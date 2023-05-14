Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586F701D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjENMcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbjENMcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:32:04 -0400
Received: from sonic309-24.consmr.mail.ir2.yahoo.com (sonic309-24.consmr.mail.ir2.yahoo.com [77.238.179.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2B82D71
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067519; bh=BgnxKccDW0hD4wBKD/wGrzdwGz4y7GQfSjWtC1jgF84=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tOFNhfjc7cMjPVUPZWShSvLt9MmaYuhvzwBdSJyDSnRBNLUM9ghwCZPz2RWxOtTzKGaXq0X4GTIxsWUwG3GJwG7D8JjO13euTQfG003dIZ+MkRHIFrVsbJUaX69kbl/sG1uEz+F6+/Ie44pjt1bQ6Z3ia8Pwm1zrp+3H7M3LYctOB+WM6uxRVKFixs3PzqRqKgO/koOke5Lj0oDgFrNxq7eo2AlvtMC75jWpyTGjwYGqrq4lWFRmSv4hC2pQfk09ygnTrZyIA1JZaApzrz7sPBNvq3abZtnnOPkBuglOsqBgtli/WUXBHOBstPmoB0GG5uKcghld7APdavvOPIFbGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067519; bh=F1e/yH2/7uoIQfeSzKAgSA5/bP4Dh1YK42oYCg+sfM/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AGNMK6IHn41SjYp9fpgk/qlIaqCgADeyt4mD8PbH/A8ulSWvVpWJIFemIB61p1J3iLbeC1LLGw69EEbVeBEHIG2JUEOK0yQe5DFqO7erl1hN3nZjuRohA/j4sxCsaUsrHNQfCGYMDt06K2F/wZZNb92iHLxGr/Nvejp1cl6y1HQ9o+e6ogPeVu8eiPSKV93TYQNhR9/TSEe94cliUo/xSuXVVRZxgOmcjTxYYv7lLCCbB0GbhN2ZDTaz+aa/6s3ezZxGvlWze6+xyREJMin/j3zdhy9pbpT5pshZQColj5IThIAzATlqD8UUN1pIOic1RngZKwTLFEhw3f77mlB9hQ==
X-YMail-OSG: mXxq_KIVM1kqLI5v7AqJx03NRoX2RkS4eD3cxfPawAdacQksZaC_k7NPkg7srpt
 I.Lh0nB9r0qpgdSqA09RiRBybXjAve9o9D_65.WSXElnu6uNQ0fKLygQ7j4FQeBp3EICUzgDWzXq
 sgFvG9W_eJlYeYj2BeDLW_snaEIHP.A1iFKu.bJKukI8JXokxjfuaAwMHxzVUcaOJLQYWxjs_WWi
 NeBER.AboFrYvpnJODU6UmPIRMnl_DRsrtV.UYC_6A0d49IEMDBZAc4eit2lJKqyclM.Co5vSeKZ
 bIWd9k4zQKM0nA_ag5dTGX1JJuUOipOcpIS5GoKhrGqNs2Udnke54juDpUNgEm5wdfYXrqSdjNVa
 MTWrxrHBY1T1CSpnoyD8SNZdJHRn71vttBUoJa3GyyM8jJQK4skFFPCHqTQSyijua20hhzAbu_8t
 YS14zLAPBxAbHDNjYIOKxTDBidQY0gSvuVO6Z9_EV3IfM_0Y67NrcoGkC_9b3UDhLcaL26V_6c.J
 0V34Z76GY9_pu6Qo0DoPh8hIxq9EDcNIy4xF1.6P6OlkkeEy8xgFugCE3XZBWKuUfQ879wcBsdr7
 4twC74IKTzTmspd6AlPYUbibqndbBdN15PXy2uhHh9Y7Z8Fe2ZegONz4fVBBqoP0jQx05V1LEb6.
 UD.cYGYMKbcfvMRhIpGHLsBl6bxmi8heVsWBV2uWN__iCqT.Go5P8lVu3Pv52uqG2Ka6HiHcAPBX
 bysRa1Jz.X2elmhbAb20Q0F8oIiCOx.Di9MgXyBduMcZlokYaK0fLlsubuCmSXTb9yM0nO6_vcQ5
 B.ucXabcDd7uiFfPJfTDefLhC7IoYpzwRsRyakT7u9nVuTDG9xO4tU_FVLUN_rP7jYiYHDf3gJ1K
 mJX6NIIdFYOT4f7.4wI.blXIzr334.Lhv7.81.vIqh6oKatmhBHS0ogxXpcvDulSu3fRzu32H8Sf
 Qcg094KwjDZwpzF6iu9NixoppaH_700xysAnZcuy55zdHMJ36qboTtBbEOZ5dam_Rdi8znMugR0T
 b7yIAh0qITRtLUd5LzIeWS9wjmtvlOHDVT9diI8aZiJtd0NInm70HCVxoWEo1v5NpCfgFi8slvfb
 FhI2yKQn78uWGaAHQmQgST68wQuWW.DKvtz9juCQKfDHooWYiv5b0HA7W0tp9Tf44XXhHSVQg2Zg
 8A.RtCL.hTveLwe7ZBoGRK.qOlIVdlaaqej73Yweh0y0OnJxRiQ5tl4RevRPO.cgnf0TFJKrsyJh
 XLMSQKGOZlAxwPl6S8KDhm1cfWaRhFRPVhGSKDASP1sUSr7pqqqpiyWZAnNfksLp7tO0qxw0i6_B
 tH4vq557NorCQw.u9e1ysQ6VsfzwdwisHzbH_ITKEROU7Uv7yjAfBb93Ex1qYvcs9md.cTsAn1mS
 GXz0gdzi9i05gejGcnUNt2mmvLNpRjtag5LQUkbjgbCF8.T_o_3AZknINv1yP73RFFe0zO0eZs7C
 TbFESAEmqJwsiJ8jZohkrgfUfpXgJS7MEf2k.0CVSYozy6ntCSffCMksi23KztxK69och0udY9lw
 KIuFYyMmG31xSzuvGLbi64Zaim04bU8vWiFySsxB5tVmebt0KsNsXErajkEf0IaM7Ey_.06Y68O5
 Y0XqePmmX8XDJK9JBi6mdrbhr9AIP0W36r3Xbwe_9a1khGC2BQrQVFEH19AjUMXYhoEL9pIXUwNn
 MqnNpVaKTyxf46beAFyrIgX5McWAltr0p_ps7O7v84feJ6UFVAzhOd_gxJPuWlw9uibpp7Gck8.4
 WFA7v1l7OxqvBLqDKHCfBtEYM6rZGfSPyQ7JFWdmgRue_oUN2yCjjDwX81bhIS1DaW8C_GXri14z
 CyDjaSDqUOAZvPa0M7rD7rbU.mtFZ.Sh_k8pKHwjXG4cy_SAecDfyKJZlpbiKZVgjaOGN4KVnIF3
 ZQHQb0WTbiZbDB9f40JRgzl1Q9WuFQTBzhOknyV7ruE_h6sGeYAtZSR4xpewl5.doPFUChybNmsg
 TSvx2vnmwtQC0LIv8iHp5B_8hNKOwaRhaFIfuqggHtjMMgCF78LrC6MNsF7Ah64FEhFguT46aIKf
 V9ns60rNrNeERZFbHrmd8iTgT4QVcbMVJASCkEciC1jp.t2vFElnVAecaOA6ZthS.K0.EMt3WOhe
 BRnKWN8z626vJs6Y8DQTuUrKpR_gPtJjKTjUAv_n4wLuK0V2sdJnZHrWvJZGd7HeXsIFnwTMElqT
 bgyD4YWm.0LA.FZ8nXdsV59BloWmRRxhpz2Luw32nHgLwilsYJBbbJLdjFKS_1a_v1uLNniRSQrS
 I_GFrwOeCGHply5nEhFZd_A--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: b3d60582-78fb-4e9a-84be-0df6b00ff0c8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:31:59 +0000
Received: by hermes--production-ir2-7867f454fc-kqstn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32d47a946aad3f7d203db987b930ba8f;
          Sun, 14 May 2023 12:31:53 +0000 (UTC)
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
Subject: [PATCH v5 03/10] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
Date:   Sun, 14 May 2023 14:31:23 +0200
Message-Id: <20230514123130.41172-4-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
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

