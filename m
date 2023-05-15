Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D21703E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbjEOUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245322AbjEOUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:18:36 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6512120BC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181871; bh=Orv9xlXl2ys7vR4uDv3BL0KEya+/X55FDQeChcF+Wx8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QC82tEqVnOdPOLck4AWPS1Oxbuo6+6vUzcLTxSi7UvC74CACKWah3ColkFxUKy/4bLiPzco+s7z3tuwno9GZ5F3av6qnDDLmzqR2cftkWoa4Yl19Pb4GnVuNvRQLEgWR+TH9IDS8OS9ZzZG7FNjiYNXu453NB1RmMYpO5+5rdmeud2CK4xidw2Mtsc2vd+eUEwwTzDLKD9IV2na6TSBayQtQXcTpv9SC8HaX3sF1oW+ufROjMAaKztHamjLILhKIDlvPXLtNhK2hMejkkeOU/gB39xehnz0V3oSDoNrrQKqUd1NfRNRY6KCS3KI0laJIWhJRsn86HQi+cABFMS6zCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181871; bh=K49QPtGjNbriJKMuofqiZphv/NCgNob2jjg+2INQjBi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sE2D6Ksk64u23xb7lw8h8pWrtYHQdFrHC6he/ZoVGG+Mkwi3kzyGOaoJhK0Cl5DdPcdpLuSxrKayCV2dnIB1Fq3PBMaksGdFFmsivafRBM762LIcMzpnDeK6CcXIek6nFqmGTCGI7//OAmhweGKezCDQJxlvnPlgXU011DfrmODjwa5s9ds7MIeef5MPKzDShDeXhm0JsKO+oAl8leQbknSxBv9oeaYQjct0i61obbrPvfONn1Lj6m5flQGBe6hdrzqh+4+M7m+6N5gU36uqdWJoBkvs5YYbzQ27HCoD91e1CHNpMcLNSF92SSSPTWjuApTM/l+giPqFlIw8JzKYvQ==
X-YMail-OSG: IFxmzi4VM1mO3.iur2nQWy7FV2Opphkfxxw.UOkcA43Lrm9uGwvyDtW4A2kwYX5
 OLU8Gv3cMTAUdmhPuRZIwHLUBkuwyBxJmRTbSeAg0.EXJYPWeAM4jqx.YvlUhZTzdh_WKrZM43bq
 x02X.GOOVs.p5_0ggsghOFzidmA3tGJ9RljkXzmA._5LDkbbGEqlcOyX6ZCtV724Yqmew56CFeUk
 r3W0cZ3JsYEQI0l3Ww6evTaf1otFTxwLYb98WdSxVxm_kzmsL.VgzukObkBV60AmLXZ2qV7J45Lb
 dopE05_FNF89BNHLMv4TfRcCMOVvdK4u.fXMWhllSw9fv3zWJJbPccUrB7UD6USMwQ8e2BD_F4jk
 mLYql7ZRTWyb1VTMWaxTD.0ZTnFOvZD42bl9hdC8vFLFffbJ0qzkyZQmGmru2lr..gZdyhepu766
 HPhT_ola_CC2tNB1oK5BK7EtPDthYrKZPTFheuvWGwBhsCJnOXzrvHug5Bzh_XSsC8EGtsxfw7bB
 7PPE6gdKB3f5sW9WVhkw9DIWnA2KkPflkoO2i2Z6cdCQ_BeKLUL9zRIGO3n_EHCVXqXEosraZxJj
 qfGl4t.7x0TKVzKAO5kN9vj_EW2Qm71R07CjnEFo.onGS9Ow92S37Mas.DZM7yUPCRYYaqhmWAvY
 UvZnul2IdwZwrUTZuqcLFfaPl7SudJTyvunTytrSqu6Ld8_tO.Wsi6RhBRZgQkE_RCvFL71tRr3r
 __kXwfWfOErn0NW4O094cZwVHo.RCBvHxauU3AvF0nmcdlpkg0EfPvIdueM257Ig311.zbNNFPYI
 hYn0xqL86sbfMmBvC66ifBDmiGBXMmf97P54OGOyTbSE1snsTSkIaJvVeD2HOWP3iJOEOahQvKfa
 73EjWCarNM97Ew01jSZ0AGZL4KzXGJDuM3rR1m4mRWm4r6cSISPHdMggOxog1ku06p2SNHD9rhgK
 wc977rhTgpa0Eb2t0T8psfU1OzAl_9W2eVYlE733KjispTRveS0p7WFD0fopPaKMtzUGCX28tpoG
 zzQSuha2CZPRyJepKRZPe3mM3E9BtuitKNJzn_kdHl0dn08oXAsKKVImHErNSAiz6KsxScKnBzzN
 pH1gZ.dAbemuz_.fsCUaS1WDqetIZ4Lh5D9l2fqhLshly0x6qDZnu0QiPi0lylqx.N_EjW5sXijI
 ihmp8lhOBsBlKnl.jQN6jybU4lZMvKB8Uel4Gc__.CNzeBXlCsXc7BZx8jPVTuAEgn3aCja.uRez
 GwcBziX272ZhYA.9RCOKsPxYHBCfEEHiHeVQ2yzhdDtt2_ctVnNssZz9hQtLc2_.bT8_4XpuetzY
 DErzWez6NvYGAXyylY.3LrkqAELOYbMGMP9moHKiqe8nbS.wq8l.93wDt2xpmI.IbASizbL5e8LJ
 QJ2Z5C6pk64lUviUGiatz8PmK7OZUk2ThQbPEwdReasR7XnWXT94ufSmZamhnAtFT.EkTR9uB_sO
 y.tnBLn5Tk3ZwwTn1tAUaDPsXmKDU7fZwr0w1srg14cWRX7fQ8EmCi_2KQFkQ7sqNW4FT40rE9i0
 DVWSouinBDUp1uK34C7rQtiWezdmPk3yvUShTCX.o2t8CM8v0ZYkbbsIhKin_QZQtoaWGEe7eccm
 uHeVrGkVzEK7bIMK5QBBCGs2RvFU7FKEbKC4r5bkIuCOp5B.46kBC6NN_u6c4syiAgsCLYK6x.aT
 yrWs95qUP_NaxDLnFkULKb2TR_DCcrIypFGnKkfN4n5xKUS5zLl0pkt_CRCa.kyiOflypRsAeDai
 .CEFZrdxIuP5Du2OGAH5DEKhCGirEFzCq1GhX3JwWfKYlR9eCLx0QIxqE5cVdjD68ui0UmkDq0FY
 KjGs2NUTqTyqRGfGmZDoIyOlIc4lFVmGeQk8JCg505joMrRaKR_x_7rHauiy10QPNaI_uy9PP4Je
 GH7pi10gGGB.fKhHP9Cz0Y8uGAhptHxSMxweRUc4J6pqsF5LaOlVNBTFi9WFc7vB8X1eH5jXZ78v
 wGSNA_VKbiAkq7Nc.mDW7.o8sJ4KxGqMZuBENF202hO3VIdbjqfuDAhAM1rzihEAHwVlINpL5w78
 qFJUAkBRjR9T5wpPlEfJImw7Sg6.AHGEzuN_ge82ZVU8sZEdO5Sn7d5xI2niaFwBzecsbZwLFtgf
 kwpB_TFcEsdh9E41iQ0XEcs0ImPcI5nmuD7hfqJdD2z86j7l9SNdDGNVxLPylkURD6UTFOHLqQrU
 DPMfzse1Qgk6EHR8wndYlsxKls92hQfWX9VqiDylvw2Cp_jvHTtsovjnFlg.h3NLpyLT.IhHJteq
 yBQDU0EK3OSCANYV2MU6GIhf5AA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 128f9572-9d09-4333-b790-65a0e522659e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:17:51 +0000
Received: by hermes--production-ir2-7867f454fc-8nkq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cb456a1ee9275492b492c35f2e11856e;
          Mon, 15 May 2023 20:17:50 +0000 (UTC)
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
Subject: [PATCH v6 08/10] power: supply: rt5033_battery: Adopt status property from charger
Date:   Mon, 15 May 2023 22:17:10 +0200
Message-Id: <20230515201712.30124-9-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201712.30124-7-jahau@rocketmail.com>
References: <20230515201712.30124-7-jahau@rocketmail.com>
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

