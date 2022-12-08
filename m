Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B640646B57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiLHJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiLHJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:03:13 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0DB69313;
        Thu,  8 Dec 2022 01:03:06 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0237732002F9;
        Thu,  8 Dec 2022 04:03:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 08 Dec 2022 04:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670490184; x=1670576584; bh=dI
        bIT4P5wieGBw5OszmyDzETmVoYXCTmhz9Cf8xh/Uc=; b=xm+UtdejQIw5wR4u0P
        F4NiMy09GdOWsnMCtT0S2dMil5ik6jqQWL+KnFomKDr1VnsvMBi8KOSr1Ie+Omuf
        twBjahpGFg5cucLYDtTx4VOtDJtFx9AkLZkPgEkB+BKj5OB+PELZ+SHZQGOfXKIL
        1UMibc6o5cwkVlwyd7Tti1DtAA4xISIkH7LifcwuqoJ2Vpyv4HIg1dAS3/AjL1Hb
        0HdwIRB7K39a1Bq3msRAN7Ty3OIYP8S03iKSUozFEyGQcAkbIprLoTBXNMLwXbZ6
        cTO+Wt1nUJkJmbyOtLqp2bWlsQKXDimYYUHltbiHSwKM4gOvnSvTSGzq2dStIVSD
        92Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670490184; x=1670576584; bh=dIbIT4P5wieGB
        w5OszmyDzETmVoYXCTmhz9Cf8xh/Uc=; b=r5ztzH31d1H3nLdOnTJeBPWMJ7R/x
        QP+A9LxiC0RrqpfGeLn/JZ22G4x2kX3gJGJJHjrEDE7we7XaVKDJyFD71/e8IcXN
        pJPaL4NRyE+AdQiWHPsJSrgVlkNdPwNztqEJrfyiesEReeemVpnhUu3cmQr48xyI
        ME1qzw6H2KP2n1iiVvIGmOAQTS7jE8z+eI3uPoDiIelNLOyJVt1vrKQRnVbEtshj
        zUkDrn5b7iH3La32PfOwsizIQqymjnGAFqNnpKZ9mu8E8CCBM1l7SGAW62SZosL3
        IFWFikxcxUPdLYeCjEZdOOE7p2M/D4VNDs+eHWOREKO4XqrP498CpfhvA==
X-ME-Sender: <xms:SKiRY3qjFgcG0_iAHdw7B5nnzlnMQZS0WcB_HXJz_xw2WyAFd4PGHw>
    <xme:SKiRYxpT8SMs5-qt4sqSvNvgIK7_GeXMMAibuJaAQuS1Bd3Yb_PnM9a9mVCzXNJJT
    dxmuhanFWFSPOY7Fw>
X-ME-Received: <xmr:SKiRY0MWwj0bBCrip5DWd-QGlGXUd2pZjSRxE9BaLZp7RCkiDa3KztUSUN9Q6yaHE9iP6W6tBENM-Vg7u68zYMq0XUWhA7Aeha_MXkmAtAVpZAdXC-aEvecCkC2_AvPpIxwLog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:SKiRY64YS5C3muz9LVsfjWF0RMgZvDYZasWisWaOKK2Db8gSbHht4A>
    <xmx:SKiRY26a0chIBC7eQrHSF7K_3eVXdTA5r05ml09YzY69bTNLJr0oYw>
    <xmx:SKiRYygxTBQLUFv26EIxfsGvAAAhOuZLZbCnRGKXb9gFrL5K4iWOhw>
    <xmx:SKiRY1TP2r8Gq-ztsVuGkWJVSUNIVCin6zUIWqJQipi5b8BNl5o5CA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:03:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 07/12] riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
Date:   Thu,  8 Dec 2022 03:02:32 -0600
Message-Id: <20221208090237.20572-8-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208090237.20572-1-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Fix `make W=1 dtbs` warnings (missing reg properties)
 - Drop mmc alias

Changes in v2:
 - Added DMIC sound card to Lichee RV dock and Lichee RV 86 Panel
 - Removed LRADC (depends on analog LDOs)

 arch/riscv/boot/dts/allwinner/Makefile        |   4 +
 .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +++++
 .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 ++
 .../sun20i-d1-lichee-rv-86-panel.dtsi         | 119 ++++++++++++++++++
 .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  97 ++++++++++++++
 .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  87 +++++++++++++
 6 files changed, 346 insertions(+)
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
index 000000000000..6cc7dd0c1ae2
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
@@ -0,0 +1,119 @@
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
+			reg = <0>;
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
index 000000000000..52b91e1affed
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
@@ -0,0 +1,97 @@
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
+			reg = <0>;
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
index 000000000000..d60a0562a8b1
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
@@ -0,0 +1,87 @@
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

