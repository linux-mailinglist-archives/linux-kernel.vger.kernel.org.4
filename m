Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31C703E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbjEOULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245226AbjEOUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:10:54 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EDC11DAC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181437; bh=NeONf/OB1wpHbPr9PJ9+zKUm4X/VQx781QdHWwD0J3M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l7RG81VvlKdlcU1sny3bNtnIHOWOTQ3Y/EGugzqAnFtOYDv3U1jdNtSfgXpIOwvxdIKDe3SyEl/BNP9EiNoqCDTtAg36gmvrWCOvDGw5xrT1xg30IWiMs0+ir9NqsM9kme9u/kiL1S3U0XObiTONXAG3qY8gi6kITuxreXS0o5YzRKAluLOhI3t7zzNLpzBezeNz3/y/TMczpKHZcDYu3iMFd12SFMtVdHhFsuzH3MEjxpI97xvSxa06L0BvH1u+olKSHMHjVsswHffuRp4y/TqI3zNwo4mhbhEbQsBcdL2zZ7FwMa3tDKOHOTLcixchD7aCyjQzaMOkyszVkCmpXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181437; bh=PVdf7hd4x3ceXsd5uqIqoAUuqpFqla09jXa3O8BOJ2h=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fmqK/F0QSZiyvd30sAx6CnWp1pQF1xOGXO5l88VBPbRx3s2fTDGR7h99V46Txca9F03Sgn6nXZ0lAMem9y0xqDiy5GnJglBWSHSFiKWJyhq/8/XupaCkDo0PO3u9f5Nk+tkWbKf0rOIUgOZyy3QdFWQ7jir/INClr0CRN/vs8VZFjqPw3hUjzc1/sd6uhfUPOfC28ctkiGpojBbc+Hp57fqFvOQv0yVDQRKUg/uzQwKsa4yi9m06M2n1ZnE9WAsUfbHky7Ff8gLyh0RsM8cpt92z6UU75QqeOKOJwujbUvfB4Ixxw3jcPw68kY6fTqi1gANyNsZifaZdisBHagumIQ==
X-YMail-OSG: zEdHFvgVM1mXTA1jvk2.wu50K2I2hHusr4IShIe5iStiTwpYw.wqou.BsckUNQU
 CL1LEsRjgICpueTl8MTjFeL1pk_.hrC8BPX_Vdw4xU7qT2rDrlpwMtgYGDdPJ1IJKlNaM2uctqja
 UuljJlZ22T11SziUXnDhDcKaIInTt6pF52BNyKfH5WlH5LVSsVXt81HUMjMrGg.xvcQLJMOwPiuZ
 okTj.ReJq1NJ2T3L8lYUb4hKH49g1X9DeZzaMt8wLInBEFCYmxq_f9f9V1dkUcXt0dK3Js8mewEJ
 EMivQulqZx5Hk7jRWkvx3aWT7FUMwT9fV3Je7eiTTDqjST3Di_xcIP8hQbohI5nRK20TwXyimbEe
 .6Zs0W6r.FpzeDIaXusKJ8f5W2Ec0AAZAGWvh3H9xJYgDxjTDhTU9_gF1Ne9Q51AS.I2leckJFPi
 nhYHsUS8ve1O5ArXcx0FKbRJzG8zwuDfI1ld1MtWbe3qh1aPCYLRqisSf36VE6Q5nNx7QQGAo.Du
 bIAEcybxKHnhEJB_htNFz0A7AVMVJPxOxR1.Ds2EkKaI7btzTqj6EgqT3vWSIux2Kql4kX56PVWs
 Azbq5CiV26fygG.oizRjxlQy381F8heYvQ087JIx68d4GloLky0L.aJ9rxYr.32C9eBkYA_kR0LB
 AH7ZU4pNAVdoBrjkK44FZaaZJFNaEJSdbIPS.GKeAx6Oeypt3MgYv9zEh8Pym_O8YfoQn5aZ5sGa
 DBwgRLKA37y6zu3m8mHydiK9zBHkphgrMoxIIKZUiLhMePVVLWCcKSULidlywxYqkHSlgjpN62vB
 w70Zhu8wv3tB3cc.CcLDL0VWbzJvQ2iki0O9e7fXm.Nro68fr2Rf2ZiYFxI_hH4DuWGf8aNdBM4n
 3u.BcrroyAoZLudiK.Hvoy4AQWbmnufWgDffGDuDEsNKmDAwG5n1kRE_LRMwfguT2ataLTcmSxwz
 qMZqtHkH.HRZMZDP5AkelrqOkhP12Mm5ko.rcihet023JPGsLC2BVFpxr__eTu_.Xwszd2.wRqqs
 1DFtzBlBSe4tAnJuakF0GenWf6YKMzuDYWDz3LroKFX4hjH.9NIQDdOGkrgq2pF2tsJ5SPT.G7pC
 jVnaF15kNk_3Mves48tXNC_k_q.iNJq8mUhpgMDslvfljy6cfarORqaFi6BvMBpqnsL8IiXjSaym
 6UDJtYdqKVCpk6KupPaizsC2jzq4KEInyfkidUL7IDfSTDApJ1b0q1yyOLsMRVrZE9QhGqgEMUB6
 XY7u3xB3RXBM4sr9I_rGycifP7YGJu8NjFGoaBpi3vhnJvBwIqa._CeN3r_tEBSEuhHdr2xzxBgi
 ZMY2rafaQHeG_8upTkZDu495LCGdYoJkyQqzpxhSMjS4k4qZuV_9vDH58JCUGmPX0LqPcNgY1a76
 t3vQh0CcU4u4vQuu0cJmUgWmvnWpn3.3UExPUCI1nc62U6Z3WEk9tcpMR3yIkYyx5Pi8kcTPSu48
 EEZcDqpa4d3WMoW1ei9lzJfUwmW3XGT0FDwIhGRMexcxurGupsUUdi_Nhd8bkj1SLjfc1Rm3o1Ny
 OaFbITfSsYy28SrioC81xv_GhakKXPe1iXAt_Ry2nIjZf.0uWnfoHStxWHmyQcvd.ZQWmlghVgvC
 BDqcJW7JMsaZB_w4AG30cy5GqTF6xpqWLVCe9y9rpAiJtK7vOgHsLnktcI_PcNGf7zYyleVpOPpW
 RG01DW5WAa8HT6_2i7bgM8sklpPsQiJVEFmrWkY0QwW.OSUTMoQMFuZXUMNuqc6jygSZUXiPWSA0
 mmz890FSYyHmGDkgi3bkvb8fdRfQdIG_WbTbz2rYJzq20GbajtFrQQH04Bhc4X3lQBU2mab112Ow
 AgaDvBa96IEvWIEfpw5u3lJkYnbnmUs41jSrqma3puG3zSJWXnRFLdoReSwY0rk6VoDdu7iuOcwn
 z729arrZSbF40_cZC7rDgfT0vbUNBmrilvCsF1rzPbas9Pc3C1WGfs5dA0WAkpAFKL0XDdpLksf8
 yF3O6Ci6Hy3wO6m04oBXBK4y49.pyS3tQTIDoq.cQSWCPSKcW6HXczDZ.dpG5jrWFn9pSN6P9XVm
 FG_EoGyFDloUOKnbjq_nRYILS2XfhkYgFyIm2eDUpDqFoM27U28og4L7X.doyIyHoP6DX_XR5HUZ
 IvKBTf7BgLOxBxrpY_tPNutjC9EZxO2qj1ciuWCS7pkddR2PjfEMj8DVwxatSBlEr.AxLvQd_a2A
 127vxKM81N0pilTpHWKmGRNijIyryCv5TydS5K5l23VOoXYf.Iq_tvElCN084h1VLi2HQWqulP2W
 hzNpbTYLNQ1UVb3kFj_cveUYUKajZ
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 08479133-b008-4bf2-bdcf-320118158db9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:10:37 +0000
Received: by hermes--production-ir2-7867f454fc-nvr6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7905ff065b8716c1e39bbada6be8236;
          Mon, 15 May 2023 20:10:32 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 05/10] power: supply: rt5033_charger: Add RT5033 charger device driver
