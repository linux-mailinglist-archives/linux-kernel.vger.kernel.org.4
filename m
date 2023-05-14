Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE3701D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjENMhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjENMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:37:29 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D726BB
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067845; bh=iR6f3XRVOHcEpdjcnFCif4nNa1shR7J/nAlLWRT5R4w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aNDwZkDhIJzo4X4lCijZaF803UlbasjNKxdPtFrPJjSswTHmICKbz4nGPtmZeMGWBDQfbp+luEfFb6rjlqb59sKKJsLfhCrm4GFuF4shK6rNeIBY751vV5L27gukt7acQyNjIfE7ThqHjH9zs56cE3zw2LHv4zjpox+M5eIPbBTJ0baEFLQA1n/Qd+ITibYbDZ8FJyIKGGxK3oaTds9jXKvRKu7LZoHufuXwhitmHZmAkCIj5lDXiMO9uTGIyneRPKd4jma+H15ZGzUazW8fuHHamtlKD4uhd+SohMW33rI7fbUPqgm05OqXkkx7cx35zfkp9eujLKricCVpHhWYTA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067845; bh=RjpbhSDHhQw1UtHbfXMZI6CGElLiocD+Lb9tXb5dZ0m=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FCvemGMKBWTvJyxVJTyJ3zgb9IT7hTBRsbA+jhZlGN9B4/pTtPGjRjuDHqEoZSK84DKnCUcyNDSpzZiQYjM+/h/7N+FAsdubR/ToMwxn86WCZNWvOp4Zzr9wWGRpfuBXxQ52O2mUUGQ5HlaTNFQ+3xrmhsM4/tUHvn+kidv0XvTQ5EHUL4SChttBU0cFK5RhMFfNo7Do8l+jk3mo9x4XDA7biSWPhNMCd0oyzVdsoZRaXBwteBB7XrwIlwb6Gy8+yoaeJT9aCquw3fYNLeTj+TiHtQE13AsxtDlV3gKo5mxqjRs0uDDQjAIco4sKQWVO8VBtB4pIOGN10faC7RMiyA==
X-YMail-OSG: mWsgP6UVM1lqWsEsYFxpseFHRosMBuMe61n_Ji4lNO7ELZZRKOqBAc7GPpU2lDU
 JYVFs1WYQ7FmkCnhPHeOEBtAn5KAcE9crF_o3mu5rFfTnDxwyzw1_cd1PXnqZ3mC_hLwGpg4Xv8t
 nYfrqJsLosp.jmrunOoPwY0QbS0Nr4xlIxx1N2.MF5LLWPuMvy_FUKDAI_8qqQr18814tt5Jy4n5
 EjJkfmEXqv0hYg.PlTmaTrR9aQgjwaj5L9u.2xjxMXyu61zxUztX_2TtR.HHLxASFkxc1Fwe2rLx
 gHtiBmK2Uf0Q3tcqK4k.KLc4PVwz7PhtwephA2C95tdUgbK0j6qYZcL1jazMaCCqfIrTZtS1gsRM
 70uM0NHqwIspYtRHcQg3no0TbOHACgS4zD9Xt57_j9V9fCxdfxC.NV30gOnU9X4ZOIZ1XSq40Ibq
 .ASVKSM_4DfgpPsTd38jUg2IEOXm5SEkhEITqAPgsHhQ_PTTZKRUmn4Zf1LtSHFKgIOtz0K_F8UX
 8YwdFJUiuiKSqooUdP47XVLaAfirUJWo4sY1CbGfSGjz0Khh7XA_ExZ6HIT3s3JJrj_P5gWp.Flb
 Arf9IugQYFKYVxIop00iqnJL7fA6KZlUPgEKkgUESn0Be914UGOWvTFM3ZuONoV7umaOIsqasGsP
 lPGPbBU63c8EZ9qvkaH8VG3CZsSy1Jn9hhD8.6drAHeoInG0Wjz99RmfXcnHne3JeFiKos6lwN2D
 pVwG6RyDOzgSeBTc7vZh6i0VjhH1rlYclzmziODbb3oTxv.CndMTYUpOt3l18raL7PLmni.KexlB
 wDYjvxIqBniCPuL9pB6SpUsREvT2jMsKv6L7y3xOBFhQjkCxgfKHkXWTa6r6.jGYgXLu9L_8yLmC
 Bju9YET8reLcZaif1mwFBIbdh6oSeb7WwMdOuh3vPtDFNpcV7d9nn46vzBzel1D9EHaATBCk25CK
 0Mp__AJ39RGyiJpGVb0i124KTaltKoXYtsFkP.8h93RRT3t2lmd0n0OfcZ5kAdqeFUYVzCkWUfWF
 qSqwX5wlGOC0K.bvhbcTHYMUTjF0KPr._Nppae4UINc2lvyH.RhwsRzaHKnPXerPc3GwQi4eYyfK
 93rjkZW6OunMb4Mr3OOJ6OtQ6kniGKIiuFNIVmjHsBxyH4As0BHvSYus8uP1RvwgfI7a2Mhp8zs3
 9P24YJaqNDGpl1jvdX.k7.FoHQJOqVDCd14t2iftdcib.csmFfjssxID.7Dg9.J4UuYUTNOsV9AA
 OXochnfS1BxIPD3YRy9XlxuFKY1C.nqSUaWTI7sMlYzrgQ.Ki2WD3XkVkuqiVleCHwEHBLOUGy37
 cqFGIxtEVdJQtcjXMLJIcqVBByjtFNxfqgbxU0RrMY4d2SMGosm6v2NBs9HYfxZcmTz5_PFlF1k2
 DAvv1rL3vwUwtERExIbqRflvHgcsfimGEsHRXTJTM00CxQF3I7nCWjWoD21oEigk9vJVPDJ6Z4Q9
 cNofbo8wSPqYWxuP3gJqDBIAukcDihl9fsSzBN5EZPL1dwTeKZnOayT4O.q2AtmX4fKJdTClHi.K
 .81.aHPLJ7twgIPn6d..4XR5nzpzW.A6J3YH966piemWF7RZnqlUGB45a3XyFP6OBHau41kQ2Wz6
 jkSqLJvgchRpj9EO3DWBiacNaTLoRuZtmLYxro8kcIE5uYuVUX5luHV0mHD6T3ZyCo3jOziCyvsA
 WvPb1McXLgUr.0heWZ6f.pIMrFHUiepyaHVMFxu0YSEhUj3LLRyRapbzv1yL0zSF03b62VC48oQ8
 PIzQup1w9DOWDIaEjyPR0jeFZvA8AufZKyB4vvIz1srSkv0kvqhpZozqmlD4hu.jpXuzZOcEWojm
 k.pI10d0VT7lNXtzG_xCSkuAV34QBKdZ3SQNL64D_CxOakue3ZtuVHHFkTE2vZZQmnilr8qn.ljV
 dDu1JXdXWjJcPCDXN5xIuxg1qgzCtlTlrBxfR7t6auJJGk0lt.DyHjhl3e7cKItg9UwXdhq8l6Mw
 _DfwK_gTXqH.UOom6ruRjHYcQxQXKFCh0yfad.0Ut6qzgNzK0ve1LDMzgvHJWX7e6gaKeyNTS6m8
 5dadqfo2jlQhuMe9_Q5sB5_FrtVMiLauXCT46kDyintoH_.b4047XYAgPfKj697O8cVHKam0CBRP
 7zWVeTUKXIm1FKg2XjXdHRziInEnytwPYUFnwcWQfgnRwidhmqeMju3pYMB1Rin6ALl3jMn8004p
 KcV_EFqxSYwTxa7di1P6wehSrapEXM2r17Rz8Z5iuZKjOSFKl_ie41GZuqBwGFGkotQMGMoKvZeB
 CXls_ki6QIi98d3w27Ns9tXyVu.ih5w--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 877ba4c0-0451-46bb-a1c2-970c7ffcb540
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:37:25 +0000
Received: by hermes--production-ir2-7867f454fc-tvsct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec262f708c8ca7d1990bed607fb68ca2;
          Sun, 14 May 2023 12:37:22 +0000 (UTC)
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
Subject: [PATCH v5 08/10] power: supply: rt5033_battery: Adopt status property from charger
Date:   Sun, 14 May 2023 14:31:28 +0200
Message-Id: <20230514123130.41172-9-jahau@rocketmail.com>
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

The rt5033-battery fuelgauge can't get a status by itself. The rt5033-charger
can, let's get this value.

To get the charger as a "supplier" from the devicetree, the "of_node" needs
to be initiated.

Additionally, in the probe function replace dev_err() with dev_err_probe(),
this will avoid printing an error for -EPROBE_DEFER when the battery driver
probes before the charger driver.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
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

