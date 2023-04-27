Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9E6F0EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbjD0XbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbjD0Xat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:30:49 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20564421A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638244; bh=TaDEAz0Die/QkzhQlShMR0Tj2yb+Ub7LPlpIw0Xo3M8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=paGgIBAYpFnSYcTWXm0oJsxFurcmBe9GTEi35uS45/e7qrjoKMDhRBihRxHg4UKPD7ZHrY80jSZE0W126kdY0MiaFXO8N4+g6IM5yO6p7S6jxX7AFLpj5KOpuMRtSVGiovzU24il8mywpnheCA8a46QGiBVezDssMl1USl1rpQE+PhikGU0Md3RFwxicej4RsyzcyMAzOaZYAI5rqtFrMwKqZfY0PjH8EMDYHNIpgEUK4nng/rTQaGGGRdDUIDoO2MS7XVKV0GEfZuNYI9kgypRF+1wmQCwc9ehrznlM/dmAGkYafYB96CFNgqCtNsuoklcKanh8QVZWBa95V8JAcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638244; bh=TNgW9onR+O95ZYZuvcKmpUJbgxwJaqWYy+TqTUo40V4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EKuOp+7DOVP5ny7egNEcgPRkdyx3ntDxpvSU0OgXyti6gN3I70fkOi8r4gHzK3dFok5TNydOMlCLhn7xqJSqodQLnndHD2ISngAge5toAXqypZ8WQWq72dqap5UicLpNVz/OSsAA6aN1pjph8QMPwILRJshbq1yel2kgEZOWnpbuZ206jqTao1gC0YsN3pzAcP10OZoJgxlu9jf3SgiAidnE9YZTeOIFy6nT9z0EBZaLmnIsG1Cm/EYQe7SLFulzsDaei5Rlcl6v6lrfATx26nz0xwuPI6RmRBjibfvWbb4bHjXHXrVN5Iw0WD5n/1x8MWmol6/guOp7heWhQ7J5dA==
X-YMail-OSG: eYwr.2EVM1ns_A6GKsN2zbL2nXttdgRq.CSbBRgVwnuD13.K1.1mI.SjpOdGYKE
 O00ZrRIwmD4OGzAdW4fjOFpTPHTGcKtujrpbwF3GzkhCVwjNOwDYeE8xi_Qz5C.RuHtoFO8e1CEi
 qCu_a.UXbnzV4Wqaq2SwceKKwrhOpaoUsXrI2T.5r8J6xIxFys6.jU04IwX6lIHq91CbS1kjPXxd
 b7_89OaaaDNxZSuxPjPkdCOnDSEy7tSht_sMmhhPJyK8TF2Pr1PZ99Z5sM1r0zmNFKHKRElcx7PM
 KngQziPjGjTqQJ96Brts3XxIryK7y6XyhURkxeZmHN8_rSwQmdltXVgRQbKyMGBv2kwK74ghwEil
 vWjUCC.UfIelZyqlUKIv4mt2T.hv4QPXQVsR89go6Fi1DUBCAk0aJV19S7BqRFGi5uTX2HEXXvd_
 mK5hGxiLPrpGtlxk7Up3BhK2zc2qhHJIWx7nci03Scl1UkR7ugxPNI9L6glzlb9gypG4W.zhlZs8
 HQ00XVWokB7bivi6dNkUBITCiGZGhK_XGaBjhIbzuEw9ss1KUqiZ4eytEYt79IcF3Oq29kjWFkk.
 xrYvyMCirhknBW4Oc526QaJCI10KeEf_AQRgNLpOOkhzrnRa7CVr8gKICQ3t0Dv79GuSvQqZQ4HN
 fGHPwA6_crPJfb.IDAZP9wKNr27xsZCHvyArPwD6TSEVaWRIFABB4FOok0gaTXUimO6YWddVyr_g
 dxat0EueqkdXP4W7U0rA8pPcpdJTC5F7P523oA4j29l61InJq61E4dWVXI_SKHln3cdG1wwbzXYx
 YDJv0ctRkufkCQCqn.9H9I4WtBSqyFln7b.XcIzgHuF1fjgZYVjRxkJ5hL1NYlKYkZqNxf8_9BkQ
 WZMsiX5txQEAFZetQbFCYDUtnl5qOw5DDMqlQxNJ3X5MGxZMO39snL81H5HVE37FrrIFlwijH4Tp
 Ok1auuxlTI_GX4qqB0h_DECllhnGn826qfkZ3sYzTVJBrs.vQWnYvxdz2CCpGir1NzpUm8nyeqF2
 Xn9ncdU0WAeKW4gOcYyqf.17atINUcWHj7D8TtL9w67qlQO_QCiEciB92bO9YXAIRiSYvbCYRZMI
 W1M.j2Bt_mb9d6YNpccJYbE.bX44tuftTK0TJkjlclLfnD2bLi6hqX5KXenay73j0uqzOK6WTMJL
 SzlFlQJI5kZew9C9ZRGxO9HZF1Q5w8UquqY06_gCMtj6Ds8VJ0WvHMT3OGsX2i34SYInFaSy7VZx
 3wSFjGzFnRM9mnFjiSwRafr2eNbRIvc8vvQI6VAgegRLZhlzGoZlnNOJC3Wrkm2x3B4RHfj_gwDW
 kDHztxRJ1E09MIg2mKymGDEeS2Qk2LCKpUpGHhv1NALvg6m8IDMD7OLfiboIu226nBJ8sRtAtQ5F
 QKTEz2zeBT4hpzLH9QVbhPqVWLIWfYxSXlSFgqx6dq5JwEzDxYlUSDztZ2oxhwOjw7gmi65oIPrg
 ReC91rjjtjAVSZTRSJdDsaj3PWIMhDLr3vkO8g5D833MlxiY1dmTMQFkMKw7SyPJKXT9KohyJOMx
 0.ROSbpMIasolaMMbX36wntnACArNAoDytMbLamuO_pq9mrRe_bCeFdOgpo4WvT5LQj9Q4wCcUoy
 HIKHhdDvbQn9PVila5Zs9XHYgIwiRJwx0s7nYVp5HHVnvBuVAwD96Mpev.502bg9Vq.pCOwbVxo2
 _znGqW.oZ3FKtyVTcs6vRNbpn8Egin28TxkuWV2ZRD6_nWX31J9S3pKFAeor5WkFD70gB.4x.pQl
 FWImv7gW3hz_Hwse8WGX5DjKGpH29yyToBPr1ZXgFLnvx7ZVtZnU_mUJRjqyV7lj9S1PhsH3NC9Y
 GpTFbmiGo5c8YHRDWMKLSHwm4BrVDDWZCVtfh75BZGfo7VnMpNhPu6OfzrdcZg4F_UGX65H7l9Un
 mxY1aLs0mRVnZArRRtE5GXHNtwXse8Zv0mhHpFLQ30Diz8cUGJV0C.F_Xuc9tZBMUY1SYEe_2Fv2
 nTGIUklBjL2oB4J.P17qGLUS7mLh4V8KbU6uVbKjWa_sy3zi0UJcEz8GxX8icxH6JPW3TroLQsHy
 aN2eeEhnL.a7iS0g1ez4R5hRzYui8o40fJvRFMFXbi6D7aUi7ThsMRXUs40XKgCPIQF3oe6cOTWM
 OQdTbN9bqH30e18aUzsxyHdluntyryYyooCVIW2R94mPUBzn5Txe4lKlfXlrRPAlmPatTP8KO89z
 HoAsTy3WlYyMDW.pVLt3WLpI2FcruFtRV75UVr1n37Iay.2.JAH8rJau2y0GXtJxS7eTK2fyU.ay
 U2IQaOjJcCvI0K2SDQ04mBCzT1C.qEQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 86e4cd83-3766-41b1-8248-00fc4edfbdcc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:30:44 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 912b1d1a256b22e43f453e00130c1256;
          Thu, 27 Apr 2023 23:30:39 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 5/8] power: supply: rt5033_charger: Add RT5033 charger device driver
