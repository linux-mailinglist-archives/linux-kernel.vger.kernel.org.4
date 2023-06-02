Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7E71FCD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjFBI5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjFBI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:56:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136BA10FC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:56:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af2db78b38so24650921fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696182; x=1688288182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrpidZdFlKb1peCnBOGzyHQ66vMzewHGJSI8Eoy2cco=;
        b=rpOG+boljts3dlGY1vcrvZpSiu7Kf8GgwnVFrPvlpM7MJJ6fr6sOh/KOmEFZKG246F
         iDJ/cVwpzw+fNS9JeaLMRUlPCul6ZvlKcW+VWXjf9L5jod6A9f0Wvc+9wH/54Os+qFuw
         ThfiOYsHP/XEZ9a+6nN67ih+y6decEC5ohFJXQl0zP+gcMzfm//4lC5jNQcgFbtWRjne
         bmHoaNucTB5mSj+8afIeEem5AA6y8fir+91Lh6uMnZXUJwbuOhGIR44pgEZdGc2O9k3r
         nuNGYRHKRn7lbZPzeWGPq5cFRiXPO+O4Tu1fxG0OBO+GxqLcETOCATf1l99+aXDxKAP2
         kGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696182; x=1688288182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrpidZdFlKb1peCnBOGzyHQ66vMzewHGJSI8Eoy2cco=;
        b=Rdtfx3C+KBGeX52ZJFuh/qj+nqhalE3FzZ0piYU4OLMjystlsiBv8EW8zZ1dJvMkBP
         A5WzIa8zd0MRK8KPzxXgUgDoGhMoZxQG0ooHEIJ4JWtaIQuoD/2Ra8AuFcubRiQiYbZn
         Z+QK+ZawQ9vPV+3APH8G0Aq6YHRuizA81P7IdvYWr//LXsBeRCVM5OqRLj7zl0lT5Rvp
         1mda+rdNxKQyti5IVngjsqRnyCOq0JPeoKWlvVmxNJGbn0lLmaL6rN36DcOetHU77Bdk
         xTjCuwrL4tLcNU8OWcCLO6B36BFIFleDVzpLiv3MMrdkCyCb2FoyHxpnJkrQ6st4AWoQ
         picQ==
X-Gm-Message-State: AC+VfDziA6gj+2SlibUsrPRu77xcbU+fbNArI+iJ2gSDCD78lfyQ8MWC
        opiMBqEGRYzb6qhMcOYhAYOg9g==
X-Google-Smtp-Source: ACHHUZ4l0ApT7LocfRdhMrG29TGzSsXg8GfH5Tp8aoqG+hzm7uAHxtZ8mpFbDowbBLab5puiE7RKBA==
X-Received: by 2002:a2e:9d58:0:b0:2af:1e55:1290 with SMTP id y24-20020a2e9d58000000b002af1e551290mr1047214ljj.46.1685696182133;
        Fri, 02 Jun 2023 01:56:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e82d5000000b002a8c1462ecbsm142980ljh.137.2023.06.02.01.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:56:21 -0700 (PDT)
Message-ID: <3ef05642-08e4-5347-10da-38f50d9c818f@linaro.org>
Date:   Fri, 2 Jun 2023 10:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 08/12] drm/msm/dpu: Add SM6375 support
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-8-998b4d2f7dd1@linaro.org>
 <h56lpxfxujaia6jfgvbpu2dp3dqdilaormxr5plms44vev2qdf@qhkrsuhlarga>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <h56lpxfxujaia6jfgvbpu2dp3dqdilaormxr5plms44vev2qdf@qhkrsuhlarga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 16:56, Marijn Suijten wrote:
> On 2023-05-23 09:46:19, Konrad Dybcio wrote:
>> Add basic SM6375 support to the DPU1 driver to enable display output.
> 
> Nit: The SM6350 commit doesn't use the word "basic" here: what does it
> mean?  Is this addition not complete (because it seems so)?
Well the 6350 commit dates back to 2021 and we didn't have INTF_TE or
DSC back then, so it's possible I had that in mind..

