Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3D701D69
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjENMha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjENMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:37:28 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFB319A1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067845; bh=VqIx9LSfStGIwADHV2nx489yoOzekt9YBpjG8dE8w6w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qvDNkQPO9K0t6noCETiE2k3jPvB2018MeCDFv5vhHr1B/30OMrcsZHHgzi26lkjifU55eitVjXhZfl0vSwjwytq7+15IZFB7UrzterCBNpmTmihAqil2bO2EnwgB28aml9tVDu5wBfdGYeWURqBR0RzYZHPXuibwqt20QcSYvjT0FEr3l3s/qSTmnnwYdPj/in/DodkLGzl7b6ATuAUR81VCmwKkyl7Kacb1QKe6R/0CthUC4a+uQPkEVTqt9UZ7z34SPreexH7zjJkYY6Ia+1iZn55jOxCegrqknhfav6AWilYgTwk8qqTcG3fQLJHJOjQr0iJm8r/0rZdhqdB/Qw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067845; bh=Awwi1q9aHXuKCeEYu1dy1W4ZCJJwkzQEbd2LjgXvC8r=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Q7WjNySFufjsKv9sB0B+4rA5l+BWUL5ebe7IUDU+YF1RxqBswIjeKGs4/P3KVtmV28zYP91fxVEq8cMJg4O1I8fgkIQAIq9XKgvD2kh1oOyEN7ZhhGS76W8tSpXvOyRaS7KWbhciwhv6ccIyAoDRR0YmRMfhQRrBNsKWCjQAY9RVZtg8xMSreya0oiI6pmHYq3KJ5BeOgkL12dEH2JeOUpShvaVAZRPzInYW+XGmiKd/vPxuEvL87++GYiiSaqKnzYkB+YELOZ0q8kZfPI6E9TPT++9PfUi3z5r0aL9HKy/XmZwGN43rYvCSLGvShOsb5AHGv4zMCap9JybsUpcD4w==
X-YMail-OSG: cuHQmTwVM1k4SQHQNYFgZMrSScidaSR_5IEb2Eow3z_uX3iC2o31iS_fLM3feES
 43vClyWqqziJCkL6rSGX1T0_LjMqaZKQ2GICmjSfijvB2.kyF.F3Iv8C9c5iwET_swr5dwvho94.
 pVc.N3xNdq_6zLllgVDsqtj8.7kJJBrsKrGRfMC_OoN1y.J2xdDTJkvkCjgT09bo_zD0a2_egiS.
 FIc.q6TvvgDDC7T9e1koLbKdJt54ANGSUncbw8_a6JDjoCAKQfM.Efge_CeTLDLQzvfPnYSnaIIW
 xHTx1fClbgCaJqWfwl6UmKCeJEV1I4hwau7yw7Wwbk.RoZg4bosG0fTPDpOzSr67pvFYmi7A0_xI
 wy0yvEd9ZBFsmQ.KBh0.Qdt1QOgy6hzLc1UlLHYLH4RxBYM62qXnTsimaCP4ObjWbTJyrHGeKxzl
 U_lxBdpjsUspmo5o.nqWegpfAnaL3j_X0rWPAtLz0Ig1OpRQmgVdhK_n3kfqDtr6V7J1C75vstMO
 wM4HwoDBTqfMVu60EHjqGW.bMQ5heWj6kZ.DvPWtas4vgT2yg9Ey8lgOm5fXkx4NjEn5GSfqz4EN
 V34FXCaCF.NsDGfNdF1gzJ0GkdO955bZGepnGT5tY7kStKVnbzUOfwgM_fPwRtljW5gZueugi84L
 oeCbjfPxIAF.MwLOSlMoBFesOGG0n0nUJlJt3UWIxLREOsGhfM.BaUP8pT7cI6EggTFV84VXzL41
 aPm4ICVbkErKz7HGLO.v4.WtESgxGQmGyaX1JxKoT5O8go2LJoOF6q.j7eQEgX4XuTklQQUjudG.
 V1y5slezl4Nd4DuNFfKU81SRvejJ1mU080bUjyrKEVsNUBj.t9NC9EUmBUWKuyayIhzO4bHQQ2hk
 n4kgArukKExB7zE9Aj4QRmN_EAhcnqXoDZTwTam8FHcUUQ93vzDYVg.swGwQ7mDP54WbJT94ofPl
 xUMiH6otj.hEfSuMjW.c3eEdizp1rKeJwWo6VYhcE.OgtKuVKD2GqluxhKRgSl9dUZOAv.TNY18S
 oaa8b4_1aWWkoYpIrd_F_n2CVllMpO5vTY_2IsYHPNZ4KhFwGIFH0yHDQEJsO_DSAtqW6LafvD.H
 Hy1HbWcAmnLCCUR224pZPgWv4vkQ45R9HrXVbWnVM6Wj44VeLYtKECBMAk4BMrp2dbRoDMSBs09_
 SsQwJ9p84VgmTYUv.Z_EatV2vR0WnHiw3u3BUSjjg.UYAu1IMMj6Z4O5LoZLucXzQ4Ad51P6cKlc
 aXlFmhAHa65AK1k0rbP.H2tFFrcAfemVn7R7ciuETLGjHBmIh_yO3XAQMvvqU6Vk35ib7DAutzJJ
 W9BFeuYP8.68mL_.ykJbA9kY6lhkPX3YFyuQlWA1MH_49VUyy9kfvZeMYWpPPLL2GpxQv6ebov.W
 pnCcA6LJMJVhfymWWXyP0a_QE0YhKB_YMEk4GH7zRRg1gFSpJacUwOHt4TG2NuqV2VUpfvfRWvtE
 U2a7k92vEQdFScySYEtBw2TztZslUKFBA9zop0pBsn8XCrwxmMjp0IvBfrmvRhAIBgtp9vYU4QBX
 s3ZA7qDqb9LhiUDbhOY6YaSbPlfHvEKjpHhZEZDApSusY4g_vnVcxAl5LJV0trkLuihqD3wZhLDl
 D0TcipUYvoqSBogBDYXPhMaZ8SZx7qMOIrkCR8PRGOLBkhldSi5H3NBL.aKbZMa8gi0UU7xlYUX9
 xkoLADQY75aHdWFYzzwGyisWp4BJER_YJY9LguNSgiMU79MHioyHpzc8oR7jl1bcB9zYuh3jLjqd
 OFFQIgjPjqDD_A8vseq5ixqCRIqh8.wBzrzGMbpuKF5iw3u5ZOJnnYnQ1UGdgnVpdg77tFUAKC52
 .7E0Z1jZXWWIcj2AGJOsHsR47khFsHJATD26749hgiIFb3Ys08NzwjOtaZx_fY7RDqOPvC5ZUFxS
 DVRQc.VurLQjzRT.mWyzZReZv3sG9NYsqzsBJk2McQFHvYEaDPdYKN8qPqnZD6wlYgH6S393dAl0
 iJObruMFUdtH3J63JVoyPtJvejo6F4dDijWgNWqAESZssabT5AaZdaFd3mKZRPh.jJdNR39DExbn
 faNMFCy_qmCNYGr_Pfkkq4R6hhU5GtGF2waq2qrI_7D8RqLqr6L1.Z4SSpI4AOno0cxk4Mb2Z_Pt
 2800_of4NpIMQ.gufzEPokN2VLBvardPsEteY24xFT1RDGcMi1EikVGUWnRY8piUIK_StMPJcttw
 3LHINN0krFtHDdjYRTMxwO6CWoiKshekO8VQ_Nqz68LAcS9rtqo9WcV8O9g06VoZE.DNHzzujpkj
 hSFjuNmt8_3qWCRzJFbaIzwSEmE17HQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 3aacc60e-eb6d-4247-8021-2b47a8d10bff
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:37:25 +0000
Received: by hermes--production-ir2-7867f454fc-tvsct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec262f708c8ca7d1990bed607fb68ca2;
          Sun, 14 May 2023 12:37:20 +0000 (UTC)
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
Subject: [PATCH v5 07/10] power: supply: rt5033_battery: Move struct rt5033_battery to battery driver
Date:   Sun, 14 May 2023 14:31:27 +0200
Message-Id: <20230514123130.41172-8-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct rt5033_battery from the mfd header into the battery driver because
it's not used by others.

