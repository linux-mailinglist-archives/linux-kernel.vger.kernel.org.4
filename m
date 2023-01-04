Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CA565D9AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbjADQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbjADQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:26:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D21B1EE;
        Wed,  4 Jan 2023 08:26:48 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kw15so83759234ejc.10;
        Wed, 04 Jan 2023 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlNSZ1zKeio5IM+qciAQdm1jmpnza6LnH9wQe17H30s=;
        b=X2pw5+FFh90/EXimxoLnyKytSb4yzru+hZwCCCd60c5Al23P9O0EPouNqRdmZTVoHw
         hMdkNZEsUdkzUc6U4X6fDNtaf+e3n0ze06t2lidZUcAGnuYs11WNPVIJ9I0+4py702nh
         G+lPvwXVaXsxf3VHCDKa7us9TAzGHh8L6Jiis56AVr2Qf47ViIGg6qv3Mt3rSkkXi4Y9
         yiU++J/VFmKPXd9WZfulHreIhCtYJ4V7YRNJL7QRmnhsBziYZRMia3vRcIddP3GIQvHa
         y9MWP6iAsPUbIj5z4RXVmaXMhTpZlUleMPP3QdxS1rxMy4wO+n/d5FDyo7Lb1NUYJeHe
         O8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dlNSZ1zKeio5IM+qciAQdm1jmpnza6LnH9wQe17H30s=;
        b=fSI+eMYQFR7+pEFzWR+dwiPwpR1Bqp+1B+Y6HZyHY1ya6EwjN9vrE6CKNm1AGZkABa
         XbBSZkPM9pG7UwqOXTyuqxzIVaENiLxg8LffyFEmir+vZLvs660xF12mxfWDvh/bhMtb
         DW9LbHosG7wK3j+04Px40yEdNj1Uvh1YJ/0Jn42koUSgs39Ns3YrGIMZGJIINdCBItvH
         kcCUVOpENyChi/XRVJndQjuQVk1q59uF1rKfig848gTZHszGGnc9IW9/E8kLSeRXFMQq
         6jOQjzBTW+I6vpD+JmlSSM+7lghl9PFcTXnnki/cIfQu7X/b3qUXkYd+uISeVVHqllgT
         qbPQ==
X-Gm-Message-State: AFqh2kpH/7zWlmaFl79786mli06mERJCodNh5a21Hw7bunlMoQu30LHz
        8HyGzIEBIo8EAUkcXEQSCHw=
X-Google-Smtp-Source: AMrXdXuK03+8hwXp7VeEhUZfc57gi6LrVEKudKlHct5gTkoUEV5OH9r7xDFowrsBeN6kcF52Sq7cBQ==
X-Received: by 2002:a17:906:185b:b0:841:e5b3:c95d with SMTP id w27-20020a170906185b00b00841e5b3c95dmr44848358eje.30.1672849607455;
        Wed, 04 Jan 2023 08:26:47 -0800 (PST)
Received: from localhost (host-82-60-200-213.retail.telecomitalia.it. [82.60.200.213])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906314b00b007ae10525550sm15402209eje.47.2023.01.04.08.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 08:26:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Jan 2023 17:26:45 +0100
Message-Id: <CPJJOZKU99U7.2II24G3LHGAXF@vincent>
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] rust: sync: add support for dispatching on Arc and
 ArcBorrow.
X-Mailer: aerc 0.8.2
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-7-wedsonaf@gmail.com>
In-Reply-To: <20221228060346.352362-7-wedsonaf@gmail.com>
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
> Trait objects (`dyn T`) require trait `T` to be "object safe". One of
> the requirements for "object safety" is that the receiver have one of
> the allowed types. This commit adds `Arc<T>` and `ArcBorrow<'_, T>` to
> the list of allowed types.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 4bde65e7b06b..e0b0e953907d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -15,6 +15,7 @@
>  #![feature(allocator_api)]
>  #![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
> +#![feature(dispatch_from_dyn)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> =20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 832bafc74a90..ff73f9240ca1 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -92,9 +92,15 @@ use core::{
>  /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
>  ///
>  /// ```
> -/// use kernel::sync::Arc;
> +/// use kernel::sync::{Arc, ArcBorrow};
> +///
> +/// trait MyTrait {
> +///     // Trait has a function whose `self` type is `Arc<Self>`.
> +///     fn example1(self: Arc<Self>) {}
>  ///
> -/// trait MyTrait {}
> +///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self=
>`.
> +///     fn example2(self: ArcBorrow<'_, Self>) {}
> +/// }
>  ///
>  /// struct Example;
>  /// impl MyTrait for Example {}
> @@ -123,6 +129,9 @@ impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>  // dynamically-sized type (DST) `U`.
>  impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> =
for Arc<T> {}
> =20
> +// This is to allow `Arc<U>` to be dispatched on when `Arc<T>` can be co=
erced into `Arc<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>=
> for Arc<T> {}
> +
>  // SAFETY: It is safe to send `Arc<T>` to another thread when the underl=
ying `T` is `Sync` because
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync=
`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `Arc<T>` may ultimate=
ly access `T` directly, for
> @@ -297,6 +306,13 @@ pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>  // This is to allow [`ArcBorrow`] (and variants) to be used as the type =
of `self`.
>  impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
> =20
> +// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T=
>` can be coerced into
> +// `ArcBorrow<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBor=
row<'_, U>>
> +    for ArcBorrow<'_, T>
> +{
> +}
> +
>  impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>      fn clone(&self) -> Self {
>          *self
> --=20
> 2.34.1

