Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DD6C4ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCVMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjCVMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:40:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5627B4D603;
        Wed, 22 Mar 2023 05:40:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32MCdpeH061268;
        Wed, 22 Mar 2023 07:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679488791;
        bh=6H/hPJGtJSUE1B5vlPy/QUFC8opB7huwtt/IQA640GE=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Z0WuMvR0bURGyP3hvFOSBlxs8EjwjV/Q7qen7cFPhPTfWtlEOeyq5ckOr8KQy5awX
         FzyjkLV8P2HGEBFp1DnCnHZF61SusV6GTnfUZWxBIFOfJ8idnAtVFrd0fh/BL+ejbH
         WG7SKuGrwPy07uqGLMvO4GJBnF0b8KFF7QBqeYzU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32MCdpIA066300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 07:39:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 22
 Mar 2023 07:39:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 22 Mar 2023 07:39:51 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32MCdcna098356;
        Wed, 22 Mar 2023 07:39:48 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Date:   Wed, 22 Mar 2023 18:09:22 +0530
Subject: [PATCH v2 3/3] arm64: ti: dts: Add support for AM62x LP SK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230321-am62-lp-sk-v2-3-0a56e1694804@ti.com>
References: <20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com>
In-Reply-To: <20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lore.kernel.org/r/20230320051304.2730692-1-vigneshr@ti.com>,
        Anand Gadiyar <gadiyar@ti.com>
X-Mailer: b4 0.12.2
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

The AM62x LP SK board is similar to the AM62x SK board, but has some
not-so-minor changes that requires different device tree.

The differences are mainly:
- AM62x SoC in the AMC package that meets AECQ100 automotive standard.
- LPDDR4 versus DDR4 on the AM62x SK.
- TPS65219 PMIC instead of discrete regulators.
- IO expander pin names are wired differently.
- Second ethernet port is currently disabled as the boards do not have
  the part physically installed.
- OSPI NAND vs OSPI NOR.
- No WLAN chip instead a SDIO M.2 connector.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
[vigneshr@ti.com: Add PMIC node]
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile          |   1 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 227 ++++++++++
 2 files changed, 228 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 6acd12409d59..785cc4f97e1e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -10,6 +10,7 @@
 
 # Boards with AM62x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
new file mode 100644
index 000000000000..b2ca19e3042e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM62x LP SK: https://www.ti.com/tool/SK-AM62-LP
+ *
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-am62x-sk-common.dtsi"
+
+/ {
+	compatible = "ti,am62-lp-sk", "ti,am625";
+	model = "Texas Instruments AM62x LP SK";
+
+	vmain_pd: regulator-0 {
+		/* TPS65988 PD CONTROLLER OUTPUT */
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_5v0: regulator-1 {
+		/* Output of TPS630702RNMR */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_3v3_sys: regulator-2 {
+		/* output of LM61460-Q1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-3 {
+		/* TPS22918DBVR */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vcc_3v3_sys>;
+		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	vddshv_sdio: regulator-4 {
+		compatible = "regulator-gpio";
+		regulator-name = "vddshv_sdio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vddshv_sdio_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&ldo1_reg>;
+		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+};
+
+&main_pmx0 {
+	vddshv_sdio_pins_default: vddshv-sdio-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
+		>;
+	};
+
+	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (C13) UART0_RTSn.GPIO1_23 */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (B16) EXTINTn */
+		>;
+	};
+};
+
+&main_i2c1 {
+	exp1: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
+				   "PRU_DETECT", "MMC1_SD_EN",
+				   "VPP_LDO_EN", "EXP_PS_3V3_En",
+				   "EXP_PS_5V0_En", "EXP_HAT_DETECT",
+				   "GPIO_AUD_RSTn", "GPIO_eMMC_RSTn",
+				   "UART1_FET_BUF_EN", "BT_UART_WAKE_SOC",
+				   "GPIO_HDMI_RSTn", "CSI_GPIO0",
+				   "CSI_GPIO1", "GPIO_OLDI_INT",
+				   "HDMI_INTn", "TEST_GPIO2",
+				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
+				   "MCASP1_FET_SEL", "UART1_FET_SEL",
+				   "", "IO_EXP_TEST_LED";
+
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+	};
+
+	exp2: gpio@23 {
+		compatible = "ti,tca6424";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "", "",
+				   "", "",
+				   "", "",
+				   "", "",
+				   "WL_LT_EN", "CSI_RSTz",
+				   "", "",
+				   "", "",
+				   "", "",
+				   "SPI0_FET_SEL", "SPI0_FET_OE",
+				   "GPIO_OLDI_RSTn", "PRU_3V3_EN",
+				   "", "",
+				   "CSI_VLDO_SEL", "SOC_WLAN_SDIO_RST";
+	};
+};
+
+&sdhci1 {
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vddshv_sdio>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
+&main_i2c0 {
+	tps65219: pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		buck1-supply = <&vcc_3v3_sys>;
+		buck2-supply = <&vcc_3v3_sys>;
+		buck3-supply = <&vcc_3v3_sys>;
+		ldo1-supply = <&vcc_3v3_sys>;
+		ldo2-supply = <&buck2_reg>;
+		ldo3-supply = <&vcc_3v3_sys>;
+		ldo4-supply = <&vcc_3v3_sys>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		ti,power-button;
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-name = "VCC1V8_SYS";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "VDD_LPDDR4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-name = "VDDSHV_SDIO";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-name = "VDDAR_CORE";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-name = "VDD_1V2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};

-- 
2.40.0

