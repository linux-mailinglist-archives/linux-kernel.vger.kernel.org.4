Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989C470AEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEUPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjEUPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:44:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA531E4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 08:44:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f1fe1208a4so5665019e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684683866; x=1687275866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8h0sYyAef3dfHw8SpLgoXEyeLwpA8w42Zq+I94cMJk=;
        b=RGGp5WoZeJwFow/zvn5fJTf6chrK3ARti5X6/fdIyoVFJf1itAuK5V0kO/WRcF9k94
         +xZzqWN3+DYoT5TBLe9yPJdsR0agrktVnHfcnKwhetdT1p163kj5RdfrQeN68MHXlV4p
         SG2qzdyJCfLOsm8kQhtOom4gsXirEhPq9GOHjEkJdkai26aSXCJtZ0rav9J6G3a1GwE5
         iBHVuWDBKCdUFH8qt0FPoZsFYix3XO2YVNQXnPOqsBdTCIMfHu5w0iXmv3zcJWQJjosi
         opE9JnYubvf4aEzMc2YV8/4WO+lcpc//7qqeqQ9lO2NzdishibANQpOH7S4tU056cCxe
         4dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684683866; x=1687275866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8h0sYyAef3dfHw8SpLgoXEyeLwpA8w42Zq+I94cMJk=;
        b=PKesxIir6DR/uYL03e5Xffz0uRbyaUN+UIUoli48aNrldlx3mLMNlV50qhah8ly2u7
         3S2yFKu+03hJXn8cQtD77xZo1U+LKMj8OIHZb2FPbKPeJy6AaqbybzljRO3GtS+uuddl
         iXyXIBRR+1iSGqYOn/WNLegttb8Pz7nckCSUZGuUUh4RCZWe0Luw1sEkeZqUbR0Ag017
         MizXSfUziI8wGeXWv9SyDUXBkfNUBskUJL07XyrmetsS4jfKvSOoR+eP8hsNPt7y1Qoj
         LsGvRw5n6bcGEkG1FUtKE7dd2Ck5BcjSfeegpx7oIbT9xtswe+lqMmmbPaCQ7tREADLv
         89ag==
X-Gm-Message-State: AC+VfDz+DxYtV2q1vmsmItMPISzI0X+RjuM/dFkvPvoCWvli2HW2pRvi
        GXXKkpZp1KbF51RCgWGz8KugEPXX9nhvFjkMS0Q=
X-Google-Smtp-Source: ACHHUZ6t2mVotRdAeTcFOz0sOX5GgUzQjzZJoRIccE969OzgFpD4NrmUaX4OvEcCVdq5v9F+NPsXig==
X-Received: by 2002:ac2:46ef:0:b0:4f3:a556:61b6 with SMTP id q15-20020ac246ef000000b004f3a55661b6mr2593863lfo.3.1684683865935;
        Sun, 21 May 2023 08:44:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v14-20020ac2560e000000b004f262997496sm659507lfd.76.2023.05.21.08.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 08:44:25 -0700 (PDT)
