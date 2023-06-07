Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA26725DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjFGLyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjFGLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:54:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2F91BCC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:54:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso3719036e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686138866; x=1688730866;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Asydfjq2eEpPjZfiuqiYvdF3KnjIA6edxD3BnnQbcZk=;
        b=bZXmpBWBfzLPQUA3isPl3V0mH5R5g9ZGiQY8ndhVQhFhlov/il+slplRLf7nlWSfaY
         5DfgOF8p37EddqumMJu14G76mkIdpCp0R9MaAfSKF7fDjrKo7frp/nChERcoMLXY03xQ
         Dih2F5mE94+ULzJuIH2xIrwR2BThaDg27zWxl0LuDXHmYNFf6Q6ay6opYlY91j//xJ7e
         qvIpl+6e6jjtCcGf5khLERdziL3H01zM1BLN/IrRN5QPdhXPAiWJghdAx4MCBcjkx4zi
         0T4jiZGXe+EGbbubXiXjOOUFAbGPoyfUwJZE+xh7hNLnG6hnVK1oIpSfoEaU7heZfCKX
         hNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686138866; x=1688730866;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Asydfjq2eEpPjZfiuqiYvdF3KnjIA6edxD3BnnQbcZk=;
        b=K4qf8jQS+VCM8kjO39k6cTg6IK0Bt3qOxwHXDqBUjxMIwDKqFYaT5k3xez+1ibKrhE
         +r1MzkYUVLQjuPSLuSBaIzFNBQNFerOg1vM/Wk1V4QXdpi1VFFaKF2fmEmZJMUhO5ot5
         FwDJirjr/yGWcP5LnsO2Ys8xQZU3S+9Db9QDGerD8Ev2lWgb8srEGdvOfAoX/jUkzZ83
         7NjU9AEZ6GpoYrdqByj7E9Qe5cAzXInMNwr4x/95U9GgujTMy9B8d9GXxCswAYjQaeO1
         Bj9g5nfMaUpJuzAE8j4XH63osVxUOQ45alnjLI0VAe7NxwjpEmG1B4tC15IzcJW3Fb4/
         f/lA==
X-Gm-Message-State: AC+VfDzwia4klNtG2Lq6oURwAN9qHwGsJ1yhn9xenqlmKBPCh3FrmHqL
        s6FiuzqfaRoAm2PR1XOu7Pz+9A==
X-Google-Smtp-Source: ACHHUZ6mLA0d3GRI9wFD9pLuo09FV/letvWT+DUmis6LFdbkVK6s5fIbjvjkb8M850Fag7uw4ZtP2Q==
X-Received: by 2002:ac2:5e8a:0:b0:4f6:1779:b1c1 with SMTP id b10-20020ac25e8a000000b004f61779b1c1mr1829447lfq.48.1686138866482;
        Wed, 07 Jun 2023 04:54:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id p19-20020a19f013000000b004f4589808ddsm1774395lfc.305.2023.06.07.04.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:54:26 -0700 (PDT)
Message-ID: <416bef68-6df3-d5c4-2aed-ef1ae7c78d7b@linaro.org>
Date:   Wed, 7 Jun 2023 13:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <6bb345c6a57ee27516764f36ba7d34fd1a719b87.1686126439.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 3/9] phy: qcom-m31: Introduce qcom,m31 USB phy driver
In-Reply-To: <6bb345c6a57ee27516764f36ba7d34fd1a719b87.1686126439.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.06.2023 12:56, Varadarajan Narayanan wrote:
> Add the M31 USB2 phy driver
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-m31.c | 360 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 360 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> new file mode 100644
> index 0000000..d29a91e
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014-2016, 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/phy.h>
> +#include <linux/reset.h>
> +#include <linux/of_device.h>
Please sort these

