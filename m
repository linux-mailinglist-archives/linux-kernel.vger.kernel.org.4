Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9696F92EF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjEFPza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjEFPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:55:13 -0400
Received: from sonic304-22.consmr.mail.ir2.yahoo.com (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141111A49B
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388508; bh=ivF0LDJr0rdgeglbnPdeUqKu3n3YDiewDyMTaQ5r3b8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YOU4bMgCW7SO67PCFka+GBQkuCgJnW+YvGqHDzlG3NcVhAisgxakAi8v6/UC+pQB1xaB1klYNE4HRzrNsH8Dz6pDiTyHGBjgvNEuBYjPjzzWP5RQ5o/rXMdA2LH0b9j+258BzfCJESCkJTfxpZ9/GdTJQ78dB8j3/eId5R4tI11XYJK3+QZOsoGbJ2XI87GDIgfXcttlK0Mb+zGpsbvqEbvdDG9C28+lWHSPklIPyBxUEy3BOML3n1Z+8pnvjHtOoDXE0fjFCDM6x6cFxdBi8kWuha6sCbn42ULNYxOBFIVuxqOp4FvQw9svDjVt2WMkfaMnjTsVEhNw1jQgiFQrag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388508; bh=Fr7U53D/1wyIvEra2i0D07RdS3ppSSa47mqtJSc00z6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IsoKrc8IoQLR9oyjdh8NDmpln8dcsmeSwsb53ZZ/cumPImwUwHA30Q9cFTOYm4/7iCqWkC+V7y5Z8uYP8y/VVY+Vty+sVkfVjyriPWERLQxybA1tjjITGxUKVjEpj14bSbj+HHCUJ0TGbIoGI/S4M2P4GWHUt2R0aKYwrHC79MPJcGLRWNc4iquxt1QTHXEODafmFzXdeQpdJl3F6PKKYV4rcjckeOHPgGTG0yaBKmqr1AXRaLNzKbYuGJN74ppEsj1UKpoJwnRTsOSMfkc9/QGfITNTumQ91NPnQA3bn90A0uT2/G3tIYLcX6hmy9yIHwb2D/x9PpYGQMsmXNOxvA==
X-YMail-OSG: D63P828VM1lrPUhMqkXmt6p4Myx7A.d5oYt3ugoJl1iISFIoAV5eeLqWWvN31WT
 FKwW0J2AuEZ92oL26ttReGoL7kV4HFI4ivR_ds2lGlvhzoQf.Dcst5Ku8tslw3DJV9CHau1yVhEJ
 nx2k5zrcyNvKLXzikctzz07r0_T_aLlhpim7UaOjhE0O5bZz3WhDlO_kbuzmGmtL5fCHuAWgCpyy
 RHdmaI.y7_BxcKvcmV1Mo916h2R38kihfQqfvI4ZVPeIxE5uTe2_KD7LYDFE_J4M5GFMV3piz6JH
 PSrQKezJwM3TxP3.fC.BebOYQX8VV.Y9e8AKdtofU1Zk7kyfK2UrgQ_sXq.ANyep1a2ckXga3Nd7
 BXZm1tQLynHToelxcARxfMTVSlzRlavj2I.uCKJc.EljYE31Dq0OdOqhnUlk5gFoLwOC1tYcR14Z
 nkElKNvOmAx1kBROIFTlzxwRlfCbwY72ShJvQThvUqNUJEVr9W60ULUPAMOLNezR9rcXBoxfyyW8
 94A0JrC4UQsAxCChROlvAqGK6qquMvbUYWnQwPPLYwq8XdY1eLl9nUUbEunWFxdk1TSkM9QCp2UA
 IrlgoE6oFsUtyAgmK_9vduZOVmCR3vNrwvPVFWO06psPlGNKqfdMWsEDlOGXI.inbUtpxIB88dgf
 2cV7LPHeJ7xY5A3VQ1AYBCdvKdqlHaoapzXRHvKTJ4ATJdTPWx_3V8NL54M0HOIHv6YgShaRwPzM
 dru5yaiMYYnC_hUFt0u27ALP3MoX7Q6uCYErPydalPmB8ry6lblfirWub7uBZLTzGhVOZa9BxcbW
 YAawQgHQ9EYUPMLN_.c5RJ36EQ9JJjpNlzIyAEz1SsHX0lOEBbCG3LcBlLkK8WdKq.k3kIg7ILI6
 gB49q567brnMhOIT3HDKI07Bq4Tb9SHdUllj7H0CLtNQSD14iA11u3fT9EOcDrIFovRuPsV0aYqT
 qCAe8KAlqXWQ0I53GRBlkZNpufzsVcj0MltK1RUV2gcD1tpUmQggS9K8LyLnSd_y3qj7nn8SHsBl
 CUsMlutYWbaM1.TvHhEcs.Y2sBy.hZ0EFS_aD5glZaUy25GyHxPqzrsbrwLtyB55TohSiyjQlYs_
 KS3G_rnSVU.XGcocp6IcDp7bYmFsAZoGwSLDmirX8wBKCxSdPXWJ72G4X6BdKIVYuNWvp9bhUe6j
 T_xQUxoB1XvlxmFkkwFGlm0pitoqqf15VpDCfhZjbXbB0KAft9H647qGfo34NeuUiYv_Kz.4LFC.
 vK2VLcOaCfXzalYMI0CEF4xarAALbp4COc9zA3WdmIuWFU8Hj6sm_K_Yu9t1Ipk_wWT4xbKQ1_oI
 KW36OOs0t5O71d9X.2.DnUXdyeUK1DxvuSpr6BBHY9g9HAQRHPHZ2QqBd9E0.ppRKV5nhSz3PtgM
 cJeIMFFiBmtT8s6WRuZOvYBD0Eum7yctPTkbVikAGwLS7ZoqZ9gdFxBiw1IzFfrC1ndCoOy.N4Mf
 Dr9RDfBk4.sc9BbxDd4ifaA2mW6V1WN16ol9TV44l3lurMh2wucdv3lkt3W89zvWPjpAhBxu.6Yh
 p3OOJNjUDx5KrE3hhKvWBHRjhIGwaF_wUGxAc28CN1i_IPv1PlUXlGXVqzCZYrL8X2rDPwwOCNaP
 klA9wZwJVkSHAcaCaL_chR.MiRdbxf3jS3B_2peAgckiS8_uN.KMMDoV22QVlUP3KepW2slIV5Kp
 meMNPDdN_XMDxoITCExBxlFPQtNzwahy697lt7gSQRzy_qbs1sJHl0u0jVOvrOPIt5akBE4CfQ3Y
 wRJkWdFuQ0OqYLLY5wwSvD89_1jTITkbUrbvxglZ4FakQjvvr9ECPksmtM6lPyuH2YJ5NHipTQDW
 BvXU2g8JF2eicnK3ncZKeYGwDkfUpNGa.P2.dU2sdTxPgdybYQZJNLPLqLFapjBmVwR3Bs369RjK
 EPd5zAwB62QC6HDQgw1SJacKwqXEbhH2a6G7vwqBm_yPEbn24B_hQkPKAv8QOOdjy0NT5pGGJJQ_
 hkrro6W.GxkwH1meGaUitv83x5HvH2bnWpkChyRVZqwyVditUFf6ZDc2U_OJne03COcCPlYhcZFz
 FgIQ7c8XUZTr6viNlWJufFIEriUkWkhLP1QRBSJSU0by6qFVu8ar.lq7d3kwkLcKIvTm5QqxctL6
 IzPGg1YwmOKZDllg0kfFeW4rvkHeeuEPxOJ4E.V.TijkD4MzcT3_qiGSJsAk32QVEcA7RlLQwEEO
 ZVODFBz_kk0P6S_t4GxNxIspnZsV_zG84_kDjy.PsyBWlzCsuaai2oOo1FalTd6u43FYIVP0PlNR
 MLIuFGfudpYpKPJW2lwD4YGSxvsr4
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: aed367c7-31d0-488c-bef1-41dd68074d9e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 15:55:08 +0000
Received: by hermes--production-ir2-74cd8fc864-s5qrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f796affa0781b2e3002453351a4dea5;
          Sat, 06 May 2023 15:55:06 +0000 (UTC)
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
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 5/8] power: supply: rt5033_charger: Add RT5033 charger device driver
Date:   Sat,  6 May 2023 17:54:32 +0200
Message-Id: <20230506155435.3005-6-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506155435.3005-1-jahau@rocketmail.com>
References: <20230506155435.3005-1-jahau@rocketmail.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

