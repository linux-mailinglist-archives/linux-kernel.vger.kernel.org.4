Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8A6A628F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB1Wix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjB1Wiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:38:51 -0500
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A443116ACE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623928; bh=bCQUGN83UroFyDdUJqNBBht/r9fSPNLG1aiH88Wt/pA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qnpJvYRxnF6d01rfdcyLO54hjTYj2ZvGhSZiD6qg19qJABylzWY7lx8dBVxaO2dTWL1t8NblrcNx5bFLFkDx0i8akH94VzXOdS4HG2ylCUfms6NsLza8uqEVt2A2DXkldVll+oFR9ygf+GtdaeJZ1rqPj3YESQLFIjbr8KW/+WcGFqaFdeb0knZVgU+6iflHNCiGj+Q3ynzlHCFxWqIy/2PaR9dLS89yE4rHX4IN6SHdoeQOyYGTMvK4OINxkhuAyKIRr3GwlfW6UstR/ZWjhO9WlMECqNKnrCVHt46OIQbX+6/t4z6LUGVT+FveoOVQO9olk5iwMK2U/8OvvEYZpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623928; bh=UDr/jziOnmspLdRFZIlNGmKwYlyWnO/x0c88XJXgRaY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pNr49AAhaZsvcJyx2dCab3CBhsIPXlXppF9OCKOrmX+Jdmietqyik6vYROUNazjg/mJYRdboon7bX/W4iZsUUsjMX4T2g81udo8mER0K3CwBWxSEItlGwNgdV7ggJ1Z4byt+2Lv7cnAhBRgOq6F29epdoEjoQnT2kKSu54CemJvumJMC8cPRLDFFgO8+lVW5HTXX1Px8EryDcVn9tn84zL9RnZlwLZARYBHmaJ//QSi2GOlk9YBqW0rlm99/S0g9+Q+VrMnHOKklzEjKjRH8afd8sBWNVfb3d8RSM3poLcLIT4lX0UBwmvxZ57ucs6hIIgVTeeykfVOsImjtPdrFgg==
X-YMail-OSG: Gj3Uk38VM1mQRwZpFU2pV4FObxhwiYD61BcMTgbtWY522HJ1OSN16GqSC6FgOLL
 t5l_.rki3dQgf7TWLsn_G9LpRijhR_Bk0LS8cIBx7t59lVYGHWGAMsBBzrTOSJfXauOsrm8vE9Bd
 fM6K5YUrhRUE2D_Fuv8CfDxc6lLl.sZjmGx.iRONawzYgipW7uDIjdOhNyz9wgHs5RO9qQHanCMg
 uqqtG0qgUhxl4lovL5R_gPB4uoBmTXpfGPOnMvELjvu_fG6iSMoIKlf6o4DwNCMXhSCseF4n2mFL
 3VLeY.zZRPBQz9IASCq70ipcqOrdON5DeQtQxK_cM1xQskl1gaGlJim._NK_XycAndp0t8KrUA7z
 rScITYBkJ.b4qOYTr53JxMNkIgvuN9ccqL.chxSdGu6NrVAD3N0Vd4IR.kOYHq_qlaaopS2fUcg_
 Bxyp9U9WZCDu.LXgNVn5c.lJQ7FaxiZoUO4RTwJpHPrPvKudUehdofB98Sx0RG.uE05CAl2OAHZo
 CPnVYDD6q7AXb6fPG_Sz1RVC6E51hwRjcjwHCjBCT0.D36rlx4Cd8sIMNaxaCX_nI3i45bYiCUCB
 FHQVCY5acPskpkMHEkKC1V6ecVM6FIo454lTYe_QLFoi430fjEZBgT6.EGMzx6Z4g_lfIrIOjVIN
 b6fj9EViCNeOKMsXOvY5CqOlUX8nk37.XGZlGuL9GhNmmsvOBZN8OCzPN1_lWKoTRd9Db1wgcply
 LZk7n5nil9d5FroDXQi8vVozhx1Qts.QVxP._ZZYUSJknqsoiumwDOzKecikItPpdEMi8v.FDD._
 ZmFq4oOjzTzhW6BTDniQ_yZhjPLGJejFw5c.4Js_8GlYvs43POanOt_oZ13PSsRq.TEbHIHEfCi.
 DckgkHlgD7_kLBNpCQaMPEZ132SlPECiA7WpQlyPETZleKAylAi2vlRxALHePFHWjt0ddbErmVWe
 eylSKaZ5ocXvDIv.uq2kAMj6G0YP74EoCSwwtUnrvnvftmaPttzvyALhev.2Cj2FAwqXvEsxBJQy
 Zj2jpJjdBEIfNInabed16iPaMUR48v6kYZ9hbmbMjmvUTocb0hVmCNRH9DeBSlxufb963Zonk1Uj
 k3A0X707r0G_ljvr1xx_a2E.Y9ullWroBSkeg_Hk2XGzXmaV18v0QNW8u8AKl8A_hzxRYpfPtNLb
 PZTobfGAtRqswpUBcaYWsaSwDhMWodlg4lAzV51oHkan1ZS85iMlncpQwODBGnnS14IpCltKVEoi
 KMtSD74MfRoHXZNzZJer5dZ0OMsYbTfbuXCCEUq7s2tp.rzHEWaVg6Tz0o4K0Tg9mqiOw_GvkZVf
 jNJipYsK4SVgzzzPOW4tiWDUaCXrDeaAfv4frFi1AjuVxdlSNv.4s2T_NLDL7YQv6WZYXgs0RuVa
 TcUkQlkt9d4JfQOwpZliMD8nASmQf8PgICePJAKq21E1bqp_XdJvPD43XbCB.43vcb5.1NIfzyP2
 9zr_Yqt7hB3zwZKeMwpCFn1NiZP6W96pUMenrBhysluDxOy0foRActndMPmeBUSiap3IDrBQIyrs
 C.uGFNpnfbrfh5zV.qonGbV7iAdhQys6BI.nOC6p7nxOREg_vIPixYHZHeB8U1gCwKr1XOWAwglI
 G_lir2Ko7fL7q1.ybiDW50WCFTVROpz7MCqiY6ByronjXADVHurJ_7QTTB.PaQTPRnqxDHqSLyM2
 JDQtabE7pKHjZMFNzDB4wCLgDGwEbwr7Q2yiw6dCu1Fy1zR38NzSyXW8fpBKjQHGbf0_xKCo84sh
 Oi7CstvwSoHDUcaJvLkypQIn35XoKlbSXQINqrG3K0MspW57xUjzfCsv2cvrpeeWdreZMidXWCoL
 QPH1R0Gxo6.IsAEH9PQWKmK9PxKH4tKRZms9dOZoB90hLXPVNoyuNI5JSuxpr5EKEE9ojJOPQSwE
 qm_6TL2MSmtLXBf3XwPMBscYGQibuNCVha9asbqnB6lg1tqt5FvchmCrRbD.kZMGleOY0RN8vkzJ
 4uLaOgFCJxZQk.JFaKA4OxqSpPgn2WrcWsNlADAmkoKNZQ9t03N8s06lxNRcrDAIr9JjwhATtPnX
 i9UdXtzBXldtMSjykXzeyLa7GRNK83buqNg2teIEMLQqQTR9ktA8ssb0chLo58gVMloi76mf.iRD
 CRwLkiS1A1ywvXZgFubqmk5o9VGC_fDWKF2M9nptsd1ttHSKP3.34m0szyR1bC43I1EDg5OxJQHC
 lgTGDaxug4qrziTJ7dE5HD1SbMN6kcV67n_giWxb6DgHHtJ_skd9oZBaMnHLJtK.2574pLqahbt1
 .r3HzuyqI1jh211BJ_QRDrlhqjkNigqHWHRfs9bwsN4nBMh7fofjX
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:38:48 +0000
Received: by hermes--production-ir2-65c64dfd66-svnc4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1052c26ec2388683ab738a7f87fce466;
          Tue, 28 Feb 2023 22:38:46 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 06/10] power: supply: rt5033_charger: Add RT5033 charger device driver
Date:   Tue, 28 Feb 2023 23:32:23 +0100
Message-Id: <e65a6f6984acd591b3f0feef03a9c2bbbf1620c8.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 0bbfe6a7ce4d..2719c51b6fca 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -785,6 +785,14 @@ config BATTERY_RT5033
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
index 0ee8653e882e..0a3303176503 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
+obj-$(CONFIG_CHARGER_RT5033)	+= rt5033_charger.o
 obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
 obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
new file mode 100644
index 000000000000..6bb3d45a5e9e
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
+	ret = of_property_read_u32(np, "richtek,pre-uamp", &chg->pre_uamp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,pre-threshold-uvolt",
+			&chg->pre_uvolt);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,fast-uamp", &chg->fast_uamp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,const-uvolt",
+			&chg->const_uvolt);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(np, "richtek,eoc-uamp", &chg->eoc_uamp);
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
2.39.1

