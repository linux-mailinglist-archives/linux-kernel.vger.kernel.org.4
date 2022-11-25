Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73898639266
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiKYXsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKYXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:47:38 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A055B5AD;
        Fri, 25 Nov 2022 15:47:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DC045C00C8;
        Fri, 25 Nov 2022 18:47:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 18:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669420036; x=1669506436; bh=Fj
        nmw3+n3dnO65hbN9PfmiuCI87wjbUsQApmVRUHJck=; b=LrQGhxsTifnfT2U4m9
        2hipkk9b9WWNVTVyVuPGjkpTPDSYtzuOGcRVBYFp/e/16f9VGqqrX9i7s1maBtCF
        znlPEOjtE4Sv/bEc1FhXAqvWafeWbVDgcXQJ2svNz4nzw8pyj+//FGqZGisP7rcA
        aJqUPzym9ZfLyoX5H94+bylk+KxuY6lD/GT+lAXPVK2WlEraRad2fh8NpVHMERFh
        KePSRPYX0zuaPcVcoXp5wzL8z45Me2eMbBtodHWEorKI5BXHvAyuRqrJhuyMKTIg
        qhG5bsEQmaDsDaTJcCClf0eE1/wkmM56D/M4X86gJ4oh3M5Pcl8Fo7b80hIaO/hw
        7S+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669420036; x=1669506436; bh=Fjnmw3+n3dnO6
        5hbN9PfmiuCI87wjbUsQApmVRUHJck=; b=N/2YxGT1/tcoHFSiTpf0vgQs9xAEe
        ezn+Swd2OW2HvNuqDpo/uIIix4xRTyu+wjiLaAf9cXrSReJ0miMBYt0t4S9KV5j5
        3qUlRZBgp5mZ57lR6cDmsjMX0kiUanaB6jVGtz4CL3wZLRoP3Npx9cDEODwpQVMR
        wGNesVjrZWoaeOMgToqHwaDywP7wX42j7O/QYsfFT0HaSVOe9+L5I8VNZ4JB7ChL
        LPoDIxGV7PQdm3pXcCpDGcKP5z8CMPwJS31u2tc1a9jNMsb24svTpUxAhjLxONpd
        KVW4Gh+a6mX6ovFCUNjo9xMxC/no2of1dARBGgnUL7IhWt9b5ltVGh+zw==
X-ME-Sender: <xms:BFSBY6_fa7vw0_FwyFptB-A8Zsmi2BmvyeKSr1dQBdHHw-QBicxojg>
    <xme:BFSBY6uTL_f9WNbplR-OBkJqL45i5bKKmL4g9XUxKSEfcvFfhPfwn-mSWJhkvKPMT
    xEVC2jJjA7GGHkYcg>
X-ME-Received: <xmr:BFSBYwDa8WBGmUNe10cmwxJCDrOdrd1qWPlIoVxKkw_V2dbUY6-JUcMs77AeG6b9xIf69nUsX28XZ-wXBv9faVdTk4Oa_5Z2DQOKyKHduuQ3912jTvyXMU-QiW-xcXj0Gmc5qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:BFSBYyc-uc3Ogs58FBhmUN-l5Coj3xPtJCFSKGe4lds4wTMGhY5PHA>
    <xmx:BFSBY_NE7l_NOzb-aL6zmlwXJhbx0ZqnKOX4EBIR8l7xznONmoQWRg>
    <xmx:BFSBY8lJULXM_JjWm8yky_AT-wu5GU_k5qI_SydjuiudoNkn4gZibA>
    <xmx:BFSBYyO1lu7WVySxYjo1q7ouw4Hfww6TLx6klT8VvdylvKDh2YinRA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 18:47:14 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: [PATCH v2 10/12] riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
Date:   Fri, 25 Nov 2022 17:46:54 -0600
Message-Id: <20221125234656.47306-11-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221125234656.47306-1-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clockwork Tech manufactures several SoMs for their RasPi CM3-compatible
"ClockworkPi" mainboard. Their R-01 SoM features the Allwinner D1 SoC.
The R-01 contains only the CPU, DRAM, and always-on voltage regulation;
it does not merit a separate devicetree.

The ClockworkPi mainboard features analog audio, a MIPI-DSI panel, USB
host and peripheral ports, an Ampak AP6256 WiFi/Bluetooth module, and an
X-Powers AXP228 PMIC for managing a Li-ion battery.

The DevTerm is a complete system which extends the ClockworkPi mainboard
with a MIPI-DSI panel and a pair of expansion boards. These expansion
boards provide a fan, a USB keyboard, speakers, and a thermal printer.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Added PMIC GPIO controller node (binding merged for 6.2)

 arch/riscv/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 253 ++++++++++++++++++
 .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  36 +++
 3 files changed, 291 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts

diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
index 87f70b1af6b4..1c91be38ea16 100644
--- a/arch/riscv/boot/dts/allwinner/Makefile
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-clockworkpi-v3.14.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-devterm-v3.14.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-dongshan-nezha-stu.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-480p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-720p.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
new file mode 100644
index 000000000000..4289e724f948
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+
+#include "sun20i-d1.dtsi"
+#include "sun20i-common-regulators.dtsi"
+
+/ {
+	model = "ClockworkPi v3.14 (R-01)";
+	compatible = "clockwork,r-01-clockworkpi-v3.14", "allwinner,sun20i-d1";
+
+	aliases {
+		ethernet0 = &ap6256;
+		mmc0 = &mmc0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/*
+	 * This regulator is PWM-controlled, but the PWM controller is not
+	 * yet supported, so fix the regulator to its default voltage.
+	 */
+	reg_vdd_cpu: vdd-cpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 11 GPIO_ACTIVE_LOW>; /* PG11/GPIO3 */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu>;
+};
+
+&dcxo {
+	clock-frequency = <24000000>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-0 = <&i2c0_pb10_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	axp221: pmic@34 {
+		compatible = "x-powers,axp228", "x-powers,axp221";
+		reg = <0x34>;
+		interrupt-parent = <&pio>;
+		interrupts = <4 9 IRQ_TYPE_LEVEL_LOW>; /* PE9/GPIO2 */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		ac_power_supply: ac-power {
+			compatible = "x-powers,axp221-ac-power-supply";
+		};
+
+		axp_adc: adc {
+			compatible = "x-powers,axp221-adc";
+			#io-channel-cells = <1>;
+		};
+
+		battery_power_supply: battery-power {
+			compatible = "x-powers,axp221-battery-power-supply";
+		};
+
+		axp_gpio: gpio {
+			compatible = "x-powers,axp221-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		regulators {
+			x-powers,dcdc-freq = <3000>;
+
+			reg_dcdc1: dcdc1 {
+				regulator-name = "sys-3v3";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-name = "sys-1v8";
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			reg_aldo1: aldo1 {
+				regulator-name = "aud-3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-name = "disp-3v3";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_aldo3: aldo3 {
+				regulator-name = "vdd-wifi";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			/* DLDO1 and ELDO1-3 are connected in parallel. */
+			reg_dldo1: dldo1 {
+				regulator-name = "vbat-wifi-a";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			/* DLDO2-DLDO4 are connected in parallel. */
+			reg_dldo2: dldo2 {
+				regulator-name = "vcc-3v3-ext-a";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_dldo3: dldo3 {
+				regulator-name = "vcc-3v3-ext-b";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_dldo4: dldo4 {
+				regulator-name = "vcc-3v3-ext-c";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_eldo1: eldo1 {
+				regulator-name = "vbat-wifi-b";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_eldo2: eldo2 {
+				regulator-name = "vbat-wifi-c";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_eldo3: eldo3 {
+				regulator-name = "vbat-wifi-d";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+
+		usb_power_supply: usb-power {
+			compatible = "x-powers,axp221-usb-power-supply";
+			status = "disabled";
+		};
+	};
+};
+
+&mmc0 {
+	broken-cd;
+	bus-width = <4>;
+	disable-wp;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10/GPIO4 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pg-supply = <&reg_ldoa>;
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pb8_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pg6_pins>, <&uart1_pg8_rts_cts_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		interrupt-parent = <&pio>;
+		interrupts = <6 17 IRQ_TYPE_LEVEL_HIGH>; /* PG17/GPIO6 */
+		device-wakeup-gpios = <&pio 6 16 GPIO_ACTIVE_HIGH>; /* PG16/GPIO7 */
+		shutdown-gpios = <&pio 6 18 GPIO_ACTIVE_HIGH>; /* PG18/GPIO5 */
+		max-speed = <1500000>;
+		vbat-supply = <&reg_dldo1>;
+		vddio-supply = <&reg_aldo3>;
+	};
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus_power-supply = <&ac_power_supply>;
+	usb1_vbus-supply = <&reg_vcc>;
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
new file mode 100644
index 000000000000..bc5c84f22762
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include "sun20i-d1-clockworkpi-v3.14.dts"
+
+/ {
+	model = "Clockwork DevTerm (R-01)";
+	compatible = "clockwork,r-01-devterm-v3.14",
+		     "clockwork,r-01-clockworkpi-v3.14",
+		     "allwinner,sun20i-d1";
+
+	fan {
+		compatible = "gpio-fan";
+		gpios = <&pio 3 10 GPIO_ACTIVE_HIGH>; /* PD10/GPIO41 */
+		gpio-fan,speed-map = <0    0>,
+				     <6000 1>;
+		#cooling-cells = <2>;
+	};
+
+	i2c-gpio-0 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 3 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PD14/GPIO44 */
+		scl-gpios = <&pio 3 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PD15/GPIO45 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		adc@54 {
+			compatible = "ti,adc101c";
+			reg = <0x54>;
+			interrupt-parent = <&pio>;
+			interrupts = <4 12 IRQ_TYPE_LEVEL_LOW>; /* PE12/GPIO35 */
+			vref-supply = <&reg_dldo2>;
+			#io-channel-cells = <1>;
+		};
+	};
+};
-- 
2.37.4

