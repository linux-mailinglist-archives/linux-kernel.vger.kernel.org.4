Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A352703E37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbjEOUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245012AbjEOUKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:10:35 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0957C11B59
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181431; bh=5w6Shyycf9TKW8fxiIBkdZ0V7BL6iy8PZMl/Ylzmv2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Afomw2TGUomiaZXermbeGsm/bAJx/ORkWBaZ5zuegNCGycqqRm49Mo6oMuzkZEL5LKpRe+ffwpX2cbGL0jaUYh1F5po7J8PgfhinKaHmjdoJujKTfXSzF2mAdl8L8Y3sPxbmNbQo53e3TbLOy0iCVUM1dYLU4gHY0Hord9kNURO66/gF1E5n2NH2oVxfkktmkSWMx8tPUlVfMHBeKlGo5YAWCerkONDBmIONa/8V2qQZvh4v4SOYZLGMcyBLNe1/hvQpvj4im0OzE1CiYaoiVlrBMm3K56xKlxeCOTY1WSDxmiYAUKi7b1hAF6VJc272eGcTH7DFx/cRuXoRw0RIHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181431; bh=SaexVcmz7XVOSO62Bcfswh2TuQHFO7x5SjaaSjF89vI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sejbvsFY0EiUxwv2U2558erkD0X1BwGvSY7rz4kyxjIbmUgqUDf28HswsKvXHtlGk9YGHsVEPi2wICUz45XmFzQn6CRC9tfbfus9zK22G5YAyCmOLgs/oS+eS7A7zbzeevqQPrkVyBe7nFq7jgXYskkfQL8LQOZd1050skQPVsWbXGJGPwl4LXu4DNM8xKfM4WSEfwZYlzu1NTgq7WE6Z3seNISatb1mDGKVzzPEoG3tL6ot3phrA940H+CSt8eRU80icXlw/M6hFt8Ch3yqi+tGnpilomMg4+jL8t3ENzZTPfqAJaFngx0dbx81WdG01b1ZdD27oi8TnfyTjaFBMg==
X-YMail-OSG: ld.6Pn8VM1m8CUgFA2RbWvtKD7N2IdccHF4L5fhxigIDKaNl3cnVuPJFFQLqFXi
 LliripOquFf4tuAd_c8dML5IyEjYdZ_QBhFjTVx0lCZnV19NLn8MHvzp3B7XKUsHPTeeiQCKRMZC
 U0XdX3H27zfSDp47YyWM1zws97U4hSaGFMkdYWBP651srX6glEjCrGw165Anrrfm31tOagQ.KEj9
 .aZ8gFFOKbAMm7d.XTD3i0.KVlBnnSjazMZ.peatwBUezUohUDYDp0bTgo7pNgmb2Gd9w.UnUH.a
 7EcXG.jRfGTJvHgAcTLhxwmO5ohr41Np_vor9ZSXVc6f5RSLlWrZo6x35a3l8iJmT2ESOLujpwRc
 0B8y9ydOGAWfx11flJW.PUWPjFmbLKq5iLraQDfrjvY.p7Qp41muPVVWZd0NPe.vIVRxGJDmUom0
 XtfkIIgr97LPnUTyhDmyvqBQFO3zDOd_ckGWl0HWnNTiHGoMwtqq2kFzKPxbpH_XJehgSogObRYB
 hZinvvexGklcpP5LF_35sOxhEJ7CIakgXU_SiAupQgS7UDgOJeIo_pPb6RO1loIWWDcKR_z28Gz0
 tQSR_HklebA4KNFQKAEOLIGXwXNyhGPAMfdqi4sMx0XmykzGClHgtucul6OCvQj1F8U58XRf0lg8
 glRBk6zt18PHI32iHEqAFpI4SD8HVhhW7EvC3HYKanpFaH_lgeVtRp9seCFq.pGRIaqKrFwV8Z0Y
 7rYgnlNXi5TQjJUMagKgasIj9IgnEmhZCg4m9pqbJJh1LQ7mbUm1sfh4Qj08ZzTjR5YA2LIFGhzZ
 qBoytU5krFRj_3fpu7YhUTXOU4RXeZC56qRsRyDX9tSKyHC8nnXZ03Xrshu9g3pDouzo8SCITL46
 RwDOr5GiQ1XzbdotiMU4i3GscarGCXm9OabmbY06MYmRISTz75hFl.CaaRJPVlH1NGV6BUtebxjf
 YO8EwCZpxL.YuLf_SuDU.Ym3TMruRwE_vZgT8M6pIoyAdMzbjEI3DAfU.L0Sxn5nX0L3dnTV7nUk
 RohWnLtPH6VX.NTskWT5nvN9nmO9IUID5ec3zGah4UdIU5ETIR4._hA1GDWngFtHNyPzksyUv9nQ
 jX6UbRxn36ngeS88HurXgzHqFETctAa35.rBcNVrqpBC0MDWn79jIPEUf7wa3YEdiaBjG3k6RYbn
 a8TVi3C3nj2q7A.NuM4yFr3VT_KOhpdEP4kSnkIDBh08jQMqmhPS7HPZMZRCWJVpn9Yin7hw8dom
 jnTsAqh14tFQ0Qvs2SysR9oO3QnhnTI1qi95oZqV53lQCznftDqndogsJz53V8HC8haJNJIze4rk
 Uz2KBOPK4WDPo0ekmbpPTZ1Ony1FhJGOoXJx9R6tditKw2EW1hqO4p9FUFNiRGF1Kfyvbks.uVFo
 ttKyruuww9EngTvTXHK3VntQX7_sSCU.SDxDxREInkdz8CPmhOlKJTNxhkcgdOi7bxe9xwwrInsP
 bFB.po9sbVRc63BD2pCT_bA7mZE7VReMdfCsjJfDhkE0etyxgUgAsd3A3CbMDJpNFXxpwOpeda9B
 UHedwJBgrURlv3bLcG7hWFy1O.e3_IABayqBVc65cOPCe3_p8MY1ZVCusrZUM6LrPYiMhrqB4zCt
 FNuiHulIujQFFBc4MEQItnYjN_II3HIOZfO59yXMAJnQWdnTIuHFmhLbJ7KB8o4OxBGBeEhs9vLK
 IYWcPmTGCy1YqP6jGcCvtxULQxonFwUuHZGUwSk7EVw2oMZXARcWecIVaMyucc9ZGMvBfL_PrJFs
 05qr.auI9LJpily1KLXGGIQQfSzT9JpLQYuELOOeAPaCxcusEaWCe.fuxyCtwXHfpZLsPbXSSwRk
 6yfmI6JcW0Z1N73masObcC4xngwTqAKVU_Hs7nvhXzhuIcT0QsfMKojAYqUeDkz6mp7d.eRwjQxm
 pIeJXb7lNO8guUGqIOu2jNFiGATci860MQDRZTWkoX6gwzF.eejnlV9RyMra9jjxnLR222qWeqXW
 6uofKiyhEt652Hs_NVtxxA86KlGDB4OZqyjKdbOQU6A5p6WxS62M_K4KBMSaTSIllHjFp.Xy8wzU
 isYT6BBG8fP1NtKvp4SFmioY2CwNlX5DsQXHIJLFWWoup.iCEHNNw0H9t2iYWsezGmSFcywKbbYo
 bx3GaVURlYG9Y0UwcYYpGuN3PfrOIOX67rStm54irMa1ys4.KcQh_ZbZCYeZE6ZBcw3niboTTtT_
 wYTuKddi3yv9n__YWH00ECm0Zj8AO_Bywqcq3es1.F6in8_9pjpFjsaAF596sJU3ayOxWnGRe76z
 apcvu3tjL1K7x_1DCLZCc4KGADhk-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 7bd4d5d4-3561-44c9-9e6a-df1f12db3018
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:10:31 +0000
Received: by hermes--production-ir2-7867f454fc-nvr6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7905ff065b8716c1e39bbada6be8236;
          Mon, 15 May 2023 20:10:29 +0000 (UTC)
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
Subject: [PATCH v6 04/10] mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
Date:   Mon, 15 May 2023 22:09:56 +0200
Message-Id: <20230515201002.29599-5-jahau@rocketmail.com>
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

