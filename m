Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44586C0C96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCTI4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCTI4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:56:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A152F97D;
        Mon, 20 Mar 2023 01:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3116129B;
        Mon, 20 Mar 2023 08:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE05AC433EF;
        Mon, 20 Mar 2023 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679302553;
        bh=13FEHAR+CE5c89ZMfC6n39bWR44A7P/5OUh9yU/RQ0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0ujfXX1gY+IpcURrGZgugKeUNIO6rm4S83QJXE6QyZAQka3vhS+LSjiujHQ4js81
         oaoySZA9x2qBMCbSzoXhk/SlU+o6FeClBYj1J+/oKhhnL1dJDcqyyFgXR/jgaSK8DJ
         Y29i/MvP5d68osNCz4XtLaDp/nIM1TzQAKqYVWXHQOGMKyzmejLq2TfX4OEvF2Ejxl
         gBRBpec2w7Fv6Xs4BLUd3IwNSEWoTbchmUhJtUjPSDzT6Ll21tnQAqoRVZnNfsz4hD
         LePZkd6LbzAtzhtbuowM5/LmS+6c+1e8SYE4N2KL7zOZGXWqMRww5e1SKWfznQLfGE
         XI79p9FZ/rKmQ==
Date:   Mon, 20 Mar 2023 14:25:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 2/5] phy: starfive: add JH7110 PCIE 2.0 and USB 2.0
 PHY driver.
Message-ID: <ZBgflY0NTqpmJMEc@matsya>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-3-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315104411.73614-3-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-23, 18:44, Minda Chen wrote:
> Add Starfive JH7110 SoC PCIe 2.0 and USB 2.0 PHY driver support.
> PCIe 2.0 PHY can used as USB 3.0 PHY
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  MAINTAINERS                            |   8 ++
>  drivers/phy/starfive/Kconfig           |  22 ++++
>  drivers/phy/starfive/Makefile          |   2 +
>  drivers/phy/starfive/phy-jh7110-pcie.c | 136 ++++++++++++++++++++
>  drivers/phy/starfive/phy-jh7110-usb.c  | 167 +++++++++++++++++++++++++
>  5 files changed, 335 insertions(+)
>  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8361b8e710ca..4263c005e45c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19977,6 +19977,14 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>  F:	drivers/phy/starfive/phy-starfive-dphy-rx.c
>  
> +STARFIVE JH71X0 PCIE AND USB PHY DRIVER
> +M:	Emil Renner Berthing <kernel@esmil.dk>
> +M:	Minda Chen <minda.chen@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml
> +F:	drivers/phy/starfive/phy-jh7110-pcie.c
> +F:	drivers/phy/starfive/phy-jh7110-usb.c
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> index e449a662acf5..dd0f139b5bfb 100644
> --- a/drivers/phy/starfive/Kconfig
> +++ b/drivers/phy/starfive/Kconfig
> @@ -11,3 +11,25 @@ config PHY_STARFIVE_DPHY_RX
>  	  Choose this option if you have a Starfive D-PHY in your
>  	  system. If M is selected, the module will be called
>  	  phy-starfive-dphy-rx.
> +
> +config PHY_STARFIVE_JH7110_USB
> +	tristate "Starfive JH7110 USB 2.0 PHY support"
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	select USB_PHY
> +	help
> +	  Enable this to support the StarFive USB 2.0 PHY,
> +	  used with the Cadence USB controller.
> +	  If M is selected, the module will be called
> +	  phy-jh7110-usb.ko.
> +
> +config PHY_STARFIVE_JH7110_PCIE

Sorted alphabetically please

> +	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	select USB_PHY
> +	help
> +	  Enable this to support the StarFive PCIe 2.0 PHY,
> +	  or used as USB 3.0 PHY.
> +	  If M is selected, the module will be called
> +	  phy-jh7110-pcie.ko.
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> index 7ec576cb30ae..c3eaf1b34cbb 100644
> --- a/drivers/phy/starfive/Makefile
> +++ b/drivers/phy/starfive/Makefile
> @@ -1,2 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PHY_STARFIVE_DPHY_RX)      += phy-starfive-dphy-rx.o
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)	+= phy-jh7110-usb.o
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)	+= phy-jh7110-pcie.o

Here also

> diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
> new file mode 100644
> index 000000000000..30a8fa1f580d
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-pcie.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * StarFive JH7110 PCIe 2.0 PHY driver
> + *
> + * Copyright (C) 2023 Minda Chen <minda.chen@starfivetech.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +#define PCIE_KVCO_LEVEL_OFF		(0x28)
> +#define PCIE_USB3_PHY_PLL_CTL_OFF	(0x7c)
> +#define PCIE_KVCO_TUNE_SIGNAL_OFF	(0x80)
> +#define PCIE_USB3_PHY_ENABLE		BIT(4)
> +#define PHY_KVCO_FINE_TUNE_LEVEL	0x91
> +#define PHY_KVCO_FINE_TUNE_SIGNALS	0xc
> +
> +struct jh7110_pcie_phy {
> +	struct phy *phy;
> +	void __iomem *regs;
> +	enum phy_mode mode;
> +};
> +
> +static void jh7110_usb3_mode_set(struct jh7110_pcie_phy *phy)
> +{
> +	/* Configuare spread-spectrum mode: down-spread-spectrum */
> +	writel(PCIE_USB3_PHY_ENABLE, phy->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
> +}
> +
> +static void jh7110_pcie_mode_set(struct jh7110_pcie_phy *phy)
> +{
> +	/* PCIe Multi-PHY PLL KVCO Gain fine tune settings: */
> +	writel(PHY_KVCO_FINE_TUNE_LEVEL, phy->regs + PCIE_KVCO_LEVEL_OFF);
> +	writel(PHY_KVCO_FINE_TUNE_SIGNALS, phy->regs + PCIE_KVCO_TUNE_SIGNAL_OFF);
> +}
> +
> +static int jh7110_pcie_phy_set_mode(struct phy *_phy,
> +				  enum phy_mode mode, int submode)
> +{
> +	struct jh7110_pcie_phy *phy = phy_get_drvdata(_phy);
> +
> +	if (mode != phy->mode) {
> +		switch (mode) {
> +		case PHY_MODE_USB_HOST:
> +		case PHY_MODE_USB_DEVICE:
> +		case PHY_MODE_USB_OTG:
> +			jh7110_usb3_mode_set(phy);
> +			break;
> +		case PHY_MODE_PCIE:
> +			jh7110_pcie_mode_set(phy);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		dev_info(&_phy->dev, "Changing phy mode to %d\n", mode);
> +		phy->mode = mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static int jh7110_pcie_phy_init(struct phy *_phy)
> +{
> +	return 0;
> +}
> +
> +static int jh7110_pcie_phy_exit(struct phy *_phy)
> +{
> +	return 0;
> +}
> +
> +static const struct phy_ops jh7110_pcie_phy_ops = {
> +	.init		= jh7110_pcie_phy_init,
> +	.exit		= jh7110_pcie_phy_exit,
> +	.set_mode	= jh7110_pcie_phy_set_mode,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int jh7110_pcie_phy_probe(struct platform_device *pdev)
> +{
> +	struct jh7110_pcie_phy *phy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(phy->regs))
> +		return PTR_ERR(phy->regs);
> +
> +	phy->phy = devm_phy_create(dev, NULL, &jh7110_pcie_phy_ops);
> +	if (IS_ERR(phy->phy))
> +		return dev_err_probe(dev, PTR_ERR(phy->regs),
> +			"Failed to map phy base\n");
> +
> +	platform_set_drvdata(pdev, phy);
> +	phy_set_drvdata(phy->phy, phy);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static int jh7110_pcie_phy_remove(struct platform_device *pdev)
> +{
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id jh7110_pcie_phy_of_match[] = {
> +	{ .compatible = "starfive,jh7110-pcie-phy" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, jh7110_pcie_phy_of_match);
> +
> +static struct platform_driver jh7110_pcie_phy_driver = {
> +	.probe	= jh7110_pcie_phy_probe,
> +	.remove	= jh7110_pcie_phy_remove,
> +	.driver = {
> +		.of_match_table	= jh7110_pcie_phy_of_match,
> +		.name  = "jh7110-pcie-phy",
> +	}
> +};
> +module_platform_driver(jh7110_pcie_phy_driver);
> +
> +MODULE_DESCRIPTION("StarFive JH7110 PCIe 2.0 PHY driver");
> +MODULE_AUTHOR("Minda Chen <minda.chen@starfivetech.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
> new file mode 100644
> index 000000000000..89db0b7b1224
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-usb.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * StarFive JH7110 USB 2.0 PHY driver

Since these two seem to be different driver, pls split the patches to
two, one for each phy driver

> + *
> + * Copyright (C) 2023 Minda Chen <minda.chen@starfivetech.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/of.h>
> +
> +#define USB_125M_CLK_RATE		125000000
> +#define USB_LS_KEEPALIVE_OFF		0x4
> +#define USB_LS_KEEPALIVE_ENABLE		BIT(4)
> +
> +struct jh7110_usb2_phy {
> +	struct phy *phy;
> +	void __iomem *regs;
> +	struct clk *usb_125m_clk;
> +	struct clk *app_125;
> +	enum usb_dr_mode dr_mode;
> +};
> +
> +static void jh7110_usb2_mode_set(struct jh7110_usb2_phy *phy)
> +{
> +	unsigned int val;
> +
> +	if (phy->dr_mode != USB_DR_MODE_PERIPHERAL) {
> +		/* Enable the LS speed keep-alive signal */
> +		val = readl(phy->regs + USB_LS_KEEPALIVE_OFF);
> +		val |= USB_LS_KEEPALIVE_ENABLE;
> +		writel(val, phy->regs + USB_LS_KEEPALIVE_OFF);
> +	}
> +}
> +
> +static int jh7110_usb2_phy_set_mode(struct phy *_phy,
> +				  enum phy_mode mode, int submode)
> +{
> +	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
> +	int new_mode;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +		new_mode = USB_DR_MODE_HOST;
> +		break;
> +	case PHY_MODE_USB_DEVICE:
> +		new_mode = USB_DR_MODE_PERIPHERAL;
> +		break;
> +	case PHY_MODE_USB_OTG:
> +		new_mode = USB_DR_MODE_OTG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (new_mode != phy->dr_mode) {
> +		dev_info(&_phy->dev, "Changing dr_mode to %d\n", new_mode);
> +		phy->dr_mode = new_mode;
> +		jh7110_usb2_mode_set(phy);
> +	}
> +
> +	return 0;
> +}
> +
> +static int jh7110_usb2_phy_init(struct phy *_phy)
> +{
> +	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
> +	int ret;
> +
> +	ret = clk_set_rate(phy->usb_125m_clk, USB_125M_CLK_RATE);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(phy->app_125);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int jh7110_usb2_phy_exit(struct phy *_phy)
> +{
> +	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
> +
> +	clk_disable_unprepare(phy->app_125);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops jh7110_usb2_phy_ops = {
> +	.init		= jh7110_usb2_phy_init,
> +	.exit		= jh7110_usb2_phy_exit,
> +	.set_mode	= jh7110_usb2_phy_set_mode,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int jh7110_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct jh7110_usb2_phy *phy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->usb_125m_clk = devm_clk_get(dev, "125m");
> +	if (IS_ERR(phy->usb_125m_clk))
> +		return dev_err_probe(dev, PTR_ERR(phy->usb_125m_clk),
> +			"Failed to get 125m clock\n");
> +
> +	phy->app_125 = devm_clk_get(dev, "app_125");
> +	if (IS_ERR(phy->app_125))
> +		return dev_err_probe(dev, PTR_ERR(phy->app_125),
> +			"Failed to get app 125m clock\n");
> +
> +	phy->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(phy->regs))
> +		return dev_err_probe(dev, PTR_ERR(phy->regs),
> +			"Failed to map phy base\n");
> +
> +	phy->phy = devm_phy_create(dev, NULL, &jh7110_usb2_phy_ops);
> +	if (IS_ERR(phy->phy))
> +		return dev_err_probe(dev, PTR_ERR(phy->phy),
> +			"Failed to create phy\n");
> +
> +	platform_set_drvdata(pdev, phy);
> +	phy_set_drvdata(phy->phy, phy);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static int jh7110_usb_phy_remove(struct platform_device *pdev)
> +{
> +	struct jh7110_usb2_phy *phy = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(phy->app_125);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id jh7110_usb_phy_of_match[] = {
> +	{ .compatible = "starfive,jh7110-usb-phy" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, jh7110_usb_phy_of_match);
> +
> +static struct platform_driver jh7110_usb_phy_driver = {
> +	.probe	= jh7110_usb_phy_probe,
> +	.remove	= jh7110_usb_phy_remove,
> +	.driver = {
> +		.of_match_table	= jh7110_usb_phy_of_match,
> +		.name  = "jh7110-usb-phy",
> +	}
> +};
> +module_platform_driver(jh7110_usb_phy_driver);
> +
> +MODULE_DESCRIPTION("StarFive JH7110 USB 2.0 PHY driver");
> +MODULE_AUTHOR("Minda Chen <minda.chen@starfivetech.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1

-- 
~Vinod
