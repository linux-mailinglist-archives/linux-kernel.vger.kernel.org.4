Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDD733D04
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjFPXnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:43:31 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E282943
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1686959008; bh=KHptyEX2xsFZL+j88dnXHyUe4p3sh5ko9681QkeWbuI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=RPnLuCpzbtlKK37vRsdZrzwQ7+AFw+ReYmfz5I8WNbr9WTjoFIwHoyNgq9sheDineLm5CIvc/Jvo9K5l8ZJlFbPoMQZkFQ6cZEUXIvI1+oTel9JTLLvOmI5nCwjTFpIbdnV3K/RYQ9dHkmrtzncdEQcIaGOqmkL41IxCmf+dfKqj5j68jdt9rTs/AObkc3oMDoXsSUuTpp6e/9LWVPXNQuOYztCM+ESqyMKlkSzh2X4Kayz9cBZoEXhARFFRixOpfZmSDVxTEaKSnKY5w27QbdhVhzLjOghDb2qmdgZDpB2ecdtQbTBbaPdIO0qGnuw3UNQpYFnjxCzrUVBPkfxIHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686959008; bh=u36nD8DK6VJYWCg9SV9eCoc5jm4KgzdxzuMPbtALCoR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jYpBbu38meAXNvAG9Tvze2HUj3JHynNN2QR4VQPPtY6k3BjBd/Kpro4WZjP3RfeW3hwfXPhlQLR+TO0BWdgeQ1so7q6xMXAtaiJ4HTV9KtQHH161zosWDUezBG8+aEC04OBE/vYlwaYjg55iC/IwtWrvFSefr9F/XSGcIeD/egPj7lXyIsyPVOP4dNQ/cA1VxH6jxxKqC0JXAIZctCr/KgNL9RYjnHzStovEQST+XpQ7JQjgMRf7oalsdmlCo0MteMsuKS8wbHfydLb9IoQ9Ur/cfO6RqHcJD3YQv3+yl+L2XM8KeaO06pSexJ4QtTE1Tn6dj6RKkAhf44aO/XhIXg==
X-YMail-OSG: XW4b4rgVM1mt62u.7floGH_4Kc.IcQVTnXVOppQWC7n_Iz2L7EQm1rF4FQswjIv
 B8yxxmC6uea0H9J7C2pauWrblZK2sGFzs3VLkH7p4s0d4iHpE6h5CYx2RvxbrooNPEbMQJaH4JwZ
 J4d7DABH.Vee0e29iRu8yj6OBxBq74nxmX2q.5M2r5Tl7bb9vNtHgBylRTCrZLm3FHkLVQrV8u1Y
 r7OLrOelw6LM2HvmciElfqi0t_qsAbL8haP0Q7DIRyN_brEYsU76uVZDml4XeAP5xIn8otMWIhQB
 .qsYjvNDfSefaL4sYe7Ap_6QRwF43dbugOVMn3ql3Vzht10NPdF6IyRHF1WtaZSClCpWnn6UqsGG
 iGdSzOwXgNU9GqteohmwICGkyCTJ8Ti7cJ6AybpX0ImN29efLiX3uVmiLSFejxXbybhXxNjtKBbL
 64FQeHqoA0ntMDWRKa5eOGbKU4rNKsedaazdAJb.veBepRtyd2HyJxUhG2PduSqtQB9_EQcYERnU
 N.gQ7zQUrXpTZ9v2Rsqi8zkTbPRHIGz9_LoWP5JeyGJQdcyBwgexDIUPixAk6FlhccvcRxT9vzge
 8l2TiCJFg4.6.mxZ43YKMAFLaIYHtpu7fNEfvhrCLJ47Kj1wluW3oFRBG3xihLk7p7nWBc2uVOJp
 SJvWXfeGtHjXfWUordL.P8a6OB.DwBxCNv0W9rYZ_tQlcraEjyICgcatkBKgo5S.3TMyEkb2j3od
 xRpzgMOX26zd449E82aVY67w9fJOgL_i.syQ7EEgl.Gq3PHhpQB6j5PJmn4xeoPg7PAMpyBwPb26
 LNyBkVFtZL1gFpDP3c0Pt322mhlQwCLOxWEBs_FWkQUaMQ0yA1uQm1_WSwkBZnj473VVH75ZHvkb
 k4qNozZatsK.ZILvNy4Zyd0cQXzOdo_LvTqUGQ2MkPr34BsZcnMR0UcZEioC1JlUDO4RV6v8X.mC
 nUr2ZmxBxJxjh1obQjjatZPwGEyAgY9Y3xpvNt_fey6IPt.cNtzlfFDTGfW82ZzCULWW74ZLIsFE
 LU0ZP3ZLKlArSyowTZttnWbA_lNOFgEBg4h9DIhBuG3g4Spogu1QVANGsdHsaO_4qT9A_jo1A_r1
 yDxC0gqyHjeeI1_3xXSDgE2N5a1uqF0FhgOoQYZHoUHxXc28MhBO.iyTOTdyE_QbNfTk1CPFrM9X
 vFaYiEFqryOAAdshhkohWOYL5GCV8.z4phabILLkgrnK4oQXMOxRkLWyspMB3ujGfLUltRtS_sKO
 zYf8XoKx8K2HEnX_SFmIHwtONYWBJwxGFf0MnuASLjmhdjCqw0hDT0soRGjzpTK.BIFoDnlYyhgV
 0r2bAUImChHxUWWdEm05uxXXOAL9mcdVdv0QEKP4pmlUJ8OroxtiEQvslZX3_mHarPLR85f5nFAz
 aiVeSJQJTD2JDbXN2bxNwkaCUwoepWudXpEwL_eaN4ad2O2ZRSxS3WOu0K3vp3OHrOvqVWtdan6d
 m9zxtzlkYK7QceBAdZfQmpAuKRbTyBOGm2cWi_ZLME0Na2YtfnGP98UFZOG5cPhwq34TP3CDd8g2
 5wWl9QYnKmawa7GKSc0Fhm_yBJz7dbmRMdmlo2pZJIIP6gFvPU6JYnSpFkcqMVm4yyZL6cO0rwrr
 e.TpYCK2vmZ.FW0tkmr3h6Oe2634o6VC9tAqvzcYDw_O8C6nBsTQ89xSvoZyeWzhXOoMojdySQ7T
 yLFSIXFzYtW85iGbJHuD0OQqw0LAtkYyjINcy4GCSFYsnPLFHqaAd_vUZUXStT852LwTAjlCPrLV
 .k8Op8rzteaPgAgBKMtVpWDMCXV5IsBMIR3ESEcixpla.AQ6PivPnLJm9nVA_9knaORqH.Ej0m6N
 RKpZXruGmHde_rP4KNi_TK7Gpp_U.5IgMvRb1uVn6arBzDDJ1sr0ScrKaDCzHiVkcx_KIIN2Drnc
 W0HbIDJMC07mSPCHQBSHao28Vb2xv4E5U7GPWMHz9e7G91XSodmQ.iwErt0UMFKxrtNYKCYwc0uv
 W7jIbP3NiO0mN2X3Pl6FnPc7LpnjuJ8a4N..lnssATLxuNZvoIuYS1cimIdX5lMq_KnHQVmQ.l4A
 ggqPrNLIvXJ7yPcBi6r0xCz4LJrZ8EjKS3K.Mqcn6n4s12.LoHRBFSHa0uup9UHU918bdj.TQ9q.
 rbSQpWQLFl_Ulo4_Mi.eAURRiGy9QkmGzMzwfayULEvC73dFOErf6KaE.HKyG3jmk6cUs6PKtifb
 6KVGamdVmlbwvw0SImgzUiF3zUDLIICXiCzGLcsEt2WVSlLluOgug3TJJgWF8yY5ZocUA2XiMsDl
 s_iepXLFAbT2yokkdDypMuZOr_yrDUwlWfIkGFls-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: a67a19a1-1c3c-4ec4-977e-cd0e4aa19324
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Fri, 16 Jun 2023 23:43:28 +0000
Received: by hermes--production-ir2-7867f454fc-8nkq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5636cffc5e4b0771cd0c200ffdd51601;
          Fri, 16 Jun 2023 23:43:23 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-serranove: Add RT5033 PMIC with charger