Message-ID: <16059762-e026-5970-1dac-b45f79d85bb8@linaro.org>
Date:   Sun, 21 May 2023 18:44:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 06/12] drm/msm/dpu: Add SM6350 support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-6-68e7e25d70e1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-6-68e7e25d70e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 20:04, Konrad Dybcio wrote:
> Add SM6350 support to the DPU1 driver to enable display output.
> 
> It's worth noting that one entry dpu_qos_lut_entry was trimmed off:
> 
> {.fl = 0, .lut = 0x0011223344556677 },
> 
> due to the fact that newer SoCs dropped the .fl (fill level)-based
> logic and don't provide real values, resulting in all entries but
> the last one being unused.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h | 188 +++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   5 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>   4 files changed, 195 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
> new file mode 100644
> index 000000000000..5d66a194155a
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
> @@ -0,0 +1,188 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022. Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef _DPU_6_4_SM6350_H
> +#define _DPU_6_4_SM6350_H
> +
> +static const struct dpu_caps sm6350_dpu_caps = {
> +	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> +	.max_mixer_blendstages = 0x7,
> +	.qseed_type = DPU_SSPP_SCALER_QSEED4,
> +	.has_src_split = true,
> +	.has_dim_layer = true,
> +	.has_idle_pc = true,
> +	.max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> +	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> +};
> +
> +static const struct dpu_ubwc_cfg sm6350_ubwc_cfg = {
> +	.ubwc_version = DPU_HW_UBWC_VER_20,
> +	.ubwc_swizzle = 6,
> +	.highest_bank_bit = 1,
> +};
> +
> +static const struct dpu_mdp_cfg sm6350_mdp[] = {
> +	{
> +	.name = "top_0", .id = MDP_TOP,
> +	.base = 0x0, .len = 0x494,
> +	.features = 0,
> +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
> +	.clk_ctrls[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
> +	.clk_ctrls[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
> +	.clk_ctrls[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2c4, .bit_off = 8 },
> +	.clk_ctrls[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
> +	},
> +};
> +
> +static const struct dpu_ctl_cfg sm6350_ctl[] = {
> +	{
> +	.name = "ctl_0", .id = CTL_0,
> +	.base = 0x1000, .len = 0x1dc,
> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
> +	},
> +	{
> +	.name = "ctl_1", .id = CTL_1,
> +	.base = 0x1200, .len = 0x1dc,
> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
> +	},
> +	{
> +	.name = "ctl_2", .id = CTL_2,
> +	.base = 0x1400, .len = 0x1dc,
> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
> +	},
> +	{
> +	.name = "ctl_3", .id = CTL_3,
> +	.base = 0x1600, .len = 0x1dc,
> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
> +	},
> +};
> +
> +static const struct dpu_sspp_cfg sm6350_sspp[] = {
> +	SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SC7180_MASK,
> +		sc7180_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
> +	SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
> +		sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
> +	SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1f8, DMA_CURSOR_SDM845_MASK,
> +		sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
> +	SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1f8, DMA_CURSOR_SDM845_MASK,
> +		sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA2),
> +};
> +
> +static const struct dpu_lm_cfg sm6350_lm[] = {
> +	LM_BLK("lm_0", LM_0, 0x44000, MIXER_SDM845_MASK,
> +		&sc7180_lm_sblk, PINGPONG_0, LM_1, DSPP_0),
> +	LM_BLK("lm_1", LM_1, 0x45000, MIXER_SDM845_MASK,
> +		&sc7180_lm_sblk, PINGPONG_1, LM_0, 0),
> +};
> +
> +static const struct dpu_dspp_cfg sm6350_dspp[] = {
> +	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
> +		&sm8150_dspp_sblk),
> +};
> +
> +static struct dpu_pingpong_cfg sm6350_pp[] = {
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK, 0, sdm845_pp_sblk,
> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +		-1),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK, 0, sdm845_pp_sblk,
> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +		-1),
> +};
> +
> +static const struct dpu_intf_cfg sm6350_intf[] = {
> +	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x2c0, INTF_DP, 0, 35, INTF_SC7180_MASK,

I think the length here should be 0x280, it doesn't have TE block.

> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25)),
> +	INTF_BLK_DSI_TE("intf_1", INTF_1, 0x6a800, 0x2c0, INTF_DSI, 0, 35, INTF_SC7180_MASK,
> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
> +		DPU_IRQ_IDX(MDP_INTF1_TEAR_INTR, 2)),
> +};
> +
> +static const struct dpu_vbif_cfg sm6350_vbif[] = {

Please use sdm845_vbif instead

> +	{
> +	.name = "vbif_0", .id = VBIF_RT,
> +	.base = 0, .len = 0x1044,
> +	.features = BIT(DPU_VBIF_QOS_REMAP),
> +	.xin_halt_timeout = 0x4000,
> +	.qos_rt_tbl = {
> +		.npriority_lvl = ARRAY_SIZE(sdm845_rt_pri_lvl),
> +		.priority_lvl = sdm845_rt_pri_lvl,
> +	},
> +	.qos_nrt_tbl = {
> +		.npriority_lvl = ARRAY_SIZE(sdm845_nrt_pri_lvl),
> +		.priority_lvl = sdm845_nrt_pri_lvl,
> +	},
> +	.memtype_count = 14,
> +	.memtype = {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
> +	},
> +};
> +
> +static const struct dpu_perf_cfg sm6350_perf_data = {
> +	.max_bw_low = 4200000,
> +	.max_bw_high = 5100000,
> +	.min_core_ib = 2500000,
> +	.min_llcc_ib = 0,
> +	.min_dram_ib = 1600000,
> +	.min_prefill_lines = 35,
> +	/* TODO: confirm danger_lut_tbl */
> +	.danger_lut_tbl = {0xffff, 0xffff, 0x0},
> +	.safe_lut_tbl = {0xff00, 0xff00, 0xffff},
> +	.qos_lut_tbl = {
> +		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
> +		.entries = sm6350_qos_linear_macrotile
> +		},
> +		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
> +		.entries = sm6350_qos_linear_macrotile
> +		},
> +		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
> +		.entries = sc7180_qos_nrt
> +		},
> +	},
> +	.cdp_cfg = {
> +		{.rd_enable = 1, .wr_enable = 1},
> +		{.rd_enable = 1, .wr_enable = 0}
> +	},
> +	.clk_inefficiency_factor = 105,
> +	.bw_inefficiency_factor = 120,
> +};
> +
> +const struct dpu_mdss_cfg dpu_sm6350_cfg = {
> +	.caps = &sm6350_dpu_caps,
> +	.ubwc = &sm6350_ubwc_cfg,
> +	.mdp_count = ARRAY_SIZE(sm6350_mdp),
> +	.mdp = sm6350_mdp,
> +	.ctl_count = ARRAY_SIZE(sm6350_ctl),
> +	.ctl = sm6350_ctl,
> +	.sspp_count = ARRAY_SIZE(sm6350_sspp),
> +	.sspp = sm6350_sspp,
> +	.mixer_count = ARRAY_SIZE(sm6350_lm),
> +	.mixer = sm6350_lm,
> +	.dspp_count = ARRAY_SIZE(sm6350_dspp),
> +	.dspp = sm6350_dspp,
> +	.pingpong_count = ARRAY_SIZE(sm6350_pp),
> +	.pingpong = sm6350_pp,
> +	.intf_count = ARRAY_SIZE(sm6350_intf),
> +	.intf = sm6350_intf,
> +	.vbif_count = ARRAY_SIZE(sm6350_vbif),
> +	.vbif = sm6350_vbif,
> +	.reg_dma_count = 1,
> +	.dma_cfg = &sm8250_regdma,
> +	.perf = &sm6350_perf_data,
> +	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
> +		     BIT(MDP_SSPP_TOP0_INTR2) | \
> +		     BIT(MDP_SSPP_TOP0_HIST_INTR) | \
> +		     BIT(MDP_INTF0_INTR) | \
> +		     BIT(MDP_INTF1_INTR) | \
> +		     BIT(MDP_INTF1_TEAR_INTR),
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 9daeaccc4f52..5ef1dffc27dc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -748,6 +748,10 @@ static const struct dpu_qos_lut_entry sc7180_qos_linear[] = {
>   	{.fl = 0, .lut = 0x0011222222335777},
>   };
>   
> +static const struct dpu_qos_lut_entry sm6350_qos_linear_macrotile[] = {
> +	{.fl = 0, .lut = 0x0011223445566777 },
> +};
> +
>   static const struct dpu_qos_lut_entry sm8150_qos_linear[] = {
>   	{.fl = 0, .lut = 0x0011222222223357 },
>   };
> @@ -803,6 +807,7 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
>   #include "catalog/dpu_6_0_sm8250.h"
>   #include "catalog/dpu_6_2_sc7180.h"
>   #include "catalog/dpu_6_3_sm6115.h"
> +#include "catalog/dpu_6_4_sm6350.h"
>   #include "catalog/dpu_6_5_qcm2290.h"
>   
>   #include "catalog/dpu_7_0_sm8350.h"
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index e9237321df77..67ff78e7bc99 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -880,6 +880,7 @@ extern const struct dpu_mdss_cfg dpu_sc8180x_cfg;
>   extern const struct dpu_mdss_cfg dpu_sm8250_cfg;
>   extern const struct dpu_mdss_cfg dpu_sc7180_cfg;
>   extern const struct dpu_mdss_cfg dpu_sm6115_cfg;
> +extern const struct dpu_mdss_cfg dpu_sm6350_cfg;
>   extern const struct dpu_mdss_cfg dpu_qcm2290_cfg;
>   extern const struct dpu_mdss_cfg dpu_sm8350_cfg;
>   extern const struct dpu_mdss_cfg dpu_sc7280_cfg;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 0e7a68714e9e..46be7ad8d615 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1286,6 +1286,7 @@ static const struct of_device_id dpu_dt_match[] = {
>   	{ .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg, },
>   	{ .compatible = "qcom,sc8280xp-dpu", .data = &dpu_sc8280xp_cfg, },
>   	{ .compatible = "qcom,sm6115-dpu", .data = &dpu_sm6115_cfg, },
> +	{ .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg, },
>   	{ .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg, },
>   	{ .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg, },
>   	{ .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg, },
> 

-- 
With best wishes
Dmitry

