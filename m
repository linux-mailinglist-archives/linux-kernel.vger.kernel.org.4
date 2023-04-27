Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C7B6F0EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbjD0Xa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344433AbjD0Xaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:30:46 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C14680
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638237; bh=BgnxKccDW0hD4wBKD/wGrzdwGz4y7GQfSjWtC1jgF84=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PQKjhQf0IZKJMvQi7N9dhnmn7aouaXPgOFtQPXtWZwq1RmCbsAc8jnYENaYkp5HVF9XK33u6Adp/H/NZK/8L3Rcwtadk2F6ZbxHtQ+IIeuwBvH/0PdfWahezGCTcKEKyUPUC0hVBqqr9eDFb36pFXjEPBOnIbH7f2y15kn3kD2yRI0zK6cmBBPAVRKrcNHqj47WEOiEK3Kg++30sfKJMm2yRuG9jeFDkHYuX1fxt3jyb9JISn2QY0Lvpzh2Z6DTVsI0S0hsq18nz+jyG2PbX4fuOZ45M/xlYvLTeXsfQEE5dptbY5i8a0JRi+DIlnpU8eLrh9M++RujM2jJNiD23JQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638237; bh=YleMwHgEakViniISIjbeHeefdZSR23tchtT2HsYzT3i=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YWQJOi64ApcawUCjkQf1dbmCFK5EwMUedqVRjKMKCJj8Plt/sPX6gJwnMuyazswrr/0V1BRWfcAqt36vqwBTqzfHU5eZBrQ8NneqkbdILOB5r8qWRbJJLrAdcsb9YAt6BU8lyyDIfZTJ4SnB9+S4ocx73orDbFcxVKSVEfCm/vmG/JEtqgeF1Vl/qH0G4sz6hPpu5LZL9NSdMjmXx83Kc33TIuhnJstK3RcnS9BY1batCSlfONkI5yUH4La8066SJNyvVa4Esprv1yttJjd15Xic6r1Ybcd+siKFqdAX4SWJFZO6jjWmlzxMkNNPUgM5wVVjGZK5fKGgwes4zn0RoA==
X-YMail-OSG: zc4eXssVM1m9uhj2LuHZGyMOiYHu_hNQR_9KT6z8KzHNrYtaxkjcX3CB0pATnGY
 wDA0SK1hHo36Vck0qWQFhDn90gfnIW4l04s5NaDguoTuUtHQqz7qaCrsTj9VIs9XQIiIHbfmh6sU
 Q73HdOer85Zvg0ag4Oef1cYi09OE2sar42WcieWDJUSPsPOnhT_aBL58VtoMfuqDydB0QceZzQ7y
 pB_2qw2lgBMytadBKsToX.wkYQ4JV6d7.86uAeqn6VJe6Ebicgos6eutgkBXhMyoZT0etyQWEJrO
 TwcA1gvaLHJGo7_QNTSfCm0whWjtt7pus8ZRDMVd3J.Ici76B8n08JdHDlD5us10CWoJQb8Nf7fF
 b1ifsigJvJOqYRx32wLVgNrPvAuUK7AVPX5RmvmHGKDHAVrKlYLa9ni6EJe6hp5S6s4TkVZx8iE_
 QMce.aWh50SFMI7bFRMY1x7yWsnU_eO1uTLX2paXbRzKej3hsgmrLyBIjI.I4h_ijOqQ87aobcaF
 V0a4QAo02a6GM9XuzIk1bz8q9ffe9su8rhMDCGyGrzAnTVgiFaIpO.UnnUUoGDwAN9bZZludYzjb
 Qe3dXGltiFw7WyFMkzxxxid_sHoxCiMCYSTE8VrBtp6BkzUbj8PsyBemaS4r1o6TU.KJVvISjCqD
 uSPYEoKthlibkCdnnfnjy3nadPiv.jI0u9JFt_XyYqlHCLRwTTb7lkOaKPSIQ4PrF1.JIo17hV34
 qs36pLugFoC9oz13om0X7c_4N8YTszcHvXXK2fFxcv7QeAc72HTv..fFHcZkrp3Fi.DE5QqLtm4X
 5rBzsoJugiW0Unw3EtrTsuxK9YMfEfntTAkm_EJPg.YFtQeEB9dVKNu3A0lxDfKMEF6Qvd1Z.4Ir
 PBZWp.D_sw7PrlavRTnpyPOArd1Be1lTBmQoOP4oNU4idOXEyovG6vLWe_6orrZldqM._2Ra9s7i
 0jgLoxYob1yf9_4iEjC4XziyQXDRItSyvRj5HHTnIBpSuj0j.csQmTsyk6C9Qb8FlGl7vSstwoWo
 fhtpLWrnhZEjN2Ij.DOdYTNdNBTnDGcU7CwZ3ptWNt3VkCndZD4FUYqHX0r9gGnT.j340GYlaS8.
 AlKTAhRnxbyYw2eJfwr1Twkk.VZ1leWriNFKAEjXzXpQzMJUIOad2WTUo5YGlb2XsWzGZ1OIlghe
 j5oXiD4b9yLKV9BpmphCVuOjNJK4fvykbajdmoV8eHFEoa76WR_Jrho_Y7tF6QYHgqVeQTiKbU0V
 3jt5f.J0E_kxqQkSgVuPu56EHOojY3WhD60Mu0lQqGrAjX4qb.Oh_eSJhQkTl.AkJAJmSeC.z4JA
 .OcGrcnowMFJ2kZwBn_GcKc1PqryMdXDyRGB0t.VAXdKRp9CiWQhv1Nr3TLqvxBHdmSKKNff1eZ4
 U0qe6.0fA4FVzWsOQLo0.whnXsvz.nV_2P8Xba7CWPmroWBZLThpclJJbQIH7Tde1Csl2dfsESRm
 GFMh4WjypokDPfhxXDqjZw474S.5AL1CPn6f5NaiYmuJJFfOs_K5EQQlNee3wOZGNCfN5UbFST7h
 72hrpW23.5OmtuOvmi6RAkSyEvJTrOPJb5y2VeYl5G1haK1Yf3jgqCkeUIq5puPQqCs49I26wcvE
 YRX0v_NzvCA1jAuW3LYqCjpO4JKJ.9Bh_L.SbHYHhIHAt3zSG0D0UxGu_eZc.ZKn25.u_JtdrZKE
 v0z.mn2GHgNqaspaXjLBIn90.Iw_5P.4cpOhjIEARYCXyp8WoZI8hnfdyZlo4mfVn_P7CGqU62jM
 lS7pMCsRe5p7nxzHQkLiN_lHSeUmiDRMT5dNgni7IcwpDj47aCIK2f3axHduJ2hSze1peBBp3lR2
 onXZnP7Fp5R4E.fYzsRGJy7CvzU2dJio979oytdhIcYT98gqrVMNXw7GUICSJJvQQr7Lhu0SEuys
 t6JI40lfoYFxRsz6wIJCHtsy7I72W3d_0uuFkcEnThqRRStnGRBD3mB894.VEz_ID2Q8LQH1bRpj
 YQIADE6WI.6tI963TkeQ.88ALqUInN_ZUtAaO2FEw8BoZhB0okziHnTpbXawjW62_tCVLvAXBwjv
 ppfGBAowDEcdNldeq4CQ4i4CKodZwpHNixcZ6e7ftI3TZsVMF.fuOBg45ImADpH_rPvmhO8_C0JN
 rGnEr7cZF1ByOs4ML.UkUGFYt3pnU9Ab6Z7gr8yMA0hQvz87YgGZdBurPF8L4tHDBn0LqFqqMAFE
 jYflevAF2pExTgOUr0jOfRr__8lNF6LNzhOLp36lI9rneCFsOWOko.m2RKjfhfgb7UOvTTXIFqJl
 1DCwxToLH_hy8BrYiEVPwCzE-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 613b4756-daa9-440d-a15a-85cdf205f9d2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:30:37 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 912b1d1a256b22e43f453e00130c1256;
          Thu, 27 Apr 2023 23:30:36 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 3/8] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
Date:   Fri, 28 Apr 2023 01:30:06 +0200
Message-Id: <8e4c8cfb7820081e62fd6d86db6c53cd2792a29c.1682636929.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682636929.git.jahau@rocketmail.com>
References: <cover.1682636929.git.jahau@rocketmail.com>
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

