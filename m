Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A996DB8D7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 06:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDHE2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 00:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDHE2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 00:28:43 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD5B76C;
        Fri,  7 Apr 2023 21:28:42 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54e40113cf3so47893067b3.12;
        Fri, 07 Apr 2023 21:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680928121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha+imKCCtXB85/iNHQU59sQzJdXxSjR3rWShEpqF89I=;
        b=RvNX+vI3R1q7p0B1Ew/XBEgeQrZn5CeHQpZoEGobJE2W1pw7xkTTClnnJohHWUig6Z
         7hGdP/HbKMrjhIufxQLJtK+MuiY9NAQKtNg6+NP/Xhf5xKphNwnd0D0jqo9vy2QAkvJp
         v/oH9JmFVhl0/SK1Nk3oUzCO9x+UOvS3gmHWvqz1Hva30RwikSXMPtX8/3WsR1JeMoaA
         1TUFyGFC9l7zoZZDMLD/00qKPSDtUaDiC0D36jsaBcyoDBEi6L1LBnKxye2HW8P2jfqY
         j1hhBsaTsrVwYsSr75Iw71R3Mvjg9tP7RKdGa88z8qI4UvX80vEC51uhlurG6cA5KBCe
         hZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680928121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ha+imKCCtXB85/iNHQU59sQzJdXxSjR3rWShEpqF89I=;
        b=f6BVlGOqcTM9F7Cnd0GLc38jqBnrCPYD9jYQr31aPIOgb546vLKp5KmhPJtWiaM9hu
         aoPUJfGzYCz+Sv3AAuy6/4O4afSjM9PI2HfefcbszJ7nGwll2MFEi6qX8PcsDtMQKSOG
         mBiQRcBfldV13Iv8fmShPTgqi0aIi9s2rHt9D0QkZy1EdQpsZOnA9rV6CRieMJ45XXfX
         GwbfteYuKuw94LGHfMs4uHGCcs8sVBiuR9J99BIfKJQDcOcdS9loRTpSY5MBd39h9L87
         sTm9a+YygFO1xJon8TF5fkskBBoxByqctJz5Dssm5OE1rAH/+HfnJhajYi+R5xoNe4FT
         D0jg==
X-Gm-Message-State: AAQBX9egqBg3kChxf0xlRLzbi93OwFjtBv6z15tluJ8SCGnp5E//NZFJ
        IUm5qDzvvboGr6T4WcY4ElXTvQrZDkVIm6EgUDQ=
X-Google-Smtp-Source: AKy350agf5XFXgVZ+6XAO3b/mlyfpJzGt0cYk53cm2oLKO8xeURquv5nafKESm1o1eu+6e6nFzKaCz2XBM5cEI1BDME=
X-Received: by 2002:a81:bd04:0:b0:545:4133:fc40 with SMTP id
 b4-20020a81bd04000000b005454133fc40mr433868ywi.9.1680928121199; Fri, 07 Apr
 2023 21:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230405175111.5974-1-wedsonaf@gmail.com> <20230405175111.5974-8-wedsonaf@gmail.com>
 <236fe27d-ce0c-88e0-6830-f4079ef23a87@protonmail.com>
In-Reply-To: <236fe27d-ce0c-88e0-6830-f4079ef23a87@protonmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sat, 8 Apr 2023 01:28:34 -0300
Message-ID: <CANeycqqTrCBR0ChZmPi14K78ev3qgHZxMsLixAiY8hWPOH8NZg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] rust: introduce `ARef`
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 at 18:59, Benno Lossin <y86-dev@protonmail.com> wrote:
>
> On 05.04.23 19:51, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This is an owned reference to an object that is always ref-counted. This
> > is meant to be used in wrappers for C types that have their own ref
> > counting functions, for example, tasks, files, inodes, dentries, etc.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: No changes
> >
> >   rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 107 insertions(+)
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index dbfae9bb97ce..b071730253c7 100644
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
> > @@ -295,6 +297,111 @@ opaque_init_funcs! {
> >       "Rust" manual_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
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
> > +pub unsafe trait AlwaysRefCounted {
> > +    /// Increments the reference count on the object.
> > +    fn inc_ref(&self);
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
>
> I think you should also mention that the pointee at `ptr` must live
> at least until this `ARef` decides to decrement the refcount.
> Otherwise I would interpret the docs as written to allow you to give
> a pointer to the stack and then free the backing storage and then
> continue to use the `ARef`.

Note the bound `T: AlwaysRefCounted`. `AlwaysRefCounted` is unsafe and
has the following requirements:

// Implementers must ensure that increments to the reference count
keep the object alive in memory
// at least until matching decrements are performed.
///
/// Implementers must also ensure that all instances are
reference-counted. (Otherwise they
/// won't be able to honour the requirement that
[`AlwaysRefCounted::inc_ref`] keep the object
/// alive.)

The latter guarantees that _all_ instances are refcounted. While the
former guarantees that you can only free an instance when the refcount
goes to zero.

The safety requirement of the function ensures that the caller is
donating an increment to `ARef`.

So it's ok to allocate from the stack. But you cannot free it
immediately without violating some promise you must abide by for
safety.

>
> --
> Cheers,
> Benno
>
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
