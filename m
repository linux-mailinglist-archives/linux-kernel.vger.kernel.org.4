Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90353689FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjBCQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjBCQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:51:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F147A9137
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:51:16 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m2so16971923ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9H+7eu0nKo3RQkzvEs2GR39wpNecSbntvidjbbSX1cA=;
        b=XWgl1miqEhDyUgWUqx5UwU2/DNele/Ymr2GysXqyFvM7EDjymyzTHNQL5FdWs7WOSd
         CFszJwShP4mChWBBfSH4sz3Z+NVP+YnGJ9JN2iTffiU6kNe7v+cv8nowevMIjY6GDvPz
         Rbbr2uy2y9YunMtdGl5Sd/PB0SB/r1mWDlL/lKPHVWLhP9SBVEm0CtyfChLQ/kjZrqd1
         7Chv4VdK2MS552pmrofmFv4pmAEkW2UetTqhN97T3ttJjXtY4xttT0uA0OAe073tH20w
         AuCxL2xcUfQvmvVM54qOVrtcPrGKN7aj5Nr5glGwJTvut27n2aiszoiE13+h968sPtnR
         GdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9H+7eu0nKo3RQkzvEs2GR39wpNecSbntvidjbbSX1cA=;
        b=60+RU+6igTPFOleAGLKbrCreaO88FlebLN4Et1USxie3DwW81QBBGy+for92YHHRez
         S0v/jEtCb/lP5S47jY1ebJAAzlHpeWyMCFSemy7XGHIdhtyObLOhmXprFY+Y1D6v99Mz
         d5dgUsXAaqG+EE9eNeQC3gpJSpdl7BDn5ph7IbQm1X8YjNZE/XzE6bb8H8oAqO1Og3rJ
         oxJvo+UqXBtxNgXOufRdR6S12rU4JEQChh9xGMpISe0m2mR6C2HA1535YwP+rqymEKjE
         uYx9iiZOW+iu/T+a3PDGxgR/KgPXH8ZrOz6FXEzGrMmKF0U20Ac57yZB4hmghLHC+675
         D+7w==
X-Gm-Message-State: AO0yUKV7aSBcR9JMKr51aVpfmxFmhVFW9ZPF6Yf2cSdFMCczmqaO9MAA
        sEgdtt35w8Uick8cd/lJyFkYcQ==
X-Google-Smtp-Source: AK7set/FJqUMcqpkulM8FoKVPvO1SihaJHrmGlj4OWLQ1VoDLsSjJ22/1UX/o5SMinpCJsqP9VCUTA==
X-Received: by 2002:a17:906:4941:b0:88c:a3f0:4e3f with SMTP id f1-20020a170906494100b0088ca3f04e3fmr11322529ejt.22.1675443074631;
        Fri, 03 Feb 2023 08:51:14 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170906f6ca00b00878812a8d14sm1608469ejb.85.2023.02.03.08.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 08:51:14 -0800 (PST)
Message-ID: <6f326ed7-6799-b965-fe3a-1f046546ed44@linaro.org>
Date:   Fri, 3 Feb 2023 18:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v3 4/7] phy: qcom: Add QCOM SNPS eUSB2 repeater driver
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
 <20230202133816.4026990-5-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230202133816.4026990-5-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 15:38, Abel Vesa wrote:
> PM8550B contains a eUSB2 repeater used for making the eUSB2 from
> SM8550 USB 2.0 compliant. This can be modelled SW-wise as a Phy.
> So add a new phy driver for it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/phy/qualcomm/Kconfig                  |   9 +
>   drivers/phy/qualcomm/Makefile                 |   1 +
>   .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 278 ++++++++++++++++++
>   3 files changed, 288 insertions(+)
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 27b5a2a3637d..a70631b04522 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -79,6 +79,15 @@ config PHY_QCOM_SNPS_EUSB2
>   	  chipsets. The PHY is paired with a Synopsys DWC3 USB controller
>   	  on Qualcomm SOCs.
>   
> +config PHY_QCOM_EUSB2_REPEATER
> +	tristate "Qualcomm SNPS eUSB2 Repeater Driver"
> +	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Enable support for the USB high-speed SNPS eUSB2 repeater on Qualcomm
> +	  PMICs. The repeater is paired with a Synopsys eUSB2 Phy
> +	  on Qualcomm SOCs.
> +
>   config PHY_QCOM_USB_HS
>   	tristate "Qualcomm USB HS PHY module"
>   	depends on USB_ULPI_BUS
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index 3ee118f4dfc7..7dcba9537b69 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PHY_QCOM_QMP)		+= \
>   
>   obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
>   obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)	+= phy-qcom-snps-eusb2.o
> +obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)	+= phy-qcom-eusb2-repeater.o
>   obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
>   obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
>   obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> new file mode 100644
> index 000000000000..f7f822f2973f
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +
> +/* eUSB2 status registers */
> +#define EUSB2_RPTR_STATUS		0x08
> +#define	RPTR_OK				BIT(7)
> +
> +/* eUSB2 control registers */
> +#define EUSB2_EN_CTL1			0x46
> +#define EUSB2_RPTR_EN			BIT(7)
> +
> +#define PHY_HOST_MODE			BIT(0)
> +#define EUSB2_FORCE_EN_5		0xE8
> +#define F_CLK_19P2M_EN			BIT(6)
> +#define F_CLK_19P2M_EN_SHIFT		6

