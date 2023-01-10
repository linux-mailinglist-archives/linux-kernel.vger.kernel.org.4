Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EDA664032
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbjAJMRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjAJMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:17:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B85FBB;
        Tue, 10 Jan 2023 04:15:25 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AC3LrJ022707;
        Tue, 10 Jan 2023 12:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=CW6FeajpJx245Ti8rqm/sRaNR2i9b469SoTxihPe6Rw=;
 b=S4N3jWw89S6+p41nkk84n7Tvb+fBfpwqiqd2TNTgcNRPwGkMg5WZo4r9ypb1RQDN7rOH
 TEETfKw7BteCft7+egR05ekXY7ZFJHpSuVeWuNFyq3vaFoB0m89wYr15AHL40lx3cOT3
 B59PfHKlw4mh+tjUZXffV2j6mVTsLOQ462ecOiQpkyR72MqQiB5JRAOi4AtVjmXuHipJ
 Fw+WqlpGEl6XgWThMAr6h6k0mlGd1SCTWPcnb4U4JPxNjKxo8fsJ31u5mP5jz0D+wU1U
 +Z9NspqQEpTuzW3nyUyn1gZ2C79TLaCER4dAREUuxheby5cAqrLO2kj+ZijqFVzsIJ3k hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n13cngmcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:14:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ACEg0n017734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:14:42 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 04:14:34 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
Date:   Tue, 10 Jan 2023 17:43:15 +0530
Message-ID: <20230110121316.24892-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110121316.24892-1-quic_devipriy@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8ok7RyJg23HrdmKnsbRArBj5iT5rty9f
X-Proofpoint-GUID: 8ok7RyJg23HrdmKnsbRArBj5iT5rty9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100074
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>

Add initial device tree support for Qualcomm IPQ9574 SoC
and AL02 board

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Co-developed-by: devi priya <quic_devipriy@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
Signed-off-by: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile            |   1 +
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  69 ++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 318 +++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 3e79496292e7..872c62028a0b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-al02-c7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
new file mode 100644
index 000000000000..ae3c32f3e16a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IPQ9574 AL02-C7 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
+	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
+	interrupt-parent = <&intc>;
+
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&blsp1_uart2 {
+	pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tlmm {
+	emmc_pins: emmc-state {
+		emmc-clk-pins {
+			pins = "gpio5";
+			function = "sdc_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+		emmc-cmd-pins {
+			pins = "gpio4";
+			function = "sdc_cmd";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+		emmc-data-pins {
+			pins = "gpio0", "gpio1", "gpio2",
+			     "gpio3", "gpio6", "gpio7",
+			     "gpio8", "gpio9";
+			function = "sdc_data";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+		emmc-rclk-pins {
+			pins = "gpio10";
+			function = "sdc_rclk";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+	};
+
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
new file mode 100644
index 000000000000..188d18688a77
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IPQ9574 SoC device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-ipq9574.h>
+#include <dt-bindings/reset/qcom,gcc-ipq9574.h>
+
+/ {
+	interrupt-parent = <&intc>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clocks {
+		bias_pll_ubi_nc_clk: bias_pll_ubi_nc_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <353000000>;
+			#clock-cells = <0>;
+		};
+
+		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
+		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
+		pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
+		pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <250000000>;
+			#clock-cells = <0>;
+		};
+
+		usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+
+		xo_board_clk: xo-board-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x2>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x3>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x40000000 0x0 0x0>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a73-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		tz_region: memory@4a600000 {
+			reg = <0x0 0x4a600000 0x0 0x400000>;
+			no-map;
+		};
+	};
+
+	soc: soc@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qcom,ipq9574-tlmm";
+			reg = <0x01000000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 65>;
+			gpio-reserved-ranges = <59 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			uart2_pins: uart2-state {
+				pins = "gpio34", "gpio35";
+				function = "blsp2_uart";
+				drive-strength = <8>;
+				bias-disable;
+			};
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qcom,gcc-ipq9574";
+			reg = <0x1800000 0x80000>;
+			clocks = <&xo_board_clk>,
+				<&sleep_clk>,
+				<&bias_pll_ubi_nc_clk>,
+				<&pcie30_phy0_pipe_clk>,
+				<&pcie30_phy1_pipe_clk>,
+				<&pcie30_phy2_pipe_clk>,
+				<&pcie30_phy3_pipe_clk>,
+				<&usb3phy_0_cc_pipe_clk>;
+			clock-names = "xo",
+				"sleep_clk",
+				"bias_pll_ubi_nc_clk",
+				"pcie30_phy0_pipe_clk",
+				"pcie30_phy1_pipe_clk",
+				"pcie30_phy2_pipe_clk",
+				"pcie30_phy3_pipe_clk",
+				"usb3phy_0_cc_pipe_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		sdhc_1: sdhci@7804000 {
+			compatible = "qcom,sdhci-msm-v5";
+			reg = <0x7804000 0x1000>, <0x7805000 0x1000>;
+			reg-names = "hc_mem", "cmdq_mem";
+
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&xo_board_clk>,
+			       <&gcc GCC_SDCC1_AHB_CLK>,
+			       <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "xo", "iface", "core";
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			mmc-hs400-1_8v;
+			mmc-hs400-enhanced-strobe;
+			max-frequency = <384000000>;
+			bus-width = <8>;
+			non-removable;
+			status = "disabled";
+		};
+
+		blsp1_uart2: serial@78b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b1000 0x200>;
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		intc: interrupt-controller@b000000 {
+			compatible = "qcom,msm-qgic2";
+			reg = <0x0b000000 0x1000>,  /* GICD */
+			      <0x0b002000 0x1000>,  /* GICC */
+			      <0x0b001000 0x1000>,  /* GICH */
+			      <0x0b004000 0x1000>;  /* GICV */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			ranges = <0 0x0b00c000 0x3000>;
+
+			v2m0: v2m@0 {
+				compatible = "arm,gic-v2m-frame";
+				reg = <0x0 0xffd>;
+				msi-controller;
+			};
+
+			v2m1: v2m@1 {
+				compatible = "arm,gic-v2m-frame";
+				reg = <0x1000 0xffd>;
+				msi-controller;
+			};
+
+			v2m2: v2m@2 {
+				compatible = "arm,gic-v2m-frame";
+				reg = <0x2000 0xffd>;
+				msi-controller;
+			};
+		};
+
+		timer@b120000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xb120000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clock-frequency = <24000000>;
+
+			frame@b120000 {
+				reg = <0xb121000 0x1000>,
+				      <0xb122000 0x1000>;
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			frame@b123000 {
+				reg = <0xb123000 0x1000>;
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@b124000 {
+				reg = <0xb124000 0x1000>;
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@b125000 {
+				reg = <0xb125000 0x1000>;
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@b126000 {
+				reg = <0xb126000 0x1000>;
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@b127000 {
+				reg = <0xb127000 0x1000>;
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@b128000 {
+				reg = <0xb128000 0x1000>;
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <24000000>;
+	};
+};
-- 
2.17.1

