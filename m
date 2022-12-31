Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87C265A841
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiLaXjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:39:06 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31F65B8;
        Sat, 31 Dec 2022 15:39:05 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7183E5C00BA;
        Sat, 31 Dec 2022 18:39:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529944; x=1672616344; bh=Sw
        UIInRaqpqK3pAz3/IZrTNpaUhmNCe2HT4MVJV0DHk=; b=vUlumu9wTcE/4mCeiR
        8PWvGIaggdImRH0XL53UWqqiPPKoQf2mrfQfk+tYR979N3eXtdtW4IGNoMtYz7xj
        S0gZAFCeu3MINGG5pmMAZGxxI0+yiTgdJIsZXNMLvFcrrl1EKIt3OX0+FJhaNRmP
        v+Zv/OqHE4D0HzqV4a7ReOoudQB3dwGLvqmQCAZPz9dvtKiSvl6X4SYcYhBNXLGx
        YLH3UON/TM0xSZpk9fYPPKn4K+7xO9zRZ8ZZzaCIvEW90uVwNRSHw8TLeu3LaHTp
        ldE8/2x4VBEPz76UvL9e9r2H3UvYiPI/c4pIKvX/LIICkg+bM1kwOjYQbWKo7te1
        24hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529944; x=1672616344; bh=SwUIInRaqpqK3
        pAz3/IZrTNpaUhmNCe2HT4MVJV0DHk=; b=GGlcUOftPqhHFAVzAk1cZD+NjLDKf
        RPDLxKqsyx3jWDYjEQx/Oip4xsJ/LBqh13bpIUgAcrxLHgHzU4F8J1fR4cVcze4G
        HbBECkN/+8JYOiUXcqFZC0YF+7btebZpbxLw0pNXXL8qKgTXlkXJHcTVu6CJhJXa
        /ggXuGvvHOFNGtWYqT/XVlw+S1IBxgmjNm1iTl2VMi6IjUnj4y1y+qiTMgN4+xC9
        C53CFOGQ0Ua2AsloOc06DjfNqUnHfXRn5SXMOXkAbGfnyDO/lHP28zqhOryoeZTa
        OZo/DGX0o6e/ljBZblp120D83dN5sHlVkHIYp7YRCKxsCPqDifn7CTgtA==
X-ME-Sender: <xms:GMiwY9fVpj5N2y3kmeAcAUigOYV6GLzFipsW9uzjrXnEKXJD8VkwTA>
    <xme:GMiwY7NSUm08MR_EoKuZ_qNrBxbPuGSrSgS4oe50yVoN25j-uhB4uKpKodqsLbYsC
    xuyFs5bcJw3iK7HeA>
X-ME-Received: <xmr:GMiwY2hgvvBt3bYd2rVpG0FBDViK5ME2inp88Brn6m5yv3aWlsoyCsUXYAeXoNCEbEwGwahpA8gfXULcF5KBT9jqPJ1nQFMzD26R_3PT2a6Sd57eCADJgCxwhG3KM4reml70_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:GMiwY2_ob-CN6Lhe8igBbfnN0Zlu4tZ7Tl-1IErHddE_DPei_NFvGQ>
    <xmx:GMiwY5t1Ed_j1ZwMxCrDdUqhDxFbfT6We3r4tNJZJtUwTxbYvbg7Vw>
    <xmx:GMiwY1Hx4v81-HwDGSa-sNvA2cJ7To2sF8DIcM4xjGyhxAyEc052rA>
    <xmx:GMiwY5OiVrXJZGtvtwRxdG8ZuVrE2zp_wueQt52lg1nO_xvZeLaMDA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:39:03 -0500 (EST)
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
Subject: [PATCH v4 08/12] riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
Date:   Sat, 31 Dec 2022 17:38:47 -0600
Message-Id: <20221231233851.24923-9-samuel@sholland.org>
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

The MangoPi MQ Pro is a tiny SBC with a layout compatible to the
Raspberry Pi Zero. It includes the Allwinner D1 SoC, 512M or 1G of DDR3,
and an RTL8723DS-based WiFi/Bluetooth module.

The board also exposes GPIO Port E via a connector on the end of the
board, which can support either a camera or an RMII Ethernet PHY. The
additional regulators supply that connector.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v3)

Changes in v3:
 - Drop mmc alias
 - Change LED_FUNCTION_BACKLIGHT to LED_FUNCTION_STATUS (the backlight
   regulator is disconnected by default, so this is a standalone LED)

Changes in v2:
 - Added LED (GPIO shared between onboard LED and backlight regulator)

 arch/riscv/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 142 ++++++++++++++++++
 2 files changed, 143 insertions(+)
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
index 000000000000..f2e07043afb3
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
@@ -0,0 +1,142 @@
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
+			function = LED_FUNCTION_STATUS;
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

