Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D046A6296
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB1WjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjB1Wiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:38:55 -0500
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1919F2C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623931; bh=AI+0hvjdKYfuB0QkdFl88NWEQ2qielkjcdN5HypZVtY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=K+bYtng/VdIfpwNTdozQJArlLgcN/9aT9bl9/AkvLCmy4lpmGJcczzb6OVjP+9x1nueDQuOeUq1Lhbxsgia0NiQh3gwS05Qix4czhY8jFO8ZCXzOgCDZl/Nhoaqepe9R9x4BGhBG7PhDfyDwCN4EEL1lndMPgg16VGzeW1NH3LSUhRAk6wQbaAE30Hsm9aVEx3v0TznGvGltFLYJOZTGgu40zCiCEtXB1+8IUc9zK/CuKNoHKubTC1iSyuCNAi7ZCexA4jM5Wf5yIbYA7vLwj/9Uxk/gfohN4iiAme94FjiArgcAJvaRdDrLmyW1SxFwKGo4s4EDsmmfaNp7uEJDWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623931; bh=GUg78fiVwK5rF01aTpoXztZE69VaZmSMSXH83LLhrrx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nMgS7P3EpkqAFAueYtG50Jio2L2E9lgRKKAbcmlY/Y7HxpyvJH6q72byhQ0DiAk4lfGdUoS/Z8EPDo2frdswAmxu7yX18Pz1Rp35fQLMKQ8/00lIVjGvq8pNRJ4tbwOnj2XqJ4zpoheLFCyejbvwe9yu0oVPLCxv/Zu0ijdnHzIzeD8dqnpVqKHOKshGZ04MQvanGAMRmDubksPXluBmjV4j4TiWk62SuVs8YqGfgupf35+tqjQYIULJFiQbO8M11Zr8aO4bFfRyAgo4ePFq3qbQRpKdTBeMG+UbuUQa7DteTrmTNS5R5Qt4yVqzUerZL/dzXWVjUBm/IKkeyAwCwg==
X-YMail-OSG: 1TQ0hVMVM1l9r60NJxhMOVpxFP6LRBtKkPbGA652M.3tTnY.HurONKYxZrhG2ng
 Z3jczbeoImDlJaP5LIAyX2hJtVhRRBPQUYrLpWTPvZzQlTevzvbrJJFinfPpxCTfOSTIi8.5LIA3
 F9TWzzXz1AkA7NUtlSM26DxAud.BqRvUkUMV2950SG0g.QNeT7ubvMu84CK.Cu1AulLi.BKeGibS
 Bls7HBHy18vg02wQf0R_HEKLtosNHN_2gcmjIsq2JDs85i63OZyrO8_Ig0K9qK0JRFv4wc4O6KkE
 dBOmnTBgAKr7t14ZgwcXSb12ZVB199SkYheQw6cAd_E9BdIuUHcREapTjWZXkYxcrosh8BHMOxw5
 w1Mk_OkFhVMq5UzjPrrw6uxtzdGr8xABce4aKHZr0ar4ebmt0tP6YmJbHhwGnb26mWUzXDsjG_45
 lc0MKuUXIhuHnyn36F4VDtrspoOKtjbOhMxahn6zBLW7k4oBrIOjwfnkdwwnXc99O9NuTQwNgNdx
 DcF4yx.w7M7_VXDkDIjKXf8.MMQG2hnhHCCW6OerpvsMa5DqUOu9Iswd5Dk8NmKVlClrGiGBAPId
 QnbSuGeGThEIDmDvjHdfipDdycXtzoB8C1RjkpUKCkyr2jcELjzqXnIJc2xYL7wHL9Syz1ZdPecA
 44YEaOjk3xPRNc7uI56ucmYggUalQ2MEhbbuZ9.rZAK3SDZ7wGVM0cfD1Sa2som1n_1q4sPie1mf
 OO5k5kSEDDBPZviT5dI7qAoLDC9h7QlSFa7IpSNCV6o9tXDXvC02ALJTUBoNDnUekQUYIvXp00iF
 XL1ONkjiaZja3rEmxnCGg27I7NWFfG3n2ilJgMYN4UOYvyJHgMwT5S1gClz_d.yIrsh9xZTl4kOC
 BU3bEA5f2cIAouhsVKCwJPKUHryIikHJA0WDANyhbwCs4JQfu8z3bqRNaI_oSfaRjWQvx5jxY8Y7
 wr4ik9.heQXQn8RVzriQZL_.NTS3MuEfsWKceVoU7Eo1rlEzYQ9YYGTkiF5cmzzVrSEUuXxPaPBc
 eZnweFb.AjeEclv8UtTS7qW7V4hLJvECib4kIoU.q_KWrC2TlmBAuuDK5KqKyYJVV0lEFIDitRW8
 67bb3f05pLvEugmlGMlqdduSCoa1Z2N0GekvHb3pKvXRJe8L6CqyXbXCcOKf6bMbEF_7p5edWSb.
 6drupwRjjB7974wZZe_F5XAPpZ6DlvtOV9tQ50ZqnpPomoKzzytEiWscUd5jv.leBOFmxeE5Vhjl
 snmS2YtrTxOVbG_Z81TrpPX0TbeY9dc54Uf3O7OsMVDNLXenr5u7bplUTY7BdAfnHp0oLTABGmNP
 5BhBdZpRx9QnMoqlU2WIP5ia.ynMsgibzmqou6fHBrcT2NqVyws_AScjlaUb4Bv1LnzGQkP3Ow7n
 df.xprNDPK3NEBCt4qt.3ghVhJN4OMzl_ER6bka7JL9hq5CkAEeyQzZq67b97E_98vyiCqL_mPM6
 .uVneran6S0W5oktsN7PiSsdTRM9rCDZO8zBWHx4QsaIWLmTzb52LqoD1oSFey.ohis9NmKbjVuE
 oPqQnaFHeElUmZQ9UO.h5UrCe7tDX2bXtg6cQulNtMQSKu9bEbzJPLiOl_9zzMdg_zyvQ2bF0h6T
 _ZCG_SQVyb9iSVy_pFm6fkHxbBgaE4XLWs1ioQ1qwNVqBVOz.eHYXnfKrRoT_zv2M0SyIWrG6KnI
 lmB40RLcadrU13I47AtcR3CIHhhpN1PhOOu6VhyJPdCgi4ryRL6_Y8ywnqILE7XhreB_i1dICSyT
 rflZO5TR5wpNRYiJwOPcUd8tNZ6QMYDdXmmemOdFrESVJZ6RjrmdMoVB3L8UK9DpLZPGih0CuUiG
 gsO_h.BwYz2p.CnFReCrJ5COxmeP_6Wo9FPaRVchgZS1frIWHOhkZJtNsg_4wR5lJ2j2q_etalEB
 a94I1TPTzs8aI.mhx.tbiGZGBtL8pzmKhDEfmJ.RWNwN2S4AUnPoTnkHGpqe4hsagoZHPT_ulC43
 qdCP4xz1hNIVmWDP886lZiaJSM1eQaFzIW5n9XWnqEwDi6IfllTN6CenD3ZGm3a8IhrHiTHHr8rQ
 laavLr3ZHr9F.pPpj7QP50_pD4bdP7XWzsfTAynPBQwJr.Q9eIOKE2ZOOdLkyzekNtJzMcfj06Dr
 sJSABvR1U2Db0Fiw0oxmRdRWPQMFE7tFr.5UUAIBrzCkYG0q8o2AnbfGc3wlLDUjvnXs0MSimleo
 2N.QSQmdQIqL31qYpzer17t5M4rseTilBWPdcCte7y7_igEtSsGIof2liRnhBGpRbGXoM9zH.eLg
 CMMuXTlh1Yict1ykzTElm9DgCJCiRHdZ0gEdXY93P6fv9QdGlbe4w
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:38:51 +0000
Received: by hermes--production-ir2-65c64dfd66-svnc4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1052c26ec2388683ab738a7f87fce466;
          Tue, 28 Feb 2023 22:38:48 +0000 (UTC)
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
Subject: [PATCH 07/10] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Tue, 28 Feb 2023 23:32:24 +0100
Message-Id: <4ec6fa3f1b2f4a96267771e8f34b12f566bbae06.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 6bb3d45a5e9e..79e7f75fe634 100644
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
2.39.1

