Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5165A836
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiLaXjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiLaXjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:39:02 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1E63DB;
        Sat, 31 Dec 2022 15:39:01 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 94C7A5C00A4;
        Sat, 31 Dec 2022 18:39:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 31 Dec 2022 18:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529940; x=1672616340; bh=BB
        2pm6gcS9z78kZfPAdsSanwNmLBg19PCeoT5bjt0oM=; b=ykwrR7WB8DUZiHaimW
        eZXTeufKJfGC0k+DIw8ssHrvf0bXCTjHpnIGDIiDJE5Q86/+Zh7oFNg3nm4RXOOs
        fucnXVfk028fyeMC1hLi4lcn18AvzfvtxLVDY0UY2uqt/+lk/s3en04G++zwO1Md
        c/qesIBp5zBraFo9ApSAKoyHSEl/JpMCBBGZPRsB5RSu57NG8GWzNe10irL6tDhz
        BRiEj6d9atcXGgzQZv5wBtf7s2nk4LRMTMTE5NBr78KkiKKPxqnhG/jp2mJ0x+gh
        i4q95xG7f6PXyUT6v/UEDESAUYZDxUUqztK2d36ZPU4aDgAAK3c1390ieFrGLEul
        r04w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529940; x=1672616340; bh=BB2pm6gcS9z78
        kZfPAdsSanwNmLBg19PCeoT5bjt0oM=; b=XHV4+55Ytpc+0O0Kk0xU9AINGUipA
        m3ahe0heg43u0eo+1y8WvUxjuzZ0iWlfo64S6UUzq9bpFqbRABAK7SwmyJT0Ztha
        ghSTwJbAW+kR7f63gL+hRf0RA/VZEako2eyp3Cv03DkKpMazN/1mFqRrMe2PigmV
        SmVf5EfBHLxmXuifABW09zCkx2Y4M9Z2lp3tWOWIjJ45qo7m1iGwK0XTTHzDusRL
        QzlSbWW4dyJcm1BEyMGU87e6OCjTUINeuNMqdzoPhDVc2mY4TYXxtmUIiYkqS2px
        o2DQ5YE4fTgC8/ZgGjFDJRqJgYwuMz89n88Po0TsqMTS4H2GJRhR8dPPQ==
X-ME-Sender: <xms:FMiwY_IDHXK4cyOlnQ2b9AWt4JRJya3vT-gyaKDHh37z_NzllBqerA>
    <xme:FMiwYzI29G6gRS430MZtZKHmvnvqXvpO9rK6a_Wlf6jhJrjlChjRyIL5S9nAOjalY
    TVNlIKwAP60yV5sFA>
X-ME-Received: <xmr:FMiwY3tXJPBwFzvf48o0Wq2t-vycmf_Uvo-VadUjM4B7Ghfa8dx6tx4U5u6z5oMd1XMC74mW0D-4eUBd22LGDpr0pB3JznL7PZakozE5VMgsQYKEFqdmLOTaaCyKaNwDzQuv0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FMiwY4YtWXrfZ5cbpG400oV2r3mHNdf_jyiCHUjLAvhA11pr6AB_DA>
    <xmx:FMiwY2aKqp69U7OaFM-flARvFBkh-D3S94eiZnTu8fHd_HnzrnH0jA>
    <xmx:FMiwY8At41Fc6g38t5yfpyIcTyAP5QmeGaaDohruneQqmDPfb3L4ZQ>
    <xmx:FMiwY7KsncAQLm_2gsR-i_lpHh3qCCtl2LePkd7oDbt0Ck2Ivt8S8w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:38:59 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 05/12] riscv: dts: allwinner: Add MangoPi MQ devicetree
Date:   Sat, 31 Dec 2022 17:38:44 -0600
Message-Id: <20221231233851.24923-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MangoPi MQ is a tiny SBC built around the Allwinner D1s. Its
onboard peripherals include two USB Type-C ports (1 device, 1 host)
and RTL8189FTV WLAN.

A MangoPi MQ-R variant of the board also exists. The MQ-R has a
different form factor, but the onboard peripherals are the same.

Most D1 and D1s boards use a similar power tree, with the 1.8V rail
powered by the SoC's internal LDOA, analog domains powered by ALDO,
and the rest of the board powered by always-on fixed regulators. To
avoid duplication, factor out the regulator information that is
common across boards.

The board also exposes GPIO Port E via a FPC connector, which can
support either a camera or an RMII Ethernet PHY. The additional
regulators supply that connector.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v3)

Changes in v3:
 - Drop mmc aliases
 - Change LED_FUNCTION_BACKLIGHT to LED_FUNCTION_STATUS (the backlight
   regulator is disconnected by default, so this is a standalone LED)

Changes in v2:
 - New patch for v2

 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun20i-common-regulators.dtsi   |  35 +++++
 .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 134 ++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 0c97d673b775..f0d9f89054f8 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+subdir-y += allwinner
 subdir-y += sifive
 subdir-y += starfive
 subdir-y += canaan
diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
new file mode 100644
index 000000000000..2f2792594f7d
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1s-mangopi-mq.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
new file mode 100644
index 000000000000..de1adf2a2759
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+/ {
+	reg_vcc: vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_vcc_3v3: vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc>;
+	};
+};
+
+&pio {
+	vcc-pb-supply = <&reg_vcc_3v3>;
+	vcc-pc-supply = <&reg_vcc_3v3>;
+	vcc-pd-supply = <&reg_vcc_3v3>;
+	vcc-pe-supply = <&reg_vcc_3v3>;
+	vcc-pf-supply = <&reg_vcc_3v3>;
+	vcc-pg-supply = <&reg_vcc_3v3>;
+};
+
+&reg_ldoa {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	ldo-in-supply = <&reg_vcc_3v3>;
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
new file mode 100644
index 000000000000..2ad00b38d50b
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/dts-v1/;
+
+#include "sun20i-d1s.dtsi"
+#include "sun20i-common-regulators.dtsi"
+
+/ {
+	model = "MangoPi MQ";
+	compatible = "widora,mangopi-mq", "allwinner,sun20i-d1s";
+
+	aliases {
+		ethernet0 = &rtl8189ftv;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 3 22 GPIO_ACTIVE_LOW>; /* PD22 */
+		};
+	};
+
+	reg_avdd2v8: avdd2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2v8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_vcc_3v3>;
+	};
+
+	reg_dvdd: dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&reg_vcc_3v3>;
+	};
+
+	reg_vcc_core: vcc-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-core";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vcc_core>;
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
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
+	vmmc-supply = <&reg_vcc_3v3>;
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
+	vmmc-supply = <&reg_vcc_3v3>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	rtl8189ftv: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pe-supply = <&reg_avdd2v8>;
+};
+
+&reg_ldob {
+	regulator-name = "vcc-dram";
+	regulator-always-on;
+	ldo-in-supply = <&reg_vcc_3v3>;
+};
+
+&uart3 {
+	pinctrl-0 = <&uart3_pb_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc>;
+	status = "okay";
+};
-- 
2.37.4

