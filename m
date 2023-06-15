Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E57312E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbjFOJAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbjFOJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:00:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57421720;
        Thu, 15 Jun 2023 02:00:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8QTMl014293;
        Thu, 15 Jun 2023 09:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FHQcSSkiGjfeEbahpUISSq7S0e+2HItdv6kYYHc/ROU=;
 b=LPKG2wXFRO64tQcJWOvOjxQqMS8PBAkMxLm4dhSgj2eN+se0UvWKmhd8UYBLekuFXC8D
 6ayr+5KIG29wlqIAvOAVP/xywJ2cC8p2JtfkVzXTQne3fwj1UhVaNREiQqmh/yqkNmg8
 L4fu/049h9dN6PxIF/aZS1youxZSN/2AoqgRG7rOZ7huwkPKH1C3D8y3ByBfE+xKOV6D
 jJJfJHR+hoki0vFf0/KS2GxKbzkm9zqJLp155OKuvxwMnlwFx+uuLR5tOXkJ6wgDQiKu
 8n95R+KgM3I1kG9VBuxRXluLOOxqtrbBC1FtK1YH4bjAYDkLGlXz9ilsY3QnteHqGsM6 Qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7cka2akm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:00:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F90VZ3030523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:00:32 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 15 Jun 2023 02:00:26 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: ipq5332: Add common RDP dtsi file
Date:   Thu, 15 Jun 2023 14:30:01 +0530
Message-ID: <20230615090001.10970-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ximtI_TEmHXdv3jowy8Gx4vS-iYdZFtT
X-Proofpoint-ORIG-GUID: ximtI_TEmHXdv3jowy8Gx4vS-iYdZFtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=962 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dtsi file to include interfaces that are common
across IPQ5332 RDPs.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 88 +++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   | 76 +-------------
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts   | 74 +-------------
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts   | 58 +----------
 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts   | 99 +------------------
 5 files changed, 92 insertions(+), 303 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
new file mode 100644
index 000000000000..97dc0e5c15f0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * IPQ5332 RDP board common device tree source
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "ipq5332.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&blsp1_i2c1 {
+	clock-frequency  = <400000>;
+	pinctrl-0 = <&i2c_1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&blsp1_uart0 {
+	pinctrl-0 = <&serial_0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sdhc {
+	bus-width = <4>;
+	max-frequency = <192000000>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-0 = <&sdc_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+/* PINCTRL */
+
+&tlmm {
+	i2c_1_pins: i2c-1-state {
+		pins = "gpio29", "gpio30";
+		function = "blsp1_i2c0";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
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
+
+&xo_board {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index 3af1d5556950..a376260abefc 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -7,83 +7,9 @@
 
 /dts-v1/;
 
-#include "ipq5332.dtsi"
+#include "ipq5332-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
 	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
-
-	aliases {
-		serial0 = &blsp1_uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0";
-	};
-};
-
-&blsp1_uart0 {
-	pinctrl-0 = <&serial_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&blsp1_i2c1 {
-	clock-frequency  = <400000>;
-	pinctrl-0 = <&i2c_1_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&sdhc {
-	bus-width = <4>;
-	max-frequency = <192000000>;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&xo_board {
-	clock-frequency = <24000000>;
-};
-
-/* PINCTRL */
-
-&tlmm {
-	i2c_1_pins: i2c-1-state {
-		pins = "gpio29", "gpio30";
-		function = "blsp1_i2c0";
-		drive-strength = <8>;
-		bias-pull-up;
-	};
-
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio13";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio12";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio8", "gpio9", "gpio10", "gpio11";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
index bcf3b31c20e3..9ca2c0440b0b 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
@@ -7,32 +7,11 @@
 
 /dts-v1/;
 
-#include "ipq5332.dtsi"
+#include "ipq5332-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.3";
 	compatible = "qcom,ipq5332-ap-mi01.3", "qcom,ipq5332";
-
-	aliases {
-		serial0 = &blsp1_uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0";
-	};
-};
-
-&blsp1_uart0 {
-	pinctrl-0 = <&serial_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&blsp1_i2c1 {
-	clock-frequency  = <400000>;
-	pinctrl-0 = <&i2c_1_pins>;
-	pinctrl-names = "default";
-	status = "okay";
 };
 
 &blsp1_spi0 {
@@ -49,58 +28,7 @@
 	};
 };
 
-&sdhc {
-	bus-width = <4>;
-	max-frequency = <192000000>;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&xo_board {
-	clock-frequency = <24000000>;
-};
-
-/* PINCTRL */
-
 &tlmm {
-	i2c_1_pins: i2c-1-state {
-		pins = "gpio29", "gpio30";
-		function = "blsp1_i2c0";
-		drive-strength = <8>;
-		bias-pull-up;
-	};
-
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio13";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio12";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio8", "gpio9", "gpio10", "gpio11";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
-
 	spi_0_data_clk_pins: spi-0-data-clk-state {
 		pins = "gpio14", "gpio15", "gpio16";
 		function = "blsp0_spi";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
index 3b6a5cb8bf07..3c8d3225db5a 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
@@ -7,25 +7,11 @@
 
 /dts-v1/;
 
-#include "ipq5332.dtsi"
+#include "ipq5332-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.6";
 	compatible = "qcom,ipq5332-ap-mi01.6", "qcom,ipq5332";
-
-	aliases {
-		serial0 = &blsp1_uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0";
-	};
-};
-
-&blsp1_uart0 {
-	pinctrl-0 = <&serial_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
 };
 
 &blsp1_spi0 {
@@ -42,51 +28,9 @@
 	};
 };
 
-&sdhc {
-	bus-width = <4>;
-	max-frequency = <192000000>;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&xo_board {
-	clock-frequency = <24000000>;
-};
-
 /* PINCTRL */
 
 &tlmm {
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio13";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio12";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio8", "gpio9", "gpio10", "gpio11";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
-
 	spi_0_data_clk_pins: spi-0-data-clk-state {
 		pins = "gpio14", "gpio15", "gpio16";
 		function = "blsp0_spi";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
index 53c68d8c5e5d..d2b2cb0a8d98 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
@@ -7,106 +7,9 @@
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include "ipq5332.dtsi"
+#include "ipq5332-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.9";
 	compatible = "qcom,ipq5332-ap-mi01.9", "qcom,ipq5332";
-
-	aliases {
-		serial0 = &blsp1_uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-0 = <&gpio_keys_default_state>;
-		pinctrl-names = "default";
-
-		button-wps {
-			label = "wps";
-			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			debounce-interval = <60>;
-		};
-	};
-};
-
-&blsp1_uart0 {
-	pinctrl-0 = <&serial_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&blsp1_i2c1 {
-	clock-frequency  = <400000>;
-	pinctrl-0 = <&i2c_1_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&sdhc {
-	bus-width = <4>;
-	max-frequency = <192000000>;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	non-removable;
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&xo_board {
-	clock-frequency = <24000000>;
-};
-
-/* PINCTRL */
-
-&tlmm {
-	gpio_keys_default_state: gpio-keys-default-state {
-		pins = "gpio35";
-		function = "gpio";
-		drive-strength = <8>;
-		bias-pull-up;
-	};
-
-	i2c_1_pins: i2c-1-state {
-		pins = "gpio29", "gpio30";
-		function = "blsp1_i2c0";
-		drive-strength = <8>;
-		bias-pull-up;
-	};
-
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio13";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio12";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio8", "gpio9", "gpio10", "gpio11";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-	};
 };
-- 
2.17.1

