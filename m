Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528B965D928
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjADQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbjADQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:21:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE80C756;
        Wed,  4 Jan 2023 08:21:46 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id x22so83788011ejs.11;
        Wed, 04 Jan 2023 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd7uI+y3iZOOxlDVGlCuUm5GdVePmb0oHf0kQszZU3s=;
        b=p4/Hw0GebhTz+KiZ7cZEuzvI4dKCPRVkt4PgwhnLixzdUx0KmhMzqM7X7eihfNgUyI
         ctrjVdoIJ43l6UUQyYt/1nS2lJjmBTd2NvOMEZyKyd5zP/LZw9bkARyonJHqds5bWOGG
         qFfCsUqHy0YjqkgqXDhf4KGDXy1QVhspVJpMw2vm0Y/RBsj+Ktw649LGAcCP6dgVRqYQ
         q7rtRrvxWgD+n0B4kYptKWS9ALWWtESJlXrmHRPGsdYO+CiZrsjlhMZGcFWSqOqWI33N
         Gse+xAkIIPUR5iRe41RowNtCFXEAbDcHgNVXfGKMKrndNFjGOQ4mOcZRxPuZ9/1zeRbj
         I4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pd7uI+y3iZOOxlDVGlCuUm5GdVePmb0oHf0kQszZU3s=;
        b=bVk/qU1AeXjTwrbz2Cmpjl5T9xpVpfmNxjJOUuj9rK6qZrTSlr/HqKhX4wdW7ZpoJD
         WmBeIxqyCUXYPoV5Itgxleokb8RycWIfWK+UxTB++kzuvu7z0CL/t67I3k/WNE9vpMa0
         yIUjQtyf1yhX1x0+vUTFxmCSSHx0M9RwnzzmUu7sSMB3MdRmF+pfw3cKP6MDOQGvRAOL
         ilCHzB+4bZ39yBjAQOhehImnaxav7b6wAeqyzv+YEKIbNdo0sq6Wa/mBeYEUlHKHtjRo
         hriWMdpop9rYQ0VMSOPSJ25qkdBr/26lckIrgW3FnRMXb+bEBQnFFkdD8y/+KORVJulX
         5oqw==
X-Gm-Message-State: AFqh2kpv2qfUL9eB22YhAlDKGNof0FDzlt5hRgA/vchTB5HsYBHQj8gT
        atpWte6pQeUP40NFHfPZfMg=
X-Google-Smtp-Source: AMrXdXt+zF5a6PsJ8NVZJnOmRkvoWlyc0lS25rNARGSItkV3QzXErxrRPHxoRH+31QLO+rPdtLp4IQ==
X-Received: by 2002:a17:906:eca6:b0:7c1:524d:2bec with SMTP id qh6-20020a170906eca600b007c1524d2becmr41770352ejb.39.1672849305027;
        Wed, 04 Jan 2023 08:21:45 -0800 (PST)
Received: from localhost (host-82-60-200-213.retail.telecomitalia.it. [82.60.200.213])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906309700b00809e33ba33dsm15709158ejv.19.2023.01.04.08.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 08:21:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Jan 2023 17:21:42 +0100
Message-Id: <CPJJL4KNB0PB.16IQTD9KFLTQS@vincent>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] rust: sync: introduce `UniqueArc`
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.8.2
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-6-wedsonaf@gmail.com>
In-Reply-To: <20221228060346.352362-6-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

On Wed Dec 28, 2022 at 7:03 AM CET, Wedson Almeida Filho wrote:
> Since `Arc<T>` does not allow mutating `T` directly (i.e., without inner
> mutability), it is currently not possible to do some initialisation of
> `T` post construction but before being shared.
>
> `UniqueArc<T>` addresses this problem essentially being an `Arc<T>` that
> has a refcount of 1 and is therefore writable. Once initialisation is
> completed, it can be transitioned (without failure paths) into an
> `Arc<T>`.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/sync.rs     |   2 +-
>  rust/kernel/sync/arc.rs | 152 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 151 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 5de03ea83ea1..33da23e3076d 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -7,4 +7,4 @@
> =20
>  mod arc;
> =20
> -pub use arc::{Arc, ArcBorrow};
> +pub use arc::{Arc, ArcBorrow, UniqueArc};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 84f31c85a513..832bafc74a90 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -19,8 +19,9 @@ use crate::{bindings, error::Result, types::Opaque};
>  use alloc::boxed::Box;
>  use core::{
>      marker::{PhantomData, Unsize},
> -    mem::ManuallyDrop,
> -    ops::Deref,
> +    mem::{ManuallyDrop, MaybeUninit},
> +    ops::{Deref, DerefMut},
> +    pin::Pin,
>      ptr::NonNull,
>  };
> =20
> @@ -222,6 +223,19 @@ impl<T: ?Sized> Drop for Arc<T> {
>      }
>  }
> =20
> +impl<T: ?Sized> From<UniqueArc<T>> for Arc<T> {
> +    fn from(item: UniqueArc<T>) -> Self {
> +        item.inner
> +    }
> +}
> +
> +impl<T: ?Sized> From<Pin<UniqueArc<T>>> for Arc<T> {
> +    fn from(item: Pin<UniqueArc<T>>) -> Self {
> +        // SAFETY: The type invariants of `Arc` guarantee that the data =
is pinned.
> +        unsafe { Pin::into_inner_unchecked(item).inner }
> +    }
> +}
> +
>  /// A borrowed reference to an [`Arc`] instance.
>  ///
>  /// For cases when one doesn't ever need to increment the refcount on th=
e allocation, it is simpler
> @@ -328,3 +342,137 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
>          unsafe { &self.inner.as_ref().data }
>      }
>  }
> +
> +/// A refcounted object that is known to have a refcount of 1.
> +///
> +/// It is mutable and can be converted to an [`Arc`] so that it can be s=
hared.
> +///
> +/// # Invariants
> +///
> +/// `inner` always has a reference count of 1.
> +///
> +/// # Examples
> +///
> +/// In the following example, we make changes to the inner object before=
 turning it into an
