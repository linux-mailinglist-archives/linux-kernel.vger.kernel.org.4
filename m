Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAA735E96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFSUiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFSUiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:38:19 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7868E54
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1687207095; bh=FLcBbpnv0153QnbGpmedSSyW79E6oM8A7Pdaxys+PpA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Re7BB47B1pAVF1UFcS4WmfwGWeJBQRejgu6LSR9guwoO4EudRqMyNYyTOxDb/WdJeJGHZBGEiBBTYvxACxXagoBekVV0CfvMDuH5WOM9TtGLoDQIgQ8vyzIVzuIf2R+/3BtRy/8lVH14VfDNkhLyyukT8IdEDfm/wO+X9TbZrasCXrdkJg0f9tUGf9zEy4GhJnpUByQLcTQJ+ExK2DAqoHv3iqYuYe0Rj5geiRRBOlEmjVVCeB0/my8uBZrDQWBdIS0TQTl1Szoz8H80xKYjwEvzKCcEfbr2AE6NgEmB8t43wkY4WP7ISRSx/qF2mzjaMqgNHtapM5+vDaBxunavFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687207095; bh=F1vhItBNgkCiUH2/rOdOZECKFsK1CinDzNu92CWu2ZU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qX8kJhsDZiqeRzm+aacTxpBkfuwW/Vddu7Kn4Y39kKnB8KKbTaNMNL2OpPsSnQpGiRYzTrlFk9H9XmsXuWDFpy1s+quF0onnCcams3Q9EHndbCEjs4jO55r35MUUNu2oRgzSmlgzHpq+iIjiA7+j4azmYmUJz1+Rf1KzqL2TUpcFFznGdyFQ9XFAzNrhB8r+Q3b4T65A3oU175uUkljgw/oPwvgoQXEmoDxwN81NiwYXRcE63R9bkBOula/BSFMqDPl8FFivgfU1oUlNpo44ZYW5JVJfGMy4CIpo5d3LjLUyPfKp3OCcjc0Ar7hJbe7E3sYI73GL83PePU+HIdZpUw==
X-YMail-OSG: sYd2DjEVM1ngnvrXRC68RMrKkNJsvc3sAkND7CqBEBYH1zhCLGe8N3PSLft7tJ5
 lYh8KqcPXW0vfnnk9.HQqS17X_2DIEK5xUv_tAHjhItxHtzGAUPqfWH5XMZ02PDR3678l8CuHhKs
 drrcmGphcnmEYdbztGC4iqPf1x2zsBLhWXa13RbLwEJTgOxO0mWI3LL_ul7RSdA6O8NP5Ms6eUt5
 ay_B8IXGYnpcK1_Wqod4.Lk0jVT5opMe6mcem6eQCKglGt0b6Sz3wv2MkAOf_4_TMeAAUW8d4QsF
 r2Kw1cRlXzdDeSMCltkunc1sfwYe6dJ0hE840M9d.buf54JfHSK.2d9FKOrlmL548cDZg1zIKf7Q
 9oRJfIZJo14KpdHRRfo3Z94FiRwPclm0HYBu3R3Ic2SkzdIk.FVzoB6dN.xAD7BM777FWGyiXzRY
 uMNRkY8y2yTPikXIEpvHRr_f7aeg8hhb1BsQgxLPnG1.UTUBaShvKPAGBZ6Imt_COUqz.eMsPesr
 mtOK4xfMP_0GMHwH5X6GSyVBLaEFVVRTaq3bRZlVXh6BkG4yw.yAFl7UFbY7R0sBIgUjRFCdpf3C
 CD0pP74xldhsftl7txXymwaWJvUd9XcokqyzkzQPS4ogSfpU9J29tDcPIYXsKiQ2zQmtR_A9XLGy
 j5TypJmmABPmb3hV7hZaGDhmOfwjvuisPB5HHsm.AlhWyWSxwZAGdGLzJQkOpflN6i6iRCuSM3y5
 E3PB_NQ6S46XKzZTH8tD_GRjY.ni3NAsB0kxdccx06dGkWDPCK.x0fZNIXPLLoWkWXt27uvb5KZB
 R6gllhb78Q75ZrTdeYTnSyTTtx26G6XP3TZRRZxy71T__xhAhNrTjA8Dx03NkwVLYCRzUDWssv.E
 rUyeZ5ZcnP4xmC9UDZZpFviT1EmLNc0NGIf3XNqaojT_UnGJ3wmGFRifdQykvQPr2cTCPcsCgBgF
 TG_rHG1Lr7VLKyieuy_aNkScCbJ9rr.o2IWZu4bRLpDjWbh1wNDeN6QrKQEky.T1zJlsr9srk_Yc
 Ek38qraJ_lXicEE_0jPw2R5DTpA19hAeeVUEtRjaPLWz8.S3fF7eJ0ASdIBCsJ3qlBKMEEZhlxwn
 1ogur3JFQQzhOHOoH7Oc3ZFzGoTFtWJyqcNR6hqNjq.RL1uTqRLlzWcGNPIcXj.5ZuN0pPxAWKRA
 tsmR1fEkSM9lPo4zabV5tvGJIXw5NOr8LnQSuZQgbk1b_tp4j_CQ8t47_.4qsKbeeL4caDpG53l7
 _7mxxZ.4fen789179G4GSOoQgeH9dS6u.nwuYEAW7OWfhgnL9fNobYb9TdbhL4LnznYW.4d1qPWd
 fgMI8F0ifScEkx4H1K8v0RbIl1Ti6G9paT8absie9CGYvmk0TacVeucrWwku.OBZOqd5hr0SZjan
 JUwJzdWDtQNvG3chxnjQpkXZ0yX411duLoedSYIRFEvYUH8_R_up2EJhx8p7D_QHCVTiFTDpRloL
 sUaxf_mChkzUdH23Tos_tz5fPC9UWbcrS5aQExx59oC220_d8T5rjWCDY2siTtlFP4Mc3i4Qqnrl
 sfHXZj3.QdIptGjU8CYbFGj.aFlBxwvxZTwjeL8dw3wXB7MTA0Jpo7i6nCuXVoJJS.sTiQgcL33y
 pYHmO_LDb3F.2O.8X_aIJnaOfaHuU2EwfpfMYLcOal5yZiZemyqZHWgjWRZqJktLeejMgwPOaxsm
 1.V.jbAMu0D8.rR9p0043bMin5ZFCTLxXc9O3gVSjm4mamAM.FEgV2tDCiAlHwjHnINoFh0R.IRv
 cBRV3dFmqqqp.G.cHslsZuneqVjIzPsDpM.4kAVA_mY96IglrSpz1YPoDdLqHfLlpYUmhZqsxNa1
 7ws_OrhTngY_mK7l4mLUNexixAL.qSJzxRakQaP97dH0Wm0pQac95IcbGVdA67sDJU8MvmYOwkA0
 0u7oTdEVNTs2Y1eADVs8hbPYT3LB_H3kdT6foNTKFL062SFQyFFMXtY9dIFO9y2C6D6y1FcSh5AS
 28hxcY_WedbRJx5emNjRIKzT1JG115aLc.GQgwzN0_l9aEVS7FuplrtNvzlb7jvpsdMYCIBoeBXk
 siwZ4lduQowlwcWFaEMKU6UE9sdrtUzhUnOkaX2Kaw35OPwyQbzrtuD96KW8pn8zkHyETt9CovFc
 Lmyd_CrnVvot.9plme9TP7qbjRThRNHBiE6WnIuTrKHf2s4c06Mw.MFVFZk_kkV4F9eDFBRKkMcq
 OLcfk8xDIgfyJHkWVQXvBfIudawSU7EDdWAzc2I2uryAZMQ.BRI1bTet5Mzx7dEBukNPY3ojQ4la
 MXbMhJQlXYnu.pDdWkzSmW2R3l0X8ifzLvb87A3s-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 25f0eead-2110-4286-a647-62625e7b1c2f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 19 Jun 2023 20:38:15 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1045102266187eb9e3901f7e3860658d;
          Mon, 19 Jun 2023 20:38:12 +0000 (UTC)
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
Subject: [PATCH v2] arm64: dts: qcom: msm8916-samsung-serranove: Add RT5033 PMIC with charger
Date:   Mon, 19 Jun 2023 22:37:43 +0200
Message-Id: <20230619203743.8136-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230619203743.8136-1-jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
 - Removed "regulator-name"s and changed regulator phandle labels as
   suggested by Stephan.

v1: https://lore.kernel.org/linux-arm-msm/20230617002934.39408-1-jahau@rocketmail.com/T/#t

 .../dts/qcom/msm8916-samsung-serranove.dts    | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 15dc246e84e2..cbda25f2ad19 100644
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
 
@@ -261,6 +278,43 @@ touchscreen@20 {
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
+			rt5033_reg_safe_ldo: SAFE_LDO {
+				regulator-min-microvolt = <4900000>;
+				regulator-max-microvolt = <4900000>;
+				regulator-always-on;
+			};
+			rt5033_reg_ldo: LDO {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
+			rt5033_reg_buck: BUCK {
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
@@ -387,6 +441,14 @@ nfc_i2c_default: nfc-i2c-default-state {
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

