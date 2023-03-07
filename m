Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D7E6ADE71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCGMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjCGMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:10:24 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083175BCAA;
        Tue,  7 Mar 2023 04:10:17 -0800 (PST)
Received: from robin.home.jannau.net (p54accbe8.dip0.t-ipconnect.de [84.172.203.232])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 4EFD826F894;
        Tue,  7 Mar 2023 13:10:16 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 07 Mar 2023 13:10:21 +0100
Subject: [PATCH v3 15/15] arm64: dts: apple: t8112: Initial t8112 (M2)
 device trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v3-15-d1a5f6383d95@jannau.net>
References: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=65859; i=j@jannau.net;
 h=from:subject:message-id; bh=JyJGEuAOMxZlwUx9ZPF3DqbJqAnp76LtIep92BxuBWg=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhhR2zYVZaskKK19n6vQ+czi3X2c5n3Tje5Gz344eYvFs/
 Civt6mio5SFQYyDQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwER2/mH4K2q0efLBg80qAZd6
 PPsexfElnzz24WHblo9tcXwz2O+m+DMyNBX8uM54fqZc4y3O7GRHubffXm54H7077oisC3/o7m0
 nWAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

This adds device trees for the following devices:
 - Macbook Air (M2, 2022)
 - Macbook Pro 13" (M2, 2022)
 - Mac mini (M2, 2023)

This brings the hardware support of the machines to the same level as M1
and M1 Pro / Max / Ultra. Supported hardware include NVMe, PCIe, serial,
pinctrl/gpio, I2C, iommu, watchdog, admac, nco, cpufreq, boot
framebuffer for laptop panels and the interrupt controller.

The ethernet LAN device on the M2 Mac mini is the only working PCIe
device. The Wlan/BT devices are powered off and controlled by the not
yet supported SMC. The ASMedia xHCI on the M2 Mac mini requires firmware
to be loaded at startup.

The main missing hardware support to make these devices useful are the
integrated USB 2/3/4 controller, keyboard and trackpad on the laptops
and SMC to power the PCIe Wlan/BT device on.
The M2 Mac mini has currently no working display output. Due to changes
in the display pipeline it is currently not possible to initialize the
HDMI output in the bootloader.

Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Janne Grunau <j@jannau.net>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile        |    3 +
 arch/arm64/boot/dts/apple/t8112-j413.dts  |   63 ++
 arch/arm64/boot/dts/apple/t8112-j473.dts  |   54 ++
 arch/arm64/boot/dts/apple/t8112-j493.dts  |   52 ++
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi |   81 ++
 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi | 1141 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi      |  912 +++++++++++++++++++++++
 7 files changed, 2306 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 5a7506ff5ea3..aec5e29cdfb7 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -10,3 +10,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
