Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58202639262
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiKYXsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiKYXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:47:35 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2765B593;
        Fri, 25 Nov 2022 15:47:13 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A1435C00F4;
        Fri, 25 Nov 2022 18:47:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 18:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669420033; x=1669506433; bh=Sl
        r1yxnMUS23NRYZXVWVUiCyyawuZSpR9t3L6Nw1vCA=; b=THADYozjBmpv/oQzC9
        g/UM0/QYQTkWZcgv5vNsefXwjLwJqFomI3e00/RroIedaAqsMW2Sh9lN65NfEyXe
        FvDUAgfPwRKh6DQ1cu39ST3n3hZ/FEJoek2OYSEB3kF0d7IwkTwA1Rfp4EAxei+i
        55wZAnCgOHgM/4WcI6RKfvkajN5D7ZvQWWO8MirdOn+UzxZwF2qwRpRYVBAB5Dbe
        oFslQ/vVi8EAuy8/gTytJVN37vd0/bSTHo4AjbcYgEVU53ko1CkLquaILeB0xb4R
        FvSQDQdIMTSRQWGrYE9phyPOtBgQ3ahdpcgLcM3Il9M/4TQ3q8WRT1gpNOgWeX5X
        c51A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669420033; x=1669506433; bh=Slr1yxnMUS23N
        RYZXVWVUiCyyawuZSpR9t3L6Nw1vCA=; b=cJ67nnAiO2bf+JL3Zrh3SM1MFuKSa
        IeyMvYQ6jiHBkBtvWGjYbTR8qlI2wSOs9oMVQGZ66TqdbIqKongc/YsGnyzgSavv
        DLshh7zC/Yh1AFuhWXx39KYZSpiOuhHh+46NR8IcfypK5RD4H1OhpxMpw6EMVN4h
        tBH2dcgFFXDax8jtWKVY9qyd7m9U3WP435z8d7iISOSAIGqiJ7EczwvZKqXqBrKZ
        j7m1gah694jtTKgWrRBBFi5WErmD+25uCwm7HxcClMdfofu6p/tzSphL+Yp0wKgg
        oe812+ETISL3I7ygbqZ7zCzsRg8yaBbdk7Kb/b0iSs/2gKvfFZGIYAthw==
X-ME-Sender: <xms:AFSBYzPBiRPBtlSsuztYQ0ZOn_ZI2PTnnrU37FswHg_KozuvMY7dfA>
    <xme:AFSBY98wNbIws9URAsR7GrwuL5zailpT-shX3scVjqk3LeE3WFhcp2LWwZCC3d6s_
    KPMr_211rn_a37F2A>
X-ME-Received: <xmr:AFSBYySBghGDXukSWWFCi-CKfRMzl4LIrwUw3XOi_LY9IpYTFjDwEdk4ORfmet7IBgAxPlavNh4jpFIWvwpc6ONg2Xx9wd8PJSJ7SFcoQUARzBCgsk38Ux_teV78hZWYAydZtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:AVSBY3vAqj6WtcHJzozbMZs8muOXE8pCF0wTkXJLoZjk1pfuXtmPOQ>
    <xmx:AVSBY7c6Sm-gm1P9cXPqcd2-Bp0VEUPjqRkXBGG_6c3HR3nr-fTG1w>
    <xmx:AVSBYz0G9mZrcEKbVR7O24RJ1boFr5PeHIgpG7vkA1-ZgbdfgT8B8w>
    <xmx:AVSBY1f81i04srS1Z1kT35Mw5X8R-KKHhRny5svUYqiOyyqnsH3Dug>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 18:47:11 -0500 (EST)
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
Subject: [PATCH v2 08/12] riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
Date:   Fri, 25 Nov 2022 17:46:52 -0600
Message-Id: <20221125234656.47306-9-samuel@sholland.org>
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

The MangoPi MQ Pro is a tiny SBC with a layout compatible to the
Raspberry Pi Zero. It includes the Allwinner D1 SoC, 512M or 1G of DDR3,
and an RTL8723DS-based WiFi/Bluetooth module.

The board also exposes GPIO Port E via a connector on the end of the
board, which can support either a camera or an RMII Ethernet PHY. The
additional regulators supply that connector.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Added LED (GPIO shared between onboard LED and backlight regulator)

 arch/riscv/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 143 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts

diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
index f1c70b9dc9bf..2ed586fafaea 100644
--- a/arch/riscv/boot/dts/allwinner/Makefile
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-480p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-720p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-dock.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-mangopi-mq-pro.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-nezha.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1s-mangopi-mq.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
new file mode 100644
index 000000000000..6d5897dc22e2
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
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
+	model = "MangoPi MQ Pro";
+	compatible = "widora,mangopi-mq-pro", "allwinner,sun20i-d1";
+
+	aliases {
+		ethernet0 = &rtl8723ds;
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
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_BACKLIGHT;
+			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
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
+		reset-gpios = <&pio 6 17 GPIO_ACTIVE_LOW>; /* PG17 */
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
+	rtl8723ds: wifi@1 {
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
+		compatible = "realtek,rtl8723ds-bt";
+		device-wake-gpios = <&pio 6 18 GPIO_ACTIVE_HIGH>; /* PG18 */
+		enable-gpios = <&pio 6 15 GPIO_ACTIVE_HIGH>; /* PG15 */
+		host-wake-gpios = <&pio 6 14 GPIO_ACTIVE_HIGH>; /* PG14 */
+	};
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

