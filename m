Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A26D8A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjDEWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDEWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:31:36 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 15:31:34 PDT
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C5810C8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=9024; q=dns/txt; s=iport;
  t=1680733894; x=1681943494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hVP+U8JQfuHPAmjtmIY5NQJcglbPXDOTcwXu+SAHQUA=;
  b=a4aNk8bruRkkqBUnoSsFEaiS4nkvoM8ic0wLRmJpGZYGnD7gM6s79gXa
   c4PBqizLAg91RA3yAcQ5BQEIrqzCCOs4kbrJKtRYqUGhF7gDeIz/hlzJx
   9QW/tZj+MbAGua8yyFDVMBvbLidg9X+GIMRUusFNRLoHzdb0v/GIoxGlm
   k=;
X-IronPort-AV: E=Sophos;i="5.98,322,1673913600"; 
   d="scan'208";a="91839697"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 05 Apr 2023 22:30:30 +0000
Received: from localhost.localdomain ([10.160.65.27])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id 335MUSxI031603;
        Wed, 5 Apr 2023 22:30:29 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        xe-linux-external@cisco.com
Cc:     Marcin Wierzbicki <mawierzb@cisco.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: cisco: add device tree for Cisco CrayAr Argos
Date:   Wed,  5 Apr 2023 15:30:26 -0700
Message-Id: <20230405223028.1268141-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.160.65.27, [10.160.65.27]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Wierzbicki <mawierzb@cisco.com>

Adds device tree include file for Cisco CrayAR SoC and
device tree file for Cisco CrayAR Argos EVB board.

Cc: xe-linux-external@cisco.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Marcin Wierzbicki <mawierzb@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 MAINTAINERS                                |   5 +
 arch/arm64/Kconfig.platforms               |   5 +
 arch/arm64/boot/dts/Makefile               |   1 +
 arch/arm64/boot/dts/cisco/Makefile         |   2 +
 arch/arm64/boot/dts/cisco/crayar.dtsi      | 247 +++++++++++++++++++++
 arch/arm64/boot/dts/cisco/crayar_argos.dts |  32 +++
 6 files changed, 292 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cisco/Makefile
 create mode 100644 arch/arm64/boot/dts/cisco/crayar.dtsi
 create mode 100644 arch/arm64/boot/dts/cisco/crayar_argos.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..ff99020029f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4793,6 +4793,11 @@ X:	drivers/char/ipmi/
 X:	drivers/char/random.c
 X:	drivers/char/tpm/
 
+CISCO ARM64 DEVICE TREE SUPPORT
+M:	xe-linux-external@cisco.com
+S:	Supported
+F:	arch/arm64/boot/dts/cisco/
+
 CHECKPATCH
 M:	Andy Whitcroft <apw@canonical.com>
 M:	Joe Perches <joe@perches.com>
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..740099c56382 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -94,6 +94,11 @@ config ARCH_BITMAIN
 	help
 	  This enables support for the Bitmain SoC Family.
 
+config ARCH_CISCO_CRAYAR_ARGOS
+	bool "Cisco Argos Platform"
+	help
+	  This enables support for the Cisco Argos Platform.
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 7b107fa7414b..3f83583f9996 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -11,6 +11,7 @@ subdir-y += arm
 subdir-y += bitmain
 subdir-y += broadcom
 subdir-y += cavium
+subdir-y += cisco
 subdir-y += exynos
 subdir-y += freescale
 subdir-y += hisilicon
diff --git a/arch/arm64/boot/dts/cisco/Makefile b/arch/arm64/boot/dts/cisco/Makefile
new file mode 100644
index 000000000000..b1d4220df2f4
--- /dev/null
+++ b/arch/arm64/boot/dts/cisco/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CISCO_CRAYAR_ARGOS) += crayar_argos.dtb
diff --git a/arch/arm64/boot/dts/cisco/crayar.dtsi b/arch/arm64/boot/dts/cisco/crayar.dtsi
new file mode 100644
index 000000000000..6ae5e1653318
--- /dev/null
+++ b/arch/arm64/boot/dts/cisco/crayar.dtsi
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Include file for Cisco CrayAR family SoC.
+ *
+ * Copyright (C) 2022 Cisco
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "cisco,crayar";
+	interrupt-parent = <&gic>;
+	#address-cells = <0x2>;
+	#size-cells = <0x2>;
+
+	base_clk: base-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <500000000>;
+	};
+
+	cpus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x00000>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x00100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x00200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x00300>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_3>;
+		};
+
+		cpu4: cpu@10000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x10000>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_4>;
+		};
+
+		cpu5: cpu@10100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_5>;
+		};
+
+		cpu6: cpu@10200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x10200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_6>;
+		};
+
+		cpu7: cpu@10300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x10300>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x7003fff8>;
+			next-level-cache = <&l2_7>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			next-level-cache = <&l3_0>;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			next-level-cache = <&l3_0>;
+		};
+
+		l2_2: l2-cache2 {
+			compatible = "cache";
+			next-level-cache = <&l3_0>;
+		};
+
+		l2_3: l2-cache3 {
+			compatible = "cache";
+			next-level-cache = <&l3_0>;
+		};
+
+		l2_4: l2-cache4 {
+			compatible = "cache";
+			next-level-cache = <&l3_1>;
+		};
+
+		l2_5: l2-cache5 {
+			compatible = "cache";
+			next-level-cache = <&l3_1>;
+		};
+
+		l2_6: l2-cache6 {
+			compatible = "cache";
+			next-level-cache = <&l3_1>;
+		};
+
+		l2_7: l2-cache7 {
+			compatible = "cache";
+			next-level-cache = <&l3_1>;
+		};
+
+		l3_0: l3-cache0 {
+			compatible = "cache";
+		};
+
+		l3_1: l3-cache1 {
+			compatible = "cache";
+		};
+	};
+
+	cci: cci@2e000000 {
+		compatible = "arm,cci-550";
+		reg = <0x0 0x2e000000 0x0 0x1000>;
+		ranges = <0x0 0x0 0x2e000000 0x6000>;
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts =	<GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gic: interrupt-controller@20000000 {
+		compatible = "arm,gic-v3";
+		reg =	<0x0 0x20000000 0x0 0x10000>,	/* GICD */
+			<0x0 0x20060000 0x0 0x100000>;	/* GICR */
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		msi-controller;
+		mbi-ranges = <256 224>;
+
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its: msi-controller@20040000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x0 0x20040000 0x0 0x10000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges = <0x0 0x0 0x0 0x0 0x100 0x0>;
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+
+		uart0: serial@23f80000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x23f80000 0x0 0x100>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <0x2>;
+			reg-io-width = <0x4>;
+			clocks = <&base_clk>;
+			current-speed = <9600>;
+			status = "disabled";
+		};
+
+		uart1: serial@23fc0000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x23fc0000 0x0 0x100>;
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <0x2>;
+			reg-io-width = <0x4>;
+			clocks = <&base_clk>;
+			current-speed = <9600>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/cisco/crayar_argos.dts b/arch/arm64/boot/dts/cisco/crayar_argos.dts
new file mode 100644
index 000000000000..cbdf3c13bf52
--- /dev/null
+++ b/arch/arm64/boot/dts/cisco/crayar_argos.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Cisco CrayAR Argos EVB board.
+ *
+ * Copyright (C) 2022 Cisco
+ */
+
+/dts-v1/;
+#include "crayar.dtsi"
+
+/ {
+	compatible = "cisco,crayar-argos", "cisco,crayar";
+	model = "Cisco CrayAr Argos EVB";
+	version = <0x00000001>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:9600n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.25.1

