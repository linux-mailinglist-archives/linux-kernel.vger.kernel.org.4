Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588AA60964D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJWUq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJWUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:46:19 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0BC6B665;
        Sun, 23 Oct 2022 13:46:06 -0700 (PDT)
Date:   Sun, 23 Oct 2022 20:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666557962; x=1666817162;
        bh=SmpW3eFDwybh3aPlX5b8GYFlbzxEioP6eZkX0RVw8Q4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Qkua8KQ/seA6o4k/Ib+o8HkE5anjaP8xj7+X5MUb5a4B3LGxlTGDwJ6+XHKMykyiW
         aEY6RQFeKPvUK6GOMKO61Wy4vrn7C4ud9l/SFziFJXWvoXevjkNh235q8m5fKUQJt/
         1b2Vq6GKD4WJBqT27P+GUMFsif00/eRGyo0pVJa2MNsxjkPvfuXUfwp7J8uneyqQ0r
         sgM2DWKdVjWLv+R+WXZr1YbH23XxXmZzSCtC5Xov76FbBJpAL1rF/F/4R5OLehjBAn
         ZKjS4JE3xmKDGSp0NDUI+usuUPYAmlK4zOms9GFSaf4pivyYLH5jiAzBeGl8CQq+OY
         TlZRSuk8Z8uEw==
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Harry Austen <hpausten@protonmail.com>
Cc:     Harry Austen <hpausten@protonmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: qcom: msm8996: add support for oneplus3(t)
Message-ID: <20221023204505.115141-5-hpausten@protonmail.com>
In-Reply-To: <20221023204505.115141-1-hpausten@protonmail.com>
References: <20221023204505.115141-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for OnePlus 3 and 3T mobile phones. They are based
on the MSM8996 SoC.

Co-developed-by: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
v1 -> v2: address Krzysztof's review comments

 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8996-oneplus-common.dtsi | 787 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts |  44 +
 .../arm64/boot/dts/qcom/msm8996-oneplus3t.dts |  45 +
 4 files changed, 878 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index b0558d3389e5..bc0d93a0dad3 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -33,6 +33,8 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8994-sony-xperia-kitaka=
