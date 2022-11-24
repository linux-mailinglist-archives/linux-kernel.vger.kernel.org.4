Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C27636EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKXATT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKXATK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:19:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0661BBF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:19:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id d3so309167ljl.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZejUihPyJi5uFCGHrBzNO4EWo8XFZCAns+rd9g32pUM=;
        b=ag7A48mm2QjXFmhFfCW63ch9xxLA5CtmlMvYIqCf7cDxzYvIFHNrYjNBcOrsfGC3T1
         /HjI/iMGmjY015iCLS9w2qU5xfXgZCyEXSi9zScgFHspswOPJNWhDjtxMqhiTtchfs4D
         tv2IzoAtJ+a6yN7V/RVQCcxL/y9ss+5sat5/2Goezm7DKQ3ch/0NDBbjf/haI/SIMj5T
         +X7vSbboU7xSL7szg2oofm99+i2tTKM033NkblzF7MmXLDtS0Ux0RJtOJf2eDUZXFdmw
         uxhJh7VpoxK4sKhoRZHHpYe+fguSINDGwMEmrDOnMmK4tsrnAUkuz7IAcIGB9sWfDVnz
         leCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZejUihPyJi5uFCGHrBzNO4EWo8XFZCAns+rd9g32pUM=;
        b=zr84IeJS+lkqaGsPk6oa636Pj/gYzwYVkMiC41rlRXIW6gt+CcWmZ72jwq6gI/JGcw
         hOzXby98LHMqjO8u5LFTzfYIhSPCSXRzlMbVb6FyIUkSnn6bbN8A4mlnFf6FNvklrjLb
         rzoRtlpC83WtUzKY57BQKplJND5m9t1gqZ023w11JaV8q+NTPUJcHJvgzOk0I4v9G7UO
         FRjK9wQj6sc7f1jDrFo9HkN4aFX1z1GbYmwObdNW/N9HVUS1arpjK6hFuPrzLIVH1VEk
         HxbmhKXkG9VVUXRoHKS8Hx0oLhx8HwZsw/JIHA/RKhVHeqe2IcRzPuJC1Q3cdTvi7A5L
         OAIA==
X-Gm-Message-State: ANoB5pl15cWX+3paNyVA7Zr0e7O+RCbUjvn6iC7JUEeKfGbJ2dIRBX3w
        m4WiYwSO7M3td0sUWRHGN4+++w==
X-Google-Smtp-Source: AA0mqf5K//gFyF4qm5Al/mBOr1aB/eBQHMGuiDTzO6b6U30wsNJRexrsVmkzmS75Gg+iDuXCVjaTkw==
X-Received: by 2002:a2e:9d4:0:b0:279:7ff6:3162 with SMTP id 203-20020a2e09d4000000b002797ff63162mr765357ljj.250.1669249147360;
        Wed, 23 Nov 2022 16:19:07 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id a17-20020a2e9811000000b0026dc7b59d8esm2400057ljj.22.2022.11.23.16.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 16:19:06 -0800 (PST)
Message-ID: <0b9cd489-572c-e29c-0fc1-4cb960500b68@linaro.org>
Date:   Thu, 24 Nov 2022 01:19:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] drm/msm/disp/dpu1: add support for display on
 SM6115
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20221124001708.25720-1-a39.skl@gmail.com>
 <20221124001708.25720-3-a39.skl@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221124001708.25720-3-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.2022 01:16, Adam Skladowski wrote:
