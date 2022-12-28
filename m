Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8676573A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiL1H1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL1H1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:27:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A0EAD;
        Tue, 27 Dec 2022 23:27:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y8so14179701wrl.13;
        Tue, 27 Dec 2022 23:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8q3GSlLPVv1xa7Tr80t1NU9RIQ4KXwQ8/ncZfjMt/lA=;
        b=prAWHAt1g/Y/quIH8eYzwWB6yf6FRq/Y/sRfXP164wNQZ/qNqlR5og8kwu24Gvb13S
         hgPfDipdtKt3F/S3yiy+y2HT8RxjRZEh2cmn5p04zwIxVF+jcHFrQLXIj+FlYCAybAAq
         5SvYZsoEJ6VayMQJRuoCbMsmnj5bL0/SZr3zMe1SnTLRu6wRNdET5WN4SsXWu0PJxd7i
         EdQp2oOdHKC/hHgsUoAMI0buGUjSi4QgcbQmmUiAV8UISFgaumcaL5OqB9v184dEPP8G
         W+dR7D8+4EZ6tWichZP6Lvs0N3GvgrONB1TfNQjjtw9FaYz1GJMKbq0WOSmX9lkYB/qb
         iKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q3GSlLPVv1xa7Tr80t1NU9RIQ4KXwQ8/ncZfjMt/lA=;
        b=itv73FReeskLxZfk1D224ppklcKwTLCpmvhoEzmChA4OstBgzZoIff1jV05v0GhOV7
         iv3L88en82yruN52RdclUZrbl5YHGJblyoaf3RClPFatZN/AU/g3jZKdPVYxACN1jOCJ
         4DKOwWIqePC5fkbXkBFerAOv/WIqWQ/0YwnMUbS7LI7pAxw7fsi8T9NwTkqb1mySHrXL
         l8NVB6s6JxNo90dup2Z1Eod82MiNFC/G99khymVm9oithggOD6tHvpXLg55HfobQDrSZ
         nnwsAbodCmpmuYDrM3SyvLhsMrS3X6O3DzX4gSwU5MluArUsUoHQMcn761+IlDxncShh
         sw1Q==
X-Gm-Message-State: AFqh2kq4PEe2zmuLTsdfwiSX79J0tBRPBoHqFXiHdh8+Z4H1kDyUZTQG
        VVv4wz2xw9FzX9r/izPYle4=
X-Google-Smtp-Source: AMrXdXtssHMMc/VWO6+2OKhdMj64KaaGDH9xt3oODE7UuNIzun8AA/+TR05Bm6zJdtC30u1MT6QTKw==
X-Received: by 2002:adf:ed51:0:b0:242:659f:9411 with SMTP id u17-20020adfed51000000b00242659f9411mr18462900wro.9.1672212423572;
        Tue, 27 Dec 2022 23:27:03 -0800 (PST)
Received: from wedsonaf-dev ([81.2.152.129])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b00288a3fd9248sm405156wrr.91.2022.12.27.23.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 23:27:03 -0800 (PST)
Date:   Wed, 28 Dec 2022 07:27:01 +0000
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Laine Taffin Altman <alexanderaltman@me.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
Message-ID: <Y6vvxWUkJD7rCbgP@wedsonaf-dev>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <B3B7C271-4C96-455E-A990-2AC7C52F703E@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3B7C271-4C96-455E-A990-2AC7C52F703E@me.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 11:09:57PM -0800, Laine Taffin Altman wrote:
> On Dec 27, 2022, at 10:03 PM, Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> > 
> > This is a basic implementation of `Arc` backed by C's `refcount_t`. It
> > allows Rust code to idiomatically allocate memory that is ref-counted.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > ---
> > rust/bindings/bindings_helper.h |   1 +
> > rust/bindings/lib.rs            |   1 +
> > rust/helpers.c                  |  19 ++++
> > rust/kernel/lib.rs              |   1 +
> > rust/kernel/sync.rs             |  10 ++
> > rust/kernel/sync/arc.rs         | 157 ++++++++++++++++++++++++++++++++
> > 6 files changed, 189 insertions(+)
> > create mode 100644 rust/kernel/sync.rs
> > create mode 100644 rust/kernel/sync/arc.rs
> > 
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index c48bc284214a..75d85bd6c592 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -7,6 +7,7 @@
> >  */
> > 
> > #include <linux/slab.h>
> > +#include <linux/refcount.h>
> > 
> > /* `bindgen` gets confused at certain things. */
> > const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > index 6c50ee62c56b..7b246454e009 100644
> > --- a/rust/bindings/lib.rs
> > +++ b/rust/bindings/lib.rs
> > @@ -41,6 +41,7 @@ mod bindings_raw {
> > #[allow(dead_code)]
> > mod bindings_helper {
> >     // Import the generated bindings for types.
> > +    use super::bindings_raw::*;
> >     include!(concat!(
> >         env!("OBJTREE"),
> >         "/rust/bindings/bindings_helpers_generated.rs"
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index b4f15eee2ffd..09a4d93f9d62 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -20,6 +20,7 @@
> > 
> > #include <linux/bug.h>
> > #include <linux/build_bug.h>
> > +#include <linux/refcount.h>
> > 
> > __noreturn void rust_helper_BUG(void)
> > {
> > @@ -27,6 +28,24 @@ __noreturn void rust_helper_BUG(void)
> > }
> > EXPORT_SYMBOL_GPL(rust_helper_BUG);
> > 
> > +refcount_t rust_helper_REFCOUNT_INIT(int n)
> > +{
> > + return (refcount_t)REFCOUNT_INIT(n);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
> > +
> > +void rust_helper_refcount_inc(refcount_t *r)
> > +{
> > + refcount_inc(r);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
> > +
> > +bool rust_helper_refcount_dec_and_test(refcount_t *r)
> > +{
> > + return refcount_dec_and_test(r);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> > +
> > /*
> >  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> >  * as the Rust `usize` type, so we can use it in contexts where Rust
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 53040fa9e897..ace064a3702a 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -31,6 +31,7 @@ mod static_assert;
> > #[doc(hidden)]
> > pub mod std_vendor;
> > pub mod str;
> > +pub mod sync;
> > pub mod types;
> > 
> > #[doc(hidden)]
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
> 
> This makes me worry, and the rest of the code confirms it.  This is not a safe abstraction:  what happens if the count saturates and then everything is dropped again?  The count “goes negative” (which is to say, use-after-free).

Are you familiar with how refcount_t is implemented? Once the counter
saturates, it stays stuck in this saturated state. There is no
user-after-free.

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
> 
> This needs to be a fallible process; maybe provide a try_clone inherent method instead of the trait impl.  It’s not worth the “convenience” to have something that can break safety (see above).  There is a reason for the original one panicking here!

Thanks for your input, but I'm afraid your lack of familiarity with
refcount_t is clouding your judgement. May I suggest that you read the
comments at the top of refcount.h?

> 
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
> > 
> 
