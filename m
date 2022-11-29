Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5800F63C44E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiK2P55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiK2P5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5567532C8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so3051492wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+WYtC3mBmE4HBeCSm4jFYtF3t8u3124l8X3DjUJU0g=;
        b=Gr+WzChG268vUa1/GnjZjq3qBXwOqgYdVorT6Uqk0jxJ71GHzUb1Fahwqr3fkvTxh9
         JqM2DSyQC15D+uSiBI5oVAipxLHFITKIzU1Dg2or9mJm7FJFnerLDjd96NJOb5iHKXTa
         L/txJ9aCsGAukPuW0GbF0uAaw5REWkfQfprgJ9DP+xAyNU/t12jyT0avf/HwCDxVt+oK
         9Kf0a7DYLyseByVsH+iJvL5lTFieNdzlP3+9tbVg3yrCuQ0jYsMldDCziG0aXafdyGpw
         fwrhGr4pwecf2wY4acv4C595I28ku2R+Rfx+1M3s4tF7+L9Vpi3B7HVjwYW6ACwbI4Qr
         t1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+WYtC3mBmE4HBeCSm4jFYtF3t8u3124l8X3DjUJU0g=;
        b=DY+4m6J35Uov1xCxFqdELF9Xhnhb9sFr7i8HhTXy5pJCuWqJuQVohGKl4AdUEqIpun
         5uzrWPQOpjxC+4PVjN9uU1tKj//8KwHVondCIBoi2W/Tpi8GTjKjOQYFNS7d7cMYUwX0
         5WsYUiuVo91mldE0pHMcMd/NvTZI1/AFqtSB5U5hDfJneoUXYnNHjZRGNyfJf4H/IXjn
         XCSL6NKmPtA0vdu8Nb1z/BhJWMy7gXPXCMy+ngWQEnXtdxA/YmNnFPKOZBX9/ttj29gr
         k5FAyTUqzp7G5NOD7wg5b5SsATrK0oNL85o5SHTMxF6kU1bY8jSu9PV2I7tRnwX0u+Eh
         vlsw==
X-Gm-Message-State: ANoB5plGTCUxouQZ2p/UqS5H0/4EkCP0ZHpSTiZhej6N2sSAM5VOOL9+
        YVpftl73I1fbh2kOQXu6Qdvweg==
X-Google-Smtp-Source: AA0mqf6AnwgQtyc09YNqbgKM5azFIKgZgTCjxTXgKFg6wK75M36RgKgKh5F/KEo8LCjh1D+jykXO4w==
X-Received: by 2002:adf:f845:0:b0:236:557c:24af with SMTP id d5-20020adff845000000b00236557c24afmr35788182wrq.636.1669737433024;
        Tue, 29 Nov 2022 07:57:13 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f2-20020a7bc8c2000000b003cfb7c02542sm2601550wml.11.2022.11.29.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:57:12 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 29 Nov 2022 16:57:06 +0100
Subject: [PATCH v7 7/8] regulator: add mt6357 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v7-7-477e60126749@baylibre.com>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=15592;
 i=amergnat@baylibre.com; h=from:subject:message-id;
 bh=FjHm7XarKGTIp+0w1oTz5v6T1oFuXdTPbkzeC2DNWpw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjhivPVkIO44o3cphM9/dPml9o8z0G8tNksl1vPGQk
 kRZmwbmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4YrzwAKCRArRkmdfjHURQRaD/
 4o7AhqXeXoLIYvVT4SYTPyCVScOmQONdqcsYv6SdfSV7zprdVUtfQYHu3j4Dz17cCyQrkP62upcLG3
 T6fqCO4+sERdWObBGqdxI4zDervemIagPDjhPUa4W7borkYp/ATR91B9C38wgsyZ4QTBda74whzeqN
 uias3y9BX2KzGjyCBs4hUHvz60IxEIIf7VOEiGDerkjdzvsEwaFoZUesP+o2xXv4EUEhx/xtRPPZuO
 ObpsoWaPq3HuCdVb4nzsGogacg6UOf6VwUOUFzAyMXjpfhuCqVJvlCP+k3kd9sx1R3wvhaPWtfbAWP
 mmEEQBk0tMkMgoxEeOIbPEpzc9s2npB24f71jthExZUg0aa9wXxKXye8esErghODnZYFuPkz4oKldA
 u+FNsS/YUYUB/uTULh9n6FmApf5GVLQrfXXwIUkoVlLLL/XHJn3pzHU9MRi8cp4vhC9mfIAye8hoFs
 xKL/wvqzlxfLz9EBK+fcutQLM8AFtyYPWonGQaWpBCKNnH3opUdvRVAohjD/nPm7V5sx0+1XGM6cM8
 Tikgof4WSQW+puJXVcQJNLOXLz6oY1eqnHCqXgIzC/OHCy6gni6RkUEsM/AcscXKtim/iOpZX1EGpn
 Jf19MV4Qs51I+FekAzbAjNO5FDmnWozvGy1JaADThl8nx5nBqLzL2x8ZWTmw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add regulator driver for the MT6357 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6357-regulator.c       | 453 +++++++++++++++++++++++++++++
 include/linux/regulator/mt6357-regulator.h |  51 ++++
 4 files changed, 514 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 070e4403c6c2..a659a57438f4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -805,6 +805,15 @@ config REGULATOR_MT6332
 	  This driver supports the control of different power rails of device
 	  through regulator interface
 
