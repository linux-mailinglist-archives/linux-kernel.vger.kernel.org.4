Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1C646AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLHImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLHIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:41:41 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7BA6176F;
        Thu,  8 Dec 2022 00:41:39 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A39F6320090F;
        Thu,  8 Dec 2022 03:41:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Dec 2022 03:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670488897; x=1670575297; bh=EF
        RSFt1/aZCTYlWqrxkm0CD3+17p7uHxAAx3+tegaKg=; b=htRY6ARzay6iIlN5OB
        1IXWfXJ8QscHhk9OlGFJa4uCueZ57LgZrbTCT3YiWtthLY4ZR++BVjzQWfJODKFe
        d/eDBq3LhAr9VURgPl99/L7XsinqxKuCaaT6dRgjhwFllvcibk885Xmi5jneWMoW
        FTnJpEsW0PILgG4x3sEtQgEqRUowSEMIhJIRy0z/wWqkzKVM0tqWSpopGyOzk4V4
        nPAUiP9/oK6xHhlcJ1KVMNkxObwBLmvUlEqljxjN4V9MKsqr4JQNpM0VPTRnZ/KT
        0PCRvzPJonaIVONgnye8MwUI7k0lTrvZNvxkouyCoo6r1qrx9bptW4vQIsuawrWh
        eHzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670488897; x=1670575297; bh=EFRSFt1/aZCTY
        lWqrxkm0CD3+17p7uHxAAx3+tegaKg=; b=bOvzvcOT1P1EyfQcCUjIo9fEGo0b6
        BtZ4LutN/97bqSV/Utf1/5SXmjNZQHt468cZfX1mFFtZwIjzkvqO1suMT4pxK5fQ
        00yE+IZoipJBPPo3B0ObTQEVSWCu7Z4qOX3wmkDU0wGZFAEm1pbweSw9oRpu0siq
        ziZ2otQgqn7n+sIHk1zIMb94a+Wrf5BZ7SxLGtJXa2TQw1vrjxQ3ea/BfFydpAbL
        /aI5Qs4/psmEM2ATSQM8Qi8a+XVxFrMLv3GY+/PUjGn4mxaQM07rUID4Oxtdx9Vq
        rGKKpRsAmF9a9AlUfDzrXePiyBh5wLnPfqcPgZPxckMUPvq080aibTRgQ==
X-ME-Sender: <xms:QKORYzUFmIDvrHW4F8onaDl8HpSwK_GtwrHw88FAKb0JSJe9wUw7iA>
    <xme:QKORY7nxOWCFl2wv0F-Vx-wt65lerG5FJZhxzBtqpYQTGG70-2Uwgqfxd48BOpwBm
    k2kXPW7jpesoqHR3g>
X-ME-Received: <xmr:QKORY_Z5xEOGoBY34-uXYQgOeEOrXwdc7c1g6pQfRZLXTMlvN676Y3Zu2IJfgQgPYR3lJazCT8Kv23Smd3yre6q5RIDGjAEHhO3ZN9Y1L3GuPZXpGy8q9aAUhnuFWfq9oDPaCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:QKORY-Vd5mfegFQq0fgr136xmDSmfpfypE483VgSnaMpnuzoGixNDw>
    <xmx:QKORY9l80ZY3XN20L7NPKSqcjBNXqLsjV7q0NAoQ1U8bQvl2MUAshQ>
    <xmx:QKORY7e6TzT1qC-vRaJkCh-5VUf1uojmdIW6FSe_qOCsjztVnqQm8w>
    <xmx:QaORY_mt6SgAVeRnZv8hsT6oVxH_cec6r1xbTSY7lN4ZBuWequ2cwQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 03:41:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 2/4] regulator: sun20i: Add Allwinner D1 LDOs driver
Date:   Thu,  8 Dec 2022 02:41:25 -0600
Message-Id: <20221208084127.17443-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208084127.17443-1-samuel@sholland.org>
References: <20221208084127.17443-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
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

Changes in v5:
 - Correct the voltage calculation for the non-linearity around 1.6 V.

Changes in v4:
 - Drop the analog LDOs until the codec binding is ready

Changes in v3:
 - Adjust control flow in sun20i_regulator_get_regmap() for clarity

Changes in v2:
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle

 drivers/regulator/Kconfig            |   8 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sun20i-regulator.c | 156 +++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
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
index 000000000000..8af6b8037ee0
--- /dev/null
+++ b/drivers/regulator/sun20i-regulator.c
@@ -0,0 +1,156 @@
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
+	unsigned int fraction, uV;
+
+	if (selector >= desc->n_voltages)
+		return -EINVAL;
+
+	uV = desc->min_uV + (desc->uV_step * selector);
+	fraction = selector + (desc->min_uV % 4);
+
+	if (uV > 1606667)
+		uV += 6667;
+	else
+		fraction++;
+
+	/* Produce correctly-rounded absolute voltages. */
+	return uV + (fraction / 3);
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
+		.min_uV		= 1593333,
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