Date:   Mon, 15 May 2023 22:09:57 +0200
Message-Id: <20230515201002.29599-6-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201002.29599-1-jahau@rocketmail.com>
References: <20230515201002.29599-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device driver of Richtek RT5033 PMIC. The driver supports
switching charger. rt5033 charger provides three charging modes. The charging
modes are pre-charge mode, fast charge mode and constant voltage mode. They
vary in charge rate, the charge parameters can be controlled by i2c interface.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/Kconfig          |   8 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/rt5033_charger.c | 472 ++++++++++++++++++++++++++
 include/linux/mfd/rt5033.h            |  16 -
 4 files changed, 481 insertions(+), 16 deletions(-)
 create mode 100644 drivers/power/supply/rt5033_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c78be9f322e6..ea11797670ca 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -766,6 +766,14 @@ config BATTERY_RT5033
 	  The fuelgauge calculates and determines the battery state of charge
 	  according to battery open circuit voltage.
 
+config CHARGER_RT5033
+	tristate "RT5033 battery charger support"
+	depends on MFD_RT5033
+	help
+	  This adds support for battery charger in Richtek RT5033 PMIC.
+	  The device supports pre-charge mode, fast charge mode and
+	  constant voltage mode.
+
 config CHARGER_RT9455
 	tristate "Richtek RT9455 battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4adbfba02d05..dfc624bbcf1d 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
