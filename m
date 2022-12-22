Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD5653DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiLVJnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiLVJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:43:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED427B36;
        Thu, 22 Dec 2022 01:43:30 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM7bn7e014192;
        Thu, 22 Dec 2022 09:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8le5LN5cvcZQzBY2ueQRpwQ1Jk9DhnzR9VDCDUutW2g=;
 b=XqIIhbBbRr/TcDNVOJfITsYLgk8ek3xuBSIHvj+tkQY3/C+feTJWm0Zivolqykt4Kb3e
 ju6S//xtIYL6V4eMoWI8cvXXkpxumbyTWEH/ZnvrJm4IpwJiYmJydT7z39LnJU7QMgu2
 ViIBO9OCa6NsV63RNynKABT4514XHGxGBzfaS+uYgfUJGML755AHI2RLdgLwMcIcy7+P
 k2NoLitdK1JL6j9X/z11LCvZcDyrJe86j4NOJt3KO3MmP20/oL/tdFZ8QJspnq20/R4n
 42TYwA3RqGQ4RJNNkAdtdRKXvuaA0RwPyl2+Zo6uwa7uQttV9px3tFRv2AhQ+0eCqTEs sA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm4xksxg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BM9hQwh010242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:26 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 01:43:21 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 2/7] arm64: dts: qcom: sc7280: audioreach: Add sound node
Date:   Thu, 22 Dec 2022 15:12:45 +0530
Message-ID: <1671702170-24781-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QXt-Cs71HNzLNxwVt1JxdCtMr0BfSqB7
X-Proofpoint-ORIG-GUID: QXt-Cs71HNzLNxwVt1JxdCtMr0BfSqB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_03,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212220085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sound node for sc7280 based audioreach platforms.

Include audioreach dtsi into crd-rev3 platform specific dts file.
Also remove phandle to sound node, as audio routing is same as
audioreach specific dtsi file.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  25 +----
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 112 +++++++++++++++++++++
 2 files changed, 113 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index b024626..aea8cbd 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-idp.dtsi"
-#include "sc7280-audio-idp.dtsi"
+#include "sc7280-herobrine-audioreach-wcd9385.dtsi"
 #include "sc7280-idp-ec-h1.dtsi"
 
 / {
@@ -88,29 +88,6 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
-&sound {
-	audio-routing =
-		"IN1_HPHL", "HPHL_OUT",
-		"IN2_HPHR", "HPHR_OUT",
-		"AMIC1", "MIC BIAS1",
-		"AMIC2", "MIC BIAS2",
-		"VA DMIC0", "MIC BIAS1",
-		"VA DMIC1", "MIC BIAS1",
-		"VA DMIC2", "MIC BIAS3",
-		"VA DMIC3", "MIC BIAS3",
-		"TX SWR_ADC0", "ADC1_OUTPUT",
-		"TX SWR_ADC1", "ADC2_OUTPUT",
-		"TX SWR_ADC2", "ADC3_OUTPUT",
-		"TX SWR_DMIC0", "DMIC1_OUTPUT",
-		"TX SWR_DMIC1", "DMIC2_OUTPUT",
-		"TX SWR_DMIC2", "DMIC3_OUTPUT",
-		"TX SWR_DMIC3", "DMIC4_OUTPUT",
-		"TX SWR_DMIC4", "DMIC5_OUTPUT",
-		"TX SWR_DMIC5", "DMIC6_OUTPUT",
-		"TX SWR_DMIC6", "DMIC7_OUTPUT",
-		"TX SWR_DMIC7", "DMIC8_OUTPUT";
-};
-
 &wcd9385 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&wcd_reset_n>, <&us_euro_hs_sel>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
new file mode 100644
index 0000000..1eac94e1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * sc7280 device tree source for boards using Max98360 and wcd9385 codec
+ * along with ADSP
+ *
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/soc/qcom,gpr.h>
+#include <dt-bindings/clock/qcom,lpass-sc7280.h>
+
+/{
+	/* BOARD-SPECIFIC TOP LEVEL NODES */
+	sound: sound {
+		compatible = "google,sc7280-herobrine";
+		model = "SC7280-AUDIOREACH";
+		status = "okay";
+		adsp-mode;
+		audio-routing =
+		   "IN1_HPHL", "HPHL_OUT",
+		   "IN2_HPHR", "HPHR_OUT",
+		   "AMIC1", "MIC BIAS1",
+		   "AMIC2", "MIC BIAS2",
+		   "VA DMIC0", "MIC BIAS1",
+		   "VA DMIC1", "MIC BIAS1",
+		   "VA DMIC2", "MIC BIAS3",
+		   "VA DMIC3", "MIC BIAS3",
+		   "TX SWR_ADC0", "ADC1_OUTPUT",
+		   "TX SWR_ADC1", "ADC2_OUTPUT",
+		   "TX SWR_ADC2", "ADC3_OUTPUT",
+		   "TX SWR_DMIC0", "DMIC1_OUTPUT",
+		   "TX SWR_DMIC1", "DMIC2_OUTPUT",
+		   "TX SWR_DMIC2", "DMIC3_OUTPUT",
+		   "TX SWR_DMIC3", "DMIC4_OUTPUT",
+		   "TX SWR_DMIC4", "DMIC5_OUTPUT",
+		   "TX SWR_DMIC5", "DMIC6_OUTPUT",
+		   "TX SWR_DMIC6", "DMIC7_OUTPUT",
+		   "TX SWR_DMIC7", "DMIC8_OUTPUT";
+
+		qcom,msm-mbhc-hphl-swh = <1>;
+		qcom,msm-mbhc-gnd-swh = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+
+		dai-link@0 {
+			link-name = "WCD9385 Playback";
+			reg = <0>;
+
+			cpu {
+				sound-dai = <&q6apmbedai  RX_CODEC_DMA_RX_0>;
+			};
+			codec {
+				sound-dai = <&wcd9385 0>, <&swr0 0>, <&lpass_rx_macro 0>;
+			};
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		dai-link@1 {
+			link-name = "WCD9385 Capture";
+			reg = <1>;
+
+			cpu {
+				sound-dai = <&q6apmbedai  TX_CODEC_DMA_TX_3>;
+			};
+			codec {
+				sound-dai = <&wcd9385 1>, <&swr1 0>, <&lpass_tx_macro 0>;
+			};
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		dai-link@2 {
+			link-name = "MAX98360A";
+			reg = <3>;
+
+			cpu {
+				sound-dai = <&q6apmbedai SECONDARY_MI2S_RX>;
+			};
+
+			codec {
+				sound-dai =	 <&max98360a>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		dai-link@3 {
+			link-name = "DMIC";
+			reg = <4>;
+
+			cpu {
+				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_va_macro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+};
-- 
2.7.4

