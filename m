Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8871775A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjEaG5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjEaG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:57:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB481A1;
        Tue, 30 May 2023 23:57:24 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V6RmCb016831;
        Wed, 31 May 2023 06:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=BPjb0LI9fh4FV0dxy/9TjkgNGSW8xbWittOmItYPovc=;
 b=Wx/HFIz+un6WRSSRxzH/QGWYWXe7Qe9DrK2RbmeyLnRSrEXia2eDawgum0EnIv2N82aR
 VRE6IpsFl3DIs/7qSAScwZK8/cj8eLYsPqNVx5oJgcVdnhZarKdT3Z9NZ0/jXv752CZW
 0oS4IFakKnnN/GKLPLw2xj8MhZRaT6watcqXvE+UQ9yXiNxTdUbgQJj+hs/AMhXHMGQE
 a8aV80RYScNWzWX9ysZevWfZF7gNUmcOPPmnEC0rVUxR1QwDQduEMULqwAitLa/KcimL
 lnZfxbeqZwszLgMKvim9//k6OebgxGq7h4zDmcnvMDYbLYASyNotdcHKcCfLO6vBgw4L eQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwp69h7qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:57:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V6vKE3031151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:57:20 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 23:57:16 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq9574: enable GPIO based LEDs
Date:   Wed, 31 May 2023 12:26:19 +0530
Message-ID: <20230531065619.9181-3-quic_sridsn@quicinc.com>
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
X-Proofpoint-ORIG-GUID: c5HUXbJ-YgbcJrN3cAERqswQ2ml0gPnr
X-Proofpoint-GUID: c5HUXbJ-YgbcJrN3cAERqswQ2ml0gPnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_03,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=836 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wlan-2g LED on GPIO 64.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts | 20 ++++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
index 2b093e02637b..77b450cbdea6 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -21,6 +22,18 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		led-0 {
+			gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
 };
 
 &blsp1_spi0 {
@@ -79,6 +92,13 @@
 };
 
 &tlmm {
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio5";
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 2b3ed8d351f7..b47971b54ccc 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -21,6 +22,18 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		led-0 {
+			gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
 };
 
 &blsp1_uart2 {
@@ -65,6 +78,13 @@
 };
 
 &tlmm {
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio5";
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
index c8fa54e1a62c..50be898cef92 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -21,6 +22,18 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		led-0 {
+			gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
 };
 
 &blsp1_spi0 {
@@ -67,6 +80,13 @@
 };
 
 &tlmm {
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
 	spi_0_pins: spi-0-state {
 		pins = "gpio11", "gpio12", "gpio13", "gpio14";
 		function = "blsp0_spi";
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
index f01de6628c3b..f45b5d5353f8 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -21,6 +22,18 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		led-0 {
+			gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
 };
 
 &blsp1_spi0 {
@@ -67,6 +80,13 @@
 };
 
 &tlmm {
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
 	spi_0_pins: spi-0-state {
 		pins = "gpio11", "gpio12", "gpio13", "gpio14";
 		function = "blsp0_spi";
-- 
2.17.1

