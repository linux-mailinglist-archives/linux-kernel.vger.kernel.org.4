Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D055BAF57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiIPO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiIPOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:25:58 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C8B3B0B;
        Fri, 16 Sep 2022 07:25:56 -0700 (PDT)
Received: from robin.home.jannau.net (unknown [91.200.110.112])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 3ECC726F07F;
        Fri, 16 Sep 2022 16:25:55 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/10] arm64: dts: apple: Add J375 devicetrees
Date:   Fri, 16 Sep 2022 16:25:47 +0200
Message-Id: <20220916142550.269905-8-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916142550.269905-1-j@jannau.net>
References: <20220916142550.269905-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the Mac Studio devices with M1 Max (t6001) and
M1 Ultra (t6002).

Signed-off-by: Janne Grunau <j@jannau.net>

---

Changes in v1:
 - removed stray /dts-v1/;" from t600x-j375.dtsi

 arch/arm64/boot/dts/apple/Makefile        |   2 +
 arch/arm64/boot/dts/apple/t6001-j375c.dts |  18 ++++
 arch/arm64/boot/dts/apple/t6002-j375d.dts |  50 ++++++++++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi | 113 ++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j375c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6002-j375d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t600x-j375.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index b021931b0a17..5a7506ff5ea3 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -8,3 +8,5 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j314s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j314c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
diff --git a/arch/arm64/boot/dts/apple/t6001-j375c.dts b/arch/arm64/boot/dts/apple/t6001-j375c.dts
new file mode 100644
index 000000000000..62ea437b58b2
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6001-j375c.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Studio (M1 Max, 2022)
+ *
+ * target-type: J375c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6001.dtsi"
+#include "t600x-j375.dtsi"
+
+/ {
+	compatible = "apple,j375c", "apple,t6001", "apple,arm-platform";
+	model = "Apple Mac Studio (M1 Max, 2022)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6002-j375d.dts b/arch/arm64/boot/dts/apple/t6002-j375d.dts
new file mode 100644
index 000000000000..3365429bdc8b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6002-j375d.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Studio (M1 Ultra, 2022)
+ *
+ * target-type: J375d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6002.dtsi"
+#include "t600x-j375.dtsi"
+
+/ {
+	compatible = "apple,j375d", "apple,t6002", "apple,arm-platform";
+	model = "Apple Mac Studio (M1 Ultra, 2022)";
+};
+
+/* USB Type C */
+&i2c0 {
+	/* front-right */
+	hpm4: usb-pd@39 {
+		compatible = "apple,cd321x";
+		reg = <0x39>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	/* front-left */
+	hpm5: usb-pd@3a {
+		compatible = "apple,cd321x";
+		reg = <0x3a>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+/* delete unused always-on power-domains on die 1 */
+
+/delete-node/ &ps_atc2_usb_aon_die1;
+/delete-node/ &ps_atc2_usb_die1;
+
+/delete-node/ &ps_atc3_usb_aon_die1;
+/delete-node/ &ps_atc3_usb_die1;
+
+/delete-node/ &ps_disp0_cpu0_die1;
+/delete-node/ &ps_disp0_fe_die1;
diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
new file mode 100644
index 000000000000..99984b96e8d0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Studio (2022)
+ *
+ * This file contains the parts common to J375 devices with both t6001 and t6002.
+ *
+ * target-type: J375c / J375d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/ {
+	aliases {
+		serial0 = &serial0;
+		wifi0 = &wifi0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+		};
+	};
+
+	memory@10000000000 {
+		device_type = "memory";
+		reg = <0x100 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+/* USB Type C */
+&i2c0 {
+	hpm0: usb-pd@38 {
+		compatible = "apple,cd321x";
+		reg = <0x38>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm1: usb-pd@3f {
+		compatible = "apple,cd321x";
+		reg = <0x3f>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm2: usb-pd@3b {
+		compatible = "apple,cd321x";
+		reg = <0x3b>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm3: usb-pd@3c {
+		compatible = "apple,cd321x";
+		reg = <0x3c>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+/* PCIe devices */
+&port00 {
+	/* WLAN */
+	bus-range = <1 1>;
+	wifi0: wifi@0,0 {
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 10];
+	};
+};
+
+&port01 {
+	/* SD card reader */
+	bus-range = <2 2>;
+	sdhci0: mmc@0,0 {
+		compatible = "pci17a0,9755";
+		reg = <0x20000 0x0 0x0 0x0 0x0>;
+		cd-inverted;
+		wp-inverted;
+	};
+};
+
+&port02 {
+	/* 10 Gbit Ethernet */
+	bus-range = <3 3>;
+	ethernet0: ethernet@0,0 {
+		reg = <0x30000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 00];
+	};
+};
+
+&port03 {
+	/* USB xHCI */
+	bus-range = <4 4>;
+};
-- 
2.35.1

