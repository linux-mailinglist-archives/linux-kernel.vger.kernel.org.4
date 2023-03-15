Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104286BB849
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjCOPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjCOPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:43:53 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE019126D7;
        Wed, 15 Mar 2023 08:43:29 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id A83A641857;
        Wed, 15 Mar 2023 20:43:26 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678895007; bh=RcUJzuCROOoVcYmcaBiEn9+oAcYPvhsta/yyIo9418w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lciStMaM3uMvpr79wMCLGAfsTlSgOoI0ui2VlQSZ9FVrdh71qIDmsmoylqcJwSVJV
         ATOhE63vh/51PEoYNNnLcMSTbJyBxIvmUG0wxGhLvxxeiDNBWB/JDHhcu56VlwCc5y
         Zd2EyVH7zuVvZOoMbNAiGMqWohtb8hFlRbbNzlXL052gZZEdkC9OpPnFPFu3BhnrIm
         XvKoDuhlPxQaC3895BtYBh0cp5qPTpKMa2cTwVDrXJGzoDX5YH7+1Wb5Jl5sOneNrz
         HE6KVA0QE9JrUKcROl6njDaqimTqzQqoanXkg8I/d2swsTqsh6lTrhvPnCuB+jii2E
         Uc0SmE3DFeYFQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 4/4] arm64: dts: qcom: Add Acer Aspire 1
Date:   Wed, 15 Mar 2023 20:43:11 +0500
Message-Id: <20230315154311.37299-5-nikita@trvn.ru>
In-Reply-To: <20230315154311.37299-1-nikita@trvn.ru>
References: <20230315154311.37299-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer Aspire 1 is a WoA laptop based on Snapdragon 7c gen1 platform.

The laptop design is similar to trogdor in the choice of primary
components but the specifics on usage of those differ slightly.

Add the devicetree for the laptop with support for most of the
hardware present.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changed in v2:
 - Various styling, ordering and node naming issues fixed. (Krzysztof)

Changed in v3:
 - Kepp camcc on, wakeup on touchpad, minor style issues. (Konrad)
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sc7180-acer-aspire1.dts     | 859 ++++++++++++++++++
 2 files changed, 860 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 89e23a74bc7f..4bd4b4079b17 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-acer-aspire1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
