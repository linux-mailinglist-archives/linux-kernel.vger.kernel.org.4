Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF586A6282
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjB1Wdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjB1Wdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:41 -0500
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD7721A1C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623608; bh=FbVYddpsZyZOwFt1hKP1uV44/imXC63D+WJnMDA/Y8Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MmsDo9sxW1kt9LCo8hONulayMmxkVqWrNG9JFuWr3LOm1QOktSPS+VpeUcHKn3J0ODRPE+7U/3hP2I/mUJxgksq+pZaufkCCXeysBJGjp6qaZJH+vKYvxR2H97CGukpJuhVRcTY8uJ8lRn+R7BlOJj0226DXIxAw28gJV3MxJyURjzZ9risDdbeWYMWsiN3Dtm8xgvkrj8eAwSzbUtK6g3nZflfOJGFIoJL9XPFVyLLUctorhU7K4raA4FvYxPKRbraXUULoM0+ZN0jUxyFPHSxZzbwqOgg6jCCPBDDy7MJeLns/zscbQuOkNr3sKjQB5SI686CJqUSwZSVVR2c0vQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623608; bh=YamGTgELO1bXYBSaWwTaMGBBLHmCM60U3zDykLCNPz2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UbCk3ur0Reh7ULQ4No4s9SSF/nPyM1a8EhfH++3HnxuJorQgYY18AVTy011kQKKxLo8e8gWeezFJUTXx3zdO1NarWpcXwV6MUzER+v3XaHmPRil3qYGDt8YaIZoYIGt1f95mUMjC6gDRny2nHxNqTEozB98qijsWKj7fGhCokjRuvpK2ugQYBaw+SxGYa8f1jRarEWCSjpjuJGgpo2g4bfIXEhVdx6Ptba04ivoiZq/Zqc3J6+DvXK7L4WvRN/F4jl0K0fcw+SIlCha83rdwbsqiegetnOY8MpfLsPZb1A1XO8w42+CxaRF4gFEkmrP3FAGXCXsDLlpazYqJy9fp6A==
X-YMail-OSG: F1gSIZUVM1kaNk8M2Cu40BJD8C_87G1.9NuQerxZjL1uCrU6omdSMcQtCxZVNU.
 VZGSUCVxaT_nqnRlm.vEmICEEEeENA35pIZdogMfGauN_EoZJleTO.GetMPaMuTs045vAtnSA_wn
 m0f9LCsGrm.MhdrY2spYw.HxzrXrDGNqOKdc5lUU02RLkHF6DhE7m6AABdaDqQwOBjlKHwpvfa8u
 iL.JwxMHkBr3ryUwxv8vjngO7YZ3qiwjkn.l30_ajxhcvdZFq2xudEnuijqM19xAYouNan2o_IIg
 mxQP5KkHMYC._Od99bn_CU_PbpD0zWsHxxiboaM.neW4SVhdTGK3KM2k98WbCfI7pLpQlEig5dhs
 OLr82wVFpnhUS6Fhx21tMz4oUBQO1NkVNoJ6xMapNdkBA71BWMVw5CHSwGRSBtDkO9Rm_Sbp2byc
 TA56lYPAuWUDDX0JtCNwM75bV102Af3pGCwCMfqYhUfSZc3eocpQ32nO545aMwU1k.wExUuhkK0S
 QbkseLNsWfN2WopFCtIA_oHIAJFMbGhJ42RkygDXpDV3KrhZvzOQ_HLsA28fl6IFecipyUT_WV4j
 _YeA8U7UpoRpZvuOcPgw._TFF8qGTqBUR6xCwbsnqc0gcAlnO2eqzVlsQn36WZPt0i_65RMLHt85
 CIwsFU6bV1uxIoHGV1XhAIND.IkS7z5X361mTCgKpZrOfBp7f49oDni8Z_RsFIxW.bELfeF6weD0
 eyd7UQQo1wym6AVJgjWgsVLvyicr1K8K1CLwlLtZnxExBeHeJx4Wrab5aLVBrAun4wi60cuzRFea
 2zLZIjlxn4.MiSsIalGZHRWzZC1Q6Mxfvnpq1wgX4XFkYJ.DwyftGNcz5lE8jx56AvbUM44tBpCF
 P6AhYJb7tu5FJrVV0ED2CwSvdAsb3goVPRvn0ljet.sMfZoCAZnkSRu5WXT8UKmOR_tio.qDnBz3
 6djIXXQwiW0OwB8sMgVgl9LZ8gisGmzRX8aLtAb2o3K5pOaY5GC1UoqZBLa8CUUpAmjp5Pnd84R.
 ioaj3cRf0CcuOdgi6h24wpw.56DTpX8z_6CJmfQvgZN8r09LzVD5drtD4wDQffGGXlSwdmoYv3xU
 tXUJ3yOPksosM30NqaY.SC6KL5G.T4mNPMHDv_rTYJbRA8nhgavvfgicSKVqL0F7Pq_b50LG78x5
 rMA5JwbiBL7tL1mt108_6pOftKO_j_t0oA.PJvYofmsEAE27crYxdElpXzmtwLEbobTYTYdNiClQ
 nmhenHgFt2grgQIqMl58UuCfkSr0f8x2BpNQ0JNnFKDOaGIV07uVjxJ.ejso7zNUVEAfDSPpA1It
 4Zzvm2XePalY3IUxK5JizhsDWsY7OKLnwsMlz8pC0hJubGYsXP84VAGfyHxe4UzSE99xnxWHDxOW
 D1q56PpCJw035exL5cXlDwV5EiweZKDSsO6.i_RETn9LpAaJRkQgR1bEFKirhbnsQvGBKiVERbHH
 sWEC6VYva.ByEG6YfOC80B7lSVcR1Jw3upYcawSTkqIkTqLMaAE.LkT4oxacbcS0r9tdh3dWpBPU
 BD9txeNkwnRYl9XdfPiaOFmiCai_vMpyAosNHcNPIvnXK2KtJT9xwEKYcQkksWht_gM_FBdveBBT
 77.Ecw8VcfohAUWGyGsL_0Z7NvPC9Gn4wuwgO1KCvAMfbyvJdkLgHlgfMJI1wpQpdm1O4DSuMSjs
 3gkAmRhzRM9j7vrkvIip4yq.MvYpBLTLvsFNCpvhLpHhs9UsjGOGxAsUrVgSyHjDdLQilpAFpPG0
 CBYyvycbBJjtHp.dL14D0MOcnR7PKH0Oy.pw1JjrtE8xXRwHy3FXNoc8Lx3Hn62L2PbMJN7IWa6Q
 rsUBuUmHLK.ipX_cH1rmBQbvScCNXG5BnIgSMyv9uvu6F8xJ7QBq29WrxjG6U2Ejk6u92AQMrmrh
 W0ll.gYvjeWFZWSnbbNIL2LalDrZe6SZJgmKuclrmftT0lXM47N1rwmKPlJGmj4VQWRwWYpcHZSs
 kvo.KkuSTNe9sM7p6pnGOydWf0Wsogqg_HSjcHyGm4XIXBAPHbCAubw4ESt05vapPEzPhBi3rjUd
 1DfOocQ7P77IlwsBciD9OBWf_paEQ_Ki4sBhcJ4r2aJ7ruSPqsmuXxCXzg2RSGmFJZdX8JIhx_RJ
 vJQW._B14Mc4douJXpvQuRh5xS_pqXPfNPnhjhxH0MG8SYPERE1BpKZhMpNq0y2hVQiH9JGOMEBc
 mFmJoi1NjR1Na7qw_hs4mu.NWAIK7W2HOFHldhjnNHy9hAdJrCu8s6KV35jmDaBWZZ.VGDIrb4ya
 Tk_5rvd_W5j0M_OkzPCvb27BBdEc0OFPVeO0U5f2YH5gy0XI-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:33:28 +0000
Received: by hermes--production-ir2-65c64dfd66-lx9xq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4362ede20d54ad479836919fc460cee8;
          Tue, 28 Feb 2023 22:33:24 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 05/10] mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
Date:   Tue, 28 Feb 2023 23:32:22 +0100
Message-Id: <4edfef7fdf129185355d4dd2d3928d63c04bac73.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.39.1

