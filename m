Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617DC6F0F18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbjD0XgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344323AbjD0XgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:36:13 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A9F3A82
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638566; bh=4J5rrnZpFezswuJYUtyHcCH81BOdg28v7BlFqifkzm8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Qud29B6J1oIVlcWDGq6UV1lwzpgfD1HbmP5bmNq84YMnJ4dOp3hbBDqK519RYzAu3pIBjZlOi86Qvyw/NcSQUjefxt4BArmxYVp6XFSVlhgVrlgNzBBcvBFlk0Rb+DXgM/GLRn5/Cpnf+DLdsGiGpdaGZHO2a8uTSVKzQ430QzZ8pVIUHBl6pbhwhOpO5lS4H8jC+mKcWoKj9Zks23td7i8IBLtY8aBJLJaZqyw1GC+bPj4X2wmOzCkupJpdf7akt26OWGCELAxuaMhjPmlI/MxjOl9xYEhC+TL6RxEG0qOOtjQazG2f5cgV010lyI4l8woZfW1OP2JlH1YKPXOEKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638566; bh=98lvrQFm7c8NwOqVpusVyw7RfMmf9CjBnCwImldO5kC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=teF5e8BM0jI5O9E5u6ZHhwJdzCBONsLu8opuaV1NOkah+sX0kkDlWYhOduF1tVV6jaVSkRm/yKdjP3+KTidhckuhGfmw4GXIurSrRHO8qhw87IOa2ltnc5BGp9g3H17gDOQTh4z/6fnMZh6ZdPWvoQHONUP/DE+ZDSoh6j0eIfPruJWbAZK+maiK4qqnoAZV5LRisTySzgklRM9jnQABwpDoMo7kWqtT27RDg7gXQMXvwNBeadvGuWqwM681dMnuRpi8GVbwC0FR3CFP7qNtbEjxGG94wkRR76+KU1aKxWaPDQk7W2zGZKSbJ2vk9pzygJki5dPMcNtV0AXoPu6qyw==
X-YMail-OSG: 9SmrivMVM1mtRz6Bie8xL0zchITEbHi83Ie4j8eNFAMaqjlQBfF0cRtL5OstS07
 x0PpQ1AjPnnXRNUIehY5Fg_c4I8nhag5GWj.wtx33W98DGTzgfBq3bXJ8EE7EH9tZdOiNRe0FOPd
 d_9FDlkSNvwETMcIqSLW4bDsE2ItYwa5UXbTv1bZcNiX77KZoFFgdWssRBhlGKGMLs7UTdRJGmgs
 suZUdToJ0adYcGH5d.ojBJ55I40_XjFIJhbzIk0gcPf1AGOuywU2OlwJiuMxNpzSGcGxkysb8s8s
 C499Zba3UdwY_7NyfcrIq_dcPYNFEwVmgbniP1eebaL9CcyRZaAQr59bzg_faORwKEAQUjiEh.UH
 ahSd73j7sA3IFYuz2X.b2Ndegu5iWgnzTW4t261AIVQSHYujfpyI.MZeaEm4bX_OdKJ7Gbyl1GtJ
 _X9HjyB36lHomac_eQ4T75jJkVgb9JpSc..eHQi7x0C2IQN6P04kJG85lM.k.wMyBcIJ2.w90c2u
 OerbciDXFgC3WZ3fLIncHxP3eOm6T2wgXENdChC6cWN49KYSpvPdpVH._zwXdz57FIH2_qfwP36M
 4PcSsEFYh_RkgeIKlkPUTTCLNC2xii.UlLXAvVElNnyKaJnW7zOApEVXEmS3rONb_uusEd.s0FAl
 ipgZBVnCkeMN01T1I5vEmNoSP_FxOSb1k28MH_NxmtLgG6uCamzvpRddh7sZiJoQDdXQoPZZockr
 SiLMnmFpSHvQFxFDQ1ioCT6Lg2Pdl7DuLJFWetr9DhiPYoqfTyIUKq4jzfMNRSDlC5PVTJWNAwPd
 VZHb8abtUaRore.gfkIipvreBzE6Nud7KcqUksZObTY0uIPODBfonZS4rXBv1fmw5Xo0osRxLho.
 lx_d1DeTQgjM3_ONwZn28ZYLIG8EZUr07yqHhjcnzveiQ9AOugbrzu4nUkddL0JG67i5mnIm_bHV
 kKdGlnV7Dg3gO92bwhKCFqf6rErw00qcHKZ6_F3BMfnV7UDvUh.Ipf8vw1VTeNUNDPnAgoqRVIk7
 d_DzVZ5gddO8Q5.MHrULJUzc_VkgxTKHqt0QqVqPoj829ZGjiEeOAdTWWKtkBU81fq1bA_62fGjg
 qLYmaCjM2QiIEdumP0reX3Qbwtsyl6XARxy4SuxblwRIqRBfxQ53ibcqVGSiun8JzTxa1fz3FZ6m
 yJwTKp9HdoQYibDJEKDTPAcgGQDvxwYwWivOV8NLHMzUcVW8gvsfvx7jxbfv3C8uysD3lJ2n7fZJ
 QZ2iZThEbr3LlrQQLhLhGmMUuc1g6JirDvAmbmwB9gD6I9ZgOpQh5sLoL0z_wCeygCRuD2fECuel
 sKgLuOllOo2V8lhZY9H64cOwlEuVSwSb6O99XmJafsGVMmD_l44pIVlydaUGQVA9gtgnr1aKdHIF
 PduJcIgQHJ.ht0ot3EsY_u3F9MilmgqqQdhGpWORBxqCuO4SClcLbJRWFGhFPNs8mfOVmE87pnRe
 NkcFgR99lYcZ9KF8nsp0kpFi.w2MtwN2xUmOIjf4VetHaPxfVFqCh_5PEN2clDCGKtEbuP_ydKaB
 2c.9fg957rl0b5P0mY2KQK_UMsihBVJxQ03UmmOrgtg1pMpPhfkrXDHGylagguovaJV.PlK970MA
 irrQ.Xp9IAPjMOmHAwSO.k5vqIzrQ2LKe1uie6figM8eAzdKNeK9zesBJvFIcTcZe3FocINthTwI
 bPxRhmAQC1my.0XvDamH07xZv7URHueJxNmzLO4zVsT.LtLMjS1fjeSVgRHJjqJFbDy_QO8JTnA9
 KqhXnUiXwCTe1Sx_I.RO_P80Uj4WUFvjrKsKOFSUcsPt05ZQ.cEBVAxj_1DjwiN2EV.cenIxoobE
 Rd4Vwr87YC_U5TaU.l9.MykErYKkxjLNapI4DlMb.zfqtOXNzqkjewED5c8YICGPLTcq1zkpm7gB
 sz3285ARIG09M2I5YkiwpBIFuCj_ihfXI_eJapFNfE8IMoMqDD10_8848QTJObsyjLCf7IyGI6u2
 HBpe1Phk1.ciacf66a0YnqOo1E_4vrn01uBLC.pKD16ByoBv_mubwqT9zrhEUzs69BilmOy6u4eA
 ehgEy0ynoF4sQZ_zPXEgWYP.9Kr7ccsA.v0ZXNZneG31y6zdPoCJjVyUCezf_LKPqhiT1.IdKHeC
 LkAeEe_idvn3eawj2haEQD6lDS2sBD5cos4Zr0tO49RsG8.G96wOHOoV4izgMF_JDMV2EbcOsvuE
 zSbuGoHrn94g9C_h3N0iCViSUnEsZOIfuxe_U3Qr8Dxx3vnBsNQ0..MovHD890CQsJbM1Uqgb3tN
 SFKkfMCgz2GIKrHuprRBrJ_K6gyo7mQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 6be0123e-0453-452a-9532-38378e2d7a86
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:36:06 +0000
Received: by hermes--production-ir2-74cd8fc864-d5c78 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b559be960ee93a958c6ba15207aea559;
          Thu, 27 Apr 2023 23:36:01 +0000 (UTC)
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
Subject: [PATCH v3 6/8] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Fri, 28 Apr 2023 01:30:09 +0200
Message-Id: <f66914a2b46651bf7ab9fb2728d13aed460b245c.1682636929.git.jahau@rocketmail.com>
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
 drivers/power/supply/rt5033_charger.c | 265 +++++++++++++++++++++++++-
 include/linux/mfd/rt5033.h            |   8 +
 2 files changed, 271 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 038530d2f0a0..94f7b8e0da42 100644
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
@@ -414,6 +649,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, charger);
 	charger->dev = &pdev->dev;
 	charger->rt5033 = rt5033;
+	mutex_init(&charger->lock);
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = charger;
@@ -434,6 +670,31 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Extcon support is not vital for the charger to work. If no extcon
+	 * is available, just emit a warning and leave the probe function.
+	 */
+	charger->edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
+	if (IS_ERR(charger->edev)) {
+		dev_warn(&pdev->dev, "no extcon phandle found in device-tree\n");
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

