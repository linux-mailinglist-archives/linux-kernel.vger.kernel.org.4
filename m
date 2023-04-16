Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D097E6E3863
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjDPMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDPMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:50:36 -0400
Received: from sonic308-17.consmr.mail.ir2.yahoo.com (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F81737
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649430; bh=w02hY1HIp+qDBUno1VcYVxa72PQBwajHWCo6K51iWc8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IrGMbRhG26hGnSoQyHybWgFZB9tFyw3xUVvHznk/SpPaD/hJOEjvTVFrQT+qqtCYHn9QlcpilqWnC4lNfPzHqc3JRPJKCVLfaJgHugPMRn0+IUIDGbDvRYpp3QbO2q2yI4Cai8k+WH1e88izfNZZWosNfkugPp0EepjSrMrih5nzLgAVxo1E0TvJdKLIXbBPLbng2lb73ruK5PcbBQafNF/yz6nr4SE/HWeM1QJJVKJYcDIysM5980aB3tlqeo5uOTcY2jB7WFZgIBjP1OnasffOBMC2VW+jIjZhYrj5/r2go5dgXKN7QGq6djHaXyMQrCtcW6PRWizOLS62uaKFPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649430; bh=KxG8LYB2qHuTiuGTL2/VUUQVh7xUPU+CUvksV498Hqb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VwO1frkc+wN0Hi2H3uxQMwLxQCl2JXxGgpeH/EV2lXVJxJ3rtMnnQApVz6F+/QKv1rKThonkc9PFTyOkrkSNWbP//LfB11CqclrIQ0ZwZGG7LHTPHSJ1YSjD3oBv0Rht5sFb4st1iUYsALcopIgWwcGEWPRoC5UmWDTE4vRicqPskh4TsUX/2WF13B4nmHJsr+nap9GhDCuzuQ7uiXPNjqvrdeDNk+fz29rT0YUSJGRl0iQfwznAr3RAKuKH4gylHa4kt9eZrTl0MSfT+pzhKJilcVh+ToHp0h8LWQ0mCI/o+Byg3Elvz3YSAaZ8ynD3sq1+606lpuiuRzKKGu11RQ==
X-YMail-OSG: CkeyGTEVM1nDBZXJc6cljvEiNfWIefd19fxHRCZZCVPaQ1dYEdyWsBw1H0my8xq
 jutc3BIxhFMApInkeHgLaYjMtARQPozJPw_R3nVKpkewyixHKuXpLHvg21GL77xAUCHRPxCWgsfo
 jZ82qMkjFWjjdIJEdt8oZNGfvWygtrPAbYFGLjdbiO.Lgpro7tGa0xavsVdYv2EXxCUZSy03gzYr
 RPBcVRbX6BdZ1fzPM4Ps.c8Uus3dixmBlJqNfpRufVAmQklHkSbTZXZlc5GJHh2gPtGJMco0uSUS
 AqirYsowBGLtMmGz9f5q3r7GmhRSPjCZchNVauMF2hCIYhN_NKslEpy2sneqTlua43uWOsX3wmWI
 taPaUba.fh0xZXqP3oCR9Fnkbt3kX_G6rYSEXKVtMOz7jzdMFoPzlEqL2Jzt82J0uzDeQauU968K
 sxLTh3dGbQ7smVYjMXtmlIzWBoVA5_01IJiNY_ouZ3aG2Xo1utxtVyQkwvDFGEE8z2tVzcJSkBiz
 c3_vzcgUPSG6G3r6LgznrL5zJ9_w6TwRmVpzQojg.TKVS.rvsmPq78BOcm859VLvze_BZ1lvDJO3
 rlmiRSM_NOxrassQPlxAldKZJZ3myxsH2WwYG7GT0RT7jofwqujd2mIhlVgAvsr4wbuWsrghVwm9
 gKUHVxmBGIh_.89g59ww6jT3.7pIAUh1s1AQV4pzY9BuTeJWLvbTdSmnf038SJ94dGsFaNXerl6M
 9Yyh7fjexLPpzqV0aVKNYxXQ7MM4sX2qTgwPRu50NVPLPw1eF4Y.2oUiJpJTiCuGJcW5jC4BLamH
 E4IiDXCbbJpE3H5Q6WuERZWiqyfnaYeiuhmaKRgMwPiVlF4nF.1VCPGpk2lDMf5JevmdEiIaU0lA
 .WTDgcbL3X1YUQq0swBmbYD6Ex9C0brRJJzaCemm4X7wrBBbQnQmGtxcNu9B7j_HkLSTv1g3ov4O
 R8XHjS5MqzlfOwqTlJjUuM7Q8GuR9h17xa5iwQEzIugbC44M9qmhnqmknW5UpmnvsR15Xm5WCb8N
 uphM0plHuMSdQBfQCqThSUxDBTws7SrT0gEOPOVMRgk5ZV.7_1BGH_m9ktfyIHVgZhr49hTYo8Xl
 4Z02rvCI4143Rq4nM9jyR3TXC_sUMpNEIymYH0VTEmpbyVtk_hbnm_Z24ut2Np31.RjnjTJFGFyy
 g88r2Uuj6dyu9Y2IE9Kh2_fhn.5FZKq9XhfJ2PLoBJpSXHdkwgPJCHSdvPd1FOWFKYdS1Tg9V8wW
 0NpxMeYQ608jYSlagZ_9gx.DesKngMrO3obhj09iP3ftFWnsG84Cjwj2hX5Rum4BACVpkF0UgWY_
 l4.PUUPYvjJGvg_7x96mhFRW_3hxgQUD4S8ukpNeYrE_C2W45jSjeTYIcrrApJMcPU4IyhYS3_eV
 5Cn.VgPteCDp.ba2yaoxrhiGYephA4mEMpNmLBMS_8h8MnY2vyq4x8wWk5eE1WKSX6m77lKFTVbG
 NPmcUm24FS72X1fLw01BusBfj5YCRCygk0DhHgSZI3jyGmmWIGRd42m_YudukWzy_7.zeseiuArF
 LfXI78RIj7VUrqIFP1mS7OyxkwIBG.jErjicKn9npWAGfdXsAiKX.n9GifgP0NfNr4u6GR_8kOwn
 3.uJeB4QC4PsBOcRtTC7ZzTkveNB5WXhG1xJVAZJa4QRy.7qy9uxu9Q2w50fnqarmXLYtazT9t5X
 r7T63_u.hC5iQujcvGb3xqrlP4UPebPnGq4jwsQZy2.dsaNrbgsuCTLRrTBNyjz2ufFaBS5aFpwh
 JVY08Mtb3NXMtkhxQXS6KCh9rCI5TV4a0P9ofSNpzJh3qPxaHmYe3R6Vi9_gh1RfzIDd5FokH27n
 pEOyJnyoYwpdunvix01cgYhrohy6sNOIvWNrREcKXgSBbJwSDDRmjxKwoRunG3yeXc6z4tf21Q_H
 rhIr20pt8n2z7l0UAlfQj_9qqxL6tR7_i7.21w0UAtqU14rt_wleuvu2BsZBQOyTjPlBfyATVDTc
 no00m5ej1KqFoft_SVMX5DbgeVTq0S4npD9aZPPZHKtwM_k1T02YQkEY0UkF5jN.xFrzqROuqEA0
 Pfr447.GO7qleFJ1ZMmZ0I4GGamJcK2y8H755u9aeBhUPt0dTz.Fid7tCTa07m2mJbo2qpFrJbVT
 iG.xhGPAtxZWtpHIpYaGqo8wPfqV1WXVRGoGUkFil5lVDP3uhubGaQFaVaB.FPlN7cV55tf.empM
 uYzA2HdoufgmUjoYqpwEc15C1xg2izmpqxRUiuam.5n04o01rUzAn9rIbMDoQ5f73r6kmt7Pk2ya
 JcbXv15prbpGk0NyxmL4swgdoEg111yHxtgl86VVBd0N2ClQkGEjFKg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 5e0ee88b-bf01-45e8-b449-045deadfede7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:50:30 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1e6b4a18b1a30b9efb33afa6a04eb6c;
          Sun, 16 Apr 2023 12:50:30 +0000 (UTC)
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
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 6/9] power: supply: rt5033_charger: Add RT5033 charger device driver
Date:   Sun, 16 Apr 2023 14:44:33 +0200
Message-Id: <665d8906ea7b84e0a248315e8395a80007b8bafb.1681646904.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681646904.git.jahau@rocketmail.com>
References: <cover.1681646904.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/power/supply/rt5033_charger.c | 463 ++++++++++++++++++++++++++
 3 files changed, 472 insertions(+)
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
index 000000000000..b5be43e6ebf5
--- /dev/null
+++ b/drivers/power/supply/rt5033_charger.c
@@ -0,0 +1,463 @@
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
+		return state;
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
+		chg->const_uvolt > RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX)
+		return -EINVAL;
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
+		chg->eoc_uamp > RT5033_CHARGER_EOC_MAX)
+		return -EINVAL;
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
+			chg->fast_uamp > RT5033_CHARGER_FAST_CURRENT_MAX)
+		return -EINVAL;
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
+		chg->pre_uvolt > RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MAX)
+		return -EINVAL;
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
+		chg->pre_uamp > RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX)
+		return -EINVAL;
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
+						struct platform_device *pdev)
+{
+	struct rt5033_charger_data *chg;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	if (!np) {
+		dev_err(&pdev->dev, "No charger of_node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
+	if (!chg)
+		return ERR_PTR(-ENOMEM);
+
+	ret = of_property_read_u32(np, "richtek,pre-microamp", &chg->pre_uamp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,pre-threshold-microvolt",
+			&chg->pre_uvolt);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,fast-microamp", &chg->fast_uamp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,const-microvolt",
+			&chg->const_uvolt);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,eoc-microamp", &chg->eoc_uamp);
+	if (ret)
+		return ERR_PTR(ret);
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
+	charger->chg = rt5033_charger_dt_init(pdev);
+	if (IS_ERR_OR_NULL(charger->chg))
+		return -ENODEV;
+
+	ret = rt5033_charger_reg_init(charger);
+	if (ret)
+		return ret;
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

