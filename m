Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC796E3845
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjDPMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjDPMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:45:17 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36295240
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649107; bh=BgnxKccDW0hD4wBKD/wGrzdwGz4y7GQfSjWtC1jgF84=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WrGLvDI03t9ixKW8BXIrR4+Q+gua8L8MuaHIr2+gMD89i+nyI1OEfFhrZl3i5YxMJgnTV/IUgOH7pO1Ifz9piZ0BfdbF0A9KGyFMzfF58FOYCX17f5iUvx4uUYTdNN0XLjw5bF4pxG934CqBLExiiFMIV+W/wDhLdziZJDrzpw+F09wvScBeZriuhLB06wx21dbBnOfwafDFbYTqF+aU10/sQ4mXlXn20MBtDNFPD3iVtBTOotmFZB/J45ujSTcmGGJ+UObRf94vhurMK179l4Kljul8rDPUgjrC5LupBYYLluOToOWf54z27ik/UYeXmOlQ5PuSgor9DxOO9F1hWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649107; bh=NW+YohgAJIbbu+CgcHo6KoDs37jn6lf4CpBsx9o0SLx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dJUlraXL6u+S2u75PB06KZo/r+CbL253gXEzSZC5EisMN4m0wm7nU8Ygj5wyRGEPo4yhCp81iBEIlvmCdJ1KOrpRhc5nuiCy067OltLrfIeDAozDwFmM6GsOnjTBshwokQmw05Yup91ycGP7Ykfb16UBN7QSnVTuuGIgV96HsggZptUu8LhU6PJoOhEX3WagkU3tkpHpyIbnng8GuDqT4XqsxdbRTvLYUP00RFiz3TwE4ihPSPGM6DdYXfMgEQR8Xvqlb631j8vXpvDNrUzCU28scjG0L05QcUyF7YimfsJRpEN1xpj6apK/53dK9khyyoP6YA+a7RIQozoUaWFT2A==
X-YMail-OSG: 0xG1sX0VM1nFpK4qSSijT7Eo3.3W6j2mCRJwPArQWwvzLUQ17rf61lj8gHzNZnO
 o1LFuZ4.PegTxUrjbrXTI56K2eqOAiRfloL8w8EbkCt5LCEN0iNtxmJGvDwLhn0Dhfkqu5ZiG3UI
 cMWFYTfU53lJUYqWkW9_XPZ3tSjTCDu4ZG.Mk6ieRll_owWbnvvc8ezO33noV.aEmvH3zLI1rboY
 0vHIsE924_cJ5.8eysb..EAkrUgflvVgaQrmdfLQd24R4tPv0wiJnbpF2AnomXw4Ypf47rYZzxZh
 Jf2W3878.7wvRmKsNFXlMYfQp3caKHZONlWxE5zfhBlsey9H6Ai.k9TrIY5SrEoSzgS9U8tcPw23
 A8pGU8zpwIjyI4tgyYwQMBZ9NRAIGO4DftKwbw0q8im5aBvVHqzPRrxS64uNGethjx2Su.8NqnCi
 OtXAENS2ogKAVRUiRTi5UWDGZcbMYaJPJtnZK0JBYzMbdiISqu5zpIC9exmcW5zn9TpUNCIJ10Wv
 WrSA.vTZMm.MNoh4y4wH6OXuztOPJk7s1VydZVXifhoPmyRcllDJj1wdn2n0_ivWPOChRClqDXvI
 fKmiiFFR1j1HPWJmUN3P9UH22Mnj_MEP6C1sR0hjvgGN._q0mGOWWfyfRkfweYcNvR6vsNF4_2Uu
 qK8N_bNF1xLmdEMd9syTyy5fIbn54TrdM73D1hETKW1vWVOLYVY_qrOA9LDSWEVv6ZtIHlwMtQnc
 ZvAxuTUJkFXVapt7NSnz0dZu9txF.fFajP95SgoXBIyPvUXDFrxOPw2yY3FolEqs99Ghw2yzcCKW
 IjUlvmkrmCbK48sXfplE0mGcK9MrdQTKoM.0Oc7S5Yw8c2ns8X2f8Cx3Ttf5rIBt4JPIE6_hzjFL
 xZ2nmXo_5pbvOTJ.kApAp7BcCHhlWnzev.mjwxyPMTK8oZf1pyrVseHTBkCalLqgzBIsKu8WgdZc
 jDNmtYfn.lxLuJUj98MoskShpH.QYbQ_quQxQdv5yOfOmORaL1D38kXSxZ_k_1hEh4T7yXvJpvQN
 38q9cQjZKMHqzLD5FyiTedTiDwHvupy76IvOMUeJfvRs8TaNB1uFtnRz7Mve67VeOIQnc3UNMTmu
 T3wlXnvSbCPrrA6KgRj18f3PLM68OBuQraKBxU8zPm6fgicBoyxS6FmOQWryIVPSeoC2dJ8a9Lch
 OKA9R8QlC3zhGtjpB3TrYiX0VQ5BTPg2.1WBcU0sCGb70E14vJHIyuGeXL7Hyw71bqzPXODsLQkN
 6cxCzxZKe3qQ0Bd4C2JlhA.t0YyOY6Hd0bLbPpURbltBFwG8M7dJQZsoydggeTH9l9Y0jbdqSkFz
 MRa51pad_SfwcYkKXgDlzYZeOmvNjw9cD1yB1nkoN8c.ZdjDBZIhs.791cW1fZt3uDxh5xVtEdi3
 YbKKUWjAZDq9W5Y7A0cGXDmT00qFT.T6ibek0zA3YavVD9SwMPPVCMruccACdhB5fZf0yrMXV2O5
 xyroRqJ2r6AbLAlySKDsGbbKNJjCP8y_7175euO1LL6NyrbD7O4XHms08tzABXDVCvKGklX.uNqC
 Ep4YcEq0sDJZXuKkPl_uQ0pYITg2sZInJJQDvBWsbUuYyUDHF0YkZ5VP8joxBR1rWPJ4a_Pz9RzJ
 uG4cU9F6oajNf61CJ_1T3EZF2zkYEn8M7zyR8CnedXq3tTUVYqd_.jjH.EgAv1xOwmvAkfOVN4kS
 eOAOFIblhMOXP9GbikXNi178UxB8tx4dWqteH02skV45eAF4Z3I3lTrvlii9SDAWqT4mfGxMJkLW
 mQ79MGXIC.fs.lbmQ6vP4npYYPA8GJXUV8mHKkvqeynHi2h4G4VY5Hlz7sEaGUf0dalqAm60L5DJ
 VFKmfE5JR4un3ZaletgACAq5EedtEoC2uj0bIOOtuntGRq0rnhGPa7ZrmRURpkPyTpPITB5rDS9k
 GVvGLkRKfbgJ9SPufS2CpdiN5orYjKoINAsNLglgmGtcaiNI1ByHO77qu1_NZx_wmzW4iCBhKcdt
 .jtGv3o.ZeS84FjjyPzJc2vdPImrBjyQXOmHOnF2IHI9j8I1Y65iLR6uKrnDA5DLSaxQekcokfvW
 N5TalC4h7HJ9WmMm0GAKJ.V_tQyVejm8L3y1Z3hMw8YyzLcNoALaAmOLqEA.045jLXzUT8cp1qAt
 .Y4.h8l1KDEByyBMAMv3adeE3xBV2f63871KjoQlOyo4.mRYCVnipb8Ig_vk5ziOVgT5m4g2C.p0
 JQTtdIjZw7Jst3HQMPiSlzGqb5qNDW6tR5.F8tmblFJS9bD1qf7DuU1XoZ68inGz1mDv7GgTbber
 yyChx.ZEZHlNjntEnoH8KxrzvDuflKu0elz3cMzSmcYYbsko-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8127dbfb-da10-4c3d-b8b5-d9c2217b666d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:45:07 +0000
