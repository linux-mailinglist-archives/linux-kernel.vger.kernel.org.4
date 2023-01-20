Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9F6757D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjATOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjATOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:54:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F4DD05C6;
        Fri, 20 Jan 2023 06:54:20 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDovJ3032685;
        Fri, 20 Jan 2023 14:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tmjYJ7CEbP9zzfXyf4A7L1KHQ0J/OvELX7Nq7/CYrC4=;
 b=NtqavjjaB4w0f4soWlpy97tRy9KjyTkuA4tk1dUsnZu6/Y9Uf7C+/BzGOi9t1y4WANh+
 A0qzhFzOM/WLGXrdt+i7iljD8G9cyRJRLdS/FKyeiNEHp6fZcgN/sJnsEJ7HYt90Lxq3
 sJdtvpIWJeMsIENLlj21isaskpMu395zu546G4IuydSR0APFNgDTTzYGi5xgEz+bx3hm
 VzKgqSAfd/9sS0WqaJ5OZnjuv3hJHPO9hy8qxqFbWqNkSeBvi0j4WBCYrSVkUr3Ql8pP
 /a0NO0tyPhRKs5YqtS0G3XJ87Rz4xDJRcEV1qM/4eBx5Xe6KZJATWTRQrHz7qQwmadOO CQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktm148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:17:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KEH5Yt018518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:17:05 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 06:16:58 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 1/7] arm64: dts: qcom: sc7280: Extract audio nodes from common idp dtsi file
Date:   Fri, 20 Jan 2023 19:46:35 +0530
Message-ID: <1674224201-28109-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674224201-28109-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674224201-28109-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lX612gzWAOUgJ0bxyB8WWE_p0c7OFjQ6
X-Proofpoint-GUID: lX612gzWAOUgJ0bxyB8WWE_p0c7OFjQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split common idp dtsi file into audio specific dtsi and common
idp dtsi file.

It is required to isolate idp and crd-rev3 platform device tree nodes
and convert crd-rev3 platform device tree nodes into audioreach specific
device tree nodes.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi | 135 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |   1 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 126 -----------------------
 3 files changed, 136 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
