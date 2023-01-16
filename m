Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D900066D1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjAPWmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAPWmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:42:50 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CAC2387A;
        Mon, 16 Jan 2023 14:42:48 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s67so20629245pgs.3;
        Mon, 16 Jan 2023 14:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjZVJeqqULFSXmD53yNXzMDaOIl+IC+pV+97/4sSu6I=;
        b=A50ejkIHtFgA5d0wShNxSrxkuzQ0lPf5tP4owGGARkoP3Z6vrmV94Jy3s1fQPzuMr9
         4K8HqAKlukvJ+QQGXZ0uX8YPG9WzST0vVaiHa2xcYzuv7etiDMGxGjCCLotBGgUuopWK
         MOBrZHqMSO14DZeEuDOOMBvQRMhBRXO9RfHoYvhp0+1R5g3GsRs5B6YyBrvzxke8gbm1
         FSrwesrnoFJBeSKm9pjYYjXtPJ+h6OPenqmqnbGzR/AvY9f5UqK6NcZmi+VO8qzzLuqx
         O/83nNUGMv89GFOM2I/PFQRz2DKTaTSPI6IW5HGGq9wEX8COP3NiDLT5URz3CWKdh2Tm
         /uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjZVJeqqULFSXmD53yNXzMDaOIl+IC+pV+97/4sSu6I=;
        b=JT6F+MMcd64hKPeEUZVD7J/Ml9sEc1k7LJZdNRRebvl+gqQiikJ8ETN4gpTA3yycJL
         xoDvlS3njEqTuCqH+PgP4pODv28nCBaQ/ZW3JBmZ33Qy3sp2vc9eYZyuUu8JPN9uXPJ7
         RnGXZS6FGRNQjSfGZ5oFkJOfnFqqpTiUEGD3DNl88VLTY/r+Iy+WU0s/UDzx4V1Adq1x
         8Zp9Y1hvcsyl/+lPCMhPrv1BqamuDVcmpbbSQRAw9YzWxsR4g8300+0maOm+lp1Se7fy
         UwDrhasBAEIEFsOzKm8Lh/Qhh0P8BrPjsgkPowTR0qPB18WzSHfSHjx2rAY+JJc3kZAB
         e/ig==
X-Gm-Message-State: AFqh2kpsMEY22xdU7j0mnFthUxrJwynSv9iMLwZ7LL7zpRfVWq3c8TPv
        he1LbqHdSnfguB0r+e3zyxVWngi4eiD5Dz3Pb2g6VL3d4Xpbqg4i
X-Google-Smtp-Source: AMrXdXto1J/YBTaLNgeEEtaDdFn46S3lxehr5Yxpiwp4zZRgDV8rwd14JdTbDD4ZU99+713loO1bAXKRi65A7Ao9hgo=
X-Received: by 2002:a63:ea0c:0:b0:476:aad3:9121 with SMTP id
 c12-20020a63ea0c000000b00476aad39121mr35934pgi.385.1673908967516; Mon, 16 Jan
 2023 14:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20221228060346.352362-1-wedsonaf@gmail.com> <20221228060346.352362-4-wedsonaf@gmail.com>
In-Reply-To: <20221228060346.352362-4-wedsonaf@gmail.com>
From:   Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Date:   Mon, 16 Jan 2023 23:42:35 +0100
Message-ID: <CAKy8djRYF52bxUf7ooTOWvmDhjcymVuu+O7h-aNd53uH_ubeDw@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ops! I fall asleep while waiting for the Copy to derive Copy debate!

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>


On Wed, Dec 28, 2022 at 7:05 AM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> This allows us to create references to a ref-counted allocation without
> double-indirection and that still allow us to increment the refcount to
> a new `Arc<T>`.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/sync.rs     |  2 +-
>  rust/kernel/sync/arc.rs | 97 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 39b379dd548f..5de03ea83ea1 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -7,4 +7,4 @@
>
>  mod arc;
>
> -pub use arc::Arc;
> +pub use arc::{Arc, ArcBorrow};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index dbc7596cc3ce..f68bfc02c81a 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque};
>  use alloc::boxed::Box;
>  use core::{
>      marker::{PhantomData, Unsize},
> +    mem::ManuallyDrop,
>      ops::Deref,
>      ptr::NonNull,
>  };
> @@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
>              _p: PhantomData,
>          }
>      }
> +
> +    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> +    ///
> +    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
> +    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
> +    #[inline]
> +    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> +        // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
> +        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
> +        // reference can be created.
> +        unsafe { ArcBorrow::new(self.ptr) }
> +    }
>  }
>
>  impl<T: ?Sized> Deref for Arc<T> {
> @@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
>          }
>      }
>  }
> +
> +/// A borrowed reference to an [`Arc`] instance.
> +///
> +/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
> +/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
> +///
> +/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
> +/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
> +/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
> +/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
> +/// needed.
> +///
> +/// # Invariants
> +///
> +/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
> +/// lifetime of the [`ArcBorrow`] instance.
> +///
> +/// # Example
> +///
> +/// ```
> +/// use crate::sync::{Arc, ArcBorrow};
> +///
> +/// struct Example;
> +///
> +/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> +///     e.into()
> +/// }
> +///
> +/// let obj = Arc::try_new(Example)?;
> +/// let cloned = do_something(obj.as_arc_borrow());
> +///
> +/// // Assert that both `obj` and `cloned` point to the same underlying object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +/// ```
> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> +    inner: NonNull<ArcInner<T>>,
> +    _p: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
> +
> +impl<T: ?Sized> ArcBorrow<'_, T> {
> +    /// Creates a new [`ArcBorrow`] instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
> +    /// 1. That `inner` remains valid;
> +    /// 2. That no mutable references to `inner` are created.
> +    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
> +        // INVARIANT: The safety requirements guarantee the invariants.
> +        Self {
> +            inner,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> +    fn from(b: ArcBorrow<'_, T>) -> Self {
> +        // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
> +        // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
> +        // increment.
> +        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> +            .deref()
> +            .clone()
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
> +        // references to it, so it is safe to create a shared reference.
> +        unsafe { &self.inner.as_ref().data }
> +    }
> +}
> --
> 2.34.1
>
