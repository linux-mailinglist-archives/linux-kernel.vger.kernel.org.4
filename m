Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A216B74DC78
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjGJR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGJR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:28:51 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60214120
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:28:50 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-565f3881cbeso3706035eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689010129; x=1691602129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul2VBha0pA5JbrKTfyVeWSobOhwcf7C0x71pvrwyrgQ=;
        b=o6mVXqDTJmoHlgZBvx002DCMmHK4ChjFvLlY6gU+ePOdej0BSjQFyLY8olhCtj6mu2
         wZDy9aP75QBVXpumDWx2MtwtuMIIxxxVJroOi4cAtqcIqzCudfXUZvzccob7nUYqsiJu
         PkYuHINFZaecU/9Sa50Uqp7GpIEgq8GZY4qH9jg743AJlaItRqXN5y8W+xZryx2ztouF
         wPofLGnW5VmLI2i1Xhvr8gLvDIqkW+uBqlwGK9X0vCT7bPizpyT+Qmqg93VDYj+B4ovZ
         ZSwRJ3e4pufvumMwOC+j3Pdo40J+zN9LTZEaCTtXpgkwsNOs0dRS2qhYBCdVqx0EJImD
         nxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010129; x=1691602129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul2VBha0pA5JbrKTfyVeWSobOhwcf7C0x71pvrwyrgQ=;
        b=dunNtnAUUfOTUVTJ6pmcLmpkgszOd8bGZjCM8JWctETJZBZkcNWK8L8fgs9Ge/iMIR
         2aRacUlrhCmVZBtGpDG8nYTVMiqQOmELpzMrSh5VLK1UwqeBbSaZcpNkv1s/TjEHcXbC
         fPZl5LIAVUIezfHJ65fog921u3J8ioqaEkKLBMZKvFnMzcSlYQ7DzqXJKAJDo/wXv/dG
         ii/71c23JTSpJtbBx8Dv0HWrAjXUGJMvvx+eWHDDKc13SKmFcDhf5A2QVdDWgzhHqr28
         v4woahUQSRNVWv27XaGbeInsenG7ErBg3yp6Y30FVVSkdBAvgZF7zEKSrMOf4p1OlO3a
         4SKg==
X-Gm-Message-State: ABy/qLZgParJ+NPntIESr7Q8VOXTgrGp67qPTtVCszpNltePTpyVHz5G
        a1vu2rGsUsr6SWTZ6gqcnmZ3PlX1SwsP2xS5+7U=
X-Google-Smtp-Source: APBJJlFBwe80s58hgF1p9KknrluN6s31yo6PZL7GCWDUtGNihirysQsJpLLHIFLcfpxDoBlymOQh450Xi90ohXdtI94=
X-Received: by 2002:a4a:4f0a:0:b0:565:97f9:d2fb with SMTP id
 c10-20020a4a4f0a000000b0056597f9d2fbmr10945664oob.3.1689010129387; Mon, 10
 Jul 2023 10:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230710090421.61623-1-xujianghui@cdjrlc.com> <77876ef2908eda36cb7f843145ec8cec@208suo.com>