Within struct rt5033_battery, remove the line "struct rt5033_dev *rt5033;"
because it doesn't get used.

In rt5033.h, remove #include <linux/power_supply.h>, it's not necessary
anymore.

In rt5033_battery.c, remove #include <linux/mfd/rt5033.h>, it's not necessary
anymore either. Instead add #include <linux/regmap.h> and

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_battery.c | 9 ++++++++-
 include/linux/mfd/rt5033.h            | 8 --------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 5c04cf305219..91e1efd81f69 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -6,11 +6,18 @@
  * Author: Beomho Seo <beomho.seo@samsung.com>
  */
 
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/regmap.h>
 #include <linux/mfd/rt5033-private.h>
-#include <linux/mfd/rt5033.h>
+
+struct rt5033_battery {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct power_supply	*psy;
+};
 
 static int rt5033_battery_get_capacity(struct i2c_client *client)
 {
diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
index 3992fb2ef0a8..bb3d18945d21 100644
--- a/include/linux/mfd/rt5033.h
+++ b/include/linux/mfd/rt5033.h
@@ -12,7 +12,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
-#include <linux/power_supply.h>
 
 /* RT5033 regulator IDs */
 enum rt5033_regulators {
@@ -32,11 +31,4 @@ struct rt5033_dev {
 	bool wakeup;
 };
 
-struct rt5033_battery {
-	struct i2c_client	*client;
-	struct rt5033_dev	*rt5033;
-	struct regmap		*regmap;
-	struct power_supply	*psy;
-};
-
 #endif /* __RT5033_H__ */
-- 
2.39.2

