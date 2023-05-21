Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6917F70B1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjEUWbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjEUWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:31:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085351B4;
        Sun, 21 May 2023 15:31:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMTsta026563;
        Sun, 21 May 2023 22:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=su4pLfaYpFjRQckjSvgDjsewZEZbx868uHmkpyjso4s=;
 b=SDVRfjCrACNcg6LJi4tTo65n2Yg4GkY/dVr3flASoMXqmfaGaMAsamyQj8NFyS6GWPB7
 sN2PeRdKbUiM453rWFu2k1URqOydZyHyjvc8DzMdimuAuj2mJtzlcfQ5ZGxsPpQI+J0O
 R6Y6naD7Bc/rMrz1Zae+3sYMlO8E5BOt7ynSDm14fghE+bNKr1eKlb/5ZsB3qvpL6Tcu
 26DYdT3ZKvA+IDG3W/Jc7gxrBxYr/VOxmApYCLCjI6S8ZrphZMMMkdyiJFQ1sQVKwEW5
 N0tFj1lhcYYi2kkxKOUO+I/03Q68UWhlTYVZQZyAAwBQfEYrMxcv6qkJhslPvxol263h 1w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppa1a9uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMUp36011891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:52 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:30:44 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <quic_mmanikan@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 13/13] arm64: dtsi: qcom: ipq9574: Add nodes to bring up multipd
Date:   Mon, 22 May 2023 03:58:52 +0530
Message-ID: <20230521222852.5740-14-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uYe28ZOXgSwTAqI5FOeRAdDepM7YcXwg
X-Proofpoint-ORIG-GUID: uYe28ZOXgSwTAqI5FOeRAdDepM7YcXwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=760 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305210202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable nodes required for multipd remoteproc bring up.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Corrected syntax like alignmnet and kept nodes in sorted order.
	- Added 'firmware-name' property.

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 118 ++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 0e04549c69a5..ff0da53ba05f 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -160,6 +160,11 @@
 			no-map;
 		};

+		q6_region: wcnss@4ab00000 {
+			reg = <0x0 0x4ab00000 0x0 0x2b00000>;
+			no-map;
+		};
+
 		smem@4aa00000 {
 			compatible = "qcom,smem";
 			reg = <0x0 0x4aa00000 0x0 0x00100000>;
@@ -697,6 +702,95 @@
 			};
 		};

+		q6v5_wcss: remoteproc@cd00000 {
+			compatible = "qcom,ipq9574-q6-mpd";
+			reg = <0x0cd00000 0x4040>;
+			firmware-name = "IPQ9574/q6_fw.mdt",
+					"IPQ9574/m3_fw.mdt";
+			interrupts-extended = <&intc GIC_SPI 325 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 0 0>,
+					      <&wcss_smp2p_in 1 0>,
+					      <&wcss_smp2p_in 2 0>,
+					      <&wcss_smp2p_in 3 0>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			qcom,smem-states = <&wcss_smp2p_out 0>,
+					   <&wcss_smp2p_out 1>;
+			qcom,smem-state-names = "shutdown",
+						"stop";
+			memory-region = <&q6_region>;
+
+			glink-edge {
+				interrupts = <GIC_SPI 321 IRQ_TYPE_EDGE_RISING>;
+				label = "rtr";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 8>;
+			};
+
+			pd-1 {
+				compatible = "qcom,ipq9574-wcss-ahb-mpd";
+				firmware-name = "IPQ9574/q6_fw.mdt";
+				interrupts-extended = <&wcss_smp2p_in 8 0>,
+						      <&wcss_smp2p_in 9 0>,
+						      <&wcss_smp2p_in 12 0>,
+						      <&wcss_smp2p_in 11 0>;
+				interrupt-names = "fatal",
+						  "ready",
+						  "spawn-ack",
+						  "stop-ack";
+				qcom,smem-states = <&wcss_smp2p_out 8>,
+						   <&wcss_smp2p_out 9>,
+						   <&wcss_smp2p_out 10>;
+				qcom,smem-state-names = "shutdown",
+							"stop",
+							"spawn";
+			};
+
+			pd-2 {
+				compatible = "qcom,ipq5018-wcss-pcie-mpd";
+				interrupts-extended = <&wcss_smp2p_in 16 0>,
+						      <&wcss_smp2p_in 17 0>,
+						      <&wcss_smp2p_in 20 0>,
+						      <&wcss_smp2p_in 19 0>;
+				interrupt-names = "fatal",
+						  "ready",
+						  "spawn-ack",
+						  "stop-ack";
+
+				qcom,smem-states = <&wcss_smp2p_out 16>,
+						   <&wcss_smp2p_out 17>,
+						   <&wcss_smp2p_out 18>;
+				qcom,smem-state-names = "shutdown",
+							"stop",
+							"spawn";
+				status = "disabled";
+			};
+
+			pd-3 {
+				compatible = "qcom,ipq5018-wcss-pcie-mpd";
+				interrupts-extended = <&wcss_smp2p_in 24 0>,
+						      <&wcss_smp2p_in 25 0>,
+						      <&wcss_smp2p_in 28 0>,
+						      <&wcss_smp2p_in 27 0>;
+				interrupt-names = "fatal",
+						  "ready",
+						  "spawn-ack",
+						  "stop-ack";
+
+				qcom,smem-states = <&wcss_smp2p_out 24>,
+						   <&wcss_smp2p_out 25>,
+						   <&wcss_smp2p_out 26>;
+				qcom,smem-state-names = "shutdown",
+							"stop",
+							"spawn";
+				status = "disabled";
+			};
+		};
+
 		pcie1: pci@10000000 {
 			compatible = "qcom,pcie-ipq9574";
 			reg =  <0x10000000 0xf1d>,
@@ -966,4 +1060,28 @@
 			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	wcss: wcss-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_SPI 322 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 9>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		wcss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		wcss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
 };
--
2.17.1

