Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5F65D7F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbjADQJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbjADQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:08:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6243C380;
        Wed,  4 Jan 2023 08:08:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qk9so83556127ejc.3;
        Wed, 04 Jan 2023 08:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S78DmMftxVSawcOYgDZLsYS9BKbUVx/H9YpxdwVwKvY=;
        b=PfSH0e+A+qifLqlDaJDU9D8DmWHiqnjEqP+S9nwIMMKYc/uE9/JhCAA7N7v7mIeu+S
         9s5E/BKFEZY2xYQ/m6Ns94ro6m+Jnhb5g1aCPKNEXKOMRLpFtIy92z0PMJNpvGntU8do
         BBU2gFpS4Ly1XD7OgXrGd7oNgCnQHHuNnRroJ3osy4SK4YDOmCQUQqhjSN477DRcE5MV
         8ehkBxB0/j6XlJGRZz0uy+p0WzC5cotqj1sWaI4ScVtGImMgN+jT1RnPOwo5OAG1gu2x
         Xwh+P+5s/NQVewBd5btkb521/DmMf5cMxZshMV2/r+UcL7qzc3coY+drmtEa7Gwd4KZl
         piRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S78DmMftxVSawcOYgDZLsYS9BKbUVx/H9YpxdwVwKvY=;
        b=E076gpYUSsxbRSyG+QqV0EH8aTCFNa8cRj+qT2gZuZ9teYqS73bosRFW2VFt/fBK7T
         LNmLmtakl22BR1jCAKIhA3sYY/uMGKCeZj/xyP2OC5KOomu3TX14v63DojEbW72PEPec
         Yx8qYl2n3PHAeuyVYcrd44Zv5Sfc2Br497G/0cLxJfd2JUVpx0Y9viuC8X56eDPhu6fc
         tkZfx8dlXrCdOslpT9Zk+HTKTb8afhMysHTqwLE7yzq8ZriM4LldA73csA3G+UGy5BVk
         a8hht7DRKGUPJg9daFJMA+SIy2Kd11aUkNN6JVKhHXX4sIvChQPb+qChE+iySgUsxU/A
         GYRA==
X-Gm-Message-State: AFqh2kodv2AaxlKOgDDZbmGJHBTJdWzy6w7BUfw5KDs/e0ylgx/DfBD7
        LeS0KDVt7eX7AJPQmBFIYjM=
X-Google-Smtp-Source: AMrXdXuuNDKP5T1gSkbOgSfyEX5u6Njm9mbxhjZmhaRfXt3hogQQLCpxEkL/MxW5YCrrQZ16979k0w==
X-Received: by 2002:a17:907:c70c:b0:7c0:a247:2f3c with SMTP id ty12-20020a170907c70c00b007c0a2472f3cmr43485561ejc.1.1672848523824;
        Wed, 04 Jan 2023 08:08:43 -0800 (PST)
Received: from localhost (host-82-60-200-213.retail.telecomitalia.it. [82.60.200.213])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007bd1ef2cccasm15247811ejh.48.2023.01.04.08.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 08:08:43 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Jan 2023 17:08:41 +0100
Message-Id: <CPJJB5S18P5H.1JVMPW2JI8KRJ@vincent>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>, "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20221228060346.352362-1-wedsonaf@gmail.com>
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

On Wed Dec 28, 2022 at 7:03 AM CET, Wedson Almeida Filho wrote:

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

> This is a basic implementation of `Arc` backed by C's `refcount_t`. It
> allows Rust code to idiomatically allocate memory that is ref-counted.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
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
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index c48bc284214a..75d85bd6c592 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/slab.h>
> +#include <linux/refcount.h>
> =20
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
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
> =20
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/refcount.h>
> =20
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -27,6 +28,24 @@ __noreturn void rust_helper_BUG(void)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_BUG);
> =20
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
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
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
> =20
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
> +//! This module contains the kernel APIs related to synchronisation that=
 have been ported or
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
> +//! This module implements a way for users to create reference-counted o=
bjects and pointers to
> +//! them. Such a pointer automatically increments and decrements the cou=
nt, and drops the
> +//! underlying object when it reaches zero. It is also safe to use concu=
rrently from multiple
> +//! threads.
> +//!
> +//! It is different from the standard library's [`Arc`] in a few ways:
> +//! 1. It is backed by the kernel's `refcount_t` type.
> +//! 2. It does not support weak references, which allows it to be half t=
he size.
> +//! 3. It saturates the reference count instead of aborting when it goes=
 over a threshold.
