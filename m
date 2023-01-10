Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB095664D36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjAJUYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjAJUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:24:15 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F98165B9;
        Tue, 10 Jan 2023 12:24:12 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id x7so1888570qtv.13;
        Tue, 10 Jan 2023 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M69p1Ux6PQEcmhP/425X+d/e/jKr0c7t4hS9ypXhsH4=;
        b=CXiySrMYrjYEJM13I/qWHhMM+PP6e5rssTbauVZAsJgPWietIXVWNg9/Lxw1JylML3
         MFunpnDP2FXKqgJlec7kwDweAUXiA0DizMJgP/0K/zzmdHQrllP2+5jjTgrLixImTewi
         vaBTqSJBqkXGuSdsUHCppKtPxvSQHCCL2y8RGZR9ZqYcKbmOrRe2oR1GprgKs/HZDVHr
         iZ3h+F/umygydzjj8vULQu4IW5p3ZB9yuC5spkCzGKiCcBWN0/CLaF5SppJrrkbTciLB
         ThyZ9/Sj4ruQOzLVuFN9vPSk5g16tgA/yX26tu8dN7fg5rdVkkdjim0+Jr1wqmUTwkEZ
         SFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M69p1Ux6PQEcmhP/425X+d/e/jKr0c7t4hS9ypXhsH4=;
        b=qiplUgP/JE7IxzoGzcAG9S872LlCSilzBWboSb61utpo5GcUxl8IrM88uK/IA5hkdO
         0a57lDgxxL607RNo7mV4OKGQqDo1kV3kPlyLmLczqE+V7hzvKE357Z7Eobr7sxh/48+l
         LSLDwLKPMW5qTYKtv8a6hju3GYSYNM9PlhwfQkUuGTeCneOGRpVhet2M/bu3ntzoIc3N
         xJJNUOYoCJ0dcGRt4bZy/UbINNCDh2QuyoIy5XwFSlUQ30kt+WSRDwu7xSQbeWmwPe/d
         /62ni5LY/bWZb4BfL7OZ7QbYMQzbK2+ZbvBtCLtOxjyuEctNU+6osKfurqonny6sds2f
         XWnw==
X-Gm-Message-State: AFqh2kqjtWnACm7jfusSNBls8dcIfYUNlIQZm+awP8nmVeiUsCBZUWDs
        x7JnE+kxH1SDp8UJbF71lRILwOghhxQ=
X-Google-Smtp-Source: AMrXdXscNKcuE5BSmyy0tyXAgtP5xvdTOxRladWPrbyUxx1iISO08RkljYEBIKAVg/JzxaM8SWb5rg==
X-Received: by 2002:a05:622a:2510:b0:3a8:1677:bc39 with SMTP id cm16-20020a05622a251000b003a81677bc39mr59193897qtb.52.1673382251303;
        Tue, 10 Jan 2023 12:24:11 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b20-20020ac85414000000b003ac83b7f5d4sm4400661qtq.29.2023.01.10.12.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 12:24:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A1B1127C0054;
        Tue, 10 Jan 2023 15:24:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 10 Jan 2023 15:24:07 -0500
X-ME-Sender: <xms:Zsm9Y8ltSyPVvxVGQSJReRJLq4P2iNAZE_ui7A8CWvLCWVWv4TGsdA>
    <xme:Zsm9Y71wApc2zAsF4QYpeJ1U2ghChX4Kvd8jFLVHEk4Vo8I_FPGfYj3HExbG1meM4
    E5Lbfqdh3LMosG_zw>
X-ME-Received: <xmr:Zsm9Y6om8EiLD8_CCWaefGZFpkTTeC9eKTos2sRFUIE2OhIzSbQA3_4pnJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepiefhhfetkeetvedugeehveduteduudetueeileeuvedvieevgfdutdegffei
    ffefnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhpthhrrdgrshenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vg
