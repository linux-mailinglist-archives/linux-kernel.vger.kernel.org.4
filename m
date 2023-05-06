Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00236F92F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjEFPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjEFPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:55:14 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384541A1ED
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388509; bh=5w6Shyycf9TKW8fxiIBkdZ0V7BL6iy8PZMl/Ylzmv2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WjtMOxC2dsc0p8kTu4GIcF/vXtuZBsBMCbO8EWRq3ppJVcPjvQfFOARAgqyccaVoqz8+d0IiP2Xkeq8e7qaZreZpx29YlfHfI8HZM5XDYL+vGsjXaXHk/UzgyBcSex4SaYqowIPMO8lB3130K8G7z68j3gTGXuOOSvvBf2CZNgy91zvcrSmaiRtiPwMQCwDonFVblKr6yZWZO3ypEGJES/QIkqtfnBkVYnVQXc6Etze4lkkeA8iXNnix75+zFmbpMJ0oKbrtWXEbfLJpP35pmhFBo2JMIc/1FUO/kwSQaPFY9+MeubDlqWaK9CdlQ5arxcVBkzN4Vtiwy6FoaENuQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388509; bh=E9c5uOZZSLSVF9QVsVRgo1wlJZnWL3QoMbBYCfuuE8u=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Z9ZSHZlQw80RO612hozs4Npw/c56p8xBiLPYZkFEgHAFtghqhecoTteZK4hony6YU73iBxMBmXxgNXUeBz7Dw7jA+44THAUxzPog8XfnqgrJ/cSmqvOdGrN+gMfrNrBryVEI2NZabyu9O9rMlzuOyKZ5JczrCyZxBIq1cVArDsJfvzQk8fiRHV9F8aL3R/+O7VXAE/StSouU+iTHo1LMxQyEK9bg2AdtwRafTRe9J+kdCXE4iwTtvdeW2+eotGPnnaLXLRmfar/mkQpbF8IncL1z45hbkfNW95uoygyEa6W2BKmDuUC1EOSsneph8Yh9ktpb68067djJEfk5sw/2+w==
X-YMail-OSG: PPmJTegVM1kyu8K6rSAS_0EHi8iB2UPrHkuOhb4rm4pjeTZ1dOWyQ6T92XEURKW
 zAIKafmLl5jlRlEFa7fhbgnd3j.AFbUgBepWQ2QQol7YWJ0y4dIsfhN_nxO4nzN5ZcHD2zmK0evf
 IdES3JvkC2jciZby9lf4os_VQYEE7FfeTKE0TdTaukK2L1nDeIB8PFBkEPKU_KIHm5YlYdTNeGp1
 O5plzwH7GZ6DidQQZjVu33zg.KK1g907wlO_TIbaF5DUUrwQoExqTiDQ904qFY596UKiBEoZhHkI
 .eH_4EDz4AX1aLYIsP7bi__sJigKScvDwS16vuQ78vuG3JxBmhPel4b7C8ZIKWcRD26dySI2njW4
 mNLvofbOYG_TTbeGIQWdWCRMHwA1JLaEXrz2N3AYSOBQ2KXOFpW8NYppJNhh.XqMMv3XkxGfPAeY
 CQHmLQsCYFNc_yZhyd2HIcwxd3jhAxDj9sIoLeEaZXRd2QNNeWlNu919HKH4PmKs2tcmnsQX59xf
 YPSWHDW9JhBxru5nHKyhZl6b5KBFNcQPTlwi3ps1ca.5170z7987s1PSoDobV.NFGCqLI5Nvy9dp
 d8uQ6LV_VWcIe0o3ASgzF8ougAS1l19iUdrKl98AAr7zDOv97zxaFNPM5IHZxNdneDYaoQkhKS4d
 O_6zC0Ee7jQRg5Er_b4PWxLRcz2w4cRM0Rh6Y0i8qNktZ2JpHZzyPO73p5Xqg_rq4eB1PP9At4Qh
 l7CDLS1DLmbawZ2vVM6z74Khce5bLkBDkW3_CDsbhv.sCQmWkPyLFyGisotWGhyBsbcFiV1JWY2M
 w5TIBc60xan8Mb1NyyXAEbsuiQISFMTqIuK_B8DZLSy_UsyvAcYwjQ6hx01Ax0RiGuR.I.UwOsbN
 DYp64JXsQeWCM6pfxeHhz7791jbjDVwBL7dwPA_VLSkJXaHTZYh8drJ2yEbdez9WCztlEBLXjRaY
 KWzrumShiZza3yGGBvRo6NIFDo77FECp4QHg7AmpBTWvJhbdqQM2bKnaECXxeWAyDRby6oUKcCvT
 aed7KnCwsOQZnK1MhHkuc4kTtlvdmJADOhswJPfcmNGo9BqQ7UwBhPr3QJHoSJ9r3gzRhfPnPuOS
 GAd1G5OYtrbsNBZN2EeDD7_ddV9M3wWg4W16NOBC9zvZ.r.JdWuuhICi_IFgEgPpXhQloJGvBuep
 oPzCaB6t4XDtjwVngz3czHpXgeiRY8NN._70LaEfVhqwWBnQdy4Os7CJLnL6AzMpJhDeBDUYGdAi
 o.9HxhAMibvlqHgHVAzhn.LJepTq4ceVRVBIN4b9BSF37sxRmA21GeludsfVtw8mKfyar.ptbUBt
 x1VsRTwXia.4iESv8OSS6ksCfhGcPn0AAD4Ub7UTW._z9c7WelV0e2R7qBOBRNw2mFCwn4hmh2Lj
 E7QOPTG7la0Gh5sApA_LE326uXgvQL4xH3xbT6xyKyiTXgx5tLW_8_08opnpUifh8jkkSHSrSbds
 zjkzCdcjnKSLWndOtXmVwC1XDQZPvSSdFZnM6rTfBvzII0TwtNOXz6ZFdmv7QzP_u.BNkDcVvj.g
 B7HsioJT_DodWHH7bdQCIXVtQjTuQHXxISPbiHd11Ga_xHWY649m0m4WtQfkG6vkoYDqHZnNo7Ds
 lgTst6q8FbD1zi_MEMP.qEHMmOgBl9z6.DDCNOSpEiPdb4KdW9Ix7AdY1dvFFu1iWr_LaLMe7qDP
 brP6aWNCcKGYWmG3gRWVMP6Vdzeodwp5YaF_zu252b08t8tc6XBkNpzi1Ca6F6QvVhHYqLkBgNUo
 UV3iMxhGO6JKkUexB_QXpreZkw_TKLLJYKSEfIezeedrQUQsvitqDi_bDSUwS9KgeH.WeYxlgwWH
 VAYtcAvuQDR1evl4CkH8PfWn.s3QZwNGI6YLnYBGh1BVmDuVS.1jg2l7rp0DBJyLuD0EZfhQ0Biy
 UCFpmzt9Or194YUQfuBrV3Fm_ULCDkMRkLifq4g5Zi4Vp2AcESpxzva.pLdpV9kS3ajYErYRxaLz
 LzUbL9ho8DxKoB7Zj5GmN3ezoK2muqPYR6wneiiB6O2gjKm1CwfLGNuJdbsxD2kiGplAa70MeEYn
 56KqyiIekm_PbchzpY5ela.Q8VSUnnem0AI_pJVgvxtsLwkP7rVeFcnVdQ70qZgonvcsjyv_TJ13
 N98bj1mogXNITEHpU5SyZDAzqjklHSJ1nabmRzOZr3viAKN64Zo.TIw7zGI8PG7WDsKovHi.5tGB
 DA8zssfXBJ.YU_Srg0UJeNtxYcMftR_HFwDrhrkuakCY354ieTCVL6uom_klnh0SJgSFPM8RtuaI
 6GfBiBJ3KFKUrTKge4EuJ7Fm5lO0-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 58e56979-5dc3-4900-8e22-1045e7b3417e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 15:55:09 +0000
Received: by hermes--production-ir2-74cd8fc864-s5qrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f796affa0781b2e3002453351a4dea5;
          Sat, 06 May 2023 15:55:05 +0000 (UTC)
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
Subject: [PATCH v4 4/8] mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
Date:   Sat,  6 May 2023 17:54:31 +0200
Message-Id: <20230506155435.3005-5-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506155435.3005-1-jahau@rocketmail.com>
References: <20230506155435.3005-1-jahau@rocketmail.com>
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