+config REGULATOR_MT6357
+	tristate "MediaTek MT6357 PMIC"
+	depends on MFD_MT6397
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6357 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6358
 	tristate "MediaTek MT6358 PMIC"
 	depends on MFD_MT6397
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5962307e1130..e4d67b7b1af6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
+obj-$(CONFIG_REGULATOR_MT6357)	+= mt6357-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
diff --git a/drivers/regulator/mt6357-regulator.c b/drivers/regulator/mt6357-regulator.c
new file mode 100644
index 000000000000..b2352b96aed2
--- /dev/null
+++ b/drivers/regulator/mt6357-regulator.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Copyright (c) 2022 BayLibre, SAS.
+// Author: Chen Zhong <chen.zhong@mediatek.com>
+// Author: Fabien Parent <fparent@baylibre.com>
+// Author: Alexandre Mergnat <amergnat@baylibre.com>
+//
+// Based on mt6397-regulator.c
+//
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6357/registers.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6357-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+/*
+ * MT6357 regulators' information
+ *
+ * @desc: standard fields of regulator description.
+ * @da_vsel_reg: Monitor register for query buck's voltage.
+ * @da_vsel_mask: Mask for query buck's voltage.
+ */
+struct mt6357_regulator_info {
+	struct regulator_desc desc;
+	u32 da_vsel_reg;
+	u32 da_vsel_mask;
+};
+
+#define MT6357_BUCK(match, vreg, min, max, step,		\
+	volt_ranges, vosel_reg, vosel_mask, _da_vsel_mask)	\
+[MT6357_ID_##vreg] = {		\
+	.desc = {		\
+		.name = #vreg,	\
+		.of_match = of_match_ptr(match),		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6357_volt_range_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = MT6357_ID_##vreg,		\
+		.owner = THIS_MODULE,		\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.linear_ranges = volt_ranges,			\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.vsel_reg = vosel_reg,		\
+		.vsel_mask = vosel_mask,	\
+		.enable_reg = MT6357_BUCK_##vreg##_CON0,	\
+		.enable_mask = BIT(0),		\
+	},	\
+	.da_vsel_reg = MT6357_BUCK_##vreg##_DBG0,		\
+	.da_vsel_mask = vosel_mask,		\
+}
+
+#define MT6357_LDO(match, vreg, ldo_volt_table,	\
+	enreg, vosel, vosel_mask)		\
+[MT6357_ID_##vreg] = {		\
+	.desc = {		\
+		.name = #vreg,	\
+		.of_match = of_match_ptr(match),		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6357_volt_table_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = MT6357_ID_##vreg,		\
+		.owner = THIS_MODULE,		\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),	\
+		.volt_table = ldo_volt_table,	\
+		.vsel_reg = vosel,		\
+		.vsel_mask = vosel_mask,	\
+		.enable_reg = enreg,		\
+		.enable_mask = BIT(0),		\
+	},	\
+}
+
+#define MT6357_LDO1(match, vreg, min, max, step, volt_ranges,	\
+	enreg, vosel, vosel_mask)		\
+[MT6357_ID_##vreg] = {		\
+	.desc = {		\
+		.name = #vreg,	\
+		.of_match = of_match_ptr(match),		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6357_volt_range_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = MT6357_ID_##vreg,		\
+		.owner = THIS_MODULE,		\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.linear_ranges = volt_ranges,	\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.vsel_reg = vosel,		\
+		.vsel_mask = vosel_mask,	\
+		.enable_reg = enreg,		\
+		.enable_mask = BIT(0),		\
+	},	\
+	.da_vsel_reg = MT6357_LDO_##vreg##_DBG0,		\
+	.da_vsel_mask = 0x7f00,	\
+}
+
+#define MT6357_REG_FIXED(match, vreg, volt)	\
+[MT6357_ID_##vreg] = {					\
+	.desc = {					\
+		.name = #vreg,				\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = "regulators",	\
+		.ops = &mt6357_volt_fixed_ops,		\
+		.type = REGULATOR_VOLTAGE,		\
+		.id = MT6357_ID_##vreg,			\
+		.owner = THIS_MODULE,			\
+		.n_voltages = 1,			\
+		.enable_reg = MT6357_LDO_##vreg##_CON0,	\
+		.enable_mask = BIT(0),			\
+		.min_uV = volt,				\
+	},						\
+}
+
+/**
+ * mt6357_get_buck_voltage_sel - get_voltage_sel for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * da_vsel_reg and da_vsel_mask fields in the info structure and
+ * then use this as their get_voltage_vsel operation.
+ */
+static int mt6357_get_buck_voltage_sel(struct regulator_dev *rdev)
+{
+	int ret, regval;
+	struct mt6357_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev,
+			"Failed to get mt6357 Buck %s vsel reg: %d\n",
+			info->desc.name, ret);
+		return ret;
+	}
+
+	regval &= info->da_vsel_mask;
+	regval >>= ffs(info->da_vsel_mask) - 1;
+
+	return regval;
+}
+
+static const struct regulator_ops mt6357_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = mt6357_get_buck_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_ops mt6357_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_ops mt6357_volt_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const int vxo22_voltages[] = {
+	2200000,
+	0,
+	2400000,
+};
+
+static const int vefuse_voltages[] = {
+	1200000,
+	1300000,
+	1500000,
+	0,
+	1800000,
+	0,
+	0,
+	0,
+	0,
+	2800000,
+	2900000,
+	3000000,
+	0,
+	3300000,
+};
+
+static const int vcn33_voltages[] = {
+	0,
+	3300000,
+	3400000,
+	3500000,
+};
+
+static const int vcama_voltages[] = {
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	2500000,
+	0,
+	0,
+	2800000,
+};
+
+static const int vcamd_voltages[] = {
+	0,
+	0,
+	0,
+	0,
+	1000000,
+	1100000,
+	1200000,
+	1300000,
+	0,
+	1500000,
+	0,
+	0,
+	1800000,
+};
+
+static const int vldo28_voltages[] = {
+	0,
+	2800000,
+	0,
+	3000000,
+};
+
+static const int vdram_voltages[] = {
+	0,
+	1100000,
+	1200000,
+};
+
+static const int vsim_voltages[] = {
+	0,
+	0,
+	0,
+	1700000,
+	1800000,
+	0,
+	0,
+	0,
+	2700000,
+	0,
+	0,
+	3000000,
+	3100000,
+};
+
+static const int vibr_voltages[] = {
+	1200000,
+	1300000,
+	1500000,
+	0,
+	1800000,
+	2000000,
+	0,
+	0,
+	0,
+	2800000,
+	0,
+	3000000,
+	0,
+	3300000,
+};
+
+static const int vmc_voltages[] = {
+	0,
+	0,
+	0,
+	0,
+	1800000,
+	0,
+	0,
+	0,
+	0,
+	0,
+	2900000,
+	3000000,
+	0,
+	3300000,
+};
+
+static const int vmch_voltages[] = {
+	0,
+	0,
+	2900000,
+	3000000,
+	0,
+	3300000,
+};
+
+static const int vemc_voltages[] = {
+	0,
+	0,
+	2900000,
+	3000000,
+	0,
+	3300000,
+};
+
+static const int vusb_voltages[] = {
+	0,
+	0,
+	0,
+	3000000,
+	3100000,
+};
+
+static const struct linear_range buck_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(518750, 0, 0x7f, 6250),
+};
+
+static const struct linear_range buck_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
+};
+
+static const struct linear_range buck_volt_range3[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
+};
+
+static const struct linear_range buck_volt_range4[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 0x7f, 12500),
+};
+
+/* The array is indexed by id(MT6357_ID_XXX) */
+static struct mt6357_regulator_info mt6357_regulators[] = {
+	/* Bucks */
+	MT6357_BUCK("buck-vcore", VCORE, 518750, 1312500, 6250,
+		buck_volt_range1, MT6357_BUCK_VCORE_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vproc", VPROC, 518750, 1312500, 6250,
+		buck_volt_range1, MT6357_BUCK_VPROC_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vmodem", VMODEM, 500000, 1293750, 6250,
+		buck_volt_range2, MT6357_BUCK_VMODEM_ELR0, 0x7f, 0x7f),
+	MT6357_BUCK("buck-vpa", VPA, 500000, 3650000, 50000,
+		buck_volt_range3, MT6357_BUCK_VPA_CON1, 0x3f, 0x3f),
+	MT6357_BUCK("buck-vs1", VS1, 1200000, 2787500, 12500,
+		buck_volt_range4, MT6357_BUCK_VS1_ELR0, 0x7f, 0x7f),
+
+	/* LDOs */
+	MT6357_LDO("ldo-vcama", VCAMA, vcama_voltages,
+		   MT6357_LDO_VCAMA_CON0, MT6357_VCAMA_ANA_CON0, 0xf00),
+	MT6357_LDO("ldo-vcamd", VCAMD, vcamd_voltages,
+		   MT6357_LDO_VCAMD_CON0, MT6357_VCAMD_ANA_CON0, 0xf00),
+	MT6357_LDO("ldo-vcn33-bt", VCN33_BT, vcn33_voltages,
+		   MT6357_LDO_VCN33_CON0_0, MT6357_VCN33_ANA_CON0, 0x300),
+	MT6357_LDO("ldo-vcn33-wifi", VCN33_WIFI, vcn33_voltages,
+		   MT6357_LDO_VCN33_CON0_1, MT6357_VCN33_ANA_CON0, 0x300),
+	MT6357_LDO("ldo-vdram", VDRAM, vdram_voltages,
+		   MT6357_LDO_VDRAM_CON0, MT6357_VDRAM_ELR_2, 0x300),
+	MT6357_LDO("ldo-vefuse", VEFUSE, vefuse_voltages,
+		   MT6357_LDO_VEFUSE_CON0, MT6357_VEFUSE_ANA_CON0, 0xf00),
+	MT6357_LDO("ldo-vemc", VEMC, vemc_voltages,
+		   MT6357_LDO_VEMC_CON0, MT6357_VEMC_ANA_CON0, 0x700),
+	MT6357_LDO("ldo-vibr", VIBR, vibr_voltages,
+		   MT6357_LDO_VIBR_CON0, MT6357_VIBR_ANA_CON0, 0xf00),
+	MT6357_LDO("ldo-vldo28", VLDO28, vldo28_voltages,
+		   MT6357_LDO_VLDO28_CON0_0, MT6357_VLDO28_ANA_CON0, 0x300),
+	MT6357_LDO("ldo-vmc", VMC, vmc_voltages,
+		   MT6357_LDO_VMC_CON0, MT6357_VMC_ANA_CON0, 0xf00),
+	MT6357_LDO("ldo-vmch", VMCH, vmch_voltages,
+		   MT6357_LDO_VMCH_CON0, MT6357_VMCH_ANA_CON0, 0x700),
+	MT6357_LDO("ldo-vsim1", VSIM1, vsim_voltages,
+		   MT6357_LDO_VSIM1_CON0, MT6357_VSIM1_ANA_CON0, 0xf00),
+	MT6357_LDO("ldo-vsim2", VSIM2, vsim_voltages,
+		   MT6357_LDO_VSIM2_CON0, MT6357_VSIM2_ANA_CON0, 0xf00),
+	MT6357_LDO("ldo-vusb33", VUSB33, vusb_voltages,
+		   MT6357_LDO_VUSB33_CON0_0, MT6357_VUSB33_ANA_CON0, 0x700),
+	MT6357_LDO("ldo-vxo22", VXO22, vxo22_voltages,
+		   MT6357_LDO_VXO22_CON0, MT6357_VXO22_ANA_CON0, 0x300),
+
+	MT6357_LDO1("ldo-vsram-proc", VSRAM_PROC, 518750, 1312500, 6250,
+		   buck_volt_range1, MT6357_LDO_VSRAM_PROC_CON0,
+		   MT6357_LDO_VSRAM_CON0, 0x7f00),
+	MT6357_LDO1("ldo-vsram-others", VSRAM_OTHERS, 518750, 1312500, 6250,
+		   buck_volt_range1, MT6357_LDO_VSRAM_OTHERS_CON0,
+		   MT6357_LDO_VSRAM_CON1, 0x7f00),
+
+	MT6357_REG_FIXED("ldo-vaud28", VAUD28, 2800000),
+	MT6357_REG_FIXED("ldo-vaux18", VAUX18, 1800000),
+	MT6357_REG_FIXED("ldo-vcamio18", VCAMIO, 1800000),
+	MT6357_REG_FIXED("ldo-vcn18", VCN18, 1800000),
+	MT6357_REG_FIXED("ldo-vcn28", VCN28, 2800000),
+	MT6357_REG_FIXED("ldo-vfe28", VFE28, 2800000),
+	MT6357_REG_FIXED("ldo-vio18", VIO18, 1800000),
+	MT6357_REG_FIXED("ldo-vio28", VIO28, 2800000),
+	MT6357_REG_FIXED("ldo-vrf12", VRF12, 1200000),
+	MT6357_REG_FIXED("ldo-vrf18", VRF18, 1800000),
+};
+
+static int mt6357_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6357 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+
+	pdev->dev.of_node = pdev->dev.parent->of_node;
+
+	for (i = 0; i < MT6357_MAX_REGULATOR; i++) {
+		config.dev = &pdev->dev;
+		config.driver_data = &mt6357_regulators[i];
+		config.regmap = mt6357->regmap;
+
+		rdev = devm_regulator_register(&pdev->dev,
+					       &mt6357_regulators[i].desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n",
+				mt6357_regulators[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id mt6357_platform_ids[] = {
+	{ "mt6357-regulator" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6357_platform_ids);
+
+static struct platform_driver mt6357_regulator_driver = {
+	.driver = {
+		.name = "mt6357-regulator",
+	},
+	.probe = mt6357_regulator_probe,
+	.id_table = mt6357_platform_ids,
+};
+
+module_platform_driver(mt6357_regulator_driver);
+
+MODULE_AUTHOR("Chen Zhong <chen.zhong@mediatek.com>");
+MODULE_AUTHOR("Fabien Parent <fabien.parent@linaro.org>");
+MODULE_AUTHOR("Alexandre Mergnat <amergnat@baylibre.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6357 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6357-regulator.h b/include/linux/regulator/mt6357-regulator.h
new file mode 100644
index 000000000000..238b1ee77ea6
--- /dev/null
+++ b/include/linux/regulator/mt6357-regulator.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __LINUX_REGULATOR_MT6357_H
+#define __LINUX_REGULATOR_MT6357_H
+
+enum {
+	/* Bucks */
+	MT6357_ID_VCORE,
+	MT6357_ID_VMODEM,
+	MT6357_ID_VPA,
+	MT6357_ID_VPROC,
+	MT6357_ID_VS1,
+
+	/* LDOs */
+	MT6357_ID_VAUX18,
+	MT6357_ID_VAUD28,
+	MT6357_ID_VCAMA,
+	MT6357_ID_VCAMD,
+	MT6357_ID_VCAMIO,
+	MT6357_ID_VCN18,
+	MT6357_ID_VCN28,
+	MT6357_ID_VCN33_BT,
+	MT6357_ID_VCN33_WIFI,
+	MT6357_ID_VDRAM,
+	MT6357_ID_VEFUSE,
+	MT6357_ID_VEMC,
+	MT6357_ID_VFE28,
+	MT6357_ID_VIBR,
+	MT6357_ID_VIO18,
+	MT6357_ID_VIO28,
+	MT6357_ID_VLDO28,
+	MT6357_ID_VMC,
+	MT6357_ID_VMCH,
+	MT6357_ID_VRF12,
+	MT6357_ID_VRF18,
+	MT6357_ID_VSIM1,
+	MT6357_ID_VSIM2,
+	MT6357_ID_VSRAM_OTHERS,
+	MT6357_ID_VSRAM_PROC,
+	MT6357_ID_VUSB33,
+	MT6357_ID_VXO22,
+
+	MT6357_ID_RG_MAX,
+};
+
+#define MT6357_MAX_REGULATOR	MT6357_ID_RG_MAX
+
+#endif /* __LINUX_REGULATOR_MT6357_H */

-- 
b4 0.10.1
