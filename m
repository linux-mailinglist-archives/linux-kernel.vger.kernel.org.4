Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B937865D8D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjADQTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbjADQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:18:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23033EE1D;
        Wed,  4 Jan 2023 08:18:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u19so83783854ejm.8;
        Wed, 04 Jan 2023 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGuq60AoPgTgitAWaqgqjJ9gTOQakFkr23ARenHdhYM=;
        b=jWdz4zdoCLHkBaYWyveEaDQFwtGW1El677I334NMo2r95D16hKdH/xEew/L3Gtq9TU
         A5yHbDhaY6FxGw3AQUoj2YqMWIN5xBBKOE8WJvlGvAw9wnznD06DeFzGBNSsWAlcpU7D
         BmRO9iVpoXOH2bmZOxUXCBY4o6ceyiBIN+5BoGHDpLgA9z+t+htpkOidaMvXDzd665fZ
         K8t+htfWgzeb7WYOJsBG7y4NC9fxgu3DhMf6c+sydrat6THvR8qlcIkkXyvjpS8/dKNc
         OHWJG9nt3hNuYf10E5TkS+apRMQiMEf9nmszW+6WY10LUfXmuCDTcz0aJWavU0Rbgvz2
         U8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGuq60AoPgTgitAWaqgqjJ9gTOQakFkr23ARenHdhYM=;
        b=Obm7U4eLvTmZU2Dw6xO+OPq6r3EsrUqrL8MEr1wBo/P5nBJgnBCVPw6Jf/PrRMLUam
         hpdl3k/MSe+pvSQN8zp+Z+q6O3eaN2Y1YwJ6vK+PrwcswY/mxhfub+qjGewySsU+smlC
         7nNf5a99M8xcuWNbsDSpujwvXtRIpUhsfkZuRIqbNxBx0f+NTaPac99KBTwEVLLETzAr
         skzOcD+DPxrQluozPO89WlX0tnVY05FFNziItRrz1na7JF9yY7V8wmSYe/flSb2DBXcp
         vltaQ/vJl/w4cxo7b+qrrbNFitgCX45oG7ZvKjCfEyMwn9W99cc7JDNMCgbxMzOaIVfh
         8Gdg==
X-Gm-Message-State: AFqh2kpsO/KdFvx5REOst+4cDn73Z5SgcnGgyNOQ+ceFSsHxCr3UrcW5
        oEslcG9C6uvg7dMyStgHzZ90hKWolq2Tfys5cCopSUdZ
X-Google-Smtp-Source: AMrXdXuD63u9Er9ghisB37xijCntkYdaG8xOti/so1Dj0gjKRLf1PxRG4xZQbCjGkAVPBn8BWHtk2g==
X-Received: by 2002:a17:906:b0cd:b0:7ac:a2f5:cd0a with SMTP id bk13-20020a170906b0cd00b007aca2f5cd0amr39948963ejb.44.1672849126692;
        Wed, 04 Jan 2023 08:18:46 -0800 (PST)
Received: from localhost (host-82-60-200-213.retail.telecomitalia.it. [82.60.200.213])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090778c300b007c00323cc23sm15432169ejc.27.2023.01.04.08.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 08:18:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Jan 2023 17:18:44 +0100
Message-Id: <CPJJIUQATXCL.D6C0EEMS35DV@vincent>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] rust: sync: allow type of `self` to be
 `ArcBorrow<T>`
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-5-wedsonaf@gmail.com>
In-Reply-To: <20221228060346.352362-5-wedsonaf@gmail.com>
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
> This allows associated functions whose `self` argument has
> `ArcBorrow<T>` as their type. This, in turn, allows callers to use the
> dot syntax to make calls.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/sync/arc.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index f68bfc02c81a..84f31c85a513 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -255,11 +255,34 @@ impl<T: ?Sized> Drop for Arc<T> {
>  /// // Assert that both `obj` and `cloned` point to the same underlying =
object.
>  /// assert!(core::ptr::eq(&*obj, &*cloned));
>  /// ```
> +///
> +/// Using `ArcBorrow<T>` as the type of `self`:
> +///
> +/// ```
> +/// use crate::sync::{Arc, ArcBorrow};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// impl Example {
> +///     fn use_reference(self: ArcBorrow<'_, Self>) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
> +/// obj.as_arc_borrow().use_reference();
> +/// ```
>  pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>      inner: NonNull<ArcInner<T>>,
>      _p: PhantomData<&'a ()>,
>  }
> =20
> +// This is to allow [`ArcBorrow`] (and variants) to be used as the type =
of `self`.
> +impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
> +
>  impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>      fn clone(&self) -> Self {
>          *self
> --=20
> 2.34.1

