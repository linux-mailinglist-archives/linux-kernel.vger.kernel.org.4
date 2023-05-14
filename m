Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971A5701D60
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbjENMcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbjENMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:32:07 -0400
Received: from sonic306-19.consmr.mail.ir2.yahoo.com (sonic306-19.consmr.mail.ir2.yahoo.com [77.238.176.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7098F30FD
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067520; bh=xfHykX4lNV0IJkAiNJxxbDhqSPAzmVIyexGvhYt+828=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pmT0AhKPqCJGY2LRJYSr0thvKqdI/DFCZirY7L8CLCWe18rrJvixoUX95DSik1lUPnxloDu6SBol3jFIrbnfp8pUDpqJR2jFFev86iBjZdVkk6CbM0VCCeLhkFCp1jvsoQ3bap4lpkhwTiiz2WtkgzZclQXKm4XjCf1agg3tUhRFUtAKteN0rwr257SojBBRjwASViyzLXZOWOIMfA78iUPxOIJO/RTvVQAWYDReIw2sHBlrIPRFtDTh+nbtgxuU7jbceA0zES4SUdasCd3RfH034GUmkM0mrWNJR5D0gQ3ekINLn2Rj6jZcqohePQjGuwAT16MH0lOeRQEK6WxsaQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067520; bh=l6+PRkGShezgHq+bJCwTCvlB4lyX9L9yCZdvoBysmd6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JI3Pl6sIl3T6IQ6YcBoZgihpR/baA/pmsjYXe2aDan3g6yUA5Q5v1952BdVy/SFC2X9/LYHUxlprXTGpI/Jleyior3nyTysvaChzpb9p95odR2IY3modpXNIMLgBDe+RRmU1Kizes9Ab3SrkCTscbd9I+vdsnfrLRMa+0A0angF6mh+RbqBGqSO6MMhXkcq8u3ixi6oNlLSDMXC+0uoQcnN/jT6sEtd1l2rVInMsrB2Zaj3km6d2Akn+hsSe5qUl2zcuM+/Uos7zwU61C+JD1EX/pAOZGgMTrdpGwr+ilS3h5+whwunxv0kDQLlE2aIoDVDp1CBa4ubw81lTWVXIYA==
X-YMail-OSG: 9oMc6WEVM1lwAQZg8xY2LQofvNPkIns1EJtLCtGe2NUTUu5dHQGyKVI9_En8AlR
 nHPosDBI0PGihMGOR3vXuwJvq8RBReziyIu6Ah0OwOFFndDD0tMC.Zb6uJ5MJYcd7aJfhgIA8DXx
 qStAqoiJtp5J5LwzJh9c3TqZn66TsQPyq0PfqgPqUljro28WVNTLtzWRKkJhlasD0W1km5KojhOD
 jd6XyIEmY6PDO22Po97OuHqgJt0HMBgVT6aDuOepYtITNeC6ljNmcNCFOi.Pb.fwoQJgPyfF2G7V
 036RZ9id5elocyJhRq9x.HEWX6Vz8qayfOf1gSlTGsT1YsAsqNfpQcVB5XMkpSMnWUyGtMJ_QPlP
 w0LqlaihDxUlCER2YgBqYXQwQqbAcIG7CohTlvRuWAf.Znpp6yQLvlrEN7bta0z0L_zpNKCwO1pE
 Rf1wpEfepTDfJT7wWdRQJxrg_sOiUNnrv7caH7tAdByUNLIO41CC.Xx77s9mJwBQQGb3w.rFK0G7
 jgv2AL8ZPmLztyx7U7HsGIIIzCjpb2RlP9o7bCbRlu1QjButW2XlaEQ_tlYVGb3TYecckrb2VMad
 wNPwR2_OkWH0fZP4SIMunQ9_8Xw1nR1pBpFI0DivAqTik7HMGJCxLTc7FhqD8weatodAcH9MYJU9
 s0N0G_L4554lNgp4tMFbcaD9V0yHaxkmQvyFNmF6w4vDyMQe1Vq2wT9MPX1d5xgapco2VwZktlah
 cg18u.tygyY0s5_lQCeecRA4iOtpPOXE5cLYR.fA.VLMu3P_Kl5BYr80sjY.656PwDhV9ho19LTU
 Npo9oFW33N_2UEHihuOwIgK1EsLpbIlK4o6ctsgUykGNfHZBhfb1TkDGIGGzziZmfZKnFQA2zcaU
 ZVpJqUEL0Wk9GgtT.A2XdbJBeCZuTo2v.quSppct3S628C811qiaIfSkPtM_fEp29GYA7x7sESJN
 NYfGwsVuXSsCYEs0ZE.LpU9q9JVI80pzRQAlx4v0T4bXEiLMJ_1fqoDP3Fd0h_fplHplUj5svroW
 VGnthYCKg00ju4YQaXaGgrox48Rn8UAbOFOw83QrpZIVXDUyTGrg7iYcLXgAXwx3WWbrKAywZGxP
 Jhzndo_IZOcDUt7fG_7tv2X.vuceVpQHYhhcJMxPekT1XN0d_Xg1psGC.ABE2Paz4CexlByyy.Gg
 HuD1jsvNyGwXRwvf9D3ZGfrvGbJbWgh..ZzraOstVnznerv6Q.TwvBSU0vRLw8vOnUo1_JnnwGHQ
 4ALFAb0jFp5OUdtNRCeOcGbex3OJFCnBA7WrhYz3uSA1JA40zGcYAkSvAQ4haGZB38Vz7rcn2tdl
 as85P7Te6M7.AUP0kN_rm48RNAPnwPD5f6qOvKDAazn8bprHYsvk5TpPQf6wv.sVmjUUFLbq14.A
 sCGHSzytch4qYr7Oanyq78nKzBeBWcuZ3c7JO0EezP0js_GDnRGMcvq.zd1ARlfrB4E6ndnY5IhU
 KXWK0UBX654PhYLIxGutt5XR0uCx48_VINhEwrQ6hbFovg81CovEMdeX4z35GdUs9Kaw3C50qrpB
 fuV_eH2WmGTVbOOes9QwohMJpfLztL0Q3SYABMiEkC9sPs04SN.rXh0WXVUtuaRTsyZDhKc.YLqT
 zoPTKEFfbf3kGD_mcAV3d4RDMopQrPmQOie5Ml5r7aE39v24ad9bEZclAht1Wono07aGMGZ7cVtN
 BwzM6IScJZcdOJpH5NHXDnsPQl3O5KddVCgpWeiiPnVbjauEcnlC1t9UdDnIx5nOwu_x_9m7Ehjq
 cL6BDpFlOPNcv2wBxmVDMXu9PdsCoHls43NBXDg_aOPe.oPi0dFBreC7WlBvTT3Km.wB2O7RxkZ_
 ykDIgPk2mb3MNbowzH8f_q61c2ZFBgjz2d2Ehu35K1rHVfHUpL3G3VKy3SZTEvMd79OiX6DeOnwW
 W67h0tFmoMhzoK_N7hy04zYfg4vRMONYxi4wi8tbOWFFeVBcJ5mCgE7ap6.jQirhg1MF3PNsQu2F
 xD52UvjgcVFBcDZRjZjaSsfsGSaNoyVrW.o3YvZ9GMwc3XUABhTyu74anvc8kCJycXkFC0rlURuj
 o_DUrzelpqrPn5LtsMndHOYkooaN8C9pnK5gQP_UDrwzIuY20Uvq0R58f_E5_bFTdIy79BPRmIfP
 GGqJgGT39mM6J22iG4rKfrPtGhxmcf_4oBDz.Zpj3WDTjC4lAnaVNVeFuQuu9lCBP8GcOhjY7MqG
 r5W.C8hhicLfMxJ64iLpBIAo79xLnV_egKaToj0A2FVCVQzV2oZDsXMLORfNnZ64A2.pjYmxFRkR
 hjOE2ZiQ7XNFh5iYpsu0MOqXukZSAWOs-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: d38c1b50-3e18-4029-8bc5-ff22906835a3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:32:00 +0000
Received: by hermes--production-ir2-7867f454fc-kqstn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32d47a946aad3f7d203db987b930ba8f;
          Sun, 14 May 2023 12:31:56 +0000 (UTC)
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
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 05/10] power: supply: rt5033_charger: Add RT5033 charger device driver
Date:   Sun, 14 May 2023 14:31:25 +0200
Message-Id: <20230514123130.41172-6-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..1aa346dd0679
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