> +
> +enum clk_reset_action {
> +	CLK_RESET_DEASSERT	= 0,
> +	CLK_RESET_ASSERT	= 1
> +};
> +
> +#define USB2PHY_PORT_POWERDOWN		0xA4
> +#define POWER_UP			BIT(0)
> +#define POWER_DOWN			0
> +
> +#define USB2PHY_PORT_UTMI_CTRL1	0x40
> +
> +#define USB2PHY_PORT_UTMI_CTRL2	0x44
> +#define UTMI_ULPI_SEL			BIT(7)
> +#define UTMI_TEST_MUX_SEL		BIT(6)
> +
> +#define HS_PHY_CTRL_REG			0x10
> +#define UTMI_OTG_VBUS_VALID             BIT(20)
> +#define SW_SESSVLD_SEL                  BIT(28)
> +
> +#define USB_PHY_CFG0			0x94
> +#define USB_PHY_UTMI_CTRL5		0x50
> +#define USB_PHY_FSEL_SEL		0xB8
> +#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
> +#define USB_PHY_REFCLK_CTRL		0xA0
> +#define USB_PHY_HS_PHY_CTRL2		0x64
> +#define USB_PHY_UTMI_CTRL0		0x3c
> +#define USB2PHY_USB_PHY_M31_XCFGI_1	0xBC
> +#define USB2PHY_USB_PHY_M31_XCFGI_4	0xC8
> +#define USB2PHY_USB_PHY_M31_XCFGI_5	0xCC
> +#define USB2PHY_USB_PHY_M31_XCFGI_11	0xE4
Could you sort them address-wise?

> +
> +#define USB2_0_TX_ENABLE		BIT(2)
> +#define HSTX_SLEW_RATE_565PS		3
> +#define PLL_CHARGING_PUMP_CURRENT_35UA	(3 << 3)
> +#define ODT_VALUE_38_02_OHM		(3 << 6)
> +#define ODT_VALUE_45_02_OHM		BIT(2)
> +#define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	(1)
Weird mix of values, bits, bitfields.. perhaps BIT(n) and
GENMASK() (+ FIELD_PREP) would be more suitable?

> +
> +#define UTMI_PHY_OVERRIDE_EN		BIT(1)
> +#define POR_EN				BIT(1)
Please associate these with their registers, like

#define FOO_REG		0xf00
 #define POR_EN		BIT(1)

> +#define FREQ_SEL			BIT(0)
> +#define COMMONONN			BIT(7)
> +#define FSEL				BIT(4)
> +#define RETENABLEN			BIT(3)
> +#define USB2_SUSPEND_N_SEL		BIT(3)
> +#define USB2_SUSPEND_N			BIT(2)
> +#define USB2_UTMI_CLK_EN		BIT(1)
> +#define CLKCORE				BIT(1)
> +#define ATERESET			~BIT(0)
> +#define FREQ_24MHZ			(5 << 4)
> +#define XCFG_COARSE_TUNE_NUM		(2 << 0)
> +#define XCFG_FINE_TUNE_NUM		(1 << 3)
same comment

> +
> +static void m31usb_write_readback(void *base, u32 offset,
> +					const u32 mask, u32 val);
We don't need this forward-definition, just move the function up.

