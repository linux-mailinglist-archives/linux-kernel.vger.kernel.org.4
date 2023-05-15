Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7B703EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245108AbjEOU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbjEOU5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:57:42 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABADC51
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184259; bh=BgnxKccDW0hD4wBKD/wGrzdwGz4y7GQfSjWtC1jgF84=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Hs0xNoDB3Cwf6Qa3uLdqHL5dT+bK0u+Uj9thWmZoNNTCaTbrJ1muQzBL72Dnyr9fuJheMd0aexMcUxZRuXIPVsz1ENEGf45vqU2UTJgMV6WPCBmvGa5NU5q+5J95R7RKwKKJDN1KqU7w8n73yoaKxvXVN9GYaQgLhb+DSn7WrkItO8yzYJI1oEIRSV8WJtxaWerebzgTNguOoBhQ6/grkF6dyAO6jyvupT+0NcoEdJgd6IGSztbq/5MCEioiFED7CdxBNlDIy7BuyzgEJlJoPvpsgKDnTZbmfvXQG7B1njc67/sp2MQGOzey2WDk19XnclE69LJBdI1CTuoLbOMvhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184259; bh=K6yb5bc35im/nqTsON9PREzbEVZi6XNI2z3Xg5pVkY9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sYAm2edwaDhxFVVlvocApip4w6CFjBW4ygYmsVJd8oPYJIUO/tkKkiNN689rnTDu63+naICD1K19vaQrZIkhGWZBU+NGpnR6rH4IQ1mynTLsd+O6cygJGi5q3XWwh7p52Ur9BkVCpvjyMo+blYy32ohIAQlGeyIYUWg3HF1X05DAyfuBwWKxgThDu6wLcGdopJLi/xn9T31DZe8CP4HY+iN3an31AzWfSty2wt99bqM8tcW6o8sZRbQv/AF5AMi9arat/fx/ZcNPZU5vCP3+Qq6PsBC3Pl22BHbPUR3lAuwuKNSHABFD+RfGgGz9RHCJN+USvBvJGWmE0J7T9MKSgg==
X-YMail-OSG: aYS7wgMVM1lh2ytxqkxRZ5vJ0QU39PPsOzbUH4zIkyoAuAGfTDj.crqkfEfvnMf
 3Rg4GZ34SJOHNlxe_Ru_hs1X8pHTmWGR1u0Cs13aqUM_PUDMxL9BaDEdco4ieahKBmJwkVoAKdUa
 EDv_o9xoPnCfJ49Ta9IBqZhOuUEc9Z3ISE1F3X3WP1CPTZfcNCC.ASMVk3DMXoLeCb_ayBTdzb57
 y9nBmqxrKPQfMCPOJNffypFv46JsOQmvfP4qJ_Wg5R7BPBHpY6RqBOc1z8EN3JLV8S4PNSXpgKAq
 ogKPo9ZcJMIV6hQ0Hd_EyxWZzpeNox3XR4H7QYMD8_8nEZI5rEJSOf7G6uApZ3KFzIIcxMx6KUV2
 q0JQ4T.8a1WfZDZzg.XNQh1YNXRmUYEdbO_G1IaqCcdUHzdYXtnW5dbmQZfkYdzzvz7IaBDHqPDs
 OSbX7sjH4DjAknXp2O7cqYnGCRE5e6iXcUxT8EMQ7g5Xo53E92hpmzeUERhpAhj84UBTHvatbbzW
 FvKVmcW_XnwrVr5W88M_3PghwWeJty345jrGWI5bhIMjh7fNBx4mceMgczL1GYw55UUuLZyRGIPP
 Sb.Hkmrz.HtAp0M5ilC26z5uHPEJgJO9sturO2He64k7XToc3YVp8yxcuo6aCzEX.OYd7PSce8cl
 qvBcSGApSWNqcX1mddN_VoveiiMs5AjY42WPyE4KMqikNfWhV3qwrOMJ43jVJByR0sHQc3juie7p
 UVqLuL22rWzagLOb.7g8YRS7lZV4sSKsl71y_vhK1cmfkMswgJY_zDOE6p77h1QrT.kSIeIWFdb4
 hryEbzymfquolidGQiDJgh.dHUq2KdfdOShnIIkjHEAHLQegTnaMZ6X2pmRaNcEZcqKndTeqW9yh
 gHYEnMd3Y_H3k1_BeDulLJnUacjNjUP9HbpOlh1lZUkJuH.jVbLK3bLVvGX.aO6W0eIJ8qHyRXwU
 ND7MHohmqt_QiWy5597SiTYAxsIZExSWUBG3YJM82b5k3ZwMB_E1uCr8pv.v635zIwY.c1Cw6_Fy
 TVacm8BHKh2nW3NW42nezIlInJGc.KJhV8b0IogGyM1R5PilOzo05z9oKevVNdUt0VtPCoIxdJql
 rK1PSfYQiRNPoSSl4t9OsO1e6QwomLM1PYwDquM8k9WXPMfMvvfqWOlp.ftpBg3b.aX05ABILSHq
 ng1uaG6zpmQjBCPlShZzse5Kr9mBoK85PWB.cfZ7N.1j5xVnJfSca5wIcBUJ6yGIqzKLuLWYXGwn
 93EQ_JLQ3lehzY1QF888PbVDqe7RnFdF1pmBaKfoOSErM0JBo1VsPmSboEaoHwky95VTo0euLnFe
 fRFTfIBd9XkuyTqQOHnudLBTq26ccBSyXLh.JqiCebHXI8p2Hj3CMBs8HvC7w6qMNSVDXRYLDr0g
 5x.bDLPNcpHfboo3bym0aq05fEvARjhlXQo2kYkwd4RAny5ghqDZQiMvI.WmXvyiE04jUX3aDmSE
 YPULQKUg7PjiEk1ZCFvvM1E9GAv_7neZphgyEVLhc9.Z54kdfEpsi1Jeiv32.rdj1dIcWHXGiSjK
 _qgmeOdlmUDhRo1SkQN2uFV5Ct7sbek6gQ.E4mRRbQy0mjAHL.kwCm4Q8Tyl9aDpvD.jZ_ERjolb
 _zMuM3kyIocQLOTiD3662KjNQA2EaGpkv.x.Tf7bSIsFpRVL2Uc940EdrQmq0ByEFplciFx7jx45
 Snx3CByJZqb4BqL_zQ0K3f2w9ioHF5C1lwnSBgq.YjykC3z.6l2Ujnh2YrCeZZqLYgQcMwMuxn7a
 GG.CUdpK_8s5RFS3l4oWNhyCzm57GOMZU0QwQOq15ZbRPlmvFBxBTYuS7Cq4zCtK5X8.IuHMVUge
 r9SzvYl2fPLDet8SP98uWxI7zRrJEEqHrhV7ZPwzxCIWHKAzPTWj4Cbn4xQdRxu_l91EWM7NxCuT
 Qq_j5_wkEnS.fccfC5BTwVsUUNwJ26T1EeAKGjctNeP2oWl5ETwq21mU8dunChQAFOU5Gf1_tJSU
 BxE6xZpOsN1XsLg12VSVXs7Ku3Xhu3wP_9p3WrYYL6QuLgPjpOtIpRmonJKP10n19OTB0a8TyPL.
 .4NY_97S4alPLipWvx8kQ6ARnutjr88aahnFpkA9Euc9m2WgIoZuekGBz_cP3ypfTqBy6bWRCwW4
 tBcY.2FT0AQYMALg0hPeXwIeMdPE_aS9hmFFIuHGG5T7rsVhY9Vw2qrLxIWHjLsEBQGWijd4FDMW
 zhKCbxCWr7q5asspcU_Iso6haj8h34XFY15dkoXuJyGe0KS0gLHbp_mkPSFrl59j7R7cE2g0OrFo
 TGZzvk5hlsZ0U.M_xrw0Q
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 048277fc-78fa-475a-90e5-6e47dc034bc2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:57:39 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9295bf04d78301a0059f933a0cc30ae0;
          Mon, 15 May 2023 20:57:33 +0000 (UTC)
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
Subject: [PATCH v6 03/10 RESEND] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
Date:   Mon, 15 May 2023 22:57:12 +0200
Message-Id: <2f17beec3d6c59b41d7e2451d177dc8aaeb7efe2.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

