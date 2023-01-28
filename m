Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362E467F77D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjA1LPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1LPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:15:44 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E530FF17;
        Sat, 28 Jan 2023 03:15:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so6861610edb.7;
        Sat, 28 Jan 2023 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NblkQfp5UobRkkFY0Xa3j7JtUtj1KMEC5tKh7feD6wQ=;
        b=QaphRaF0CjZse1VY5jxor5wjrjI0Re9lrfq6VU2GhZG/G3AWNo3wvmocYU5z2CmQK0
         bvAN2Uq3P8FOvHYPmuRJN0IXsjehPANLAaU0JgSlGJ3Vc21hV0MDrTv7shEGnJpkvJ3V
         IDIoozn7G+JpNfYh+JvFxgmujdhI2rYH0P8GdY/Yanm0W8gW2ZyKH+y04N9bcxeqH/ud
         TpmNYUMw/i9Gf6gLgsiPiUNFAe4VbKcQV5teKAnVy5QJLtbP9mWP84ttGAqsPjGKVeUz
         YYQXaeMKiXbqVsE7F1H1hG5Br81mv35ZQzfVxv2o0RojdBzXNxtaJdC39IwjZiHz2+Sa
         IXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NblkQfp5UobRkkFY0Xa3j7JtUtj1KMEC5tKh7feD6wQ=;
        b=tPJ1VeASvD511Xk4vragIT0lZrkStykOXltY2qyfqafa2skBE/oMSFlkd4rmZaqJy0
         LvLsUWy7Mr7k5kb9uZQID7aczMZAw5k+/QzbEFgHh/YKrg6+Muwht6TO4njq21TSra4F
         ahBJESDDulF9gWVUIAjapjmX5+vZVx5PgaRRAEGg2qoqWE6LhiFrgRVtTaOfiK1hKVUC
         RhLtLFLsdSeGi7LdU7XBbUZIlDuUR5acfrqUfxg1VFtWBUqk3Htq7tdZQXm+QDj4jTRJ
         +NLj/rlPDytGOkuRSWGAaP6elusGeiIoKlVO5JszLc/eNYUboURyRD7emJg3LCmLfuR1
         mvtg==
X-Gm-Message-State: AFqh2kq8EuFtBwJ5c4HxnNyLIBN7b4X6XpBZssVviXxP1OtDXFVBUy1i
        /AmALrg6xDzFo4hb8kgS7m4=
X-Google-Smtp-Source: AMrXdXvAbr1LdsmnFm8NQlq8Tg+exnS4E+q6qnKEgOhrOeO1rqyv1GdsFNUn+RfsLKvxOIqEjvko9A==
X-Received: by 2002:a05:6402:3214:b0:49d:bc8c:c3eb with SMTP id g20-20020a056402321400b0049dbc8cc3ebmr52335717eda.15.1674904541584;
        Sat, 28 Jan 2023 03:15:41 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:645c:8576:916a:8c99])
        by smtp.gmail.com with ESMTPSA id e22-20020a17090658d600b0085214114218sm3736327ejs.185.2023.01.28.03.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 03:15:41 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 12:15:39 +0100
Message-Id: <CQ3S3VEW6WEJ.1U8R1SIJAWHOY@vincent>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] rust: types: implement `ForeignOwnable` for
 `Arc<T>`
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20230119174036.64046-1-wedsonaf@gmail.com>
 <20230119174036.64046-5-wedsonaf@gmail.com>
In-Reply-To: <20230119174036.64046-5-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 19, 2023 at 6:40 PM CET, Wedson Almeida Filho wrote:
> This allows us to hand ownership of Rust ref-counted objects to
> the C side of the kernel.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  rust/kernel/sync/arc.rs | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index ff73f9240ca1..519a6ec43644 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -15,7 +15,11 @@
>  //!
>  //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
> =20
> -use crate::{bindings, error::Result, types::Opaque};
> +use crate::{
> +    bindings,
> +    error::Result,
> +    types::{ForeignOwnable, Opaque},
> +};
>  use alloc::boxed::Box;
>  use core::{
>      marker::{PhantomData, Unsize},
> @@ -189,6 +193,32 @@ impl<T: ?Sized> Arc<T> {
>      }
>  }
> =20
> +impl<T: 'static> ForeignOwnable for Arc<T> {
> +    type Borrowed<'a> =3D ArcBorrow<'a, T>;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        ManuallyDrop::new(self).ptr.as_ptr() as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a,=
 T> {
> +        // SAFETY: By the safety requirement of this function, we know t=
hat `ptr` came from
> +        // a previous call to `Arc::into_foreign`.
> +        let inner =3D NonNull::new(ptr as *mut ArcInner<T>).unwrap();
> +
> +        // SAFETY: The safety requirements of `from_foreign` ensure that=
 the object remains alive
> +        // for the lifetime of the returned value. Additionally, the saf=
ety requirements of
> +        // `ForeignOwnable::borrow_mut` ensure that no new mutable refer=
ences are created.
> +        unsafe { ArcBorrow::new(inner) }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: By the safety requirement of this function, we know t=
hat `ptr` came from
> +        // a previous call to `Arc::into_foreign`, which owned guarantee=
s that `ptr` is valid and
> +        // owns a reference.
> +        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
> +    }
> +}
> +
>  impl<T: ?Sized> Deref for Arc<T> {
>      type Target =3D T;
> =20
> --=20
> 2.34.1

