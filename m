Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF16F92F5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjEFQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjEFQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:00:35 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B61386C
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388830; bh=4mRwXa1gMdue93vMRrJ4TyF/6qEdHlr7ly6l2Io5b4c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rGB9pKZ5NnXKaBsknCQEViRw++dhLP3PWBQ1D+/MJ+vlrPtSk/LkhlvuePNtZT8Tp8LakLoXIdvJRhAoYAMq4y13aAHkK3sWAlDOiBttK65vqONI8KTH/iDKWxh4Mml0J1MP5qu4npZ0+U0iqkzOJW/vRIY+5ErOvlk+aeymGXfZcKdgDq1kXZc5N9Awlu4bH4PyNEGmEdej7Pc74LUs7yTHHSNTjki4YrG/Ei38mzKK5PojWMPB7cZxax8rKCYRWToeSsBA1V6BwoNpk6JqgaJVJ4xZKLDGLgZhhACBngDs7OXd0/qCIJjpxwIPTIBHBVzUNWSCu1ujRpqTLVlbIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388830; bh=xB8idHuK8TGsO+HBBhBgz0PGTGLsvyraG3xA/WePFz0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jqmDC6aSNOR3ntbywT3Twbuu/hygg6B1EzT//vjr1KunxHT+UiNxiMGZbZopF97wf4hAnz5r72gLO2SxHBcUdZM7uNnJ13qn2kXuS5z9PSGAT/rOzmi6TFd3rvpg+cwefxORR12jUuBKJf/qGVm7qi6tORNOMl2Kc8fh2o4AT80V/yzLJMaqrpPPyL+RTz2tZ+Wvm9a98GGbJ4uR6WTGTmepjohfzjmMFyi3jiWZd/fhYQebqrXQHToOIQI0xmgpBhdH/vo1tMe3mDF/9Co0y/gffbGQXMPnBYqVNVp9UO7ZvUzARQTBNT5c3KpJy95Zk5q46RDaJ1zgWHNQg8SyqQ==
X-YMail-OSG: TCZOCYIVM1n9hG4vqWnFQ8t7EqcOViTUJbtsX093nxKVfhA8d0CL4S5fIouDNRn
 mLQUVWzLMn269NiPQ.nSNyzQTVyeHl79RyXLAZ8fcXxQKxCPezYEJUGO6XmPL.abVPRpn6uMLDT.
 0voW_vma2WG8v3J2x74huHXmnhkES.AxlBnm8RyywngTS9u3rKhJNZSAD8wPL9fqiZCTll3TT1Q5
 Be8UvtvzGYQBAvS15f24WB8ekeSinGEN9Zd1QmD2gQ2_I_W5IFIyBR.S7fuxVILaQX7YTBCbBEwF
 X9AA5Y81RBCW3rpG4osCe4_BjsUGXxJ6h9xnBRxOaepuSs391AZ57OfJC9gKkJ590W1jzKcFLk8v
 TsUj0OZj5l8COrdzZfF.vFp6CvXhTz.GiWpGZTuoo8Z_jz7qHDtn_TJVHUxycGz2rOAwM1B_bi1H
 bB1HrCfbPZT2kFX.lQxJjDHASJZE6d0Vsk3OD5wUNp1YRNdkcWt.DEHDXbCypz1cbwpeMMtqOjUf
 tNTpytfPy7DTEjGMHDuAeg1OemHZK6EpYVz3vPs8jdx_R2ivIW.x6OIR.VuW55jt.8UR3XpUkL7y
 _Hb28TrL1BmEjbvWcljYo6568dCL.Qi1j8MyXrgJKFosRC0M31.sC7H3qkDdC.XbzsYY33a2iTJI
 _NlCSySxxkfhN0KY6Z.j7.tuXbSfzwnkiyo1nTbapDx32Ww.1G7OEAbMm4SfZtPzpxoW1nSTgiSj
 Re6uHSInW7MrrhzI3yOQMQ_wKsFL6sc81AGnUtugg2FSB9c.CVceN7F.8xNftw2CNQrOIpaqjAf5
 7N2b6IrqD6grPCSWmFzlkdQcyy2_fa7u3za3SAlA5FKlXd7vGar880O06dmQfdghiD2HVaTOnyhz
 .O.Seb9lXcQPGscOtY0VZJx1qCXSbHBh6ZU3m4WBcEfzOU0SQfTASsLo_URSXj93myV_E.noTeNT
 fdY3.TgBczlI3Ip9vXypH0lHxKShi55.NeY_pi1T0WdKE2.vj6Pi.5TO5DrPkH7C5G8zc47PlZfM
 2Ke660208ZJ2mp_dDl1YFl7rFOczAGkz8ypg6DGnju2SLjnx2GdE1G4VKSl7MqDIr5wswVzcis3I
 7xbfpl4M8huoJuRjaPnGgBvg.GrvGFpXikMCW73OZymcL7x1CrWbxHea0boLMM6JrnT.4PoCQgGB
 ggnO4mpP2oL6scbYwPJyfXmBdMRwm1_skTwArovdNyPSxFnNmhdLiheKv2dRvDA0pZBfWp2SzgT2
 NJj6Rk8FgXorwVc.lN38YN_b9p.CvtpEIRj8DnmAOJPnHg2fj5ogcm4WWOmY5znwf62CDRbXvk.c
 HJVqWnbV9cFbUw_ifkPnsKGsJnzMVCXs3ZdTWTXBBRG9dL2LS42ZLafBiB.XgzV_0hmtBzWin7i3
 k9dmokXmufdwHmkuy09F7EP_3wJ_9xqT9INsz5eVlnowM6vCRPlkWPjwb5GHvdBysctSKejQb.Vz
 BlcbJG2BHVBr1I52iBE3be9xFBCdUlTqd8lfpYy1Txx0vGZlQO_kBFXZH_dewJ2EGjX_yk.AqKSv
 Y.oNEcVQegCS87dLxo0zcfBfmh1RE27DWWEAz4KihZqrlCToJmAOxfd0_QBvg_dsrC2ti_8yiuC2
 PX2U14QchfnTyO4bF4K.fvR5pejpf4dcSczpsFoutSctOWE6V1pxEA2gvnxA1Uy69CbRzSY9wNsa
 A_n1vuLrew2CvXaOqe8xgB5Hf1U.glu1V16FjQEtXYSfQQAtkG6Oj_69QSUZ390yN.mCCiigEPOw
 cdHnhZggOotWPkzPwadnLuf3WUTPaE.B5yLxSzTUfOqU25dIb4OwV2yGijuTagWJpiqujAtlJqMB
 mrTO3R.d.ZZq2uRrZS3P2rKYMi8e3ney2hOdWPlTr5bUbqmP0g1N94FPuu5IddmcGza1T5gRZPuj
 fP.erN6.oi6sHmPAjoG.RxwqJykXUYVpJOKUxU..pA7DuS758P0SkjGTqfyLNHk1EcKQ76HKwU.5
 DMaMoaqo9hbJxQtgk1TZNT3wsbAjsmtlojXkpDGKcuDctLH2RBtRrwAFoWULsb6ZeNb.Cpr0_jDe
 N0sPMqkVO6kjnvMlFvRSmlvHxhsGB1A08PRzDFChNcRnN1uarsMrw2cXjrbVRrivkFzwMcnlQ_Ie
 HKH7_3tZ6I27PUpg0RMaRpQmIbAS80BS8K2tSKuCwcZ9nGROWkb07w2pRbczXxqnYfsqHY5FGjCM
 cBTkxcztgCNTYicHT32Nc6NAmPci4aZoX7AU8WBmWrEPBP2fzbAx7Tw3Uzf_jz19VUZ9Tl53bRay
 C7dtQky5nuqTd4G9rnc6MTR6X86nC5g--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: b9e49314-84aa-4bdc-92e2-d05d9fc2a404
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 16:00:30 +0000
Received: by hermes--production-ir2-74cd8fc864-j696l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b71ff572232817f95ac730737b6b2406;
          Sat, 06 May 2023 16:00:29 +0000 (UTC)
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
Subject: [PATCH v4 6/8] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Sat,  6 May 2023 17:54:33 +0200
Message-Id: <20230506155435.3005-7-jahau@rocketmail.com>
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
---
 drivers/power/supply/rt5033_charger.c | 268 +++++++++++++++++++++++++-
 include/linux/mfd/rt5033.h            |   8 +
 2 files changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 038530d2f0a0..fe63c16a9d51 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -10,7 +10,10 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/devm-helpers.h>
