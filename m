Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8FD6F4C58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEBVmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEBVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:42:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09CB1984
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:42:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4edc7cc6f46so5180604e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683063729; x=1685655729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTtiE3JTFO0cOKr86RoPcbIJbXhk5xldLmdUe24G2v8=;
        b=B2CHfRALrKnpEAUaX9F4pvRc6hDgmVz5h3Vl+H+TDwvzU8exwLZc8aHWoHuRyVdwyQ
         Ik/uZ1pl4SGeil/uzcySMPHnOcQjmVdGhRXJsiwesMV4DTE1nsL5r2NtIxNnaEuRHAvN
         4VvbAhlCo6QjGvdvBsSvFifKTgYeH5o4w2rHVLzfGv55CUG7PAW+oAB1QNvWyV41DAAR
         LHdhVV8LWfsjV4k1rYXHo1w5eOHU66JjdCAkLFakq9fI5eTnMv2wuvJ7SdUUqTuD/3A+
         Vx/k332iDZLEHDgP9VbxXnV0Xa4UYy0RT4kUIlR5A+f74dJxtFF4apgJwb0Vy1iT4vZC
         KyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683063729; x=1685655729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTtiE3JTFO0cOKr86RoPcbIJbXhk5xldLmdUe24G2v8=;
        b=gAWNlKUcz8umIDbn8O7BeQXeHK09l42x4KLcyf7NvP4ZfNd10JkbVsyDuRweLtfcQ+
         jb3Pm/XeYiLDlXTI/b7iFIOfLTppjoPBo6j+f/fiXRCeHpiQ1+HBet8R8UMR+XAMWim4
         vciPxnUguk6W5a/YeYj+IzQ/XfmYpqmFBPdTEzbJmtwyFTnntFVpUgJ7Y8dv6XhIuU4d
         gblvIgM78KCL1waBlELOlpxV07VKuIbIxnKmBvqNq+VBN9EqQYnp/FJHeYVEuhnLy1US
         sauyqNldztTzdFFzRTP24SFGR2Eae4L12ILU7xrfrdabk6inu9xjvJ3W3+IiC9EzGn4c
         bUoQ==
X-Gm-Message-State: AC+VfDycYfFh8zopxahdVE50tgQxJts9gYMRIMCvJMPeXCRdnSnEBlpD
        ikPKIm+cn5Z7tNPPpSkq5ZY1Cg==
X-Google-Smtp-Source: ACHHUZ7cZofo4A2Nrg1r9YYlX8ECTEOw+Ai1PWajayQnPHNsggyGS2+1bH4T7vgKY/SKRWoj1hf8Zw==
X-Received: by 2002:a19:ee0c:0:b0:4e8:5576:98f4 with SMTP id g12-20020a19ee0c000000b004e8557698f4mr421236lfb.45.1683063729146;
        Tue, 02 May 2023 14:42:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e7412000000b002a8bb20e534sm5316902ljc.108.2023.05.02.14.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:42:08 -0700 (PDT)
Message-ID: <1d390e6f-4ec3-bef3-4ad6-b86e5b07c709@linaro.org>
Date:   Wed, 3 May 2023 00:42:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 7/7] drm/msm/dpu: add DSC 1.2 hw blocks for relevant
 chipsets
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
 <1683061382-32651-8-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683061382-32651-8-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 00:03, Kuogee Hsieh wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add DSC 1.2 hardware blocks to the catalog with necessary sub-block and
> feature flag information.  Each display compression engine (DCE) contains
> dual hard slice DSC encoders so both share same base address but with
> its own different sub block address.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor question below.