+obj-$(CONFIG_CHARGER_RT5033)	+= rt5033_charger.o
 obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
 obj-$(CONFIG_CHARGER_RT9467)	+= rt9467-charger.o
 obj-$(CONFIG_CHARGER_RT9471)	+= rt9471.o
diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
new file mode 100644
index 000000000000..5218dfbf5e1b
--- /dev/null
+++ b/drivers/power/supply/rt5033_charger.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Battery charger driver for RT5033
+ *
+ * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
+ * Author: Beomho Seo <beomho.seo@samsung.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/mfd/rt5033-private.h>
+
+struct rt5033_charger_data {
+	unsigned int pre_uamp;
+	unsigned int pre_uvolt;
+	unsigned int const_uvolt;
+	unsigned int eoc_uamp;
+	unsigned int fast_uamp;
+};
+
+struct rt5033_charger {
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct power_supply		*psy;
+	struct rt5033_charger_data	*chg;
+};
+
+static int rt5033_get_charger_state(struct rt5033_charger *charger)
+{
+	struct regmap *regmap = charger->regmap;
+	unsigned int reg_data;
+	int state;
+
+	if (!regmap)
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+
+	regmap_read(regmap, RT5033_REG_CHG_STAT, &reg_data);
+
+	switch (reg_data & RT5033_CHG_STAT_MASK) {
+	case RT5033_CHG_STAT_DISCHARGING:
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case RT5033_CHG_STAT_CHARGING:
+		state = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case RT5033_CHG_STAT_FULL:
+		state = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case RT5033_CHG_STAT_NOT_CHARGING:
+		state = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	default:
+		state = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return state;
+}
+
+static int rt5033_get_charger_type(struct rt5033_charger *charger)
+{
+	struct regmap *regmap = charger->regmap;
+	unsigned int reg_data;
+	int state;
+
+	regmap_read(regmap, RT5033_REG_CHG_STAT, &reg_data);
+
+	switch (reg_data & RT5033_CHG_STAT_TYPE_MASK) {
+	case RT5033_CHG_STAT_TYPE_FAST:
+		state = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case RT5033_CHG_STAT_TYPE_PRE:
+		state = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	default:
+		state = POWER_SUPPLY_CHARGE_TYPE_NONE;
+	}
+
+	return state;
+}
+
+static int rt5033_get_charger_current_limit(struct rt5033_charger *charger)
+{
+	struct regmap *regmap = charger->regmap;
+	unsigned int state, reg_data, data;
+
+	regmap_read(regmap, RT5033_REG_CHG_CTRL5, &reg_data);
+
+	state = (reg_data & RT5033_CHGCTRL5_ICHG_MASK)
+		 >> RT5033_CHGCTRL5_ICHG_SHIFT;
+
+	data = RT5033_CHARGER_FAST_CURRENT_MIN +
+		RT5033_CHARGER_FAST_CURRENT_STEP_NUM * state;
+
+	return data;
+}
+
+static int rt5033_get_charger_const_voltage(struct rt5033_charger *charger)
+{
+	struct regmap *regmap = charger->regmap;
+	unsigned int state, reg_data, data;
+
+	regmap_read(regmap, RT5033_REG_CHG_CTRL2, &reg_data);
+
+	state = (reg_data & RT5033_CHGCTRL2_CV_MASK)
+		 >> RT5033_CHGCTRL2_CV_SHIFT;
+
+	data = RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN +
+		RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM * state;
+
+	return data;
+}
+
+static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
+{
+	struct rt5033_charger_data *chg = charger->chg;
+	int ret;
+	unsigned int val;
+	u8 reg_data;
+
+	/* Set constant voltage mode */
+	if (chg->const_uvolt < RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN ||
+	    chg->const_uvolt > RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX) {
+		dev_err(charger->dev,
+			"Value 'constant-charge-voltage-max-microvolt' out of range\n");
+		return -EINVAL;
+	}
+
+	if (chg->const_uvolt == RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN)
+		reg_data = 0x00;
+	else if (chg->const_uvolt == RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX)
+		reg_data = RT5033_CV_MAX_VOLTAGE;
+	else {
+		val = chg->const_uvolt;
+		val -= RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN;
+		val /= RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM;
+		reg_data = val;
+	}
+
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
+			RT5033_CHGCTRL2_CV_MASK,
+			reg_data << RT5033_CHGCTRL2_CV_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed regmap update\n");
+		return -EINVAL;
+	}
+
+	/* Set end of charge current */
+	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
+	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
+		dev_err(charger->dev,
+			"Value 'charge-term-current-microamp' out of range\n");
+		return -EINVAL;
+	}
+
+	if (chg->eoc_uamp == RT5033_CHARGER_EOC_MIN)
+		reg_data = 0x01;
+	else if (chg->eoc_uamp == RT5033_CHARGER_EOC_MAX)
+		reg_data = 0x07;
+	else {
+		val = chg->eoc_uamp;
+		if (val < RT5033_CHARGER_EOC_REF) {
+			val -= RT5033_CHARGER_EOC_MIN;
+			val /= RT5033_CHARGER_EOC_STEP_NUM1;
+			reg_data = 0x01 + val;
+		} else if (val > RT5033_CHARGER_EOC_REF) {
+			val -= RT5033_CHARGER_EOC_REF;
+			val /= RT5033_CHARGER_EOC_STEP_NUM2;
+			reg_data = 0x04 + val;
+		} else {
+			reg_data = 0x04;
+		}
+	}
+
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL4,
+			RT5033_CHGCTRL4_EOC_MASK, reg_data);
+	if (ret) {
+		dev_err(charger->dev, "Failed regmap update\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int rt5033_init_fast_charge(struct rt5033_charger *charger)
+{
+	struct rt5033_charger_data *chg = charger->chg;
+	int ret;
+	unsigned int val;
+	u8 reg_data;
+
+	/* Set limit input current */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_IAICR_MASK, RT5033_AICR_2000_MODE);
+	if (ret) {
+		dev_err(charger->dev, "Failed regmap update\n");
+		return -EINVAL;
+	}
+
+	/* Set fast-charge mode charging current */
+	if (chg->fast_uamp < RT5033_CHARGER_FAST_CURRENT_MIN ||
+	    chg->fast_uamp > RT5033_CHARGER_FAST_CURRENT_MAX) {
+		dev_err(charger->dev,
+			"Value 'constant-charge-current-max-microamp' out of range\n");
+		return -EINVAL;
+	}
+
+	if (chg->fast_uamp == RT5033_CHARGER_FAST_CURRENT_MIN)
+		reg_data = 0x00;
+	else if (chg->fast_uamp == RT5033_CHARGER_FAST_CURRENT_MAX)
+		reg_data = RT5033_CHG_MAX_CURRENT;
+	else {
+		val = chg->fast_uamp;
+		val -= RT5033_CHARGER_FAST_CURRENT_MIN;
+		val /= RT5033_CHARGER_FAST_CURRENT_STEP_NUM;
+		reg_data = val;
+	}
+
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL5,
+			RT5033_CHGCTRL5_ICHG_MASK,
+			reg_data << RT5033_CHGCTRL5_ICHG_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed regmap update\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int rt5033_init_pre_charge(struct rt5033_charger *charger)
+{
+	struct rt5033_charger_data *chg = charger->chg;
+	int ret;
+	unsigned int val;
+	u8 reg_data;
+
+	/* Set pre-charge threshold voltage */
+	if (chg->pre_uvolt < RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN ||
+	    chg->pre_uvolt > RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MAX) {
+		dev_err(charger->dev,
+			"Value 'precharge-upper-limit-microvolt' out of range\n");
+		return -EINVAL;
+	}
+
+	if (chg->pre_uvolt == RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN)
+		reg_data = 0x00;
+	else if (chg->pre_uvolt == RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MAX)
+		reg_data = 0x0f;
+	else {
+		val = chg->pre_uvolt;
+		val -= RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN;
+		val /= RT5033_CHARGER_PRE_THRESHOLD_STEP_NUM;
+		reg_data = val;
+	}
+
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL5,
+			RT5033_CHGCTRL5_VPREC_MASK, reg_data);
+	if (ret) {
+		dev_err(charger->dev, "Failed regmap update\n");
+		return -EINVAL;
+	}
+
+	/* Set pre-charge mode charging current */
+	if (chg->pre_uamp < RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN ||
+	    chg->pre_uamp > RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX) {
+		dev_err(charger->dev,
+			"Value 'precharge-current-microamp' out of range\n");
+		return -EINVAL;
+	}
+
+	if (chg->pre_uamp == RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN)
+		reg_data = 0x00;
+	else if (chg->pre_uamp == RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX)
+		reg_data = RT5033_CHG_MAX_PRE_CURRENT;
+	else {
+		val = chg->pre_uamp;
+		val -= RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN;
+		val /= RT5033_CHARGER_PRE_CURRENT_STEP_NUM;
+		reg_data = val;
+	}
+
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL4,
+			RT5033_CHGCTRL4_IPREC_MASK,
+			reg_data << RT5033_CHGCTRL4_IPREC_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed regmap update\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rt5033_charger_reg_init(struct rt5033_charger *charger)
+{
+	int ret = 0;
+
+	/* Enable charging termination */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_TE_EN_MASK, RT5033_TE_ENABLE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to enable charging termination.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Disable minimum input voltage regulation (MIVR), this improves
+	 * the charging performance.
+	 */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL4,
+			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_DISABLE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to disable MIVR.\n");
+		return -EINVAL;
+	}
+
+	ret = rt5033_init_pre_charge(charger);
+	if (ret)
+		return ret;
+
+	ret = rt5033_init_fast_charge(charger);
+	if (ret)
+		return ret;
+
+	ret = rt5033_init_const_charge(charger);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static enum power_supply_property rt5033_charger_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int rt5033_charger_get_property(struct power_supply *psy,
+			enum power_supply_property psp,
+			union power_supply_propval *val)
+{
+	struct rt5033_charger *charger = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = rt5033_get_charger_state(charger);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		val->intval = rt5033_get_charger_type(charger);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = rt5033_get_charger_current_limit(charger);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		val->intval = rt5033_get_charger_const_voltage(charger);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = RT5033_CHARGER_MODEL;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = RT5033_MANUFACTURER;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = (rt5033_get_charger_state(charger) ==
+				POWER_SUPPLY_STATUS_CHARGING);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct rt5033_charger_data *rt5033_charger_dt_init(
+						struct rt5033_charger *charger)
+{
+	struct rt5033_charger_data *chg;
+	struct power_supply_battery_info *info;
+	int ret;
+
+	chg = devm_kzalloc(charger->dev, sizeof(*chg), GFP_KERNEL);
+	if (!chg)
+		return ERR_PTR(-ENOMEM);
+
+	ret = power_supply_get_battery_info(charger->psy, &info);
+	if (ret)
+		return ERR_PTR(dev_err_probe(charger->dev, -EINVAL,
+			       "missing battery info\n"));
+
+	/* Assign data. Validity will be checked in the init functions. */
+	chg->pre_uamp = info->precharge_current_ua;
+	chg->fast_uamp = info->constant_charge_current_max_ua;
+	chg->eoc_uamp = info->charge_term_current_ua;
+	chg->pre_uvolt = info->precharge_voltage_max_uv;
+	chg->const_uvolt = info->constant_charge_voltage_max_uv;
+
+	return chg;
+}
+
+static const struct power_supply_desc rt5033_charger_desc = {
+	.name = "rt5033-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = rt5033_charger_props,
+	.num_properties = ARRAY_SIZE(rt5033_charger_props),
+	.get_property = rt5033_charger_get_property,
+};
+
+static int rt5033_charger_probe(struct platform_device *pdev)
+{
+	struct rt5033_charger *charger;
+	struct power_supply_config psy_cfg = {};
+	int ret;
+
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, charger);
+	charger->dev = &pdev->dev;
+	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = charger;
+
+	charger->psy = devm_power_supply_register(&pdev->dev,
+						  &rt5033_charger_desc,
+						  &psy_cfg);
+	if (IS_ERR(charger->psy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(charger->psy),
+				     "Failed to register power supply\n");
+
+	charger->chg = rt5033_charger_dt_init(charger);
+	if (IS_ERR_OR_NULL(charger->chg))
+		return PTR_ERR(charger->chg);
+
+	ret = rt5033_charger_reg_init(charger);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct platform_device_id rt5033_charger_id[] = {
+	{ "rt5033-charger", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, rt5033_charger_id);
+
+static const struct of_device_id rt5033_charger_of_match[] = {
+	{ .compatible = "richtek,rt5033-charger", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5033_charger_of_match);
+
+static struct platform_driver rt5033_charger_driver = {
+	.driver = {
+		.name = "rt5033-charger",
+		.of_match_table = rt5033_charger_of_match,
+	},
+	.probe = rt5033_charger_probe,
+	.id_table = rt5033_charger_id,
+};
+module_platform_driver(rt5033_charger_driver);
+
+MODULE_DESCRIPTION("Richtek RT5033 charger driver");
+MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
index e99e2ab0c1c1..3992fb2ef0a8 100644
--- a/include/linux/mfd/rt5033.h
+++ b/include/linux/mfd/rt5033.h
@@ -39,20 +39,4 @@ struct rt5033_battery {
 	struct power_supply	*psy;
 };
 
-/* RT5033 charger platform data */
-struct rt5033_charger_data {
-	unsigned int pre_uamp;
-	unsigned int pre_uvolt;
-	unsigned int const_uvolt;
-	unsigned int eoc_uamp;
-	unsigned int fast_uamp;
-};
-
-struct rt5033_charger {
-	struct device			*dev;
-	struct rt5033_dev		*rt5033;
-	struct power_supply		*psy;
-	struct rt5033_charger_data	*chg;
-};
-
 #endif /* __RT5033_H__ */
-- 
2.39.2