+#include <linux/extcon.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/mfd/rt5033-private.h>
@@ -44,6 +47,10 @@ static int rt5033_get_charger_state(struct rt5033_charger *charger)
 		state = POWER_SUPPLY_STATUS_UNKNOWN;
 	}
 
+	/* For OTG mode, RT5033 would still report "charging" */
+	if (charger->otg)
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+
 	return state;
 }
 
@@ -135,6 +142,9 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 		return -EINVAL;
 	}
 
+	/* Store that value for later usage */
+	charger->cv_regval = reg_data;
+
 	/* Set end of charge current */
 	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
 	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
@@ -318,6 +328,152 @@ static int rt5033_charger_reg_init(struct rt5033_charger *charger)
 	return 0;
 }
 
+static int rt5033_charger_set_otg(struct rt5033_charger *charger)
+{
+	int ret;
+
+	mutex_lock(&charger->lock);
+
+	/* Set OTG boost v_out to 5 volts */
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL2,
+			RT5033_CHGCTRL2_CV_MASK,
+			0x37 << RT5033_CHGCTRL2_CV_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed set OTG boost v_out\n");
+		return -EINVAL;
+	}
+
+	/* Set operation mode to OTG */
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL2,
+			RT5033_CHGCTRL2_CV_MASK,
+			data << RT5033_CHGCTRL2_CV_SHIFT);
+	if (ret) {
+		dev_err(charger->dev, "Failed to restore constant voltage\n");
+		return -EINVAL;
+	}
+
+	/* Set operation mode to charging */
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
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
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL4,
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
+		ret = regmap_update_bits(charger->rt5033->regmap,
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
@@ -355,8 +511,7 @@ static int rt5033_charger_get_property(struct power_supply *psy,
 		val->strval = RT5033_MANUFACTURER;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = (rt5033_get_charger_state(charger) ==
-				POWER_SUPPLY_STATUS_CHARGING);
+		val->intval = charger->online;
 		break;
 	default:
 		return -EINVAL;
@@ -392,6 +547,86 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
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
@@ -405,6 +640,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	struct rt5033_charger *charger;
 	struct rt5033_dev *rt5033 = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
+	struct device_node *np_conn, *np_edev;
 	int ret;
 
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
@@ -414,6 +650,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, charger);
 	charger->dev = &pdev->dev;
 	charger->rt5033 = rt5033;
+	mutex_init(&charger->lock);
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
@@ -434,6 +671,33 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Extcon support is not vital for the charger to work. If no extcon
+	 * is available, just emit a warning and leave the probe function.
+	 */
+	np_conn = of_parse_phandle(pdev->dev.of_node, "connector", 0);
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
 
diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
index e99e2ab0c1c1..d2c613764756 100644
--- a/include/linux/mfd/rt5033.h
+++ b/include/linux/mfd/rt5033.h
@@ -53,6 +53,14 @@ struct rt5033_charger {
 	struct rt5033_dev		*rt5033;
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
 
 #endif /* __RT5033_H__ */
-- 
2.39.2

