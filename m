Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD67147DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjE2KZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjE2KZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:25:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76574C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:25:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2b74d258so32536281fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685355918; x=1687947918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZdc6i5z2R/+Y9/ZFuY2y7w4jz+QILDjulsUhtAyGX4=;
        b=QNCnfs6uHjOyrcMnfQ8vqUApOV5PYhd2YixOtZ7ZLvFcGAb6Pb0aoP3puWryA+eRMF
         OJ+TttCaALibGx5g/3d20G59+wyTb4AcAIYonXNHlIGNNSvcA6etaisqMX/KFPN8LdOi
         u45uXcF9YqwZpUIKi5nbVvyfNtY7dC1jiUf+KzlOYXTKTvtyrAuzPLjdnouSQ3J+/7PR
         U9Fx1vCsn9yIS6lHP631N6DB/5W0s+QezhHySMggtRmrAAinkVQ1oeNq6eaBWORj6ntF
         wGlq3kjjX1JnvGuIJ4CZNUXMTni0jXDlxQbvqRZkkRe6cLMIt+zwWHBlUzKOeT7hYcJk
         JR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685355918; x=1687947918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZdc6i5z2R/+Y9/ZFuY2y7w4jz+QILDjulsUhtAyGX4=;
        b=ApXUSP8F6LqOwsyq5k0ytHLttYegkJ1YFtKMpzLm1hPIYZMaWWMxwIkRqY6QuZGTse
         c8wPrkbN3N7IAkyK/uVAv0Ch5cF6VYJ5A2+nvyiUpsKQyZOEGd+HKXlDy6RvpUmkg6Gd
         Mot7eJWl7fJ2JPzmFvsO/eB23X7svavR2J/KqDhp1Tv0lJN66eejJ/1Irmrvu8emgXRV
         dkyhpe29juFSRGpT92FndPnWoKd39vfNIHB/C63rblJOKwSg5+Xw4rx43FrZqsCXY2wI
         Wh4bdEJTjnXF9UtaEVrbjpvRIC+lVp1NnGaWae/bSfzyf+n76eKvzFCYlMVvVvGUBJXg
         vhdg==
X-Gm-Message-State: AC+VfDwMqJeYg+tMYqABWO6tmQ521S0xBNGXOQoXfTqoSJa2ZP2/7nRo
        DJv6kYwDYfnlBmOOVrFJF6mJMg==
X-Google-Smtp-Source: ACHHUZ4vIs5yH8NjfN0Nkf8gbyCGQ+5UHb7B/5mHAM8XHR9LNDJubjGFpITvbLKj2kdYgWG0sTKPqA==
X-Received: by 2002:ac2:593b:0:b0:4f4:e26c:644c with SMTP id v27-20020ac2593b000000b004f4e26c644cmr3364039lfi.68.1685355917693;
        Mon, 29 May 2023 03:25:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id i20-20020ac25234000000b004e887fd71acsm1905505lfl.236.2023.05.29.03.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 03:25:17 -0700 (PDT)
Message-ID: <ef8e2090-7e55-14c1-1472-cee7c0ee66ea@linaro.org>
Date:   Mon, 29 May 2023 12:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/7] drm/msm/dsi: Add phy configuration for MSM8226
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-6-679f335d3d5b@z3ntu.xyz>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230308-msm8226-mdp-v1-6-679f335d3d5b@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
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



