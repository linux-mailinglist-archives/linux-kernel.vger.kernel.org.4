Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C89703E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbjEOUK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244838AbjEOUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:10:52 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B241154D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181432; bh=BgnxKccDW0hD4wBKD/wGrzdwGz4y7GQfSjWtC1jgF84=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RP6aw96yc2BHZ48d/Uch0+TopFMEeo9MizLV7i1kPad8H1KamdeiDU1tEuq+jALnNRzGIKQt/j3V8snvArld6enLltNi9dTcofAV+HGccg8nlub+xip2jnU8UmJEQ07lDAuj3LbVYX5W5I2sf0SOVTUMVEL+EefBclagEIarOES7YIxCKuSwypVMxi034NmOWB6jt2RX086yDU4U9H6HNEiceKssXQHHn3W+DNkZLT5VyS1Ww5zg1+5+6S2tnxYvdt9FtrZS6mZuxAUHNfqGguGfHBHbfGFBCwMKghFzlPS4OPU5YjZ7+PsIcNGdUyepOSU6qXbEiHBCd9EqnkKi4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181432; bh=oP+s83GQ/16sp4M8IMngNSA1dCS+rqi9Z19DSeaYgRu=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qk0Y7nj69lz05eJ3YTeePUGYm86/a57A4jdhCOFpHrBzk63wwkgzR531g0+W84OB9KBM8N56MQyoLT8iI9yo4MWVSVDynw4tlx0R0hJJifMAeivjubnYN8odkk1BVLQS1NML1SxaZZPR7iKMVfRtzOfJUcf1iY0NaT0SrGZ4jK+baQlbGFmukSrhcwksht6SLSOalaZ4gwJi60UQs29ruCWCJyIVLDLLCbMz8Q39CajMmCSKGXPCB16y3bbVtGL8hv3lTTtSF8MrzroeN0rwXE70OArJJjpefaf8SFozdPppjDSEm0T+UzB6PEAazFE9h6qNlZCCojKL1OzpXTNkEw==
X-YMail-OSG: QH80s0MVM1mOEqDsKNWgaGzlBhYDBuI7WSaRBXjHpVB6K3HibXQgQv26rBz0B90
 .IA6uC.TRpw6b.Z7kMGgOzovzEBsKgD41n0gVdEneU995EnRa8vdFQCjO8DGk.qGqpu75oHmlQgI
 KvukHDTFaJ0NwdsPVKX4bBZNkfvVrfw0utGdNZFji7PkD31Di5lpFpRmecLln_Iogkef7u3j0txh
 2V0HNlQ9sTUm9dBIULo_4HUs7LXpdVDnuTW7gjPBfDEBwyIjarpHrruMMo.urir5z8LaiCaKSAC.
 IAJ99p6KQaupbRfnkfyGabW9.AfUo6zNh9pLjYvFsrVjQgFbWPonwnOL4fDWwb2J5wOMfIHs7900
 c1fbgaN6Ul_CnzG77PmlE5DvoTsOUOmHhFDP8a3RT5MKuwobmIgNlHTwALowwhcpJhf7JQZKvDw4
 ml_rbreMZAyztvlsPTSiSlXwAP6Z.uZhiZl.0WRYIg1sYGX9sADgPbgNYzFGZ63aAWHgVKTLanLP
 2BRgFx6DuOwy0t3BSJllQTky0UQIRttAANDkCO1eBgwZJsaSXKgUxJq76GFFYEEH9Itr2nPv0qTw
 xv53Zb8ivieIfzzCNba9Gv70xRVj_Gqa7gi.D1zrgWDQ5dPfCpEhO6gCDOXiE.fkDzsS_6q11OB7
 G6LhmEkQbW0NSa7DESSbz54B1O2.UzXPNSbOdOu8qZmDojjMwSd3iMJo_A4vm05XijJz3QDjFvzA
 84ERQBXZTE6QQblpxZXKP1mLBqpy0MYp8fk5WX72RjnJ40dqDvUWed0ALYdL9kF1osBouLpiRdqJ
 SOmSRDiayoFbHAfasEtwBJnNeen_ObRP1T4B_7noJrr4snLnm73o06uWTyOn.mTpJQNWsjvvzXjt
 2wTL2j2VuZXQ.dgwpr5T7dZI5uhsNw0nxAeSKyIyKUHsqTLwVwXzpAYODlP5Ge2HX4fpVla.ZAsT
 uG2YXqUjPxD1thA7_JFIR6VXBo1qKjkNerS3a.X_FeBWd5wE1lGngM_WlxdnOXtGmL5NuD43QlZx
 esT.8V9rVmdVi36J2pe.fagMlhFlJU3XCtCdlw_IhEp0CqjoOpcY8KdO5H94Wgn5DtpF3OBWfVCC
 iR_CEH.1pNFbEJkfjxgPsMhcE4wiDso2mIWrHcfBe3Fb4Me6LdPKP7eiBI9TBCCi3iDfgWHtEsXd
 n0vGmJNytZKQnh4otNqMnJAHW5jGs3GTcRTqFvk158EWY_wBjjee.i.FxOHnRoZoNK0uwaZ9_AX2
 cbp5_xqujZRQvGKZw1VGmJNNiGFjkiuHPXqvG0nMYg7i8TpGyhTKzNv11bACpzMOn4riRin5shbV
 SS2FEy25wTWUi0drqWdKYRBycRfqBslu3xWIFMmZ_5DUA1w_Q2BfybkY8PfhLG2QflcoVM5wr8dS
 l2fwOnDQWmXpVsRMUX3RkZm_qZoFEJ6aHakhUawlQSbyQkCEf9n7rK.QY9CdhSE_MDMcU6xzxJtm
 0_RFNYQJFDZ6iK9ToQQWGAr3Z7KVPT0MRxyLjI6v5rDnyfBUW1pjfjZq0jA5O_YKms5eCaOdYx5D
 .RExC.0R9_DQBNXekEbMFvQjvlOUnwU83FmsCwoi9WtpZCvHEM4LV1jAZzdWFOql99BXCd_Ayv6I
 SLyh4tauJcyJMfRKjzReAEWzpydUiJnQKMGVZ7flbuBGmZoZ.7cbg1.z7Gm8yrmnWmZdzvFt7C6Z
 f1WbjV4TDDVJ550QfpObqUad_47DX0wWUcWeKnL8Etkto0pQXj6Paz.Wwsark0ijHky_A9QwlyBA
 0xxrnnL9p7d9Yk_TneKGRkM_zfNjXvh3zUe5cw2VM5SPsIk25IKjhgjdEPtpCZsjSoOJKgfYYUhy
 5sodqdAvyw.0oGxCnqYOuxc_f5PtM17CzTrPaaZ47EZjaIshRrm.3AireB7kVAaqaxJtBwO_7ASc
 JWDHS42IVKXqHUHY2bMDj3NlUSa6s1dFBoG1mWj9nPxdtSN4sxB.ElHzS4PCJrTBjd4LcQ06CcrF
 nSghwBPZvCeLMPAmzAKtYWHh6.kWd1DpqiuyshW4_eh3ex4tjjyAV_Whdr2HzTRJKKpXgvNk7Qod
 DMkjnFu9Po76MNZYlkyuLpCo8EB0HHdvEQCUaOHyAW58AUVVSLQD4xRD5E9uUmDVvRjIXvNaqmk0
 LyHPYBR.pVHi5eHom2jtJJ5ku4R3JHf4B3TQM3wPBSBiaJzfNVfz5CmTjiLAMA9E70N1Z03jKD4J
 F_TgN6lDMHoGELZ7XfBm6n4oulcA_d4WeW3XUM2mzJQpr5FLDxHr6b5ARzV6C1CHrMQTAHjOx7PC
 LpJrq4D8blW.AXMJ0oCtc
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8d82af19-c494-4f7c-b17b-99f9bda315bc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:10:32 +0000
Received: by hermes--production-ir2-7867f454fc-nvr6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7905ff065b8716c1e39bbada6be8236;
          Mon, 15 May 2023 20:10:27 +0000 (UTC)
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
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 03/10] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
Date:   Mon, 15 May 2023 22:09:55 +0200
Message-Id: <20230515201002.29599-4-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201002.29599-1-jahau@rocketmail.com>
References: <20230515201002.29599-1-jahau@rocketmail.com>
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

