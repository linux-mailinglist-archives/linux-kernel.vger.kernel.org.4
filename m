Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081CB72F85C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbjFNIvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243790AbjFNIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:51:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A871FD0;
        Wed, 14 Jun 2023 01:51:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E4mqPr008448;
        Wed, 14 Jun 2023 08:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=10lR0iDjQOvoiKBVYPwgoiPdV3NYL/so1Q4ESNGAQl4=;
 b=pgY64F7mMh2Vlzk7H4tTfqhi1kmJAKeLLGOyPkDdg+PT6DBNSZOyHjPZnJnPojifZ4RU
 l2vtUFKSotqLWR1VnyLNmgq7+gWoxvWT/9kDmUNeU8N2TN21w/xkr2x9ROvbwTcgy+n3
 MzZwZ8y8jlZ9TO5F6eXEFXeutjgx0ja8t0QhsgqlBC8gyDlDnOhkjQltVlCDsUwwW+3t
 nubCRe5X5SJsxMIldPe0IywwoN2baFZX2uynmts0erQUgBqqhiUz0BcoiFAMI0frhN0l
 lW3h3JlbOMn2mbNTW8y+pTGEhZCB2yTnrlpsHUgcdAVDQ5R3Jr2EiKFHhe7KeYo675n0 tg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6f7a3cg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:51:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E8p9Ka001256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:51:09 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 01:51:04 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq9574: Add common RDP dtsi file
Date:   Wed, 14 Jun 2023 14:20:39 +0530
Message-ID: <20230614085040.22071-2-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230614085040.22071-1-quic_anusha@quicinc.com>
References: <20230614085040.22071-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gZuSkaSsUmlX8uqsjl6QW2AVBJYWBRi3
X-Proofpoint-ORIG-GUID: gZuSkaSsUmlX8uqsjl6QW2AVBJYWBRi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_05,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dtsi file to include interfaces that are common
across RDPs.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 121 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts   | 107 +---------------
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  88 +------------
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts   |  65 +---------
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts   |  65 +---------
 5 files changed, 125 insertions(+), 321 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
new file mode 100644
index 000000000000..999902bc70bd
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP board common device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&blsp1_spi0 {
+	pinctrl-0 = <&spi_0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "micron,n25q128a11", "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&blsp1_uart2 {
+	pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-mp5496-regulators";
+
+		ipq9574_s1: s1 {
+		/*
+		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
+		 * During regulator registration, kernel not knowing the initial voltage,
+		 * considers it as zero and brings up the regulators with minimum supported voltage.
+		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
+		 * the regulators are brought up with 725mV which is sufficient for all the
+		 * corner parts to operate at 800MHz
+		 */
+			regulator-min-microvolt = <725000>;
+			regulator-max-microvolt = <1075000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc_default_state>;
+	pinctrl-names = "default";
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	max-frequency = <384000000>;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&tlmm {
+	sdc_default_state: sdc-default-state {
+		clk-pins {
+			pins = "gpio5";
+			function = "sdc_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cmd-pins {
+			pins = "gpio4";
+			function = "sdc_cmd";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		data-pins {
+			pins = "gpio0", "gpio1", "gpio2",
+			       "gpio3", "gpio6", "gpio7",
+			       "gpio8", "gpio9";
+			function = "sdc_data";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		rclk-pins {
+			pins = "gpio10";
+			function = "sdc_rclk";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+	};
+
+	spi_0_pins: spi-0-state {
+		pins = "gpio11", "gpio12", "gpio13", "gpio14";
+		function = "blsp0_spi";
+		drive-strength = <8>;
+		bias-disable;
+	};
+};
+
+&xo_board_clk {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
index 2b093e02637b..924e4c50101a 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
@@ -8,117 +8,12 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C2";
 	compatible = "qcom,ipq9574-ap-al02-c2", "qcom,ipq9574";
 
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_spi0 {
-	pinctrl-0 = <&spi_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash@0 {
-		compatible = "micron,n25q128a11", "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
 };
 
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
-};
-
-&sdhc_1 {
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	max-frequency = <384000000>;
-	bus-width = <8>;
-	status = "okay";
-};
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&tlmm {
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio5";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio4";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio0", "gpio1", "gpio2",
-			       "gpio3", "gpio6", "gpio7",
-			       "gpio8", "gpio9";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		rclk-pins {
-			pins = "gpio10";
-			function = "sdc_rclk";
-			drive-strength = <8>;
-			bias-pull-down;
-		};
-	};
-
-	spi_0_pins: spi-0-state {
-		pins = "gpio11", "gpio12", "gpio13", "gpio14";
-		function = "blsp0_spi";
-		drive-strength = <8>;
-		bias-disable;
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 2b3ed8d351f7..ae2578ba6980 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -8,96 +8,10 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
 	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
 
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
-};
-
-&sdhc_1 {
-	pinctrl-0 = <&sdc_default_state>;
-	pinctrl-names = "default";
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	max-frequency = <384000000>;
-	bus-width = <8>;
-	status = "okay";
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&tlmm {
-	sdc_default_state: sdc-default-state {
-		clk-pins {
-			pins = "gpio5";
-			function = "sdc_clk";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "gpio4";
-			function = "sdc_cmd";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "gpio0", "gpio1", "gpio2",
-			       "gpio3", "gpio6", "gpio7",
-			       "gpio8", "gpio9";
-			function = "sdc_data";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
-
-		rclk-pins {
-			pins = "gpio10";
-			function = "sdc_rclk";
-			drive-strength = <8>;
-			bias-pull-down;
-		};
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
index c8fa54e1a62c..d36d1078763e 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
@@ -8,73 +8,10 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C6";
 	compatible = "qcom,ipq9574-ap-al02-c6", "qcom,ipq9574";
 
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_spi0 {
-	pinctrl-0 = <&spi_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash@0 {
-		compatible = "micron,n25q128a11", "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&tlmm {
-	spi_0_pins: spi-0-state {
-		pins = "gpio11", "gpio12", "gpio13", "gpio14";
-		function = "blsp0_spi";
-		drive-strength = <8>;
-		bias-disable;
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
index f01de6628c3b..c30c9fbedf26 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
@@ -8,73 +8,10 @@
 
 /dts-v1/;
 
-#include "ipq9574.dtsi"
+#include "ipq9574-rdp-common.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
 	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
 
-	aliases {
-		serial0 = &blsp1_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&blsp1_spi0 {
-	pinctrl-0 = <&spi_0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	flash@0 {
-		compatible = "micron,n25q128a11", "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&blsp1_uart2 {
-	pinctrl-0 = <&uart2_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-mp5496-regulators";
-
-		ipq9574_s1: s1 {
-		/*
-		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
-		 * During regulator registration, kernel not knowing the initial voltage,
-		 * considers it as zero and brings up the regulators with minimum supported voltage.
-		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
-		 * the regulators are brought up with 725mV which is sufficient for all the
-		 * corner parts to operate at 800MHz
-		 */
-			regulator-min-microvolt = <725000>;
-			regulator-max-microvolt = <1075000>;
-		};
-	};
-};
-
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
-&tlmm {
-	spi_0_pins: spi-0-state {
-		pins = "gpio11", "gpio12", "gpio13", "gpio14";
-		function = "blsp0_spi";
-		drive-strength = <8>;
-		bias-disable;
-	};
-};
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
 };
-- 
2.17.1

