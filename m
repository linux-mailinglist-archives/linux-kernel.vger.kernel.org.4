Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF514717757
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjEaG5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjEaG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:57:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5E188;
        Tue, 30 May 2023 23:57:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V6Q9Ie028293;
        Wed, 31 May 2023 06:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hTLxHFgwLV40fSfDFgmFOpCxt0qkk+q8+S1xv1pmK4U=;
 b=JEno0EZJCuyU/h598BufLQLTzBJW6Eizj4pdPr+UY7embz982+mmV9NOBEdg93HGVobn
 0yAUGax81LHWZMIF0MaHBxPW7zgR6aM8dcyXjdeJQseHXA2cQSImU4KEtAgwKgmeDfD3
 vynD2HpC2Xmyz/nQ3T7EQ8S/GgUlaXr8UMMw1sHcnmAFIrPsjpDEEmRHtXGgfyOALakj
 OLfe8kB4zbJHeNXY/3BI/dB2pclJLkBJCXSDSmnC/3mlpiSV4nF5hWH0bG8hxrAD0FCp
 fG27/K4NZyPfDfYTH4r1HnzVIuHGSdjDlNn9qswXddkI/QkXmg9cxSFCCuiAHRocC1R4 gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwvt1rhcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:57:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V6vGrl017729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:57:16 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 23:57:12 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons
Date:   Wed, 31 May 2023 12:26:18 +0530
Message-ID: <20230531065619.9181-2-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230531065619.9181-1-quic_sridsn@quicinc.com>
References: <20230531065619.9181-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HCamhgMfmabY6QXbEPI0AIk72elf4c7a
X-Proofpoint-GUID: HCamhgMfmabY6QXbEPI0AIk72elf4c7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_03,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=965 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wlan-2g LED on GPIO 36 and wps buttons on GPIO 35.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 43 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 43 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 43 +++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
index 3af1d5556950..ba733b6cab06 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "ipq5332.dtsi"
 
 / {
@@ -20,6 +22,33 @@
 	chosen {
 		stdout-path = "serial0";
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		button-wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			debounce-interval = <60>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		led-0 {
+			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
 };
 
 &blsp1_uart0 {
@@ -57,6 +86,20 @@
 /* PINCTRL */
 
 &tlmm {
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio35";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio36";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
+
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
 		function = "blsp1_i2c0";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
index bcf3b31c20e3..5322b9ee3359 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "ipq5332.dtsi"
 
 / {
@@ -20,6 +22,33 @@
 	chosen {
 		stdout-path = "serial0";
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		button-wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			debounce-interval = <60>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		led-0 {
+			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
 };
 
 &blsp1_uart0 {
@@ -71,6 +100,20 @@
 /* PINCTRL */
 
 &tlmm {
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio35";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio36";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
+
 	i2c_1_pins: i2c-1-state {
 		pins = "gpio29", "gpio30";
 		function = "blsp1_i2c0";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
index 3b6a5cb8bf07..15c54dfcaf3f 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "ipq5332.dtsi"
 
 / {
@@ -20,6 +22,33 @@
 	chosen {
 		stdout-path = "serial0";
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		button-wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			debounce-interval = <60>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		led-0 {
+			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
 };
 
 &blsp1_uart0 {
@@ -64,6 +93,20 @@
 /* PINCTRL */
 
 &tlmm {
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio35";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio36";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio13";
-- 
2.17.1

