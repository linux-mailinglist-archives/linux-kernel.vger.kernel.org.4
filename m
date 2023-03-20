Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67A6C0DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCTJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjCTJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:45:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECF220542;
        Mon, 20 Mar 2023 02:45:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8Nl5x029864;
        Mon, 20 Mar 2023 09:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=52Aa9QVqTX4Dd1Soud4+IASjl18oxx5XAbR7JIMdT8A=;
 b=aCA3VbtoTMzqEy0OvabJcG1VZzIi6CslNqWJE9HBEgJlRjJP1gDZe6OgP5YcK0Ub5jc0
 Z0CLkY7dFbUZk9MeGa6nZPlwWA3Llj6KMpuR1prmzS+N1Fng7djQ3hV67Tym34y+vLRM
 QQgQFAF3H9vRm8YzgqXFWztsEGXsgG/z3B8Zbmeivdcjv7TQ0sLjoShsbPMvPAl6KKyZ
 FCvwW/vNJElWo7NHbNNytS8icUzqLWnzqueHON0gwloeGZPWIHkLti6oXKUWOl3fJNbj
 GbAfXaXaUzC7LtC341ZB6lev/9P844T2TFq2ljneUHyrTsG/HjPYKJl79whC4ny8VBbu eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pd491cgxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 09:45:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32K9jGYn003672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 09:45:16 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 02:45:12 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq5332: add few device nodes
Date:   Mon, 20 Mar 2023 15:14:50 +0530
Message-ID: <20230320094450.8015-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320094450.8015-1-quic_kathirav@quicinc.com>
References: <20230320094450.8015-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dfyCSEr7tIdJ9cl23yN21XO3p8S1pLFi
X-Proofpoint-GUID: dfyCSEr7tIdJ9cl23yN21XO3p8S1pLFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes for QUP peripheral, PRNG and WDOG. While at it, enable the
I2C device for MI01.2 board.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 14 +++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 67 +++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
index 702013b867d7..3af1d5556950 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
@@ -28,6 +28,13 @@
 	status = "okay";
 };
 
+&blsp1_i2c1 {
+	clock-frequency  = <400000>;
+	pinctrl-0 = <&i2c_1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &sdhc {
 	bus-width = <4>;
 	max-frequency = <192000000>;
@@ -50,6 +57,13 @@
 /* PINCTRL */
 
 &tlmm {
+	i2c_1_pins: i2c-1-state {
+		pins = "gpio29", "gpio30";
+		function = "blsp1_i2c0";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio13";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 04ef80f267bf..fcc2b901bb65 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -134,6 +134,13 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		rng: rng@e3000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x000e3000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5332-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -191,6 +198,16 @@
 			status = "disabled";
 		};
 
+		blsp_dma: dma-controller@7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x1d000>;
+			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
 		blsp1_uart0: serial@78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078af000 0x200>;
@@ -201,6 +218,48 @@
 			status = "disabled";
 		};
 
+		blsp1_spi0: spi@78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x078b5000 0x600>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		blsp1_i2c1: i2c@78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x078b6000 0x600>;
+			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		blsp1_spi2: spi@78b7000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>,	/* GICD */
@@ -233,6 +292,14 @@
 			};
 		};
 
+		watchdog: watchdog@b017000 {
+			compatible = "qcom,apss-wdt-ipq5332", "qcom,kpss-wdt";
+			reg = <0x0b017000 0x1000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sleep_clk>;
+			timeout-sec = <30>;
+		};
+
 		apcs_glb: mailbox@b111000 {
 			compatible = "qcom,ipq5332-apcs-apps-global",
 				     "qcom,ipq6018-apcs-apps-global";
-- 
2.17.1

