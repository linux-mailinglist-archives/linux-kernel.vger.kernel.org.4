Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F7733D2B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 02:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFQAaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 20:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjFQA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 20:29:59 -0400
Received: from sonic309-26.consmr.mail.ir2.yahoo.com (sonic309-26.consmr.mail.ir2.yahoo.com [77.238.179.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085C3A8B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1686961796; bh=3ubr12IgCaxiPc2P8P9TgUxEmc8Jyb9OzmeOqzumtgk=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=M4Updjdi/OxKbtaffuNH0NEQsq2dfOH3jBxf+nDZMVzh3GGJus6BAo3PD4VGUzZIUsk8dzhmumQpsthkSMFgIUySZQ5Oy10wQLb8Yc64GNPKWqLyb3FyHZBohgi9PPHHw0Qslg/1cyt6yMr4LJTlPBAtxFKra17viSo27OMYMLRXrv+O+uK6l5y8TqjKKQlag63Gto1MaOGiCutsj4B/SRs5l/QuLRFqSVxZXLjR2GBrE7ThuV8aHw/fXAP6oKhAe852cPzciit/kHMNnGoH6XnktlCLzfgqugCyYXTy0HvfdWbuXV0rks3EF1r3HNoIudujY0wGtfWkgYTUoR79xQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686961796; bh=MH5EA0KMdDcFFmZklUynEhNEW+WykT6rpUiuQIMgOS9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HyAHiozHGMTZDiDgduuyEbzkitm2Ac+++dCwWPUySoSvCjgqeCWqJ7ZHZNw5/mzhuxpqfEr0/W/nD91+2bxlHyfJ9aUScOBVCn6yzU4ncMkSsIXmWOv1Bd3NNG5ccS5SphMf3eXmbix7E77MFIj6df2L8b+QipOJcF0WbmUd6/oRwAyebU6UoT9H2hYu8hfag32aIgabZuy1q4sIC7XUThBk/8iPx9iqtaPjFt/omRjDSRYukJybQ5Y10Q4lqcC459egjUMJ+T/01WBsEZWvoRK/JCp3bv0/puqr7G+be+JnDR0zScccGSMEaYhcY33iv/YRfnhKaje5uZ2EwCIsMg==
X-YMail-OSG: mN13q3sVM1keDcvr7VW0xFSaD4WqKY.6_NqMnAy7IeEb54cIHb0m.w826wvgL6R
 S7PW.GFHt16fIeBCoKFLlY6WkLKNqSVSls1AtZL.1ZnghE7B3Jf0pqUHOIFEM0RFYToddOdduNzs
 Y9e1A0jenAGXyYPLFiMx0JKphCjhUGWqaQf__4i6WWJeWolVafO8ugECPjWPqn7WWs6FgZrUHBP3
 T0xemv8oyCHc4IHeYQD6p0W75JpnLjxVxUUSAYIXXbM4v_sFIxoD2WIRgNcndmSjj_tpTHEt1yFe
 3qTILi9zWmNzHlKv7bFCsc32oXsKAdemCl9HZdCLyL4cO9r0culLLLH58JU5YdGcmgvWDU0n.ksS
 VQT9VHI_QLoqc_dQ9_j0ZYCMo8r5iTzRa92JMfewl420rlMkdTMvaG3HPUmNtXem0sa7U7KlDocO
 789gAmrLeSav_RIlOMoOOyi4ncf2JUoefj3XKfuNU_WvlxuTpjJusVlTjLy__5K5Dlj_4VY62NDO
 otQgW4KZwig8BnOFt07mCEumsJd52EF4Lw_OBpHeXULKvNqVkjMSHCwLqv9YUTsdLqD09BJ6oyq2
 oI.GZ1Vn.LYoJ0Cc8RIemsvmTJr_X1lFzAHzhdXzTazfBi6NGYcCogOTu9Yyt4SfGeVeqwq0lvXS
 kZnpQGeBoJSVv4ROtfwwMneeKFFNQ2avayUcreJjl7jyXZuq4O1qKeoK7CLUpvGGgK9Myo3Q1AUQ
 f0w.Ye.ZZ1CRH2i9zVEShFgwZaGpUFmEyfeIXNTg5NWu8_fqN0GEFO85aAuZVyseRC2aOX7ljF0y
 rA6Dte_363jC5kVMbOfM5YjAGBwmDg3YRcr9RFvd_6QQQpv.jvCdj_Ac1TIHcB31ixbeniojQc5p
 6K.3yg_.JCSpQ5sN8SYCDPgSjkD1hUWnNm7Wa0FE3anb2DvYNMB84_AGT2aKLpYim2tjjsM28HO7
 JoyAWz1RsU6uCHjfUEwrFuh_fx3F8eZR3avAqhPTaSEK3oaz.Y4pB_ERI5vOcQDBnW7w7nn3N7Ft
 3ZjGi.I6sBNBQqnNUQ58fYrZqfW8rq5KVNL9jMOt7kVuFRcvcMFhVkMBBUST38WWeMVw2IcfeTit
 MEoz3THhM18sLKjjmt4rZ6XfengcOP0rgRpIi5umgOCsZ.LGaYHNAh_Bf5CV21yT6_F4qQUbDrca
 EpdqNJbO0umP07rDQEQ9vwMtNDcoyZy0rn0jkineORZSASP0DRscThl3YcG_XD3ggJZKKcqti3fn
 9_rE5EOjUCmHhdNQQsRF1lIMTtm0j6B0LDu6ZPzRH4ENCNlq_a7zq0XCU8cFoGUoOWs7bTpeak4g
 N7Whj.bO5bzaVGSfRZeR.INgOr5gMbrzYjoeRdGlPHUbrKuB_dswbQiSee5Pk5Zb3fBaY3WtkK8e
 p4oGIPJjzuCAjPv55hAdxb4LM0ljSzZB0CPf9yJYEm5fRRnmiWwt7kz_j7LJVnrK.L5h_.C2lwBi
 HW.i.q4dEBwdLU.4oyBhiWSFM7gK.etrQSJ3OisJSFQI3jo090uUKNrgqRPUvWhrxHQ5c8SXU10w
 osiEStVZZ6LKa99ptOVV3zmGkJx.WD1q2E7v3UYdXcf7z3tBxqJHr7vOoqgxXO1sTcWywwofBbV_
 .UMwN0Ebn9NdwwwFYBGx7bj943zhF60lQqXfuBXgaPUqNpWdFJEFUnp8Pxov7Yb9BrNUMPR666rc
 l8V2cpj2qJ_WxKN99Q4624oRStpoiomYIDCnxLdr6Zwb.fIuqDQPI3ZBrlGpYHVOWXZGdA3Aqj.b
 Y00ZpYqdCKYV.VpHuMin7ALSwdGJvFZowiZ0F6O_tC3nZSR.TtrSvztPjHVGjJWrTy0Kxobw1ENy
 uGYoYnO30Wifu5gJailc2gnxphEU.KWwooJApGRIsHd3MOMXmF3ayJN5H1_qJ0orTOoBemH_QQxw
 ydMAzwLghF3Jnfp5VUWkCHXBzTM.CtAc_6WLINbF6ooZpPlLiw_S_kjME3bqZKLvCczWk7pRIacw
 R.tbp2Jc0rPmE2doXZzPqkmLOs8XH2Etllup7xDxkLZ2YZU8NjtN7FX9SbY0ckmpk2nMtJTNXByT
 vqUZ4g5tWiiFhgR5tgDjOcGxDMO9zFRZHWSB9rPwOhkvPoOHdkZ8FCov0VVLFQL1GSiZkQDjCTi5
 _M8fd_zA1LttfTOi6ewcSahLBX3t7hbbHYuOav_tMi6hj.qrNoq2WhplOrsWBzgExJMgf8Fisej4
 p5ZGUCBwbE3GthfHETSSN7hGfE1KqH3vsejcU8ocTyLAw2tIKtrQuooSC1WAul65N_KAhXiV51ZI
 n5GvVQ1Mc5gXWXMUIfQVZNiGRkgDJ0Qi1Yh2OAQ_r.L1Abg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: affb121a-d648-453f-a0ed-9ac74f21d891
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sat, 17 Jun 2023 00:29:56 +0000
Received: by hermes--production-ir2-7867f454fc-8nkq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e11accc94c1b3a6c23a5a72d5ce29def;
          Sat, 17 Jun 2023 00:29:54 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH RESEND] arm64: dts: qcom: msm8916-samsung-serranove: Add RT5033 PMIC with charger
Date:   Sat, 17 Jun 2023 02:29:34 +0200
Message-Id: <20230617002934.39408-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230617002934.39408-1-jahau.ref@rocketmail.com>
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

RESEND because I used an outdated e-mail address of Bjorn before.

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

