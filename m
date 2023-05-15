Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407B8703E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbjEOUTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245315AbjEOUSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:18:31 -0400
Received: from sonic306-20.consmr.mail.ir2.yahoo.com (sonic306-20.consmr.mail.ir2.yahoo.com [77.238.176.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6F13C09
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181867; bh=0yYU8C7xlqmDkWwpaZRtoa3ihjRL8hLS5l3j8E2lBPs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=EwI4F+Wn/AfPcPVAWo3Th+beBcHuBdGrbg243JvxgJyofKOS5ubpkQo3A4VCvucxx8BLyegXHpZQCUXx3CNqsA8WGNQ91OPFZpvoByjM07rcWXGedfmGWEZdm4JcsyC/lo5WqtBJv0+M55OYxaWKKn+3oqERY2D8wmsWFRrgUJbg6QkJ8xzmCUBPusujIR9BzTirmhjw4FUCJ7t2LLh+EJLf2Qvv7P/MlyR6Kn5S15xQEzbmsekwaat8MgMxLcobFRuMgY5XHqpuGdRVPSnkjNeYwckwz4oxA1KcEq8nbMkgOciMgbsnurB2RGhFzbGditLuF5xNZjiW8mRk/aClAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181867; bh=ZoGB7gyigXBLm0ldR4J+mHTwuj8j1gR2KdkcljWP28H=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Utphzh+lv2/+5Rj7PzXi8cew2Cy/McQkP/tOE1gObDPxWE6LD7Id8Qz3dQTDNgr6g/iUJ2ClPHlb5UvtowP6pEybgcyUmVVjHcW819ZhuunTwsAfrEkRC5y7p+QQPjf1iOpgmQA+BzIHc5AN8+POknP846onR6mmAT5cOT0p8+Ol7ROJM6n1z1ZImp3rWzQKwLuzZcpG46Hjb060pO1FKZDWzPQXmCWCZLoTWw5N9auKtj3BpidUIsbQFUhq5dYNBBYllPB05S2obodWL9C81QkupjLP38zoKwWOX9jDEN5JBFfY8D/H7ZPdr7XbkHRNUpgLX1bh2hiR9QIYC98PVw==
X-YMail-OSG: edJtd.sVM1k1A9j4tOFjg1bhvWO2.OQuI3yOcPFTchaX6W1dzcID7C1SdwlaPb8
 kANiIfzyZKDeCto7dZbsNp9IjVED6QlrY9Y7POxvch9LCm4BkF8qo4n6BlhN5fe5.4NOGrx7347q
 ZoWfNwGE13P1Dy2LFsncJHtkq27L.qvF10QSVBq.j75KsKVcE5Q1fGZLPwmPbJy.WlM2mioZsMgg
 7iOClVBEH06A8v6oEYJpiLX6B4zSf0S47t.n9ja8AoHSsebkmPimB1t5_nBkuFJpjHtUIJJWKw0R
 lXI8chFHL2V91Ys5ZWwZR4sxNg57Qa7ypIyGDye3IE5t1HYA3ENZL_UPRt8Uop_KrVVMXr1L27AI
 2fOR8QV0OGTvpIECh0xsqUfcnn5HDmQHvWjJM9JPVHcpxIa7DTo4Sj8Y1vKGyzLaUHnFTyjHRkrf
 cMKb_Ri1pzS5rjUoe2Zq3.0.hZe8sihT7F_FJsIFY5LHFBbJvmaUiRWfY3RCYLxm_UszYGYUZs58
 xtUvsj0w.4WG4vBAvXSevVxd.gOfCrC0LqoWIgSxf_itwwj.ZxRDCIFTFB7XOiv2QJ0pq1fdJRyn
 oilwqsUJ52mq5cVgRuV69U65QSJCPsUIcY28t6jqySIcj_W6uTK1y_MFVYcANNYJN8XoJ4KFWWwO
 7dA0cPTtu.2hZeuOHJaHqhcCPD2Dtf7W8sHJ0o3rr0mlRStl7lOJCoffcgL2aSoWjQyPJcLryL0Y
 EE3bTXu7ycSi4lg6a7Y.uQLWZftbZQVXWMnTbQjFCpUmZoRJMQVo91JkmpVO8aWh4ti4tagfULCf
 u8AVPf3DuZtMraRp4EuNkjlokluUL_P8wByBNrNoUOvCqjtzcBujeVqGY0QjDnVrYOYT65WOMiTx
 tgp07r_mGZY7E2GrXjtrA8SB757vFYUpM5qub_az4dDjc7p768Zd6gKVyPGl7k42f_TSztOOCk_F
 OySvGvRrryw7bFhKICA4I0KRzgu65zVeSK7iV90BrmE1nP8_4vwlrFvt2qQUcS2zfZBiCgKJFsTd
 mEtZ85SqTirsX8OpmJP.UWOJcct9LCmGd_8F9jSf2qTfDAo9jieRIMJw76y62RpmVDRpCpmqF3XH
 IWGmFVpZaWxUBwoWVZRenOh8iH8XLaUqwJymhQUtSh63GPyH5ewYYpjZO8zTylHnHkI9HIwFdDg4
 MmPprCdnR4mb_kcoecXXxiQv06CvlFLu0.h2DT3mjeFMjCHdv2LkqCRwdr6IIiagXkirsyiHyM.m
 SNJ_MRIFDQR7_bNLOFgCepOHZFuP8yBYV5YallIP_z8nd3ioUhunfLKTKXKdicDRuLhRWRx47I.H
 rCwtPuJ.QdtkwUV01hdPWRGsTTFZs3vZzRQXWgB4gVDjZ7XRh9ve8XmQhA7F0sQM7jbraWUNVO42
 OGYBfU6a0tUp__o.sxcJllAp9ZlCJD2um6rTlcI2n5erdKPdY7qlxmxyoWeCLkuS0Z3lXSMKt7Ea
 oCZbDqXZMhbDGcKw_15Qip7YGfz_kjzSVayQ.nWodaCf.Ky1EewjxWwI38EJ_gF20AfiGs.Bhsgc
 GWZR5YlkdFFY8Agp6Qll.oINS.OMNaCtZTC3Kz1Qq6zbaHGQgXvJV_wIdrPA1fX6Oc.Rjv6dZGj_
 hB8quVN6kzYY1nDSQ9foDCLxei9ri_7Mv0cX4jTkjUmGguk9UBhskuZ32BpAC._3hA7cOTwkXq63
 zO9LfqJ2ZrtBVH4qwUVYCKTqPZczs.T73qVsb_abE.eJRcGU0_qdxYUr5STFNWDY3YFP249ITsTS
 T8VPBa3SDgooNaJSuu7HksLHlmOBlmrmLWrMlAXrBfSNF9FfFJlT7xyVKrK6kfAJm0wKnN_ByGpe
 grCAaw9JCtrUQyucmQrUaUsKZvkPeqySCGjNYsB09k2AxoteQzwjwFBq1Lektg3zqa3p3Fy8CgzV
 ExKgZ9NNkz1k3euOIsagCf_dAIHDlA2VmaJ0nUV2pu_66Mn78S0oVDnpp7H1x5EX6ZiBKyIqNkVM
 NCiXz3.JLh8sg99urqYF3DIHTD4.e3P5ybGEHCZxUFiwquKjbgNJtFXlsIsiaQGiJsZ0Ioa.R0Hl
 spz8RvkVj2btEdnvH5eBS4dlVpsV9wMxS5uXnJ_ICIWmTxtc_eXDLZntEAB1jfN1FH8XCUSb4I6p
 bozbV.H0b0XOF2TfYdTX022sbB_A9v.B.Eiy7IE3S_FQVmwaGvNKICGaf5D4p6qfn2IYpFhYLYvI
 oS5q9dz69dGS_jtvFdeHJRZ4SuIjVean93dHOJZ_PxydmTeLRPMLRZgfbKW87ucywCna31Qsx_8K
 mErwNR5HyQo0K.MPshlcCBQ2R
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 6839743b-6406-42b8-ae6c-93fb1d3c39d4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:17:47 +0000
Received: by hermes--production-ir2-7867f454fc-8nkq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cb456a1ee9275492b492c35f2e11856e;
          Mon, 15 May 2023 20:17:42 +0000 (UTC)
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
Subject: [PATCH v6 06/10] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Mon, 15 May 2023 22:17:08 +0200
Message-Id: <20230515201712.30124-7-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230515201712.30124-7-jahau.ref@rocketmail.com>
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

Implement cable detection by extcon and handle the driver according to the
connector type.

There are basically three types of action: "set_charging", "set_otg" and
"set_disconnect".

A forth helper function to "unset_otg" was added because this is used in both
"set_charging" and "set_disconnect". In the first case it covers the rather
rare event that someone changes from OTG to charging without disconnect. In
the second case, when disconnecting, the values are set back to the ones from
initialization to return into a defined state.

Additionally, there is "set_mivr". When connecting to e.g. a laptop/PC, the
minimum input voltage regulation (MIVR) shall prevent a voltage drop if the
cable or the supply is weak. The MIVR value is set to 4600MV, same as in the
Android driver [1]. When disconnecting, MIVR is set back to DISABLED.

In the function rt5033_get_charger_state(): When in OTG mode, the chip
reports status "charging". Change this to "discharging" because there is
no charging going on in OTG mode [2].

[1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L499
[2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L686-L687

Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/rt5033_charger.c | 276 +++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 5218dfbf5e1b..e0303ca5a8db 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -6,7 +6,10 @@
  * Author: Beomho Seo <beomho.seo@samsung.com>
  */
 
+#include <linux/devm-helpers.h>
+#include <linux/extcon.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -26,6 +29,14 @@ struct rt5033_charger {
 	struct regmap			*regmap;
 	struct power_supply		*psy;
 	struct rt5033_charger_data	*chg;
+	struct extcon_dev		*edev;
+	struct notifier_block		extcon_nb;
+	struct work_struct		extcon_work;
+	struct mutex			lock;
+	bool online;
+	bool otg;
+	bool mivr_enabled;
+	u8 cv_regval;
 };
 
 static int rt5033_get_charger_state(struct rt5033_charger *charger)
@@ -56,6 +67,10 @@ static int rt5033_get_charger_state(struct rt5033_charger *charger)
 		state = POWER_SUPPLY_STATUS_UNKNOWN;
 	}
 
+	/* For OTG mode, RT5033 would still report "charging" */
+	if (charger->otg)
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+
 	return state;
 }
 
@@ -147,6 +162,9 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 		return -EINVAL;
 	}
 
