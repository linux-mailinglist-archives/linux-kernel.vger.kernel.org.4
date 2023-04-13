Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373506E1324
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDMRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDMRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:06:15 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEA159F9;
        Thu, 13 Apr 2023 10:06:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fbb713301so52550377b3.11;
        Thu, 13 Apr 2023 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681405573; x=1683997573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IUYlznoUrbB0p3XNuf/X8IzvdcyNbHt0erhjLaXu/Hk=;
        b=gI1nS0dcMKhyxQ6KtTDJYis4ipnsTs5kQWuexkpPyzs57fv6rNiq6KsosRRFJmzxRL
         T7zJXKuZugM+eaDLQg4rez0PXrb85TnMv7X/EyBgyd53Qhv9tNn0DRpCXdnzPND666to
         TliD9ErmCJmbyuuhaKhXPl36Izst9mZfQ3L1/OVyP5P48RTaIvbqKEetU1KKF7UGkI5N
         nQgV5bqWjkFE3aFEmI1unrIgqiWhxHXcqv+CfVvFJJq6LWCbxvphBVzGn8IsAEywOM/W
         nDC4zjMsAe3HU/L+a/xqU1Re3hPw27GODBZYgmkvG5igMuIoeAmwIzOWWRlVIpiVWfxS
         BEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405573; x=1683997573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUYlznoUrbB0p3XNuf/X8IzvdcyNbHt0erhjLaXu/Hk=;
        b=U+atQzXZaLRD7edT6AIe64ReBP3wAuwN1x+/vUKevkGoO/DzAOa2uoFwoT6zIstEZ6
         dgxC/+pJ3TuqznMqN8zxwpGJIfia1daCfv+bOpYtHYiHTca6lBUAJvE3JGJim1d18oC0
         CQg9Ih1jGyVVDnaIITg7mVu8pHOHSWE7eQU8x77g1HAxoIQDVqKO44ey3iJUeZTMQxdt
         /Ly7BxX0E8ptS/aLbvmmCKeghlPNcu5zFeWohTRkgDgjEpwimJSTbjrAzHm1V7n0ghYM
         k7+4TGWc9bmbN5chBvIAIXFCz+VRNzzHBBW6Kys+b5Qgn0Vh+7KY3z5Y+NjlyB6OQl2q
         Pb5w==
X-Gm-Message-State: AAQBX9dKjwM2ohMS5/EORM0ZZ8nhoQQnDOqqGPiVNW6U2quIrqdCcHDI
        z44PH39XHE7otxxOrjmJBaJXvuTgxq+0JrExh2U=
X-Google-Smtp-Source: AKy350apRzhwGxN6Wa/0P0M+YPonP87XH/WnaVL4UlyEAXnh70TXuz/kGk5f3GXv1X6EI/8Eax3NBsOdG6r4vtMDCB8=
X-Received: by 2002:a81:af53:0:b0:549:14b0:84af with SMTP id
 x19-20020a81af53000000b0054914b084afmr1649461ywj.1.1681405571885; Thu, 13 Apr
 2023 10:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-8-wedsonaf@gmail.com>
 <f8575380-e710-d505-837c-bfcabe0eff00@proton.me>
In-Reply-To: <f8575380-e710-d505-837c-bfcabe0eff00@proton.me>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 13 Apr 2023 14:06:01 -0300
Message-ID: <CANeycqp_WfJxFDrxJGQ=UO2HOKtKYJCbOwGu50vZKyQSzYuiPQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] rust: introduce `ARef`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 06:19, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 11.04.23 07:45, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This is an owned reference to an object that is always ref-counted. This
> > is meant to be used in wrappers for C types that have their own ref
> > counting functions, for example, tasks, files, inodes, dentries, etc.
> >
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: No changes
> > v2 -> v3: No changes
> > v3 -> v4: No changes
> >
> >   rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 107 insertions(+)
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index a4b1e3778da7..29db59d6119a 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
> >   use alloc::boxed::Box;
> >   use core::{
> >       cell::UnsafeCell,
> > +    marker::PhantomData,
> >       mem::MaybeUninit,
> >       ops::{Deref, DerefMut},
> > +    ptr::NonNull,
> >   };
> >
> >   /// Used to transfer ownership to and from foreign (non-Rust) languages.
> > @@ -268,6 +270,111 @@ impl<T> Opaque<T> {
> >       }
> >   }
> >
> > +/// Types that are _always_ reference counted.
> > +///
> > +/// It allows such types to define their own custom ref increment and decrement functions.
> > +/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
> > +/// [`ARef<T>`].
> > +///
> > +/// This is usually implemented by wrappers to existing structures on the C side of the code. For
> > +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
> > +/// instances of a type.
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that increments to the reference count keep the object alive in memory
> > +/// at least until matching decrements are performed.
> > +///
> > +/// Implementers must also ensure that all instances are reference-counted. (Otherwise they
> > +/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
> > +/// alive.)
>
> `dec_ref` states below that it 'Frees the object when the count reaches
> zero.', this should also be stated here, since implementers should adhere
> to that when implementing `dec_ref`.