On 29.05.2023 11:44, Luca Weiss wrote:
> MSM8226 uses a modified PLL lock sequence compared to MSM8974, which is
> based on the function dsi_pll_enable_seq_m in the msm-3.10 kernel.
> 
> Worth noting that the msm-3.10 downstream kernel also will try other
> sequences in case this one doesn't work, but during testing it has shown
> that the _m sequence succeeds first time also:
> 
>   .pll_enable_seqs[0] = dsi_pll_enable_seq_m,
>   .pll_enable_seqs[1] = dsi_pll_enable_seq_m,
>   .pll_enable_seqs[2] = dsi_pll_enable_seq_d,
>   .pll_enable_seqs[3] = dsi_pll_enable_seq_d,
>   .pll_enable_seqs[4] = dsi_pll_enable_seq_f1,
>   .pll_enable_seqs[5] = dsi_pll_enable_seq_c,
>   .pll_enable_seqs[6] = dsi_pll_enable_seq_e,
> 
> We may need to expand this in the future.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c      |  2 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h      |  3 +-
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 97 ++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index bb09cbe8ff86..9d5795c58a98 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -541,6 +541,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
>  	  .data = &dsi_phy_28nm_hpm_famb_cfgs },
>  	{ .compatible = "qcom,dsi-phy-28nm-lp",
>  	  .data = &dsi_phy_28nm_lp_cfgs },
> +	{ .compatible = "qcom,dsi-phy-28nm-8226",
> +	  .data = &dsi_phy_28nm_8226_cfgs },
>  #endif
>  #ifdef CONFIG_DRM_MSM_DSI_20NM_PHY
>  	{ .compatible = "qcom,dsi-phy-20nm",
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> index 7137a17ae523..8b640d174785 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> @@ -46,8 +46,9 @@ struct msm_dsi_phy_cfg {
>  extern const struct msm_dsi_phy_cfg dsi_phy_28nm_hpm_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_28nm_hpm_famb_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_28nm_lp_cfgs;
> -extern const struct msm_dsi_phy_cfg dsi_phy_20nm_cfgs;
> +extern const struct msm_dsi_phy_cfg dsi_phy_28nm_8226_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_28nm_8960_cfgs;
> +extern const struct msm_dsi_phy_cfg dsi_phy_20nm_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_660_cfgs;
>  extern const struct msm_dsi_phy_cfg dsi_phy_14nm_2290_cfgs;
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> index 4c1bf55c5f38..f71308387566 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> @@ -37,6 +37,7 @@
>  
>  /* v2.0.0 28nm LP implementation */
>  #define DSI_PHY_28NM_QUIRK_PHY_LP	BIT(0)
> +#define DSI_PHY_28NM_QUIRK_PHY_8226	BIT(1)
>  
>  #define LPFR_LUT_SIZE			10
>  struct lpfr_cfg {
> @@ -377,6 +378,74 @@ static int dsi_pll_28nm_vco_prepare_hpm(struct clk_hw *hw)
>  	return ret;
>  }
>  
> +static int dsi_pll_28nm_vco_prepare_8226(struct clk_hw *hw)
> +{
> +	struct dsi_pll_28nm *pll_28nm = to_pll_28nm(hw);
> +	struct device *dev = &pll_28nm->phy->pdev->dev;
> +	void __iomem *base = pll_28nm->phy->pll_base;
> +	u32 max_reads = 5, timeout_us = 100;
> +	bool locked;
> +	u32 val;
> +	int i;
> +
> +	DBG("id=%d", pll_28nm->phy->id);
> +
> +	pll_28nm_software_reset(pll_28nm);
> +
> +	/*
> +	 * PLL power up sequence.
> +	 * Add necessary delays recommended by hardware.
> +	 */
> +	dsi_phy_write(base + REG_DSI_28nm_PHY_PLL_CAL_CFG1, 0x34);
> +
> +	val = DSI_28nm_PHY_PLL_GLB_CFG_PLL_PWRDN_B; // 1
Did you send the correct revision?

Konrad
> +	dsi_phy_write_udelay(base + REG_DSI_28nm_PHY_PLL_GLB_CFG, val, 200);
> +
> +	val |= DSI_28nm_PHY_PLL_GLB_CFG_PLL_PWRGEN_PWRDN_B; // 4
> +	dsi_phy_write_udelay(base + REG_DSI_28nm_PHY_PLL_GLB_CFG, val, 200);
> +
> +	val |= DSI_28nm_PHY_PLL_GLB_CFG_PLL_LDO_PWRDN_B; // 2
> +	val |= DSI_28nm_PHY_PLL_GLB_CFG_PLL_ENABLE; // 8
> +	dsi_phy_write_udelay(base + REG_DSI_28nm_PHY_PLL_GLB_CFG, val, 600);
> +
> +	for (i = 0; i < 7; i++) {
> +		/* DSI Uniphy lock detect setting */
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_PLL_LKDET_CFG2, 0x0d);
> +		dsi_phy_write_udelay(base + REG_DSI_28nm_PHY_PLL_LKDET_CFG2,
> +				0x0c, 100);
> +		dsi_phy_write(base + REG_DSI_28nm_PHY_PLL_LKDET_CFG2, 0x0d);
> +
> +		/* poll for PLL ready status */
> +		locked = pll_28nm_poll_for_ready(pll_28nm,
> +						max_reads, timeout_us);
> +		if (locked)
> +			break;
> +
> +		pll_28nm_software_reset(pll_28nm);
> +
> +		/*
> +		 * PLL power up sequence.
> +		 * Add necessary delays recommended by hardware.
> +		 */
> +		dsi_phy_write_udelay(base + REG_DSI_28nm_PHY_PLL_PWRGEN_CFG, 0x00, 50);
> +
> +		val = DSI_28nm_PHY_PLL_GLB_CFG_PLL_PWRDN_B; // 1
> +		val |= DSI_28nm_PHY_PLL_GLB_CFG_PLL_PWRGEN_PWRDN_B; // 4
> +		dsi_phy_write_udelay(base + REG_DSI_28nm_PHY_PLL_GLB_CFG, val, 100);
> +
> +		val |= DSI_28nm_PHY_PLL_GLB_CFG_PLL_LDO_PWRDN_B; // 2
> +		val |= DSI_28nm_PHY_PLL_GLB_CFG_PLL_ENABLE; // 8
> +		dsi_phy_write_udelay(base + REG_DSI_28nm_PHY_PLL_GLB_CFG, val, 600);
> +	}
> +
> +	if (unlikely(!locked))
> +		DRM_DEV_ERROR(dev, "DSI PLL lock failed\n");
> +	else
> +		DBG("DSI PLL Lock success");
> +
> +	return locked ? 0 : -EINVAL;
> +}
> +
>  static int dsi_pll_28nm_vco_prepare_lp(struct clk_hw *hw)
>  {
>  	struct dsi_pll_28nm *pll_28nm = to_pll_28nm(hw);
> @@ -471,6 +540,15 @@ static const struct clk_ops clk_ops_dsi_pll_28nm_vco_lp = {
>  	.is_enabled = dsi_pll_28nm_clk_is_enabled,
>  };
>  
> +static const struct clk_ops clk_ops_dsi_pll_28nm_vco_8226 = {
> +	.round_rate = dsi_pll_28nm_clk_round_rate,
> +	.set_rate = dsi_pll_28nm_clk_set_rate,
> +	.recalc_rate = dsi_pll_28nm_clk_recalc_rate,
> +	.prepare = dsi_pll_28nm_vco_prepare_8226,
> +	.unprepare = dsi_pll_28nm_vco_unprepare,
> +	.is_enabled = dsi_pll_28nm_clk_is_enabled,
> +};
> +
>  /*
>   * PLL Callbacks
>   */
> @@ -536,6 +614,8 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>  
>  	if (pll_28nm->phy->cfg->quirks & DSI_PHY_28NM_QUIRK_PHY_LP)
>  		vco_init.ops = &clk_ops_dsi_pll_28nm_vco_lp;
> +	else if (pll_28nm->phy->cfg->quirks & DSI_PHY_28NM_QUIRK_PHY_8226)
> +		vco_init.ops = &clk_ops_dsi_pll_28nm_vco_8226;
>  	else
>  		vco_init.ops = &clk_ops_dsi_pll_28nm_vco_hpm;
>  
> @@ -820,3 +900,20 @@ const struct msm_dsi_phy_cfg dsi_phy_28nm_lp_cfgs = {
>  	.quirks = DSI_PHY_28NM_QUIRK_PHY_LP,
>  };
>  
> +const struct msm_dsi_phy_cfg dsi_phy_28nm_8226_cfgs = {
> +	.has_phy_regulator = true,
> +	.regulator_data = dsi_phy_28nm_regulators,
> +	.num_regulators = ARRAY_SIZE(dsi_phy_28nm_regulators),
> +	.ops = {
> +		.enable = dsi_28nm_phy_enable,
> +		.disable = dsi_28nm_phy_disable,
> +		.pll_init = dsi_pll_28nm_init,
> +		.save_pll_state = dsi_28nm_pll_save_state,
> +		.restore_pll_state = dsi_28nm_pll_restore_state,
> +	},
> +	.min_pll_rate = VCO_MIN_RATE,
> +	.max_pll_rate = VCO_MAX_RATE,
> +	.io_start = { 0xfd922b00 },
> +	.num_dsi_phy = 1,
> +	.quirks = DSI_PHY_28NM_QUIRK_PHY_8226,
> +};
> 
