Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765546ECB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjDXLO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDXLOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:14:54 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9530DA;
        Mon, 24 Apr 2023 04:14:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B97F424DC7D;
        Mon, 24 Apr 2023 19:14:50 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 19:14:50 +0800
Received: from [192.168.125.108] (113.72.145.137) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 19:14:49 +0800
Message-ID: <c014f16d-8383-af3e-49a3-4e16e6008959@starfivetech.com>
Date:   Mon, 24 Apr 2023 19:14:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 4/7] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Mason Huo" <mason.huo@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-5-minda.chen@starfivetech.com>
 <44e5ba0a-7a76-caa8-349d-ced41aaa8836@kernel.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <44e5ba0a-7a76-caa8-349d-ced41aaa8836@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/24 17:23, Roger Quadros wrote:
> 
> 
> On 20/04/2023 14:00, Minda Chen wrote:
>> Add Starfive JH7110 SoC PCIe 2.0 PHY driver support.
>> PCIe 2.0 PHY default connect to PCIe controller.
>> But pcie0 PHY can connect to USB 3.0 controlller.
> 
> s/controlller/controller
> 
ok
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  MAINTAINERS                            |   4 +-
>>  drivers/phy/starfive/Kconfig           |  11 ++
>>  drivers/phy/starfive/Makefile          |   1 +
>>  drivers/phy/starfive/phy-jh7110-pcie.c | 202 +++++++++++++++++++++++++
>>  4 files changed, 217 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c09ea66dcd5a..8e0f755ba91b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19968,10 +19968,12 @@ M:	William Qiu <william.qiu@starfivetech.com>
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>  
>> -STARFIVE JH71X0 USB PHY DRIVER
>> +STARFIVE JH71X0 PCIE AND USB PHY DRIVER
>>  M:	Minda Chen <minda.chen@starfivetech.com>
>>  S:	Supported
>> +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
>>  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>> +F:	drivers/phy/starfive/phy-jh7110-pcie.c
>>  F:	drivers/phy/starfive/phy-jh7110-usb.c
>>  
>>  STATIC BRANCH/CALL
>> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
>> index 2c013c390dee..c21c21d284a6 100644
>> --- a/drivers/phy/starfive/Kconfig
>> +++ b/drivers/phy/starfive/Kconfig
>> @@ -12,6 +12,17 @@ config PHY_STARFIVE_DPHY_RX
>>  	  system. If M is selected, the module will be called
>>  	  phy-starfive-dphy-rx.
>>  
>> +config PHY_STARFIVE_JH7110_PCIE
>> +	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
>> +	depends on USB_SUPPORT
> 
> What if system has PCIE and no USB. Then they can't use this PHY
> as it cannot be built?
> 
ok, I will delete it
>> +	select GENERIC_PHY
>> +	select USB_PHY
>> +	help
>> +	  Enable this to support the StarFive PCIe 2.0 PHY,
>> +	  or used as USB 3.0 PHY.
>> +	  If M is selected, the module will be called
>> +	  phy-jh7110-pcie.ko.
>> +
>>  config PHY_STARFIVE_JH7110_USB
>>  	tristate "Starfive JH7110 USB 2.0 PHY support"
>>  	depends on USB_SUPPORT
>> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
>> index 176443852f4d..03a55aad53a2 100644
>> --- a/drivers/phy/starfive/Makefile
>> +++ b/drivers/phy/starfive/Makefile
>> @@ -1,3 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_PHY_STARFIVE_DPHY_RX)      += phy-starfive-dphy-rx.o
>> +obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)	+= phy-jh7110-pcie.o
>>  obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)	+= phy-jh7110-usb.o
>> diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
>> new file mode 100644
>> index 000000000000..fe029daef62e
>> --- /dev/null
>> +++ b/drivers/phy/starfive/phy-jh7110-pcie.c
>> @@ -0,0 +1,202 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * StarFive JH7110 PCIe 2.0 PHY driver
>> + *
>> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
>> + * Author: Minda Chen <minda.chen@starfivetech.com>
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#define PCIE_KVCO_LEVEL_OFF		(0x28)
>> +#define PCIE_USB3_PHY_PLL_CTL_OFF	(0x7c)
>> +#define PCIE_KVCO_TUNE_SIGNAL_OFF	(0x80)
> 
> Brackets not required.
> 
ok
>> +#define PCIE_USB3_PHY_ENABLE		BIT(4)
>> +#define PHY_KVCO_FINE_TUNE_LEVEL	0x91
>> +#define PHY_KVCO_FINE_TUNE_SIGNALS	0xc
>> +
>> +#define USB_PDRSTN_SPLIT		BIT(17)
>> +
>> +#define PCIE_PHY_MODE			BIT(20)
>> +#define PCIE_PHY_MODE_MASK		GENMASK(21, 20)
>> +#define PCIE_USB3_BUS_WIDTH_MASK	GENMASK(3, 2)
>> +#define PCIE_USB3_RATE_MASK		GENMASK(6, 5)
>> +#define PCIE_USB3_RX_STANDBY_MASK	BIT(7)
>> +#define PCIE_USB3_PHY_ENABLE		BIT(4)
>> +
>> +struct jh7110_pcie_phy {
>> +	struct phy *phy;
>> +	struct regmap *stg_syscon;
>> +	struct regmap *sys_syscon;
>> +	void __iomem *regs;
>> +	u32 sys_phy_connect;
>> +	u32 stg_pcie_mode;
>> +	u32 stg_pcie_usb;
>> +	enum phy_mode mode;
>> +};
>> +
>> +static int jh7110_usb3_mode_set(struct jh7110_pcie_phy *data)
>> +{
>> +	if (!data->stg_syscon || !data->sys_syscon) {
>> +		dev_info(&data->phy->dev, "don't support usb3 mode\n");
> 
> s/don't/doesn't
> 
> dev_err()
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
>> +			   PCIE_PHY_MODE_MASK, PCIE_PHY_MODE);
>> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
>> +			   PCIE_USB3_BUS_WIDTH_MASK, 0);
>> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
>> +			   PCIE_USB3_RATE_MASK, 0);
>> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
>> +			   PCIE_USB3_RX_STANDBY_MASK, 0);
>> +	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
>> +			   PCIE_USB3_PHY_ENABLE, PCIE_USB3_PHY_ENABLE);
>> +
>> +	/* Connect usb 3.0 phy mode */
>> +	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
>> +			   USB_PDRSTN_SPLIT, 0);
>> +
>> +	/* Configuare spread-spectrum mode: down-spread-spectrum */
>> +	writel(PCIE_USB3_PHY_ENABLE, data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
>> +
>> +	return 0;
>> +}
>> +
>> +static void jh7110_pcie_mode_set(struct jh7110_pcie_phy *phy)
>> +{
>> +	/* PCIe Multi-PHY PLL KVCO Gain fine tune settings: */
>> +	writel(PHY_KVCO_FINE_TUNE_LEVEL, phy->regs + PCIE_KVCO_LEVEL_OFF);
>> +	writel(PHY_KVCO_FINE_TUNE_SIGNALS, phy->regs + PCIE_KVCO_TUNE_SIGNAL_OFF);
> 
> In cases where PHY can be connected to both USB and PCIe don't you have to
> make sure PHY is connected to PCIe controller by setting data->sys_syscon
> and data->stg_syscon appropriately?
> 
PHY default connect to pcie. In our products so far, The PHY connected to either USB or PCIe. So I don't set the syscon register.
But the case of PHY can be connected to both USB and PCIe maybe existed. I will add this case.
>> +}
>> +
>> +static int jh7110_pcie_phy_set_mode(struct phy *_phy,
>> +				    enum phy_mode mode, int submode)
>> +{
>> +	struct jh7110_pcie_phy *phy = phy_get_drvdata(_phy);
>> +	int ret;
>> +
>> +	if (mode == phy->mode)
>> +		return 0;
>> +
>> +	switch (mode) {
>> +	case PHY_MODE_USB_HOST:
>> +	case PHY_MODE_USB_DEVICE:
>> +	case PHY_MODE_USB_OTG:
>> +		ret = jh7110_usb3_mode_set(phy);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case PHY_MODE_PCIE:
>> +		jh7110_pcie_mode_set(phy);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_info(&_phy->dev, "Changing phy mode to %d\n", mode);
> 
> dev_dbg()?
> 
ok
>> +	phy->mode = mode;
>> +
>> +	return 0;
>> +}
>> +
>> +static int jh7110_pcie_phy_init(struct phy *_phy)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int jh7110_pcie_phy_exit(struct phy *_phy)
>> +{
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops jh7110_pcie_phy_ops = {
>> +	.init		= jh7110_pcie_phy_init,
>> +	.exit		= jh7110_pcie_phy_exit,
> 
> As you are not doing anything in init/exit, you don't have to set them.
> 
ok
>> +	.set_mode	= jh7110_pcie_phy_set_mode,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static int jh7110_pcie_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct jh7110_pcie_phy *phy;
>> +	struct device *dev = &pdev->dev;
>> +	struct phy_provider *phy_provider;
>> +	u32 args[2];
>> +
>> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> +	if (!phy)
>> +		return -ENOMEM;
>> +
>> +	phy->regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(phy->regs))
>> +		return PTR_ERR(phy->regs);
>> +
>> +	phy->phy = devm_phy_create(dev, NULL, &jh7110_pcie_phy_ops);
>> +	if (IS_ERR(phy->phy))
>> +		return dev_err_probe(dev, PTR_ERR(phy->regs),
>> +			"Failed to map phy base\n");
>> +
>> +	phy->sys_syscon =
>> +		syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
>> +						     "starfive,sys-syscon",
>> +						     1, args);
>> +
>> +	if (!IS_ERR_OR_NULL(phy->sys_syscon))
>> +		phy->sys_phy_connect = args[0];
>> +	else
>> +		phy->sys_syscon = NULL;
>> +
>> +	phy->stg_syscon =
>> +		syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
>> +						     "starfive,stg-syscon",
>> +						     2, args);
>> +
>> +	if (!IS_ERR_OR_NULL(phy->stg_syscon)) {
>> +		phy->stg_pcie_mode = args[0];
>> +		phy->stg_pcie_usb = args[1];
>> +	} else {
>> +		phy->stg_syscon = NULL;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, phy);
>> +	phy_set_drvdata(phy->phy, phy);
>> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +	return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static int jh7110_pcie_phy_remove(struct platform_device *pdev)
>> +{
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id jh7110_pcie_phy_of_match[] = {
>> +	{ .compatible = "starfive,jh7110-pcie-phy" },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, jh7110_pcie_phy_of_match);
>> +
>> +static struct platform_driver jh7110_pcie_phy_driver = {
>> +	.probe	= jh7110_pcie_phy_probe,
>> +	.remove	= jh7110_pcie_phy_remove,
>> +	.driver = {
>> +		.of_match_table	= jh7110_pcie_phy_of_match,
>> +		.name  = "jh7110-pcie-phy",
>> +	}
>> +};
>> +module_platform_driver(jh7110_pcie_phy_driver);
>> +
>> +MODULE_DESCRIPTION("StarFive JH7110 PCIe 2.0 PHY driver");
>> +MODULE_AUTHOR("Minda Chen <minda.chen@starfivetech.com>");
>> +MODULE_LICENSE("GPL");
> 
> cheers,
> -roger
