Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6407329E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjFPIdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbjFPIde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:33:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C52D71;
        Fri, 16 Jun 2023 01:33:33 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G4G7He032571;
        Fri, 16 Jun 2023 08:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=s/lYTq+hJ8wNXg+fwaA8N4RWE3CAcIKR3WOgYP98Y+4=;
 b=Ps4euilWU/gN/a4v1uaLRusI0qp0A/f4OYJT7QXDBerdSFXsmtcechb0ApUlj5AELWC8
 rqsMjKb9FLuyC5N0PjJbDr/zKLCywKV/ZdxDlxWPJ5Eqtq/Cwh6Bsi19ijazY01oznLv
 Ds/N/LORIUBEM4gT6WyuPmuFReV/mhiVSPzVKvtdCgoFa2Qr8xuFShPpyzHQmf5EnlN/
 mFcXxRcTI9lkXxQeOZuFZvhqNNS/G43NKJ/TLhfh69J0qnrQngG8/2Gs+VcVEsi4CsgA
 Labg3MFtV0tu0GrrQhhLgZZoOxAID/r7vniuLB8AAXCq46qlDWoi4J+WPzWi1DrOcxfI Xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7u8cb7k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:33:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35G8XS40018455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:33:28 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Jun 2023 01:33:06 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH V4 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons
Date:   Fri, 16 Jun 2023 14:02:37 +0530
Message-ID: <20230616083238.20690-2-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616083238.20690-1-quic_sridsn@quicinc.com>
References: <20230616083238.20690-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4gtcoRO034_JxHk-6ebuPv_-Xhv12m__
X-Proofpoint-GUID: 4gtcoRO034_JxHk-6ebuPv_-Xhv12m__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_05,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=634 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160075
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
Changes in V4:
	- Added patch dependency. This change depends on below patch set
	  https://lore.kernel.org/linux-arm-msm/20230615090001.10970-1-quic_sridsn@quicinc.com/

Changes in V3:
	- Updated patch series title. Mentioned platform in series
	  title

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

