Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3656EF2F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbjDZK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbjDZK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:57:40 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445025265;
        Wed, 26 Apr 2023 03:57:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QAvVPB098624;
        Wed, 26 Apr 2023 05:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682506651;
        bh=Hm3EJu/qSrw2t3pXQaTOtm7l7auBwyIGsWpsVYasJ9M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qo8842UHPs4xMMeaUPoNK8+Lbn4WFr/I5P7iAjPpqVKy13FsZ/bcMl8g4XePTTGo4
         1nVO7iBKoVd0WJ9ylqwkJ/Gl1uhAobQumwXBOIMiTWnLqbzdH0G++Tgp85//uaZkL9
         HeP3A8yXS6kAZTNA4se+G2UWgNHqH2kN4G59X7sI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QAvVIm096485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 05:57:31 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 05:57:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 05:57:31 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QAvJqV001570;
        Wed, 26 Apr 2023 05:57:27 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH 2/2] arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI
Date:   Wed, 26 Apr 2023 16:27:18 +0530
Message-ID: <20230426105718.118806-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426105718.118806-1-s-vadapalli@ti.com>
References: <20230426105718.118806-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

The MAIN CPSW2G instance of CPSW on J721S2 SoC can be enabled with the GESI
Expansion Board connected to the J7 Common-Proc-Board. Use the overlay
to enable this.

Add alias for the MAIN CPSW2G port to enable kernel to fetch MAC address
directly from U-Boot.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 83 +++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c83c9d772b81..13db9b8dbe1d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 # Boards with J721s2 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
 
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
@@ -49,3 +50,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-j721s2-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
new file mode 100644
index 000000000000..2ec08754bf04
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for MAIN CPSW2G using GESI Expansion Board with J7 common processor board.
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
+		ethernet1 = "/bus@100000/ethernet@c200000/ethernet-ports/port@1";
+	};
+};
+
+&main_pmx0 {
+	main_cpsw_mdio_pins_default: main-cpsw-mdio-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0c0, PIN_OUTPUT, 6) /* (T28) MCASP1_AXR0.MDIO0_MDC */
+			J721S2_IOPAD(0x0bc, PIN_INPUT, 6) /* (V28) MCASP1_AFSX.MDIO0_MDIO */
+		>;
+	};
+
+	rgmii1_pins_default: rgmii1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0b8, PIN_INPUT, 6) /* (AA24) MCASP1_ACLKX.RGMII1_RD0 */
+			J721S2_IOPAD(0x0a0, PIN_INPUT, 6) /* (AB25) MCASP0_AXR12.RGMII1_RD1 */
+			J721S2_IOPAD(0x0a4, PIN_INPUT, 6) /* (T23) MCASP0_AXR13.RGMII1_RD2 */
+			J721S2_IOPAD(0x0a8, PIN_INPUT, 6) /* (U24) MCASP0_AXR14.RGMII1_RD3 */
+			J721S2_IOPAD(0x0b0, PIN_INPUT, 6) /* (AD26) MCASP1_AXR3.RGMII1_RXC */
+			J721S2_IOPAD(0x0ac, PIN_INPUT, 6) /* (AC25) MCASP0_AXR15.RGMII1_RX_CTL */
+			J721S2_IOPAD(0x08c, PIN_OUTPUT, 6) /* (T25) MCASP0_AXR7.RGMII1_TD0 */
+			J721S2_IOPAD(0x090, PIN_OUTPUT, 6) /* (W24) MCASP0_AXR8.RGMII1_TD1 */
+			J721S2_IOPAD(0x094, PIN_OUTPUT, 6) /* (AA25) MCASP0_AXR9.RGMII1_TD2 */
+			J721S2_IOPAD(0x098, PIN_OUTPUT, 6) /* (V25) MCASP0_AXR10.RGMII1_TD3 */
+			J721S2_IOPAD(0x0b4, PIN_OUTPUT, 6) /* (U25) MCASP1_AXR4.RGMII1_TXC */
+			J721S2_IOPAD(0x09c, PIN_OUTPUT, 6) /* (T24) MCASP0_AXR11.RGMII1_TX_CTL */
+		>;
+	};
+};
+
+&exp1 {
+	p15 {
+		/* P15 - EXP_MUX2 */
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "EXP_MUX2";
+	};
+};
+
+&main_cpsw {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_pins_default>;
+};
+
+&main_cpsw_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_cpsw_mdio_pins_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	main_cpsw_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&main_cpsw_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&main_cpsw_phy0>;
+};
-- 
2.25.1