new file mode 100644
index 000000000000..9e758edeaa82
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (M2, 2022)
+ *
+ * target-type: J413
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8112.dtsi"
+#include "t8112-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
+	model = "Apple MacBook Air (13-inch, M2, 2022)";
+
+	aliases {
+		bluetooth0 = &bluetooth0;
+		wifi0 = &wifi0;
+	};
+};
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+&port00 {
+	bus-range = <1 1>;
+	wifi0: wifi@0,0 {
+		compatible = "pci14e4,4433";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 10];
+		apple,antenna-sku = "XX";
+		brcm,board-type = "apple,hokkaido";
+	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f71";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+		brcm,board-type = "apple,hokkaido";
+	};
+};
+
+&i2c0 {
+	/* MagSafe port */
+	hpm5: usb-pd@3a {
+		compatible = "apple,cd321x";
+		reg = <0x3a>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j473.dts b/arch/arm64/boot/dts/apple/t8112-j473.dts
new file mode 100644
index 000000000000..06fe257f08be
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8112-j473.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple Mac mini (M2, 2023)
+ *
+ * target-type: J473
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8112.dtsi"
+#include "t8112-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j473", "apple,t8112", "apple,arm-platform";
+	model = "Apple Mac mini (M2, 2023)";
+
+	aliases {
+		ethernet0 = &ethernet0;
+	};
+};
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+&port00 {
+	bus-range = <1 1>;
+};
+
+&port01 {
+	bus-range = <2 2>;
+	status = "okay";
+};
+
+&port02 {
+	bus-range = <3 3>;
+	status = "okay";
+	ethernet0: ethernet@0,0 {
+		reg = <0x30000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 00];
+	};
+};
+
+&pcie1_dart {
+	status = "okay";
+};
+
+&pcie2_dart {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
new file mode 100644
index 000000000000..8552c15be265
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Pro (13-inch, M1, 2022)
+ *
+ * target-type: J493
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8112.dtsi"
+#include "t8112-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j493", "apple,t8112", "apple,arm-platform";
+	model = "Apple MacBook Pro (13-inch, M2, 2022)";
+
+	aliases {
+		bluetooth0 = &bluetooth0;
+		wifi0 = &wifi0;
+	};
+};
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+&port00 {
+	bus-range = <1 1>;
+	wifi0: wifi@0,0 {
+		compatible = "pci14e4,4425";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 00 00 00 00 00];
+		apple,antenna-sku = "XX";
+		brcm,board-type = "apple,kyushu";
+	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f69";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+		brcm,board-type = "apple,kyushu";
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
new file mode 100644
index 000000000000..f5edf61113e7
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple M2 MacBook Air/Pro (M2, 2022)
+ *
+ * This file contains parts common to all Apple M2 devices using the t8112.
+ *
+ * target-type: J493, J413
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/ {
+	aliases {
+		serial0 = &serial0;
+		serial2 = &serial2;
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
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	hpm0: usb-pd@38 {
+		compatible = "apple,cd321x";
+		reg = <0x38>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm1: usb-pd@3f {
+		compatible = "apple,cd321x";
+		reg = <0x3f>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&nco_clkref {
+	clock-frequency = <900000000>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8112-pmgr.dtsi
new file mode 100644
index 000000000000..0f2d810921c8
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8112-pmgr.dtsi
@@ -0,0 +1,1141 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T8112 "M2" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+
+&pmgr {
+	ps_sbr: power-controller@100 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sbr";
+		apple,always-on; /* Core device */
+	};
+
+	ps_aic: power-controller@108 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@110 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+		apple,always-on; /* Core device */
+	};
+
+	ps_soc_spmi0: power-controller@118 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_spmi0";
+	};
+
+	ps_gpio: power-controller@120 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pms_busif: power-controller@128 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_busif";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pms: power-controller@130 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pms_c1ppt: power-controller@160 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_c1ppt";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_soc_dpe: power-controller@168 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_dpe";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pmgr_soc_ocla: power-controller@170 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmgr_soc_ocla";
+		power-domains = <&ps_pms>;
+	};
+
+	ps_ispsens0: power-controller@178 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@180 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_ispsens2: power-controller@188 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens2";
+	};
+
+	ps_ispsens3: power-controller@190 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens3";
+	};
+
+	ps_pcie_ref: power-controller@198 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_ref";
+	};
+
+	ps_aft0: power-controller@1a0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aft0";
+	};
+
+	ps_imx: power-controller@1a8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "imx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sio_busif: power-controller@1b0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_busif";
+	};
+
+	ps_sio: power-controller@1b8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		apple,always-on;
+		power-domains = <&ps_sio_busif>;
+	};
+
+	ps_sio_cpu: power-controller@1c0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_cpu";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_fpwm0: power-controller@1c8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm0";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_fpwm1: power-controller@1d0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm1";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_fpwm2: power-controller@1d8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm2";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c0: power-controller@1e0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c1: power-controller@1e8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c2: power-controller@1f0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c3: power-controller@1f8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c4: power-controller@200 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c4";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_spi_p: power-controller@208 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_uart_p: power-controller@210 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_audio_p: power-controller@218 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "audio_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_aes: power-controller@220 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_spi0: power-controller@228 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi1: power-controller@230 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi2: power-controller@238 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi3: power-controller@240 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi4: power-controller@248 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi4";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi5: power-controller@250 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi5";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_uart_n: power-controller@258 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_n";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart0: power-controller@260 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart1: power-controller@268 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart2: power-controller@270 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart3: power-controller@278 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart4: power-controller@280 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart5: power-controller@288 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart6: power-controller@290 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart7: power-controller@298 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart7";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart8: power-controller@2a0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart8";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_sio_adma: power-controller@2a8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_adma";
+		power-domains = <&ps_spi_p>, <&ps_audio_p>;
+	};
+
+	ps_dpa0: power-controller@2b0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa0";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa1: power-controller@2b8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa1";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_mca0: power-controller@2c0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca1: power-controller@2c8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca2: power-controller@2d0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca3: power-controller@2d8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca4: power-controller@2e0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca5: power-controller@2e8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca5";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mcc: power-controller@2f0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Memory controller */
+	};
+
+	ps_dcs0: power-controller@2f8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs2: power-controller@300 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs1: power-controller@308 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs3: power-controller@310 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs4: power-controller@318 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs4";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs5: power-controller@320 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs5";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs6: power-controller@328 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs6";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs7: power-controller@330 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs7";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_smx0: power-controller@338 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx0";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_smx1: power-controller@340 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx1";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_apcie: power-controller@348 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie";
+		power-domains = <&ps_imx>, <&ps_pcie_ref>;
+	};
+
+	ps_rmx0: power-controller@350 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "rmx0";
+		/* Apple Fabric, display/image stuff: this can power down */
+	};
+
+	ps_rmx1: power-controller@358 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x358 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "rmx1";
+		/* Apple Fabric, display/image stuff: this can power down */
+	};
+
+	ps_cmx: power-controller@360 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cmx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_mmx: power-controller@368 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x368 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mmx";
+		/* Apple Fabric, media stuff: this can power down */
+	};
+
+	ps_disp0_sys: power-controller@370 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_sys";
+		power-domains = <&ps_rmx1>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_disp0_fe: power-controller@378 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_fe";
+		power-domains = <&ps_disp0_sys>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	ps_dispext_sys: power-controller@380 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_sys";
+		power-domains = <&ps_rmx0>;
+	};
+
+	ps_dispext_fe: power-controller@388 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_fe";
+		power-domains = <&ps_dispext_sys>;
+	};
+
+	ps_dispext_cpu0: power-controller@3c8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext_cpu0";
+		power-domains = <&ps_dispext_fe>;
+		apple,min-state = <4>;
+	};
+
+	ps_dptx_ext_phy: power-controller@3d8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dptx_ext_phy";
+	};
+
+	ps_dispdfr_fe: power-controller@3e0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispdfr_fe";
+		power-domains = <&ps_rmx0>;
+	};
+
+	ps_dispdfr_be: power-controller@3e8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispdfr_be";
+		power-domains = <&ps_dispdfr_fe>;
+	};
+
+	ps_mipi_dsi: power-controller@3f0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_dispdfr_be>;
+	};
+
+	ps_jpg: power-controller@3f8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_cmx>;
+	};
+
+	ps_apcie_gp: power-controller@400 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_gp";
+		power-domains = <&ps_apcie>;
+		apple,always-on; /* Breaks things if shut down */
+	};
+
+	ps_msr: power-controller@408 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x408 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_imx>;
+	};
+
+	ps_pmp: power-controller@410 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x410 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+		apple,always-on;
+	};
+
+	ps_pms_sram: power-controller@418 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x418 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+		apple,always-on;
+	};
+
+	ps_msr_ase_core: power-controller@420 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x420 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr_ase_core";
+		power-domains = <&ps_msr>;
+	};
+
+	ps_ans: power-controller@428 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x428 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+		power-domains = <&ps_imx>;
+	};
+
+	ps_gfx: power-controller@430 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x430 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_isp_sys: power-controller@438 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x438 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sys";
+		power-domains = <&ps_rmx1>;
+	};
+
+	ps_venc_sys: power-controller@440 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x440 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_sys";
+		power-domains = <&ps_rmx1>;
+	};
+
+	ps_avd_sys: power-controller@448 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x448 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "avd_sys";
+		power-domains = <&ps_mmx>;
+	};
+
+	ps_apcie_st: power-controller@450 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x450 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_st";
+		power-domains = <&ps_apcie>, <&ps_ans>;
+	};
+
+	ps_atc0_common: power-controller@458 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x458 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_common";
+		power-domains = <&ps_imx>;
+	};
+
+	ps_atc0_pcie: power-controller@460 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x460 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_pcie";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio: power-controller@468 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x468 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio_pcie: power-controller@470 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x470 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_pcie";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc0_cio_usb: power-controller@478 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x478 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_usb";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc1_common: power-controller@480 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x480 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_common";
+		power-domains = <&ps_rmx0>;
+	};
+
+	ps_atc1_pcie: power-controller@488 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x488 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_pcie";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio: power-controller@490 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x490 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio_pcie: power-controller@498 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x498 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_pcie";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_atc1_cio_usb: power-controller@4a0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_usb";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_ane_sys: power-controller@4a8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_sys";
+		power-domains = <&ps_mmx>;
+	};
+
+	ps_scodec: power-controller@4b0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x4b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "scodec";
+		power-domains = <&ps_rmx0>;
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on;
+	};
+
+	ps_venc_dma: power-controller@8000 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_dma";
+		power-domains = <&ps_venc_sys>;
+	};
+
+	ps_venc_pipe4: power-controller@8008 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe4";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_pipe5: power-controller@8010 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe5";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me0: power-controller@8018 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+		power-domains = <&ps_venc_pipe5>, <&ps_venc_pipe4>;
+	};
+
+	ps_venc_me1: power-controller@8020 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+		power-domains = <&ps_venc_pipe5>, <&ps_venc_pipe4>;
+	};
+
+	ps_disp0_cpu0: power-controller@10000 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x10000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_cpu0";
+		power-domains = <&ps_disp0_fe>;
+		apple,min-state = <4>;
+	};
+};
+
+&pmgr_mini {
+
+	ps_debug_gated: power-controller@58 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_gated";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_spmi0: power-controller@60 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi0";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_spmi1: power-controller@68 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi1";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_aon: power-controller@70 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x70 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_aon";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_msg: power-controller@78 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x78 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msg";
+	};
+
+	ps_nub_gpio: power-controller@80 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_gpio";
+		apple,always-on;
+	};
+
+	ps_atc0_usb_aon: power-controller@88 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb_aon";
+		apple,always-on; /* Needs to stay on for dwc3 to work */
+	};
+
+	ps_atc1_usb_aon: power-controller@90 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x90 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb_aon";
+		apple,always-on; /* Needs to stay on for dwc3 to work */
+	};
+
+	ps_atc0_usb: power-controller@98 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x98 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb";
+		power-domains = <&ps_atc0_usb_aon>, <&ps_atc0_common>;
+	};
+
+	ps_atc1_usb: power-controller@a0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xa0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb";
+		power-domains = <&ps_atc1_usb_aon>, <&ps_atc1_common>;
+	};
+
+	ps_nub_fabric: power-controller@a8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_fabric";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_nub_sram: power-controller@b0 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_sram";
+		apple,always-on; /* Core AON device */
+	};
+
+	ps_debug_switch: power-controller@b8 {
+		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xb8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_switch";
+		apple,always-on; /* Core AON device */
+	};
+};
+
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
new file mode 100644
index 000000000000..698a436e7dac
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -0,0 +1,912 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8112 "M2" SoC
+ *
+ * Other names: H14G
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	compatible = "apple,t8112", "apple,arm-platform";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+				core2 {
+					cpu = <&cpu_p2>;
+				};
+				core3 {
+					cpu = <&cpu_p3>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
+			compatible = "apple,blizzard";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <756>;
+			performance-domains = <&cpufreq_e>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e1: cpu@1 {
+			compatible = "apple,blizzard";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <756>;
+			performance-domains = <&cpufreq_e>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e2: cpu@2 {
+			compatible = "apple,blizzard";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <756>;
+			performance-domains = <&cpufreq_e>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e3: cpu@3 {
+			compatible = "apple,blizzard";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&ecluster_opp>;
+			capacity-dmips-mhz = <756>;
+			performance-domains = <&cpufreq_e>;
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_p0: cpu@10100 {
+			compatible = "apple,avalanche";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p1: cpu@10101 {
+			compatible = "apple,avalanche";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p2: cpu@10102 {
+			compatible = "apple,avalanche";
+			device_type = "cpu";
+			reg = <0x0 0x10102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p3: cpu@10103 {
+			compatible = "apple,avalanche";
+			device_type = "cpu";
+			reg = <0x0 0x10103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&pcluster_opp>;
+			capacity-dmips-mhz = <1024>;
+			performance-domains = <&cpufreq_p>;
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x400000>;
+		};
+
+		l2_cache_1: l2-cache-1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x1000000>;
+		};
+	};
+
+	ecluster_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-level = <1>;
+			clock-latency-ns = <7500>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-level = <2>;
+			clock-latency-ns = <20000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1284000000>;
+			opp-level = <3>;
+			clock-latency-ns = <22000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1752000000>;
+			opp-level = <4>;
+			clock-latency-ns = <30000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <2004000000>;
+			opp-level = <5>;
+			clock-latency-ns = <35000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <2256000000>;
+			opp-level = <6>;
+			clock-latency-ns = <39000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <2424000000>;
+			opp-level = <7>;
+			clock-latency-ns = <53000>;
+		};
+	};
+
+	pcluster_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp01 {
+			opp-hz = /bits/ 64 <660000000>;
+			opp-level = <1>;
+			clock-latency-ns = <9000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <924000000>;
+			opp-level = <2>;
+			clock-latency-ns = <19000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1188000000>;
+			opp-level = <3>;
+			clock-latency-ns = <22000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1452000000>;
+			opp-level = <4>;
+			clock-latency-ns = <24000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-level = <5>;
+			clock-latency-ns = <26000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1968000000>;
+			opp-level = <6>;
+			clock-latency-ns = <28000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-level = <7>;
+			clock-latency-ns = <30000>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-level = <8>;
+			clock-latency-ns = <33000>;
+		};
+		opp09 {
+			opp-hz = /bits/ 64 <2568000000>;
+			opp-level = <9>;
+			clock-latency-ns = <34000>;
+		};
+		opp10 {
+			opp-hz = /bits/ 64 <2724000000>;
+			opp-level = <10>;
+			clock-latency-ns = <36000>;
+		};
+		opp11 {
+			opp-hz = /bits/ 64 <2868000000>;
+			opp-level = <11>;
+			clock-latency-ns = <41000>;
+		};
+		opp12 {
+			opp-hz = /bits/ 64 <2988000000>;
+			opp-level = <12>;
+			clock-latency-ns = <42000>;
+		};
+		opp13 {
+			opp-hz = /bits/ 64 <3096000000>;
+			opp-level = <13>;
+			clock-latency-ns = <44000>;
+		};
+		opp14 {
+			opp-hz = /bits/ 64 <3204000000>;
+			opp-level = <14>;
+			clock-latency-ns = <46000>;
+		};
+		/* Not available until CPU deep sleep is implemented */
+#if 0
+		opp15 {
+			opp-hz = /bits/ 64 <3324000000>;
+			opp-level = <15>;
+			clock-latency-ns = <62000>;
+			turbo-mode;
+		};
+		opp16 {
+			opp-hz = /bits/ 64 <3408000000>;
+			opp-level = <16>;
+			clock-latency-ns = <62000>;
+			turbo-mode;
+		};
+		opp17 {
+			opp-hz = /bits/ 64 <3504000000>;
+			opp-level = <17>;
+			clock-latency-ns = <62000>;
+			turbo-mode;
+		};
+#endif
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-e {
+		compatible = "apple,blizzard-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,avalanche-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	/*
+	 * This is a fabulated representation of the input clock
+	 * to NCO since we don't know the true clock tree.
+	 */
+	nco_clkref: clock-ref-nco {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "nco_ref";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges;
+		nonposted-mmio;
+
+		cpufreq_e: cpufreq@210e20000 {
+			compatible = "apple,t8112-cluster-cpufreq", "apple,cluster-cpufreq";
+			reg = <0x2 0x10e20000 0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
+		cpufreq_p: cpufreq@211e20000 {
+			compatible = "apple,t8112-cluster-cpufreq", "apple,cluster-cpufreq";
+			reg = <0x2 0x11e20000 0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
+		sio_dart: iommu@235004000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x2 0x35004000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 769 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_sio_cpu>;
+		};
+
+		i2c0: i2c@235010000 {
+			compatible = "apple,t8112-i2c", "apple,i2c";
+			reg = <0x2 0x35010000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 761 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c0_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@235014000 {
+			compatible = "apple,t8112-i2c", "apple,i2c";
+			reg = <0x2 0x35014000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 762 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c1_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@235018000 {
+			compatible = "apple,t8112-i2c", "apple,i2c";
+			reg = <0x2 0x35018000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 763 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@23501c000 {
+			compatible = "apple,t8112-i2c", "apple,i2c";
+			reg = <0x2 0x3501c000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 764 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c3_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c3>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@235020000 {
+			compatible = "apple,t8112-i2c", "apple,i2c";
+			reg = <0x2 0x35020000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 765 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c4_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c4>;
+			status = "disabled";
+		};
+
+		serial0: serial@235200000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x35200000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 739 IRQ_TYPE_LEVEL_HIGH>;
+			/*
+			 * TODO: figure out the clocking properly, there may
+			 * be a third selectable clock.
+			 */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
+			status = "disabled";
+		};
+
+		serial2: serial@235208000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x35208000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 741 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart2>;
+			status = "disabled";
+		};
+
+		admac: dma-controller@238200000 {
+			compatible = "apple,t8112-admac", "apple,admac";
+			reg = <0x2 0x38200000 0x0 0x34000>;
+			dma-channels = <24>;
+			interrupts-extended = <0>,
+					      <&aic AIC_IRQ 760 IRQ_TYPE_LEVEL_HIGH>,
+					      <0>,
+					      <0>;
+			#dma-cells = <1>;
+			iommus = <&sio_dart 2>;
+			power-domains = <&ps_sio_adma>;
+			resets = <&ps_audio_p>;
+		};
+
+		mca: i2s@238400000 {
+			compatible = "apple,t8112-mca", "apple,mca";
+			reg = <0x2 0x38400000 0x0 0x18000>,
+			      <0x2 0x38300000 0x0 0x30000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 753 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 754 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 755 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 756 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 757 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 758 IRQ_TYPE_LEVEL_HIGH>;
+
+			resets = <&ps_audio_p>;
+			clocks = <&nco 0>, <&nco 1>, <&nco 2>,
+				 <&nco 3>, <&nco 4>, <&nco 4>;
+			power-domains = <&ps_audio_p>, <&ps_mca0>, <&ps_mca1>,
+					<&ps_mca2>, <&ps_mca3>, <&ps_mca4>, <&ps_mca5>;
+			dmas = <&admac 0>, <&admac 1>, <&admac 2>, <&admac 3>,
+			       <&admac 4>, <&admac 5>, <&admac 6>, <&admac 7>,
+			       <&admac 8>, <&admac 9>, <&admac 10>, <&admac 11>,
+			       <&admac 12>, <&admac 13>, <&admac 14>, <&admac 15>,
+			       <&admac 16>, <&admac 17>, <&admac 18>, <&admac 19>,
+			       <&admac 20>, <&admac 21>, <&admac 22>, <&admac 23>;
+			dma-names = "tx0a", "rx0a", "tx0b", "rx0b",
+				    "tx1a", "rx1a", "tx1b", "rx1b",
+				    "tx2a", "rx2a", "tx2b", "rx2b",
+				    "tx3a", "rx3a", "tx3b", "rx3b",
+				    "tx4a", "rx4a", "tx4b", "rx4b",
+				    "tx5a", "rx5a", "tx5b", "rx5b";
+
+			#sound-dai-cells = <1>;
+		};
+
+		nco: clock-controller@23b044000 {
+			compatible = "apple,t8112-nco", "apple,nco";
+			reg = <0x2 0x3b044000 0x0 0x14000>;
+			clocks = <&nco_clkref>;
+			#clock-cells = <1>;
+		};
+
+		aic: interrupt-controller@23b0c0000 {
+			compatible = "apple,t8112-aic", "apple,aic2";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x2 0x3b0c0000 0x0 0x8000>,
+				<0x2 0x3b0c8000 0x0 0x4>;
+			reg-names = "core", "event";
+			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1 &cpu_p2 &cpu_p3>;
+				};
+			};
+		};
+
+		pmgr: power-management@23b700000 {
+			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2 0x3b700000 0 0x14000>;
+			/* child nodes are added in t8103-pmgr.dtsi */
+		};
+
+		pinctrl_ap: pinctrl@23c100000 {
+			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x3c100000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 213>;
+			apple,npins = <213>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 205 IRQ_TYPE_LEVEL_HIGH>;
+
+			i2c0_pins: i2c0-pins {
+				pinmux = <APPLE_PINMUX(111, 1)>,
+					 <APPLE_PINMUX(110, 1)>;
+			};
+
+			i2c1_pins: i2c1-pins {
+				pinmux = <APPLE_PINMUX(113, 1)>,
+					 <APPLE_PINMUX(112, 1)>;
+			};
+
+			i2c2_pins: i2c2-pins {
+				pinmux = <APPLE_PINMUX(87, 1)>,
+					 <APPLE_PINMUX(86, 1)>;
+			};
+
+			i2c3_pins: i2c3-pins {
+				pinmux = <APPLE_PINMUX(54, 1)>,
+					 <APPLE_PINMUX(53, 1)>;
+			};
+
+			i2c4_pins: i2c4-pins {
+				pinmux = <APPLE_PINMUX(131, 1)>,
+					 <APPLE_PINMUX(130, 1)>;
+			};
+
+			spi3_pins: spi3-pins {
+				pinmux = <APPLE_PINMUX(46, 1)>,
+					<APPLE_PINMUX(47, 1)>,
+					<APPLE_PINMUX(48, 1)>,
+					<APPLE_PINMUX(49, 1)>;
+			};
+
+			pcie_pins: pcie-pins {
+				pinmux = <APPLE_PINMUX(162, 1)>,
+					 <APPLE_PINMUX(163, 1)>,
+					 <APPLE_PINMUX(164, 1)>;
+				// TODO: 1 more CLKREQs
+			};
+		};
+
+		pinctrl_nub: pinctrl@23d1f0000 {
+			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x3d1f0000 0x0 0x4000>;
+			power-domains = <&ps_nub_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_nub 0 0 24>;
+			apple,npins = <24>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 371 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 372 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 373 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 376 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 377 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pmgr_mini: power-management@23d280000 {
+			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2 0x3d280000 0 0x4000>;
+			/* child nodes are added in t8103-pmgr.dtsi */
+		};
+
+		wdt: watchdog@23d2b0000 {
+			compatible = "apple,t8112-wdt", "apple,wdt";
+			reg = <0x2 0x3d2b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 379 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_smc: pinctrl@23e820000 {
+			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x3e820000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_smc 0 0 18>;
+			apple,npins = <18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 490 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 491 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 492 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 493 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 494 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 495 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 496 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@24a820000 {
+			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x4a820000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 54>;
+			apple,npins = <54>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 301 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 302 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 303 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 305 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 307 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		ans_mbox: mbox@277408000 {
+			compatible = "apple,t8112-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0x77408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 717 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 718 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 719 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 720 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans>;
+		};
+
+		sart: sart@27bc50000 {
+			compatible = "apple,t8112-sart", "apple,t6000-sart";
+			reg = <0x2 0x7bc50000 0x0 0x10000>;
+			power-domains = <&ps_ans>;
+		};
+
+		nvme@27bcc0000 {
+			compatible = "apple,t8112-nvme-ans2", "apple,nvme-ans2";
+			reg = <0x2 0x7bcc0000 0x0 0x40000>,
+				<0x2 0x77400000 0x0 0x4000>;
+			reg-names = "nvme", "ans";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 724 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			apple,sart = <&sart>;
+			power-domains = <&ps_ans>, <&ps_apcie_st>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans>;
+		};
+
+		pcie0_dart: iommu@681008000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x6 0x81008000 0x0 0x4000>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 782 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_apcie_gp>;
+		};
+
+		pcie1_dart: iommu@682008000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x6 0x82008000 0x0 0x4000>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 785 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_apcie_gp>;
+			status = "disabled";
+		};
+
+		pcie2_dart: iommu@683008000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x6 0x83008000 0x0 0x4000>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 788 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_apcie_gp>;
+			status = "disabled";
+		};
+
+		pcie3_dart: iommu@684008000 {
+			compatible = "apple,t8110-dart";
+			reg = <0x6 0x84008000 0x0 0x4000>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 791 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&ps_apcie_gp>;
+			status = "disabled";
+		};
+
+		pcie0: pcie@690000000 {
+			compatible = "apple,t8112-pcie", "apple,pcie";
+			device_type = "pci";
+
+			reg = <0x6 0x90000000 0x0 0x1000000>,
+			      <0x6 0x80000000 0x0 0x100000>,
+			      <0x6 0x81000000 0x0 0x4000>,
+			      <0x6 0x82000000 0x0 0x4000>,
+			      <0x6 0x83000000 0x0 0x4000>,
+			      <0x6 0x84000000 0x0 0x4000>;
+			reg-names = "config", "rc", "port0", "port1", "port2", "port3";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 781 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 784 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 787 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 790 IRQ_TYPE_LEVEL_HIGH>;
+
+			msi-controller;
+			msi-parent = <&pcie0>;
+			msi-ranges = <&aic AIC_IRQ 793 IRQ_TYPE_EDGE_RISING 32>;
+
+			iommu-map = <0x100 &pcie0_dart 0 1>,
+				    <0x200 &pcie1_dart 1 1>,
+				    <0x300 &pcie2_dart 2 1>,
+				    <0x400 &pcie3_dart 3 1>;
+			iommu-map-mask = <0xff00>;
+
+			bus-range = <0 4>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
+				 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
+
+			power-domains = <&ps_apcie_gp>;
+			pinctrl-0 = <&pcie_pins>;
+			pinctrl-names = "default";
+
+			port00: pci@0,0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				reset-gpios = <&pinctrl_ap 166 GPIO_ACTIVE_LOW>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
+						<0 0 0 2 &port00 0 0 0 1>,
+						<0 0 0 3 &port00 0 0 0 2>,
+						<0 0 0 4 &port00 0 0 0 3>;
+			};
+
+			port01: pci@1,0 {
+				device_type = "pci";
+				reg = <0x800 0x0 0x0 0x0 0x0>;
+				reset-gpios = <&pinctrl_ap 167 GPIO_ACTIVE_LOW>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &port01 0 0 0 0>,
+						<0 0 0 2 &port01 0 0 0 1>,
+						<0 0 0 3 &port01 0 0 0 2>,
+						<0 0 0 4 &port01 0 0 0 3>;
+
+				status = "disabled";
+			};
+
+			port02: pci@2,0 {
+				device_type = "pci";
+				reg = <0x1000 0x0 0x0 0x0 0x0>;
+				reset-gpios = <&pinctrl_ap 168 GPIO_ACTIVE_LOW>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &port02 0 0 0 0>,
+						<0 0 0 2 &port02 0 0 0 1>,
+						<0 0 0 3 &port02 0 0 0 2>,
+						<0 0 0 4 &port02 0 0 0 3>;
+
+				status = "disabled";
+			};
+
+			/* TODO: GPIO unknown */
+			port03: pci@3,0 {
+				device_type = "pci";
+				reg = <0x1800 0x0 0x0 0x0 0x0>;
+				//reset-gpios = <&pinctrl_ap 33 GPIO_ACTIVE_LOW>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &port03 0 0 0 0>,
+						<0 0 0 2 &port03 0 0 0 1>,
+						<0 0 0 3 &port03 0 0 0 2>,
+						<0 0 0 4 &port03 0 0 0 3>;
+
+				status = "disabled";
+			};
+		};
+	};
+};
+
+#include "t8112-pmgr.dtsi"

-- 
2.39.2