In-Reply-To: <77876ef2908eda36cb7f843145ec8cec@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jul 2023 13:28:38 -0400
Message-ID: <CADnq5_PzKrkt7_=8VGMbAeXw+HD3Wch1VXaTTbeds3jHO2j+vg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: ERROR: that open brace { should be on the
 previous line
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 10, 2023 at 5:06=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix eleven occurrences of the checkpatch.pl error:
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/rv770.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/rv770.c
> b/drivers/gpu/drm/radeon/rv770.c
> index a5ce59d4a485..9ce12fa3c356 100644
> --- a/drivers/gpu/drm/radeon/rv770.c
> +++ b/drivers/gpu/drm/radeon/rv770.c
> @@ -136,7 +136,7 @@ int rv770_set_uvd_clocks(struct radeon_device *rdev,
> u32 vclk, u32 dclk)
>       return 0;
>   }
>
> -static const u32 r7xx_golden_registers[] =3D{
> +static const u32 r7xx_golden_registers[] =3D {
>       0x8d00, 0xffffffff, 0x0e0e0074,
>       0x8d04, 0xffffffff, 0x013a2b34,
>       0x9508, 0xffffffff, 0x00000002,
> @@ -151,7 +151,7 @@ static const u32 r7xx_golden_registers[] =3D{
>       0x7300, 0xffffffff, 0x001000f0
>   };
>
> -static const u32 r7xx_golden_dyn_gpr_registers[] =3D{
> +static const u32 r7xx_golden_dyn_gpr_registers[] =3D {
>       0x8db0, 0xffffffff, 0x98989898,
>       0x8db4, 0xffffffff, 0x98989898,
>       0x8db8, 0xffffffff, 0x98989898,
> @@ -163,7 +163,7 @@ static const u32 r7xx_golden_dyn_gpr_registers[] =3D{
>       0x88c4, 0xffffffff, 0x00000082
>   };
>
> -static const u32 rv770_golden_registers[] =3D{
> +static const u32 rv770_golden_registers[] =3D {
>       0x562c, 0xffffffff, 0,
>       0x3f90, 0xffffffff, 0,
>       0x9148, 0xffffffff, 0,
> @@ -172,7 +172,7 @@ static const u32 rv770_golden_registers[] =3D{
>       0x9698, 0x18000000, 0x18000000
>   };
>
> -static const u32 rv770ce_golden_registers[] =3D{
> +static const u32 rv770ce_golden_registers[] =3D {
>       0x562c, 0xffffffff, 0,
>       0x3f90, 0xffffffff, 0x00cc0000,
>       0x9148, 0xffffffff, 0x00cc0000,
> @@ -183,7 +183,7 @@ static const u32 rv770ce_golden_registers[] =3D{
>       0x9698, 0x18000000, 0x18000000
>   };
>
> -static const u32 rv770_mgcg_init[] =3D{
> +static const u32 rv770_mgcg_init[] =3D {
>       0x8bcc, 0xffffffff, 0x130300f9,
>       0x5448, 0xffffffff, 0x100,
>       0x55e4, 0xffffffff, 0x100,
> @@ -340,7 +340,7 @@ static const u32 rv770_mgcg_init[] =3D{
>       0x92a4, 0xffffffff, 0x00080007
>   };
>
> -static const u32 rv710_golden_registers[] =3D{
> +static const u32 rv710_golden_registers[] =3D {
>       0x3f90, 0x00ff0000, 0x00fc0000,
>       0x9148, 0x00ff0000, 0x00fc0000,
>       0x3f94, 0x00ff0000, 0x00fc0000,
> @@ -349,7 +349,7 @@ static const u32 rv710_golden_registers[] =3D{
>       0xa180, 0xffffffff, 0x00003f3f
>   };
>
> -static const u32 rv710_mgcg_init[] =3D{
> +static const u32 rv710_mgcg_init[] =3D {
>       0x8bcc, 0xffffffff, 0x13030040,
>       0x5448, 0xffffffff, 0x100,
>       0x55e4, 0xffffffff, 0x100,
> @@ -407,7 +407,7 @@ static const u32 rv710_mgcg_init[] =3D{
>       0x9150, 0xffffffff, 0x4d940000
>   };
>
> -static const u32 rv730_golden_registers[] =3D{
> +static const u32 rv730_golden_registers[] =3D {
>       0x3f90, 0x00ff0000, 0x00f00000,
>       0x9148, 0x00ff0000, 0x00f00000,
>       0x3f94, 0x00ff0000, 0x00f00000,
> @@ -417,7 +417,7 @@ static const u32 rv730_golden_registers[] =3D{
>       0xa180, 0xffffffff, 0x00003f3f
>   };
>
> -static const u32 rv730_mgcg_init[] =3D{
> +static const u32 rv730_mgcg_init[] =3D {
>       0x8bcc, 0xffffffff, 0x130300f9,
>       0x5448, 0xffffffff, 0x100,
>       0x55e4, 0xffffffff, 0x100,
> @@ -538,7 +538,7 @@ static const u32 rv730_mgcg_init[] =3D{
>       0x92a4, 0xffffffff, 0x00000005
>   };
>
> -static const u32 rv740_golden_registers[] =3D{
> +static const u32 rv740_golden_registers[] =3D {
>       0x88c4, 0xffffffff, 0x00000082,
>       0x28a50, 0xfffffffc, 0x00000004,
>       0x2650, 0x00040000, 0,
> @@ -574,7 +574,7 @@ static const u32 rv740_golden_registers[] =3D{
>       0x9698, 0x18000000, 0x18000000
>   };
>
> -static const u32 rv740_mgcg_init[] =3D{
> +static const u32 rv740_mgcg_init[] =3D {
>       0x8bcc, 0xffffffff, 0x13030100,
>       0x5448, 0xffffffff, 0x100,
>       0x55e4, 0xffffffff, 0x100,
