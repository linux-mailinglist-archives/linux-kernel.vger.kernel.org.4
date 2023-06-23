Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785673B339
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFWJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:05:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B153C2;
        Fri, 23 Jun 2023 02:05:57 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N8GiHt032613;
        Fri, 23 Jun 2023 09:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Fm5WFiqSZHdC/UrdhohLSKLZlG54PTroJ44BuZr+u6U=;
 b=LX6mfpHZXrs3Q627kt8an3VIGa8wUd+caUXHxoWqew4/C9o+MpxGFWDHzNAcd9e1FTLm
 S4GTth/GAgBeEia8IRK5UaEAnohzCjvFmA2qSwm+q9yZ/M+GPSzZom/SSKZIWdYioLjb
 L9WR9FEt1wg0mhN9Pc1+ElUa8HBA2lwEg6YVN6cQdsKimCxNHIg7h8zeNCIQYFh+2au/
 sQXVqSaOfHGO0nqOXgA6tkkx/I1P3MsH1Fvc51ixdl7vCesWpYxdmChbmxXGDBwnjyec
 N+9JYD4ozxM9Q55/kVVhaR64MSDsRld1ZtwtMg1LI6uLRRz7eHaevMUyhdiLQ4XklXim PA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc6b2c9vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:00:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N90dVW006713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:00:39 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 02:00:34 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>,
        Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH V2] arm64: dts: qcom: ipq5332: Add common RDP dtsi file
Date:   Fri, 23 Jun 2023 14:30:01 +0530
Message-ID: <20230623090001.27778-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vsGIW8WS23mkWAq_PN0_bECZ3xpC8tyy
X-Proofpoint-GUID: vsGIW8WS23mkWAq_PN0_bECZ3xpC8tyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_03,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Changes in V2:
	- removed blsp1_i2c1 and sdhc nodes from common.dtsi file
	  and added in board dts file since it is board specific
 
 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 36 ++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   | 26 +---------
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts   | 26 +---------
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts   | 24 +---------
 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts   | 47 +------------------
 5 files changed, 40 insertions(+), 119 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
new file mode 100644
index 000000000000..f13dea7d67fe
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
@@ -0,0 +1,36 @@
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
+&blsp1_uart0 {
+	pinctrl-0 = <&serial_0_pins>;
+	pinctrl-names = "default";
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
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index 3af1d5556950..e89e2e948603 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -7,25 +7,11 @@
 
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
 };
 
 &blsp1_i2c1 {
@@ -46,16 +32,6 @@
 	status = "okay";
 };
 
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
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
index bcf3b31c20e3..efd480a7afdf 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
@@ -7,25 +7,11 @@
 
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
 };
 
 &blsp1_i2c1 {
@@ -60,16 +46,6 @@
 	status = "okay";
 };
 
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
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
index 3b6a5cb8bf07..f96b0c8c908b 100644
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
@@ -53,14 +39,6 @@
 	status = "okay";
 };
 
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
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
index 53c68d8c5e5d..eb1fa33d6fe4 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
@@ -7,41 +7,11 @@
 
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
 };
 
 &blsp1_i2c1 {
@@ -62,24 +32,9 @@
 	status = "okay";
 };
 
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
-	gpio_keys_default_state: gpio-keys-default-state {
-		pins = "gpio35";
-		function = "gpio";
-		drive-strength = <8>;
-		bias-pull-up;
-	};
-
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
 		function = "blsp1_i2c0";
-- 
2.17.1

