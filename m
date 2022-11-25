Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB863925B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKYXri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKYXrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:47:16 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A5E5A6C8;
        Fri, 25 Nov 2022 15:47:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B9775C0103;
        Fri, 25 Nov 2022 18:47:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 18:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669420028; x=1669506428; bh=v7
        9D6Ov/tAQKi5bW+r8SZEyTNnfG6OGD+PYt1mIfM7c=; b=waV+gO9AYtF7GKlvl8
        Y4VnUn0Z80pS/FlOwjTWYS3hB8epwZASA+3nuOKmxJhv5Moho2SJj8q3tcWOCbBq
        sMCI2PbgynMzRpvld6RaVXlNumfTwFKGqjTrh8xO4Plg6rJhnIfFROg874Q5hjwL
        qRzeVDJFLIoJZT9f1XviPBcN5kWqbVi6O4Jv+h6N3J2SboGe7wcULJ+yEsWEeTKz
        K3mjGaqc3NIMD6vVw1jRQT7xD6Pil08i79gqmozeaAJ2YgiNOdIciwQ39zHb5NoQ
        JRg6aSPSsK3AKArrsFe8nIUQ5qPiaOGCTJ19xUuo+F8D/XNFG2TpzYA9JS1N/Wk3
        1AVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669420028; x=1669506428; bh=v79D6Ov/tAQKi
        5bW+r8SZEyTNnfG6OGD+PYt1mIfM7c=; b=A5G33+EGXg1/bbx0y5qE1dPotEOO9
        4QKwCMxYTrbB+kQb9S24oXPofpAmaH5mc+wcP4wAaA0lRtcMdjKg53I223YkFS8x
        qufyNRT/B/UoYvtBDA487xlRfL8Guu2otA7LuK8N8UVtz9ROUPmZPk49zjd1GdiE
        692pnJ5gfvT3TRxszis8ZmhUYh2GIl5uSHrxTdYY7azBhG4635VEJnbdcuUlqv3K
        1NvfV5pr/s9VwNkOtuHKS2b3xDXwBTjKn91W6q/xi/NiZTewTstkzbKwNlxHzYfj
        Ye4723WX9SdgMGFzyavttY9E7UufCI0l9qMiXHH36nO9oxK8iLFwMxfmQ==
X-ME-Sender: <xms:-1OBYxTthToWkvXGlrSJUnUYiwTIDkWijQurpICgY8ZFQC03CXWcUg>
    <xme:-1OBY6wFbGxXMUU5v3aJCtNLRj2HJiEGl-LsCDFgdTMZHaC_D57Y8DgoGc_6NDdu7
    jY-VyY67l95QOeB7g>
X-ME-Received: <xmr:-1OBY21KB5F7sDKfTGVWH8Tr_388JhEnCJA6rEjc9RZDydoeBaMm7Olh27oHoJgTnW9zgHJDjaV3wVE5IquioZgKx_vtS0Eg-MRvtpDVyKVUwiAh79Zg_mW8aNuawV91J26PaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:-1OBY5AKWLQ3g_16lIYmUYEXMv4ndBoKiz0MSwG7AdqsuytCqWNhQA>
    <xmx:-1OBY6ij_bvx1IZh2NDqVD244s6J3HLfaZlxNXj2R2kCD2dM0xzBcw>
    <xmx:-1OBY9o6zvvoCHqp-y1zQyt7oL2UAZazxU-NkiWlKKrbicgkOdjaNQ>
    <xmx:_FOBY6Q74Q9UNDcVaLxHohU6PJH2NZV8AkOh2hUseuS5-u-vudbaPw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 18:47:06 -0500 (EST)
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
Subject: [PATCH v2 05/12] riscv: dts: allwinner: Add MangoPi MQ devicetree
Date:   Fri, 25 Nov 2022 17:46:49 -0600
Message-Id: <20221125234656.47306-6-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch for v2

 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun20i-common-regulators.dtsi   |  35 +++++
 .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 135 ++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index ff174996cdfd..f292e31bdb2c 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+subdir-y += allwinner
 subdir-y += sifive
 subdir-y += starfive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
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
index 000000000000..11b150182490
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
@@ -0,0 +1,135 @@
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
+		mmc0 = &mmc0;
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
+			function = LED_FUNCTION_BACKLIGHT;
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

