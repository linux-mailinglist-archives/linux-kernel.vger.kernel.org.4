Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717F605611
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJTDn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJTDnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:43:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8091ABEF0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:43:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu25so31470034lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mbb+ms7dDLns10UB111selnMgeoJrimy+PQGWTgS8os=;
        b=GRtyKqUh+xv5psvLq7nIc/uv5P0r3/660TF9/kxeZxN52qyJUhRib44NzMiYTxaTEr
         gt0lMlGyjzA2fjCTFjSW50BtLm0XQH2pKDal/noPsgy7J3PDU64LVzMWZpucBvLQho6M
         zHAzs1fhiXK0EJH+/SYu13RkaENktAnPyvrHPHJ5XA5Lg85aDFJNuqc6MGxXU5yki90H
         8fLy/lFuZNXgd+iJFajRLxxb0BpzC/EhocRwnh+WBeqX4yVD4kviu6GNaIivVLuHslp+
         fM9/aVVU2yvR4xHnLv20NA8DnJfnCUEkTDSMO3XxFAUW50cU0CmyAloZtVExGDq1S6hF
         97lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mbb+ms7dDLns10UB111selnMgeoJrimy+PQGWTgS8os=;
        b=1wIxxZhS2wZKpHSuOBNZO8jHCIO9cu68KRWuGWEaBOg3VaGwUD0UFYTlc1+pslG0hG
         2WkzIYKB2j+xfE099lHS6BoRW0MueX/9kU8TAC01kBx7qD7p40qkV3VAJ/DeupXG1U/t
         TJKOPF/JquPVEjOzJly2qKLay7RGGSAx+dE0ID4VqJHS5MwUkT8REWbhEBOSXozy4st2
         WtRGnzsKpx1pdPRrpo+coQ8bkV0HzSREpiDEkNsXxrZ+lC+QQ75jk3H/S/ebcj3ltyi9
         Z02b+hAPedSFUA+W9A7cb4MI+0Q6U6U/cd4nZbqpxE5O4+1gs6xf2fdW9dAumQM5Mp/r
         qx4w==
X-Gm-Message-State: ACrzQf1OPyAf9iypvke2W35cjEIsEmdDx8WwEjdXQ+qDODgDLQVvnVTQ
        llDcuF3LzRg012JcYoThN6G42w==
X-Google-Smtp-Source: AMsMyM6MKUT7PHDVARV6rvHpxydEsT1vycmI5y9FVGzscxrHq1b3OZzmwF1HsCbazGeU+aREwzCNOQ==
X-Received: by 2002:ac2:443a:0:b0:4a2:623d:6022 with SMTP id w26-20020ac2443a000000b004a2623d6022mr4379478lfl.372.1666237428674;
        Wed, 19 Oct 2022 20:43:48 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id k3-20020a2eb743000000b0026fd3d906d7sm2725364ljo.133.2022.10.19.20.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 20:43:48 -0700 (PDT)
Message-ID: <2902e7e8-eddf-149c-06fd-86b85d8af326@linaro.org>
Date:   Thu, 20 Oct 2022 06:43:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 15/15] phy: qcom-qmp-pcie: add support for sc8280xp
 4-lane PHYs
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019113552.22353-16-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 14:35, Johan Hovold wrote:
> The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
> 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
> PCIe2A and PCIe2B).
> 
> Add support for fetching the 4-lane configuration from the TCSR and
> programming the lane registers of the second port when in 4-lane mode.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/Kconfig             |   1 +
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 118 +++++++++++++++++++++++
>   2 files changed, 119 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 5c98850f5a36..eb9ddc685b38 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -54,6 +54,7 @@ config PHY_QCOM_QMP
>   	tristate "Qualcomm QMP PHY Driver"
>   	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
>   	select GENERIC_PHY
> +	select MFD_SYSCON
>   	help
>   	  Enable this to support the QMP PHY transceiver that is used
>   	  with controllers such as PCIe, UFS, and USB on Qualcomm chips.
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index ea5228bd9ecc..e5bce4810bb5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -10,6 +10,7 @@
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
>   #include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> @@ -17,6 +18,7 @@
>   #include <linux/phy/pcie.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/reset.h>
>   #include <linux/slab.h>
> @@ -886,6 +888,10 @@ static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl[] =
>   	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>   };
>   
> +static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
> +};
> +
>   static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_tx_tbl[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x20),
>   	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0x75),
> @@ -1491,6 +1497,9 @@ struct qmp_phy_cfg {
>   	const struct qmp_phy_cfg_tables *tables_rc;
>   	const struct qmp_phy_cfg_tables *tables_ep;
>   
> +	const struct qmp_phy_init_tbl *serdes_4ln_tbl;
> +	int serdes_4ln_num;

Would it make more sense to change this into the proper 
qmp_phy_cfg_tables entry and then use the existing API for programming 
the table?

> +
>   	/* clock ids to be requested */
>   	const char * const *clk_list;
>   	int num_clks;
> @@ -1518,6 +1527,7 @@ struct qmp_pcie {
>   	struct device *dev;
>   
>   	const struct qmp_phy_cfg *cfg;
> +	bool tcsr_4ln_config;

As a matter of preference, this seems too specific. I'd rename it to 
split_config or split_4ln_config.

>   
>   	void __iomem *serdes;
>   	void __iomem *pcs;
> @@ -1527,6 +1537,8 @@ struct qmp_pcie {
>   	void __iomem *tx2;
>   	void __iomem *rx2;
>   
> +	void __iomem *port_b;
> +
>   	struct clk *pipe_clk;
>   	struct clk *pipediv2_clk;
>   	struct clk_bulk_data *clks;
> @@ -1932,6 +1944,44 @@ static const struct qmp_phy_cfg sc8280xp_qmp_gen3x2_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS,
>   };
>   
> +static const struct qmp_phy_cfg sc8280xp_qmp_gen3x4_pciephy_cfg = {
> +	.lanes			= 4,
> +
> +	.offsets		= &qmp_pcie_offsets_v5,
> +
> +	.tables = {
> +		.serdes		= sc8280xp_qmp_pcie_serdes_tbl,
> +		.serdes_num	= ARRAY_SIZE(sc8280xp_qmp_pcie_serdes_tbl),
> +		.tx		= sc8280xp_qmp_gen3x2_pcie_tx_tbl,
> +		.tx_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_tx_tbl),
> +		.rx		= sc8280xp_qmp_gen3x2_pcie_rx_tbl,
> +		.rx_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_rx_tbl),
> +		.pcs		= sc8280xp_qmp_gen3x2_pcie_pcs_tbl,
> +		.pcs_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_pcs_tbl),
> +		.pcs_misc	= sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl,
> +		.pcs_misc_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl),
> +	},
> +
> +	.tables_rc = &(const struct qmp_phy_cfg_tables) {
> +		.serdes		= sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl,
> +		.serdes_num	= ARRAY_SIZE(sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl),
> +	},
> +
> +	.serdes_4ln_tbl		= sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl,
> +	.serdes_4ln_num		= ARRAY_SIZE(sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl),
> +
> +	.clk_list		= sc8280xp_pciephy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sc8280xp_pciephy_clk_l),
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= sm8250_pcie_regs_layout,
> +
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +};
> +
>   static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>   	.lanes			= 2,
>   
> @@ -2054,6 +2104,24 @@ static void qmp_pcie_configure(void __iomem *base,
>   	qmp_pcie_configure_lane(base, tbl, num, 0xff);
>   }
>   
> +static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
> +	void __iomem *tx3, *rx3, *tx4, *rx4;
> +
> +	tx3 = qmp->port_b + offs->tx;
> +	rx3 = qmp->port_b + offs->rx;
> +	tx4 = qmp->port_b + offs->tx2;
> +	rx4 = qmp->port_b + offs->rx2;
> +
> +	qmp_pcie_configure_lane(tx3, tbls->tx, tbls->tx_num, 1);
> +	qmp_pcie_configure_lane(rx3, tbls->rx, tbls->rx_num, 1);
> +
> +	qmp_pcie_configure_lane(tx4, tbls->tx, tbls->tx_num, 2);
> +	qmp_pcie_configure_lane(rx4, tbls->rx, tbls->rx_num, 2);

