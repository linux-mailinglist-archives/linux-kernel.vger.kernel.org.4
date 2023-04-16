Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10D6E386A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDPMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDPMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:50:41 -0400
Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA053580
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649436; bh=t2fvyYZS7Chh40ho3TEbOh4/xUHgvfaETlyY4tmywTw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OOQ1PErd5vd8UQBpNxVM/+o1su7VLFHpeVTHjoFaEI/k6269DK9UvDTPxwQ4+zAvhbb+vNihoXqLpfsEpi68JifWkP1Y86UsXGFZLCfwHsLeWLNVHMJFwOTX5d0/qu/xsN7vN2+QDTOG1kQkLX7uO16k22jvKd6FKxIyC6az485KViJQKH4+1bjgRgmEE7ko77Y3DKiknLD0gX9PVA6olpqmBRmK8hGIhWh8iEMc0xnhOqbHACLuR0MCnnsrwhsWDqQX/3I8hE5DchN8JZtRAsTHNTJZ5M/n9QyBSDbPVtiUwjej7729BsQ0NfmtNp3QF5IIXWV8B0uUP+M950D+7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649436; bh=6pZIRE45gcFJ00KwaPV3W2dWc2VJdFKuQHIvliouYvS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MCljO7+jXWpB6VL4OH5CUK8VUdP8gOhTo+FTOeC3Tdm3cnWvcG8LXIuWpLY0YuumoO2IzuDGFUqUuMSVL2uzhfwUmbq70aQ7ijrXf9yKe0ZLjp43J7+8lCezeUEONnX3wfJEA/UIEzpgoDqxzbGsnfNsY8tKFwnB2T2CPMH2j0hpsyAOCdW88rAnoauBKBxr8dhOCVMx7Paqe8mK059QRs+Zn10JiB4bg1JZX/yfU6reZ7g0Yl6bYiFfqMQS8PoU4+T27499HlirtLO870gqnrehqQ7NSy3ixkbnEp7U/GDfj6fN3uyZhKFKo3b5a/H1Nqx1hzigjED0zcCFzrbnFA==
X-YMail-OSG: Ajq8mNAVM1kRvYlg3OlYxJ6lg9CuVDdY42aRTCQRT4AvNkBUUfi9RrbqaiEOxPs
 dKYgHSxl2cgU9VvW.D8d2v1DRK3fUOFdjM_ABKn_POn4tTGgjlDcU4cRjq2U2SEkv6I.hMznlzGm
 S.Wu3X.UO9dNJxyk14jRaMd0NtnVzKk63ruTIFgB.oZkAGboQhppZOL9X0nOl2G2cp4rKkLPh81b
 HRWi9hlzsaq1kyHmF0xHC92JFJgDbaQLkJ.Z_ZugXSYo36EKVLoQb6Z5XvICBVcg13g9l3_Q32tx
 asBGoY9lwl3FQP4WgjonjAUGN1G2lx19R6kfhpkZetoR45hxUsl3W82Z7mcTFISUc4jXqeI2DS1a
 3crPA2EvJh1_q2Ax4dY1FisNcyMIdi1uiyUC6qIjVIua1e1SdG0AfbPmgNYF_0M22ky60ya7JM25
 jIkS3Yl2FW9YSePTQ9sD3RQotPt7NW6Uo6WeH5aDETsyKbKUZpavAkEPjCY65lc7X77EZ_MfoWJu
 vNhgGdNpkoXS.y2GPM2pTZ23iJPjLdEhwYeqVZMWvZ6eyyhmVJoGHBPGgLlgdKbXLSAWoypy4r9i
 a7ZVtvLXd7ajsOLkoo9bqkBjsiqWDe4Gr6fQ8KwBVPTc_YNqfqtlj35JFBVGbnmvKt8Qa0g17sSa
 EQ1SGhmrf8c6RUHmDupUNz1Wr0gIKFTAz_gYo5rJ_NlV3FJa5usPXKrJ52jg1.Su7DgMueqn_Ir8
 vBj5ZmAP6ILBMeuuEo5T6jQQaCSnXkF_XVtWchijKcQRjNRTOOPePIngilFu1aUbQW8FJcprPJJ3
 LJsYC2Nilg3xQ64Z_bKB_nClWQNSjNY98ECylr21SEgEpfTMB_OpDLmxL6lue4fm94xtPQHQzfTc
 7ed2nJpXa0RyVnelSnV3U.u08RVk3ZTUti7JgB0Jt3HSXz51WWLcWtxOaxG9bXlFWepNwtvbWrmG
 Rd_Z9L3FzAks9SSVC8Lol.skh3apXYMe1WdXbQV6nzV8xshIluz8xfkU6_6DvKDVmc433PXwV9Ca
 Ax8Ld5Wbh5OfLesKk88HRinexHnkBCwHvB9UdFx8HHEv0A7O7eKaROTEbJRU2sAgDAywxhdQ_1SD
 1n7YWsLCm2TzW03_adCn12_w.pcc2jLn6KkH5QpZDU_YI2JzXzHNrOzBzlbLWStbb5qiOLnxTtE_
 6B5EecZGJegW_h7Udap2ngGLezm9jRirXxOOrLB2wb49oaxF_T2imjFjZA6djPcQ_rrNAlS6zcVA
 y07K6sgmQOjCYBrPw7WnwAqr8XjTnMk2dnU7c490yYpk5HZdyd0Vb7kN7F.QqSoSA6SHrVjCzPzH
 mpRDGVSHlyX6UXCWrdrSyWfYGXYzPtc0fyVtQBLyevK6to6JEEtXEckoGEXWOhzUpVOVTRR_6Xfc
 dey9MOJmbYad.PL7tK5n3H6OFQcZYjq2.aPvdtLCTGdVtk9pTcG9jZdpLy_MYoIITdl99sGkOnK2
 GRHl4EInnPsQ4WKFSlpGHOGlUkmBWMAp1qTYF0xtT2mjqg8dUz09gjXvWtYOjQ1QnpT6X6jo31gc
 Aa7H0ir2L_8VjhlBbGJLIs5Os0e_Q2mXw.867RSUF2LopS7cS7cFjUNL_HVrBwobF_EyCrTomH9C
 JUMH6oSx2csgmSJXDHx8UiKlsdd0IZMumbQ1vS0oa5RY9JPdyFaTreMCb9i1BU3NjxSfNLMpWcWP
 pjQYHWHTgNAmK5BbKzY.i5tnj4aLBPLBNEqCv9DwgyJWmNjfcJM_IFNQaEVYujmV8ONxQkhg6ypB
 .pQ7zfXLyS2VmFxgDRyUW1PYH.ZTGj5cH35xzoLvSSV_YldkMi6LdtilEMEVHFl_aV7ihtAGqkue
 LQtMbMXggSqoFdfOZZgpswwgqxbnkJ5pibvgO.UBUhjK3iCQyAPW1clHZhD1RkJwvLEKZzFOoCXY
 ELxSViGxreHLTj.d_mXhQZEIUI3vB8GfOx5uurdySxcmUTeDxYSPZmpD5aPOXnT7dLFKrWQcmt_l
 FeVGShetNNRo2q5ZgMyA2jSq9HonuUcbEGnr4jwbttbcMY0UoGvr_j4rxkb6vEHhZGPKbvP_GsB7
 bcUMxrDPcDeBeEU92ZmZKC67884F0c3JyUYK9xpPIq59wFts4RHjqXO4_Y_anyAcjvwPNCljvJdS
 _klnB8Y6l2F3Jh0mJ1SN63_OeI9vPnNN.6KeP9.VElIFb4XFYQwlnZQ47n6gaha45Fz5tirNFN_o
 6ibVKE2uVv2iOzbxvcXFvbGRrHcccHO9AWbRXW73.zre_YzufJg9.ELSihlXpVdVxu_jTQmGWCIR
 KUIYGBsZrN9tzKp4vqPy8TXGdCn7.oyDAfodXPCNkGjraeOVNFdkc3g--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 37b66e74-6baf-4456-be0a-5c9429113131
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:50:36 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1e6b4a18b1a30b9efb33afa6a04eb6c;
          Sun, 16 Apr 2023 12:50:33 +0000 (UTC)
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
Subject: [PATCH v2 8/9] power: supply: rt5033_battery: Adopt status property from charger
Date:   Sun, 16 Apr 2023 14:44:35 +0200
Message-Id: <23260904aab2566faf86d2ac01a31e7f1e024e66.1681646904.git.jahau@rocketmail.com>
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

The rt5033-battery fuelgauge can't get a status by itself. The rt5033-charger
can, let's get this value.

Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_battery.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 5c04cf305219..48d4cccce4f6 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -12,6 +12,26 @@
 #include <linux/mfd/rt5033-private.h>
 #include <linux/mfd/rt5033.h>
 
+static int rt5033_battery_get_status(struct i2c_client *client)
+{
+	struct power_supply *charger;
+	union power_supply_propval val;
+	int ret;
+
+	charger = power_supply_get_by_name("rt5033-charger");
+	if (!charger)
+		return -ENODEV;
+
+	ret = power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS, &val);
+	if (ret) {
+		power_supply_put(charger);
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	power_supply_put(charger);
+	return val.intval;
+}
+
 static int rt5033_battery_get_capacity(struct i2c_client *client)
 {
 	struct rt5033_battery *battery = i2c_get_clientdata(client);
@@ -84,6 +104,9 @@ static int rt5033_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY:
 		val->intval = rt5033_battery_get_capacity(battery->client);
 		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = rt5033_battery_get_status(battery->client);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -96,6 +119,7 @@ static enum power_supply_property rt5033_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static const struct regmap_config rt5033_battery_regmap_config = {
-- 
2.39.2

