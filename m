Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C573731B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbjFOO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345046AbjFOO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:28:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A09326AA;
        Thu, 15 Jun 2023 07:28:34 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FDuoIP011080;
        Thu, 15 Jun 2023 14:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jb+Usk5es7WjHbWgWhEDSuZLV/sVQvdB8ni8nhZrTcc=;
 b=HeDg601dv/vZ8DP6//YOdCCTTw5hONa4w4KN+hGRzDczIFoytwqcBKj/iZ6PYTOVfxst
 9JLqslkhkPocLH/c/Xw/dEVekoNiGo9NNF+rpo/j5oT0SRH9GRBIhpnyUR/n2NSp6w7T
 CnN5UdJGmffxwH7RFHdEtiWZAtzntWBZ7618SkhbNP6TAP6P2z3FPdGFaHoIVO9zgpR0
 CT6iIX2c2UKm5ywJUR+lUl9gVk+jmloYJQxw6WVvl5qKv1rQ0UBruqEnLrBn/jKt3ew5
 XLy3TEFGZSmasIMvJx7sk/oFripMRWS10nu4fa7V+cZWoAO3y8m0ocVevmKjDWqNL60O Hg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7p4q9sft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 14:28:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35FESTlm027460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 14:28:29 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 15 Jun 2023 07:28:25 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons
Date:   Thu, 15 Jun 2023 19:58:02 +0530
Message-ID: <20230615142803.26975-2-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615142803.26975-1-quic_sridsn@quicinc.com>
References: <20230615142803.26975-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NQSNQfE1l8TWGxGMnqUfKOc05IgNKqHM
X-Proofpoint-ORIG-GUID: NQSNQfE1l8TWGxGMnqUfKOc05IgNKqHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_10,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=894 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wlan-2g LED on GPIO 36 and wps buttons on GPIO 35.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
Changes in V3:
	- added leds and gpio-keys nodes in rdp-common.dtsi

Changes in V2:
	- Used the hypen in node name instead of underscore
	- Dropped the status property

 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
index 97dc0e5c15f0..a8671a4ac2e4 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
@@ -19,6 +19,31 @@
 	chosen {
 		stdout-path = "serial0";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		button-wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
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
 
 &blsp1_i2c1 {
@@ -52,6 +77,20 @@
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
-- 
2.17.1