+	/* Store that value for later usage */
+	charger->cv_regval = reg_data;
+
 	/* Set end of charge current */
 	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
 	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
@@ -330,6 +348,152 @@ static int rt5033_charger_reg_init(struct rt5033_charger *charger)
 	return 0;
 }
 
+static int rt5033_charger_set_otg(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/* Set OTG boost v_out to 5 volts */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
+			RT5033_CHGCTRL2_CV_MASK,
+			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed set OTG boost v_out\n");
+		return -EINVAL;
+	}
+
+	/* Set operation mode to OTG */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_MODE_MASK, RT5033_BOOST_MODE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to update OTG mode.\n");
+		return -EINVAL;
+	}
+
+	/* In case someone switched from charging to OTG directly */
+	if (charger->online)
+		charger->online = false;
+
+	charger->otg = true;
+
+	mutex_unlock(&charger->lock);
+
+	return 0;
+}
+
+static int rt5033_charger_unset_otg(struct rt5033_charger *charger)
+{
+	int ret;
+	u8 data;
+
+	/* Restore constant voltage for charging */
+	data = charger->cv_regval;
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL2,
+			RT5033_CHGCTRL2_CV_MASK,
+			data << RT5033_CHGCTRL2_CV_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed to restore constant voltage\n");
+		return -EINVAL;
+	}
+
+	/* Set operation mode to charging */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_MODE_MASK, RT5033_CHARGER_MODE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to update charger mode.\n");
+		return -EINVAL;
+	}
+
+	charger->otg = false;
+
+	return 0;
+}
+
+static int rt5033_charger_set_charging(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/* In case someone switched from OTG to charging directly */
+	if (charger->otg) {
+		ret = rt5033_charger_unset_otg(charger);
+		if (ret)
+			return -EINVAL;
+	}
+
+	charger->online = true;
+
+	mutex_unlock(&charger->lock);
+
+	return 0;
+}
+
+static int rt5033_charger_set_mivr(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/*
+	 * When connected via USB connector type SDP (Standard Downstream Port),
+	 * the minimum input voltage regulation (MIVR) should be enabled. It
+	 * prevents an input voltage drop due to insufficient current provided
+	 * by the adapter or USB input. As a downside, it may reduces the
+	 * charging current and thus slows the charging.
+	 */
+	ret = regmap_update_bits(charger->regmap, RT5033_REG_CHG_CTRL4,
+			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_4600MV);
+	if (ret) {
+		dev_err(charger->dev, "Failed to set MIVR level.\n");
+		return -EINVAL;
+	}
+
+	charger->mivr_enabled = true;
+
+	mutex_unlock(&charger->lock);
+
+	/* Beyond this, do the same steps like setting charging */
+	rt5033_charger_set_charging(charger);
+
+	return 0;
+}
+
+static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/* Disable MIVR if enabled */
+	if (charger->mivr_enabled) {
+		ret = regmap_update_bits(charger->regmap,
+				RT5033_REG_CHG_CTRL4,
+				RT5033_CHGCTRL4_MIVR_MASK,
+				RT5033_CHARGER_MIVR_DISABLE);
+		if (ret) {
+			dev_err(charger->dev, "Failed to disable MIVR.\n");
+			return -EINVAL;
+		}
+
+		charger->mivr_enabled = false;
+	}
+
+	if (charger->otg) {
+		ret = rt5033_charger_unset_otg(charger);
+		if (ret)
+			return -EINVAL;
+	}
+
+	if (charger->online)
+		charger->online = false;
+
+	mutex_unlock(&charger->lock);
+
+	return 0;
+}
+
 static enum power_supply_property rt5033_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
