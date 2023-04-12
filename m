Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62F96E01C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDLWWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLWV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:21:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9465B4EDD;
        Wed, 12 Apr 2023 15:21:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e9so42752080ljq.4;
        Wed, 12 Apr 2023 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681338116; x=1683930116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJr6AWFebjK1Coi807z+XBUR1Np+UcCq6pNM3vMGwoo=;
        b=aNuQQWmbgSMWmF1ot1asUunY9Gtyu9/w4nuwYix+fSMpVIlCplQvbcBt6ATr0gP6zy
         21wf8/gsMaOWQAoOnnfASoVsyM76miHNwFyJnme8ADMsg+1kjc4ZjN4Y+zI32F1+cr0S
         FJ1NaoY3mTLXj8jryuimEXKCWhofdVNAbvE1HwaNhJt/A2Qo5WQCZCWoBOXsxBl2jtbM
         0ROSrO9fpaBHAEUVifIfSZSNHgyHdG7OX1jzuzhlMYSvbfsjlB+MSN0j5u4+1jZDY5AG
         0GoFgVHdYQHhCtUI6fBKVbOBD/X995rGDzp7NdPDDVqg0hU/NKLfq3PGcVmBlQQmBMKl
         I1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338116; x=1683930116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJr6AWFebjK1Coi807z+XBUR1Np+UcCq6pNM3vMGwoo=;
        b=Y7ouMq0EHvA2oGEP2pAp60D3bW9pEaBmMaEW/czjDqUpshjYN55Ms+lZZH2zGOjyRB
         p9ePzi41lDdJ8l8v4RHxR+2dipdW6HRQNitPB3v/QpnXLV8UCMaT3fIRs4TrcIdJ+6Jr
         I+jNlj9VMMfNqWRzvx2Lk8iFsU9r3ZJIY7dMht3U1uL9Dl+jY3WYu0dZv2FxImipuTW1
         +ltktM08n39gUtZWdxAQvaaBM8+x7HPN4aOAOtG3Sh44Lo1HRsBXdpiLVguqMSyFiiQC
         jNiiERMlXSlHkJIfp5KpdCQyXgCZrdlSisflzAB69Pym5z7TI8Q2Q1PnZjpRy31G5pgI
         HOFQ==
X-Gm-Message-State: AAQBX9cNNllkah4Gy3pjx1KG0dDnuBsuperzpOT48d3q1qq0b1IoT5eY
        hOQnKLM2t0lF2fen2wom8elUWryVA8XpEZjq6nY=
X-Google-Smtp-Source: AKy350ZKq0MErucl+c8u4wpRhsUOwBNFfKHT4tb97uXRU0ahEt4j/D4sUk0PdPgT82Uvx9Nus5B+BCaePsGQTAdrvu4=
X-Received: by 2002:a2e:8296:0:b0:2a7:73ce:93be with SMTP id
 y22-20020a2e8296000000b002a773ce93bemr73252ljg.9.1681338115661; Wed, 12 Apr
 2023 15:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230412221823.830135-1-ojeda@kernel.org>
In-Reply-To: <20230412221823.830135-1-ojeda@kernel.org>
From:   Alex Gaynor <alex.gaynor@gmail.com>
Date:   Wed, 12 Apr 2023 18:21:44 -0400
Message-ID: <CAFRnB2VygPYBY7MbxoftzEtqs52YG5AN_EO72Nm1ukLWnApa=Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Benno Lossin as Rust reviewer
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

On Wed, Apr 12, 2023 at 6:18=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Benno has been involved with the Rust for Linux project for
> the better part of a year now. He has been working on solving
> the safe pinned initialization problem [1], which resulted in
> the pin-init API patch series [2] that allows to reduce the
> need for `unsafe` code in the kernel. He is also working on
> the field projection RFC for Rust [3] to bring pin-init as
> a language feature.
>
> His expertise with the language will be very useful to have
> around in the future if Rust grows within the kernel, thus
> add him to the `RUST` entry as reviewer.
>
> Link: https://rust-for-linux.com/the-safe-pinned-initialization-problem [=
1]
> Link: https://lore.kernel.org/rust-for-linux/20230408122429.1103522-1-y86=
-dev@protonmail.com/ [2]
> Link: https://github.com/rust-lang/rfcs/pull/3318 [3]
> Cc: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..bf9deaa4aa5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18225,6 +18225,7 @@ M:      Wedson Almeida Filho <wedsonaf@gmail.com>
>  R:     Boqun Feng <boqun.feng@gmail.com>
>  R:     Gary Guo <gary@garyguo.net>
>  R:     Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> +R:     Benno Lossin <benno.lossin@proton.me>
>  L:     rust-for-linux@vger.kernel.org
>  S:     Supported
>  W:     https://github.com/Rust-for-Linux/linux
>
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
> --
> 2.40.0
>


--=20
All that is necessary for evil to succeed is for good people to do nothing.
