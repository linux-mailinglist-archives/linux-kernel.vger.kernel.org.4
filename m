Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0565D861
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbjADQOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbjADQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:13:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC226E8;
        Wed,  4 Jan 2023 08:13:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk9so83593825ejc.3;
        Wed, 04 Jan 2023 08:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaSj26sneeDRxTZdnypoQJdLKacz1zedI+sgNhCME8Y=;
        b=pooGM0pFb7waa3wptKfvpjCQgl+tibQuGyA/Xb/aLZOkBwCB6yMHyYv8tmPbRFzQrg
         aI+GlXA3dL1Ex3CaHtNqh+vWerkPLpuem5UpcWVzGbtJOUlHeWQnZxvcANRJCDk83wcW
         eepxz8DO6a50rZZ5hijztsDb724UDJ6vxTaqxeLSbdBYMbqs8BjviJQ/A6eqqk7kkt/c
         S48HjyoCwRs1qQf4eMvdFH8DwQ9hkWRGHJVNGkESl9nNx/dklCOThVnyqTNKrCxDXs0w
         3S+3CsDVurD7VUTQ+pj9xvfJyhlNzH4q/bASSbU6conGmRWILd1p2qZ1d00qIAauTM4e
         rw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TaSj26sneeDRxTZdnypoQJdLKacz1zedI+sgNhCME8Y=;
        b=Pro7adf5MfiYzP/FZ3L7m/ogr0pHyqLaHVMN0B3kTmrbIvUkih4hSObt9b9pm2hdjB
         Bv6rsNZdhKQNFkQMdjESaN7rLJB9zQvnpkgQDx+YR3aC6mEyj9qq+sm70/vRK/IhyF9r
         l30FVDBrNDFm0MW0/sDmzUz8f9akiTBMqx2CKDcaTQW9Pvp0BcMb5wfMTTY2SfPFEuJr
         WTWncoP0MXAlkIp7MjIx2OA6vJRLKy/0n8O47HmxjswM0jeOPggGSz9H11NAv84u7hWs
         ESYs++HIwUOcGPD2Hl1fpEnZasy6CbydlZmCQBgIR4hV0+BauB2/Q0RjsPj+OrMjr0up
         2aCA==
X-Gm-Message-State: AFqh2ko+54PfEVGayrj9gKWR9HNgsxDyfwLmodbpJ6arKlu9QunsrBKq
        YJ9HLOBFrDcoQouNBLlVtbc=
X-Google-Smtp-Source: AMrXdXtjhkB2Nj6SHctXsTHWa4AEmyBr5z825qY8ikPoRwvHoLmYx8+m6LGhVWLIo3tUbKops8qCuQ==
X-Received: by 2002:a17:906:f854:b0:849:7688:3e3e with SMTP id ks20-20020a170906f85400b0084976883e3emr32268125ejb.44.1672848818681;
        Wed, 04 Jan 2023 08:13:38 -0800 (PST)
Received: from localhost (host-82-60-200-213.retail.telecomitalia.it. [82.60.200.213])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090668c400b007aed2057eacsm15389633ejr.221.2023.01.04.08.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 08:13:38 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Jan 2023 17:13:36 +0100
Message-Id: <CPJJEXA0W9QT.K7XCYZGX0NU3@vincent>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] rust: sync: allow coercion from `Arc<T>` to
 `Arc<U>`
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-3-wedsonaf@gmail.com>
In-Reply-To: <20221228060346.352362-3-wedsonaf@gmail.com>
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
> The coercion is only allowed if `U` is a compatible dynamically-sized
> type (DST). For example, if we have some type `X` that implements trait
> `Y`, then this allows `Arc<X>` to be coerced into `Arc<dyn Y>`.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/lib.rs      |  2 ++
>  rust/kernel/sync/arc.rs | 27 ++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 1a10f7c0ddd9..4bde65e7b06b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -13,8 +13,10 @@
> =20
>  #![no_std]
>  #![feature(allocator_api)]
> +#![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
>  #![feature(receiver_trait)]
> +#![feature(unsize)]
> =20
>  // Ensure conditional compilation based on the kernel configuration work=
s;
>  // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e2eb0e67d483..dbc7596cc3ce 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,7 +17,11 @@
> =20
>  use crate::{bindings, error::Result, types::Opaque};
>  use alloc::boxed::Box;
> -use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> +use core::{
> +    marker::{PhantomData, Unsize},
> +    ops::Deref,
> +    ptr::NonNull,
> +};
> =20
>  /// A reference-counted pointer to an instance of `T`.
>  ///
> @@ -82,6 +86,23 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNu=
ll};
>  /// obj.use_reference();
>  /// obj.take_over();
>  /// ```
> +///
> +/// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// trait MyTrait {}
> +///
> +/// struct Example;
> +/// impl MyTrait for Example {}
> +///
> +/// // `obj` has type `Arc<Example>`.
> +/// let obj: Arc<Example> =3D Arc::try_new(Example)?;
> +///
> +/// // `coerced` has type `Arc<dyn MyTrait>`.
> +/// let coerced: Arc<dyn MyTrait> =3D obj;
> +/// ```
>  pub struct Arc<T: ?Sized> {
>      ptr: NonNull<ArcInner<T>>,
>      _p: PhantomData<ArcInner<T>>,
> @@ -96,6 +117,10 @@ struct ArcInner<T: ?Sized> {
>  // This is to allow [`Arc`] (and variants) to be used as the type of `se=
lf`.
>  impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
> =20
> +// This is to allow coercion from `Arc<T>` to `Arc<U>` if `T` can be con=
verted to the
> +// dynamically-sized type (DST) `U`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> =
for Arc<T> {}
> +
>  // SAFETY: It is safe to send `Arc<T>` to another thread when the underl=
ying `T` is `Sync` because
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync=
`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `Arc<T>` may ultimate=
ly access `T` directly, for
> --=20
> 2.34.1

