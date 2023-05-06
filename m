Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4110A6F92E9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjEFPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjEFPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:55:07 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252FE14913
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388504; bh=BgnxKccDW0hD4wBKD/wGrzdwGz4y7GQfSjWtC1jgF84=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UfadBhbI9VtF1wxEGJ3H7hb766TB7uvihxuyKpmC3klAR+V0OihCmdcmXJi+1INZ075veT8BwnerMbfHioyE6KLycf7QROMGvf67pAc74uz+PEsFeKmiG2pKtqnvyT/0QCLGnbeUd42Q3YXioU7+SbuFaJSiSeCN6QsjHY8BjWCrOCawxTPRw0CLmWWs+rKBq2e9I3D+nYsuA4lOpFOsDwSB/p3yX7yk3OKw+sbKifu29a5Zyr5XS/NclN4K3EAnUTbJOMFuDm8kOZ+olqz6GfhHynysULcZnDzgF8NwSaUMULsO96caXTPBsNBWXKBjTU86j0E8cbI1zCa28vD+tQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388504; bh=RNV/JCjeLztT9viv2T43hMVNespAeCRByTEg8dNf8wi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oCY6/0FeqsIDyjjgnHnzar6t3qKAWIT6grM1BiI0xvsYsAA2ciA9nAD61jN7xFXEUwQZ0eHHkBDbWcmsO6AmkGP7bfEZMwhFfMBNajIx8NJwXPFmYUy59pjHkdRj9wVn6Q0cQPjI4wQ2bWCXc6M5Lh6n8avDIqq7FlAOPcZBxyGNbU0e8XKxaTLJYIPFORfSH/P6D/aWoLXWSTFv03yba9dbsRks/zY7GZhx98mWKQvDaztmkxHxhOx6N2giWTH9MdUelHt45UyUYyee6cxPeK1R0/5PT1w2LkcVOydIcMeuHP2j0jqeNPO1CKmF/ZEICyX6nQT/1wHHMM0CGHMh0w==
X-YMail-OSG: .EoXj1sVM1lMET6iIQaEh88oWOhfkp1zUO.qZIYIPaOOOQlFDITJUuvI7TlEeow
 ftUouzjxfcP64YFDzg_nH01EeAbzH_a_sWyEY_hZBqBISXRn6ppZ6j0YLZIjBMVfGmUL81z71wcf
 EucITv7Pt_4Y0EPoBudH_EpIEOKKYD7hPlF7CApX9vNbEaPbsQPP8wd3OEAwcDSeVEOn5DsTFrXc
 FF2ZtSnrUyVDSrvFOQdBoylq9eGolfPiN7YoGUBH6B1u4C5VyeaocAIcIBFMJVTkSUpvjKJzn0c4
 XyOkRXiVWycp7UrK0QrnzwTBjr2UIpoWzYXS7UYVnmpewfYz05S9yb.XRGi2xJUo0o41ea1R_ZAq
 PYMVWcAGJJzVu9Yg0ViZoo0_LRRmL2AyT79KdcG2F5DK.m6V2D0X1IrM3h3A26hXaevldFSo7vc9
 dfZYuwqrldiLBkth7qcBMrYtcIhUO3Fkov.NjXxMgBaCDdTv4kSBr6e8VslJp20uVilcRBepNtYm
 xVGyNK7dTHziPLI6G.VcgE_jNcesVWFZuVZw35MkSjEnP6IGLD3ZIX6gTo3SL6fwyFRSmyrAZRQZ
 a2LbnDy73qMbTwEIen4mHsaoT2GExtEW42BDww_A1.GG4nqNhjTIQ4x5Kn3dZ0eUW79h3.qr1sor
 6n.S7yIcVXyjkL7I6MRjb6d8DW6Jj044QxB8d80TZ2Tt8Au0zqpee2NhXjYsrdkVwddv1Uxm.b0e
 I4ETvnubwQ27wiEVlAYL7CItfc0XLuy50.o1K..S36LLeI53OvVcKP6okOx5WLreRBJ6pefevFlH
 mXPx20yigbs.XmehUNkFMsoUnuZMf9R_FbGF5z69NUTOZRB42oTLrWEt2VdieRXuCNOAQmofWLiZ
 egrBczNYPpbF6xIjybXcid2Nat56tWhBRIx8L4axfNNVU_MZc_93pNNV4TjVSh5SiS5SKjs0qprw
 OpeH_FuLtUYhRz2_kespTNDARGKhAuoDpzv3KkRNJM8GfxdXUtC1lpSnjGWuFMtcNqirupLFWMbP
 yFJ1278LUoUseNrPDVowmcDGSoj7KRQ0jlsSJ_mhXlOE2WodV8a_kGJZzVdNgtw3U6UQtnR290.X
 oZTtEnCRtdEBo1NFHu83eNbBSBFDakAcpQWj1BwhqyaUfSGa8fz_hTCkVJRRinlmVluLPrvYpOHm
 VVNBLIDEr4vrlXXaZs8.GY.36qVc7a1KqZ6xXvOfJSjFo6l98YDLS_NVEMwH6i2y8nPAV9f6JuqJ
 lfOCJ_9SVbpN6pi4GI4L5AJLIsvMqzhy2jqUYqXpHbO5OjIcWvvHll8hm8Rvkoi26gkTjF1RH9r2
 _1NJaWr4UUbM2Oi7zhOfJ_IKtYBzPTJculMuNlniEwSarNWFdOHyEsX8v2eGs.H9rHlYTN39kngo
 xpjWByL7Y33MDeTchwoWSRX5UmQwjbAZR6lCPPhM20lphRodWv8tITwYkqh5m6UpqZx3e0Rl6TZT
 VEwPQwYZqVBKwm7fx3MSfa1SI.8yIjoEareTG2j6HB1Sj8JMDKmmYe9__qp37_f4eC5LFA1kSID5
 _IxZ.JihJBY95XIU4bNTohbFbYuSlIYtllfNMrLarQxWWIz_ADvIRZpasQyG07MyWy19sE8AKT8N
 l7mVNWFZoe8sZOHKemen5NEl6N8v47UoUjbmfvmtD2jO47OVyiyNGdIs0GQGkwyIQa9RAxOZUjeB
 FXxCrjOJDD_tSJZnnvICIk298SBqXX5LWXrXoyO9RchixFuqfkPXW47fLl8zQFE1zw3crFOGx6hT
 s.0aSbdkidbPHVzLEbmQ7kSpfVPBmBLQgKKuZIB5wdO_XMzfizONwR0IdTpBaFyHFW3C0P4pK0np
 dVOzKLDo1_EzTvNFnpTRnLGZ1CaO3m8um7muaVy2NW3DH3bBZueeF6w_CNlVD1mVu7WSCekCeq7J
 6QioTa3Qt3SGDDdhBi_aoSNbm7Eg6QN9xV1nnLHVorM_a8S80a51G8sCuD7afnClzBFezfHpVfwZ
 ttxuM1nsWLEUPwQ4fOy8yk2.WxgdLdfyIwtGzItvwGVDx4n3le0oo9qHeweWhlqUle.Q_ftZ0Oqu
 3vu2HMc3tV1ld1goQQmm3Z8tMN5s7e949q71m7yA4QbksbjC_awy5GpZrhXriQXdRjL6kyBRi1MP
 yBFcrfJrHKymrRX5shaXcehN0J3nNryw.16l0khD7XzZnHhB3W02Bcm3Po3sCMfU_S0wBmdcT7BR
 XEgWriYjDSDzc3NsxJvLTNb1.TX9R4PeGJveNwSmG3aZnBetNu0LdsI7eQN.Gs5_99zWQXW6hTnX
 sF3_Kyc33mgrgaF5eeH9RsA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: daf1be99-739a-4c97-bd31-81579ac28943
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 15:55:04 +0000
Received: by hermes--production-ir2-74cd8fc864-s5qrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f796affa0781b2e3002453351a4dea5;
          Sat, 06 May 2023 15:55:03 +0000 (UTC)
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
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 3/8] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
Date:   Sat,  6 May 2023 17:54:30 +0200
Message-Id: <20230506155435.3005-4-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506155435.3005-1-jahau@rocketmail.com>
References: <20230506155435.3005-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

