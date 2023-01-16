Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4B66D0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjAPVG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjAPVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:06:47 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08582387A;
        Mon, 16 Jan 2023 13:06:41 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id fd15so15705021qtb.9;
        Mon, 16 Jan 2023 13:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jS7eMVu6WDr3Lp0t8OumS7Xlv9BgrvtpIYrK/5X2zI=;
        b=So0kAhiPO2TRZYm2x0HCP/HxD2dWxZuDhpKra1GvnDHxpcXVrnG8yROB3RrjzWQ6jS
         Qetdsb51n6AzEZjV37L3WLaUTSKCjyz8dD8MwxG08ODVKbROxJQeJj2wWazZxVVR7ZQX
         FOEQIrmWYKKp33xEhOHu3+DnReAMNyGMJyvqEfoso1A7I2Buh09EQ3/wmQ+vfRWvZUQr
         vd9odAXIy3j9brqipwkpiaz/RixBc1yvMx/RO9UFeTOPx+VJcIUBmmZa+oBOTyp9KyAU
         xhT1Mr6+O5AHGic9qaeR8You9zWmg6jN3p8B9JlaClMrKbrR9X8DkkO14iPcECH6110f
         rXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jS7eMVu6WDr3Lp0t8OumS7Xlv9BgrvtpIYrK/5X2zI=;
        b=2lELNVrrIGWaFJlzqVvUp5ByzYg5As5cVgyn9jnUXw+19b/kSrX08tlOge7nv23hnj
         huyUNUcT7Yl685WznagL0HqhnaO8bWtVmlVpM9HByKMJjA9RCyDpuHt03+YycFDKgTq2
         9uh2ovIkkMTxhcWukLlIdKsdbjIIBsMcGpy20+mWhLbGPuYHkRe0Ou57W1qstJ6yXSSe
         kunXzByCBHZmAO+p47vWnfyc3XyyQARcfcAbe5hsqYnjBFeOJbMkIjQodjpdrRb26scP
         T/Cxh9U2cK66HUKF+5aPS4veufh/n+B29YwBAjmDAf0OfiGjtYNCKClwbrH6d6jQVCf8
         gNKw==
X-Gm-Message-State: AFqh2kp4dwhbMkAQ0DKCJxKd90dWqe9Q/jEsGHISYq574fwnV/aiXG46
        5+pia8ENjs1xjtYN6Tou+sc=
X-Google-Smtp-Source: AMrXdXuq4eZ+LDYkLgMBZaek8ba1KeDm1uthxK9glNPD3TBtckkN69VQISoPbxAjc6guibTGxMXbnA==
X-Received: by 2002:ac8:5a95:0:b0:3b6:2f0d:1924 with SMTP id c21-20020ac85a95000000b003b62f0d1924mr930954qtc.32.1673903201035;
        Mon, 16 Jan 2023 13:06:41 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y18-20020ac87092000000b003b2685a575asm6026887qto.21.2023.01.16.13.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 13:06:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DDAE427C0054;
        Mon, 16 Jan 2023 16:06:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 16 Jan 2023 16:06:39 -0500
X-ME-Sender: <xms:X7zFY12y8vPEfhZm3sayrR4WoPNjWkm2foDBJ8bX9lFUDWdtlSbDxQ>
    <xme:X7zFY8GbR0Zixc5LH0PfmhCmXSIFnLnzFNSWP5ZXE1y-LpEPkKnimABsqMaIxADkm
    QhGijgp6zyHyevqAg>
X-ME-Received: <xmr:X7zFY14PuS1c1s_Cf_6Ta3G5Bt8MbunZdXmDP0c7vbERbC5dWjhxxjvCpF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepiefhhfetkeetvedugeehveduteduudetueeileeuvedvieevgfdutdeg
    ffeiffefnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhpthhrrdgrshenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:X7zFYy1rJa8hh2qV-85UrmSRTLc0bE1PZK3PkmLQHJ-KJFpJja3w9A>
    <xmx:X7zFY4HU-EB34qNd1owCGZu3jmnOwOg5dd3XsC5oTDZ9iLZKexigTQ>
    <xmx:X7zFYz_9sH5CVzqYKoz5cWQ8i4YDq9xB-ppRiaqxREJNWPggD2Lp_g>
    <xmx:X7zFYzCxz1Cf425laqAndZaWWgyplDeDV5K2VIa1vP6-haecD25DlA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 16:06:38 -0500 (EST)