new file mode 100644
index 0000000..614fb06
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * sc7280 Audio IDP board device tree source (common between SKU1 and SKU2)
+ *
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+/{
+	/* BOARD-SPECIFIC TOP LEVEL NODES */
+	sound: sound {
+		compatible = "google,sc7280-herobrine";
+		model = "sc7280-wcd938x-max98360a-1mic";
+
+		audio-routing =
+			"IN1_HPHL", "HPHL_OUT",
+			"IN2_HPHR", "HPHR_OUT",
+			"AMIC1", "MIC BIAS1",
+			"AMIC2", "MIC BIAS2",
+			"VA DMIC0", "MIC BIAS3",
+			"VA DMIC1", "MIC BIAS3",
+			"VA DMIC2", "MIC BIAS1",
+			"VA DMIC3", "MIC BIAS1",
+			"TX SWR_ADC0", "ADC1_OUTPUT",
+			"TX SWR_ADC1", "ADC2_OUTPUT",
+			"TX SWR_ADC2", "ADC3_OUTPUT",
+			"TX SWR_DMIC0", "DMIC1_OUTPUT",
+			"TX SWR_DMIC1", "DMIC2_OUTPUT",
+			"TX SWR_DMIC2", "DMIC3_OUTPUT",
+			"TX SWR_DMIC3", "DMIC4_OUTPUT",
+			"TX SWR_DMIC4", "DMIC5_OUTPUT",
+			"TX SWR_DMIC5", "DMIC6_OUTPUT",
+			"TX SWR_DMIC6", "DMIC7_OUTPUT",
+			"TX SWR_DMIC7", "DMIC8_OUTPUT";
+
+		qcom,msm-mbhc-hphl-swh = <1>;
+		qcom,msm-mbhc-gnd-swh = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+
+		dai-link@0 {
+			link-name = "MAX98360A";
+			reg = <0>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+			};
+
+			codec {
+				sound-dai = <&max98360a>;
+			};
+		};
+
+		dai-link@1 {
+			link-name = "DisplayPort";
+			reg = <1>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_DP_RX>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp>;
+			};
+		};
+
+		dai-link@2 {
+			link-name = "WCD9385 Playback";
+			reg = <2>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
+			};
+
+			codec {
+				sound-dai = <&wcd9385 0>, <&swr0 0>, <&lpass_rx_macro 0>;
+			};
+		};
+
+		dai-link@3 {
+			link-name = "WCD9385 Capture";
+			reg = <3>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
+			};
+
+			codec {
+				sound-dai = <&wcd9385 1>, <&swr1 0>, <&lpass_tx_macro 0>;
+			};
+		};
+
+		dai-link@4 {
+			link-name = "DMIC";
+			reg = <4>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_va_macro 0>;
+			};
+		};
+	};
+};
+
+&lpass_cpu {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
+
+	dai-link@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+
+	dai-link@5 {
+		reg = <LPASS_DP_RX>;
+	};
+
+	dai-link@6 {
+		reg = <LPASS_CDC_DMA_RX0>;
+	};
+
+	dai-link@19 {
+		reg = <LPASS_CDC_DMA_TX3>;
+	};
+
+	dai-link@25 {
+		reg = <LPASS_CDC_DMA_VA_TX0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index 1185141..b024626 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-idp.dtsi"
+#include "sc7280-audio-idp.dtsi"
 #include "sc7280-idp-ec-h1.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index fa10ddd..6b41574 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -87,104 +87,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&nvme_pwren>;
 	};
-
-	sound: sound {
-		compatible = "google,sc7280-herobrine";
-		model = "sc7280-wcd938x-max98360a-1mic";
-
-		audio-routing =
-			"IN1_HPHL", "HPHL_OUT",
-			"IN2_HPHR", "HPHR_OUT",
-			"AMIC1", "MIC BIAS1",
-			"AMIC2", "MIC BIAS2",
-			"VA DMIC0", "MIC BIAS3",
-			"VA DMIC1", "MIC BIAS3",
-			"VA DMIC2", "MIC BIAS1",
-			"VA DMIC3", "MIC BIAS1",
-			"TX SWR_ADC0", "ADC1_OUTPUT",
-			"TX SWR_ADC1", "ADC2_OUTPUT",
-			"TX SWR_ADC2", "ADC3_OUTPUT",
-			"TX SWR_DMIC0", "DMIC1_OUTPUT",
-			"TX SWR_DMIC1", "DMIC2_OUTPUT",
-			"TX SWR_DMIC2", "DMIC3_OUTPUT",
-			"TX SWR_DMIC3", "DMIC4_OUTPUT",
-			"TX SWR_DMIC4", "DMIC5_OUTPUT",
-			"TX SWR_DMIC5", "DMIC6_OUTPUT",
-			"TX SWR_DMIC6", "DMIC7_OUTPUT",
-			"TX SWR_DMIC7", "DMIC8_OUTPUT";
-
-		qcom,msm-mbhc-hphl-swh = <1>;
-		qcom,msm-mbhc-gnd-swh = <1>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#sound-dai-cells = <0>;
-
-		dai-link@0 {
-			link-name = "MAX98360A";
-			reg = <0>;
-
-			cpu {
-				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
-			};
-
-			codec {
-				sound-dai = <&max98360a>;
-			};
-		};
-
-		dai-link@1 {
-			link-name = "DisplayPort";
-			reg = <1>;
-
-			cpu {
-				sound-dai = <&lpass_cpu LPASS_DP_RX>;
-			};
-
-			codec {
-				sound-dai = <&mdss_dp>;
-			};
-		};
-
-		dai-link@2 {
-			link-name = "WCD9385 Playback";
-			reg = <2>;
-
-			cpu {
-				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
-			};
-
-			codec {
-				sound-dai = <&wcd9385 0>, <&swr0 0>, <&lpass_rx_macro 0>;
-			};
-		};
-
-		dai-link@3 {
-			link-name = "WCD9385 Capture";
-			reg = <3>;
-
-			cpu {
-				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
-			};
-
-			codec {
-				sound-dai = <&wcd9385 1>, <&swr1 0>, <&lpass_tx_macro 0>;
-			};
-		};
-
-		dai-link@4 {
-			link-name = "DMIC";
-			reg = <4>;
-
-			cpu {
-				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
-			};
-
-			codec {
-				sound-dai = <&lpass_va_macro 0>;
-			};
-		};
-	};
 };
 
 &apps_rsc {
@@ -377,34 +279,6 @@
 	status = "okay";
 };
 
-&lpass_cpu {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
-
-	dai-link@1 {
-		reg = <MI2S_SECONDARY>;
-		qcom,playback-sd-lines = <0>;
-	};
-
-	dai-link@5 {
-		reg = <LPASS_DP_RX>;
-	};
-
-	dai-link@6 {
-		reg = <LPASS_CDC_DMA_RX0>;
-	};
-
-	dai-link@19 {
-		reg = <LPASS_CDC_DMA_TX3>;
-	};
-
-	dai-link@25 {
-		reg = <LPASS_CDC_DMA_VA_TX0>;
-	};
-};
-
 &lpass_rx_macro {
 	status = "okay";
 };
-- 
2.7.4