> +
> +struct m31usb_phy {
> +	struct usb_phy		phy;
> +	void __iomem		*base;
> +	void __iomem		*qscratch_base;
> +
> +	struct reset_control	*phy_reset;
> +
> +	bool			cable_connected;
> +	bool			suspended;
> +	bool			ulpi_mode;
> +};
> +
> +static void m31usb_reset(struct m31usb_phy *qphy, u32 action)
> +{
> +	if (action == CLK_RESET_ASSERT)
> +		reset_control_assert(qphy->phy_reset);
> +	else
> +		reset_control_deassert(qphy->phy_reset);
> +	wmb(); /* ensure data is written to hw register */
Please move the comment above the call.

> +}
> +
> +static void m31usb_phy_enable_clock(struct m31usb_phy *qphy)
> +{
> +	/* Enable override ctrl */
> +	writel(UTMI_PHY_OVERRIDE_EN, qphy->base + USB_PHY_CFG0);
Some of the comments are missing a space before '*/'

Also, please consider adding some newlines to logically split the
actions.

> +	/* Enable POR*/
> +	writel(POR_EN, qphy->base + USB_PHY_UTMI_CTRL5);
> +	udelay(15);
> +	/* Configure frequency select value*/
> +	writel(FREQ_SEL, qphy->base + USB_PHY_FSEL_SEL);
> +	/* Configure refclk frequency */
> +	writel(COMMONONN | FSEL | RETENABLEN,
> +		qphy->base + USB_PHY_HS_PHY_CTRL_COMMON0);
> +	/* select refclk source */
> +	writel(CLKCORE, qphy->base + USB_PHY_REFCLK_CTRL);
> +	/* select ATERESET*/
> +	writel(POR_EN & ATERESET, qphy->base + USB_PHY_UTMI_CTRL5);
> +	writel(USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
> +		qphy->base + USB_PHY_HS_PHY_CTRL2);
> +	writel(0x0, qphy->base + USB_PHY_UTMI_CTRL5);
> +	writel(USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
> +		qphy->base + USB_PHY_HS_PHY_CTRL2);
> +	/* Disable override ctrl */
> +	writel(0x0, qphy->base + USB_PHY_CFG0);
> +}
> +
> +static void ipq5332_m31usb_phy_enable_clock(struct m31usb_phy *qphy)
> +{
> +	/* Enable override ctrl */
> +	writel(UTMI_PHY_OVERRIDE_EN, qphy->base + USB_PHY_CFG0);
> +	/* Enable POR*/
ditto

> +	writel(POR_EN, qphy->base + USB_PHY_UTMI_CTRL5);
> +	udelay(15);
> +	/* Configure frequency select value*/
> +	writel(FREQ_SEL, qphy->base + USB_PHY_FSEL_SEL);
> +	/* Configure refclk frequency */
> +	writel(COMMONONN | FREQ_24MHZ | RETENABLEN,
> +		qphy->base + USB_PHY_HS_PHY_CTRL_COMMON0);
> +	/* select ATERESET*/
> +	writel(POR_EN & ATERESET, qphy->base + USB_PHY_UTMI_CTRL5);
> +	writel(USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
> +		qphy->base + USB_PHY_HS_PHY_CTRL2);
> +	writel(XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM,
> +				qphy->base + USB2PHY_USB_PHY_M31_XCFGI_11);
> +	/* Adjust HSTX slew rate to 565 ps*/
> +	/* Adjust PLL lock Time counter for release clock to 35uA */
> +	/* Adjust Manual control ODT value to 38.02 Ohm */
> +	writel(HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
> +		ODT_VALUE_38_02_OHM, qphy->base + USB2PHY_USB_PHY_M31_XCFGI_4);
These functions seem very similar, with the main difference being that
IPQ5332 adds some more writes at the end. Perhaps some commonizing could
be done?

> +	/*
> +	 * Enable to always turn on USB 2.0 TX driver
> +	 * when system is in USB 2.0 HS mode
> +	 */
> +	writel(USB2_0_TX_ENABLE, qphy->base + USB2PHY_USB_PHY_M31_XCFGI_1);
> +	/* Adjust Manual control ODT value to 45.02 Ohm */
> +	/* Adjust HSTX Pre-emphasis level to 0.55mA */
> +	writel(ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA,
> +		qphy->base + USB2PHY_USB_PHY_M31_XCFGI_5);
> +	udelay(4);
> +	writel(0x0, qphy->base + USB_PHY_UTMI_CTRL5);
> +	writel(USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
> +		qphy->base + USB_PHY_HS_PHY_CTRL2);
> +}
> +
> +static int m31usb_phy_init(struct usb_phy *phy)
> +{
> +	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
> +
> +	/* Perform phy reset */
> +	m31usb_reset(qphy, CLK_RESET_ASSERT);
> +	usleep_range(1, 5);
https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

this may not work as intended

> +	m31usb_reset(qphy, CLK_RESET_DEASSERT);
> +
> +	/* configure for ULPI mode if requested */
> +	if (qphy->ulpi_mode)
> +		writel_relaxed(0x0, qphy->base + USB2PHY_PORT_UTMI_CTRL2);
> +
> +	/* Enable the PHY */
> +	writel_relaxed(POWER_UP, qphy->base + USB2PHY_PORT_POWERDOWN);
> +
> +	/* Make sure above write completed */
> +	wmb();
As you're calling wmb in the reset func, dropping _relaxed from the
ULPI and PORT_POWERDOWN writes should work the same

> +
> +	/* Turn on phy ref clock*/
> +	if (of_device_is_compatible(phy->dev->of_node,
> +					"qcom,ipq5332-m31-usb-hsphy"))
> +		ipq5332_m31usb_phy_enable_clock(qphy);
> +	else
> +		m31usb_phy_enable_clock(qphy);
This should be done using OF match data.

> +
> +	/* Set OTG VBUS Valid from HSPHY to controller */
> +	m31usb_write_readback(qphy->qscratch_base, HS_PHY_CTRL_REG,
> +				UTMI_OTG_VBUS_VALID, UTMI_OTG_VBUS_VALID);
> +	/* Indicate value is driven by UTMI_OTG_VBUS_VALID bit */
> +	m31usb_write_readback(qphy->qscratch_base, HS_PHY_CTRL_REG,
> +				SW_SESSVLD_SEL, SW_SESSVLD_SEL);
> +
> +	return 0;
> +}
> +
> +static void m31usb_phy_shutdown(struct usb_phy *phy)
> +{
> +	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
> +
> +	/* Disable the PHY */
> +	writel_relaxed(POWER_DOWN, qphy->base + USB2PHY_PORT_POWERDOWN);
> +	/* Make sure above write completed */
> +	wmb();
> +}
> +
> +static void m31usb_write_readback(void *base, u32 offset,
> +					const u32 mask, u32 val)
The indentation here makes `const u32..` misaligned.

