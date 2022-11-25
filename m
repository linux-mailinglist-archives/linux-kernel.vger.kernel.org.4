Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206936382FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKYECI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKYEBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:01:19 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3C72C664;
        Thu, 24 Nov 2022 20:01:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B71815C010A;
        Thu, 24 Nov 2022 23:01:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 24 Nov 2022 23:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669348877; x=1669435277; bh=wn
        aTOhFhwVFvlLpXmB27jPEeXmF21EO1MoGqYkoBTaw=; b=TZfMg6/yUwRvU5p741
        /Dsrj7GUOt94UcPsYzMqd+V35FJ+lY/DAKApAIFa9Yb4w7r1bIkvZBFotRk34TSJ
        MrhNHK3BI9zmxS/wOOs30/UZrC2uaEJ2+gF4udvizjqq0Bhd2pO+MY3Dzm9oOVr4
        WLzCe3vrYUPn9Gj7qoLU50zJGUNScFRDs+4OFOZN/wpo2dJZOk4G6Qz1HCIDRC0e
        PqenNDZtvvhJiaf9Rfn3geI8SBN6BiYiuHzKk67r/Qrz+3Mq8MRZDHudaScH+5Ld
        VaPGiIm+bTrYlYUEBdtKJ3/vZfRfgPOcziZqWhN8A5zY/C9hLyruf5mKNMXhFSX3
        /XuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669348877; x=1669435277; bh=wnaTOhFhwVFvl
        LpXmB27jPEeXmF21EO1MoGqYkoBTaw=; b=ZHigOORO/7OxKiPrmpWl3uDaF+u9V
        CS5Cq+kJ1UpOKOXXCgST5gboftEWUJOV9r93RIGby4tktSGWxJm3O/UeRFUpLWK5
        fXIBa+sjAA/BT5glTSpVgFJ8rps5GTum4j7JvFj2REU48d2P8g/tbEKt7YoMCcJE
        O7jadvp1BQD1Qp+4s/t/9DVDH/p5IabVQBtuk9MBxbDjlVxp/nmsBSawQE3HOLqK
        8FuBgL6fRQk7rO1DNfSCvTWtU19V65sw5UtSRbX5vhUqTabhnv0xag07ZjwNUKZD
        3l/qjvoTDPeC6yBFHaN7wARPnHXyIaqYrEjboYjKd6YJBmpYM4GUZvi9w==
X-ME-Sender: <xms:DT6AY67RDXeyBMdNFmpljEVXjIQ_6gSFC6ejkZrS9xWqM-ij9-vuhw>
    <xme:DT6AYz63opMpMWf_eiOm6YMBrLAiaOczKbiBd1uSTMB8Lj2KS-jSHajTPt02tOY-P
    -NRXO9BP5hTWStqAg>
X-ME-Received: <xmr:DT6AY5cRcrVWe_8ztTPIceprnBbLldKmyOoyHBst2cWEklL0WN1dy8NhR2MhaMns8SfJh65VtGiBunKL4BABlZIGBaMPWjXdS6iYXWGC3_wJSpF5Uc49D-SBo-thRgMNVwrvOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeggdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:DT6AY3KTdit0xmKXXujneaYSvuCskz_6rwNwddmq_9RpfZvaHHzYhA>
    <xmx:DT6AY-L3UA-IeWy9kHjsDKhx1vkJxEhrgM6ua-eZVYiJrngpi-dN3Q>
    <xmx:DT6AY4wzbUVyHkWqq8a2nK3rLJEqTbkbBfux5tGdWioI7QjAN_4r1g>
    <xmx:DT6AYwCZO8mjzY6uuS1ONkB5JiMK3eg3GolhUgok_pb_5tqe0SKykg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Nov 2022 23:01:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v4 2/4] regulator: sun20i: Add Allwinner D1 LDOs driver
Date:   Thu, 24 Nov 2022 22:01:10 -0600
Message-Id: <20221125040112.18160-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221125040112.18160-1-samuel@sholland.org>
References: <20221125040112.18160-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 contains two pairs of LDOs, "analog" LDOs and "system" LDOs. They are
similar and can share a driver, but only the system LDOs have a DT
binding defined so far.

The system LDOs have a single linear range. The voltage step is not an
integer, so a custom .list_voltage is needed to get the rounding right.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
 - Drop the analog LDOs until the codec binding is ready

Changes in v3:
 - Adjust control flow in sun20i_regulator_get_regmap() for clarity