Drop the _SHIFT defines please, they don't add anything on top of 
previous defines (and don't seem to be used anyway).

> +
> +#define EUSB2_FORCE_VAL_5		0xED
> +#define V_CLK_19P2M_EN			BIT(6)
> +#define V_CLK_19P2M_EN_SHIFT		6
> +
> +#define EUSB2_TUNE_IUSB2		0x51
> +#define EUSB2_TUNE_SQUELCH_U		0x54
> +#define EUSB2_TUNE_USB2_PREEM		0x57
> +
> +#define QCOM_EUSB2_REPEATER_INIT_CFG(o, v)	\
> +	{					\
> +		.offset = o,			\
> +		.val = v,			\
> +	}
> +
> +enum repeater_mode {
> +	REPEATER_HOST_MODE,
> +	REPEATER_PERIPH_MODE,
> +};

I think this is unused now.

> +
> +struct eusb2_repeater_init_tbl {
> +	unsigned int offset;
> +	unsigned int val;
> +};
> +
> +struct eusb2_repeater_cfg {
> +	const struct eusb2_repeater_init_tbl *init_tbl;
> +	int init_tbl_num;
> +	/* regulators to be requested */
> +	const char * const *vreg_list;
> +	int num_vregs;
> +};
> +
> +struct eusb2_repeater {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct phy *phy;
> +	struct regulator_bulk_data *vregs;
> +	const struct eusb2_repeater_cfg *cfg;
> +	u16 base;
> +	enum phy_mode mode;
> +};
> +
> +static const char * const pm8550b_vreg_l[] = {
> +	"vdd18", "vdd3",
> +};
> +
> +static const struct eusb2_repeater_init_tbl pm8550b_init_tbl[] = {
> +	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_IUSB2, 0x8),
> +	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_SQUELCH_U, 0x3),
> +	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_USB2_PREEM, 0x5),
> +};
> +
> +static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
> +	.init_tbl	= pm8550b_init_tbl,
> +	.init_tbl_num	= ARRAY_SIZE(pm8550b_init_tbl),
> +	.vreg_list	= pm8550b_vreg_l,
> +	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
> +};
> +
> +static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
> +{
> +	int num = rptr->cfg->num_vregs;
> +	struct device *dev = rptr->dev;
> +	int i;
> +
> +	rptr->vregs = devm_kcalloc(dev, num, sizeof(*rptr->vregs), GFP_KERNEL);
> +	if (!rptr->vregs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; i++)
> +		rptr->vregs[i].supply = rptr->cfg->vreg_list[i];
> +
> +	return devm_regulator_bulk_get(dev, num, rptr->vregs);
> +}
> +
> +static int eusb2_repeater_init(struct phy *phy)
> +{
> +	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> +	const struct eusb2_repeater_init_tbl *init_tbl = rptr->cfg->init_tbl;
> +	int num = rptr->cfg->init_tbl_num;
> +	int ret = 0;
> +	u32 val;
> +	int i;
> +
> +	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
> +	if (ret)
> +		return ret;
> +
> +	regmap_update_bits(rptr->regmap, rptr->base + EUSB2_EN_CTL1,
> +				EUSB2_RPTR_EN, EUSB2_RPTR_EN);
> +
> +	for (i = 0; i < num; i++)
> +		regmap_update_bits(rptr->regmap,
> +					rptr->base + init_tbl[i].offset,
> +					init_tbl[i].val, init_tbl[i].val);

I'd move this to a separate function. Then you can use it in the 
set_mode() too.

> +
> +	ret = regmap_read_poll_timeout(rptr->regmap,
> +					rptr->base + EUSB2_RPTR_STATUS, val,
> +					val & RPTR_OK, 10, 5);
> +	if (ret)
> +		dev_err(rptr->dev, "initialization timed-out\n");
> +
> +	return ret;
> +}
> +
> +static int eusb2_repeater_set_mode(struct phy *phy,
> +					enum phy_mode mode, int submode)
> +{
> +	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +		/*
> +		 * CM.Lx is prohibited when repeater is already into Lx state as
> +		 * per eUSB 1.2 Spec. Below implement software workaround until
> +		 * PHY and controller is fixing seen observation.
> +		 */
> +		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
> +				F_CLK_19P2M_EN, F_CLK_19P2M_EN);
> +		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
> +				V_CLK_19P2M_EN, V_CLK_19P2M_EN);
> +		break;
> +	case PHY_MODE_USB_DEVICE:
> +		/*
> +		 * In device mode clear host mode related workaround as there
> +		 * is no repeater reset available, and enable/disable of
> +		 * repeater doesn't clear previous value due to shared
> +		 * regulators (say host <-> device mode switch).
> +		 */
> +		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
> +				F_CLK_19P2M_EN, 0);
> +		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
> +				V_CLK_19P2M_EN, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eusb2_repeater_exit(struct phy *phy)
> +{
> +	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> +
> +	return regulator_bulk_disable(rptr->cfg->num_vregs, rptr->vregs);
> +}
> +
> +
> +static const struct phy_ops eusb2_repeater_ops = {
> +	.init		= eusb2_repeater_init,
> +	.exit		= eusb2_repeater_exit,
> +	.set_mode	= eusb2_repeater_set_mode,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int eusb2_repeater_probe(struct platform_device *pdev)
> +{
> +	struct eusb2_repeater *rptr;
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +	struct device_node *np;
> +	u32 res;
> +	int ret;
> +
> +	np = of_node_get(dev->of_node);

Do you really need to increase the refcount here? I thought that we can 
use dev->of_node straight away.

> +
> +	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
> +	if (!rptr)
> +		goto err_node_put;
> +
> +	rptr->dev = dev;
> +	dev_set_drvdata(dev, rptr);
> +
> +	rptr->cfg = of_device_get_match_data(dev);
> +	if (!rptr->cfg)
> +		goto err_node_put;
> +
> +	rptr->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!rptr->regmap)
> +		goto err_node_put;
> +
> +	ret = of_property_read_u32(np, "reg", &res);
> +	if (ret < 0)
> +		goto err_node_put;
> +
> +	rptr->base = res;
> +
> +	ret = eusb2_repeater_init_vregs(rptr);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to get supplies\n");
> +		goto err_node_put;
> +	}
> +
> +	rptr->phy = devm_phy_create(dev, np, &eusb2_repeater_ops);
> +	if (IS_ERR(rptr->phy)) {
> +		ret = PTR_ERR(rptr->phy);
> +		dev_err(dev, "failed to create PHY: %d\n", ret);
> +		goto err_node_put;
> +	}
> +
> +	phy_set_drvdata(rptr->phy, rptr);
> +
> +	of_node_put(np);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	dev_info(dev, "Registered Qcom-eUSB2 repeater\n");
> +
> +	return 0;
> +
> +err_node_put:
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +static int eusb2_repeater_remove(struct platform_device *pdev)
> +{
> +	struct eusb2_repeater *rptr = platform_get_drvdata(pdev);
> +
> +	if (!rptr)
> +		return 0;
> +
> +	eusb2_repeater_exit(rptr->phy);
> +	return 0;
> +}
> +
> +
> +static const struct of_device_id eusb2_repeater_of_match_table[] = {
> +	{
> +		.compatible = "qcom,pm8550b-eusb2-repeater",
> +		.data = &pm8550b_eusb2_cfg,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, eusb2_repeater_of_match_table);
> +
> +static struct platform_driver eusb2_repeater_driver = {
> +	.probe		= eusb2_repeater_probe,
> +	.remove		= eusb2_repeater_remove,
> +	.driver = {
> +		.name	= "qcom-eusb2-repeater",
> +		.of_match_table = eusb2_repeater_of_match_table,
> +	},
> +};
> +
> +module_platform_driver(eusb2_repeater_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm PMIC eUSB2 Repeater driver");
> +MODULE_LICENSE("GPL v2");

-- 
With best wishes
Dmitry

