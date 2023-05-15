Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD7703F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245449AbjEOVDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245360AbjEOVDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:03:12 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453949FA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184589; bh=Orv9xlXl2ys7vR4uDv3BL0KEya+/X55FDQeChcF+Wx8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dF2MhJ4CqN+DNtcgiesNYvI9c7QNfWYv/sIaNSVrKAC1obA9Af6O/R5S4vC62+cinn7uWC0tPoVcoqRX60KcrEfq8W9znWZcV2iQ1ejahx+APBrN0U+QdRxc2Xwj5lFamBX81w+qENwNfuSu4/sJbqNip/CGoDQPJDn/YaJDjfb22WRp2vwNoPG/uB2VtcstJe3ctCUyC4G/IAElT/2iUozagAcIuWgLRBwSxu+kvChWhvFiRTsN0lQXRSCuPCHLqH/xb0PJSGXLdi5YXLLRljdm3XUMsa7tVWG+65RXaz1YQkdo1173M7AqwTI4nhgmcoomrOW+4w9IPC5WNiH3ZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184589; bh=PlXw4B/ZlsJpM1fBOzAizKqTx+HLgraJahk7CBFeWL5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aXxQRIy9NEiMmwA2y/SFFxu8kbmk5Fej+xSfSz8L5WaMe0eUNvfXratA3p1mAg/frU4vP44xmlM7qnwiU+U1sNlqgOWSVmxbXoBUmNbC0U5T9oPKuX2JOJedB9frD9KSikYOz+hCAzHChlDgaJ0yR0+OKsEuS64T+PrQZ115+kIVtfsUTpJ3uZlZ0UE1c29ezpIuS/mS+uU/u7SAvx4dZX4sq5Z3Hrekwxwh7fn5rW/P2wE9AtULn/OlA6A+Bx+F26s7N4ryJ2AgKXOR62f6qfXZ/c66LiLWJPYGejeohfaaK4PBTdqRYTV9LQdoOpLLn4MuLbm9VEKNL0ZndXLG4g==
X-YMail-OSG: 2uk7uLcVM1nOrBPTXLT4cA1oTH8lVphI8bXzHm556tklLTUq5IRZHJf2Pxu242c
 OT92p2xNyeDS9w7816H01Xmh.hPulbFH3fBsZE14M9qivkS1_1oT5d2upREYsndQ6Arxx8Cn2qEt
 gmh7kDy0rG.1FE_7aDgU7P71yYv4sHjchSonzqZdgdD9LUbrCNqt5wTH7BGI04JA9u.yDeMY3iii
 uW.RtoyJtN66zLgMpAEmplzGLc_nen.NW_Ru1Jton0Lhi8zMgwwufNE4NnKeq.3zZht_enbty7dP
 Pn9_ZXN1rB.upi9bfZnTvvfEC0Sv5DK1x07vfb_19YCYUSuBlLmHt1IrkROy1OcmXN2JGhocg6J3
 ykjSNfNj8aSX5Cvpr1UwYZrR6mb6et1wGrhiAV3ziTVGPX3LQnkBzbXfq_Lfg9eKsEqqLnoXZzta
 McApfsFCfy7RnVG5rGxEhSmgcumvP.oOzZA4yrDISPxsYnfKSYT3QQ8_Aau6BJV9NmGj3aAUcasR
 oM..H7mwSSBfdqrSY6qZkcllvV_I2ZFBaKPlqu4RiCfzlZanSm5sg4ujaPWmpXJu98ph2X4FXEex
 TViF9EzH95OHazLBPOImtgTNY1GVCpbutjHemJwXS.pys6VNnqdC3J.KGbR3O.HBKXxClFfYHo1c
 hPYpkEhSIt7oCVy6.8RMjdncGiPk2Jvg_2O.SjPIaCK_fWAfbkFLVjsecb.Sea.2ajePvkZ1NenF
 cqCNLhonvaiMkhXv9F4bShEOH8LcmXFt0nSGdG7S5yN8dehs8NLl7VFyEu0NwevLB_CiEqYU2MBE
 CEuqQDumdcU3BUaEANi0e2k70_i2LqHDE4ZsfqBZ55ulzj1cIVi5B7Xyu5NQ0jej8stlQdsHOkGP
 Jp19U52edpC.nCtaBKnBBss1Pg3DT3w2.GKuZd7sbguOCh_9ZIeBHXltLatfSCDsBdNDJ5BfoZcF
 o9erUg9cTJal6HPamclI7oPctphd9BBGIWz6SdTgiSOftejXrUJmuS.rUZWrcWXURoqE6p_krQ5H
 XPZs8Mun.ww0K4C96u.KvcU4j5ewUXuqpAQh0cu01iJOfybs3Ns5LlOVSOIKtdCHfFgdoZFq8cSO
 CyhPA1m0QJ4dg78cBle.y9bR7MINz4odC3k4Y2u6.KL6kAWQuDag7rthKezgDNcHLPVGM57Dqwo0
 hmaCrm3S3JRdiW4kxmT3aDo_jQTM20jRMKyEg_OgHCRmXjQNUl0PRn4EK4QWbZtTlKeQSHOtUk6w
 D1dRniAG20jl7WyERMlf.cGZ0gLciwKn1r8Rq1yPoZllLALuQwmyMRvq2Ce45EN2u9EOZHpKJEjI
 W3cBtE9MRSJbZJiSF28c00FPecH8JzT_N.Bru1YJ57GJuR18you6Cz1xoYXyvoBcRFNFxE.zp9aG
 LO2DrXX_oHx3ucPFIpYlSAa2ue6oQEo8SLLDEYfYhTlnpKHDmeR6lvZg66Dq.5qdjsmPVBMvNsxm
 N.XE2pKuQtfQXuss8tPe83QqbyYnxTR6IlMppEHk0qI.JC1YEsYpsSmk0JMsqo8yhHxdvxbFKb_K
 wKWY2DH8XjcMt9F60Fm8GOtWxBlks6RvYiers4e.5S._8jkPO4hnZ17Ft53WX0QDy6ju1IkPHlQl
 tY104a.BxXOTYsDJTGlbpTbMcaY3205XjJ9J.tlfUVyHGgYH4S42BroBWWnc0qOpfC_nAViIpnp1
 QIZXFGeMSCr1JdQKGSm4_u.xV.gn56pFbpQXghwYKYGaTCJ32afienPGTWQkMI2icHZhMiMJSIBI
 JhvGGDEMwDOimP.0HpC9qDWIUoCafo5k30VGJuoyaMstX8e5K81vz10o6_YLOZl12YicO.bI_ASi
 BhNN7J7H9JILAl7BgcTi1VE9X1DVIUFW5sOE8YPrw2TeuPh6Xu9m78Vgv_48X9oQZyuKzxFn14G5
 vKdhDVV2zpfNuudXVp3phg_KZZgKQE3julf4Nzs4sopabbpRZ0rPk_0rbQSRqmf7nzhW7WiSz3.7
 67I85vA3j_vVyZUPxpQB2pBU5TYLsdS9LAks62myIYiXMFUClD5bYcSLKWNTRdcReLJWVG6RZkaJ
 axjxdysPXcFpv4wnFyyHc8w6MQQyIfcSl0vrQDqbH2KMC5KVZI2YL.7K1adcpqcs1bGV_KStnOW3
 GocX5E1A4zHOxmi8FejM22.S.pXCM_DEuQFfKwdiIsiKmiZhpzTTS23u7uVw6JZyWbTYo_vIao0C
 M6YoMXMS12oeAKOX4Ik1eLaHMmRkJbPTxgKWy94ngIokBPIfZaBqiBBuG7wkzeE3ulvARJKCSasY
 PIjJKBTCywevNbpmFrRhf9grO1wE-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 268edc4d-39d3-4099-a321-550e2d494c88
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 21:03:09 +0000
Received: by hermes--production-ir2-7867f454fc-bgghb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8cd4b5b48eaefdf4c621d749d286a70;
          Mon, 15 May 2023 21:03:05 +0000 (UTC)
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
Subject: [PATCH v6 08/10 RESEND] power: supply: rt5033_battery: Adopt status property from charger
Date:   Mon, 15 May 2023 22:57:17 +0200
Message-Id: <a2015d257b145108a3ecdf107a3040362c887fc5.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5033-battery fuelgauge can't get a status by itself. The rt5033-charger
can, let's get this value.