@@ -366,8 +530,7 @@ static int rt5033_charger_get_property(struct power_supply *psy,
 		val->strval = RT5033_MANUFACTURER;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = (rt5033_get_charger_state(charger) ==
-				POWER_SUPPLY_STATUS_CHARGING);
+		val->intval = charger->online;
 		break;
 	default:
 		return -EINVAL;
@@ -402,6 +565,86 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
 	return chg;
 }
 
+static void rt5033_charger_extcon_work(struct work_struct *work)
+{
+	struct rt5033_charger *charger =
+		container_of(work, struct rt5033_charger, extcon_work);
+	struct extcon_dev *edev = charger->edev;
+	int connector, state;
+	int ret;
+
+	for (connector = EXTCON_USB_HOST; connector <= EXTCON_CHG_USB_PD;
+	     connector++) {
+		state = extcon_get_state(edev, connector);
+		if (state == 1)
+			break;
+	}
+
+	/*
+	 * Adding a delay between extcon notification and extcon action. This
+	 * makes extcon action execution more reliable. Without the delay the
+	 * execution sometimes fails, possibly because the chip is busy or not
+	 * ready.
+	 */
+	msleep(100);
+
+	switch (connector) {
+	case EXTCON_CHG_USB_SDP:
+		ret = rt5033_charger_set_mivr(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set USB mode\n");
+			break;
+		}
+		dev_info(charger->dev, "USB mode. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_CHG_USB_DCP:
+	case EXTCON_CHG_USB_CDP:
+	case EXTCON_CHG_USB_ACA:
+	case EXTCON_CHG_USB_FAST:
+	case EXTCON_CHG_USB_SLOW:
+	case EXTCON_CHG_WPT:
+	case EXTCON_CHG_USB_PD:
+		ret = rt5033_charger_set_charging(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set charging\n");
+			break;
+		}
+		dev_info(charger->dev, "charging. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_USB_HOST:
+		ret = rt5033_charger_set_otg(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set OTG\n");
+			break;
+		}
+		dev_info(charger->dev, "OTG enabled\n");
+		break;
+	default:
+		ret = rt5033_charger_set_disconnect(charger);
+		if (ret) {
+			dev_err(charger->dev, "failed to set disconnect\n");
+			break;
+		}
+		dev_info(charger->dev, "disconnected\n");
+		break;
+	}
+
+	power_supply_changed(charger->psy);
+}
+
+static int rt5033_charger_extcon_notifier(struct notifier_block *nb,
+					  unsigned long event, void *param)
+{
+	struct rt5033_charger *charger =
+		container_of(nb, struct rt5033_charger, extcon_nb);
+
+	schedule_work(&charger->extcon_work);
+
+	return NOTIFY_OK;
+}
+
 static const struct power_supply_desc rt5033_charger_desc = {
 	.name = "rt5033-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -414,6 +657,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 {
 	struct rt5033_charger *charger;
 	struct power_supply_config psy_cfg = {};
+	struct device_node *np_conn, *np_edev;
 	int ret;
 
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
@@ -423,6 +667,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, charger);
 	charger->dev = &pdev->dev;
 	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	mutex_init(&charger->lock);
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
@@ -442,6 +687,33 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Extcon support is not vital for the charger to work. If no extcon
+	 * is available, just emit a warning and leave the probe function.
+	 */
+	np_conn = of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector", 0);
+	np_edev = of_get_parent(np_conn);
+	charger->edev = extcon_find_edev_by_node(np_edev);
+	if (IS_ERR(charger->edev)) {
+		dev_warn(&pdev->dev, "no extcon device found in device-tree\n");
+		goto out;
+	}
+
+	ret = devm_work_autocancel(&pdev->dev, &charger->extcon_work,
+				   rt5033_charger_extcon_work);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize extcon work\n");
+		return ret;
+	}
+
+	charger->extcon_nb.notifier_call = rt5033_charger_extcon_notifier;
+	ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
+						&charger->extcon_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register extcon notifier\n");
+		return ret;
+	}
+out:
 	return 0;
 }
 
-- 
2.39.2