Date:   Sat, 17 Jun 2023 01:42:52 +0200
Message-Id: <20230616234252.37022-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230616234252.37022-1-jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the regulators, apply the same settings as in the downstream
devicetree [1], including the "regulator-always-on" for the SAFE_LDO.
For the voltage of SAFE_LDO, however, there is only one voltage of 4.9 V
available in the mainline driver [2][3].

The values of the battery data evolve from following sources:
- precharge current: 450 mA corresponds to the default value of the chip. It
  doesn't get changed by the downstream Android driver. Therefore let's stick
  to this value.
- constant charge current: The 1000 mA are taken from the downstream devicetree
  of the serranove battery. It's not easy to spot. The value is in the line
  "input_current_limit" [4]. The rows are according to the power supply type,
  the 4th value stands for "main supply" [5]. That's the value used by the
  Android driver when a charging cable is plugged into the device.
- charge termination current: In the downstream devicetree of the battery
  that's the line "full_check_current_1st", which contains the 150 mA [6].
- precharge voltage: This one doesn't get set in the downstream Android driver.
  The chip's default is 2.8 V. That seemed too low to have a notable effect of
  handling the battery gentle. The chosen value of 3.5 V is a bit arbitrary
  and possibly rather high. As the device is already several years old and
  therefore most batteries too, a value on the safe side seems reasonable.
