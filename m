Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D256703F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbjEOVDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245352AbjEOVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:03:11 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CCA255
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184586; bh=0yYU8C7xlqmDkWwpaZRtoa3ihjRL8hLS5l3j8E2lBPs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QQ+B+jLwYioPH5paCNiHv6E0NeEfzGWbD/J7HyB6vzU6gLMVwxX+qUNrzifFP/yVQvHEyHRW5ACPws65PCAObQnY57x6dHbdWaGCQvVliJdKAJ2XDNZDNhZeZI3rZFxgs7fMeACsh2U6EfwusVB2uMUEdNDfRv29xH6jaVQEOq+9AO+2q4GokrhM9Xbx/r1QNikL3I0OzPpaIJKkrreVwHT4y6SAYypLnDQWza2DIMlZT9xCclTsEVf0ptt2Jh2C2+4XhavdpWS/ewFT2Qu1tGFSt6ehnZSIA79Y7cETdgZHxkxH4RTOb1jDJiVtiQLbTX/Gt4GIqq06EQBW8pF11Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184586; bh=NVNiD+pdjjadmhwgLAK0eUyIUAq3RengG35SQM/Tt/2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=C1rPwgB/BVaDAXPN47ZhFgW31D9bL8cupyPBvl+k/6kAMOLxxnk3XxJ1vlsiSmXedg1FzOuwHR3S1RjKsraAkiIvS3RrNRfP5wj6SgM+zhpTD8pvmDMO98N9nNkhwlAhsq+6FzVdoMqhN8QRKLUCfvuDRIHyD/+QsAMLXQLe/BfW+0EOlfXF0BzLfwGZe9ATDYhqdVKOXuU7NmFm3flQlTbInmIL8rJ8AVpqsSrg6YkXQKSLHVXIECoAaSZqtD/uikhd8mputlImJIFauuZIgqwssU5pxAfGAxBcyR/C/XpB/vJ3ZvJnqineu1qxqGnrD5xNxOMXeXBAnn7its5fUg==
X-YMail-OSG: AByWGYgVM1mbKTtZ8uP_TUfQnZb7HWosCrrBlhzOSrGFC8iYTw_5Alkfhwn9P8K
 2nHSIE.3MMzcHBsBqWZ2AzOpy5mEPZkTUsz80zNhvF8brXcqWoJs1PfiITfLLwsuAMeK.bCAJcdz
 EQyVi0PnIm3wt_DyYav72ynarwLisnCRVHPtxfhlpr6GCTugH2qrjeZYF3x3ojrDydisPScofcHt
 yZJ5MH7_gQ9qF54zi1QPWcrqSCpoR7EjkVoFwW_bmF5hvzfGq8U5zSRRvd1h1ZZxy50k2pQp29yK
 m3rme.Lgpeb53647s96Ym_D9dUkLZ5b6B.CkeYPOfj.BzZKk1vqwlDXu7negbqgjTfeD5GmRjoNq
 B5FJ.9HHH2gk.hjdqfidYlroaw0EOSLadnOUX_vDLsKj_1un6WPPrqFXVu_g8kyHelHvD2nvgE4N
 JKCpeTM8Jsdf2tWs6rSiD1EeGfl4Ijj2m0mDGRcVwzmR8LD05I.wV1MsSn1uv7aDjQ2c9AzLGu4U
 QsKk5wmytkRHBaN0fWNUA2t4QseOAPjRA69X5JDJF3TFA2Xx6eonMYE086z6Z7apEdRPqg5uLjb4
 Bajq.B2mqndpPSzuMvcA3EkqkW9xrgh1iO6yQvjvibOuZiShVeSQD5WDMIydtCj70No6Mr2gjB92
 0Y6ca80RUkNVswJVCbF3pBWixiGaWPg6Go04vGCiUmSmFHkSeVtp5VnOjqJHV5OxcQjQDKGQ3jxz
 1AhQcZrgI7_ZXA2cXZk.lWLxu4T2aScsJK0x8bng_KhfmXWGcJsCs20omDhyAWqcRZ9XBgmYpNjl
 cfjr517u8hjPasIrkvXB5MV0sY3b7XwnKOpQnbO7JFkcGCI07Nht.7U65ukzwKp0AhtOXyL5JQ2F
 a4dV6VSwBkYMj.nN_BHuYtVm30G39lqc9.YFUpvyRkgNVSwf.o86QK6sOSramy167QbB8ahkFCJ9
 OuHW_G86kbrlOU9lS7gWodAZS1THNGnqVvGwSO5xQTj8hVhiLYMHDm1zOspeGZJNahNgmvYiyHCI
 iXdoF9occfeynxnMdivhbgJ1wnz_.qljuYSY33WdrfIbE8v.JNGmpB7Zm.h82DhJqX12ejrBYI5X
 yq4DtnPTn7AxAwitoyUlppwxEnL27Kn9t3PtXbx8csbS0AwIOGYOue10PLK8atk5AzEKP7teL1Qo
 QbRCO2yLYdECzMB5UXens7E7KLx9oHBofsoG9e._tPWyOX24AQfxTZZ9DzyB0SRHnppNiCCx7kqG
 0wgRAbY.o_PYfKzfbo4Uuuhd7WoyqfuygXKc5O.QpRTQUm54fJAlp6e.C5qXAyHqsvJMzhQFsIl8
 Z3ahORMOQMMpy5oOu5mjrmi0220.Fj8w52AHgqAjGp.FxYQofHynqYGDE4h_Igu1_Czih_4ZD8tW
 4tmk.LJhApcOst.RSpWpssPmL1W9F9WF8jAiZjrf9zpGyiMPWC1iR4NLWHIwmS7Jm.ZSQ1kNX2YY
 YJsNRVNdqxg9npFgTWRy3wuQyFOBSenLEauY.ZoAVPGP3UCLLd9NfncPBPPvWBohL41ph0fk8cnA
 _bBWH85_c67MRIAFopRJUR9j5wrbde1YymuzLrZNazHlNVbn42nCisvuYwr6v.sKYn2u1b.3w8Rv
 txswCN0axWhRyXWQ62aSZPF.pzV22xAN7L.k0kt8Gr4IWN.bSZI3kGqLOl5xUy0jWOapg1YxsvbN
 IjYpt5.mS24E3vAyE9i98fn6rmwNyWtlJAzrQCRc6WeaKIOCIpkafw4NParj.gCqHLaXsTkXmiJ4
 ijw7CwP6nwlI7jBJHiD4yx4mnHN3h5ZapzUB1kF63jpZDgwZLIGt02JaG6maBZHjVTGf9wQyKBFv
 M_pohuyGciSp0VRd3FTNphQkJiaT3jY9g0LKuRhOip2rSbZe1lhPmS5VbEXI3cPSFxDZsKsWuDCY
 1Nuogyb7b2LWhQt7sceBLqJxs94XfyRvLoILpeNQyEaFCqiUG9_Ksltx5li_KqKbO2coQaHzQM2X
 yY1UVTKmeZPL0uMsV.LBT6R4DnVqZTY6g7lPXsjNiufpWbX7f1uqDchsyyKWGM0HOLjjCBvi1sDM
 SjaM_fT3fzzLA9IzaA2LxBPGQCM4EDu1L1tMNOnxuMxCfCfkWbbIWrDRpz0_GBiNg8n.fXc6bwED
 MdQiDUnHmgk29YfELmGZmVf8xvUERGyLX5h9ZPyjgLOOQS8dxySREw__5ucveMsUj.6nnU9vCbpS
 6myMK_UTDYWWvgNNXl3QyKkhE98TbO3wQVUgYy.UVfi1I5MystgvzfCu7VsoQpoSfCMhIO6YKBn9
 y8Lr1hlr5Y_mKWMiX1gint38TJkns
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 9b2dba68-dfd4-4ba9-8c0c-861d47dd301c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 21:03:06 +0000
Received: by hermes--production-ir2-7867f454fc-bgghb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8cd4b5b48eaefdf4c621d749d286a70;
          Mon, 15 May 2023 21:03:01 +0000 (UTC)
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
Subject: [PATCH v6 06/10 RESEND] power: supply: rt5033_charger: Add cable detection and USB OTG supply
Date:   Mon, 15 May 2023 22:57:15 +0200
Message-Id: <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

