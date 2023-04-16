Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703E26E386C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDPMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjDPMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:50:41 -0400
Received: from sonic308-17.consmr.mail.ir2.yahoo.com (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D422111
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649435; bh=U4eMVUfWJ8XaHrvH+5J4MdBct8eeD1kSSIOQlDDshYk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=i0weJPFkHHKUGahoFSHKGbQhpm6ZsXyIVt8WSLqdSe//cbPl/RDwz/bBMOfS7uRTijgRTAVINYbuLk885l4nxrP3y2nYlutl63pfRu/2wxG40w9BUDGpW/SmxHyCM+f3ipDvoiotuubY6QQgy7jdDTIz5d0NpYUWOAuFRK7s+xNY9K8ClKUONj/7O9fBmfy2Pai30O5wqnzgt3UEJ+BqDL9PKQH4hLhea9iHtMi+OlFirPn9ofJgfUM0ZC7Hx/hFqbTp8Lean8kJjiWhwDjZrPke+RyUelTI72E/bpeGQXdfJNxHc4u3FC2pjEfRpEKuYl61qNHh0L+yB44aXarKnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649435; bh=buPDOhnwlqoYBBjwCWGvecJ5PpIl0GLue1+djqkbzyZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=grBNsuXfaTAgR8k+cBKLEJq6n+WqKhOk3H1YCLfnTrdwobq/ie2cpsKXpXRspL7UNUxXy3DRo2tofJ2J1ypKobLSuEheLfibEIOqYTWlZotgD6O0AMifBJBCy/YWKbfITOtMXjk6tomIaNZ6BekEHnXlNT06xx7onXYI9S7nsUve8Ai9z+u3htvRGkdGlqKE5SJDdSpIhvVjPy1+4W0N4p9UjE8d8cbbfx/DrJumQWNOdSaiP4f+8ufnQp5HEmgkcgb26ytTLQEEWHxXBPOuT3Wkz3dBmEHMWGneoz2NVsYC0CYuMtDK8AaM/rcUizMY+bMBLl31csve/UE3VV7Hgg==
X-YMail-OSG: GjfTNXQVM1kCSOcA9_TQfQSIh5c1CIcR5C0PwDJDfXUzefdx3tnTsTCzTw.sPeL
 L8Ureeo2yu1QxzN5MDj1LUNoUQB2OndLiN9qX0.JwTqV7Sz1Mfz9AWn6FiyyFI5KRdqkkPbCYD9k
 jTnO86aRx81DAe10aSdee2uZ8Z4jNH8_aC4LIC9zQAprLzgN.F41IZOPkkSXf5Uqk08xYzteGMfz
 _dj8tMfi5qmJvE2U1LMdHDNyrdhtsNcxR5w1UxWZxl1ptfH5SUb4Ci9VAeY5mPU0W243gu2PTqTZ
 Y88EXHOdgbKL.WDxPLTUeSFBxKuxsKdgIjdcrQdL0N1UBZnQg.pc3mCRdyUjr2iroCtMu_YO3Ze9
 EoeMHzSioNrE0Ui8u739v0KW6jMKxqryQhGdyOR3P7ZLjpZEDPrVjEpPIOeI07E8ZrAPl8IUAWD2
 6wAw6MXmutgOKa2YApSSFwzThP9L4jHiOy4dyt.Ie2jISp.p.FoTgOjgs6aOSltGt2DJ9ljMVxL1
 L.r6dy0Fe.3SyTbxTm_MInzpWUhFPe6RxVN.wJYX3EluPNAa8W82mjhYdpsaVAkNy3zWWjt2K0R.
 0ncAz8USuKdyN5DRsspj.IVeqpyffXpnNgt83vorMRAV10DNby.iKfAzsjEGAgTQ9k4J4MvPYIC6
 MF9cKVq6kPnlleGfZ4Z1i5q99ZpsPW74I3PdgUBuBy4xvPDm11ri3HkPxdP2gq_owJArN0RKixHW
 m5HwzPSbmffckwaaJ08Jw9xsLzcvR_NWa4Uud4LLnRoHHXpzi3nqSzfEtk7YkuZpuEjIIVcvW_2D
 Fa51_kqC7xh7ITw9ELVyY4UpkCZAk8JD.NpE.W5HmjjsnIVplvVWCzCIz47ijIqKOhIoNUm0QBWz
 8yGPGH.sPMCABcZw0d7hKVJlz7AL8WZbLViEeruY4jDOKOQQSKyftGsuLIGQbCXHTFFMC6d0pU4R
 9fckmQXsbwb2kkmF70BQvQns1pNdd_C2IDVnoBljxGGd7EqHUdOV3NKfYn_PLI1wZGaMwPqL7Ewv
 DShL9XYzjmlGjdElRLBUAQYxriKtv7uuKY.SmA7kdzi.Qgu3Fp2nkGnjIS.c5bYPMzgDRJAhLNXB
 MS9U9TZy7tvwtTBM8wC7qqg259k1w6d2Bo4kX0MVm0K3zPZktgB8LPjzSRyMlxHUz2Wru57d1IS0
 j62TrnL4oW0HgCf3c1PPIWbRiMeFxZXIRjRKufrQECiK4uqE5bzPwFZ67C0cV1DTDl7symd.EZl7
 kTqd3o9T4osnSR55yWMCPUBINETVITzGP4WV0XqjnYu9szSO0BFCYw3aIogqm42x4lV3.qM47c.C
 pL0x0mh0gRV1WSxlkaBg72jjL0SQsLqYjRle1.bQErUhPTBX6taL4DY38mnVbKmAYa44V9ARk6au
 .yfukSaHrBdkZrbBdzlisY5IupeG1LLD.llRzLtPspqutxCk3eRaqYpiXuqr5XSuBrHcPNbiwyl7
 lmTBkyj00JnU9Umxbtj.ZMLDzR4w_gaHDk0Eh8lE_NsL4QNnpUItdETe4mciT3IoEHrgLdgGwgSc
 CZJcdcbPGk.IhXR7gOlWoj8qdpHuDoSeGitE4w0xdzVdAeLB1I8vuZrA8K5igteQ6iKDtHABZwFq
 BJlePkCBumeQku33VcohfsOsyOKmMjTDh6AIWWU9I96FDHwuZN8agVXyewqAp9KbgghkcsHKa0.x
 tgtZJvXM.PLOhjbSJBvoREZCHzjW4vx8L_6Xx3hzuOvzZq398m0cyq6wDbNVqLgGoZ65tXLoLCTG
 N_fIuzrDaDvmG16MUY8Ke7l0nl_A3aQmB_ST4mPf1Jv.wXvo.aURZ1vE3XU9wTZdCOWWw5pnCoKd
 buaFJkK8HmcCYtxJuRTlfI9IZ6amiKhhGN_Ohm7.VztRM4HMX8tDBq0DnymRLv1xl8OGCdoQNErl
 68kgNeSFu3Ew1rAf9HwAFzTwEa4FqEoZV.9LOsf1bNfX2SSiL7xcebRyQcZhffNWdncKA_1cCj07
 IR_4zXpyHFw5FZtp_rxJkVo.qGG5JFEJJEOZ6d9UoNAGa7xkl3UWjWV6H_yupQ9ya8DTMaA4MNHX
 zlA.dtBUTnx9G6FBHPleTHj675gDuMw5zKbBzvNb.CNXzXc9BqEACSCTztY.CrIMakB9WB70ZXXD
 81th5qtwNMt5FAqQBBAxIlMghJAIJ2gI2decojEQfy1NzQIt.CPBCxjbRRbmn4w2JojijeORuHkS
 WrPzS4uKHLNRhHLysRg6fqrOBzc.MIFtm6cJcUX85GDLVTLIm34_NeBAkCCrfrq9FCPEvuyurIz8
 DHsdoEsSMluer0Ec3_tC6TqrCV9vB8eZMZRow52RbxWLs4y4.W6BYcg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 52d95fc6-ec98-4b7e-9a40-c5246ee92025
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:50:35 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1e6b4a18b1a30b9efb33afa6a04eb6c;
          Sun, 16 Apr 2023 12:50:31 +0000 (UTC)
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
Subject: [PATCH v2 7/9] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Sun, 16 Apr 2023 14:44:34 +0200
Message-Id: <ea015de93221addf7a148accab66e92fc7c1cb05.1681646904.git.jahau@rocketmail.com>
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
index b5be43e6ebf5..dd71233d554b 100644
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
 
@@ -132,6 +139,9 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 		return -EINVAL;
 	}
 
+	/* Store that value for later usage */
+	charger->cv_regval = reg_data;
+
 	/* Set end of charge current */
 	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
 		chg->eoc_uamp > RT5033_CHARGER_EOC_MAX)
@@ -303,6 +313,152 @@ static int rt5033_charger_reg_init(struct rt5033_charger *charger)
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
@@ -340,8 +496,7 @@ static int rt5033_charger_get_property(struct power_supply *psy,
 		val->strval = RT5033_MANUFACTURER;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = (rt5033_get_charger_state(charger) ==
-				POWER_SUPPLY_STATUS_CHARGING);
+		val->intval = charger->online;
 		break;
 	default:
 		return -EINVAL;
@@ -391,6 +546,86 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
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
@@ -413,6 +648,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, charger);
 	charger->dev = &pdev->dev;
 	charger->rt5033 = rt5033;
+	mutex_init(&charger->lock);
 
 	charger->chg = rt5033_charger_dt_init(pdev);
 	if (IS_ERR_OR_NULL(charger->chg))
@@ -433,6 +669,31 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->psy);
 	}
 
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