- constant charge voltage: The value of 4.35 V is set in the line
  "chg_float_voltage" of the downstream battery devicetree [7].

The "connector" sub-node in the extcon node, the "battery" node in the
general section and the line "power-supplies" in the fuel-gauge node result
from the way of implementation documented in the dt-bindings of
rt5033-charger [8] and mfd rt5033 [9].

[1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-eur-r03.dtsi#L135-L181
[2] https://github.com/torvalds/linux/blob/v6.3/include/linux/mfd/rt5033-private.h#L211-L212
[3] https://github.com/torvalds/linux/blob/v6.3/drivers/regulator/rt5033-regulator.c#L83
[4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L100
[5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/include/linux/power_supply.h#L173-L177
[6] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L102
[7] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-serranovelte-battery-r01.dtsi#L95
[8] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml?h=next-20230616
[9] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml?h=next-20230616

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
The patch is based on linux-next "next-20230616".

The driver rt5033-charger was just recently added to linux-next.

 .../dts/qcom/msm8916-samsung-serranove.dts    | 67 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 15dc246e84e2..2114d26548db 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -142,6 +142,12 @@ muic: extcon@14 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&muic_irq_default>;
+
+			usb_con: connector {
+				compatible = "usb-b-connector";
+				label = "micro-USB";
+				type = "micro";
+			};
 		};
 	};
 
@@ -199,6 +205,15 @@ nfc@2b {
 			pinctrl-0 = <&nfc_default>;
 		};
 	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		precharge-current-microamp = <450000>;
+		constant-charge-current-max-microamp = <1000000>;
+		charge-term-current-microamp = <150000>;
+		precharge-upper-limit-microvolt = <3500000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
+	};
 };
 
 &blsp_i2c2 {
@@ -228,7 +243,7 @@ magnetometer@2e {
 &blsp_i2c4 {
 	status = "okay";
 
-	battery@35 {
+	fuel-gauge@35 {
 		compatible = "richtek,rt5033-battery";
 		reg = <0x35>;
 
@@ -237,6 +252,8 @@ battery@35 {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&fg_alert_default>;
+
+		power-supplies = <&rt5033_charger>;
 	};
 };
 
@@ -261,6 +278,46 @@ touchscreen@20 {
 	};
 };
 
+&blsp_i2c6 {
+	status = "okay";
+
+	pmic@34 {
+		compatible = "richtek,rt5033";
+		reg = <0x34>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_default>;
+
+		regulators {
+			safe_ldo_reg: SAFE_LDO {
+				regulator-name = "SAFE_LDO";
+				regulator-min-microvolt = <4900000>;
+				regulator-max-microvolt = <4900000>;
+				regulator-always-on;
+			};
+			ldo_reg: LDO {
+				regulator-name = "LDO";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
+			buck_reg: BUCK {
+				regulator-name = "BUCK";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+		};
+
+		rt5033_charger: charger {
+			compatible = "richtek,rt5033-charger";
+			monitored-battery = <&battery>;
+			richtek,usb-connector = <&usb_con>;
+		};
+	};
+};
+
 &blsp_uart2 {
 	status = "okay";
 };
@@ -387,6 +444,14 @@ nfc_i2c_default: nfc-i2c-default-state {
 		bias-disable;
 	};
 
+	pmic_int_default: pmic-int-default-state {
+		pins = "gpio62";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	tkey_default: tkey-default-state {
 		pins = "gpio98";
 		function = "gpio";
-- 
2.39.2