I'd use BIT(2) and BIT(3) here. This would allow one to make a 
difference between programming first pair of lanes and second pair of 
lanes if necessary.


> +}
> +
>   static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>   {
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -2080,6 +2148,11 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>   
>   	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
>   	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> +
> +	if (cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
> +		qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
> +		qmp_pcie_init_port_b(qmp, tbls);
> +	}

As you have been refactoring this piece of code, maybe it would make 
more sense to change qmp->tx/tx2 into an array of two elements? Then we 
can extend it to 4 in this patch, and just always write the whole array 
in a loop?

>   }
>   
>   static int qmp_pcie_init(struct phy *phy)
> @@ -2477,6 +2550,37 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
>   	return 0;
>   }
>   
> +static int qmp_pcie_get_4ln_config(struct qmp_pcie *qmp)
> +{
> +	struct regmap *tcsr;
> +	unsigned int args[2];
> +	int ret;
> +
> +	tcsr = syscon_regmap_lookup_by_phandle_args(qmp->dev->of_node,
> +						    "qcom,4ln-config-sel",
> +						    ARRAY_SIZE(args), args);
> +	if (IS_ERR(tcsr)) {
> +		ret = PTR_ERR(tcsr);
> +		if (ret == -ENOENT)
> +			return 0;
> +
> +		dev_err(qmp->dev, "failed to lookup syscon: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_test_bits(tcsr, args[0], BIT(args[1]));
> +	if (ret < 0) {
> +		dev_err(qmp->dev, "failed to read tcsr: %d\n", ret);
> +		return ret;
> +	}
> +
> +	qmp->tcsr_4ln_config = ret;
> +
> +	dev_dbg(qmp->dev, "4ln_config_sel = %d\n", qmp->tcsr_4ln_config);
> +
> +	return 0;
> +}
> +
>   static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
>   {
>   	struct platform_device *pdev = to_platform_device(qmp->dev);
> @@ -2484,10 +2588,15 @@ static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
>   	const struct qmp_pcie_offsets *offs = cfg->offsets;
>   	struct device *dev = qmp->dev;
>   	void __iomem *base;
> +	int ret;
>   
>   	if (!offs)
>   		return -EINVAL;
>   
> +	ret = qmp_pcie_get_4ln_config(qmp);
> +	if (ret)
> +		return ret;
> +
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
> @@ -2503,6 +2612,12 @@ static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
>   		qmp->rx2 = base + offs->rx2;
>   	}
>   
> +	if (qmp->cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
> +		qmp->port_b = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(qmp->port_b))
> +			return PTR_ERR(qmp->port_b);
> +	}
> +
>   	qmp->pipe_clk = devm_clk_get(dev, "pipe");
>   	if (IS_ERR(qmp->pipe_clk)) {
>   		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
> @@ -2610,6 +2725,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>   	}, {
>   		.compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy",
>   		.data = &sc8280xp_qmp_gen3x2_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,sc8280xp-qmp-gen3x4-pcie-phy",
> +		.data = &sc8280xp_qmp_gen3x4_pciephy_cfg,
>   	}, {
>   		.compatible = "qcom,sdm845-qhp-pcie-phy",
>   		.data = &sdm845_qhp_pciephy_cfg,

-- 
With best wishes
Dmitry

