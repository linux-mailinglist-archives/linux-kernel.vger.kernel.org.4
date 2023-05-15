Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92380703EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbjEOU5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245221AbjEOU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:57:41 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA96D063
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184258; bh=5w6Shyycf9TKW8fxiIBkdZ0V7BL6iy8PZMl/Ylzmv2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NLFFXkeqPxyYUITxJC03ph2WsNTMzuRq5ICB4Q4umbnR4hx+M5tQhhOt0w6jYtBqR8iSLpa8pkzzO526oCuUickCmK2nTFZ6Pxpy2BQCaRZBLZWS6A2PTqhni41+aXbOQCTzr6VfMOS3Taqir83ebsloFWz6zMpw8QYHVWwcAvMGRqhu/LthFiKu5eSmarr0fBkqC0lDyL6ELohWx7IzZI3kvkM3Wg8Uvu3M0HaKlSCNlOVuBItUFrSo5HQwQrVizJo23OwUZCS2NYvXQJLIMDRck1BAhX6XKOzrHhXCDsJNJbXIx3TzyCugioEg5/q7y4lu+JC8O4s+FMrx1VRvtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184258; bh=CN10ry56VTwi/UZagoNBmkShbIL6cpW8D1qZDuMt5RV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hhI1gpZmyoYucWPEHuf4IiQh+vCDJEOFRbJleyBGRWLoDtWEx/2QZTOY1h/Dm2DwqCoqr6bPlupHWXsxjlK6tHNqgjEoVddSwIUzGlzfbT/Tm/tNTUUBScRrnzFm6HOtpTHlOCJi524tpNL5NVNRDlBzVKwzkz4hLWIBtLgO0yq2VHqtXvhoM5oxu4PoHN2R0yGLDrWVZ+Whvd0RfhcrVbGnNxI0Eix0aZadlV+izVX3iGPnq4ZW7yejLGsytbu2jNCIxpF+YBDJS/pxcFFerpHfR+Kyn6TFenZv1GfVB9rPUtxQbH0Fr3+LrdgH+hjbIa/SCwjAcJyadGofxjLtSQ==
X-YMail-OSG: n4VjJj0VM1kDzM0kbHMI4sG1T8Ndf.aJU1M7bgDz5O1B6JysKsAX4zzr.6ijh6D
 f3F6cDD13HSfPoFKwKgzUBx85eWxVdSi3FlDMjS_UAXs.YchDKGoaBlWfV.Xmo5WcfahY8dZm_CE
 trUXctdP0rQrPt0_sTI4A1b4wzMg1KaEN1GcO88ULXfVA9Wv6B.oo9xGRyKvHfKLeRt_nUVFDBa_
 tSdpq2WR9FCGUvgfrQnUOIN2ihQfUh_MZEOwEcMJA6Q6r5dETZXDFa6zCSWapBn4LdvbgK3xjjN0
 K.25oes_KdqZifuKUfwo9cNImTXtXHnWyXMHQlW6xjiusC3BO6s3tHhT843Spm5a2ynd_kwqEEKa
 YfXC72TH0FfAWM4.j0DjlghYkimxhx9hhHv_8sKcbpuivYm4H0JF54vPPLfY._kILEANyDImblh_
 h5dJtUTij5tgSbX6uHEojNJuh7RTMt.ulGRgz3k3kJswyFzf4SxD2JlDpQaPkOJ2UScU2w21YfQA
 VI0aPmy8mfPZY7g7Xty9kBQVtOIo19zIYmm3sLWQ_94Znm0.qNZvcfH49.mdXCjLNI0eKDhe3bEJ
 cNoskfIsEXZyIqNSN8v7yftmsQjy3e6Vvs2LVEnWlmtJ5BszEnED8mLpsF1nj6XMPhNO9G8HVLDG
 Vi1V2BtNeoGAm5Z6k0Hnaj08qvOacXv_l3JPCLC1BOrfeVLfJL7Zb5c7MZvqbrtYj_E9ssghoZ5K
 Lw1iAPrrrsJg8UJxBIhbAEvAzZ_J_4xVD1OtJs.NN_mog.TEQBVg_fMfCs6CL._b.IcVweuH0I_U
 LMtdDKJOjfC6WD_YDoSHyXLQdJVUBpWyxRbF_Q7SLIX4hbs_u0SX47m1503gQxMZdd3ASxdsUZgQ
 u1gkqaRtgGhtTa.Tn56I9o4O.swOUd5XIwdxzL13tvOEtjPLvT59TCvM8SzV0UkLxfgvzfRFEine
 dQocCDHOaM77NLMNgjYFyB76A1GU48bcyGSP6pEBJNpEPxVxqi1g0jIB2hR0pTf3Sab6KMHKm0Qq
 qUL80NPiOF75WG71fVYZWYub6hFCEvcxOFq8MMNIfwILSl1VLN8E58ScHtX1wDsUabPOppUDBJdS
 72DlumeAFtAUTBI7KFkvrjXuQ1bdso4FurQHPzjL7CTsSoD8mqYrxLGKQDyuDk7.QchNn5LURmJE
 smZM0k46s15ejVjuew8Vpp5tINL6abhP9k5HO52cj1Hxj8IzxWUlNmWquQeE2PA5K4cuVHgUwgiJ
 7ZtHClE7MOcqSjYkzqd0Zz_FQjSpaiVu.lrE.JDMLB.E087Mz4HsmSxgsb3VhUib7uuJCPeOMf74
 KPK.DD_NQQlpQM2yEvY5j9_0UdjTXJQWgpQYnsgZL7fo4ejZGAs10pdZHv5C0BiSykBrJF55qjiH
 bLw2AFHZoeX28DHwrP.R15ZXNRMSw2_Ekd90V6DBld0AnT3S1c4RcesdCTtiTRLvtYJ7rTcJZW5S
 H7AevgBy1Emkhu0RPV3TQaVlDK43cQ.rymL03OF7J05tOUjWCjiZbPn6BoRaPzfOQSpONTqOsl7q
 VoSOoJCfbPf6dLNuQ8bRX3TYeAOZfwLWZCZQik0qYlri7IQ_CLbHUNk6cjnQnU8frgdzRduXBu5N
 zu.1bhaBWpe_8xDBHAIM1cntZfDov9YJi_9Hz6TLIPoGTzg4kaj.Ig6CVj4l9wm1LP9Rnj9fUwz.
 Ne5awguE0QUtxjBhv2QHd3OhlZxYEhtq5Wlq_WWSmo1T_meZlSZ5ano3f9Q4TO_2IKGjp026xEPy
 TVVGV2SzXfppsOomkCfLaGtGjaWOv3TbDIh9VpaeC2y8T0IkafgzZfdHOuYlCoFPlx5568T5ae3F
 3Mg5RiJmdMbmJvnKfsyoCrSigjEhP.hmXg5gduQ0tvsq1IHBCP9G_Ahb5.JFqOykBuJq9y92JERm
 lHRSr.gSz36Rqp3JAVZWnMm5OQtQxJcanXMKpPLBB4tdCDCKZnPgeYdtS4mikX4UPf0utJ8csuSk
 77tuk7wNRxJXXR0pvpOYFwCbEft2DIzsy1F9FFQJnqo2Tt.TdiNjxX8vLjjsSTddatKOiITybNMb
 7it6whS7bszlmiYnpq42EiQPuNJQpj18bPfhF39Ki53H3dtnQOiIAoxRAu5oxnnlilZglKeB8Src
 zokjmoWeZBsQ0awXi57byTCWlXaSlSnMRNgi6xOWiGUX2WpE_SHOoauikYKxlVM.Mxio3i.YYLt3
 1j46HrsLqfYgbOuhiZ0xIYM2I5dJj2CuOk3awqVjL4jzvVeX_HHr6sQYWs_E_Na_SmQWJCfK5XXM
 0H6kU69sddKsgVSzc8izjkg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: c00a3323-0c2c-4c2c-8b86-ffab17e06ef4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:57:38 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9295bf04d78301a0059f933a0cc30ae0;
          Mon, 15 May 2023 20:57:35 +0000 (UTC)
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
Subject: [PATCH v6 04/10 RESEND] mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
Date:   Mon, 15 May 2023 22:57:13 +0200
Message-Id: <31c750ae13a1c1896b51d8f0a0d9869f8b85624f.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
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

