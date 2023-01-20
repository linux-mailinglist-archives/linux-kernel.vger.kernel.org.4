Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6090B674D01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjATGGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjATGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:06:38 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64F44207
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:06:37 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4d0f843c417so58866517b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qYSDc0B7KD+ubtZdheB3KaxlEaF1j+0CJdxBaF6gP+g=;
        b=Zf+Y6IFxHLJFmNSvgnDrN9LB4xXTZzLb4bIK7/sFOldukCb5dQNZ1JMHsMeQVF703J
         7y0srT22t6HhdStCtw/k0ia2Emq3YG1WAjFCKrRHYSWG58yh4Pdst+O1dUQsJQQAhhcy
         F5dkzBGCS+RGC8a2FoMwIBg3sflhfn5F5YhWE+zxjOrIbwcNtiJQM+Y9qQk9s9NyMSGa
         r3rUUaPYBPc1dLqy4/ROQXmUkHJbz9F0o6ozYBa2hZ2qMJKpClOT3rPcs2xu0M1MBMAQ
         Pa7Tb9KiRLeGyM4GVGR8+6F2c8O/dFUlGTeJCPoCxncBgpfAP63VZKPDpKcz1Zo5Um2V
         44dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYSDc0B7KD+ubtZdheB3KaxlEaF1j+0CJdxBaF6gP+g=;
        b=APyBuWNMYenkqLaldYmdE/+gkOO2JTpAzuPxGTA7euLucjuIxsT55+19PMiEFq6WkL
         /NXpKXoLV7qXBcrRjFZe8szbAe1eI8r4yd9PW8w5zWrcxD1whojdJxRkdJQOTTjmvzLJ
         UctDxpC1obhyHwx1wieDYFOgg2fcOGBzdE94mnypTRJJTDVXO2f0A57Ph10clZJRayF7
         J9RVvZPFCMOSDcLPktB+7UXvrWSwyTp4X0uOuew7JKh5xL7PEW3fZYp24jwke15yKsS3
         fxC1NZEYpwX/U8xUnrcIUKtMjmYx6lMhmWsgfXi39u28UMD9y45QcfI2ukaNzlm9ltJS
         eTDQ==
X-Gm-Message-State: AFqh2kpra02vSCbgC9mLWtmySKhTm+V3My7vAv3BRM3oAt9DvVt5h9xz
        tQksndT2KxQ/BXP2Ez+e0Ng8fJ5Emeyy1x+8TVCb
X-Google-Smtp-Source: AMrXdXtrebisz+Wtw4lXdITn1C6XRLRglAlL62lvqjqZy+ZaPKNi7gMRPBHbVd9XWEAMKq/MtsVC+y+XiPEcxbn0FL0=
X-Received: by 2002:a81:7dd7:0:b0:4bb:c96d:f685 with SMTP id
 y206-20020a817dd7000000b004bbc96df685mr1671269ywc.208.1674194796877; Thu, 19
 Jan 2023 22:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20230119190045.1619043-1-sean.anderson@seco.com>
In-Reply-To: <20230119190045.1619043-1-sean.anderson@seco.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 19 Jan 2023 22:06:24 -0800
Message-ID: <CANDhNCrtzvKK5qbW9ZnD-MZRo139hw+jnF+tEKFEH6zH50vOOA@mail.gmail.com>
Subject: Re: [PATCH v3] drm: kirin: Enable COMPILE_TEST
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Xinliang Liu <xinliang.liu@linaro.org>,
        linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:01 AM Sean Anderson <sean.anderson@seco.com> wrote:
>
> Make various small changes to allow compile-testing on other arches.
> This is helpful to allow testing changes to 32-bit arm drivers in the
> same build.
>
> The primary changes is to use macros for 64-bit divisions and shifts,
> but we also need some other fixes to deal with larger constants and
> differences in includes.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

No objection from me (though I'm not sure I really see the benefit of
test building this driver on 32bit).

I no longer have hardware to test with, so adding YongQin and Amit.

So maybe a tentative Acked-by: John Stultz <jstultz@google.com>

thanks
-john


> ---
>
> Changes in v3:
> - Include io.h for readl/writel
>
> Changes in v2:
> - Use BIT_ULL
>
>  drivers/gpu/drm/hisilicon/kirin/Kconfig         |  2 +-
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 10 +++++-----
>  drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h    |  2 ++
>  drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h |  2 +-
>  4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> index c5265675bf0c..0772f79567ef 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DRM_HISI_KIRIN
>         tristate "DRM Support for Hisilicon Kirin series SoCs Platform"
> -       depends on DRM && OF && ARM64
> +       depends on DRM && OF && (ARM64 || COMPILE_TEST)
>         select DRM_KMS_HELPER
>         select DRM_GEM_DMA_HELPER
>         select DRM_MIPI_DSI
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> index d9978b79828c..1cfeffefd4b4 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> @@ -157,8 +157,8 @@ static u32 dsi_calc_phy_rate(u32 req_kHz, struct mipi_phy_params *phy)
>                         q_pll = 0x10 >> (7 - phy->hstx_ckg_sel);
>
>                 temp = f_kHz * (u64)q_pll * (u64)ref_clk_ps;
> -               m_n_int = temp / (u64)1000000000;
> -               m_n = (temp % (u64)1000000000) / (u64)100000000;
> +               m_n_int = div_u64_rem(temp, 1000000000, &m_n);
> +               m_n /= 100000000;
>
>                 if (m_n_int % 2 == 0) {
>                         if (m_n * 6 >= 50) {
> @@ -229,8 +229,8 @@ static u32 dsi_calc_phy_rate(u32 req_kHz, struct mipi_phy_params *phy)
>                         phy->pll_fbd_div5f = 1;
>                 }
>
> -               f_kHz = (u64)1000000000 * (u64)m_pll /
> -                       ((u64)ref_clk_ps * (u64)n_pll * (u64)q_pll);
> +               f_kHz = div64_u64((u64)1000000000 * (u64)m_pll,
> +                                 (u64)ref_clk_ps * (u64)n_pll * (u64)q_pll);
>
>                 if (f_kHz >= req_kHz)
>                         break;
> @@ -490,7 +490,7 @@ static void dsi_set_mode_timing(void __iomem *base,
>         hsa_time = (hsw * lane_byte_clk_kHz) / pixel_clk_kHz;
>         hbp_time = (hbp * lane_byte_clk_kHz) / pixel_clk_kHz;
>         tmp = (u64)htot * (u64)lane_byte_clk_kHz;
> -       hline_time = DIV_ROUND_UP(tmp, pixel_clk_kHz);
> +       hline_time = DIV64_U64_ROUND_UP(tmp, pixel_clk_kHz);
>
>         /* all specified in byte-lane clocks */
>         writel(hsa_time, base + VID_HSA_TIME);
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h b/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
> index d79fc031e53d..a87d1135856f 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
> @@ -7,6 +7,8 @@
>  #ifndef __DW_DSI_REG_H__
>  #define __DW_DSI_REG_H__
>
> +#include <linux/io.h>
> +
>  #define MASK(x)                                (BIT(x) - 1)
>
>  /*
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> index be9e789c2d04..36f923cc7594 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> @@ -10,7 +10,7 @@
>  /*
>   * ADE Registers
>   */
> -#define MASK(x)                                (BIT(x) - 1)
> +#define MASK(x)                                (BIT_ULL(x) - 1)
>
>  #define ADE_CTRL                       0x0004
>  #define FRM_END_START_OFST             0
> --
> 2.35.1.1320.gc452695387.dirty
>
