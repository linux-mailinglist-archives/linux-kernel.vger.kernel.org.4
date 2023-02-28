Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733636A6299
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjB1WjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjB1WjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:39:00 -0500
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7321954
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623932; bh=s32HUPwCKOshIyB3RzDVkjP0uF49xcWO2+tOArORygE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VigrbbD8aKFhzR97hZhIck1i/JZoKmjNuqqlIYkdawxgM2bALYrg5XHv3kzjLy+MFdth/ams8RdUG62fNEZbh3VND51wJMYty5O9oN2eD1xr40d5cIJ0qbZXFHKxDnNBi4tC3UfvCahYeR84sWbkTyJKzgHQgB0TqF/1ejM1LTqcBD0pHwlhaP4XjG9ENjDAtGSwyD2+llN5RrdJI/Zhcs5usM09h7036wpRrCJ9F1GdxjZJbfJVeJJDchySTTs2fmvqmooncMtH8WTTg51zts2RA0d/t95BTNA1MsX/tPcHVKM5Ig1gBco8u/Mj40BBVBlWc8zJDqut68XCMMQMVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623932; bh=DazgWJ/4JyL16bAVXpPyn+BI5M9Si0HC/6Rq5ZQ296C=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hTdT9sM6BDIYDYRfEijeoUxODPej0NVXea9647wzjH+E4NK7qR50bjcS5F2Zrg4QqiGs0ExNccc0Rx5d8aLVG+Hodd/OeEg1DJHIpzas659GHI7I4S+vl7YjnhUff6lvSVzFeK0Ef/ErflRzkiijRLKl0IFCLWpl1brfuu1du8wEOSB3BOyppMc76FkO3c3lKiGsH5F7ZlqlpcjeRWzqLd7ru8LSF/Q52pwqmmsfLLII8VOse+D9UtsEdB9ygeN76ShK2Vf4b8x7ZfrIpd3XSVObJceR27FMCbtNmdnXjjcP8+7zWxSczd7IzT/Dl1BnxpvMn3FYWUqhCjMnopRrYg==
X-YMail-OSG: wICbhc0VM1kdw4_duWXEt.87sSWmKgwAI8ZrMPcIumfg88JbB06OJTaSCgLk8Yd
 Jl9su5MeOZ_2jIkT6rTpvdsdLyHjVDIqRJzHUZ4ghIHJKtXCbyJ_ayZ3p8QeX6WuNJAgeO1a1S4g
 cz0NuhwUIW0uftUuV5_UABjWEjmBaTlkTytX6iNmYIFqs4RmjQFN770klq2DAspORAhlWM.lfPBf
 nn7EJWFr5rRwZAAAn3Z1cDFJ92PkHibAkNojbm.szu60af8USbF65vUCq3y9vmx8rkWoTj2sxOaZ
 S16sZm1Jd7Jry2zs3owFGT3_lG7kCDGIezf7rmM2fKWk6DoFm8LWN2Ke81UWw3Ie792226xfkS8c
 Tn9HxZPJY4OR0ASDK_4KNUAQ.GLmJXpQIjpNyCSnp6nJomMHhiRH0HE497b3LLG3cjdJPMgzVtf3
 6YFGLUvM5z9MkFoTPi8OxHaNTro2go2xzARGYS.R67a0bA5oynjCJV.5HKUSAMIV81X44fstTlFT
 a8TJMe223wY7FxRPcY6QWnt6B8b9k6S4EQqrCmKUmYZTDliLUB.05OOhXS9NfbrX7Wv3dBdzQ6vh
 k11ZWypjD4HK17dWYOfSVUU59Ff3eSWVDqc3gibTYBNVvnBYYWi_osqNHG2gy9WTbbiBnHXQGK2t
 NPbqfb77RdnSb9HoCg34Pea6qbHc_Exh_6OxKx4hT0ud68F1bSibqpsk0fHyG1tHIIcWvWBs6tH.
 oat3_FDGB_41HYFnU2t51aqFavp56biEMQaAwy_gqjJZ8WR4GE3bH4AUS.uhjNuBfBxbal3YVJ1P
 mXbwhF5YvYAjw8L16wonkggB_WyjE5aufSKreDyhraVvuRyTf1HmyBW8zl48aC6ibDkcGXitTjtq
 Pu0cYgFPzFVJUiXeMmlS0y6Rbabv4ujMReTMdUFm.VlSDlsonc8gjuMvB6cYDaofvAnkUq9FPfKY
 HDlDkxcITgJyVb0JWp3ipFjrAMhWXh7aLR_cZU4AcyZkHpnHxmqM4Q8ShypbWyPC83jm7GQe3AUL
 yTLLScncVcYTe3rvE2icXOmOmZP0bvACA55v6BZFgqos3zvg0luTW4YR64AxSE76ZUJfxtRI1RbM
 G9oxfJVN9_TP26Y0tw0SdUUCsxwjqQ55gJzXqm2zPV7XXdeNTfaJPsXEwVPIQJKDaXUCYqTwTOWx
 B4cWE2651A8_PmpdMOIjmpoByJWJz2DCMlMNPme86ntKR0FX7cTnTooM44FSgPj8UnHtZNZ.cMt5
 FMjXscrhzo4caqjqS.jHhGlFlojcFy4gFflAbud956CzWhAmsfKM3iK90xFWl7ryvSdMdexswGYo
 hkrh5OKRE_cFnPVdOfl1QBhw9rTiWmrJYd_1Dg6oN7TDHJz8MwyWql.8yoqzX7l9Uf9rp8dB437Z
 d1cHQwa7L5kQMQFnqHtOnEPn2ThJqyQX70pnS2k5D6tyw41LcMfFWjnz2_DyHvq_hxM7r9R1rs1o
 I_N.8SOFbyBB4llT41oEQ7VzXHVxbo3ad9pzPJ1f88mF5WtDgQsnrCFzrOVx.seMPoEvNhlGlFON
 aTeshFn7V0qdoMpvi7zl_4NcK5SZOowZqzj1RBqg1.eipsI9c6dqqIjzqoUOkFEeAc6hp56fq7We
 oX3fvVd1a8UWtikLIKyKoLZNFzhWLskpwHqr92az0bqcJ.TPcZ53udvq2LK8WtqzQkssUerkkLFP
 DS7vLmc3YPIH28xcWDLFzoSXs61P7aPa61UocBGLmvfePMM27THFHeiT1FlmbaWZ.ToJ1SSqCJid
 _X19uXAA3k86dFpglIyq6VEmDEQ0wdOOx3CcjC38SiNR3k7i.ReRQS5LlbOShmJWUZRBBVb6u5T_
 c0.Dt9AGhLgOqHlgStN8y9tS8u.A4bMnMuXrdMCjOMFV527a9pkoTjhTIC2Xn9.XaVCTJ8iw4LzF
 n3Jb1MYBHf_F7qyzqDETlTPTlUJ6KfCy.Vjl9xc8Xw9jYgfh80w9gjbSwJKI7gF.2BSWrT7Z4y0a
 ZrzdN2PR94kHl4xh57K.iUjvFwISpPYQGgWF07iNF3SecIqx3wsSkM87Fx9AAaEph44uVMCWZa8g
 SwWlY3Eq3ADySg3Ctc48RTDoNFrJsHkS1iWvipBnUyi43Eli6eDNGdAewM4ytQ8A8q1jDj3EZUuu
 17Ix4KHfPohq_PsdZIVfcOPqrIWJFyYKWCxHlkTA7n08cuwq4xGU2UiR6vwNJaNTE_Iv4H29x7Xz
 3brrE4wy0mZCnZ_SnDZdk2grj6NxkUla0oAHGvhsT8.K7h1kletjiinZnzDT5PxNRllXIjeo2Dtt
 pfE2d6CMD.4vswlI4CDvjA.kQxKC3186sgWnCWM0qT1NLjBVvow--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:38:52 +0000
Received: by hermes--production-ir2-65c64dfd66-svnc4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1052c26ec2388683ab738a7f87fce466;
          Tue, 28 Feb 2023 22:38:50 +0000 (UTC)
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
Subject: [PATCH 09/10] power: supply: rt5033_battery: Adopt status property from charger
Date:   Tue, 28 Feb 2023 23:32:26 +0100
Message-Id: <768faa5609bcf52a97f1f1f71dea6518237b04a0.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.39.1

