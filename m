Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8851C70B1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjEUWbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjEUWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:31:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523B1AD;
        Sun, 21 May 2023 15:30:53 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMUcUw024261;
        Sun, 21 May 2023 22:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=e1GPoTVGld6zUTGEyertNXqGagjhl5YpMmZvSoYsVIA=;
 b=n1fI2ne98CUvovIlAVnlKwt/9aQct+iHf9q5lg54+2i7/moc+RuQrfc0zqcVb2r5LE9b
 pwj2DfOVTe7bUXc/FmPCMD14aAY8iFkA8vtLITqyTdzTCjroz3wvwD+oFKIA281l0Y6d
 lw0mqg1Y5g//QFZGcZlLsaU6IYACT1mpDW71MgomdAq5FljFXALoLckh7BEEiAZ9ZF5t
 oCtavDSYsLnTiP0DeOAMsArSxix4IegeZ3ODXrTJArYC3u1uhNTBJpJuIibCj6JxDghI
 8ukhDezCBi5h0t9xM8sxGxl7PIlSE5by/YdMnbs4+ggag/ILgEgXTzSM8RKIXo0TwS/8 Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppypa6c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMUbvG001421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:37 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:30:30 -0700
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
Subject: [PATCH V2 11/13] arm64: dtsi: qcom: ipq5018: enable nodes required for multipd
Date:   Mon, 22 May 2023 03:58:50 +0530
Message-ID: <20230521222852.5740-12-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JTtRzheAr9v5Y0EwewG3a5y_PyJ__gly
X-Proofpoint-GUID: JTtRzheAr9v5Y0EwewG3a5y_PyJ__gly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=853 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210203
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable nodes required for multipd remoteproc bring up

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Corrected syntax like alignmnet and kept nodes in sorted order.
	- Covered entire TCSR region.
	- Added 'firmware-name' property.

 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 140 ++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..3772d54d89e4 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -85,6 +85,18 @@
 			reg = <0x0 0x4ac00000 0x0 0x200000>;
 			no-map;
 		};
+
+		q6_region: wcnss@4b000000 {
+			reg = <0x0 0x4b000000 0x0 0x1700000>;
+			no-map;
+		};
+
+		smem@4ab00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4ab00000 0x0 0x100000>;
+			hwlocks = <&tcsr_mutex 0>;
+			no-map;
+		};
 	};

 	soc: soc@0 {
@@ -128,6 +140,12 @@
 			#power-domain-cells = <1>;
 		};

+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq5018-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x7804000 0x1000>;
@@ -181,6 +199,14 @@
 			};
 		};

+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq5018-apcs-apps-global",
+				     "qcom,ipq6018-apcs-apps-global";
+			reg = <0x0b111000 0x1000>;
+			#clock-cells = <1>;
+			#mbox-cells = <1>;
+		};
+
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0b120000 0x1000>;
@@ -238,6 +264,96 @@
 				status = "disabled";
 			};
 		};
+
+		q6v5_wcss: remoteproc@cd00000 {
+			compatible = "qcom,ipq5018-q6-mpd";
+			reg = <0x0cd00000 0x4040>;
+			firmware-name = "IPQ5018/q6_fw.mdt",
+					"IPQ5018/m3_fw.mdt",
+					"qcn6122/m3_fw.mdt";
+			interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
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
+				interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+				label = "rtr";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 8>;
+			};
+
+			pd-1 {
+				compatible = "qcom,ipq5018-wcss-ahb-mpd";
+				firmware-name = "IPQ5018/q6_fw.mdt";
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
 	};

 	timer {
@@ -247,4 +363,28 @@
 			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	wcss: wcss-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
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

