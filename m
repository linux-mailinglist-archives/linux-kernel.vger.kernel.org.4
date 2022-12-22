Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1EB653DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiLVJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiLVJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:43:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C827B2F;
        Thu, 22 Dec 2022 01:43:27 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM97Fwu028171;
        Thu, 22 Dec 2022 09:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=J2Y1OhiAbGN4by8BD6xuUcc/297dayPgjjDnjIDrsZs=;
 b=phsyGAHdrOPgrG57lpBNLe++WosIWjNGJww5mLHOFHjlIhJBWXeWu/NoZpjWSgyGSgEK
 tDNq/Vc5LMWqJWj3FUyuTrZsmlKsxpuUIymFe2RYOnN+wlfu84Epa+7m9AYUj25y9eqc
 lCDNO4hFRekjirw9GePxE66ymqyPFQHJdqlVyDD54Yf09RhR5yHnl3YKokfhO0czFswQ
 bL/J7hmYGJzpRhl9sEjK7rky+TRyV/lZAp6xe1sTAjVMhvPAoYqp7ETinpQ4ZAeSy85x
 gNvH38GXC+EjbL6DXgRxgMtspChv3Hly1bRxo3ATeA38gBr0xDqdgovrMDvftG0EzRMT tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mmkrx0473-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BM9hL5J026961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:21 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 01:43:16 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 1/7] arm64: dts: qcom: sc7280: Extract audio nodes from common idp dtsi file
Date:   Thu, 22 Dec 2022 15:12:44 +0530
Message-ID: <1671702170-24781-2-git-send-email-quic_srivasam@quicinc.com>
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
X-Proofpoint-GUID: Vas1kuLuRCNOkKxJFhOPvDJ-R0SKSdwl
X-Proofpoint-ORIG-GUID: Vas1kuLuRCNOkKxJFhOPvDJ-R0SKSdwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_03,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi | 242 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |   1 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 230 -----------------------
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts       |   1 +
 4 files changed, 244 insertions(+), 230 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
new file mode 100644
index 0000000..8c9e667
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * sc7280 Audio IDP board device tree source (common between SKU1 and SKU2)
+ *
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+/{
+   /* BOARD-SPECIFIC TOP LEVEL NODES */
+	sound: sound {
+		compatible = "google,sc7280-herobrine";
+		model = "sc7280-wcd938x-max98360a-1mic";
+
+		audio-routing =
+			   "IN1_HPHL", "HPHL_OUT",
+			   "IN2_HPHR", "HPHR_OUT",
+			   "AMIC1", "MIC BIAS1",
+			   "AMIC2", "MIC BIAS2",
+			   "VA DMIC0", "MIC BIAS3",
+			   "VA DMIC1", "MIC BIAS3",
+			   "VA DMIC2", "MIC BIAS1",
+			   "VA DMIC3", "MIC BIAS1",
+			   "TX SWR_ADC0", "ADC1_OUTPUT",
+			   "TX SWR_ADC1", "ADC2_OUTPUT",
+			   "TX SWR_ADC2", "ADC3_OUTPUT",
+			   "TX SWR_DMIC0", "DMIC1_OUTPUT",
+			   "TX SWR_DMIC1", "DMIC2_OUTPUT",
+			   "TX SWR_DMIC2", "DMIC3_OUTPUT",
+			   "TX SWR_DMIC3", "DMIC4_OUTPUT",
+			   "TX SWR_DMIC4", "DMIC5_OUTPUT",
+			   "TX SWR_DMIC5", "DMIC6_OUTPUT",
+			   "TX SWR_DMIC6", "DMIC7_OUTPUT",
+			   "TX SWR_DMIC7", "DMIC8_OUTPUT";
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
+			   sound-dai = <&max98360a>;
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
+
+	wcd9385: audio-codec-1 {
+		compatible = "qcom,wcd9385-codec";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&wcd_reset_n>;
+		pinctrl-1 = <&wcd_reset_n_sleep>;
+
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		vdd-rxtx-supply = <&vreg_l18b_1p8>;
+		vdd-io-supply = <&vreg_l18b_1p8>;
+		vdd-buck-supply = <&vreg_l17b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
+							  500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		#sound-dai-cells = <1>;
+	};
+
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
+
+&lpass_rx_macro {
+	status = "okay";
+};
+
+&lpass_tx_macro {
+	status = "okay";
+};
+
+&lpass_va_macro {
+	status = "okay";
+	vdd-micb-supply = <&vreg_bob>;
+};
+
+&swr0 {
+	status = "okay";
+
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		#sound-dai-cells = <1>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		#sound-dai-cells = <1>;
+		qcom,tx-port-mapping = <1 2 3 4>;
+	};
+};
+
+&lpass_dmic01_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic01_data {
+	   bias-pull-down;
+};
+
+&lpass_dmic23_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic23_data {
+	bias-pull-down;
+};
+
+&lpass_rx_swr_clk {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-disable;
+};
+
+&lpass_rx_swr_data {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-bus-hold;
+};
+
+&lpass_tx_swr_clk {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-disable;
+};
+
+&lpass_tx_swr_data {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-bus-hold;
+};
+
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
index f7efb99..7e35867 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -29,34 +29,6 @@
 		#sound-dai-cells = <0>;
 	};
 
