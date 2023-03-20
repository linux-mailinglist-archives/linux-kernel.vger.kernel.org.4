Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C266C0FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCTKvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCTKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:49:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D728E50;
        Mon, 20 Mar 2023 03:47:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8PGQe003066;
        Mon, 20 Mar 2023 10:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7ohpvS8wat8lT/Kko0MXO2b+oMzqJGE+J11bxdCgLzE=;
 b=XbR94dlZgHb3qcW3/1tV4bIC6x7zKfdxUA8/CsVtWTwTMrarEdcShE5Y9pHsQ8YE4Gex
 VenfkVlhJ8sF2Kv3VkaSwm4VDNb5JG7MpKV3ubMZsJNFZjEqUEtVF01MHvcbNf4KNCLx
 rGFEdk1S2SYc4LJPpPx7vSrtzjz/z/X28YK/kJ7Z0xPNuwVPYghuhGPtVkKevlwAfC2n
 yYkl+TldK30ar3QZ53jwQzZ1j0yGNaabkPHPHsO7n/5LabGMJQClYcc6QBuTDnSP8Pwu
 130JrwMdY4fy+0BEhyt/kUT8to9YzYdDaPKmqa3g6sNQxLGR2YpgEhSstI3C7jc6JsVr pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pd4mtckkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 10:45:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KAjv0t012586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 10:45:57 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 03:45:53 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 2/2] arm64: dts: qcom: ipq5332: add few device nodes
Date:   Mon, 20 Mar 2023 16:15:30 +0530
Message-ID: <20230320104530.30411-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320104530.30411-1-quic_kathirav@quicinc.com>
References: <20230320104530.30411-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZVx835coboO_jviTrZUKgtdQu1iyrJPB
X-Proofpoint-ORIG-GUID: ZVx835coboO_jviTrZUKgtdQu1iyrJPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes for QUP peripheral, PRNG and WDOG. While at it, enable the
I2C device for MI01.2 board.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Moved the 'reg' property after compatible

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
index 04ef80f267bf..12e0e179e139 100644
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
+			reg = <0x078b5000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <0x078b6000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <0x078b7000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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

