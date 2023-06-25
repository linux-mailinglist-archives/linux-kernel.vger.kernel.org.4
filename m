Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE073D398
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFYUTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjFYUTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:19:53 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9419A;
        Sun, 25 Jun 2023 13:19:51 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id EC8BD1F65D;
        Sun, 25 Jun 2023 22:19:48 +0200 (CEST)
Date:   Sun, 25 Jun 2023 22:19:47 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH 08/15] drm/msm/dpu: Add SM6125 support
Message-ID: <eeyexowcbjmqpmw6xps6ewczamehhyopjkvd2tg72soirpla2r@ydtuxti4r6xk>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-8-1d5a638cebf2@somainline.org>
 <d836cdaa-7d67-82b1-baa6-6d2f8c761b1a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d836cdaa-7d67-82b1-baa6-6d2f8c761b1a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-24 03:47:27, Konrad Dybcio wrote:
> On 24.06.2023 02:41, Marijn Suijten wrote:
> > Add definitions for the display hardware used on the Qualcomm SM6125
> > platform.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> [...]
> 
> > +static const struct dpu_perf_cfg sm6125_perf_data = {
> > +	.max_bw_low = 4100000,
> > +	.max_bw_high = 4100000,
> > +	.min_core_ib = 2400000,
> > +	.min_llcc_ib = 800000,
> While Dmitry will likely validate other values

Lovely.

> I can tell you already that this SoC has no LLCC.

Copy-paste error on downstream?

https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/LA.UM.9.11.c25/arch/arm64/boot/dts/qcom/trinket-sde.dtsi#L146

- Marijn

> 
> Konrad
> > +	.min_dram_ib = 800000,
> > +	.min_prefill_lines = 24,
> > +	.danger_lut_tbl = {0xf, 0xffff, 0x0},
> > +	.safe_lut_tbl = {0xfff8, 0xf000, 0xffff},
> > +	.qos_lut_tbl = {
> > +		{.nentry = ARRAY_SIZE(sm8150_qos_linear),
> > +		.entries = sm8150_qos_linear
> > +		},
> > +		{.nentry = ARRAY_SIZE(sc7180_qos_macrotile),
> > +		.entries = sc7180_qos_macrotile
> > +		},
> > +		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
> > +		.entries = sc7180_qos_nrt
> > +		},
> > +		/* TODO: macrotile-qseed is different from macrotile */
> > +	},
> > +	.cdp_cfg = {
> > +		{.rd_enable = 1, .wr_enable = 1},
> > +		{.rd_enable = 1, .wr_enable = 0}
> > +	},
> > +	.clk_inefficiency_factor = 105,
> > +	.bw_inefficiency_factor = 120,
> > +};
> > +
> > +const struct dpu_mdss_cfg dpu_sm6125_cfg = {
> > +	.caps = &sm6125_dpu_caps,
> > +	.ubwc = &sm6125_ubwc_cfg,
> > +	.mdp_count = ARRAY_SIZE(sm6125_mdp),
> > +	.mdp = sm6125_mdp,
> > +	.ctl_count = ARRAY_SIZE(sm6125_ctl),
> > +	.ctl = sm6125_ctl,
> > +	.sspp_count = ARRAY_SIZE(sm6125_sspp),
> > +	.sspp = sm6125_sspp,
> > +	.mixer_count = ARRAY_SIZE(sm6125_lm),
> > +	.mixer = sm6125_lm,
> > +	.dspp_count = ARRAY_SIZE(sm6125_dspp),
> > +	.dspp = sm6125_dspp,
> > +	.pingpong_count = ARRAY_SIZE(sm6125_pp),
> > +	.pingpong = sm6125_pp,
> > +	.intf_count = ARRAY_SIZE(sm6125_intf),
> > +	.intf = sm6125_intf,
> > +	.vbif_count = ARRAY_SIZE(sdm845_vbif),
> > +	.vbif = sdm845_vbif,
> > +	.perf = &sm6125_perf_data,
> > +	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
> > +		     BIT(MDP_SSPP_TOP0_INTR2) | \
> > +		     BIT(MDP_SSPP_TOP0_HIST_INTR) | \
> > +		     BIT(MDP_INTF0_INTR) | \
> > +		     BIT(MDP_INTF1_INTR) | \
> > +		     BIT(MDP_INTF1_TEAR_INTR),
> > +};
> > +
> > +#endif
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > index 0de507d4d7b7..8a02bbdaae8a 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > @@ -33,6 +33,9 @@
> >  #define VIG_SC7180_MASK \
> >  	(VIG_MASK | BIT(DPU_SSPP_QOS_8LVL) | BIT(DPU_SSPP_SCALER_QSEED4))
> >  
> > +#define VIG_SM6125_MASK \
> > +	(VIG_MASK | BIT(DPU_SSPP_QOS_8LVL) | BIT(DPU_SSPP_SCALER_QSEED3LITE))
> > +
> >  #define VIG_SC7180_MASK_SDMA \
> >  	(VIG_SC7180_MASK | BIT(DPU_SSPP_SMART_DMA_V2))
> >  
> > @@ -348,6 +351,8 @@ static const struct dpu_sspp_sub_blks sc7280_vig_sblk_0 =
> >  
> >  static const struct dpu_sspp_sub_blks sm6115_vig_sblk_0 =
> >  				_VIG_SBLK("0", 2, DPU_SSPP_SCALER_QSEED4);
> > +static const struct dpu_sspp_sub_blks sm6125_vig_sblk_0 =
> > +				_VIG_SBLK("0", 3, DPU_SSPP_SCALER_QSEED3LITE);
> >  
> >  static const struct dpu_sspp_sub_blks sm8250_vig_sblk_0 =
> >  				_VIG_SBLK("0", 5, DPU_SSPP_SCALER_QSEED4);
> > @@ -762,6 +767,7 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
> >  
> >  #include "catalog/dpu_5_0_sm8150.h"
> >  #include "catalog/dpu_5_1_sc8180x.h"
> > +#include "catalog/dpu_5_4_sm6125.h"
> >  
> >  #include "catalog/dpu_6_0_sm8250.h"
> >  #include "catalog/dpu_6_2_sc7180.h"
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > index b860784ade72..4314235cb2b8 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > @@ -861,6 +861,7 @@ extern const struct dpu_mdss_cfg dpu_sc8180x_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sm8250_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sc7180_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sm6115_cfg;
> > +extern const struct dpu_mdss_cfg dpu_sm6125_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sm6350_cfg;
> >  extern const struct dpu_mdss_cfg dpu_qcm2290_cfg;
> >  extern const struct dpu_mdss_cfg dpu_sm6375_cfg;
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > index aa8499de1b9f..a1c7ffb6dffb 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> > @@ -1305,6 +1305,7 @@ static const struct of_device_id dpu_dt_match[] = {
> >  	{ .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg, },
> >  	{ .compatible = "qcom,sc8280xp-dpu", .data = &dpu_sc8280xp_cfg, },
> >  	{ .compatible = "qcom,sm6115-dpu", .data = &dpu_sm6115_cfg, },
> > +	{ .compatible = "qcom,sm6125-dpu", .data = &dpu_sm6125_cfg, },
> >  	{ .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg, },
> >  	{ .compatible = "qcom,sm6375-dpu", .data = &dpu_sm6375_cfg, },
> >  	{ .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg, },
> > 
