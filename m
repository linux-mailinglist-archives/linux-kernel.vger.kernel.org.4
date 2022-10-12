Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E805FC05B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJLF6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJLF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:58:06 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD5ABF3B;
        Tue, 11 Oct 2022 22:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665554262; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=atvxzaSC6LFGcRfJpsJMIxtZIt352jx03gJSKk9uG2bkcg77Y15gkiUasLg3zDhLReHbGEjnx3tJ2gkVMUb3aK7fyFOk6f5pWP0PjglEZcMHnXpc8g3weSsl8It/gmsCOF/SoFoUsKAy8Jv6bkLp9jxZB+M2JOEP+t8kMvODrMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665554262; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UaXtIwhiAd0KbivjBK2cgrEAbkI3s44C7vM8EyFF4v0=; 
        b=L6Lud2AdEMM5tJTi0UUUFx1GxiYaGqtDGvSfxIof0tDU+nBc3J11SgE1BeFJWySk25dxe0Luhy/MpsioQaqeTtXrpAL/E3ejaLqzRvo5h2+DPe2maA9043VnkaIONCT7dS1Tx+DtxTco4HTvzqUBOlOwwxBp/PUYzefz1NItZug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665554262;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=UaXtIwhiAd0KbivjBK2cgrEAbkI3s44C7vM8EyFF4v0=;
        b=hq5MQdXicXEsg+vm/uyU/1/Dn97R6FibHgNnj8zV92K4aKrpJK0iyObxJ+qLhApu
        FtnxRSOc/uhim8UcT0Y3n078oC9JCn6qmecZx+NY0ivRckdEyTAFgMfoGoQmtXHEB1s
        4X0J6n/Tr5Fgu4XjuDCktzCDKTT7RWyLWPbtfgTQ=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665554261224772.6070403474648; Tue, 11 Oct 2022 22:57:41 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 10/10] ARM: dts: suniv: add device tree for PopStick v1.1
Date:   Wed, 12 Oct 2022 13:56:02 +0800
Message-Id: <20221012055602.1544944-11-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012055602.1544944-1-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PopStick is a minimal Allwinner F1C200s dongle, with its USB controller
wired to a USB Type-A port, a SD slot and a SPI NAND flash on board, and
an on-board CH340 USB-UART converted connected to F1C200s's UART0.

Add a device tree for it. As F1C200s is just F1C100s with a different
DRAM chip co-packaged, directly use F1C100s DTSI here.

This commit covers the v1.1 version of this board, which is now shipped.
v1.0 is some internal sample that have not been shipped at all.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
New patch introduced in v2.

 arch/arm/boot/dts/Makefile                    |   3 +-
 .../boot/dts/suniv-f1c200s-popstick-v1.1.dts  | 101 ++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6aa7dc4db2fc..0249c07bd8a6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1391,7 +1391,8 @@ dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
 dtb-$(CONFIG_MACH_SUNIV) += \
-	suniv-f1c100s-licheepi-nano.dtb
+	suniv-f1c100s-licheepi-nano.dtb \
+	suniv-f1c200s-popstick-v1.1.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-acer-a500-picasso.dtb \
 	tegra20-asus-tf101.dtb \
diff --git a/arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts b/arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts
new file mode 100644
index 000000000000..121dfc6f609d
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c200s-popstick-v1.1.dts
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+/dts-v1/;
+#include "suniv-f1c100s.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Popcorn Computer PopStick v1.1";
+	compatible = "sourceparts,popstick-v1.1", "sourceparts,popstick",
+		     "allwinner,suniv-f1c200s", "allwinner,suniv-f1c100s";
+
+	aliases {
+		mmc0 = &mmc0;
+		serial0 = &uart0;
+		spi0 = &spi0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 4 6 GPIO_ACTIVE_HIGH>; /* PE6 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&mmc0 {
+	cd-gpios = <&pio 4 3 GPIO_ACTIVE_LOW>; /* PE3 */
+	bus-width = <4>;
+	disable-wp;
+	status = "okay";
+	vmmc-supply = <&reg_vcc3v3>;
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pc_pins>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "u-boot-with-spl";
+				reg = <0x0 0x100000>;
+			};
+
+			ubi@100000 {
+				label = "ubi";
+				reg = <0x100000 0x7f00000>;
+			};
+		};
+	};
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pe_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.37.1

