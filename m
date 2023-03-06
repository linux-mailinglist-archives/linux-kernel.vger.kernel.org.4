Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D176AB858
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCFIb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCFIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:31:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACECC21287
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:31:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7617012wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9paQOaq2eEB2qjbuVIt0wzXMqlxj1jY9L16aa86PI8=;
        b=ggrN4NuyTni6QREDuDxe2nkm4a6ejQJSi/MPpl6QrJQf3DTcF8wcVCC7sTPkiEpFDd
         fBYazb+nSjZYDS947j9Hx3UaGMb7IQspJt2C8VcnWoBNaLEWe2aBrdi9qjtaK/slc+QD
         NymJpbPGpO9FEU+m8w3FhkvJv/EvadT7Y4z8BKojrhHp2xKVuIJ+dapy4Mqrcxp1mn84
         nyerxSY8MkF+AJDNPnV2KUOmHCX89LBnapEUH8jMNbWHDkf6DFdGJGBizN0zI9cIWFWO
         TBQ6O1birQAfDzA861mVAZWwLj/3ThgPzcyLoSll22y80eCA8D465wZ85tsVunKSPVSm
         U+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9paQOaq2eEB2qjbuVIt0wzXMqlxj1jY9L16aa86PI8=;
        b=E1f6NjyhaPIrBspixZE7R1oecxDITYtV9enQ8OExgRzzlEMw6K/JU+/OpGzlO1XlIv
         CnJ8ik3IKG9ztuBAq88TnzEJFOBudeeLpBVYIqGiGkW1pZW86j9UMQ53C+m/b+xVXEjv
         KxAIako7tB7QPJ7CzjLx9N4eY7BNCTtouXU8yA1HlNtYYiJnH25hlQs/VPVGRKqkg61Y
         fEvSrEWAeFpZ3+aOui8mzNnEntQEk9uroHKqTYlpIjojoU0B5VObgJgTwD9ucoVyyqR8
         Bn7n8k8jiY2WOgX4miEhgNI+nZYOx+J2Hwvq5WHBi71wwX5/GzlrUs0seH6cfBCP5C0B
         u6Ow==
X-Gm-Message-State: AO0yUKUHJoPnRFk0u/o6St51835CKoKaLCVEoWJ3J+wdmRN9ofYN72/G
        dDEGSaVYOyKZ3cKLAhrq0QJJKw==
X-Google-Smtp-Source: AK7set8n4mM9eJH7Un6l4s9q+A2Zc+Dlp9pyCgMQeL9DgW+UE/Bxb9n5SUIAuQS2OMaLK+djQEAb8g==
X-Received: by 2002:a05:600c:5126:b0:3ea:f6c4:3060 with SMTP id o38-20020a05600c512600b003eaf6c43060mr8361298wms.18.1678091501100;
        Mon, 06 Mar 2023 00:31:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003daf7721bb3sm13529724wmb.12.2023.03.06.00.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:31:40 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Mar 2023 09:31:39 +0100
Subject: [PATCH v2 2/2] arm64: dts: amlogic: Add initial support for
 BPI-CM4 module with BPI-CM4IO baseboard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-amlogic-upstream-bpi-cm4-v2-2-2ecfde76fc4d@linaro.org>
References: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for both the BananaPi BPI-CM4 module and the BananaPi
baseboard which is comnpatible with the RaspberryPi CM4IO baseboard.

The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
but with a single HDMI port and a since DSI output.

The current CM4IO baseboard DT should work fine on the Raspberry CM4
baseboard and other derivatives baseboards, but proper DT should
be written for other baseboards.

The split is done so it's easy to describe a new CM4 baseboard, enabling
only the necessary HW used on the baseboard.

[1] https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts  | 165 +++++++++
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi  | 388 +++++++++++++++++++++
 3 files changed, 554 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index ccf1ba57fa87..7acce22434a8 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-cm4io.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