-	wcd9385: audio-codec-1 {
-		compatible = "qcom,wcd9385-codec";
-		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&wcd_reset_n>;
-		pinctrl-1 = <&wcd_reset_n_sleep>;
-
-		reset-gpios = <&tlmm 83 GPIO_ACTIVE_LOW>;
-
-		qcom,rx-device = <&wcd_rx>;
-		qcom,tx-device = <&wcd_tx>;
-
-		vdd-rxtx-supply = <&vreg_l18b_1p8>;
-		vdd-io-supply = <&vreg_l18b_1p8>;
-		vdd-buck-supply = <&vreg_l17b_1p8>;
-		vdd-mic-bias-supply = <&vreg_bob>;
-
-		qcom,micbias1-microvolt = <1800000>;
-		qcom,micbias2-microvolt = <1800000>;
-		qcom,micbias3-microvolt = <1800000>;
-		qcom,micbias4-microvolt = <1800000>;
-
-		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
-							  500000 500000 500000>;
-		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
-		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
-		#sound-dai-cells = <1>;
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -87,103 +59,6 @@
 		pinctrl-0 = <&nvme_pwren>;
 	};
 
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
@@ -381,47 +256,6 @@
 	modem-init;
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
-&lpass_rx_macro {
-	status = "okay";
-};
-
-&lpass_tx_macro {
-	status = "okay";
-};
-
-&lpass_va_macro {
-	status = "okay";
-	vdd-micb-supply = <&vreg_bob>;
-};
-
 &pcie1 {
 	status = "okay";
 	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
@@ -482,28 +316,6 @@
 	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
 };
 
-&swr0 {
-	status = "okay";
-
-	wcd_rx: codec@0,4 {
-		compatible = "sdw20217010d00";
-		reg = <0 4>;
-		#sound-dai-cells = <1>;
-		qcom,rx-port-mapping = <1 2 3 4 5>;
-	};
-};
-
-&swr1 {
-	status = "okay";
-
-	wcd_tx: codec@0,3 {
-		compatible = "sdw20217010d00";
-		reg = <0 3>;
-		#sound-dai-cells = <1>;
-		qcom,tx-port-mapping = <1 2 3 4>;
-	};
-};
-
 &uart5 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";
@@ -571,48 +383,6 @@
 	bias-disable;
 };
 
-&lpass_dmic01_clk {
-	drive-strength = <8>;
-	bias-disable;
-};
-
-&lpass_dmic01_data {
-	bias-pull-down;
-};
-
-&lpass_dmic23_clk {
-	drive-strength = <8>;
-	bias-disable;
-};
-
-&lpass_dmic23_data {
-	bias-pull-down;
-};
-
-&lpass_rx_swr_clk {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-disable;
-};
-
-&lpass_rx_swr_data {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-bus-hold;
-};
-
-&lpass_tx_swr_clk {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-disable;
-};
-
-&lpass_tx_swr_data {
-	drive-strength = <2>;
-	slew-rate = <1>;
-	bias-bus-hold;
-};
-
 &mi2s1_data0 {
 	drive-strength = <6>;
 	bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index d4f7cab..bc1a1a8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-idp.dtsi"
+#include "sc7280-audio-idp.dtsi"
 #include "sc7280-idp-ec-h1.dtsi"
 
 / {
-- 
2.7.4