> Add required display hw catalog changes for SM6115.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 87 +++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  1 +
>  drivers/gpu/drm/msm/msm_mdss.c                |  5 ++
>  4 files changed, 94 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 3934d8976833..b4ca123d8e69 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -330,6 +330,18 @@ static const struct dpu_caps sc7180_dpu_caps = {
>  	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
>  };
>  
> +static const struct dpu_caps sm6115_dpu_caps = {
> +	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> +	.max_mixer_blendstages = 0x4,
> +	.qseed_type = DPU_SSPP_SCALER_QSEED3LITE,
> +	.smart_dma_rev = DPU_SSPP_SMART_DMA_V2, /* TODO: v2.5 */
> +	.ubwc_version = DPU_HW_UBWC_VER_20,
> +	.has_dim_layer = true,
> +	.has_idle_pc = true,
> +	.max_linewidth = 2160,
> +	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> +};
> +
>  static const struct dpu_caps sm8150_dpu_caps = {
>  	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
>  	.max_mixer_blendstages = 0xb,
> @@ -498,6 +510,19 @@ static const struct dpu_mdp_cfg sc8180x_mdp[] = {
>  	},
>  };
>  
> +static const struct dpu_mdp_cfg sm6115_mdp[] = {
> +	{
> +	.name = "top_0", .id = MDP_TOP,
> +	.base = 0x0, .len = 0x494,
> +	.features = 0,
> +	.highest_bank_bit = 0x1,
> +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
> +		.reg_off = 0x2ac, .bit_off = 0},
> +	.clk_ctrls[DPU_CLK_CTRL_DMA0] = {
> +		.reg_off = 0x2ac, .bit_off = 8},
> +	},
> +};
> +
>  static const struct dpu_mdp_cfg sm8250_mdp[] = {
>  	{
>  	.name = "top_0", .id = MDP_TOP,
> @@ -941,6 +966,16 @@ static const struct dpu_sspp_cfg sc7180_sspp[] = {
>  		sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>  };
>  
> +static const struct dpu_sspp_sub_blks sm6115_vig_sblk_0 =
> +				_VIG_SBLK("0", 2, DPU_SSPP_SCALER_QSEED3LITE);
> +
> +static const struct dpu_sspp_cfg sm6115_sspp[] = {
> +	SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SM8250_MASK,
> +		sm6115_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
> +	SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
> +		sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
> +};
> +
>  static const struct dpu_sspp_sub_blks sm8250_vig_sblk_0 =
>  				_VIG_SBLK("0", 5, DPU_SSPP_SCALER_QSEED3LITE);
>  static const struct dpu_sspp_sub_blks sm8250_vig_sblk_1 =
> @@ -1757,6 +1792,35 @@ static const struct dpu_perf_cfg sc7180_perf_data = {
>  	.bw_inefficiency_factor = 120,
>  };
>  
> +static const struct dpu_perf_cfg sm6115_perf_data = {
> +	.max_bw_low = 3100000,
> +	.max_bw_high = 4000000,
> +	.min_core_ib = 2400000,
> +	.min_llcc_ib = 800000,
> +	.min_dram_ib = 800000,
> +	.min_prefill_lines = 24,
> +	.danger_lut_tbl = {0xff, 0xffff, 0x0},
> +	.safe_lut_tbl = {0xfff0, 0xff00, 0xffff},
> +	.qos_lut_tbl = {
> +		{.nentry = ARRAY_SIZE(sc7180_qos_linear),
> +		.entries = sc7180_qos_linear
> +		},
> +		{.nentry = ARRAY_SIZE(sc7180_qos_macrotile),
> +		.entries = sc7180_qos_macrotile
> +		},
> +		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
> +		.entries = sc7180_qos_nrt
> +		},
> +		/* TODO: macrotile-qseed is different from macrotile */
> +	},
> +	.cdp_cfg = {
> +		{.rd_enable = 1, .wr_enable = 1},
> +		{.rd_enable = 1, .wr_enable = 0}
> +	},
> +	.clk_inefficiency_factor = 105,
> +	.bw_inefficiency_factor = 120,
> +};
> +
>  static const struct dpu_perf_cfg sm8150_perf_data = {
>  	.max_bw_low = 12800000,
>  	.max_bw_high = 12800000,
> @@ -1998,6 +2062,28 @@ static const struct dpu_mdss_cfg sc7180_dpu_cfg = {
>  	.mdss_irqs = IRQ_SC7180_MASK,
>  };
>  
> +static const struct dpu_mdss_cfg sm6115_dpu_cfg = {
> +	.caps = &sm6115_dpu_caps,
> +	.mdp_count = ARRAY_SIZE(sm6115_mdp),
> +	.mdp = sm6115_mdp,
> +	.ctl_count = ARRAY_SIZE(qcm2290_ctl),
> +	.ctl = qcm2290_ctl,
> +	.sspp_count = ARRAY_SIZE(sm6115_sspp),
> +	.sspp = sm6115_sspp,
> +	.mixer_count = ARRAY_SIZE(qcm2290_lm),
> +	.mixer = qcm2290_lm,
> +	.dspp_count = ARRAY_SIZE(qcm2290_dspp),
> +	.dspp = qcm2290_dspp,
> +	.pingpong_count = ARRAY_SIZE(qcm2290_pp),
> +	.pingpong = qcm2290_pp,
> +	.intf_count = ARRAY_SIZE(qcm2290_intf),
> +	.intf = qcm2290_intf,
> +	.vbif_count = ARRAY_SIZE(sdm845_vbif),
> +	.vbif = sdm845_vbif,
> +	.perf = &sm6115_perf_data,
> +	.mdss_irqs = IRQ_SC7180_MASK,
> +};
> +
>  static const struct dpu_mdss_cfg sm8150_dpu_cfg = {
>  	.caps = &sm8150_dpu_caps,
>  	.mdp_count = ARRAY_SIZE(sdm845_mdp),
> @@ -2158,6 +2244,7 @@ static const struct dpu_mdss_hw_cfg_handler cfg_handler[] = {
>  	{ .hw_rev = DPU_HW_VER_510, .dpu_cfg = &sc8180x_dpu_cfg},
>  	{ .hw_rev = DPU_HW_VER_600, .dpu_cfg = &sm8250_dpu_cfg},
>  	{ .hw_rev = DPU_HW_VER_620, .dpu_cfg = &sc7180_dpu_cfg},
> +	{ .hw_rev = DPU_HW_VER_630, .dpu_cfg = &sm6115_dpu_cfg},
>  	{ .hw_rev = DPU_HW_VER_650, .dpu_cfg = &qcm2290_dpu_cfg},
>  	{ .hw_rev = DPU_HW_VER_720, .dpu_cfg = &sc7280_dpu_cfg},
>  	{ .hw_rev = DPU_HW_VER_810, .dpu_cfg = &sm8450_dpu_cfg},
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index aa6c9ca99221..29e7ea5840a2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -44,6 +44,7 @@
>  #define DPU_HW_VER_510	DPU_HW_VER(5, 1, 1) /* sc8180 */
>  #define DPU_HW_VER_600	DPU_HW_VER(6, 0, 0) /* sm8250 */
>  #define DPU_HW_VER_620	DPU_HW_VER(6, 2, 0) /* sc7180 v1.0 */
> +#define DPU_HW_VER_630	DPU_HW_VER(6, 3, 0) /* sm6115|sm4250 */
>  #define DPU_HW_VER_650	DPU_HW_VER(6, 5, 0) /* qcm2290|sm4125 */
>  #define DPU_HW_VER_720	DPU_HW_VER(7, 2, 0) /* sc7280 */
>  #define DPU_HW_VER_810	DPU_HW_VER(8, 1, 0) /* sm8450 */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 69a86e87685c..38e63b19d930 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1299,6 +1299,7 @@ static const struct of_device_id dpu_dt_match[] = {
>  	{ .compatible = "qcom,sc7180-dpu", },
>  	{ .compatible = "qcom,sc7280-dpu", },
>  	{ .compatible = "qcom,sc8180x-dpu", },
> +	{ .compatible = "qcom,sm6115-dpu", },
>  	{ .compatible = "qcom,sm8150-dpu", },
>  	{ .compatible = "qcom,sm8250-dpu", },
>  	{ .compatible = "qcom,sm8450-dpu", },
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 5602fbaf6e0e..144c8dd82be1 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -280,6 +280,10 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
>  		/* UBWC_2_0 */
>  		msm_mdss_setup_ubwc_dec_20(msm_mdss, 0x1e);
>  		break;
> +	case DPU_HW_VER_630:
> +		/* UBWC_2_0 */
> +		msm_mdss_setup_ubwc_dec_20(msm_mdss, 0x11f);
> +		break;
>  	case DPU_HW_VER_720:
>  		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_3_0, 6, 1, 1, 1);
>  		break;
> @@ -513,6 +517,7 @@ static const struct of_device_id mdss_dt_match[] = {
>  	{ .compatible = "qcom,sc7180-mdss" },
>  	{ .compatible = "qcom,sc7280-mdss" },
>  	{ .compatible = "qcom,sc8180x-mdss" },
> +	{ .compatible = "qcom,sm6115-mdss" },
>  	{ .compatible = "qcom,sm8150-mdss" },
>  	{ .compatible = "qcom,sm8250-mdss" },
>  	{ .compatible = "qcom,sm8450-mdss" },