new file mode 100644
index 000000000000..1b0c3881c6a1
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-bananapi-cm4.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "bananapi,bpi-cm4io", "bananapi,bpi-cm4", "amlogic,a311d", "amlogic,g12b";
+	model = "BananaPi BPI-CM4IO Baseboard with BPI-CM4 Module";
+
+	aliases {
+		ethernet0 = &ethmac;
+		i2c0 = &i2c1;
+		i2c1 = &i2c3;
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 2>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "Function";
+			linux,code = <KEY_FN>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	hdmi_connector: hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "BPI-CM4IO";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing =	"TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&cecb_AO {
+	status = "okay";
+};
+
+&ethmac {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+/* CSI port */
+&i2c1 {
+	status = "okay";
+};
+
+/* DSI port for touchscreen */
+&i2c3 {
+	status = "okay";
+};
+
+/* miniPCIe port with USB + SIM slot */
+&pcie {
+	status = "okay";
+};
+
+&sd_emmc_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
+/* Peripheral Only USB-C port */
+&usb {
+	dr_mode = "peripheral";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
new file mode 100644
index 000000000000..97e522921b06
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include "meson-g12b-a311d.dtsi"
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+
+/ {
+	aliases {
+		serial0 = &uart_AO;
+		rtc1 = &vrtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOAO_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	emmc_1v8: regulator-emmc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "EMMC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	dc_in: regulator-dc-in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vddio_c: regulator-vddio-c {
+		compatible = "regulator-gpio";
+		regulator-name = "VDDIO_C";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		enable-gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+		regulator-always-on;
+
+		gpios = <&gpio_ao GPIOAO_9 GPIO_OPEN_DRAIN>;
+		gpios-states = <1>;
+
+		states = <1800000 0>,
+			 <3300000 1>;
+	};
+
+	vddao_1v8: regulator-vddao-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	vddcpu_a: regulator-vddcpu-a {
+		/*
+		 * MP8756GD DC/DC Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU_A";
+		regulator-min-microvolt = <680000>;
+		regulator-max-microvolt = <1040000>;
+
+		pwm-supply = <&dc_in>;
+
+		pwms = <&pwm_ab 0 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddcpu_b: regulator-vddcpu-b {
+		/*
+		 * SY8120B1ABC DC/DC Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU_B";
+		regulator-min-microvolt = <680000>;
+		regulator-max-microvolt = <1040000>;
+
+		pwm-supply = <&dc_in>;
+
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu100 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu101 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu102 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu103 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+/* Ethernet to be enabled in baseboard DT */
+&ethmac {
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rgmii-txid";
+	phy-handle = <&external_phy>;
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+/* HDMI to be enabled in baseboard DT */
+&hdmi_tx {
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&dc_in>;
+};
+
+/* "Camera" I2C bus */
+&i2c1 {
+	pinctrl-0 = <&i2c1_sda_h6_pins>, <&i2c1_sck_h7_pins>;
+	pinctrl-names = "default";
+};
+
+/* Main I2C bus */
+&i2c2 {
+	pinctrl-0 = <&i2c2_sda_x_pins>, <&i2c2_sck_x_pins>;
+	pinctrl-names = "default";
+};
+
+/* "ID" I2C bus */
+&i2c3 {
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+};
+
+&pcie {
+	reset-gpios = <&gpio GPIOA_8 GPIO_ACTIVE_LOW>;
+};
+
+&pwm_ab {
+	pinctrl-0 = <&pwm_a_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin0";
+
+	status = "okay";
+};
+
+&pwm_ef {
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vddao_1v8>;
+
+	status = "okay";
+};
+
+/* on-module SDIO WiFi */
+&sd_emmc_a {
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	sd-uhs-sdr104;
+	max-frequency = <50000000>;
+
+	non-removable;
+	disable-wp;
+
+	/* WiFi firmware requires power in suspend */
+	keep-power-in-suspend;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddao_3v3>;
+
+	status = "okay";
+
+	rtl8822cs: wifi@1 {
+		reg = <1>;
+	};
+};
+
+/* SD card to be enabled in baseboard DT */
+&sd_emmc_b {
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <50000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_c>;
+};
+
+/* on-module eMMC */
+&sd_emmc_c {
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddao_1v8>;
+
+	status = "okay";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+/* on-module UART BT */
+&uart_A {
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8822cs-bt";
+		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
+		device-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&uart_AO {
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&usb {
+	phys = <&usb2_phy0>, <&usb2_phy1>;
+	phy-names = "usb2-phy0", "usb2-phy1";
+};

-- 
2.34.1

