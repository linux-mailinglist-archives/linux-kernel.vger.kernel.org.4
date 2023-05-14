Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DAD701D58
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjENMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjENMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:32:01 -0400
Received: from sonic303-20.consmr.mail.ir2.yahoo.com (sonic303-20.consmr.mail.ir2.yahoo.com [77.238.178.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD8626BC
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067518; bh=5w6Shyycf9TKW8fxiIBkdZ0V7BL6iy8PZMl/Ylzmv2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DyDRhBQEYRktzcQdNPQ9ON26jgHHUNBPM80JuNTydyZ79XWt4Pih3v7S91pB+uDxd1Y77NSLrK0wxHr6AhFaFot3ML2cCqMZ5pQr2OZEAGCjtmThU+LosS1OFp657Rkr3q8vnazE8Ah2rsr1CYcmzsTmog6ZlcrZ+ITalYvlvTU8aL0DI2v0DU39MC6D7kjqTyXd2mrFm6vB/XKd8ds3YxNFXjypnIlNK4k86oqCE5dYQtBvD/xHRXdCoJDc79ouwJ0B2yhYpwHFjZP1T6yu+OOP4WJSwucof21CrWwnfmjeC6Gt7JJRSlyWLtVz3BapkSZgdV0F7hbPhoTdpdsmbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067518; bh=HJebqURTY5FrewwRn8MaPno1pIcc4hgve2QLthmWurb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gIq/9i6lh+RILmhp3DE5VuXIXSOE8awybChQNBMqjL9SqRxSeGvMQwsvvXETSdmFNsmQk/iaSzA/zGONv3lnilJcAfnlEgsbsVJOI+O0pbCBefaPkSZUizNNE4a3rwsJ1WPm+UNw4v4J4a2Ikn5N4zqTSiJJiu3LKMOCaO02Zcv+Ms8+vQLt6o55pybyO3EKY3Az1Fu9PvOB3GEz++bsun27Er/HwCZBgl8ZLj4C+yWqN1E9gmxXCapAPxRjUftx0Vzf0Frm/f09tBhTuUwM+oRKVb9p09YmyH4HZZXMJ4pI/Hv/sLnzxM6CvrF5HTzPhr8KBQt6NR79nYExqZMZlw==
X-YMail-OSG: fGv2R5kVM1kg_xJK_.dwb6p.im7jSADU7DsvYp0O6tNZvAEcCRsu0O_p8178qIs
 _9jkbLeeIymvRghM1y8i3clr5Yt79KCwgdf79VkTR1mvhnfZxOiWIIBt2JAulo0NY3d1FrBnC6nf
 KmVUDDSg.6.l56wZlydrnPEsi5XhFgK7eDyYQkXmmtPX1KZto5JdaRKyqXjTr1DTyOIR.D9Dk3zY
 Vm6KSdCbWMcHtcbeOWe.iUi8Wh4bL9wg0JOkqMtyDGqIqzO7nqaXDsMIC_F8sm_.5QjpDTZ2D6oL
 hvefMDQ84dH__JCDuSPFyCEGSni0h209FcfGAkwTIbJkjKD_TQ1I7vzk9tLT_6GlomAh3h6f2cvf
 trtGOC0iJe9Ch13c538A7mEPwka_B0qa9CWUUSTcSFwIs691F8gqP31qbbcNzZqcho0CFQ0JwFzP
 3u8b9OS.HjmzppYKpbZBfZQZXQ04CLUCh3iF2AM.Sz_JUddDS2J9VNhieL.U3CpqOE8mSnQ03VX4
 nUxSPnITEViwYgMWTgHuVvsedKXVBzduOjFZ7_hSKPjCULLlekmJdX9cuV.WwKiLgplUp_3_Q1AQ
 8M9eYCsiKul9PF2Uwfe6e4DO0XANRSQsACHXxB0C75zBZAGBFhBIuheqAnixhHkPZoXFY5O1KQV8
 FI_r0acbRBvfgylKLxAhBOPXlFFL_m2LPL247C6XZRRHOQfnAwq7DmqDsoCVOrdYNmm3NAqOBhcl
 8Ruj_0kIx3leebuC.NZT6Fz4ab080j1OjF6g4cBSSfdas9q0byLHjRDygnvRLRYlSoKUhva2ygt1
 OmeCqzOXAnNz63gR4WQ5rvwbvvf_PVyBet3cB9C.S8yphjC2HjMaPAzXHxwl_6Nlxk.L6ndRqjNC
 VMYmvPEFu4ho7YUrPsgkC_bt8IWr81Y0WYfhnp3XCwi6EavqRv.ve93d79VOJYFqiYkszYYzk5EU
 nB9quY09CSjvwve8u31ROf8WQMHS3Cv.hopkJMxAMpZqNiktQHMddL2h8UAe7B7q.SYU6yh75fdF
 Wz8Hsghh5tmal.ZUUwI5mn5NBWg.xRtg1oV13YCnToVvFA8GVfGmwbxifQj6NLLgs1xCGBjTb61q
 ucP6CLxqM0M1EGd9e.hKjRnnvlKHo_1A531wCVU6jrDrIghLQ8J96Ta.JVELjI8hxCXT47783j5C
 3H7uivrslpFaEYeCNdaOJYvD.rRX9m.bs_O9mKYdHWHNOROVwmmPc5xXVazcIyzee.MVt6MuFqxM
 RUYtULJzPnhYJ6yHHExthklO0RculF9akhNIJtk1SYrr7HIFJuu74AWDZ9IWcWIZB1XQWm9PHGqs
 XLNRzHWdJY02Z11XHJW8kbkxTecKM3iALXPhIqkX0PiBheK92Fg7e_lLX9dfJuFwj7XnhNKqE27.
 UFt.mMS94u4W_9IjWXkVS3s6_8jMBWIQw3lIS6tEkC2RLwXO16ceGuxfflybyfwycZ3UrCMQY1II
 qzdvL6f8EMQshTl5d_B960kw6Rq34_oJVKXYxXQMkMmg5xdVsr5S96FqnbZq7XfyJkHOEKaqQYtV
 y1EqaQpdrGw6HH9gw4i4XRCQP2B6ARHOd9TJSAnL47_qUKLYOkoOUwWgmVATNbtH9dNFVryKY4si
 c9g5pzHND.zhajUXgI3bzO6W3pfOVd4YIuZUmk9TPUl.4kk2SpR1G6JRAQnD14QA_1Mw9A6zMUrB
 ovbu52a387w870dajs8a5IXLVT4SAW_AUEEQWVSbJEf7Ev8T0Mh.5HmiDZ0D0P.M9vE7G.v4OFVy
 2r2InO8Zxq9LLCgkM8X1fW4TJmOneCV7YBhp7OOOM4WBG7pYPTAxNDGcd9U1iyE7J4UYQVukxwfp
 PmlExQZUZyqnvyBLz_fsICiHcHry3V64XT2syJsy33DzyZPCIGltZ_3YROPKfwA.XQ6mfvo.VRPS
 6W33usygF0tH.sLSrkFoTTCzW2Ckk.xVVq1BDKyDayfaPzHIUsP5SCK9lWk69pmGFaDvrtSg11wN
 98Aj1phuLkeC518xoy1OpZdV2xA1qglBV84kHo_vvaW1qmrg8hUf4me52EcZF2Wghy9zbJWLugYD
 4NYoeMabzgPG7E8WzumEjmLgRIAgMnra7zoc9FtiUY7DkiS56nmjScYukkJAwqRYZpriw9fQFp4_
 8ryDW4.bb0VSl3m6L0uuvvQCCjgGePQUaNeSpZ7iAH6epQM4A1xEJUsCkA323pTBZTNZMBI2.nAy
 lq23iLAFwNmBTA4Y56rFi9w6jcbawYMzEviYcmlHXkOOR878euVpmIQyZrhbZyC6TXfRGwP4SWii
 HdWiDWT7KzAiuiCuZSaSHmDY4
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 444e4b96-56f7-4f5b-a7bb-2b756b76af81
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:31:58 +0000
Received: by hermes--production-ir2-7867f454fc-kqstn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32d47a946aad3f7d203db987b930ba8f;
          Sun, 14 May 2023 12:31:55 +0000 (UTC)
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
Subject: [PATCH v5 04/10] mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
Date:   Sun, 14 May 2023 14:31:24 +0200
Message-Id: <20230514123130.41172-5-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
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

Order the register blocks to have the masks in descending manner.

Add new defines for constant voltage shift (RT5033_CHGCTRL2_CV_SHIFT),
MIVR mask (RT5033_CHGCTRL4_MIVR_MASK), pre-charge current shift
(RT5033_CHGCTRL4_IPREC_SHIFT), internal timer disable
(RT5033_INT_TIMER_DISABLE), termination disable (RT5033_TE_DISABLE),
CFO disable (RT5033_CFO_DISABLE), UUG disable (RT5033_CHARGER_UUG_DISABLE).

The fast charge timer type needs to be written on mask 0x38
(RT5033_CHGCTRL3_TIMER_MASK). To avoid a bit shift on application, change the
values of the timer types to fit the mask. Added the timout duration as a
comment. And the timer between TIMER8 and TIMER12 is most likely TIMER10, see
e.g. RT5036 [1] page 28 bottom.

Add value options for MIVR (Minimum Input Voltage Regulation).

Move RT5033_TE_ENABLE_MASK to the block "RT5033 CHGCTRL1 register", in order
to have the masks of the register collected there. To fit the naming scheme,
rename it to RT5033_CHGCTRL1_TE_EN_MASK.

Move RT5033_CHG_MAX_CURRENT to the block "RT5033 charger fast-charge current".

Add new defines RT5033_CV_MAX_VOLTAGE and RT5033_CHG_MAX_PRE_CURRENT to the
blocks "RT5033 charger constant charge voltage" and "RT5033 charger pre-charge
current limits".

In include/linux/mfd/rt5033.h, turn power_supply "psy" into a pointer in order
to use it in devm_power_supply_register().

[1] https://media.digikey.com/pdf/Data%20Sheets/Richtek%20PDF/RT5036%20%20Preliminary.pdf

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 include/linux/mfd/rt5033-private.h | 53 ++++++++++++++++++++----------
 include/linux/mfd/rt5033.h         |  2 +-
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index b6773ebf4e6b..0221f806d139 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -55,22 +55,24 @@ enum rt5033_reg {
 };
 
 /* RT5033 Charger state register */
+#define RT5033_CHG_STAT_TYPE_MASK	0x60
+#define RT5033_CHG_STAT_TYPE_PRE	0x20
+#define RT5033_CHG_STAT_TYPE_FAST	0x60
 #define RT5033_CHG_STAT_MASK		0x30
 #define RT5033_CHG_STAT_DISCHARGING	0x00
 #define RT5033_CHG_STAT_FULL		0x10
 #define RT5033_CHG_STAT_CHARGING	0x20
 #define RT5033_CHG_STAT_NOT_CHARGING	0x30
-#define RT5033_CHG_STAT_TYPE_MASK	0x60
-#define RT5033_CHG_STAT_TYPE_PRE	0x20
-#define RT5033_CHG_STAT_TYPE_FAST	0x60
 
 /* RT5033 CHGCTRL1 register */
 #define RT5033_CHGCTRL1_IAICR_MASK	0xe0
-#define RT5033_CHGCTRL1_MODE_MASK	0x01
+#define RT5033_CHGCTRL1_TE_EN_MASK	0x08
 #define RT5033_CHGCTRL1_HZ_MASK		0x02
+#define RT5033_CHGCTRL1_MODE_MASK	0x01
 
 /* RT5033 CHGCTRL2 register */
 #define RT5033_CHGCTRL2_CV_MASK		0xfc
+#define RT5033_CHGCTRL2_CV_SHIFT	0x02
 
 /* RT5033 DEVICE_ID register */
 #define RT5033_VENDOR_ID_MASK		0xf0
@@ -82,14 +84,15 @@ enum rt5033_reg {
 #define RT5033_CHGCTRL3_TIMER_EN_MASK	0x01
 
 /* RT5033 CHGCTRL4 register */
-#define RT5033_CHGCTRL4_EOC_MASK	0x07
+#define RT5033_CHGCTRL4_MIVR_MASK	0xe0
 #define RT5033_CHGCTRL4_IPREC_MASK	0x18
+#define RT5033_CHGCTRL4_IPREC_SHIFT	0x03
+#define RT5033_CHGCTRL4_EOC_MASK	0x07
 
 /* RT5033 CHGCTRL5 register */
-#define RT5033_CHGCTRL5_VPREC_MASK	0x0f
 #define RT5033_CHGCTRL5_ICHG_MASK	0xf0
 #define RT5033_CHGCTRL5_ICHG_SHIFT	0x04
-#define RT5033_CHG_MAX_CURRENT		0x0d
+#define RT5033_CHGCTRL5_VPREC_MASK	0x0f
 
 /* RT5033 RT CTRL1 register */
 #define RT5033_RT_CTRL1_UUG_MASK	0x02
@@ -128,20 +131,28 @@ enum rt5033_reg {
 #define RT5033_AICR_1500_MODE			0xc0
 #define RT5033_AICR_2000_MODE			0xe0
 
-/* RT5033 use internal timer need to set time */
-#define RT5033_FAST_CHARGE_TIMER4		0x00
-#define RT5033_FAST_CHARGE_TIMER6		0x01
-#define RT5033_FAST_CHARGE_TIMER8		0x02
-#define RT5033_FAST_CHARGE_TIMER9		0x03
-#define RT5033_FAST_CHARGE_TIMER12		0x04
-#define RT5033_FAST_CHARGE_TIMER14		0x05
-#define RT5033_FAST_CHARGE_TIMER16		0x06
+/* RT5033 charger minimum input voltage regulation */
+#define RT5033_CHARGER_MIVR_DISABLE		0x00
+#define RT5033_CHARGER_MIVR_4200MV		0x20
+#define RT5033_CHARGER_MIVR_4300MV		0x40
+#define RT5033_CHARGER_MIVR_4400MV		0x60
+#define RT5033_CHARGER_MIVR_4500MV		0x80
+#define RT5033_CHARGER_MIVR_4600MV		0xa0
+#define RT5033_CHARGER_MIVR_4700MV		0xc0
+#define RT5033_CHARGER_MIVR_4800MV		0xe0
 
+/* RT5033 use internal timer need to set time */
+#define RT5033_FAST_CHARGE_TIMER4		0x00 /*  4 hrs */
+#define RT5033_FAST_CHARGE_TIMER6		0x08 /*  6 hrs */
+#define RT5033_FAST_CHARGE_TIMER8		0x10 /*  8 hrs */
+#define RT5033_FAST_CHARGE_TIMER10		0x18 /* 10 hrs */
+#define RT5033_FAST_CHARGE_TIMER12		0x20 /* 12 hrs */
+#define RT5033_FAST_CHARGE_TIMER14		0x28 /* 14 hrs */
+#define RT5033_FAST_CHARGE_TIMER16		0x30 /* 16 hrs */
+
+#define RT5033_INT_TIMER_DISABLE		0x00
 #define RT5033_INT_TIMER_ENABLE			0x01
 
-/* RT5033 charger termination enable mask */
-#define RT5033_TE_ENABLE_MASK			0x08
-
 /*
  * RT5033 charger opa mode. RT5033 has two opa modes for OTG: charger mode
  * and boost mode.
@@ -150,25 +161,30 @@ enum rt5033_reg {
 #define RT5033_BOOST_MODE			0x01
 
 /* RT5033 charger termination enable */
+#define RT5033_TE_DISABLE			0x00
 #define RT5033_TE_ENABLE			0x08
 
 /* RT5033 charger CFO enable */
+#define RT5033_CFO_DISABLE			0x00
 #define RT5033_CFO_ENABLE			0x40
 
 /* RT5033 charger constant charge voltage (as in CHGCTRL2 register), uV */
 #define RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN	3650000U
 #define RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM   25000U
 #define RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX	4400000U
+#define RT5033_CV_MAX_VOLTAGE			0x1e
 
 /* RT5033 charger pre-charge current limits (as in CHGCTRL4 register), uA */
 #define RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN	350000U
 #define RT5033_CHARGER_PRE_CURRENT_STEP_NUM	100000U
 #define RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX	650000U
+#define RT5033_CHG_MAX_PRE_CURRENT		0x03
 
 /* RT5033 charger fast-charge current (as in CHGCTRL5 register), uA */
 #define RT5033_CHARGER_FAST_CURRENT_MIN		700000U
 #define RT5033_CHARGER_FAST_CURRENT_STEP_NUM	100000U
 #define RT5033_CHARGER_FAST_CURRENT_MAX		2000000U
+#define RT5033_CHG_MAX_CURRENT			0x0d
 
 /*
  * RT5033 charger const-charge end of charger current (
@@ -192,6 +208,7 @@ enum rt5033_reg {
  * RT5033 charger UUG. It enables MOS auto control by H/W charger
  * circuit.
  */
+#define RT5033_CHARGER_UUG_DISABLE		0x00
 #define RT5033_CHARGER_UUG_ENABLE		0x02
 
 /* RT5033 charger high impedance mode */
diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
index 8f306ac15a27..e99e2ab0c1c1 100644
--- a/include/linux/mfd/rt5033.h
+++ b/include/linux/mfd/rt5033.h
@@ -51,7 +51,7 @@ struct rt5033_charger_data {
 struct rt5033_charger {
 	struct device			*dev;
 	struct rt5033_dev		*rt5033;
-	struct power_supply		psy;
+	struct power_supply		*psy;
 	struct rt5033_charger_data	*chg;
 };
 
-- 
2.39.2

