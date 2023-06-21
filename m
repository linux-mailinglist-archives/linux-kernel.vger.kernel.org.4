Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82600738230
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjFULMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFULMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933B186;
        Wed, 21 Jun 2023 04:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E94B6150C;
        Wed, 21 Jun 2023 11:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0303EC433C0;
        Wed, 21 Jun 2023 11:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687345933;
        bh=hemcQkLtj8eWOKOF5ziGhqriVgYi/b1g7rj4VltgJCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUqEMkZZyULF/pzRaSsITTNpCD4gR0JyXNpDI4McoFlgJ2Nz13WNKcEig6H2ml1/P
         kxdt74OU71d/nzwWs4Vm2xaaoc5NkVu30moVjVD7/pFETuTiboDiexS5/6X+CVCzSI
         S7MJsAkt0zmBZkRj93ApPwM9rG7BoWnXsDi4ULFcaxeI1TQ78nhbU0oSRIk41zkEAG
         4L3Tono77SSGEHVG+FMiZf1ZqKBsTDwe1UYB10PzrkBnHF2Eh928CZ3R3iYz9nHdSH
         yYniY4l9NE8LRSDiTXSZ7AfuTCQzwbk9zygg8KEbU7A/3h3jaq7qyGDG0ccfrmMFqA
         kzGkpw6Sm4Ygw==
Date:   Wed, 21 Jun 2023 16:42:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v7 3/5] phy: starfive: Add JH7110 USB 2.0 PHY driver
Message-ID: <ZJLbCbG9+XnGVjKb@matsya>
References: <20230619094759.21013-1-minda.chen@starfivetech.com>
 <20230619094759.21013-4-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619094759.21013-4-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-23, 17:47, Minda Chen wrote:
> Add Starfive JH7110 SoC USB 2.0 PHY driver support.
> USB 2.0 PHY default connect to Cadence USB controller.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
>  MAINTAINERS                           |   6 ++
>  drivers/phy/Kconfig                   |   1 +
>  drivers/phy/Makefile                  |   1 +
>  drivers/phy/starfive/Kconfig          |  15 +++
>  drivers/phy/starfive/Makefile         |   2 +
>  drivers/phy/starfive/phy-jh7110-usb.c | 150 ++++++++++++++++++++++++++
>  6 files changed, 175 insertions(+)
>  create mode 100644 drivers/phy/starfive/Kconfig
>  create mode 100644 drivers/phy/starfive/Makefile
>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f794002a192e..d2ce89a8d31c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20174,6 +20174,12 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/watchdog/starfive*
>  F:	drivers/watchdog/starfive-wdt.c
>  
> +STARFIVE JH71X0 USB PHY DRIVER
> +M:	Minda Chen <minda.chen@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> +F:	drivers/phy/starfive/phy-jh7110-usb.c
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index f46e3148d286..0000149edbc4 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -91,6 +91,7 @@ source "drivers/phy/rockchip/Kconfig"
>  source "drivers/phy/samsung/Kconfig"
>  source "drivers/phy/socionext/Kconfig"
>  source "drivers/phy/st/Kconfig"
> +source "drivers/phy/starfive/Kconfig"
>  source "drivers/phy/sunplus/Kconfig"
>  source "drivers/phy/tegra/Kconfig"
>  source "drivers/phy/ti/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 54f312c10a40..fb3dc9de6111 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
>  					   samsung/	\
>  					   socionext/	\
>  					   st/		\
> +					   starfive/	\
>  					   sunplus/	\
>  					   tegra/	\
>  					   ti/		\
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> new file mode 100644
> index 000000000000..2283feadfc76
> --- /dev/null
> +++ b/drivers/phy/starfive/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Phy drivers for StarFive platforms
> +#
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
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> new file mode 100644
> index 000000000000..52e9a09cc619
> --- /dev/null
> +++ b/drivers/phy/starfive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)	+= phy-jh7110-usb.o
> diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
> new file mode 100644
> index 000000000000..90d788423705
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-usb.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * StarFive JH7110 USB 2.0 PHY driver
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + * Author: Minda Chen <minda.chen@starfivetech.com>
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
> +	struct clk *app_125m;
> +	enum phy_mode mode;
> +};
> +
> +static void jh7110_usb2_mode_set(struct jh7110_usb2_phy *phy)
> +{
> +	unsigned int val;
> +
> +	if (phy->mode != PHY_MODE_USB_HOST) {
> +		/* Enable the LS speed keep-alive signal */
> +		val = readl(phy->regs + USB_LS_KEEPALIVE_OFF);
> +		val |= USB_LS_KEEPALIVE_ENABLE;
> +		writel(val, phy->regs + USB_LS_KEEPALIVE_OFF);
> +	}

looks like this sets only for host, so why not call it
jh7110_usb2_set_host_mode() rather than get confused about
jh7110_usb2_mode_set/jh7110_usb2_phy_set_mode

> +}
> +
> +static int jh7110_usb2_phy_set_mode(struct phy *_phy,
> +				    enum phy_mode mode, int submode)
> +{
> +	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_DEVICE:
> +	case PHY_MODE_USB_OTG:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (mode != phy->mode) {
> +		dev_dbg(&_phy->dev, "Changing phy to %d\n", mode);
> +		phy->mode = mode;
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
> +	ret = clk_prepare_enable(phy->app_125m);
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
> +	clk_disable_unprepare(phy->app_125m);
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
> +	phy->app_125m = devm_clk_get(dev, "app_125m");
> +	if (IS_ERR(phy->app_125m))
> +		return dev_err_probe(dev, PTR_ERR(phy->app_125m),
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
> +	phy_set_drvdata(phy->phy, phy);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
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
> +	.driver = {
> +		.of_match_table	= jh7110_usb_phy_of_match,
> +		.name  = "jh7110-usb-phy",
> +	}
> +};
> +module_platform_driver(jh7110_usb_phy_driver);

A very light driver, only setting couple of things for hw. Can you
explain how phy registers are configured, am sure there would be many
more..? Do you rely on bootloader or some other entity for that?

> +
> +MODULE_DESCRIPTION("StarFive JH7110 USB 2.0 PHY driver");
> +MODULE_AUTHOR("Minda Chen <minda.chen@starfivetech.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1

-- 
~Vinod
