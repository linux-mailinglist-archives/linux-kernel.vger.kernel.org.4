Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76558714737
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjE2Jmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE2Jmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:42:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A890;
        Mon, 29 May 2023 02:42:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34T9gQvH058082;
        Mon, 29 May 2023 04:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685353346;
        bh=qcyWyNvZPs6e8PY3hCn9iFCEEj8U7x6tMLFjejghvrQ=;
        h=From:To:CC:Subject:Date;
        b=AFybdTkAdBLvg4grn5+j0FQ3CCNGmUehuwk1ePrQIdgj7lJBM3HgYSwkQ/Tv70BgO
         sk9z26+ewTxsqfgf7fO9z2cXBDvVMTB8NOBNDi1DD5pv8OBBoyUntPFaPz2JejxNwb
         JwxrC3M8sN1IPovVWzP9R1DFhVsoDrm0NQF/baZo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34T9gQ3B023603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 May 2023 04:42:26 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 May 2023 04:42:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 May 2023 04:42:26 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34T9gM5X096630;
        Mon, 29 May 2023 04:42:23 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports with GESI
Date:   Mon, 29 May 2023 15:12:22 +0530
Message-ID: <20230529094222.512675-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J7 GESI EXP board for J721E Common-Proc-Board supports RGMII mode.
Use the overlay to configure CPSW9G ports in RGMII-RXID mode.

Add aliases for CPSW9G ports to enable kernel to fetch MAC addresses
directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Note: This patch is based on linux-next tagged next-20230525.

 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../dts/ti/k3-j721e-evm-gesi-exp-board.dtso   | 196 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c83c9d772b81..6ca1ee2735e1 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-evm.dtb
 k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-exp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 
 # Boards with J721s2 SoC
