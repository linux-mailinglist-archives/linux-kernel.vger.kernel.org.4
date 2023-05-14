Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7248E701D5F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjENMcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbjENMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:32:05 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E030D5
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067520; bh=OldnDodhv2UMYI2uWUh8c6nG0E6HngPbQQkkB+bleEE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Yh1V05HTSyaFt1uqWbRmOA8TIPVm3mJ5J7Jl2taW2qiwmVBG1hs1yohUaFXjsim06XK4d4Gi7RcU/r+U5G7x58RlDpo2s4E7gIAAftG/UMloKZweMnEEACd206NQ04Y8tR00oJ1+3x3EK8rN3n06Odf9S5HzdvclC8c1/3RIpI7RA6sGOOI2eggZDyjgnJggMU8U4wFQ/WRIB01HgwLhHiyl0gX2V7m7diY8bQ9SL2D0lN+mHvInECVzhX2cJC8PvhwV1rFk6V4j9TYWWTsdIoVxm11vTzPHg5nseqGGOCi0THm5aTQqzdlI6ZkzKyeOBeTaG4dWLvfsu3BnBrJxZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067520; bh=jnfGf+F6s62v7cprSAky7Cd8CejK/75WgmNOqwWM7TL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rYHwi+kgNWt7l5JTpKz7JsL0xOGgK4ut4MRkeHTJXxuYljVJy1iU7AMEGh7v/oJaKn/qbi1Ku9Lov0oiACPFU0q20u8rY4gaVho21jPi4+C5jo23THrMVgtOBg9iWIxDZSubSGNGg1BVVvYfPHRLyVdwLKlDfCAExKa/DTGHrf2Z7DzTeHtS5uN3vh9y3bPizKtC4VZkPGHiP27LGUuAQ1Gka9/R1Dy9UbsqZ56gI5JhozV0n7jl5PuHxjPtfOM+OvkxMORdNx+yYRz0HArY7p113BLn7A8BU2rQVBdrg60OT1OAjzHIgRQLJYkY8bDMZpoT/NpHZfXDa8sKL8vXoA==
X-YMail-OSG: e_yc170VM1kcBWD9Qa5K.yDxfOq1guwncs59YlOXMfwyTHcIGh2oafUaXuz8A0h
 43OHbccAhqtScF_3k5GqDqPBe_hShjTaUCK1c7lt2o_CDK5uLQN3tA.GFQMYaqyHgEjzUNtYtRjZ
 kNnzMC4D6tYDT3Rt9Hy5xeENGyoHsFETEclSpa5DUsdKv7MCbApmNiQQmEr7WrZfq6gWh6f22l6S
 X5J2DIy.rVvMRETVbB7YiqjHWD78bCiHngp7R99WTFhV5BjChNynzgXD0lEOCN6sAlbyAZfds0Eu
 VyOYpm86.bz2_KUjNB4E0D9cRNMUMrtaMSXpqGhG8amTLbxDoRZcgwHqN70bNajwDkY6QcuCUXKc
 i.HwCpk8x3q0vxabBHkEUbvDP0kyiJn0GutPvI0Ly_LwEBc_wdyoRiWcy5hpLr0LUJGz05VQFFZb
 wJ3I7iZyz3Wwemls3_xoGMZEHspjMggVltyNm4LuEL3_vDcHKrHVJEjP5tVny4cl4xjx0UHoNjrR
 KY3DdvMNti6oBCie5urp1G5m.TGeE3P0qq048Huk.j3P1Vot0_deG_vropQhcvshklDHgUgUFtJv
 tJHrNt4b0aPJCmNy5k9fH4We0DGutQsAO8v9UXZL82E7wXepwUvbRRsZKbh2AJ1JQKSWR0ttgPRG
 _jG1LBNn9G0hXavBpcVu5B0u.FYtVja.z23X28kpuB_j_s87U3VQUkUmEICe1Ot1N_8Jhf8XtXPX
 nx5SgLj3lcR8hz8MQwj.xAxyBmKjNAHu23F2s7yciWb9KX9fIiQl9Z9U8g7SsxOqLAZQ2tpUDBrh
 plWkWMfmTaUkYZICb_Vw0KM7usoQMskpz5bhtZ8FSEz.9dnn0kb73dPMaxp08BAGtxUJkqteIt82
 e83hcqkJ2YuCPp41B4CdCQast4vAh8eRSeW_LqK9jXQMfXK.ip7FFBi.CKeR6apE5r5XVB6tRGDM
 PjdjFrsb0h40HVvjxmS9AKhwwjKJbU.2lCIRuKiB.c0Pg0erU_bbGM.IhcgXw.ieW0EJvo1asWgD
 PxjUKQaYykQRiaPwCY7ML7OSVwaZ3EJP5W1f_RZYL6UvQZz_RIwVscFCsN3Fjn449Vy9I43S8oTs
 Knhd3CMxmL5suCUNh3oVQCpLEaufcQ89rubJ6s89tYhDs7TfA1rNVCUipRUONtZN6jtYUJlTdiqr
 BVBqq6sjRlajL5BfNXj.7STkML.ipImtOm08i.v.M9Fqx_LdeW8K4a7DrXJN.fQoeLQopGOEGUSd
 SA_TIy7MhnF0029kl9QUpdwcky56igZfDNDfFq7Z6a.pCUM0cPxLggrhR4keBx3BSUPaAprm92Iq
 RhBgshXaZPc6tUpIYcbCdNgk6RFU6.2T_1nJiVco3JyeHuSmOPe1c2_oB.mrTK4MMqtmFU0jqVj1
 ClO30WJS9VK0u930MUE_ToTzw_eDrSaBwaEdcohpSGAsSlq4OIOtb.OGS9EeHJB.ByGTpJaozZh3
 iJ7cq2eludaCska5.0PH3cyByWdjrfEBZpli6K6CgKiAUGypDi9zI2ZVE9mBj.NAXLqQ1M4.At_8
 DEDzZxBwLA4fAERjuGqrnd_MaJLYDxRPN6vWh1MfgQWw1UzhErEWJYySlBAOv2Ts9WiWhPUYs2z3
 ydc7AYeZVk.IXYNpSDcemBVpjutj3DHF1kQEv0PVJd6zYEN1HzrY80sqF.YRRBrYhoERdhdM2z8r
 bcyeZntAhOndmXlu4u_Je8cgJymqBHDnloQNvFD13LfQliXrnBgR2fikTeKm1.Ai3kZpbimWaw6j
 3phldlrCTF1Hcfjc4FTuDJfQIxMRsVQ53IbjoEFcDw2knQcigYcRDtGBgbc5zOlDPpbsb1_0Rp6G
 h_s8Dwh7pq1fHlZ66AEjX9dXhLiIcMvjUg_CCuqiGpLiLz7DXMiRfCeYzIn0li3sZULh1bBHBXRG
 OHzRRFCsHmgYjCgLEOR6_pQ9TlyzJ9SGYD8lg5v18sNO1jgkXdIY6a8HdnhJ1YNATVkVBNCM48Q8
 niTobHBg8US4_Zsbg8XukFmbcuopxxSBfyMtgpnPR3Dd4urHW0AHfk4jIVO_HOS.7UNU11h.o3ps
 FH1XAk7qfhOcHofzItGhKqWVSspKYp_bkSdY0nMpxh2RdFTGgfpFPYXg3a_ERcYqisEeZwQ1Wmli
 H1RVYvvt5RWIIztlprzGkjFPC853BAA4vok2JugyGM0atwT8Gs0s2BQAp4oSjIlRhfCG61D5ZFmq
 0BHQaQJiuSYjZSIZw35QtjOJ8Vxl.8O4vGHizGxdVmxCD912IMc2VphNhHDGkScuOS3L1Dubm65S
 D41QdHLhUrEIblBWFy_8bPxAiVU5MJT4-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 222650e1-c93d-44bd-95c8-65ff071e9161
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:32:00 +0000
Received: by hermes--production-ir2-7867f454fc-kqstn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32d47a946aad3f7d203db987b930ba8f;
          Sun, 14 May 2023 12:31:58 +0000 (UTC)
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
Subject: [PATCH v5 06/10] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Sun, 14 May 2023 14:31:26 +0200
Message-Id: <20230514123130.41172-7-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
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
 drivers/power/supply/rt5033_charger.c | 276 +++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 1aa346dd0679..7c7fd4cf0623 100644
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