X-ME-Proxy: <xmx:Zsm9Y4memCYFGDVBa7GvNUUm7dQYpXtEGJZ-m5ng1vIsS1x8_bqXOQ>
    <xmx:Zsm9Y61a-r1Uus1fDIK4zcwMy4g1V-r0bsuJGYg4jdt0zqxJSHhj_w>
    <xmx:Zsm9Y_ulcu_gFfPNrBMtVGtGh0j_554jRROBcoTV0zVRRxJIk9DyUA>
    <xmx:Z8m9Y4xzJlEVreGrSPKFlavJICQelqb5_uFOQ7A4ZQKTOuqERnNQmQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jan 2023 15:24:06 -0500 (EST)
Date:   Tue, 10 Jan 2023 12:22:47 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
Message-ID: <Y73JF1rvF/No/JRi@boqun-archlinux>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228060346.352362-1-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 28, 2022 at 06:03:40AM +0000, Wedson Almeida Filho wrote:
> This is a basic implementation of `Arc` backed by C's `refcount_t`. It
> allows Rust code to idiomatically allocate memory that is ref-counted.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

The whole series look good to me. I just want to bring up a few things
before I give an Acked-by as atomics subsystem reviewer.

First, I'd really appreciate it that Will, Peter or Mark can take a look
at the series and see if they are happy or not ;-)

And from the atomics subsystem POV, I think it's better that there are a
few self/unit tests along with the series, because the implementation of
`Arc` clearly depends on refcount_t APIs and has some requirement on
these APIs, which can be better described by tests. Although the
semantics of refcount_t APIs is unlikely to change, but the future is
always difficult to predict, plus there would always be new
architecutres implementing these APIs.

Anyway, I don't think the request for tests blocks the series, just
want to have more tools for kernel C developers to collaborate with Rust
developers. And put my Rust hat on, Will, Peter and Mark, please tell me
whether we are doing OK or how we can improve to give you some level of
understanding for the code ;-) Thanks!

Regards,
Boqun

> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/bindings/lib.rs            |   1 +
>  rust/helpers.c                  |  19 ++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/sync.rs             |  10 ++
>  rust/kernel/sync/arc.rs         | 157 ++++++++++++++++++++++++++++++++
>  6 files changed, 189 insertions(+)
>  create mode 100644 rust/kernel/sync.rs
>  create mode 100644 rust/kernel/sync/arc.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index c48bc284214a..75d85bd6c592 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/slab.h>
> +#include <linux/refcount.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 6c50ee62c56b..7b246454e009 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -41,6 +41,7 @@ mod bindings_raw {
>  #[allow(dead_code)]
>  mod bindings_helper {
>      // Import the generated bindings for types.
> +    use super::bindings_raw::*;
>      include!(concat!(
>          env!("OBJTREE"),
>          "/rust/bindings/bindings_helpers_generated.rs"
> diff --git a/rust/helpers.c b/rust/helpers.c
> index b4f15eee2ffd..09a4d93f9d62 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/refcount.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -27,6 +28,24 @@ __noreturn void rust_helper_BUG(void)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_BUG);
>  
> +refcount_t rust_helper_REFCOUNT_INIT(int n)
> +{
> +	return (refcount_t)REFCOUNT_INIT(n);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
> +
> +void rust_helper_refcount_inc(refcount_t *r)
> +{
> +	refcount_inc(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
> +
> +bool rust_helper_refcount_dec_and_test(refcount_t *r)
> +{
> +	return refcount_dec_and_test(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 53040fa9e897..ace064a3702a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -31,6 +31,7 @@ mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
>  pub mod str;
> +pub mod sync;
>  pub mod types;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> new file mode 100644
> index 000000000000..39b379dd548f
> --- /dev/null
> +++ b/rust/kernel/sync.rs
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Synchronisation primitives.
> +//!
> +//! This module contains the kernel APIs related to synchronisation that have been ported or
> +//! wrapped for usage by Rust code in the kernel.
> +
> +mod arc;
> +
> +pub use arc::Arc;
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> new file mode 100644
> index 000000000000..22290eb5ab9b
> --- /dev/null
> +++ b/rust/kernel/sync/arc.rs
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A reference-counted pointer.
> +//!
> +//! This module implements a way for users to create reference-counted objects and pointers to
> +//! them. Such a pointer automatically increments and decrements the count, and drops the
> +//! underlying object when it reaches zero. It is also safe to use concurrently from multiple
> +//! threads.
> +//!
> +//! It is different from the standard library's [`Arc`] in a few ways:
> +//! 1. It is backed by the kernel's `refcount_t` type.
> +//! 2. It does not support weak references, which allows it to be half the size.
> +//! 3. It saturates the reference count instead of aborting when it goes over a threshold.
> +//! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
> +//!
> +//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
> +
> +use crate::{bindings, error::Result, types::Opaque};
> +use alloc::boxed::Box;
> +use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> +
> +/// A reference-counted pointer to an instance of `T`.
> +///
> +/// The reference count is incremented when new instances of [`Arc`] are created, and decremented
> +/// when they are dropped. When the count reaches zero, the underlying `T` is also dropped.
> +///
> +/// # Invariants
> +///
> +/// The reference count on an instance of [`Arc`] is always non-zero.
> +/// The object pointed to by [`Arc`] is always pinned.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// // Create a ref-counted instance of `Example`.
> +/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> +///
> +/// // Get a new pointer to `obj` and increment the refcount.
> +/// let cloned = obj.clone();
> +///
> +/// // Assert that both `obj` and `cloned` point to the same underlying object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +///
> +/// // Destroy `obj` and decrement its refcount.
> +/// drop(obj);
> +///
> +/// // Check that the values are still accessible through `cloned`.
> +/// assert_eq!(cloned.a, 10);
> +/// assert_eq!(cloned.b, 20);
> +///
> +/// // The refcount drops to zero when `cloned` goes out of scope, and the memory is freed.
> +/// ```
> +pub struct Arc<T: ?Sized> {
> +    ptr: NonNull<ArcInner<T>>,
> +    _p: PhantomData<ArcInner<T>>,
> +}
> +
> +#[repr(C)]
> +struct ArcInner<T: ?Sized> {
> +    refcount: Opaque<bindings::refcount_t>,
> +    data: T,
> +}
> +
> +// SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
> +// example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
> +
> +// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
> +// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&Arc<T>`
> +// into an `Arc<T>`, which may lead to `T` being accessed by the same reasoning as above.
> +unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
> +
> +impl<T> Arc<T> {
> +    /// Constructs a new reference counted instance of `T`.
> +    pub fn try_new(contents: T) -> Result<Self> {
> +        // INVARIANT: The refcount is initialised to a non-zero value.
> +        let value = ArcInner {
> +            // SAFETY: There are no safety requirements for this FFI call.
> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +            data: contents,
> +        };
> +
> +        let inner = Box::try_new(value)?;
> +
> +        // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
> +        // `Arc` object.
> +        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
> +    }
> +}
> +
> +impl<T: ?Sized> Arc<T> {
> +    /// Constructs a new [`Arc`] from an existing [`ArcInner`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `inner` points to a valid location and has a non-zero reference
> +    /// count, one of which will be owned by the new [`Arc`] instance.
> +    unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
> +        // INVARIANT: By the safety requirements, the invariants hold.
> +        Arc {
> +            ptr: inner,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for Arc<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> +        // safe to dereference it.
> +        unsafe { &self.ptr.as_ref().data }
> +    }
> +}
> +
> +impl<T: ?Sized> Clone for Arc<T> {
> +    fn clone(&self) -> Self {
> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> +        // safe to increment the refcount.
> +        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
> +
> +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
> +        unsafe { Self::from_inner(self.ptr) }
> +    }
> +}
> +
> +impl<T: ?Sized> Drop for Arc<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
> +        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
> +        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
> +        // freed/invalid memory as long as it is never dereferenced.
> +        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
> +
> +        // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
> +        // this instance is being dropped, so the broken invariant is not observable.
> +        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
> +        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
> +        if is_zero {
> +            // The count reached zero, we must free the memory.
> +            //
> +            // SAFETY: The pointer was initialised from the result of `Box::leak`.
> +            unsafe { Box::from_raw(self.ptr.as_ptr()) };
> +        }
> +    }
> +}
> -- 
> 2.34.1
> 