@@ -49,3 +50,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-j721e-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
new file mode 100644
index 000000000000..5a8e074a924b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for CPSW9G in RGMII mode using J7 GESI EXP BRD board with
+ * J721E board.
+ *
+ * GESI Board Product Link: https://www.ti.com/tool/J7EXPCXEVM
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+#include "k3-pinctrl.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@1";
+		ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@2";
+		ethernet3 = "/bus@100000/ethernet@c000000/ethernet-ports/port@3";
+		ethernet4 = "/bus@100000/ethernet@c000000/ethernet-ports/port@4";
+	};
+};
+
+&cpsw0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_pins_default
+		     &rgmii2_pins_default
+		     &rgmii3_pins_default
+		     &rgmii4_pins_default>;
+};
+
+&cpsw0_port1 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy12>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>;
+};
+
+&cpsw0_port2 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy15>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>;
+};
+
+&cpsw0_port3 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy0>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 3>;
+};
+
+&cpsw0_port4 {
+	status = "okay";
+	phy-handle = <&cpsw9g_phy3>;
+	phy-mode = "rgmii-rxid";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 4>;
+};
+
+&cpsw9g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins_default>;
+	bus_freq = <1000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpsw9g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+	cpsw9g_phy3: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+	cpsw9g_phy12: ethernet-phy@12 {
+		reg = <12>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+	cpsw9g_phy15: ethernet-phy@15 {
+		reg = <15>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&exp1 {
+	p15-hog {
+		/* P15 - EXP_MUX2 */
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "EXP_MUX2";
+	};
+
+	p16-hog {
+		/* P16 - EXP_MUX3 */
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "EXP_MUX3";
+	};
+};
+
+&main_pmx0 {
+	mdio0_pins_default: mdio0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1bc, PIN_OUTPUT, 0) /* (V24) MDIO0_MDC */
+			J721E_IOPAD(0x1b8, PIN_INPUT, 0) /* (V26) MDIO0_MDIO */
+		>;
+	};
+
+	rgmii1_pins_default: rgmii1-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x4, PIN_INPUT, 4) /* (AC23) PRG1_PRU0_GPO0.RGMII1_RD0 */
+			J721E_IOPAD(0x8, PIN_INPUT, 4) /* (AG22) PRG1_PRU0_GPO1.RGMII1_RD1 */
+			J721E_IOPAD(0xc, PIN_INPUT, 4) /* (AF22) PRG1_PRU0_GPO2.RGMII1_RD2 */
+			J721E_IOPAD(0x10, PIN_INPUT, 4) /* (AJ23) PRG1_PRU0_GPO3.RGMII1_RD3 */
+			J721E_IOPAD(0x1c, PIN_INPUT, 4) /* (AD22) PRG1_PRU0_GPO6.RGMII1_RXC */
+			J721E_IOPAD(0x14, PIN_INPUT, 4) /* (AH23) PRG1_PRU0_GPO4.RGMII1_RX_CTL */
+			J721E_IOPAD(0x30, PIN_OUTPUT, 4) /* (AF24) PRG1_PRU0_GPO11.RGMII1_TD0 */
+			J721E_IOPAD(0x34, PIN_OUTPUT, 4) /* (AJ24) PRG1_PRU0_GPO12.RGMII1_TD1 */
+			J721E_IOPAD(0x38, PIN_OUTPUT, 4) /* (AG24) PRG1_PRU0_GPO13.RGMII1_TD2 */
+			J721E_IOPAD(0x3c, PIN_OUTPUT, 4) /* (AD24) PRG1_PRU0_GPO14.RGMII1_TD3 */
+			J721E_IOPAD(0x44, PIN_OUTPUT, 4) /* (AE24) PRG1_PRU0_GPO16.RGMII1_TXC */
+			J721E_IOPAD(0x40, PIN_OUTPUT, 4) /* (AC24) PRG1_PRU0_GPO15.RGMII1_TX_CTL */
+		>;
+	};
+
+	rgmii2_pins_default: rgmii2-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x58, PIN_INPUT, 4) /* (AE22) PRG1_PRU1_GPO0.RGMII2_RD0 */
+			J721E_IOPAD(0x5c, PIN_INPUT, 4) /* (AG23) PRG1_PRU1_GPO1.RGMII2_RD1 */
+			J721E_IOPAD(0x60, PIN_INPUT, 4) /* (AF23) PRG1_PRU1_GPO2.RGMII2_RD2 */
+			J721E_IOPAD(0x64, PIN_INPUT, 4) /* (AD23) PRG1_PRU1_GPO3.RGMII2_RD3 */
+			J721E_IOPAD(0x70, PIN_INPUT, 4) /* (AE23) PRG1_PRU1_GPO6.RGMII2_RXC */
+			J721E_IOPAD(0x68, PIN_INPUT, 4) /* (AH24) PRG1_PRU1_GPO4.RGMII2_RX_CTL */
+			J721E_IOPAD(0x84, PIN_OUTPUT, 4) /* (AJ25) PRG1_PRU1_GPO11.RGMII2_TD0 */
+			J721E_IOPAD(0x88, PIN_OUTPUT, 4) /* (AH25) PRG1_PRU1_GPO12.RGMII2_TD1 */
+			J721E_IOPAD(0x8c, PIN_OUTPUT, 4) /* (AG25) PRG1_PRU1_GPO13.RGMII2_TD2 */
+			J721E_IOPAD(0x90, PIN_OUTPUT, 4) /* (AH26) PRG1_PRU1_GPO14.RGMII2_TD3 */
+			J721E_IOPAD(0x98, PIN_OUTPUT, 4) /* (AJ26) PRG1_PRU1_GPO16.RGMII2_TXC */
+			J721E_IOPAD(0x94, PIN_OUTPUT, 4) /* (AJ27) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
+		>;
+	};
+
+	rgmii3_pins_default: rgmii3-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xb0, PIN_INPUT, 4) /* (AF28) PRG0_PRU0_GPO0.RGMII3_RD0 */
+			J721E_IOPAD(0xb4, PIN_INPUT, 4) /* (AE28) PRG0_PRU0_GPO1.RGMII3_RD1 */
+			J721E_IOPAD(0xb8, PIN_INPUT, 4) /* (AE27) PRG0_PRU0_GPO2.RGMII3_RD2 */
+			J721E_IOPAD(0xbc, PIN_INPUT, 4) /* (AD26) PRG0_PRU0_GPO3.RGMII3_RD3 */
+			J721E_IOPAD(0xc8, PIN_INPUT, 4) /* (AE26) PRG0_PRU0_GPO6.RGMII3_RXC */
+			J721E_IOPAD(0xc0, PIN_INPUT, 4) /* (AD25) PRG0_PRU0_GPO4.RGMII3_RX_CTL */
+			J721E_IOPAD(0xdc, PIN_OUTPUT, 4) /* (AJ28) PRG0_PRU0_GPO11.RGMII3_TD0 */
+			J721E_IOPAD(0xe0, PIN_OUTPUT, 4) /* (AH27) PRG0_PRU0_GPO12.RGMII3_TD1 */
+			J721E_IOPAD(0xe4, PIN_OUTPUT, 4) /* (AH29) PRG0_PRU0_GPO13.RGMII3_TD2 */
+			J721E_IOPAD(0xe8, PIN_OUTPUT, 4) /* (AG28) PRG0_PRU0_GPO14.RGMII3_TD3 */
+			J721E_IOPAD(0xf0, PIN_OUTPUT, 4) /* (AH28) PRG0_PRU0_GPO16.RGMII3_TXC */
+			J721E_IOPAD(0xec, PIN_OUTPUT, 4) /* (AG27) PRG0_PRU0_GPO15.RGMII3_TX_CTL */
+		>;
+	};
+
+	rgmii4_pins_default: rgmii4-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x100, PIN_INPUT, 4) /* (AE29) PRG0_PRU1_GPO0.RGMII4_RD0 */
+			J721E_IOPAD(0x104, PIN_INPUT, 4) /* (AD28) PRG0_PRU1_GPO1.RGMII4_RD1 */
+			J721E_IOPAD(0x108, PIN_INPUT, 4) /* (AD27) PRG0_PRU1_GPO2.RGMII4_RD2 */
+			J721E_IOPAD(0x10c, PIN_INPUT, 4) /* (AC25) PRG0_PRU1_GPO3.RGMII4_RD3 */
+			J721E_IOPAD(0x118, PIN_INPUT, 4) /* (AC26) PRG0_PRU1_GPO6.RGMII4_RXC */
+			J721E_IOPAD(0x110, PIN_INPUT, 4) /* (AD29) PRG0_PRU1_GPO4.RGMII4_RX_CTL */
+			J721E_IOPAD(0x12c, PIN_OUTPUT, 4) /* (AG26) PRG0_PRU1_GPO11.RGMII4_TD0 */
+			J721E_IOPAD(0x130, PIN_OUTPUT, 4) /* (AF27) PRG0_PRU1_GPO12.RGMII4_TD1 */
+			J721E_IOPAD(0x134, PIN_OUTPUT, 4) /* (AF26) PRG0_PRU1_GPO13.RGMII4_TD2 */
+			J721E_IOPAD(0x138, PIN_OUTPUT, 4) /* (AE25) PRG0_PRU1_GPO14.RGMII4_TD3 */
+			J721E_IOPAD(0x140, PIN_OUTPUT, 4) /* (AG29) PRG0_PRU1_GPO16.RGMII4_TXC */
+			J721E_IOPAD(0x13c, PIN_OUTPUT, 4) /* (AF29) PRG0_PRU1_GPO15.RGMII4_TX_CTL */
+		>;
+	};
+};
-- 
2.25.1

