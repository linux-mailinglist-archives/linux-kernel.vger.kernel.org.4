Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F45680C70
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjA3Ltk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjA3Lt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:49:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D89936091;
        Mon, 30 Jan 2023 03:48:57 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBSJOO004058;
        Mon, 30 Jan 2023 11:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5OvxXUZipzWCBpFvVa5CogcV4T+VJf33YDyCncG4jXs=;
 b=jCjP6gJGCFt00VMrWPoiRLL4NO+zWHkQVbYtMTOHdxwvZHyotsI0BzI2COPP5ST3COoq
 8BfK7N/RiipQ8m7llj0eMQPWZh9ZHHMzS43fT4F0I00ZfA23u+oVR0quETYSslUGFmDc
 XZmaNWA6xHoiS/O8gee/ItXoELRzxiFNZ+/STpxTaqecfAmUU+O/DitGNAF7WKaCv0rl
 zi4VCyKVJV8OYf8zDpQqfCpjcal8WpVIruG9D3Ez57YogPXsF57wLZxU1ns4v0a06P0Y
 1hZ6HAuXPhGVq6VAr6jiZVsKtC2y4jyQXmvH7Ex9jFPtBi/okb2jbklyNtpT+igf6Lqt yA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvvu3c1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:48:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UBmK9Y014622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:48:20 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 03:48:13 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 8/9] arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board support
Date:   Mon, 30 Jan 2023 17:17:01 +0530
Message-ID: <20230130114702.20606-9-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130114702.20606-1-quic_kathirav@quicinc.com>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JqOSio1xCjcT2I4E_7m3CEvjYOdqNYHY
X-Proofpoint-ORIG-GUID: JqOSio1xCjcT2I4E_7m3CEvjYOdqNYHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

Add initial device tree support for the Qualcomm IPQ5332 SoC and
MI01.2 board.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Changed the license to BSD3 in the file ipq5332-mi01.2.dts
	- Updated the model name, not to include the foundry ID
	- Used the decimal notation instead of hex for 'cache-level'
	  property
	- Dropped the blank line
	- Updated the node name for the TZ reserved region
	- Moved the 'compatible' property as first one in the node,
	  wherever applicable
	- Used the decimal notation for *-cells property insrtead of
	  hex
	- Reorganised the properties of memory mapped timer node as below
		- reg
		- interrupts
		- frame-number
	- Fixed the indentation in timer node

 arch/arm64/boot/dts/qcom/Makefile           |   1 +
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts |  71 +++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 272 ++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b0423ca3e79f..28d0587b8991 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
new file mode 100644
index 000000000000..e86ae14e5613
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * IPQ5332 AP-MI01.2 board device tree source
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq5332.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
+	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
+
+	aliases {
+		serial0 = &blsp1_uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&blsp1_uart0 {
+	pinctrl-0 = <&serial_0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sdhc {
+	pinctrl-0 = <&sdc_default_state>;
+	pinctrl-names = "default";
+	non-removable;
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&xo_board {
+	clock-frequency = <24000000>;
+};
+
+/* PINCTRL */
+
+&tlmm {
+	sdc_default_state: sdc-default-state {
+		clk-pins {
+			pins = "gpio13";
+			function = "sdc_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "gpio12";
+			function = "sdc_cmd";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "gpio8", "gpio9", "gpio10", "gpio11";
+			function = "sdc_data";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
new file mode 100644
index 000000000000..7f0ba2ec339c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * IPQ5332 device tree source
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&intc>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clocks {
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+		xo_board: xo-board-clk {
+			compatible = "fixed-clock";
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
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
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
+	firmware {
+		scm {
+			compatible = "qcom,scm-ipq5332", "qcom,scm";
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
+		compatible = "arm,cortex-a53-pmu";
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
+		tz_mem: tz@4a600000 {
+			no-map;
+			reg = <0x0 0x4a600000 0x0 0x200000>;
+		};
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qcom,ipq5332-tlmm";
+			reg = <0x01000000 0x300000>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 53>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			serial_0_pins: serial0-state {
+				pins = "gpio18", "gpio19";
+				function = "blsp0_uart0";
+				drive-strength = <8>;
+				bias-pull-up;
+			};
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qcom,ipq5332-gcc";
+			reg = <0x01800000 0x80000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clock-names = "xo",
+				      "sleep_clk",
+				      "pcie_2lane_phy_pipe_clk",
+				      "pcie_2lane_phy_pipe_clk_x1",
+				      "usb_pcie_wrapper_pipe_clk";
+			clocks = <&xo_board>,
+				 <&sleep_clk>,
+				 <0>,
+				 <0>,
+				 <0>;
+		};
+
+		sdhc: mmc@7804000 {
+			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
+
+			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			max-frequency = <192000000>;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		blsp1_uart0: serial@78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078af000 0x200>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		intc: interrupt-controller@b000000 {
+			compatible = "qcom,msm-qgic2";
+			reg = <0x0b000000 0x1000>,	/* GICD */
+			      <0x0b002000 0x1000>,	/* GICC */
+			      <0x0b001000 0x1000>,	/* GICH */
+			      <0x0b004000 0x1000>;	/* GICV */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0b00c000 0x3000>;
+
+			v2m0: v2m@0 {
+				compatible = "arm,gic-v2m-frame";
+				reg = <0x00000000 0xffd>;
+				msi-controller;
+			};
+
+			v2m1: v2m@1 {
+				compatible = "arm,gic-v2m-frame";
+				reg = <0x00001000 0xffd>;
+				msi-controller;
+			};
+
+			v2m2: v2m@2 {
+				compatible = "arm,gic-v2m-frame";
+				reg = <0x00002000 0xffd>;
+				msi-controller;
+			};
+		};
+
+		timer@b120000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0b120000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			frame@b120000 {
+				reg = <0x0b121000 0x1000>,
+				      <0x0b122000 0x1000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <0>;
+			};
+
+			frame@b123000 {
+				reg = <0x0b123000 0x1000>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <1>;
+				status = "disabled";
+			};
+
+			frame@b124000 {
+				reg = <0x0b124000 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <2>;
+				status = "disabled";
+			};
+
+			frame@b125000 {
+				reg = <0x0b125000 0x1000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <3>;
+				status = "disabled";
+			};
+
+			frame@b126000 {
+				reg = <0x0b126000 0x1000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <4>;
+				status = "disabled";
+			};
+
+			frame@b127000 {
+				reg = <0x0b127000 0x1000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <5>;
+				status = "disabled";
+			};
+
+			frame@b128000 {
+				reg = <0x0b128000 0x1000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <6>;
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
+	};
+};
-- 
2.17.1