Date:   Fri, 28 Apr 2023 01:30:08 +0200
Message-Id: <0070da504581081906a30d1095b104c4c2930e86.1682636929.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682636929.git.jahau@rocketmail.com>
References: <cover.1682636929.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
 drivers/power/supply/Kconfig          |   8 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/rt5033_charger.c | 464 ++++++++++++++++++++++++++
 3 files changed, 473 insertions(+)
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
index 000000000000..038530d2f0a0
--- /dev/null
+++ b/drivers/power/supply/rt5033_charger.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Battery charger driver for RT5033
+ *
+ * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
+ * Author: Beomho Seo <beomho.seo@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/mfd/rt5033-private.h>
+#include <linux/mfd/rt5033.h>
+
+static int rt5033_get_charger_state(struct rt5033_charger *charger)
+{
+	struct regmap *regmap = charger->rt5033->regmap;
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
+	struct regmap *regmap = charger->rt5033->regmap;
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
+	struct regmap *regmap = charger->rt5033->regmap;
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
+	struct regmap *regmap = charger->rt5033->regmap;
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL2,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL4,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL5,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL5,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL4,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL4,
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
+	int ret = 0;
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
+	return ret;
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
+	if (ret) {
+		dev_err(charger->dev, "failed to get battery info\n");
+		return ERR_PTR(-EINVAL);
+	}
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
+	struct rt5033_dev *rt5033 = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
+	int ret;
+
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, charger);
+	charger->dev = &pdev->dev;
+	charger->rt5033 = rt5033;
+
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = charger;
+
+	charger->psy = devm_power_supply_register(&pdev->dev,
+						  &rt5033_charger_desc,
+						  &psy_cfg);
+	if (IS_ERR(charger->psy)) {
+		dev_err(&pdev->dev, "failed: power supply register\n");
+		return PTR_ERR(charger->psy);
+	}
+
+	charger->chg = rt5033_charger_dt_init(charger);
+	if (IS_ERR_OR_NULL(charger->chg))
+		return -ENODEV;
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
-- 
2.39.2