> +//! 4. It does not provide a `get_mut` method, so the ref counted object=
 is pinned.
> +//!
> +//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
> +
> +use crate::{bindings, error::Result, types::Opaque};
> +use alloc::boxed::Box;
> +use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> +
> +/// A reference-counted pointer to an instance of `T`.
> +///
> +/// The reference count is incremented when new instances of [`Arc`] are=
 created, and decremented
> +/// when they are dropped. When the count reaches zero, the underlying `=
T` is also dropped.
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
> +/// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
> +///
> +/// // Get a new pointer to `obj` and increment the refcount.
> +/// let cloned =3D obj.clone();
> +///
> +/// // Assert that both `obj` and `cloned` point to the same underlying =
object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +///
> +/// // Destroy `obj` and decrement its refcount.
> +/// drop(obj);
> +///
> +/// // Check that the values are still accessible through `cloned`.
> +/// assert_eq!(cloned.a, 10);
> +/// assert_eq!(cloned.b, 20);
> +///
> +/// // The refcount drops to zero when `cloned` goes out of scope, and t=
he memory is freed.
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
> +// SAFETY: It is safe to send `Arc<T>` to another thread when the underl=
ying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is `Sync=
`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `Arc<T>` may ultimate=
ly access `T` directly, for
> +// example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
> +
> +// SAFETY: It is safe to send `&Arc<T>` to another thread when the under=
lying `T` is `Sync` for the
> +// same reason as above. `T` needs to be `Send` as well because a thread=
 can clone an `&Arc<T>`
> +// into an `Arc<T>`, which may lead to `T` being accessed by the same re=
asoning as above.
> +unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
> +
> +impl<T> Arc<T> {
> +    /// Constructs a new reference counted instance of `T`.
> +    pub fn try_new(contents: T) -> Result<Self> {
> +        // INVARIANT: The refcount is initialised to a non-zero value.
> +        let value =3D ArcInner {
> +            // SAFETY: There are no safety requirements for this FFI cal=
l.
> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) })=
,
> +            data: contents,
> +        };
> +
> +        let inner =3D Box::try_new(value)?;
> +
> +        // SAFETY: We just created `inner` with a reference count of 1, =
which is owned by the new
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
> +    /// The caller must ensure that `inner` points to a valid location a=
nd has a non-zero reference
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
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
> +        // safe to dereference it.
> +        unsafe { &self.ptr.as_ref().data }
> +    }
> +}
> +
> +impl<T: ?Sized> Clone for Arc<T> {
> +    fn clone(&self) -> Self {
> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it can=
not overflow to zero.
> +        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
> +        // safe to increment the refcount.
> +        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()=
) };
> +
> +        // SAFETY: We just incremented the refcount. This increment is n=
ow owned by the new `Arc`.
> +        unsafe { Self::from_inner(self.ptr) }
> +    }
> +}
> +
> +impl<T: ?Sized> Drop for Arc<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object. We cannot
> +        // touch `refcount` after it's decremented to a non-zero value b=
ecause another thread/CPU
> +        // may concurrently decrement it to zero and free it. It is ok t=
o have a raw pointer to
> +        // freed/invalid memory as long as it is never dereferenced.
> +        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> +
> +        // INVARIANT: If the refcount reaches zero, there are no other i=
nstances of `Arc`, and
> +        // this instance is being dropped, so the broken invariant is no=
t observable.
> +        // SAFETY: Also by the type invariant, we are allowed to decreme=
nt the refcount.
> +        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refcoun=
t) };
> +        if is_zero {
> +            // The count reached zero, we must free the memory.
> +            //
> +            // SAFETY: The pointer was initialised from the result of `B=
ox::leak`.
> +            unsafe { Box::from_raw(self.ptr.as_ptr()) };
> +        }
> +    }
> +}
> --=20
> 2.34.1

