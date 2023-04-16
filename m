Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165B06E3849
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjDPMpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjDPMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:45:18 -0400
Received: from sonic310-57.consmr.mail.ir2.yahoo.com (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE514C00
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649111; bh=5w6Shyycf9TKW8fxiIBkdZ0V7BL6iy8PZMl/Ylzmv2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LrMztTlliwRbTv5z/JWofG7LAQ7iak9yAdRU8G3DTgkEraIz/bTFMD8B9rUohK2vf+2kRmKB05fPtFyY4edRnNDM9J1a9jaYbd9DCPJOYISH22VRlSFQ3PNP2TWROT4LM+E/27kiKPOSZAK1d/6b73D0f5kOW/KJ5mZFb3PPGMnYr8dVeUI61okTmXlIqstvS73YUis1SMVfw8kivFShN/FSjHdvD/p0cZw+aYamdan8aMuwSpVttIPX6R58qgsalh/xia7TYOu+EsYYdGMKTZOHVjUQnhvZGmnjxtzllpgjDO6nXjLu6H/P5tRl4RhX6YckB/1I/s2cbeCNBsLnjw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649111; bh=6jNhRSkwjwcNdOysluK5MECwQrmE27tZ2YUS6DdYuC6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HxkliYZQ+UEAaqTKVmWF1wo9NSc+mY2B7E9Nm/RcQpcGEl+2ClqQuGakk8s2K4Q6kxZU6Wtm/FFG/zVDm4WB/+dOrygEAz0L27SuVVYBZSISWvr4RaF/M3Zl5daHlJ3Z3bsHHLjnI7za6uFDSNrdzOzhhDf7xncv0huA9S347bTRwcKxO5AiIPSLAOD+5Ks4fIA1u6ZLe7/wudPF5nxzVQhYouZI5oQExqrd4nP2omIlpAtb/poDmWHImtvSMob8Bd1fkpQwOZbqLg4nDwPrZ7O2msyyv4oDBE2FjsMpY8Oh/M7TJ99ab6dvprDYaavrh5yRQHKjl3zJY66a/Y2sBA==
X-YMail-OSG: 80cIE4wVM1l6d8QFJAP7GwTQ9cVWNQxyEye6eYPKht4pV5848pUWVCvSZ.iT_g0
 uhms_iuX5H4LwdCZockrDzAPf6GHiInciAVOaTdQjVcXt62TOQjyMM7Ipjxf9rkHp6xtJb5RNUaz
 tcnU3N_YBeWgUT163dPKF7PYxWuP2RjP_IJJ_I8IlmFoeR_eczQoyaER2gpGQGg3B19U_0ca_Fhg
 hRoH8knmwfZsghLmySlwuC9eeEQkkjX2qz.NkM4IRxSkXxsyo0Dvy362p8Y3GHvNu8iHFp6LWF.M
 xnfh6O83UJ_wAxTvjrYyyJagaPKtXBYIs5ZlkCPZ.hp6rXhanIl.GhYhednkB4.vZBohHJOuwb7u
 I4ixZCM0tXMtCEyHR4zqUUV.RcWuvR4VNeCJYkG4ORoxs8IdPA8ggad.NxR91.EeeBH32Fg5p1wK
 hoWR10H7XCornOogKu9sT7vQ4.v0uMixQWV2yU8b29ydsCokYCrHp9lhRvOD_fL8n8MLEb6su1FE
 NIeIL1FkXJFSDqAZrzJxQQogUZYrClyQLfspibUFRUIZYa9bgTpz1KXLvsIaIkPIsI62gR6MR_OJ
 RXuylMhwmvrY60wtTVFwR.3jUlIdSIWPfG_BudaoLoo4W0p8DWz_zshSMr9fn41d7fNPQbeqajNQ
 HEqCLNp4c.u4G_PmSxx73RnfC2ztm6SqpEfqc_TDu.MXXfbGiEYIEkkUIhadRrL4TGS06Id2QHJT
 FPC_.TuTg7OgWBGk7aZFZ28GZgxuVDseHtziJNaQbqqQQu6jVeYvrtFcUmdmcYw2A8ZOYF4_SG2c
 zGQKmHHQgRLzvMlMIQu3YAjpmbG8dKnHNUllmENr7mvJMhz7CJF1.kXfDY5sAbT8dtpgzC5QBamE
 cgBNVKhH8Gyo51T7vVvYk7vrCXa6sMHOySQbdIbV8rdLOpK6qgRfLExx06FoO8WscQOoUwXItWSN
 u8LHEF0nJmy_eBMsjbsucWeL5CKl_vgmtlbSxV1.wO6x5YPRUprhkn708vcvUWPJ0bjXof5X.Ip7
 4.MkuilQ9sLBrQTzBMe6c90aKL1F1MtRfZHy6f7gv0YmYEh98K1FQM2TSjpPsWbQRysCu._tGnX6
 e4aLBF4wvLSBCzL6Kn_ZO5NjVx9lHZjr_xiiWWFLnCptOlb0_SFm_OeOQS380.v_iXCfeIBNFENk
 LUvXcOd8CbLh8jQX9KhH4XPSAABLaNPS.fnEDRoEyi4SyMP8yYF6ARauWsXOTtgK9e2O4x4INUeg
 9TKzPB5QHC7dPpx4ax6XS0NHyyi8UGUcsb.4kG6rw9yGaZkDTo3gQbtpx81a.sIWr.xm3JuGUlJo
 gfQ8JDIBkXuiXireTPVNDgVgeypCt.G..2glJSYeU9a5rVoluf2b2vY15y3kwBYrceuxgZ7FD319
 j9IAc31w9n9FIHJqsP.iC2i7sgIasIMlkfb2DDKad2kbzZ5f__hWRQy0TJd2hHO_e9OYPYBreyh9
 pN4Hmgho6F9jtTcg_tyZq5ibN50S9qMarWKEVTX9rVo8KOvOY1MO8mZU4DaebL.tcPpPDYthyuNn
 7QBWOpeDMdlxnxC8IDQr2Z_T6gdLGXdR8sI70m6gfZcy.HGdmM.6_Zcl2VbCKRCuEZ0KZyzISRNq
 jfMr0b1OYhYlpWrAX2dtP8ZoUAPVbbON1K.KeK6Ry5njmc0.jr3E8KVFeeDHfSZ5wOufqtAx75gE
 Vh9qn0n9MyArN7QvoVFMs858_ciIJO6xtkgpqGuFcqxfFhcnTzh7hQ6JxEEoqjn_AAdXuHw4_uGz
 R2lJcERbZLL1OY8am4MTVFwPKUCdNqjDMXUSSPHRXtypdMhC3XZevmEGaawd_PwLkW6j7MqS6cHX
 m7SO8.1kzhBQyPW82DUtnU1wGcaxyqN6vSF0zU.qq_xSBuVOBs9Qa9PRWDqqXPqy7L5BFNdWR3v9
 Bo77_rICF8.K35tBsolG47IRZaHQv0azjs.O.z9l.fj2B.GUQSIaZcUJiJw_xN65YkFj5luA9HlT
 1Ymc.YViHE9c8XVYGfePI1QIrzSGm3i2p3yEyAH9FC3QcJvImtJRqdMcdd1XSYGNqOLuAKQ4pRcX
 CmnFhqWVy5pk1n0.uV3hA2URVNHda8IKrHf2CCPg_kyU6NVImAd_lK596mL93vS2RtyPWUT8Jjv0
 6lUYU_hU8ARhaytlsOq1jL.8WPwwT7KIAUaI9r.GRIxYUwIcwYYWL8qyn4zsiN59W1HMHPJDHljm
 W15kiHmkkLOniMOAgMFaOwNe1F3AtWduU.Pbnlm2ftK_3HKkDi.9VvZtHeGQBo3_Yi0Ff701xubK
 C.3T9nU_NprSLmCGisVoKLgIY3ePq4.VDzwIigV6y0RAWyD94
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 7428be8d-47e8-428a-9d4e-c25f9104e0c3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:45:11 +0000
Received: by hermes--production-ir2-74cd8fc864-4bl68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a53f7a8722383f9609d619e4fab1862;
          Sun, 16 Apr 2023 12:45:06 +0000 (UTC)
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
Subject: [PATCH v2 4/9] mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
Date:   Sun, 16 Apr 2023 14:44:31 +0200
Message-Id: <f309f1b68a33ccb9e6d1c20b577a545b90af1f1e.1681646904.git.jahau@rocketmail.com>
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