mi-satsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8994-sony-xperia-kitakami-sumire.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8994-sony-xperia-kitakami-suzuran.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-oneplus3.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-oneplus3t.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-sony-xperia-tone-dora.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-sony-xperia-tone-kagura.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8996-sony-xperia-tone-keyaki.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/ar=
m64/boot/dts/qcom/msm8996-oneplus-common.dtsi
new file mode 100644
index 000000000000..20f5c103c63b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
@@ -0,0 +1,787 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Harry Austen <hpausten@protonmail.com>
+ */
+
+#include "msm8996.dtsi"
+#include "pm8994.dtsi"
+#include "pmi8994.dtsi"
+#include "pmi8996.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,wcd9335.h>
+
+/ {
+=09aliases {
+=09=09serial0 =3D &blsp1_uart2;
+=09=09serial1 =3D &blsp2_uart2;
+=09};
+
+=09battery: battery {
+=09=09compatible =3D "simple-battery";
+
+=09=09constant-charge-current-max-microamp =3D <3000000>;
+=09=09voltage-min-design-microvolt =3D <3400000>;
+=09};
+
+=09chosen {
+=09=09stdout-path =3D "serial1:115200n8";
+=09};
+
+=09clocks {
+=09=09div1_mclk: div1-clk {
+=09=09=09compatible =3D "gpio-gate-clock";
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <&audio_mclk>;
+=09=09=09#clock-cells =3D <0>;
+=09=09=09clocks =3D <&rpmcc RPM_SMD_DIV_CLK1>;
+=09=09=09enable-gpios =3D <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
+=09=09};
+
+=09=09divclk4: div4-clk {
+=09=09=09compatible =3D "fixed-clock";
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <&divclk4_pin_a>;
+=09=09=09#clock-cells =3D <0>;
+=09=09=09clock-frequency =3D <32768>;
+=09=09=09clock-output-names =3D "divclk4";
+=09=09};
+=09};
+
+=09reserved-memory {
+=09=09ramoops@ac000000 {
+=09=09=09compatible =3D "ramoops";
+=09=09=09reg =3D <0 0xac000000 0 0x200000>;
+=09=09=09record-size =3D <0x20000>;
+=09=09=09console-size =3D <0x100000>;
+=09=09=09pmsg-size =3D <0x80000>;
+=09=09};
+=09};
+
+=09vph_pwr: vph-pwr-regulator {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vph_pwr";
+=09=09regulator-min-microvolt =3D <3700000>;
+=09=09regulator-max-microvolt =3D <3700000>;
+=09=09regulator-always-on;
+=09=09regulator-boot-on;
+=09};
+
+=09wlan_en: wlan-en-regulator {
+=09=09compatible =3D "regulator-fixed";
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&wlan_en_gpios>;
+=09=09regulator-name =3D "wlan-en-regulator";
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+
+=09=09gpio =3D <&pm8994_gpios 8 GPIO_ACTIVE_HIGH>;
+
+=09=09/* WLAN card specific delay */
+=09=09startup-delay-us =3D <70000>;
+=09=09enable-active-high;
+=09};
+};
+
+&adsp_pil {
+=09status =3D "okay";
+};
+
+&blsp1_i2c3 {
+=09status =3D "okay";
+
+=09tfa9890_amp: audio-codec@36 {
+=09=09compatible =3D "nxp,tfa9890";
+=09=09reg =3D <0x36>;
+=09=09#sound-dai-cells =3D <0>;
+=09};
+};
+
+&blsp1_i2c6 {
+=09status =3D "okay";
+
+=09bq27541: fuel-gauge@55 {
+=09=09compatible =3D "ti,bq27541";
+=09=09reg =3D <0x55>;
+=09};
+};
+
+&blsp1_uart2 {
+=09label =3D "BT-UART";
+=09uart-has-rtscts;
+=09status =3D "okay";
+
+=09bluetooth {
+=09=09compatible =3D "qcom,qca6174-bt";
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&bt_en_gpios>;
+=09=09enable-gpios =3D <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+=09=09clocks =3D <&divclk4>;
+=09};
+};
+
+&blsp2_i2c1 {
+=09status =3D "okay";
+};
+
+&blsp2_i2c6 {
+=09status =3D "okay";
+
+=09synaptics_rmi4_i2c: touchscreen@20 {
+=09=09compatible =3D "syna,rmi4-i2c";
+=09=09reg =3D <0x20>;
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+=09=09interrupts-extended =3D <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
+=09=09pinctrl-names =3D "default", "sleep";
+=09=09pinctrl-0 =3D <&touch_default>;
+=09=09pinctrl-1 =3D <&touch_suspend>;
+=09=09vdd-supply =3D <&vreg_l22a_3p0>;
+=09=09vio-supply =3D <&vreg_s4a_1p8>;
+=09=09syna,reset-delay-ms =3D <200>;
+=09=09syna,startup-delay-ms =3D <200>;
+
+=09=09rmi4-f01@1 {
+=09=09=09reg =3D <0x1>;
+=09=09=09syna,nosleep-mode =3D <1>;
+=09=09};
+
+=09=09rmi4-f12@12 {
+=09=09=09reg =3D <0x12>;
+=09=09=09syna,sensor-type =3D <1>;
+=09=09=09touchscreen-x-mm =3D <68>;
+=09=09=09touchscreen-y-mm =3D <122>;
+=09=09};
+=09};
+};
+
+&blsp2_uart2 {
+=09pinctrl-names =3D "default", "sleep";
+=09pinctrl-0 =3D <&blsp2_uart2_2pins_default>;
+=09pinctrl-1 =3D <&blsp2_uart2_2pins_sleep>;
+=09status =3D "okay";
+};
+
+&camss {
+=09vdda-supply =3D <&vreg_l2a_1p25>;
+};
+
+&dsi0 {
+=09vdda-supply =3D <&vreg_l2a_1p25>;
+=09vcca-supply =3D <&vreg_l22a_3p0>;
+=09status =3D "okay";
+};
+
+&dsi0_out {
+=09data-lanes =3D <0 1 2 3>;
+};
+
+&dsi0_phy {
+=09vdda-supply =3D <&vreg_l2a_1p25>;
+=09vcca-supply =3D <&vreg_l28a_0p925>;
+=09status =3D "okay";
+};
+
+&gpu {
+=09status =3D "okay";
+};
+
+&hsusb_phy1 {
+=09vdd-supply =3D <&vreg_l28a_0p925>;
+=09vdda-pll-supply =3D <&vreg_l12a_1p8>;
+=09vdda-phy-dpdm-supply =3D <&vreg_l24a_3p075>;
+=09status =3D "okay";
+};
+
+&hsusb_phy2 {
+=09vdd-supply =3D <&vreg_l28a_0p925>;
+=09vdda-pll-supply =3D <&vreg_l12a_1p8>;
+=09vdda-phy-dpdm-supply =3D <&vreg_l24a_3p075>;
+=09status =3D "okay";
+};
+
+&mdp {
+=09status =3D "okay";
+};
+
+&mdss {
+=09status =3D "okay";
+};
+
+&mmcc {
+=09vdd-gfx-supply =3D <&vdd_gfx>;
+};
+
+&mss_pil {
+=09pll-supply =3D <&vreg_l12a_1p8>;
+=09status =3D "okay";
+};
+
+&pcie0 {
+=09perst-gpios =3D <&tlmm 35 GPIO_ACTIVE_LOW>;
+=09vddpe-3v3-supply =3D <&wlan_en>;
+=09vdda-supply =3D <&vreg_l28a_0p925>;
+=09status =3D "okay";
+};
+
+&pcie_phy {
+=09vdda-phy-supply =3D <&vreg_l28a_0p925>;
+=09vdda-pll-supply =3D <&vreg_l12a_1p8>;
+=09status =3D "okay";
+};
+
+&pm8994_gpios {
+=09bt_en_gpios: bt-en-gpios-state {
+=09=09pins =3D "gpio19";
+=09=09function =3D PMIC_GPIO_FUNC_NORMAL;
+=09=09output-low;
+=09=09power-source =3D <PM8994_GPIO_S4>;
+=09=09qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_LOW>;
+=09=09bias-pull-down;
+=09};
+
+=09wlan_en_gpios: wlan-en-gpios-state {
+=09=09pins =3D "gpio8";
+=09=09function =3D PMIC_GPIO_FUNC_NORMAL;
+=09=09output-low;
+=09=09power-source =3D <PM8994_GPIO_S4>;
+=09=09qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_LOW>;
+=09=09bias-pull-down;
+=09};
+
+=09audio_mclk: divclk1-state {
+=09=09pins =3D "gpio15";
+=09=09function =3D PMIC_GPIO_FUNC_FUNC1;
+=09=09power-source =3D <PM8994_GPIO_S4>;
+=09};
+
+=09divclk4_pin_a: divclk4-state {
+=09=09pins =3D "gpio18";
+=09=09function =3D PMIC_GPIO_FUNC_FUNC2;
+=09=09bias-disable;
+=09=09power-source =3D <PM8994_GPIO_S4>;
+=09};
+};
+
+&pm8994_spmi_regulators {
+=09qcom,saw-reg =3D <&saw3>;
+
+=09s9 {
+=09=09qcom,saw-slave;
+=09};
+
+=09s10 {
+=09=09qcom,saw-slave;
+=09};
+
+=09s11 {
+=09=09qcom,saw-leader;
+=09=09regulator-min-microvolt =3D <1140000>;
+=09=09regulator-max-microvolt =3D <1140000>;
+=09=09regulator-max-step-microvolt =3D <150000>;
+=09=09regulator-always-on;
+=09};
+};
+
+&pmi8994_spmi_regulators {
+=09vdd_gfx: s2 {
+=09=09regulator-name =3D "vdd-gfx";
+=09=09regulator-min-microvolt =3D <980000>;
+=09=09regulator-max-microvolt =3D <1230000>;
+=09};
+};
+
+&q6asmdai {
+=09#address-cells =3D <1>;
+=09#size-cells =3D <0>;
+
+=09dai@0 {
+=09=09reg =3D <0>;
+=09};
+
+=09dai@1 {
+=09=09reg =3D <1>;
+=09};
+
+=09dai@2 {
+=09=09reg =3D <2>;
+=09};
+};
+
+&rpm_requests {
+=09regulators {
+=09=09compatible =3D "qcom,rpm-pm8994-regulators";
+
+=09=09vreg_s3a_1p3: s3 {
+=09=09=09regulator-name =3D "vreg_s3a_1p3";
+=09=09=09regulator-min-microvolt =3D <1300000>;
+=09=09=09regulator-max-microvolt =3D <1300000>;
+=09=09};
+
+=09=09vreg_s4a_1p8: s4 {
+=09=09=09regulator-name =3D "vreg_s4a_1p8";
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09=09regulator-always-on;
+=09=09};
+
+=09=09vreg_s5a_2p15: s5 {
+=09=09=09regulator-name =3D "vreg_s5a_2p15";
+=09=09=09regulator-min-microvolt =3D <2150000>;
+=09=09=09regulator-max-microvolt =3D <2150000>;
+=09=09};
+
+=09=09vreg_s7a_0p8: s7 {
+=09=09=09regulator-name =3D "vreg_s7a_0p8";
+=09=09=09regulator-min-microvolt =3D <800000>;
+=09=09=09regulator-max-microvolt =3D <800000>;
+=09=09};
+
+=09=09vreg_l1a_1p0: l1 {
+=09=09=09regulator-name =3D "vreg_l1a_1p0";
+=09=09=09regulator-min-microvolt =3D <1000000>;
+=09=09=09regulator-max-microvolt =3D <1000000>;
+=09=09};
+
+=09=09vreg_l2a_1p25: l2 {
+=09=09=09regulator-name =3D "vreg_l2a_1p25";
+=09=09=09regulator-min-microvolt =3D <1250000>;
+=09=09=09regulator-max-microvolt =3D <1250000>;
+=09=09=09regulator-allow-set-load;
+=09=09};
+
+=09=09vreg_l3a_1p1: l3 {
+=09=09=09regulator-name =3D "vreg_l3a_1p1";
+=09=09=09regulator-min-microvolt =3D <1100000>;
+=09=09=09regulator-max-microvolt =3D <1100000>;
+=09=09};
+
+=09=09vreg_l4a_1p225: l4 {
+=09=09=09regulator-name =3D "vreg_l4a_1p225";
+=09=09=09regulator-min-microvolt =3D <1225000>;
+=09=09=09regulator-max-microvolt =3D <1225000>;
+=09=09};
+
+=09=09vreg_l6a_1p2: l6 {
+=09=09=09regulator-name =3D "vreg_l6a_1p2";
+=09=09=09regulator-min-microvolt =3D <1200000>;
+=09=09=09regulator-max-microvolt =3D <1200000>;
+=09=09};
+
+=09=09vreg_l7a_1p8: l7 {
+=09=09=09regulator-name =3D "vreg_l7a_1p8";
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09};
+
+=09=09vreg_l9a_1p8: l9 {
+=09=09=09regulator-name =3D "vreg_l9a_1p8";
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09};
+
+=09=09vreg_l10a_1p8: l10 {
+=09=09=09regulator-name =3D "vreg_l10a_1p8";
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09};
+
+=09=09vreg_l11a_1p15: l11 {
+=09=09=09regulator-name =3D "vreg_l11a_1p15";
+=09=09=09regulator-min-microvolt =3D <1150000>;
+=09=09=09regulator-max-microvolt =3D <1150000>;
+=09=09};
+
+=09=09vreg_l12a_1p8: l12 {
+=09=09=09regulator-name =3D "vreg_l12a_1p8";
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09=09regulator-allow-set-load;
+=09=09};
+
+=09=09vreg_l13a_2p95: l13 {
+=09=09=09regulator-name =3D "vreg_l13a_2p95";
+=09=09=09regulator-min-microvolt =3D <2950000>;
+=09=09=09regulator-max-microvolt =3D <2950000>;
+=09=09};
+
+=09=09vreg_l16a_2p7: l16 {
+=09=09=09regulator-name =3D "vreg_l16a_2p7";
+=09=09=09regulator-min-microvolt =3D <2700000>;
+=09=09=09regulator-max-microvolt =3D <2700000>;
+=09=09};
+
+=09=09vreg_l17a_2p6: l17 {
+=09=09=09regulator-name =3D "vreg_l17a_2p6";
+=09=09=09regulator-min-microvolt =3D <2600000>;
+=09=09=09regulator-max-microvolt =3D <2600000>;
+=09=09};
+
+=09=09vreg_l18a_3p3: l18 {
+=09=09=09regulator-name =3D "vreg_l18a_3p3";
+=09=09=09regulator-min-microvolt =3D <3300000>;
+=09=09=09regulator-max-microvolt =3D <3300000>;
+=09=09};
+
+=09=09vreg_l19a_3p0: l19 {
+=09=09=09regulator-name =3D "vreg_l19a_3p0";
+=09=09=09regulator-min-microvolt =3D <3000000>;
+=09=09=09regulator-max-microvolt =3D <3000000>;
+=09=09};
+
+=09=09vreg_l20a_2p95: l20 {
+=09=09=09regulator-name =3D "vreg_l20a_2p95";
+=09=09=09regulator-min-microvolt =3D <2950000>;
+=09=09=09regulator-max-microvolt =3D <2950000>;
+=09=09=09regulator-allow-set-load;
+=09=09};
+
+=09=09vreg_l21a_2p95: l21 {
+=09=09=09regulator-name =3D "vreg_l21a_2p95";
+=09=09=09regulator-min-microvolt =3D <2950000>;
+=09=09=09regulator-max-microvolt =3D <2950000>;
+=09=09=09regulator-allow-set-load;
+=09=09=09regulator-system-load =3D <200000>;
+=09=09};
+
+=09=09vreg_l22a_3p0: l22 {
+=09=09=09regulator-name =3D "vreg_l22a_3p0";
+=09=09=09regulator-min-microvolt =3D <3000000>;
+=09=09=09regulator-max-microvolt =3D <3300000>;
+=09=09};
+
+=09=09vreg_l23a_2p8: l23 {
+=09=09=09regulator-name =3D "vreg_l23a_2p8";
+=09=09=09regulator-min-microvolt =3D <2800000>;
+=09=09=09regulator-max-microvolt =3D <2800000>;
+=09=09};
+
+=09=09vreg_l24a_3p075: l24 {
+=09=09=09regulator-name =3D "vreg_l24a_3p075";
+=09=09=09regulator-min-microvolt =3D <3075000>;
+=09=09=09regulator-max-microvolt =3D <3075000>;
+=09=09};
+
+=09=09vreg_l25a_1p2: l25 {
+=09=09=09regulator-name =3D "vreg_l25a_1p2";
+=09=09=09regulator-min-microvolt =3D <1200000>;
+=09=09=09regulator-max-microvolt =3D <1200000>;
+=09=09=09regulator-allow-set-load;
+=09=09=09regulator-always-on;
+=09=09};
+
+=09=09vreg_l27a_1p2: l27 {
+=09=09=09regulator-name =3D "vreg_l27a_1p2";
+=09=09=09regulator-min-microvolt =3D <1200000>;
+=09=09=09regulator-max-microvolt =3D <1200000>;
+=09=09};
+
+=09=09vreg_l28a_0p925: l28 {
+=09=09=09regulator-name =3D "vreg_l28a_0p925";
+=09=09=09regulator-min-microvolt =3D <925000>;
+=09=09=09regulator-max-microvolt =3D <925000>;
+=09=09=09regulator-allow-set-load;
+=09=09};
+
+=09=09vreg_l29a_2p8: l29 {
+=09=09=09regulator-name =3D "vreg_l29a_2p8";
+=09=09=09regulator-min-microvolt =3D <2800000>;
+=09=09=09regulator-max-microvolt =3D <2800000>;
+=09=09};
+
+=09=09vreg_l30a_1p8: l30 {
+=09=09=09regulator-name =3D "vreg_l30a_1p8";
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09};
+
+=09=09vreg_l32a_1p8: l32 {
+=09=09=09regulator-name =3D "vreg_l32a_1p8";
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09};
+=09};
+};
+
+&slpi_pil {
+=09status =3D "okay";
+};
+
+&sound {
+=09compatible =3D "qcom,apq8096-sndcard";
+=09model =3D "OnePlus3";
+=09audio-routing =3D "RX_BIAS", "MCLK",
+=09=09=09"AMIC2", "MIC BIAS2",
+=09=09=09"MIC BIAS2", "Headset Mic",
+=09=09=09"AMIC4", "MIC BIAS1",
+=09=09=09"MIC BIAS1", "Primary Mic",
+=09=09=09"AMIC5", "MIC BIAS3",
+=09=09=09"MIC BIAS3", "Noise Mic";
+
+=09mm1-dai-link {
+=09=09link-name =3D "MultiMedia1";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+=09=09};
+=09};
+
+=09mm2-dai-link {
+=09=09link-name =3D "MultiMedia2";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+=09=09};
+=09};
+
+=09mm3-dai-link {
+=09=09link-name =3D "MultiMedia3";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+=09=09};
+=09};
+
+=09mm4-dai-link {
+=09=09link-name =3D "MultiMedia4";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA4>;
+=09=09};
+=09};
+
+=09mm5-dai-link {
+=09=09link-name =3D "MultiMedia5";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA5>;
+=09=09};
+=09};
+
+=09mm6-dai-link {
+=09=09link-name =3D "MultiMedia6";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA6>;
+=09=09};
+=09};
+
+=09mm7-dai-link {
+=09=09link-name =3D "MultiMedia7";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA7>;
+=09=09};
+=09};
+
+=09mm8-dai-link {
+=09=09link-name =3D "MultiMedia8";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA8>;
+=09=09};
+=09};
+
+=09mm9-dai-link {
+=09=09link-name =3D "MultiMedia9";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA9>;
+=09=09};
+=09};
+
+=09mm10-dai-link {
+=09=09link-name =3D "MultiMedia10";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA10>;
+=09=09};
+=09};
+
+=09mm11-dai-link {
+=09=09link-name =3D "MultiMedia11";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA11>;
+=09=09};
+=09};
+
+=09mm12-dai-link {
+=09=09link-name =3D "MultiMedia12";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA12>;
+=09=09};
+=09};
+
+=09mm13-dai-link {
+=09=09link-name =3D "MultiMedia13";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA13>;
+=09=09};
+=09};
+
+=09mm14-dai-link {
+=09=09link-name =3D "MultiMedia14";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA14>;
+=09=09};
+=09};
+
+=09mm15-dai-link {
+=09=09link-name =3D "MultiMedia15";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA15>;
+=09=09};
+=09};
+
+=09mm16-dai-link {
+=09=09link-name =3D "MultiMedia16";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA16>;
+=09=09};
+=09};
+
+=09slim-dai-link {
+=09=09link-name =3D "SLIM Playback";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6afedai SLIMBUS_6_RX>;
+=09=09};
+
+=09=09platform {
+=09=09=09sound-dai =3D <&q6routing>;
+=09=09};
+
+=09=09codec {
+=09=09=09sound-dai =3D <&wcd9335 AIF4_PB>;
+=09=09};
+=09};
+
+=09slimcap-dai-link {
+=09=09link-name =3D "SLIM Capture";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6afedai SLIMBUS_0_TX>;
+=09=09};
+
+=09=09platform {
+=09=09=09sound-dai =3D <&q6routing>;
+=09=09};
+
+=09=09codec {
+=09=09=09sound-dai =3D <&wcd9335 AIF1_CAP>;
+=09=09};
+=09};
+
+=09speaker-dai-link {
+=09=09link-name =3D "Speaker";
+
+=09=09cpu {
+=09=09=09sound-dai =3D <&q6afedai QUATERNARY_MI2S_RX>;
+=09=09};
+
+=09=09codec {
+=09=09=09sound-dai =3D <&tfa9890_amp>;
+=09=09};
+=09};
+};
+
+&tlmm {
+=09gpio-reserved-ranges =3D <81 4>;
+
+=09mdss_dsi_active: mdss-dsi-active-state {
+=09=09pins =3D "gpio8";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <8>;
+=09=09bias-disable;
+=09};
+
+=09mdss_dsi_suspend: mdss-dsi-suspend-state {
+=09=09pins =3D "gpio8";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-down;
+=09};
+
+=09mdss_te_active: mdss-te-active-state {
+=09=09pins =3D "gpio10";
+=09=09function =3D "mdp_vsync";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-down;
+=09};
+
+=09mdss_te_suspend: mdss-te-suspend-state {
+=09=09pins =3D "gpio10";
+=09=09function =3D "mdp_vsync";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-down;
+=09};
+
+=09touch_default: touch-default-state {
+=09=09pins =3D "gpio89", "gpio125", "gpio49";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <16>;
+=09=09bias-pull-up;
+=09};
+
+=09touch_suspend: touch-suspend-state {
+=09=09pins =3D "gpio89", "gpio125", "gpio49";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+};
+
+&ufsphy {
+=09vdda-phy-supply =3D <&vreg_l28a_0p925>;
+=09vdda-pll-supply =3D <&vreg_l12a_1p8>;
+=09vddp-ref-clk-supply =3D <&vreg_l25a_1p2>;
+
+=09status =3D "okay";
+};
+
+&ufshc {
+=09vcc-supply =3D <&vreg_l20a_2p95>;
+=09vccq-supply =3D <&vreg_l25a_1p2>;
+=09vccq2-supply =3D <&vreg_s4a_1p8>;
+
+=09vcc-max-microamp =3D <600000>;
+=09vccq-max-microamp =3D <450000>;
+=09vccq2-max-microamp =3D <450000>;
+
+=09status =3D "okay";
+};
+
+&usb3 {
+=09status =3D "okay";
+};
+
+&usb3_dwc3 {
+=09phys =3D <&hsusb_phy1>;
+=09phy-names =3D "usb2-phy";
+
+=09maximum-speed =3D "high-speed";
+};
+
+&venus {
+=09status =3D "okay";
+};
+
+&wcd9335 {
+=09clock-names =3D "mclk", "slimbus";
+=09clocks =3D <&div1_mclk>,
+=09=09 <&rpmcc RPM_SMD_BB_CLK1>;
+
+=09vdd-buck-supply =3D <&vreg_s4a_1p8>;
+=09vdd-buck-sido-supply =3D <&vreg_s4a_1p8>;
+=09vdd-tx-supply =3D <&vreg_s4a_1p8>;
+=09vdd-rx-supply =3D <&vreg_s4a_1p8>;
+=09vdd-io-supply =3D <&vreg_s4a_1p8>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts b/arch/arm64/boo=
t/dts/qcom/msm8996-oneplus3.dts
new file mode 100644
index 000000000000..1bdc1b134305
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Harry Austen <hpausten@protonmail.com>
+ */
+
+/dts-v1/;
+
+#include "msm8996-oneplus-common.dtsi"
+
+/ {
+=09model =3D "OnePlus 3";
+=09compatible =3D "oneplus,oneplus3", "qcom,msm8996";
+=09chassis-type =3D "handset";
+=09qcom,board-id =3D <8 0 15801 15>, <8 0 15801 16>;
+=09qcom,msm-id =3D <246 0x30001>;
+};
+
+&adsp_pil {
+=09firmware-name =3D "qcom/msm8996/oneplus3/adsp.mbn";
+};
+
+&battery {
+=09charge-full-design-microamp-hours =3D <3000000>;
+=09voltage-max-design-microvolt =3D <4350000>;
+};
+
+&gpu {
+=09zap-shader {
+=09=09firmware-name =3D "qcom/msm8996/oneplus3/a530_zap.mbn";
+=09};
+};
+
+&mss_pil {
+=09firmware-name =3D "qcom/msm8996/oneplus3/mba.mbn",
+=09=09=09"qcom/msm8996/oneplus3/modem.mbn";
+};
+
+&slpi_pil {
+=09firmware-name =3D "qcom/msm8996/oneplus3/slpi.mbn";
+};
+
+&venus {
+=09firmware-name =3D "qcom/msm8996/oneplus3/venus.mbn";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts b/arch/arm64/bo=
ot/dts/qcom/msm8996-oneplus3t.dts
new file mode 100644
index 000000000000..34f837dd0c12
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Harry Austen <hpausten@protonmail.com>
+ */
+
+/dts-v1/;
+
+#include "msm8996-oneplus-common.dtsi"
+
+/ {
+=09model =3D "OnePlus 3T";
+=09compatible =3D "oneplus,oneplus3t", "qcom,msm8996";
+=09chassis-type =3D "handset";
+=09qcom,board-id =3D <8 0 15811 26>,
+=09=09=09<8 0 15811 27>,
+=09=09=09<8 0 15811 28>;
+};
+
+&adsp_pil {
+=09firmware-name =3D "qcom/msm8996/oneplus3t/adsp.mbn";
+};
+
+&battery {
+=09charge-full-design-microamp-hours =3D <3400000>;
+=09voltage-max-design-microvolt =3D <4400000>;
+};
+
+&gpu {
+=09zap-shader {
+=09=09firmware-name =3D "qcom/msm8996/oneplus3t/a530_zap.mbn";
+=09};
+};
+
+&mss_pil {
+=09firmware-name =3D "qcom/msm8996/oneplus3t/mba.mbn",
+=09=09=09"qcom/msm8996/oneplus3t/modem.mbn";
+};
+
+&slpi_pil {
+=09firmware-name =3D "qcom/msm8996/oneplus3t/slpi.mbn";
+};
+
+&venus {
+=09firmware-name =3D "qcom/msm8996/oneplus3t/venus.mbn";
+};
--
2.38.1


