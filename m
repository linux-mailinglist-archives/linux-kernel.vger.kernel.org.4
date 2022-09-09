Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B906F5B39FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIINwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIINvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:51:33 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F79142D8C;
        Fri,  9 Sep 2022 06:51:24 -0700 (PDT)
Received: from robin.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id EA8E926EFF0;
        Fri,  9 Sep 2022 15:51:06 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/10] arm64: dts: apple: Add J314 and J316 devicetrees
Date:   Fri,  9 Sep 2022 15:51:00 +0200
Message-Id: <20220909135103.98179-8-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909135103.98179-1-j@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

These are the 14-inch and 16-inch 2021 MacBooks, in both M1 Pro and M1
Max variants (t6000 and t6001).

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---

 arch/arm64/boot/dts/apple/Makefile            |   4 +
 arch/arm64/boot/dts/apple/t6000-j314s.dts     |  18 +++
 arch/arm64/boot/dts/apple/t6000-j316s.dts     |  18 +++
 arch/arm64/boot/dts/apple/t6001-j314c.dts     |  18 +++
 arch/arm64/boot/dts/apple/t6001-j316c.dts     |  18 +++
 .../arm64/boot/dts/apple/t600x-j314-j316.dtsi | 110 ++++++++++++++++++
 6 files changed, 186 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t6000-j314s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6000-j316s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j314c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j316c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index c0510c25ca6a..b021931b0a17 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -4,3 +4,7 @@ dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j456.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j457.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6000-j314s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6001-j314c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
diff --git a/arch/arm64/boot/dts/apple/t6000-j314s.dts b/arch/arm64/boot/dts/apple/t6000-j314s.dts
new file mode 100644
index 000000000000..c9e192848fe3
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6000-j314s.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14-inch, M1 Pro, 2021)
+ *
+ * target-type: J314s
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6000.dtsi"
+#include "t600x-j314-j316.dtsi"
+
+/ {
+	compatible = "apple,j314s", "apple,t6000", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M1 Pro, 2021)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6000-j316s.dts b/arch/arm64/boot/dts/apple/t6000-j316s.dts
new file mode 100644
index 000000000000..ff1803ce2300
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6000-j316s.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (16-inch, M1 Pro, 2021)
+ *
+ * target-type: J316s
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6000.dtsi"
+#include "t600x-j314-j316.dtsi"
+
+/ {
+	compatible = "apple,j316s", "apple,t6000", "apple,arm-platform";
+	model = "Apple MacBook Pro (16-inch, M1 Pro, 2021)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j314c.dts b/arch/arm64/boot/dts/apple/t6001-j314c.dts
new file mode 100644
index 000000000000..1761d15b98c1
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6001-j314c.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14-inch, M1 Max, 2021)
+ *
+ * target-type: J314c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6001.dtsi"
+#include "t600x-j314-j316.dtsi"
+
+/ {
+	compatible = "apple,j314c", "apple,t6001", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M1 Max, 2021)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j316c.dts b/arch/arm64/boot/dts/apple/t6001-j316c.dts
new file mode 100644
index 000000000000..750e9beeffc0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6001-j316c.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (16-inch, M1 Max, 2021)
+ *
+ * target-type: J316c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6001.dtsi"
+#include "t600x-j314-j316.dtsi"
+
+/ {
+	compatible = "apple,j316c", "apple,t6001", "apple,arm-platform";
+	model = "Apple MacBook Pro (16-inch, M1 Max, 2021)";
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
new file mode 100644
index 000000000000..8079200aeb12
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14/16-inch, 2021)
+ *
+ * This file contains the parts common to J314 and J316 devices with both t6000 and t6001.
+ *
+ * target-type: J314s / J314c / J316s / J316c
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
+	/* MagSafe port */
+	hpm5: usb-pd@3a {
+		compatible = "apple,cd321x";
+		reg = <0x3a>;
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
+&pcie0_dart_2 {
+	status = "disabled";
+};
+
+&pcie0_dart_3 {
+	status = "disabled";
+};
+
+/delete-node/ &port02;
+/delete-node/ &port03;
-- 
2.35.1