Received: by hermes--production-ir2-74cd8fc864-4bl68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a53f7a8722383f9609d619e4fab1862;
          Sun, 16 Apr 2023 12:45:04 +0000 (UTC)
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
Subject: [PATCH v2 3/9] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
Date:   Sun, 16 Apr 2023 14:44:30 +0200
Message-Id: <7eda1f8751b4f5a5bd88063b7fbf3cfdb911019c.1681646904.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681646904.git.jahau@rocketmail.com>
References: <cover.1681646904.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charger state mask RT5033_CHG_STAT_MASK should be 0x30 [1][2].

The high impedance mask RT5033_RT_HZ_MASK is actually value 0x02 [3] and is
assosiated to the RT5033 CHGCTRL1 register [4]. Accordingly also change
RT5033_CHARGER_HZ_ENABLE to 0x02 to avoid the need of a bit shift upon
application.

For input current limiting AICR mode, the define for the 1000 mA step was
missing [5]. Additionally add the define for DISABLE option. Concerning the
mask, remove RT5033_AICR_MODE_MASK because there is already
RT5033_CHGCTRL1_IAICR_MASK further up. They are redundant and the upper one
makes more sense to have the masks of a register colleted there as an
overview.

[1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L669-L682
[2] https://github.com/torvalds/linux/blob/v6.0/include/linux/mfd/rt5033-private.h#L59-L62
[3] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/include/linux/battery/charger/rt5033_charger.h#L44
[4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L223
[5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L278

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Acked-for-MFD-by: Lee Jones <lee@kernel.org>
---
 include/linux/mfd/rt5033-private.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index b035a67cec73..b6773ebf4e6b 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -55,7 +55,7 @@ enum rt5033_reg {
 };
 
 /* RT5033 Charger state register */
-#define RT5033_CHG_STAT_MASK		0x20
+#define RT5033_CHG_STAT_MASK		0x30
 #define RT5033_CHG_STAT_DISCHARGING	0x00
 #define RT5033_CHG_STAT_FULL		0x10
 #define RT5033_CHG_STAT_CHARGING	0x20
@@ -67,6 +67,7 @@ enum rt5033_reg {
 /* RT5033 CHGCTRL1 register */
 #define RT5033_CHGCTRL1_IAICR_MASK	0xe0
 #define RT5033_CHGCTRL1_MODE_MASK	0x01
+#define RT5033_CHGCTRL1_HZ_MASK		0x02
 
 /* RT5033 CHGCTRL2 register */
 #define RT5033_CHGCTRL2_CV_MASK		0xfc
@@ -92,7 +93,6 @@ enum rt5033_reg {
 
 /* RT5033 RT CTRL1 register */
 #define RT5033_RT_CTRL1_UUG_MASK	0x02
-#define RT5033_RT_HZ_MASK		0x01
 
 /* RT5033 control register */
 #define RT5033_CTRL_FCCM_BUCK_MASK		BIT(0)
@@ -119,13 +119,14 @@ enum rt5033_reg {
  * register), AICR mode limits the input current. For example, the AIRC 100
  * mode limits the input current to 100 mA.
  */
+#define RT5033_AICR_DISABLE			0x00
 #define RT5033_AICR_100_MODE			0x20
 #define RT5033_AICR_500_MODE			0x40
 #define RT5033_AICR_700_MODE			0x60
 #define RT5033_AICR_900_MODE			0x80
+#define RT5033_AICR_1000_MODE			0xa0
 #define RT5033_AICR_1500_MODE			0xc0
 #define RT5033_AICR_2000_MODE			0xe0
-#define RT5033_AICR_MODE_MASK			0xe0
 
 /* RT5033 use internal timer need to set time */
 #define RT5033_FAST_CHARGE_TIMER4		0x00
@@ -195,7 +196,7 @@ enum rt5033_reg {
 
 /* RT5033 charger high impedance mode */
 #define RT5033_CHARGER_HZ_DISABLE		0x00
-#define RT5033_CHARGER_HZ_ENABLE		0x01
+#define RT5033_CHARGER_HZ_ENABLE		0x02
 
 /* RT5033 regulator BUCK output voltage uV */
 #define RT5033_REGULATOR_BUCK_VOLTAGE_MIN		1000000U
-- 
2.39.2