> +{
> +	u32 write_val, tmp = readl_relaxed(base + offset);
> +
> +	tmp &= ~mask; /* retain other bits */
> +	write_val = tmp | val;
> +
> +	writel_relaxed(write_val, base + offset);
> +	/* Make sure above write completed */
> +	wmb();
> +
> +	/* Read back to see if val was written */
> +	tmp = readl_relaxed(base + offset);
> +	tmp &= mask; /* clear other bits */
> +
> +	if (tmp != val)
> +		pr_err("%s: write: %x to QSCRATCH: %x FAILED\n",
> +			__func__, val, offset);
> +}
> +
> +static int m31usb_phy_notify_connect(struct usb_phy *phy,
> +					enum usb_device_speed speed)
> +{
> +	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
> +
> +	qphy->cable_connected = true;
> +
> +	dev_dbg(phy->dev, " cable_connected=%d\n", qphy->cable_connected);
spurious space at the beginning of the string

> +
> +	/* Set OTG VBUS Valid from HSPHY to controller */
> +	m31usb_write_readback(qphy->qscratch_base, HS_PHY_CTRL_REG,
> +				UTMI_OTG_VBUS_VALID,
> +				UTMI_OTG_VBUS_VALID);
Please align the lines with the previous opening bracket

> +
> +	/* Indicate value is driven by UTMI_OTG_VBUS_VALID bit */
> +	m31usb_write_readback(qphy->qscratch_base, HS_PHY_CTRL_REG,
> +				SW_SESSVLD_SEL, SW_SESSVLD_SEL);
> +
> +	dev_dbg(phy->dev, "M31USB2 phy connect notification\n");
> +	return 0;
> +}
> +
> +static int m31usb_phy_notify_disconnect(struct usb_phy *phy,
> +					enum usb_device_speed speed)
> +{
> +	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
> +
> +	qphy->cable_connected = false;
> +
> +	dev_dbg(phy->dev, " cable_connected=%d\n", qphy->cable_connected);
> +
> +	/* Set OTG VBUS Valid from HSPHY to controller */
> +	m31usb_write_readback(qphy->qscratch_base, HS_PHY_CTRL_REG,
> +				UTMI_OTG_VBUS_VALID, 0);
> +
> +	/* Indicate value is driven by UTMI_OTG_VBUS_VALID bit */
> +	m31usb_write_readback(qphy->qscratch_base, HS_PHY_CTRL_REG,
> +				SW_SESSVLD_SEL, 0);
> +
> +	dev_dbg(phy->dev, "M31USB2 phy disconnect notification\n");
> +	return 0;
> +}
> +
> +static int m31usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct m31usb_phy *qphy;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret;
> +	const char *phy_type;
Please sort these in a reverse-Christmas-tree order.

