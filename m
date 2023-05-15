Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6396D703E78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbjEOUSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245311AbjEOUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:18:30 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF111B6D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181869; bh=1v+m/grXHAScwxBU4YO/Z+1o7wz/5i8+x8kx+V7NuiM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PFEBsqfYv+pBpmk/Iwe655XLMWfYQt9+y+t17hGDiskMATnr42gR7roIA3SY1Z5cge+G6TeohpOys9ltBbiNE+5ebcaJzt/Y9SA6zrLNBUXGdTGUGlPawc43syhS2IB9tLbCy+XuSK62mMUKWsFu6b5zVZEwmpL5qvExl9g+ksSe2EiuDrqtepE2ScReomJbgcyaw8EAHiNZLQG33AZWZpyec6wgotzjZcoq0oNIfdmjJ1OOh4+yqN5Yw7pAowzl0joKCfydIcTsVFm+w+kt/1jC23aRau0jqJkcZnIttp1KjUgKMh8Vzlybetxltjm5whrtwN1M4f7IBayIVWp7RQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181869; bh=HpTvbph2prhOBcv320IwZCkwngqmL/eykbAmwayqxrz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rW0twGpml3Y/tU2q/A5pHJWem9mTqMbyQpruoSYWai1+dfGbxWdAS1g7J0z4bUy7sgNw+SSBjcoYytPP3UIy0SsBvnCd2efMkekj1y47iIyVp7g66/sb4tmXwBWxwBI9jJYlznxPXB0hsjP5nRYzzeLDb7t9gupu5672spvQ5uJfhdv5KkKsg5EsnutQno44z6ZkKF/l5buCJWPtjZ6DkscbgPEno5Lp1ff+VbIEvQ+bwtx0osZZHEVUxoU42f4U/ADwWlY/MLXZX31daX7aUMWMX9zPgtb3WIiiIwpaZPM9yEyoFRgXwtQ3JNMs6IdVbeZs1jGTFgoY7aTiSlctPQ==
X-YMail-OSG: NA0e80sVM1l_ETwenReYk.pkAe2_I9ST.CGkbAseeJO6Cyko.n6pDl2vJ5y3Zbt
 uNH6AMGCsTTWBcpQ51aK7nm_hfsu4OzTKMb2Utl6FgqbO76g804v7WWA41St6c89sjV2Gcn2yibK
 nKlAZCblMz5GdvBasPu0vZ8Wa7FX5uVSRXhRcuV4PjHQhi0Ssw5I_LYy1vm20PcILI7vxBxpDOB1
 62UP6Pghb.r04DsY5NQzd7LCmpyu430GEf3pGI7GR47vIRSdAmS2XG.htOx_Qk7xyTMI7Y_r.Dvj
 Ieo5UoEJvaQfzqqWsn0QEiMyY8YT1pv8yp1QKzhoFXWLnc4kMfuCT_Emx8mgbU3fvxWs5czKE2tg
 x.3XwNRMfezN3NS_BChKo_L2J6AxJykZHXqCPIGYnPrZSBbFX2DP6.h4wgexnErqvhxh8NvgQCs4
 xa5eMHXhafeUjpOYwyRKrp08nEDyCRu8jfIxQA1GswWP_s2x.PyNsFs1kqqFrxAZYL_rNkJr.OT4
 ni0yV73ie4CKr0CFgvDr2GzyOxVvwT7fyTx9ijJsi.26ZFFVtFZdis1CwJxF4ZuTlaDx2605ThGR
 l.kfseNqLNMaPzIEcdOe_PFBxktn6sCZsIoTiETSX8SED0IbUb4NcJu21FsoKXf66zXe5ed7zhUx
 iZAQDSlXq9fo_6sIMWNoOHWmaGoGfG13hON8CBMPFe2i72lF906WIQ4uYajTtRDm67HWQj4t.t22
 26Nx4n7jXoiYU.MUkb0083zFHq.Tr9jgeETPnkC66iVXiK.XYQmEfHSbgt7SGcx5o8CPKXnv21lh
 SORvKHPvdZgxO.aDEdMao4eo3vpH5mugWO2ifvT7gXphJs1KRFGjaWVdOrSLXi0xsoaMNwMVpMWw
 mpkf31tPzn6XOMzJE5otcSyQ9mrpvD8GtUWVq3XM6Q1cBLswxlDyAb98jQMyHw4qj2FoRljdUs_l
 3SUtK.VZSNKERc3jaKWegL0jb_a9cG9Bp5SIQagevi8.A1uhtnCNSELF9lQptBDbd08rn7P8cBzq
 R7EOb0JJjqS2vVBfAgTsHurkq.qmA7Xd6FwnZAlUw3kfpGm6Kgy2k9BLFOBKksDIrrHOg5fDBzBV
 dFVRcM4qIhuv0m7JsoVcwLj_LrPy0Th.u1GjW6XbHWSxNxmjcEbAL9pJ_UWbAlIAiHeQZttgDPea
 tmGyPgjn.gno3iFH2qIVl.p6MQp450LFsq8FIiY2Kba4zjEvkv5iEvRYm_ssieUHzB3n_.4uKnDK
 9JK2b4ZfGWAlX71zm5uY2Lw.UWociXZvvOVQELYs2k6jlvsR0t7Un91C_hUtLZHYrZN2NlUndOg2
 HowBV12KjM0tE9Cq6UVtCWlO3FemyR7ijf0yFLH_Kxp1XsimIS5lR9HBJe_mmTSHcwP582N8UkVJ
 QSJuSNGs6HvsK5A_6Tpf5B16BIh2gnZVhTxI7T0iHExOcx8SwpOsYmoqk.7FjXmFW6IFBxkUhT9I
 c73jpCKe61sshTi2p4T8IGC..Fj9WTILTm_OLpeEYbPxuZtODlE_lUjvFPn1fHbT991FOlhw48_W
 AF6ubbiV6rd0izpUBeZU8qTCqhLRqyPmNVkeDdQdZ8CY0hG7aNHCPlUeJ8oF3.XG51iXYeaWA.BC
 n0Z0OMIjogoyVWWOY8AoA3Ki9tHtiOpZcxCJtgDpYKe1NvEqZGpMRb4DjZH8j0Q82TlLF3PGHmGK
 0YGYQZ9PLgOg17vtgdoRkwoS.MxdSNgFycsSSxXvlx9xSK7jNQrFNVM0.9PSwX7YX0ie09LzEy4L
 v71mp4GWhVCfCS_tFNqGpY5JUPFwnGLreHzYskfH4jIRyItAGoMnvQSKme5tZJTdyDl3LChi5jr_
 LLTFb8irlwEb0QyWcC5yxuZ6SajbO9A8QnamN_kztxfnvYYP98U6vU_zDsd0I1L6iRUIFaz.6eN5
 Dx4.Uv9KYvGxne5XMWrzW30UzTT7V.SZRqrq9rxyqwoaqf8ixUYOR7tWhREveM1btNDDk75xbPek
 hFjoZI.YASGAnAODoEowVJU_NESBAS4ziSGigUAaje8aMRQUFl5K41hZeRKSeSx1S_KByFvh9Hwv
 3lO6EGZc452aGWCSJJTQSCqxzyZUcldFO2ebTgP4RYYvvS6669LVyu.qjmWzf4pEllQBWbaJ.az8
 1o1Osi.7ELCh6pEYWtEC2QeE9Id0Aw9VzBilEfzD7rkrs6ZDWO8opOPWMGlFbbVaQAv8UJ_ViLep
 _ina6xnQ0aI0sGdj_lKH3raI1OdYEDGBMqGM9D4KrT9bnRHb6R.MMhWyQ2ayoNsXcHbjb9fp7Gkr
 yQ9abKRuM9_LMBg96qXORPWo4sg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 29cd6d19-08f7-4b1d-91fd-9bdffd2e122d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:17:49 +0000
Received: by hermes--production-ir2-7867f454fc-8nkq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cb456a1ee9275492b492c35f2e11856e;
          Mon, 15 May 2023 20:17:46 +0000 (UTC)
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
Subject: [PATCH v6 07/10] power: supply: rt5033_battery: Move struct rt5033_battery to battery driver
Date:   Mon, 15 May 2023 22:17:09 +0200
Message-Id: <20230515201712.30124-8-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201712.30124-7-jahau@rocketmail.com>
References: <20230515201712.30124-7-jahau@rocketmail.com>
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

Move struct rt5033_battery from the mfd header into the battery driver because
it's not used by others.

Within struct rt5033_battery, remove the line "struct rt5033_dev *rt5033;"
because it doesn't get used.

In rt5033.h, remove #include <linux/power_supply.h>, it's not necessary
anymore.

In rt5033_battery.c, remove #include <linux/mfd/rt5033.h>, it's not necessary
anymore either. Instead add #include <linux/regmap.h> and

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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

