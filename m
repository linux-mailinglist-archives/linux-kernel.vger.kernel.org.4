Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC80639261
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKYXsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKYXre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:47:34 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B55A6C3;
        Fri, 25 Nov 2022 15:47:12 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A87995C00FB;
        Fri, 25 Nov 2022 18:47:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 25 Nov 2022 18:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669420031; x=1669506431; bh=gx
        BHetNU3R/dLIimneQ0t7ulehAFSyYZwcuH33p8yS0=; b=yZOR62XcbHVRfe+G68
        32xtXYPGAh//ikrkFKZZCk9hKkjUzb9BdnWWRtBC+qKsvHhdiAdXVbrMmSUkWUGL
        JXli82nRG0hlrNABytTmFNTCUQbYJ//xHhwqBBf3qKpGKzcQ00mZf2n5MiYOhBVg
        TJdZ1MIv7q0jb/RDN9tuVBBeY6ltpUw7u+ADUWph3f1Fqt6AgY9Fll+OX+i2462P
        pPYFSGBhh6Btml6h9lFAywc3PwrHCtZx0/qTQuGGL6MW5q2AXNWAIyJ+ZWFxGp8T
        q4GZUnQLO9gPHGA8etQoUti6rLUCJuALr84U0XaTU/kNuk3x/FpJ8sZMWgMeMOZj
        Ph8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669420031; x=1669506431; bh=gxBHetNU3R/dL
        IimneQ0t7ulehAFSyYZwcuH33p8yS0=; b=dRcrC35k4/0dRLF89miuPX+TCAbTw
        n8XOY0TR7rdUJ5x9LFEw3dKg/XAN1HlV1AQp6YuxkfCXVoK8e9OynuElI2Au6r2V
        pxPwa2V7ARu7nPuJDD/Tc7jLYJEqLNl3eiEsBvB1oSJCpAqD6SzwYCQohYegiO9T
        01ZCBTGykY7QbLV1CktKQnDArHQFKBNcUgfksxsVQ02RZftD7jpYgA/ohDGnZNr1
        aw9dOgWri/sXLpgtGJnXwYEOVAq+X/NsSKPNYFh1AvbdJkbwdYEWVdkf1ohprL87
        5w+pUQPxOZlf3RpwkhIl/nwnmvOn9ZYdoTVmqQegIAuxNyNFnrfDG/56A==
X-ME-Sender: <xms:_1OBYwwnvk3CX5JUE5VnZ4JSJPzNxKNkNkRAiM8mA4YRuKS0n8vxSw>
    <xme:_1OBY0SEEaBFl4w0uK5IAqlhkNvbLrrzyctRxRa8cTKiRjYGd-gncP_vwE4SgJwdW
    UncjiwaNdh4wrotJA>
X-ME-Received: <xmr:_1OBYyXBWsKrrRxJ_hfbd4KzeQ_HBRMNsF1dmc9DlaRr0oecrrXf-V2CA7EpiMXbttUroHpN_HOdkD3SHUCkpIjb79zY9okUNgVLNn8BzMy1iyKJpGtQ0-9FHDtpxCrRnT_bKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:_1OBY-jmKrPZ1pBcht6h8gUpVRIQLs1lE_IoNp_ORkZSmpRrxjY04g>
    <xmx:_1OBYyCF3B7xMiKIpDHzg3DZjcopkwg9GSYXyqyfZO1LpqKfKAQ17g>
    <xmx:_1OBY_IK5j3bSGlJ8AnQz68iIazSqP5lpzUhI0MMUoxgbDel9p-oSA>
    <xmx:_1OBYzzm4SZC3joWithzB-Kls9BARVnZO4B-aJGohTignoYrXHAEMw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 18:47:10 -0500 (EST)
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
Subject: [PATCH v2 07/12] riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
Date:   Fri, 25 Nov 2022 17:46:51 -0600
Message-Id: <20221125234656.47306-8-samuel@sholland.org>
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

Sipeed manufactures a "Lichee RV" system-on-module, which provides a
minimal working system on its own, as well as a few carrier boards. The
"Dock" board provides audio, USB, and WiFi. The "86 Panel" additionally
provides 100M Ethernet and a built-in display panel.

The 86 Panel repurposes the USB ID and VBUS detection GPIOs for its RGB
panel interface, since the USB OTG port is inaccessible inside the case.

Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Added DMIC sound card to Lichee RV dock and Lichee RV 86 Panel
 - Removed LRADC (depends on analog LDOs)

 arch/riscv/boot/dts/allwinner/Makefile        |   4 +
 .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +++++
 .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 ++
 .../sun20i-d1-lichee-rv-86-panel.dtsi         | 118 ++++++++++++++++++
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  96 ++++++++++++++
 .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  88 +++++++++++++
 6 files changed, 345 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts

diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
index 277e59d1c907..f1c70b9dc9bf 100644
--- a/arch/riscv/boot/dts/allwinner/Makefile
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -1,3 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-480p.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-720p.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-dock.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-nezha.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1s-mangopi-mq.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
new file mode 100644
index 000000000000..4df8ffb71561
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include "sun20i-d1-lichee-rv-86-panel.dtsi"
+
+/ {
+	model = "Sipeed Lichee RV 86 Panel (480p)";
+	compatible = "sipeed,lichee-rv-86-panel-480p", "sipeed,lichee-rv",
+		     "allwinner,sun20i-d1";
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pb0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "focaltech,ft6236";
+		reg = <0x48>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 14 IRQ_TYPE_LEVEL_LOW>; /* PG14 */
+		iovcc-supply = <&reg_vcc_3v3>;
+		reset-gpios = <&pio 6 15 GPIO_ACTIVE_LOW>; /* PG15 */
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <480>;
+		vcc-supply = <&reg_vcc_3v3>;
+		wakeup-source;
+	};
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
new file mode 100644
index 000000000000..1874fc05359f
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include "sun20i-d1-lichee-rv-86-panel.dtsi"
+
+/ {
+	model = "Sipeed Lichee RV 86 Panel (720p)";
+	compatible = "sipeed,lichee-rv-86-panel-720p", "sipeed,lichee-rv",
+		     "allwinner,sun20i-d1";
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
new file mode 100644
index 000000000000..65408b7c66ab
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include "sun20i-d1-lichee-rv.dts"
+
+/ {
+	aliases {
+		ethernet0 = &emac;
+		ethernet1 = &xr829;
+	};
+
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		#sound-dai-cells = <0>;
+	};
+
+	dmic-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "DMIC";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			format = "pdm";
+			frame-master = <&link0_cpu>;
+			bitclock-master = <&link0_cpu>;
+
+			link0_cpu: cpu {
+				sound-dai = <&dmic>;
+			};
+
+			link0_codec: codec {
+				sound-dai = <&dmic_codec>;
+			};
+		};
+	};
+
+	/* PC1 is repurposed as BT_WAKE_AP */
+	/delete-node/ leds;
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&ccu CLK_FANOUT1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
+		assigned-clocks = <&ccu CLK_FANOUT1>;
+		assigned-clock-rates = <32768>;
+		pinctrl-0 = <&clk_pg11_pin>;
+		pinctrl-names = "default";
+	};
+};
+
+&dmic {
+	pinctrl-0 = <&dmic_pb11_d0_pin>, <&dmic_pe17_clk_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-0 = <&rmii_pe_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&ext_rmii_phy>;
+	phy-mode = "rmii";
+	phy-supply = <&reg_vcc_3v3>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
+	};
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	xr829: wifi@1 {
+		reg = <1>;
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pg6_pins>, <&uart1_pg8_rts_cts_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* XR829 bluetooth is connected here */
+};
+
+&usb_otg {
+	status = "disabled";
+};
+
+&usbphy {
+	/* PD20 and PD21 are repurposed for the LCD panel */
+	/delete-property/ usb0_id_det-gpios;
+	/delete-property/ usb0_vbus_det-gpios;
+	usb1_vbus-supply = <&reg_vcc>;
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
new file mode 100644
index 000000000000..57a1359193a8
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/input/input.h>
+
+#include "sun20i-d1-lichee-rv.dts"
+
+/ {
+	model = "Sipeed Lichee RV Dock";
+	compatible = "sipeed,lichee-rv-dock", "sipeed,lichee-rv",
+		     "allwinner,sun20i-d1";
+
+	aliases {
+		ethernet1 = &rtl8723ds;
+	};
+
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		#sound-dai-cells = <0>;
+	};
+
+	dmic-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "DMIC";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			format = "pdm";
+			frame-master = <&link0_cpu>;
+			bitclock-master = <&link0_cpu>;
+
+			link0_cpu: cpu {
+				sound-dai = <&dmic>;
+			};
+
+			link0_codec: codec {
+				sound-dai = <&dmic_codec>;
+			};
+		};
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
+	};
+};
+
+&dmic {
+	pinctrl-0 = <&dmic_pb11_d0_pin>, <&dmic_pe17_clk_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	rtl8723ds: wifi@1 {
+		reg = <1>;
+	};
+};
+
+&ohci1 {
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
+		compatible = "realtek,rtl8723ds-bt";
+		device-wake-gpios = <&pio 6 15 GPIO_ACTIVE_HIGH>; /* PG16 */
+		enable-gpios = <&pio 6 18 GPIO_ACTIVE_HIGH>; /* PG18 */
+		host-wake-gpios = <&pio 6 17 GPIO_ACTIVE_HIGH>; /* PG17 */
+	};
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc>;
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
new file mode 100644
index 000000000000..b1c458fae09e
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/dts-v1/;
+
+#include "sun20i-d1.dtsi"
+#include "sun20i-common-regulators.dtsi"
+
+/ {
+	model = "Sipeed Lichee RV";
+	compatible = "sipeed,lichee-rv", "allwinner,sun20i-d1";
+
+	aliases {
+		mmc0 = &mmc0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 2 1 GPIO_ACTIVE_HIGH>; /* PC1 */
+		};
+	};
+
+	reg_vdd_cpu: vdd-cpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&reg_vcc>;
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
+&ehci0 {
+	status = "okay";
+};
+
+&mmc0 {
+	broken-cd;
+	bus-width = <4>;
+	disable-wp;
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pb8_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 3 21 GPIO_ACTIVE_HIGH>; /* PD21 */
+	usb0_vbus_det-gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
+	usb0_vbus-supply = <&reg_vcc>;
+	status = "okay";
+};
-- 
2.37.4

