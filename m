Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073E65A837
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiLaXjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiLaXjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:39:03 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716B65A6;
        Sat, 31 Dec 2022 15:39:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D82D65C00AB;
        Sat, 31 Dec 2022 18:39:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529941; x=1672616341; bh=J6
        rVARyJw3muIrcP2dT3zZNyK79SVGldDrAhgT6GSYM=; b=lPOqAUz8H+7uJm+eKd
        ECf73YRfEL4S9dsCWvL0/k+7QWyhwJ+iPYLu3mDlqDVx4DFn+Hu1I9S67GcDMu0K
        5VcR7ABPDgfwpkdADgE1/ujAZpsod21npMYOvNYDfFxBzkdftcXFOeUVqwStU4Xk
        ZE5JrvXdzYHAqZkFEyW3QfSm1YIx2gwBDmbJM+5PGWmDrZDCP8VODFRZNrlE0Smz
        fUwtrEe2A6DOgc3om9OshOMsqGJJc7kHQ4agk9MAzWVBNffrYHOENWA1zBF9Nihi
        +UZrHOT5SHf7XEDS3LSrG3lFee+VKv6bKJ/Pq46Sdlz95KKGhUNp47cXN4ZjMSj+
        +GgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529941; x=1672616341; bh=J6rVARyJw3muI
        rcP2dT3zZNyK79SVGldDrAhgT6GSYM=; b=XxfBgMmF8pYlC19NjFs/qVpaISWiJ
        6d1kfpASWIFphk08oShxXVGnzTJApJcGjI3nNOxpizqpeoFZpEjt4cxaKurT7pLF
        DlLICqP75zHDUtaFHGmszWHG5PgY6zCY7w5OWMnQxF1X+KRdBbYh1pMktS53pI02
        Y+9aPW06ptUoLdHM+MFyh1HLF9vWNjQ1RBjmLLsENXKcTJC9mXz/6W+GOFNbUFsA
        gReMcxK89RmxZBr2VE0+y5V+vsMjNP5ExwFR6q8HxOkKBszkCtshPc9jPS8GenM2
        tK3+43J22P/RbFLMCzrVxJoWJ9WHb8eLq4+DgJxJMO9zHnmYybx49fjRw==
X-ME-Sender: <xms:FciwY_qh4qtmxlNQRIeSGcI4scUl5M9_S7sQjgbliNy9Kz18lcCopQ>
    <xme:FciwY5qvczNk-VtOUhsAAvuAQ853GaNj0u0gl6-4fNbBXS_35CNaowCeBEDDHZDjm
    _77TzDG5c2v4YVSJg>
X-ME-Received: <xmr:FciwY8N4Xj1_x853Y262PYPP7BhfXsckhsvJEe4Mnq_U6ljD_iyZVj4EVbmYxTZzG527vwEWoKprIaW_aA65GKp4FLiUbHvi9P1WPR6xzZSX4KWPuXSoZVRheM--nusU4bQ-3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FciwYy4JYLTmqZYzh4u-i8_pXDuLyW2f3rTvnp57J9ToOTKsizEUbA>
    <xmx:FciwY-4Az6ty2Rd7ogV7kFXQXmT_i-RQ-1ZZPGdq5TBlrtzykQjSPA>
    <xmx:FciwY6jVR-KB8T-sEZGPIX19_1u9ZhW6ZqVrTxnjTbh9qcozzBd0Ow>
    <xmx:FciwY6pYSAc9UWST5ISNLzGrQL1rXdbwl2xYPjSJo5uzBAK1CI-_5w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:39:00 -0500 (EST)
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
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 06/12] riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
Date:   Sat, 31 Dec 2022 17:38:45 -0600
Message-Id: <20221231233851.24923-7-samuel@sholland.org>
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

"D1 Nezha" is Allwinner's first-party development board for the D1 SoC.
It was shipped with 512M, 1G, or 2G of DDR3. It supports onboard audio,
HDMI, gigabit Ethernet, WiFi and Bluetooth, USB 2.0 host and OTG ports,
plus low-speed I/O from the SoC and a GPIO expander chip.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v3)

Changes in v3:
 - Drop mmc alias

Changes in v2:
 - Common regulators moved to MangoPi MQ patch, removed analog LDOs
 - Removed LRADC (depends on analog LDOs)
 - Added XR829 host-wake interrupt

 arch/riscv/boot/dts/allwinner/Makefile        |   1 +
 .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 166 ++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts

diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
index 2f2792594f7d..277e59d1c907 100644
--- a/arch/riscv/boot/dts/allwinner/Makefile
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-nezha.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1s-mangopi-mq.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
new file mode 100644
index 000000000000..a0769185be97
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/dts-v1/;
+
+#include "sun20i-d1.dtsi"
+#include "sun20i-common-regulators.dtsi"
+
+/ {
+	model = "Allwinner D1 Nezha";
+	compatible = "allwinner,d1-nezha", "allwinner,sun20i-d1";
+
+	aliases {
+		ethernet0 = &emac;
+		ethernet1 = &xr829;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_usbvbus: usbvbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbvbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
+		enable-active-high;
+		vin-supply = <&reg_vcc>;
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
+		reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
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
+&ehci1 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-0 = <&rgmii_pe_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&reg_vcc_3v3>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pb0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pcf8574a: gpio@38 {
+		compatible = "nxp,pcf8574a";
+		reg = <0x38>;
+		interrupt-parent = <&pio>;
+		interrupts = <1 2 IRQ_TYPE_LEVEL_LOW>; /* PB2 */
+		interrupt-controller;
+		gpio-controller;
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+	};
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
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
+	xr829: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
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
+	/* XR829 bluetooth is connected here */
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
+	usb0_vbus-supply = <&reg_usbvbus>;
+	usb1_vbus-supply = <&reg_vcc>;
+	status = "okay";
+};
-- 
2.37.4