To get the charger as a "supplier" from the devicetree, the "of_node" needs
to be initiated.

Additionally, in the probe function replace dev_err() with dev_err_probe(),
this will avoid printing an error for -EPROBE_DEFER when the battery driver
probes before the charger driver.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/rt5033_battery.c | 29 +++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 91e1efd81f69..94d2dea7ef5e 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -19,6 +19,21 @@ struct rt5033_battery {
 	struct power_supply	*psy;
 };
 
+static int rt5033_battery_get_status(struct i2c_client *client)
+{
+	struct rt5033_battery *battery = i2c_get_clientdata(client);
+	union power_supply_propval val;
+	int ret;
+
+	ret = power_supply_get_property_from_supplier(battery->psy,
+						POWER_SUPPLY_PROP_STATUS,
+						&val);
+	if (ret)
+		val.intval = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	return val.intval;
+}
+
 static int rt5033_battery_get_capacity(struct i2c_client *client)
 {
 	struct rt5033_battery *battery = i2c_get_clientdata(client);
@@ -91,6 +106,9 @@ static int rt5033_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY:
 		val->intval = rt5033_battery_get_capacity(battery->client);
 		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = rt5033_battery_get_status(battery->client);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -103,6 +121,7 @@ static enum power_supply_property rt5033_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static const struct regmap_config rt5033_battery_regmap_config = {
@@ -124,7 +143,6 @@ static int rt5033_battery_probe(struct i2c_client *client)
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct rt5033_battery *battery;
-	u32 ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -142,15 +160,14 @@ static int rt5033_battery_probe(struct i2c_client *client)
 	}
 
 	i2c_set_clientdata(client, battery);
+	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = battery;
 
 	battery->psy = power_supply_register(&client->dev,
 					     &rt5033_battery_desc, &psy_cfg);
-	if (IS_ERR(battery->psy)) {
-		dev_err(&client->dev, "Failed to register power supply\n");
-		ret = PTR_ERR(battery->psy);
-		return ret;
-	}
+	if (IS_ERR(battery->psy))
+		return dev_err_probe(&client->dev, PTR_ERR(battery->psy),
+				     "Failed to register power supply\n");
 
 	return 0;
 }
-- 
2.39.2

