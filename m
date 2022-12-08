Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B9C646B59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiLHJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLHJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:03:35 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660D69A8F;
        Thu,  8 Dec 2022 01:03:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 531D432002E2;
        Thu,  8 Dec 2022 04:03:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 08 Dec 2022 04:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670490187; x=1670576587; bh=XA
        UUj025hjaAz/jQ9EC9wA+kfkKhAh5I8DBGwmHbusE=; b=zULGPY2rWtaZCXIOsr
        fRCBAj6UzKteHeOJp14PC8nVALarHBKRyzYShL/Ptmik4Z6ba1YN1KiV6kyjsEil
        m4MYs7XrxCVNLY9nNDPBKtmqwdocMNizJ4ZdYMxy1IDSCqk8Jaulfb2tyyt0vC7Y
        sjZn7GjbdtchPZ4fY+ZpnVF6ysGrHcJqhtt12gY8FzMlY6kAMD+K48C0Q4O0BM+V
        EJ6XFwcASRHVxz2tLDLvf3pK3fZgD1tPEixYW5tqZ5AWdw5aAVowv9VdRwCWgZcJ
        l+V8rpANll8Nag7/y9kjnmwIipL3A50/YKr3tXYRjNpwm60NbyUhzbdMtt9dPz5M
        jYtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670490187; x=1670576587; bh=XAUUj025hjaAz
        /jQ9EC9wA+kfkKhAh5I8DBGwmHbusE=; b=dgIA3c4fgwpGqqLlM3KgIVydoDHDU
        LDGw7UIkUS7GQlNPRwiiAb2GwhkyEPMjA/cmsmP7c3K0ERGRGoZzgInhB/PX6Bpl
        AS9e5gZsBYGuRZ/B/e0+blt4vtmdBce78wE6ICqQYWZ/84HqfVokdxNDIVfjqTJN
        G7KydcU/oPIbwD1rdk8LI9p8o5oYTa4baoAE1k9evInhco2ztm8U5Hj8/dfNfqbO
        DsIWxIF32kJIS00X9LJLbvTkfbIN0Y/Hnfzfm9zgKkwCTbtszWxwSAezMs9LGHQQ
        2ZwnVEHWEsa1UzckzR9usCHIG48f1Ta98XnOaZ6/gPwB23M5q31ATMw1g==
X-ME-Sender: <xms:S6iRY2WJYcuvCMJRNlTdo-IKsk0se483sIbdr6rq2OLPky-Uv4Bj_w>
    <xme:S6iRYylaCsHnvaXdSEIUsvQYOcbBR83OKqL5DuUL65s83oQ5h38Pp9NQhN2Pg4lng
    syXR6RPpTLc01iNVg>
X-ME-Received: <xmr:S6iRY6aRlSHkJQ-DX90rHKke0GBv1R5MnE39zoTzDCb-OCXem3yzHBlf4Uq_EIR-nKQQwJRwhHutw3E3aruOgbrW62kDEx-7PbzcDDZ8406ybpahDbGYxw7T37zjcNmt9a8MGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefgudefiedt
    veetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:S6iRY9WTdSsoyS9SuJfzLOtXjTeaQ-XWuKU3t69yo0yX_by098y0sw>
    <xmx:S6iRYwkUgV7lVbJzbiSPZzz8rQQsZkW8Ctoqvrfnf2JzbbhppksgSQ>
    <xmx:S6iRYyc6KPx2lO4Jo1eQ9hvfomr6gUYCN4sZ2vignT8PpC16GpFLQQ>
    <xmx:S6iRY0lcCLCR5MXEgFLPt07gLUobdVQIljQeADPBJGPjxzjVCJDijg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:03:06 -0500 (EST)
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
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v3 08/12] riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
Date:   Thu,  8 Dec 2022 03:02:33 -0600
Message-Id: <20221208090237.20572-9-samuel@sholland.org>
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