Konrad
> 
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h | 139 +++++++++++++++++++++
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>>  4 files changed, 142 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
>> new file mode 100644
>> index 000000000000..924f2526c06a
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
>> @@ -0,0 +1,139 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022. Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Linaro Limited
>> + */
>> +
>> +#ifndef _DPU_6_9_SM6375_H
>> +#define _DPU_6_9_SM6375_H
>> +
>> +static const struct dpu_caps sm6375_dpu_caps = {
>> +	.max_mixer_width = DEFAULT_DPU_LINE_WIDTH,
>> +	.max_mixer_blendstages = 0x4,
>> +	.qseed_type = DPU_SSPP_SCALER_QSEED4,
>> +	.has_dim_layer = true,
>> +	.has_idle_pc = true,
>> +	.max_linewidth = 2160,
>> +	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
>> +};
>> +
>> +static const struct dpu_ubwc_cfg sm6375_ubwc_cfg = {
>> +	.ubwc_version = DPU_HW_UBWC_VER_20,
>> +	.ubwc_swizzle = 6,
>> +	.highest_bank_bit = 1,
>> +};
>> +
>> +static const struct dpu_mdp_cfg sm6375_mdp[] = {
>> +	{
>> +	.name = "top_0", .id = MDP_TOP,
>> +	.base = 0x0, .len = 0x494,
>> +	.features = 0,
>> +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
>> +	.clk_ctrls[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
>> +	},
>> +};
>> +
>> +static const struct dpu_ctl_cfg sm6375_ctl[] = {
>> +	{
>> +	.name = "ctl_0", .id = CTL_0,
>> +	.base = 0x1000, .len = 0x1dc,
>> +	.features = BIT(DPU_CTL_ACTIVE_CFG),
>> +	.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
>> +	},
>> +};
>> +
>> +static const struct dpu_sspp_cfg sm6375_sspp[] = {
>> +	SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SC7180_MASK,
>> +		sm6115_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> +	SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
>> +		sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> +};
>> +
>> +static const struct dpu_lm_cfg sm6375_lm[] = {
>> +	LM_BLK("lm_0", LM_0, 0x44000, MIXER_QCM2290_MASK,
>> +		&qcm2290_lm_sblk, PINGPONG_0, 0, DSPP_0),
>> +};
>> +
>> +static const struct dpu_dspp_cfg sm6375_dspp[] = {
>> +	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
>> +		&sm8150_dspp_sblk),
>> +};
>> +
>> +static const struct dpu_pingpong_cfg sm6375_pp[] = {
>> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK, 0, sdm845_pp_sblk,
>> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>> +		-1),
>> +};
>> +
>> +static const struct dpu_dsc_cfg sm6375_dsc[] = {
>> +	DSC_BLK("dsc_0", DSC_0, 0x80000, BIT(DPU_DSC_OUTPUT_CTRL)),
>> +};
>> +
>> +static const struct dpu_intf_cfg sm6375_intf[] = {
>> +	INTF_BLK("intf_0", INTF_0, 0x00000, 0x280, INTF_NONE, 0, 0, 0, 0, 0),
>> +	INTF_BLK_DSI_TE("intf_1", INTF_1, 0x6a800, 0x2c0, INTF_DSI, 0, 24, INTF_SC7280_MASK,
> 
> Did you forget to set this back to SC7180?  This will be enabling
> DPU_INTF_DATA_COMPRESS otherwise, which is a DPU 7.x feature.
> 
> - Marijn
> 
>> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
>> +		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
>> +		DPU_IRQ_IDX(MDP_INTF1_TEAR_INTR, 2)),
>> +};
>> +
>> +static const struct dpu_perf_cfg sm6375_perf_data = {
>> +	.max_bw_low = 5200000,
>> +	.max_bw_high = 6200000,
>> +	.min_core_ib = 2500000,
>> +	.min_llcc_ib = 0, /* No LLCC on this SoC */
>> +	.min_dram_ib = 1600000,
>> +	.min_prefill_lines = 24,
>> +	/* TODO: confirm danger_lut_tbl */
>> +	.danger_lut_tbl = {0xffff, 0xffff, 0x0},
>> +	.safe_lut_tbl = {0xfe00, 0xfe00, 0xffff},
>> +	.qos_lut_tbl = {
>> +		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
>> +		.entries = sm6350_qos_linear_macrotile
>> +		},
>> +		{.nentry = ARRAY_SIZE(sm6350_qos_linear_macrotile),
>> +		.entries = sm6350_qos_linear_macrotile
>> +		},
>> +		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
>> +		.entries = sc7180_qos_nrt
>> +		},
>> +	},
>> +	.cdp_cfg = {
>> +		{.rd_enable = 1, .wr_enable = 1},
>> +		{.rd_enable = 1, .wr_enable = 0}
>> +	},
>> +	.clk_inefficiency_factor = 105,
>> +	.bw_inefficiency_factor = 120,
>> +};
>> +
>> +const struct dpu_mdss_cfg dpu_sm6375_cfg = {
>> +	.caps = &sm6375_dpu_caps,
>> +	.ubwc = &sm6375_ubwc_cfg,
>> +	.mdp_count = ARRAY_SIZE(sm6375_mdp),
>> +	.mdp = sm6375_mdp,
>> +	.ctl_count = ARRAY_SIZE(sm6375_ctl),
>> +	.ctl = sm6375_ctl,
>> +	.sspp_count = ARRAY_SIZE(sm6375_sspp),
>> +	.sspp = sm6375_sspp,
>> +	.mixer_count = ARRAY_SIZE(sm6375_lm),
>> +	.mixer = sm6375_lm,
>> +	.dspp_count = ARRAY_SIZE(sm6375_dspp),
>> +	.dspp = sm6375_dspp,
>> +	.dsc_count = ARRAY_SIZE(sm6375_dsc),
>> +	.dsc = sm6375_dsc,
>> +	.pingpong_count = ARRAY_SIZE(sm6375_pp),
>> +	.pingpong = sm6375_pp,
>> +	.intf_count = ARRAY_SIZE(sm6375_intf),
>> +	.intf = sm6375_intf,
>> +	.vbif_count = ARRAY_SIZE(sdm845_vbif),
>> +	.vbif = sdm845_vbif,
>> +	.perf = &sm6375_perf_data,
>> +	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
>> +		     BIT(MDP_SSPP_TOP0_INTR2) | \
>> +		     BIT(MDP_SSPP_TOP0_HIST_INTR) | \
>> +		     BIT(MDP_INTF1_INTR) | \
>> +		     BIT(MDP_INTF1_TEAR_INTR),
>> +};
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 6e338d569632..7cfdcf7aa486 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -750,6 +750,7 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
>>  #include "catalog/dpu_6_3_sm6115.h"
>>  #include "catalog/dpu_6_4_sm6350.h"
>>  #include "catalog/dpu_6_5_qcm2290.h"
>> +#include "catalog/dpu_6_9_sm6375.h"
>>  
>>  #include "catalog/dpu_7_0_sm8350.h"
>>  #include "catalog/dpu_7_2_sc7280.h"
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> index ed4311f6aaf0..b84c14318449 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> @@ -836,6 +836,7 @@ extern const struct dpu_mdss_cfg dpu_sc7180_cfg;
>>  extern const struct dpu_mdss_cfg dpu_sm6115_cfg;
>>  extern const struct dpu_mdss_cfg dpu_sm6350_cfg;
>>  extern const struct dpu_mdss_cfg dpu_qcm2290_cfg;
>> +extern const struct dpu_mdss_cfg dpu_sm6375_cfg;
>>  extern const struct dpu_mdss_cfg dpu_sm8350_cfg;
>>  extern const struct dpu_mdss_cfg dpu_sc7280_cfg;
>>  extern const struct dpu_mdss_cfg dpu_sc8280xp_cfg;
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index d9925097626c..d3ca8c3c808c 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -1329,6 +1329,7 @@ static const struct of_device_id dpu_dt_match[] = {
>>  	{ .compatible = "qcom,sc8280xp-dpu", .data = &dpu_sc8280xp_cfg, },
>>  	{ .compatible = "qcom,sm6115-dpu", .data = &dpu_sm6115_cfg, },
>>  	{ .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg, },
>> +	{ .compatible = "qcom,sm6375-dpu", .data = &dpu_sm6375_cfg, },
>>  	{ .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg, },
>>  	{ .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg, },
>>  	{ .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg, },
>>
>> -- 
>> 2.40.1
>>