Date:   Mon, 16 Jan 2023 13:06:23 -0800
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
Message-ID: <Y8W8TwYZyWGoHkqr@boqun-archlinux>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <Y73JF1rvF/No/JRi@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73JF1rvF/No/JRi@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:22:47PM -0800, Boqun Feng wrote:
> Hi,
> 
> On Wed, Dec 28, 2022 at 06:03:40AM +0000, Wedson Almeida Filho wrote:
> > This is a basic implementation of `Arc` backed by C's `refcount_t`. It
> > allows Rust code to idiomatically allocate memory that is ref-counted.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

For the whole series:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 
> The whole series look good to me. I just want to bring up a few things
> before I give an Acked-by as atomics subsystem reviewer.
> 
> First, I'd really appreciate it that Will, Peter or Mark can take a look
> at the series and see if they are happy or not ;-)
> 
> And from the atomics subsystem POV, I think it's better that there are a
> few self/unit tests along with the series, because the implementation of
> `Arc` clearly depends on refcount_t APIs and has some requirement on
> these APIs, which can be better described by tests. Although the
> semantics of refcount_t APIs is unlikely to change, but the future is
> always difficult to predict, plus there would always be new
> architecutres implementing these APIs.
> 
> Anyway, I don't think the request for tests blocks the series, just
> want to have more tools for kernel C developers to collaborate with Rust
> developers. And put my Rust hat on, Will, Peter and Mark, please tell me
> whether we are doing OK or how we can improve to give you some level of
> understanding for the code ;-) Thanks!
> 
> Regards,
> Boqun
> 
> > ---
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/bindings/lib.rs            |   1 +
> >  rust/helpers.c                  |  19 ++++
> >  rust/kernel/lib.rs              |   1 +
> >  rust/kernel/sync.rs             |  10 ++
> >  rust/kernel/sync/arc.rs         | 157 ++++++++++++++++++++++++++++++++
> >  6 files changed, 189 insertions(+)
> >  create mode 100644 rust/kernel/sync.rs
> >  create mode 100644 rust/kernel/sync/arc.rs
> > 
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index c48bc284214a..75d85bd6c592 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -7,6 +7,7 @@
> >   */
> >  
> >  #include <linux/slab.h>
> > +#include <linux/refcount.h>
> >  
> >  /* `bindgen` gets confused at certain things. */
> >  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > index 6c50ee62c56b..7b246454e009 100644
> > --- a/rust/bindings/lib.rs
> > +++ b/rust/bindings/lib.rs
> > @@ -41,6 +41,7 @@ mod bindings_raw {
> >  #[allow(dead_code)]
> >  mod bindings_helper {
> >      // Import the generated bindings for types.
> > +    use super::bindings_raw::*;
> >      include!(concat!(
> >          env!("OBJTREE"),
> >          "/rust/bindings/bindings_helpers_generated.rs"
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index b4f15eee2ffd..09a4d93f9d62 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -20,6 +20,7 @@
> >  
> >  #include <linux/bug.h>
> >  #include <linux/build_bug.h>
> > +#include <linux/refcount.h>
> >  
> >  __noreturn void rust_helper_BUG(void)
> >  {
> > @@ -27,6 +28,24 @@ __noreturn void rust_helper_BUG(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_BUG);
> >  
> > +refcount_t rust_helper_REFCOUNT_INIT(int n)
> > +{
> > +	return (refcount_t)REFCOUNT_INIT(n);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
> > +
> > +void rust_helper_refcount_inc(refcount_t *r)
> > +{
> > +	refcount_inc(r);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
> > +
> > +bool rust_helper_refcount_dec_and_test(refcount_t *r)
> > +{
> > +	return refcount_dec_and_test(r);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> > +
> >  /*
> >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 53040fa9e897..ace064a3702a 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -31,6 +31,7 @@ mod static_assert;
> >  #[doc(hidden)]
> >  pub mod std_vendor;
> >  pub mod str;
> > +pub mod sync;
> >  pub mod types;
> >  
> >  #[doc(hidden)]
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > new file mode 100644
> > index 000000000000..39b379dd548f
> > --- /dev/null
> > +++ b/rust/kernel/sync.rs
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Synchronisation primitives.
> > +//!
> > +//! This module contains the kernel APIs related to synchronisation that have been ported or
> > +//! wrapped for usage by Rust code in the kernel.
> > +
> > +mod arc;
> > +
> > +pub use arc::Arc;
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > new file mode 100644
> > index 000000000000..22290eb5ab9b
> > --- /dev/null
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -0,0 +1,157 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! A reference-counted pointer.
> > +//!
> > +//! This module implements a way for users to create reference-counted objects and pointers to
> > +//! them. Such a pointer automatically increments and decrements the count, and drops the
> > +//! underlying object when it reaches zero. It is also safe to use concurrently from multiple
> > +//! threads.
> > +//!
> > +//! It is different from the standard library's [`Arc`] in a few ways:
> > +//! 1. It is backed by the kernel's `refcount_t` type.
> > +//! 2. It does not support weak references, which allows it to be half the size.
> > +//! 3. It saturates the reference count instead of aborting when it goes over a threshold.
> > +//! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
> > +//!
> > +//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
> > +
> > +use crate::{bindings, error::Result, types::Opaque};
> > +use alloc::boxed::Box;
> > +use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> > +
> > +/// A reference-counted pointer to an instance of `T`.
> > +///
> > +/// The reference count is incremented when new instances of [`Arc`] are created, and decremented
> > +/// when they are dropped. When the count reaches zero, the underlying `T` is also dropped.
> > +///
> > +/// # Invariants
> > +///
> > +/// The reference count on an instance of [`Arc`] is always non-zero.
> > +/// The object pointed to by [`Arc`] is always pinned.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::sync::Arc;
> > +///
> > +/// struct Example {
> > +///     a: u32,
> > +///     b: u32,
> > +/// }
> > +///
> > +/// // Create a ref-counted instance of `Example`.
> > +/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> > +///
> > +/// // Get a new pointer to `obj` and increment the refcount.
> > +/// let cloned = obj.clone();
> > +///
> > +/// // Assert that both `obj` and `cloned` point to the same underlying object.
> > +/// assert!(core::ptr::eq(&*obj, &*cloned));
> > +///
> > +/// // Destroy `obj` and decrement its refcount.
> > +/// drop(obj);
> > +///
> > +/// // Check that the values are still accessible through `cloned`.
> > +/// assert_eq!(cloned.a, 10);
> > +/// assert_eq!(cloned.b, 20);
> > +///
> > +/// // The refcount drops to zero when `cloned` goes out of scope, and the memory is freed.
> > +/// ```
> > +pub struct Arc<T: ?Sized> {
> > +    ptr: NonNull<ArcInner<T>>,
> > +    _p: PhantomData<ArcInner<T>>,
> > +}
> > +
> > +#[repr(C)]
> > +struct ArcInner<T: ?Sized> {
> > +    refcount: Opaque<bindings::refcount_t>,
> > +    data: T,
> > +}
> > +
> > +// SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
> > +// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> > +// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
> > +// example, when the reference count reaches zero and `T` is dropped.
> > +unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
> > +
> > +// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
> > +// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&Arc<T>`
> > +// into an `Arc<T>`, which may lead to `T` being accessed by the same reasoning as above.
> > +unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
> > +
> > +impl<T> Arc<T> {
> > +    /// Constructs a new reference counted instance of `T`.
> > +    pub fn try_new(contents: T) -> Result<Self> {
> > +        // INVARIANT: The refcount is initialised to a non-zero value.
> > +        let value = ArcInner {
> > +            // SAFETY: There are no safety requirements for this FFI call.
> > +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> > +            data: contents,
> > +        };
> > +
> > +        let inner = Box::try_new(value)?;
> > +
> > +        // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
> > +        // `Arc` object.
> > +        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> Arc<T> {
> > +    /// Constructs a new [`Arc`] from an existing [`ArcInner`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure that `inner` points to a valid location and has a non-zero reference
> > +    /// count, one of which will be owned by the new [`Arc`] instance.
> > +    unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
> > +        // INVARIANT: By the safety requirements, the invariants hold.
> > +        Arc {
> > +            ptr: inner,
> > +            _p: PhantomData,
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> Deref for Arc<T> {
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> > +        // safe to dereference it.
> > +        unsafe { &self.ptr.as_ref().data }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> Clone for Arc<T> {
> > +    fn clone(&self) -> Self {
> > +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
> > +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> > +        // safe to increment the refcount.
> > +        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
> > +
> > +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
> > +        unsafe { Self::from_inner(self.ptr) }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> Drop for Arc<T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
> > +        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
> > +        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
> > +        // freed/invalid memory as long as it is never dereferenced.
> > +        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
> > +
> > +        // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
> > +        // this instance is being dropped, so the broken invariant is not observable.
> > +        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
> > +        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
> > +        if is_zero {
> > +            // The count reached zero, we must free the memory.
> > +            //
> > +            // SAFETY: The pointer was initialised from the result of `Box::leak`.
> > +            unsafe { Box::from_raw(self.ptr.as_ptr()) };
> > +        }
> > +    }
> > +}
> > -- 
> > 2.34.1
> > 