new file mode 100644
index 000000000000..b4161f1f21a7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -0,0 +1,859 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "sc7180.dtsi"
+
+#include "pm6150.dtsi"
+#include "pm6150l.dtsi"
+
+/delete-node/ &tz_mem;
+/delete-node/ &ipa_fw_mem;
+
+/ {
+	model = "Acer Aspire 1";
+	compatible = "acer,aspire1", "qcom,sc7180";
+	chassis-type = "laptop";
+
+	aliases {
+		bluetooth0 = &bluetooth;
+		hsuart0 = &uart3;
+		serial0 = &uart8;
+		wifi0 = &wifi;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		zap_mem: zap-shader@80840000 {
+			reg = <0 0x80840000 0 0x2000>;
+			no-map;
+		};
+
+		venus_mem: venus@85b00000 {
+			reg = <0 0x85b00000 0 0x500000>;
+			no-map;
+		};
+
+		mpss_mem: mpss@86000000 {
+			reg = <0x0 0x86000000 0x0 0x2000000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@8e400000 {
+			reg = <0x0 0x8e400000 0x0 0x2800000>;
+			no-map;
+		};
+
+		wlan_mem: wlan@93900000 {
+			reg = <0x0 0x93900000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
+	max98357a: audio-codec {
+		compatible = "maxim,max98357a";
+		sdmode-gpios = <&tlmm 23 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&amp_sd_mode_default>;
+		pinctrl-names = "default";
+
+		#sound-dai-cells = <0>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&sn65dsi86_bridge 1000000>;
+		enable-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&soc_bkoff_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_brij_1p2: bridge-1p2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "brij_1p2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+
+		gpio = <&tlmm 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&reg_edp_1p2_en_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_brij_1p8: bridge-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "brij_1p8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		vin-supply = <&vreg_l8c_1p8>;
+
+		gpio = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&reg_edp_1p8_en_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_codec_3p3: codec-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "codec_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&reg_audio_en_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_lcm_3p3: panel-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcm_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		/*
+		 * HACK: Display fails with
+		 *
+		 * *ERROR* Unexpected max rate (0x0); assuming 5.4 GHz
+		 * *ERROR* Link training failed, link is off (-5)
+		 *
+		 * if the power to the panel was ever cut
+		 */
+		regulator-always-on;
+
+		gpio = <&tlmm 26 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&reg_lcm_en_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_tp_3p3: touchpad-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "tp_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&reg_tp_en_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&dsi0 {
+	vdda-supply = <&vreg_l3c_1p2>;
+	status = "okay";
+};
+
+&dsi0_out {
+	remote-endpoint = <&sn65dsi86_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&dsi_phy {
+	vdds-supply = <&vreg_l4a_0p8>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* embedded-controller@76 */
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/*
+	 * NOTE: DSDT defines two possible touchpads, other one is
+	 *
+	 * reg = <0x15>;
+	 * hid-descr-addr = <0x1>;
+	 */
+
+	touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+
+		vdd-supply = <&reg_tp_3p3>;
+
+		interrupts-extended = <&tlmm 94 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&hid_touchpad_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+
+	keyboard@3a {
+		compatible = "hid-over-i2c";
+		reg = <0x3a>;
+		hid-descr-addr = <0x1>;
+
+		interrupts-extended = <&tlmm 33 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&hid_keyboard_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+};
+
+&i2c9 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	alc5682: codec@1a {
+		compatible = "realtek,rt5682i";
+		reg = <0x1a>;
+
+		#sound-dai-cells = <1>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <28 IRQ_TYPE_EDGE_BOTH>;
+
+		pinctrl-0 = <&codec_irq_default>;
+		pinctrl-names = "default";
+
+		AVDD-supply = <&vreg_l15a_1p8>;
+		MICVDD-supply = <&reg_codec_3p3>;
+		VBAT-supply = <&reg_codec_3p3>;
+
+		realtek,dmic1-data-pin = <1>;
+		realtek,dmic1-clk-pin = <1>;
+		realtek,jd-src = <1>;
+	};
+};
+
+&i2c10 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	sn65dsi86_bridge: bridge@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		#pwm-cells = <1>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+
+		enable-gpios = <&tlmm 51 GPIO_ACTIVE_HIGH>;
+		suspend-gpios = <&tlmm 22 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&bridge_en_default>,
+			    <&edp_bridge_irq_default>,
+			    <&bridge_suspend_default>;
+		pinctrl-names = "default";
+
+		vpll-supply = <&reg_brij_1p8>;
+		vccio-supply = <&reg_brij_1p8>;
+		vcca-supply = <&reg_brij_1p2>;
+		vcc-supply = <&reg_brij_1p2>;
+
+		clocks = <&rpmhcc RPMH_LN_BB_CLK3>;
+		clock-names = "refclk";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sn65dsi86_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sn65dsi86_out: endpoint {
+					data-lanes = <0 1>;
+					remote-endpoint = <&panel_in_edp>;
+				};
+			};
+		};
+
+		aux-bus {
+			panel: panel {
+				compatible = "edp-panel";
+				power-supply = <&reg_lcm_3p3>;
+				backlight = <&backlight>;
+
+				port {
+					panel_in_edp: endpoint {
+						remote-endpoint = <&sn65dsi86_out>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&zap_mem>;
+		firmware-name = "qcom/sc7180/acer/aspire1/qcdxkmsuc7180.mbn";
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&pm6150_adc {
+	thermistor@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	charger-thermistor@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm6150_adc_tm {
+	status = "okay";
+
+	charger-thermistor@0 {
+		reg = <0>;
+		io-channels = <&pm6150_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	thermistor@1 {
+		reg = <1>;
+		io-channels = <&pm6150_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pm6150_pon {
+	status = "disabled";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sc7180/acer/aspire1/qcmpss7180_nm.mbn";
+	status = "okay";
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc1_default>;
+	pinctrl-1 = <&sdc1_sleep>;
+	pinctrl-names = "default", "sleep";
+	vmmc-supply = <&vreg_l19a_2p9>;
+	vqmmc-supply = <&vreg_l12a_1p8>;
+
+	status = "okay";
+};
+
+&uart3 {
+	/delete-property/interrupts;
+	interrupts-extended = <&intc GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 41 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-1 = <&qup_uart3_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn3991-bt";
+		vddio-supply = <&vreg_l10a_1p8>;
+		vddxo-supply = <&vreg_l1c_1p8>;
+		vddrf-supply = <&vreg_l2c_1p3>;
+		vddch0-supply = <&vreg_l10c_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&uart8 {
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb_hub_2_x: hub@1 {
+		compatible = "usbbda,5411";
+		reg = <1>;
+		peer-hub = <&usb_hub_3_x>;
+	};
+
+	usb_hub_3_x: hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		peer-hub = <&usb_hub_2_x>;
+	};
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l4a_0p8>;
+	vdda-pll-supply = <&vreg_l11a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l17a_3p0>;
+	qcom,imp-res-offset-value = <8>;
+	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_15_PERCENT>;
+	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+	qcom,bias-ctrl-value = <0x22>;
+	qcom,charge-ctrl-value = <3>;
+	qcom,hsdisc-trim-value = <0>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l4a_0p8>;
+
+	status = "okay";
+};
+
+&venus {
+	firmware-name = "qcom/sc7180/acer/aspire1/qcvss7180.mbn";
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&vreg_l9a_0p6>;
+	vdd-1.8-xo-supply = <&vreg_l1c_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l10c_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l11c_3p3>;
+
+	status = "okay";
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm6150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_s1a_1p1: smps1 {
+			regulator-min-microvolt = <1128000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_l4a_0p8: ldo4 {
+			regulator-min-microvolt = <824000>;
+			regulator-max-microvolt = <928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a_0p6: ldo9 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_1p8: ldo10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vreg_l11a_1p8: ldo11 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_1p8: ldo13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p8: ldo15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2496000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18a_2p8: ldo18 {
+			regulator-min-microvolt = <2496000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l19a_2p9: ldo19 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm6150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1120000>;
+			regulator-max-microvolt = <1408000>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1616000>;
+			regulator-max-microvolt = <1984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1168000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1144000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2952000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+	};
+};
+
+&qup_i2c2_default {
+	drive-strength = <2>;
+
+	/* Has external pullup */
+	bias-disable;
+};
+
+&qup_i2c4_default {
+	drive-strength = <2>;
+
+	/* Has external pullup */
+	bias-disable;
+};
+
+&qup_i2c9_default {
+	drive-strength = <2>;
+
+	/* Has external pullup */
+	bias-disable;
+};
+
+&qup_i2c10_default {
+	drive-strength = <2>;
+
+	/* Has external pullup */
+	bias-disable;
+};
+
+&tlmm {
+	/*
+	 * The TZ seem to protect those because some boards can have
+	 * fingerprint sensor connected to this range. Not connected
+	 * on this board
+	 */
+	gpio-reserved-ranges = <58 5>;
+
+	amp_sd_mode_default: amp-sd-mode-deault-state {
+		pins = "gpio23";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	bridge_en_default: bridge-en-default-state {
+		pins = "gpio51";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	bridge_suspend_default: bridge-suspend-default-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+	};
+
+	codec_irq_default: codec-irq-deault-state {
+		pins = "gpio28";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	edp_bridge_irq_default: edp-bridge-irq-default-state {
+		pins = "gpio11";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	hid_keyboard_default: hid-keyboard-default-state {
+		pins = "gpio33";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	hid_touchpad_default: hid-touchpad-default-state {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	qup_uart3_sleep: qup-uart3-sleep-state {
+		cts-pins {
+			/*
+			 * Configure a pull-down on CTS to match the pull of
+			 * the Bluetooth module.
+			 */
+			pins = "gpio38";
+			function = "gpio";
+			bias-pull-down;
+		};
+
+		rts-pins {
+			/*
+			 * Configure pull-down on RTS. As RTS is active low
+			 * signal, pull it low to indicate the BT SoC that it
+			 * can wakeup the system anytime from suspend state by
+			 * pulling RX low (by sending wakeup bytes).
+			 */
+			pins = "gpio39";
+			function = "gpio";
+			bias-pull-down;
+		};
+
+		tx-pins {
+			/*
+			 * Configure pull-up on TX when it isn't actively driven
+			 * to prevent BT SoC from receiving garbage during sleep.
+			 */
+			pins = "gpio40";
+			function = "gpio";
+			bias-pull-up;
+		};
+
+		rx-pins {
+			/*
+			 * Configure a pull-up on RX. This is needed to avoid
+			 * garbage data when the TX pin of the Bluetooth module
+			 * is floating which may cause spurious wakeups.
+			 */
+			pins = "gpio41";
+			function = "gpio";
+			bias-pull-up;
+		};
+	};
+
+	reg_edp_1p2_en_default: reg-edp-1p2-en-deault-state {
+		pins = "gpio19";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	reg_edp_1p8_en_default: reg-edp-1p8-en-deault-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	reg_lcm_en_default: reg-lcm-en-deault-state {
+		pins = "gpio26";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	reg_audio_en_default: reg-audio-en-deault-state {
+		pins = "gpio83";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	reg_tp_en_default: reg-tp-en-deault-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	soc_bkoff_default: soc-bkoff-deault-state {
+		pins = "gpio10";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	sdc1_default: sdc1-default-state {
+		clk-pins {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		cmd-pins {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+
+		data-pins {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+
+		rclk-pins {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	sdc1_sleep: sdc1-sleep-state {
+		clk-pins {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		cmd-pins {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		data-pins {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		rclk-pins {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	ter_mi2s_active: ter-mi2s-active-state {
+		pins = "gpio63", "gpio64", "gpio65";
+		function = "mi2s_2";
+	};
+};
-- 
2.39.2