> +
> +	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
> +	if (!qphy)
> +		return -ENOMEM;
> +
> +	qphy->phy.dev = dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +							"m31usb_phy_base");
> +	qphy->base = devm_ioremap_resource(dev, res);
devm_platform_get_and_ioremap_resource?

> +	if (IS_ERR(qphy->base))
> +		return PTR_ERR(qphy->base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +							"qscratch_base");
> +	if (res) {
Do we expect platforms without this register space?

> +		qphy->qscratch_base = devm_ioremap(dev, res->start,
> +							resource_size(res));
> +		if (IS_ERR(qphy->qscratch_base)) {
> +			dev_dbg(dev, "couldn't ioremap qscratch_base\n");
> +			qphy->qscratch_base = NULL;
> +		}
> +	}
> +
> +	qphy->phy_reset = devm_reset_control_get(dev, "usb2_phy_reset");
not _exclusive?

> +	if (IS_ERR(qphy->phy_reset))
> +		return PTR_ERR(qphy->phy_reset);
> +
> +	qphy->ulpi_mode = false;
> +	ret = of_property_read_string(dev->of_node, "phy_type", &phy_type);
of_usb_get_phy_mode?

> +
> +	if (!ret) {
> +		if (!strcasecmp(phy_type, "ulpi"))
> +			qphy->ulpi_mode = true;
> +	} else {
> +		dev_err(dev, "error reading phy_type property\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, qphy);
> +
> +	qphy->phy.label			= "qcom-m31usb-phy";
> +	qphy->phy.init			= m31usb_phy_init;
> +	qphy->phy.shutdown		= m31usb_phy_shutdown;
> +	qphy->phy.type			= USB_PHY_TYPE_USB2;
> +
> +	if (qphy->qscratch_base) {
> +		qphy->phy.notify_connect        = m31usb_phy_notify_connect;
> +		qphy->phy.notify_disconnect     = m31usb_phy_notify_disconnect;
> +	}
> +
> +	ret = usb_add_phy_dev(&qphy->phy);
> +
> +	return ret;
> +}
> +
> +static int m31usb_phy_remove(struct platform_device *pdev)
Please make this return void and pass it to .remove_new

> +{
> +	struct m31usb_phy *qphy = platform_get_drvdata(pdev);
> +
> +	usb_remove_phy(&qphy->phy);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id m31usb_phy_id_table[] = {
> +	{ .compatible = "qcom,m31-usb-hsphy",},
> +	{ .compatible = "qcom,ipq5332-m31-usb-hsphy",},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, m31usb_phy_id_table);
> +
> +static struct platform_driver m31usb_phy_driver = {
> +	.probe		= m31usb_phy_probe,
> +	.remove		= m31usb_phy_remove,
> +	.driver = {
> +		.name	= "qcom-m31usb-phy",
> +		.of_match_table = of_match_ptr(m31usb_phy_id_table),
of_match_ptr is unnecessary, this driver depends on OF.

Konrad
> +	},
> +};
> +
> +module_platform_driver(m31usb_phy_driver);
> +
> +MODULE_DESCRIPTION("USB2 Qualcomm M31 HSPHY driver");
> +MODULE_LICENSE("GPL");
