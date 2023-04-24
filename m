Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EED6EC80E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjDXIq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjDXIq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24175E53;
        Mon, 24 Apr 2023 01:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A349A61F1F;
        Mon, 24 Apr 2023 08:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6286C433D2;
        Mon, 24 Apr 2023 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682326014;
        bh=BxzHUQB3Z0bZMqtecVzotggbecUSmBmH1hXxG3knd7g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jdIvp0lahDwhD5Of5iNaBzJV93J9CmLiSKsfK1wx/EDaULMmI0evPDb9JQTkiL1XP
         5jKKP4/Y2ucVSWsWg++viia79FEnxT553ndleAu9A1vuaz/a3zdIVk/gE7V0fLHIDh
         4QX6Komzpjypwyt6yjSDtiHh5biBVitIbcP9muVRxCl/M/+7+Bq2gRVCq00GmwAVUM
         RUWT7VCJkA1H9gt4I1sPvYBFI+2YQhN8VS/iHBYVmYX7RRkcpvWyj83CTagRAHyv6u
         03EsgB/Z3j3cPPy2b089AdlQ1B0t0GArQ22uIg47zwYiKSrpnp6K6ssjUUrMlJlhRf
         s170M+b+8IO5g==
Message-ID: <f9666a06-8087-f804-202a-dbb744011d3a@kernel.org>
Date:   Mon, 24 Apr 2023 11:46:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/7] phy: starfive: Add JH7110 USB 2.0 PHY driver
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-4-minda.chen@starfivetech.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230420110052.3182-4-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minda,

On 20/04/2023 14:00, Minda Chen wrote:
> Add Starfive JH7110 SoC USB 2.0 PHY driver support.
> USB 2.0 PHY default connect to Cadence USB controller.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  MAINTAINERS                           |   6 +
>  drivers/phy/starfive/Kconfig          |  11 ++
>  drivers/phy/starfive/Makefile         |   1 +
>  drivers/phy/starfive/phy-jh7110-usb.c | 162 ++++++++++++++++++++++++++
>  4 files changed, 180 insertions(+)
>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aef5ba46d71..c09ea66dcd5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19968,6 +19968,12 @@ M:	William Qiu <william.qiu@starfivetech.com>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
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
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> index f989b8ff8bcb..2c013c390dee 100644
> --- a/drivers/phy/starfive/Kconfig
> +++ b/drivers/phy/starfive/Kconfig
> @@ -11,3 +11,14 @@ config PHY_STARFIVE_DPHY_RX
>  	  Choose this option if you have a StarFive D-PHY in your
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
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> index 7ec576cb30ae..176443852f4d 100644
> --- a/drivers/phy/starfive/Makefile
> +++ b/drivers/phy/starfive/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PHY_STARFIVE_DPHY_RX)      += phy-starfive-dphy-rx.o
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)	+= phy-jh7110-usb.o
> diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
> new file mode 100644
> index 000000000000..4a12df0692cd
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-usb.c
> @@ -0,0 +1,162 @@
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
> +		dev_info(&_phy->dev, "Changing phy to %d\n", mode);

dev_dbg() please?

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
> +	clk_disable_unprepare(phy->app_125m);

Why do you need to do clk_disable here? You didn't enable it in probe.

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

cheers,
-roger