> ---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h | 14 +++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  7 ++++++
>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   | 16 +++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h | 14 +++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 14 +++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 27 ++++++++++++++++++++--
>   6 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> index 4f6a965..f98c2a5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> @@ -153,6 +153,18 @@ static const struct dpu_merge_3d_cfg sm8350_merge_3d[] = {
>   	MERGE_3D_BLK("merge_3d_2", MERGE_3D_2, 0x50000),
>   };
>   
> +/*
> + * NOTE: Each display compression engine (DCE) contains dual hard
> + * slice DSC encoders so both share same base address but with
> + * its own different sub block address.
> + */
> +static const struct dpu_dsc_cfg sm8350_dsc[] = {
> +	DSC_BLK_1_2("dce_0", DSC_0, 0x80000, 0x100, 0, dsc_sblk_0),
> +	DSC_BLK_1_2("dce_0", DSC_1, 0x80000, 0x100, 0, dsc_sblk_1),
> +	DSC_BLK_1_2("dce_1", DSC_2, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_0),
> +	DSC_BLK_1_2("dce_1", DSC_3, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_1),
> +};
> +
>   static const struct dpu_intf_cfg sm8350_intf[] = {
>   	INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>   	INTF_BLK("intf_1", INTF_1, 0x35000, 0x2c4, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> @@ -205,6 +217,8 @@ const struct dpu_mdss_cfg dpu_sm8350_cfg = {
>   	.dspp = sm8350_dspp,
>   	.pingpong_count = ARRAY_SIZE(sm8350_pp),
>   	.pingpong = sm8350_pp,
> +	.dsc = sm8350_dsc,
> +	.dsc_count = ARRAY_SIZE(sm8350_dsc),
>   	.merge_3d_count = ARRAY_SIZE(sm8350_merge_3d),
>   	.merge_3d = sm8350_merge_3d,
>   	.intf_count = ARRAY_SIZE(sm8350_intf),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> index 6b2c7ea..3fd0498a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> @@ -93,6 +93,11 @@ static const struct dpu_pingpong_cfg sc7280_pp[] = {
>   	PP_BLK_DITHER("pingpong_3", PINGPONG_3, 0x6c000, 0, sc7280_pp_sblk, -1, -1),
>   };
>   
> +/* NOTE: sc7280 only has one dsc hard slice encoder */
> +static const struct dpu_dsc_cfg sc7280_dsc[] = {
> +	DSC_BLK_1_2("dce_0", DSC_0, 0x80000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_0),
> +};
> +
>   static const struct dpu_intf_cfg sc7280_intf[] = {
>   	INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>   	INTF_BLK("intf_1", INTF_1, 0x35000, 0x2c4, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> @@ -142,6 +147,8 @@ const struct dpu_mdss_cfg dpu_sc7280_cfg = {
>   	.mixer = sc7280_lm,
>   	.pingpong_count = ARRAY_SIZE(sc7280_pp),
>   	.pingpong = sc7280_pp,
> +	.dsc_count = ARRAY_SIZE(sc7280_dsc),
> +	.dsc = sc7280_dsc,
>   	.intf_count = ARRAY_SIZE(sc7280_intf),
>   	.intf = sc7280_intf,
>   	.vbif_count = ARRAY_SIZE(sdm845_vbif),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> index 706d0f1..ce583eb 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> @@ -141,6 +141,20 @@ static const struct dpu_merge_3d_cfg sc8280xp_merge_3d[] = {
>   	MERGE_3D_BLK("merge_3d_2", MERGE_3D_2, 0x50000),
>   };
>   
> +/*
> + * NOTE: Each display compression engine (DCE) contains dual hard
> + * slice DSC encoders so both share same base address but with
> + * its own different sub block address.
> + */
> +static const struct dpu_dsc_cfg sc8280xp_dsc[] = {
> +	DSC_BLK_1_2("dce_0", DSC_0, 0x80000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_0),
> +	DSC_BLK_1_2("dce_0", DSC_1, 0x80000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_1),
> +	DSC_BLK_1_2("dce_1", DSC_2, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_0),
> +	DSC_BLK_1_2("dce_1", DSC_3, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_1),
> +	DSC_BLK_1_2("dce_2", DSC_4, 0x82000, 0x100, 0, dsc_sblk_0),
> +	DSC_BLK_1_2("dce_2", DSC_5, 0x82000, 0x100, 0, dsc_sblk_1),

Just checking: all other platforms have non-422 encoders first, then the 
422-enabled ones. Is there any reason why this platform has them in the 
opposite order?

> +};
> +
>   /* TODO: INTF 3, 8 and 7 are used for MST, marked as INTF_NONE for now */
>   static const struct dpu_intf_cfg sc8280xp_intf[] = {
>   	INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> @@ -196,6 +210,8 @@ const struct dpu_mdss_cfg dpu_sc8280xp_cfg = {
>   	.dspp = sc8280xp_dspp,
>   	.pingpong_count = ARRAY_SIZE(sc8280xp_pp),
>   	.pingpong = sc8280xp_pp,
> +	.dsc = sc8280xp_dsc,
> +	.dsc_count = ARRAY_SIZE(sc8280xp_dsc),
>   	.merge_3d_count = ARRAY_SIZE(sc8280xp_merge_3d),
>   	.merge_3d = sc8280xp_merge_3d,
>   	.intf_count = ARRAY_SIZE(sc8280xp_intf),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
> index 4ecb3df..3950e7b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
> @@ -161,6 +161,18 @@ static const struct dpu_merge_3d_cfg sm8450_merge_3d[] = {
>   	MERGE_3D_BLK("merge_3d_3", MERGE_3D_3, 0x65f00),
>   };
>   
> +/*
> + * NOTE: Each display compression engine (DCE) contains dual hard
> + * slice DSC encoders so both share same base address but with
> + * its own different sub block address.
> + */
> +static const struct dpu_dsc_cfg sm8450_dsc[] = {
> +	DSC_BLK_1_2("dce_0", DSC_0, 0x80000, 0x100, 0, dsc_sblk_0),
> +	DSC_BLK_1_2("dce_0", DSC_1, 0x80000, 0x100, 0, dsc_sblk_1),
> +	DSC_BLK_1_2("dce_1", DSC_2, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_0),
> +	DSC_BLK_1_2("dce_1", DSC_3, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_1),
> +};
> +
>   static const struct dpu_intf_cfg sm8450_intf[] = {
>   	INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>   	INTF_BLK("intf_1", INTF_1, 0x35000, 0x300, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> @@ -213,6 +225,8 @@ const struct dpu_mdss_cfg dpu_sm8450_cfg = {
>   	.dspp = sm8450_dspp,
>   	.pingpong_count = ARRAY_SIZE(sm8450_pp),
>   	.pingpong = sm8450_pp,
> +	.dsc = sm8450_dsc,
> +	.dsc_count = ARRAY_SIZE(sm8450_dsc),
>   	.merge_3d_count = ARRAY_SIZE(sm8450_merge_3d),
>   	.merge_3d = sm8450_merge_3d,
>   	.intf_count = ARRAY_SIZE(sm8450_intf),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> index d0ab351..1b3f542 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> @@ -165,6 +165,18 @@ static const struct dpu_merge_3d_cfg sm8550_merge_3d[] = {
>   	MERGE_3D_BLK("merge_3d_3", MERGE_3D_3, 0x66700),
>   };
>   
> +/*
> + * NOTE: Each display compression engine (DCE) contains dual hard
> + * slice DSC encoders so both share same base address but with
> + * its own different sub block address.
> + */
> +static const struct dpu_dsc_cfg sm8550_dsc[] = {
> +	DSC_BLK_1_2("dce_0", DSC_0, 0x80000, 0x100, 0, dsc_sblk_0),
> +	DSC_BLK_1_2("dce_0", DSC_1, 0x80000, 0x100, 0, dsc_sblk_1),
> +	DSC_BLK_1_2("dce_1", DSC_2, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_0),
> +	DSC_BLK_1_2("dce_1", DSC_3, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), dsc_sblk_1),
> +};
> +
>   static const struct dpu_intf_cfg sm8550_intf[] = {
>   	INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>   	/* TODO TE sub-blocks for intf1 & intf2 */
> @@ -218,6 +230,8 @@ const struct dpu_mdss_cfg dpu_sm8550_cfg = {
>   	.dspp = sm8550_dspp,
>   	.pingpong_count = ARRAY_SIZE(sm8550_pp),
>   	.pingpong = sm8550_pp,
> +	.dsc = sm8550_dsc,
> +	.dsc_count = ARRAY_SIZE(sm8550_dsc),
>   	.merge_3d_count = ARRAY_SIZE(sm8550_merge_3d),
>   	.merge_3d = sm8550_merge_3d,
>   	.intf_count = ARRAY_SIZE(sm8550_intf),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 6ea1e9d..83c0cd9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022. Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #define pr_fmt(fmt)	"[drm:%s:%d] " fmt, __func__, __LINE__
> @@ -536,11 +536,34 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
>   /*************************************************************
>    * DSC sub blocks config
>    *************************************************************/
> +static const struct dpu_dsc_sub_blks dsc_sblk_0 = {
> +	.enc = {.base = 0x100, .len = 0x100},
> +	.ctl = {.base = 0xF00, .len = 0x10},
> +};
> +
> +static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
> +	.enc = {.base = 0x200, .len = 0x100},
> +	.ctl = {.base = 0xF80, .len = 0x10},
> +};
> +
>   #define DSC_BLK(_name, _id, _base, _features) \
>   	{\
>   	.name = _name, .id = _id, \
>   	.base = _base, .len = 0x140, \
> -	.features = _features, \
> +	.features = BIT(DPU_DSC_HW_REV_1_1) | _features, \
> +	}
> +
> +/*
> + * NOTE: Each display compression engine (DCE) contains dual hard
> + * slice DSC encoders so both share same base address but with
> + * its own different sub block address.
> + */
> +#define DSC_BLK_1_2(_name, _id, _base, _len, _features, _sblk) \
> +	{\
> +	.name = _name, .id = _id, \
> +	.base = _base, .len = _len, \
> +	.features = BIT(DPU_DSC_HW_REV_1_2) | _features, \
> +	.sblk = &_sblk, \
>   	}
>   
>   /*************************************************************

-- 
With best wishes
Dmitry

