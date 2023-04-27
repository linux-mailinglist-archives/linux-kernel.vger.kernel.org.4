Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765D96F0EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjD0XbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbjD0Xar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:30:47 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE5F3A82
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638240; bh=5w6Shyycf9TKW8fxiIBkdZ0V7BL6iy8PZMl/Ylzmv2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lIO/G6G0791liF6HsWkUX3fRrnRTeR40wXCW7myx4n1RJxqWB3xIK0ZPCazMbHMfOvtX1LVGIbh5K4l6GRxaA0J5YRJ9xJyo8NVfQvsco1Au8+0dWGkvO0bp/n1F3a5xB1BdtXQ/8hIn3ZeoZTvuh/sZYTO4nvpLnxbIeRFOYorbw6jF6jUoPBbcwDLkIKgVeXODshUUZwjVm1H6fvcu1Deib+P3ksqBjrHjXNeaH+d4x16SlGZ2l2MZrNLphg0cxxdpTuLMea8DiltbRKdOl98+gi0+DRC44K+jNopaxCFDeD1+0LBf45GQ2yO5qe+z6tYp1H5xnDuC/S9K+W2d0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638240; bh=7AwfMWhIcIpV+xE2e+9RfQ22UQGUhT+EcKvKOlDcxZl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KVhEIfUmooyuGQCXI8LlgZ0t9gL0MHbJ6QHXJzKx9N9MZTfqeMDQXfX3vJUGJmET/Oe8aAAQRx/G8m7th0Q9juaR1SFonD/3WNZoaXbhQtdmcBGeh6EiHVN5UDfeODDBCCH2zbfEe9u8hhqcgtEM30FsLpygTt5+T/zJCiDWKaGCznPflAFSVZ6lbSX0OaXlHyKFPAYqgKRM7mt9QZx1TWknQO0d0lqFSwpj0XIgy5k1SwgcUzH8X6cAmfvQiOzN4Jh/8NvDeyufwUs1WWeR6Cy+yezq78WsbqVfNZ/lYVnF13dQtf9pwBoCBN8CLoazOicV3hh7QwHsLLKZa5o2PA==
X-YMail-OSG: JQFEhTAVM1nVEnx7AGEET9qVTJY1EzA4MO1ecXl8CjOgeVtBuCE4qgCvJHdp3_7
 wStUaNVC3dv5fTgIL1uZiRYR40lwyKV9UYG1HP2BJYom8Rkoy7g27WzyX3juj9y7fypv0b6JbDvB
 USYiyUdTcJz1TAveRvRgW6mJygqiHjoK53blXCFObKxhO5Uec59zrIS7ZkGrd1Ad324LCE1HwKB1
 gQx46VXpuWOcnQnwjgNLH7swRNHRHTvRIy.S256ECsVPX3PdWFxfjmjrTeqnzyS_XymM75RcepXZ
 _SpcSgqGcmW4G7jPmBALat_gwKyGRGi2KsxYenmr2jrKTyhXQ7.PwouzkRMHYKO5ZxFia1tclIZz
 DKh8WWRl3s.Ijy5DEwUzQ9INpSlYB03u9MvJoj8RH0MnXFOS8QkN2g478YVTqOimZWJdwuL_YL6m
 oHLtmtAP6ZrpVgMKe923SX0EXdASHuTHB0pXE.kO8sAx7FLkTAbHic_qXPPzZrVpdpQI76XRwSAg
 BZ41sbm7LK_sFH3CaiAbt9Ak.dZO_6Le8UqxCOLS9bVnD5tYF1y7v.c6VmgeNy6L0NL3OU.MzNEu
 vVFTmy5bKm7OizUx2AyFmBB6XoRPdGoSJ54tusLRdSYJBDle.ezhI49xCJtXXDA44DYPvBq80wgm
 JTsd5oiFs5bSf6_xzGqhc6uWptuQS4_vD0ptwrpFuOeUvI_lrhqUkyUfpx9gBRkZeofUIfyeXMB4
 3KuX6mTm7OYzZJBB1cld4B9hpiN399lVUCMOJh5hBIrkpp9p1ZxWTMb20SaF3vQqv9S8zu_.JcjG
 cX19TvMX_wtqzd3oITXOH9PDJdxdin5Hb7BzNp7V_rtsojhvUjEweaLmU5_sfnlE6MgmHSmjFDPB
 ouEFrWv622XGl00Vxz_KHBnWoJbXsPUMPPJqBBk95C6SUERn463MP_p8061MzV1dTnCSB2Xk6uyR
 NpoHPdVLPHgwvuTZMaXQoWOHnQn.lrZ5mQgYE4FXyOr1OTsODJw4oXrjjZECfERGjb0kB4AiCant
 Bml97dCTZfzffj.P2aCX3FQH4HTiyTvfe8Sjk.enqsWjCzZOrBqq7ejk_99qKcD5yafKeA9EebyZ
 zk0NgNPKbwotEgCepB.tRDZFC_RKS2o4P73iREL0OCehqBbIfP0erBOc_4b7Rt.F.PvAZKGqPzDl
 nOHEGMdTavPkHBlfZDxDDljxR6zqjIWaqSOniTjXnsTMDVNEoi2nCbcmeuxd4I6HjwPt1O44o3RO
 9PpvlW0cAuKW4B8DhAP7fW1_z3.imXxRF.fXVc_nuQjBlYUeH1CWxygR3qC4I45f_PrGpOVFcHQ3
 16xS4xeuN6zxPcATRKa3HvFeUY_UdOuOVzyfVEhP5CijzUBC3KVWuwHvjIDtZk8yY.DsEE4BVVDb
 rMCsOJ._4M5zweG01nAYrCIeOyhZQCWVVf7ulMCZtpMg6EtzUmys9mEIafvW4S.y41uK09.cLrZi
 xwSs_x2bawei2kgnwCC_ouOiFXcdYFC6ebymEPEaZv9Ca0O6dNDcbYS_gvg_kuijzjj68w62krEU
 JQxSSPDlgQvfucIdEz1OUvc8ITYBy9M_tq0xe5oN.O9_ulaZSxhoKr114jJ_wgHdUEVkPrj4mn9M
 0FyVeycms4gmkgnp_9rIFKH_WabeO4CS3zWsGy9VozOpu8Yuu4YI2EF2m9jrFfngo1nKeRMZzI66
 pDmTMN5FqMeMEh_W2QnfgroaOX.Z27R7NHsEjY6TDJmZ4oEbCatsuAfWQvxL8v3ikHXDg.KJshYr
 aWBim1Si0p1_P0CTYqN6.rklnpZ1pS9sm7sfXIqNJuqcswx.kPU4rqv.NSzyiJXEI06Q0rwv_xio
 8FIqgxNXEfAzH0vU2iIIHlJS_9nXVCwJgb6ePQIiJHg1bfcSsXD5llTdevaOaZjkei.GyZLIXB6s
 nY3o8YX3pzuz6wc_PTt4A2AhHa1ySFV1NJ2lUx9r71zYRvnUSbArjcIM6uWWnETKfuBFuIg7Z3oV
 9iTzKtnJR2DTifazORl6ecOaxZa9g4x.X4l.mCy0aQvLtLkTZ8hHNZTHYpPVUjw9B0D0jipgxDs6
 i9MeL2Fzl_sPprwmyZekW2TcULxPihz2Bmb0mAByAiD9wVQt3xAqWRZwZekmNhnXNiycolAXPdKD
 R64HPx..OkMvmN5eaiABzU4fKrqPeynNbdziIIbEnSfLX00RSQJVdnMeqZ_bIFjVYGfWP.n3JKiT
 4bo6n0M5jz5Yf0FmQbF9a8Vti1SsplulEUHWnbVO6R9vv8O6l9V4ZNPIWRMBpu9euP6YxnRK8.cE
 be0Q39cXgTmAcSk6aY36bhi3B
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 0a167e92-6dd8-4fb9-b86e-24f661fe5a24
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:30:40 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 912b1d1a256b22e43f453e00130c1256;
          Thu, 27 Apr 2023 23:30:37 +0000 (UTC)
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
Subject: [PATCH v3 4/8] mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
Date:   Fri, 28 Apr 2023 01:30:07 +0200
Message-Id: <af691a402160887645739a5ad4ce5de0613b3d22.1682636929.git.jahau@rocketmail.com>
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