This section is for safety requirements. Freeing the object doesn't
fall into this category.

> > +pub unsafe trait AlwaysRefCounted {
> > +    /// Increments the reference count on the object.
> > +    fn inc_ref(&self);
>
>
>
> > +
> > +    /// Decrements the reference count on the object.
> > +    ///
> > +    /// Frees the object when the count reaches zero.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that there was a previous matching increment to the reference count,
> > +    /// and that the object is no longer used after its reference count is decremented (as it may
> > +    /// result in the object being freed), unless the caller owns another increment on the refcount
> > +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> > +    /// [`AlwaysRefCounted::dec_ref`] once).
> > +    unsafe fn dec_ref(obj: NonNull<Self>);
> > +}
> > +
> > +/// An owned reference to an always-reference-counted object.
> > +///
> > +/// The object's reference count is automatically decremented when an instance of [`ARef`] is
> > +/// dropped. It is also automatically incremented when a new instance is created via
> > +/// [`ARef::clone`].
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
> > +/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> > +pub struct ARef<T: AlwaysRefCounted> {
> > +    ptr: NonNull<T>,
> > +    _p: PhantomData<T>,
> > +}
> > +
> > +impl<T: AlwaysRefCounted> ARef<T> {
> > +    /// Creates a new instance of [`ARef`].
> > +    ///
> > +    /// It takes over an increment of the reference count on the underlying object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that the reference count was incremented at least once, and that they
> > +    /// are properly relinquishing one increment. That is, if there is only one increment, callers
> > +    /// must not use the underlying object anymore -- it is only safe to do so via the newly
> > +    /// created [`ARef`].
> > +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> > +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> > +        // increment on the refcount.
> > +        Self {
> > +            ptr,
> > +            _p: PhantomData,
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: AlwaysRefCounted> Clone for ARef<T> {
> > +    fn clone(&self) -> Self {
> > +        self.inc_ref();
> > +        // SAFETY: We just incremented the refcount above.
> > +        unsafe { Self::from_raw(self.ptr) }
> > +    }
> > +}
> > +
> > +impl<T: AlwaysRefCounted> Deref for ARef<T> {
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: The type invariants guarantee that the object is valid.
> > +        unsafe { self.ptr.as_ref() }
> > +    }
> > +}
> > +
> > +impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
> > +    fn from(b: &T) -> Self {
> > +        b.inc_ref();
> > +        // SAFETY: We just incremented the refcount above.
> > +        unsafe { Self::from_raw(NonNull::from(b)) }
> > +    }
> > +}
>
> This impl seems unsound to me, as we can do this:
>
>      struct MyStruct {
>          raw: Opaque<bindings::my_struct>, // This has a `refcount_t` inside.
>      }
>
>      impl MyStruct {
>          fn new() -> Self { ... }
>      }
>
>      unsafe impl AlwaysRefCounted for MyStruct { ... } // Implemented correctly.
>
>      fn evil() -> ARef<MyStruct> {
>          let my_struct = MyStruct::new();
>          ARef::from(&my_struct) // We return a pointer to the stack!
>      }
>
> similarly, this can also be done with a `Box`:
>
>      fn evil2() -> ARef<MyStruct> {
>          let my_struct = Box::new(MyStruct::new());
>          ARef::from(&*my_struct)
>          // Box is freed here, even just dropping the `ARef` will result in
>          // a UAF.
>      }

This implementation of `AlwaysRefCounted` is in violation of the
safety requirements of the trait, namely:

/// Implementers must ensure that increments to the reference count
keep the object alive in memory
/// at least until matching decrements are performed.
///
/// Implementers must also ensure that all instances are
reference-counted. (Otherwise they
/// won't be able to honour the requirement that
[`AlwaysRefCounted::inc_ref`] keep the object
/// alive.)

It boils down `MyStruct::new` in your example. It's not refcounted.

> Additionally, I think that `AlwaysRefCounted::inc_ref` should not be safe,
> as the caller must not deallocate the memory until the refcount is zero.

The existence of an `&T` is evidence that the refcount is non-zero, so
it is safe to increment it. The caller cannot free the object without
violating the safety requirements.

> Another pitfall of `ARef`: it does not deallocate the memory when the
> refcount reaches zero. People might expect that this code would not leak
> memory:
>
>      let foo = Box::try_new(Foo::new())?;
>      let foo = Box::leak(foo); // Leak the box, such that we do not
>                                // deallocate the memory too early.
>      let foo = ARef::from(foo);
>      drop(foo); // refcount is now zero, but the memory is never deallocated.

This is also in violation of the safety requirements of `AlwaysRefCounted`.

> > +
> > +impl<T: AlwaysRefCounted> Drop for ARef<T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> > +        // decrement.
> > +        unsafe { T::dec_ref(self.ptr) };
> > +    }
> > +}
> > +
> >   /// A sum type that always holds either a value of type `L` or `R`.
> >   pub enum Either<L, R> {
> >       /// Constructs an instance of [`Either`] containing a value of type `L`.
> > --
> > 2.34.1
> >
>