> +/// `Arc<Test>` object (after which point, it cannot be mutated directly=
). Note that `x.into()`
> +/// cannot fail.
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let mut x =3D UniqueArc::try_new(Example { a: 10, b: 20 })?;
> +///     x.a +=3D 1;
> +///     x.b +=3D 1;
> +///     Ok(x.into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +///
> +/// In the following example we first allocate memory for a ref-counted =
`Example` but we don't
> +/// initialise it on allocation. We do initialise it later with a call t=
o [`UniqueArc::write`],
> +/// followed by a conversion to `Arc<Example>`. This is particularly use=
ful when allocation happens
> +/// in one context (e.g., sleepable) and initialisation in another (e.g.=
, atomic):
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let x =3D UniqueArc::try_new_uninit()?;
> +///     Ok(x.write(Example { a: 10, b: 20 }).into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +///
> +/// In the last example below, the caller gets a pinned instance of `Exa=
mple` while converting to
> +/// `Arc<Example>`; this is useful in scenarios where one needs a pinned=
 reference during
> +/// initialisation, for example, when initialising fields that are wrapp=
ed in locks.
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let mut pinned =3D Pin::from(UniqueArc::try_new(Example { a: 10,=
 b: 20 })?);
> +///     // We can modify `pinned` because it is `Unpin`.
> +///     pinned.as_mut().a +=3D 1;
> +///     Ok(pinned.into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +pub struct UniqueArc<T: ?Sized> {
> +    inner: Arc<T>,
> +}
> +
> +impl<T> UniqueArc<T> {
> +    /// Tries to allocate a new [`UniqueArc`] instance.
> +    pub fn try_new(value: T) -> Result<Self> {
> +        Ok(Self {
> +            // INVARIANT: The newly-created object has a ref-count of 1.
> +            inner: Arc::try_new(value)?,
> +        })
> +    }
> +
> +    /// Tries to allocate a new [`UniqueArc`] instance whose contents ar=
e not initialised yet.
> +    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
> +        Ok(UniqueArc::<MaybeUninit<T>> {
> +            // INVARIANT: The newly-created object has a ref-count of 1.
> +            inner: Arc::try_new(MaybeUninit::uninit())?,
> +        })
> +    }
> +}
> +
> +impl<T> UniqueArc<MaybeUninit<T>> {
> +    /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by =
writing a value into it.
> +    pub fn write(mut self, value: T) -> UniqueArc<T> {
> +        self.deref_mut().write(value);
> +        let inner =3D ManuallyDrop::new(self).inner.ptr;
> +        UniqueArc {
> +            // SAFETY: The new `Arc` is taking over `ptr` from `self.inn=
er` (which won't be
> +            // dropped). The types are compatible because `MaybeUninit<T=
>` is compatible with `T`.
> +            inner: unsafe { Arc::from_inner(inner.cast()) },
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> From<UniqueArc<T>> for Pin<UniqueArc<T>> {
> +    fn from(obj: UniqueArc<T>) -> Self {
> +        // SAFETY: It is not possible to move/replace `T` inside a `Pin<=
UniqueArc<T>>` (unless `T`
> +        // is `Unpin`), so it is ok to convert it to `Pin<UniqueArc<T>>`=
.
> +        unsafe { Pin::new_unchecked(obj) }
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for UniqueArc<T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.inner.deref()
> +    }
> +}
> +
> +impl<T: ?Sized> DerefMut for UniqueArc<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: By the `Arc` type invariant, there is necessarily a r=
eference to the object, so
> +        // it is safe to dereference it. Additionally, we know there is =
only one reference when
> +        // it's inside a `UniqueArc`, so it is safe to get a mutable ref=
erence.
> +        unsafe { &mut self.inner.ptr.as_mut().data }
> +    }
> +}
> --=20
> 2.34.1