Changes in v2:
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle

 drivers/regulator/Kconfig            |   8 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sun20i-regulator.c | 150 +++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/regulator/sun20i-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 070e4403c6c2..8480532114c1 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1280,6 +1280,14 @@ config REGULATOR_STW481X_VMMC
 	  This driver supports the internal VMMC regulator in the STw481x
 	  PMIC chips.
 
+config REGULATOR_SUN20I
+	tristate "Allwinner D1 internal LDOs"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	select MFD_SYSCON
+	default ARCH_SUNXI
+	help
+	  This driver supports the internal LDOs in the Allwinner D1 SoC.
+
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
 	depends on MFD_SY7636A
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5962307e1130..8e9b5a21123d 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
+obj-$(CONFIG_REGULATOR_SUN20I) += sun20i-regulator.o
 obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
diff --git a/drivers/regulator/sun20i-regulator.c b/drivers/regulator/sun20i-regulator.c
new file mode 100644
index 000000000000..031bcc3dee50
--- /dev/null
+++ b/drivers/regulator/sun20i-regulator.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
+//
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#define SUN20I_SYS_LDO_CTRL_REG		0x150
+
+struct sun20i_regulator_data {
+	const struct regulator_desc	*descs;
+	unsigned int			ndescs;
+};
+
+/* regulator_list_voltage_linear() modified for the non-integral uV_step. */
+static int sun20i_d1_system_ldo_list_voltage(struct regulator_dev *rdev,
+					     unsigned int selector)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	unsigned int uV;
+
+	if (selector >= desc->n_voltages)
+		return -EINVAL;
+
+	uV = desc->min_uV + (desc->uV_step * selector);
+
+	/* Produce correctly-rounded absolute voltages. */
+	return uV + ((selector + 1 + (desc->min_uV % 4)) / 3);
+}
+
+static const struct regulator_ops sun20i_d1_system_ldo_ops = {
+	.list_voltage		= sun20i_d1_system_ldo_list_voltage,
+	.map_voltage		= regulator_map_voltage_ascend,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_desc sun20i_d1_system_ldo_descs[] = {
+	{
+		.name		= "ldoa",
+		.supply_name	= "ldo-in",
+		.of_match	= "ldoa",
+		.ops		= &sun20i_d1_system_ldo_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= 32,
+		.min_uV		= 1600000,
+		.uV_step	= 13333, /* repeating */
+		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
+		.vsel_mask	= GENMASK(7, 0),
+	},
+	{
+		.name		= "ldob",
+		.supply_name	= "ldo-in",
+		.of_match	= "ldob",
+		.ops		= &sun20i_d1_system_ldo_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= 64,
+		.min_uV		= 1166666,
+		.uV_step	= 13333, /* repeating */
+		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
+		.vsel_mask	= GENMASK(15, 8),
+	},
+};
+
+static const struct sun20i_regulator_data sun20i_d1_system_ldos = {
+	.descs	= sun20i_d1_system_ldo_descs,
+	.ndescs	= ARRAY_SIZE(sun20i_d1_system_ldo_descs),
+};
+
+static struct regmap *sun20i_regulator_get_regmap(struct device *dev)
+{
+	struct regmap *regmap;
+
+	/*
+	 * First try the syscon interface. The system control device is not
+	 * compatible with "syscon", so fall back to getting the regmap from
+	 * its platform device. This is ugly, but required for devicetree
+	 * backward compatibility.
+	 */
+	regmap = syscon_node_to_regmap(dev->parent->of_node);
+	if (!IS_ERR(regmap))
+		return regmap;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (regmap)
+		return regmap;
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int sun20i_regulator_probe(struct platform_device *pdev)
+{
+	const struct sun20i_regulator_data *data;
+	struct device *dev = &pdev->dev;
+	struct regulator_config config;
+	struct regmap *regmap;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	regmap = sun20i_regulator_get_regmap(dev);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to get regmap\n");
+
+	config = (struct regulator_config) {
+		.dev	= dev,
+		.regmap	= regmap,
+	};
+
+	for (unsigned int i = 0; i < data->ndescs; ++i) {
+		const struct regulator_desc *desc = &data->descs[i];
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(dev, desc, &config);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sun20i_regulator_of_match[] = {
+	{
+		.compatible = "allwinner,sun20i-d1-system-ldos",
+		.data = &sun20i_d1_system_ldos,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun20i_regulator_of_match);
+
+static struct platform_driver sun20i_regulator_driver = {
+	.probe	= sun20i_regulator_probe,
+	.driver	= {
+		.name		= "sun20i-regulator",
+		.of_match_table	= sun20i_regulator_of_match,
+	},
+};
+module_platform_driver(sun20i_regulator_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Allwinner D1 internal LDO driver");
+MODULE_LICENSE("GPL");
-- 
2.37.4

