Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226564F0F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLPS1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLPS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:27:07 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFBC655F;
        Fri, 16 Dec 2022 10:27:06 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id o66so1219975oia.6;
        Fri, 16 Dec 2022 10:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0BbxwVHNwnSrMPUgguGHD04mtg+HPKRQ7WxnV2HF38=;
        b=biwKZPVPRDWVDg8cbMLT+e9pIkZmNGSZ4+p/pPdCb3bqm64i3tTm4BzwAMVTyRExAc
         5mv4THP+c0qpUpKDyoK7zoh9OozdEngsVQR6IBFdTS748NIymMdRgGu2KoAwXxHXygF1
         IQtBNU+QN8hs3vUToyW1ALsxoMjebCNBNQfYVQVS8ztmzmfbZsG9xP+xOb+7L5APKqKj
         rpANIyh0bQr5T0VsTjjsvzk3j1RTBAmOSnalj0hCaI9xn7vznEPoOis8Q3chtrCaUnAe
         tBVjWz465ZxzGfmNETc8E9ZVwUAwyYKsiihiCfFG2yUBY5XBtsOncxHWQNthxh3Yycjr
         JENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0BbxwVHNwnSrMPUgguGHD04mtg+HPKRQ7WxnV2HF38=;
        b=j4IFDTApYRzQvJLJlbUlxa5xwkQmKRgJGvEk+fr2vFfsPaEppm/Ft7p+ErDxO/Rayk
         iuxZnl6fSBnviyh3JkxJM2Aw7BOmjg5EP7cf/nYWrp00xPX1ywu+bvPchISqJYXsAIeG
         QWrrdOrobrHh2FhBnv4Zlf2JmkGpLyna2Afbs408Hstl7fuJv2f3gegjJN88Uu5AJ2GJ
         wfIT4GbO+Wz7FKKHBqKT+1X1wRHjHO60NqsRvI2cPIiRV9oLikXYFP1Kj36x3OV9P5JP
         NndtRCmhABgIFA22J7L8GGABxn2mJh9JGLMMGodBcrnza6rbogudyPU2+j8RrOGH+zLz
         sU2g==
X-Gm-Message-State: ANoB5plsPe6hrBTn39e3PRSBCM5Z9Q4kMo8d+QVbGHSUsu2ZDomjLjP3
        0cNZsR4mU+iex04HMyGyBaoz95Dn8WYXYSRtEgI=
X-Google-Smtp-Source: AA0mqf63J78Q9RFPzckC3oK1B2mFXsXDeCOwaZCxtQLiEnahGwTCF+DmDFsb0l9h/8xCYCRWEJM5TC2Uy4GT8jLuT7c=
X-Received: by 2002:a05:6808:108:b0:354:74a1:d0a with SMTP id
 b8-20020a056808010800b0035474a10d0amr733796oie.204.1671215225622; Fri, 16 Dec
 2022 10:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20221216174927.1008629-1-wei.liu@kernel.org>
In-Reply-To: <20221216174927.1008629-1-wei.liu@kernel.org>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Fri, 16 Dec 2022 18:26:57 +0000
Message-ID: <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: drop repetition in offset_of macro
To:     Wei Liu <wei.liu@kernel.org>
Cc:     rust-for-linux@vger.kernel.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 at 17:49, Wei Liu <wei.liu@kernel.org> wrote:
>
> It doesn't make sense to allow multiple fields to be specified in
> offset_of.

Why do you say it doesn't make sense?

Here's what I had in mind:
```
    struct Y {
        z: u32
    }
    struct X {
        y: Y
    }
    offset_of!(X, y.z)
```

Which is something very plausible.

> No functional change.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> ---
>  rust/kernel/lib.rs | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 6a322effa60c..2f3601e4e27e 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -208,7 +208,7 @@ impl<'a> Drop for KParamGuard<'a> {
>  /// ```
>  #[macro_export]
>  macro_rules! offset_of {
> -    ($type:ty, $($f:tt)*) =3D> {{
> +    ($type:ty, $f:tt) =3D> {{
>          let tmp =3D core::mem::MaybeUninit::<$type>::uninit();
>          let outer =3D tmp.as_ptr();
>          // To avoid warnings when nesting `unsafe` blocks.
> @@ -216,12 +216,14 @@ macro_rules! offset_of {
>          // SAFETY: The pointer is valid and aligned, just not initialise=
d; `addr_of` ensures that
>          // we don't actually read from `outer` (which would be UB) nor c=
reate an intermediate
>          // reference.
> -        let inner =3D unsafe { core::ptr::addr_of!((*outer).$($f)*) } as=
 *const u8;
> +        let inner =3D unsafe { core::ptr::addr_of!((*outer).$f) } as *co=
nst u8;
>          // To avoid warnings when nesting `unsafe` blocks.
>          #[allow(unused_unsafe)]
>          // SAFETY: The two pointers are within the same allocation block=
.
> -        unsafe { inner.offset_from(outer as *const u8) }
> -    }}
> +        unsafe {
> +            inner.offset_from(outer as *const u8)
> +        }
> +    }};
>  }
>
>  /// Produces a pointer to an object from a pointer to one of its fields.
> --
> 2.35.1
>
