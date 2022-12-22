Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D664A653CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiLVIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiLVIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:08:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B118B2E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:08:33 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s5so1830599edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWl2qoDVkyJv80Dcc1T5jz7QH+u5H5UltZOFP/s+yNc=;
        b=pxjve+q03lKhs9SeI/Plbwt+Lh8uP7gi1x/bjlCAL591ccNGllzK8muEElztCm5iUh
         mS0twT3wf+xxGqzYK3BsDx/gvFSz4ISBvX8iqJZGXbnGRdQpcLsbopmYDk1Vd2Smv/7I
         F/trMddiOnaywB0ILgvT4aIHLcoAQ8zQYrsfQyPSGX8i72oCryK8lMyRuFDIwtd9C339
         vbdtqh5IlwEVvxKj1QceSj+xghj6cH02HJywNPUGBmJ93ZVRpLR3iP9AO2kJILUYvUH4
         0/xhFPV8hDQsQGUBbMjr0JqnUHrI+JcGPKQO/woydj2xCzN03+akoAHUEidDm2IgbrMI
         U+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWl2qoDVkyJv80Dcc1T5jz7QH+u5H5UltZOFP/s+yNc=;
        b=22iYvOT/JeGfBORDMqT3Q9BlO1Ohm0nNdPkObpHDNfMF+BglPBmzeMUkOrMbsKyvzZ
         hDt5rcPgolGdst9XXZ1YxxUxuuCY+kZLmADWERtJKQmDMdrZYl/gvDxue1lf+9N3BZwp
         ZmUWPg/Tci7UOtR6EldIK5Wvp546ya7D3N2nHuy/TK1hs2j/FYj7JAXkXd6mGqPksEvT
         JEmv2y08Rwz5tCD28NJ6DJjQWfSaO5KFOdvCuoqq4hJezr/Kuz45fKNDs6Qz1KIvCLrn
         MQKXLS18Ev2/g1qWc4heQC5bKJhxgYlbjk9DOwllMvvtX8t6wETKvzQrJkjx+yrqO+CN
         grQw==
X-Gm-Message-State: AFqh2koJhGqywqUB+3Jh8dOsDGWemTFJlFcjIAyHdms6NSDUiSyPIc7D
        Sa2WGQUlk/7/iCBaGUu5Q6niNZvSUrPFKaKJTyw=
X-Google-Smtp-Source: AMrXdXusTK9Hhv8wh8JqFhdYHmGuw61kpiPUKpJ/RHarx/sqLCZ/vGyocTEVJbmzH+H6TkwPBJNf4iI2gDX4yf+P1K4=
X-Received: by 2002:aa7:c986:0:b0:46c:5a22:b00c with SMTP id
 c6-20020aa7c986000000b0046c5a22b00cmr512937edt.46.1671696511568; Thu, 22 Dec
 2022 00:08:31 -0800 (PST)
MIME-Version: 1.0
References: <Y5XhPJ39ipMCcctq@qemulion>
In-Reply-To: <Y5XhPJ39ipMCcctq@qemulion>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 22 Dec 2022 16:07:54 +0800
Message-ID: <CAAfSe-sa2Vw7bUxuRne-fw7GZrHW+7OMj6gCS9jPTamsGF5MBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sprd: remove redundant error logging
To:     Deepak R Varma <drv@mailo.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
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

On Sun, 11 Dec 2022 at 21:55, Deepak R Varma <drv@mailo.com> wrote:
>
> A call to platform_get_irq() already prints an error on failure within
> its own implementation. So printing another error based on its return
> value in the caller is redundant and should be removed. The clean up
> also makes if condition block braces unnecessary. Remove that as well.
>
> Issue identified using platform_get_irq.cocci coccicheck script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/gpu/drm/sprd/sprd_dpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> index 88f4259680f1..db0bcea1d9f4 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -803,10 +803,8 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
>         }
>
>         ctx->irq = platform_get_irq(pdev, 0);
> -       if (ctx->irq < 0) {
> -               dev_err(dev, "failed to get dpu irq\n");
> +       if (ctx->irq < 0)

Thanks for the patch, it makes sense to me, so
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

>                 return ctx->irq;
> -       }
>
>         /* disable and clear interrupts before register dpu IRQ. */
>         writel(0x00, ctx->base + REG_DPU_INT_EN);
> --
> 2.34.1
>
>
>
