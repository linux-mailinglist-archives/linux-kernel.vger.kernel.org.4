Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2846AD674
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCGEoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjCGEn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:43:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4FD4344C;
        Mon,  6 Mar 2023 20:43:26 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3273ktmC020223;
        Tue, 7 Mar 2023 04:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VpRk4YbY777HFNVZ8BbePQvB828+ffTguz28se27huw=;
 b=ZQcjpfMKEAkg/UEE4uRVD2v+AeWrqlnZXn+uLvt4UuI2RTFrgNbkdjPpBxaSR+NFN+C7
 jNbg4T7lBYHVe/YTCF+dR/hoj5r+zFtobx7ipiAi7xRCN6ido1ZBoCdG7q7awvS11v1o
 kmICGsxxtaxg19DDaK90Q52WNkbTH7aU4rkd4DSYoFNYBLW+vyl856N6MFp+jW/Ysel/
 oIAqnYFeDM/INrRf5oFdNDKNMSouDNhJcf+4FWaDYjNbL94vubU6mpbdk1JMy64PkCHb
 Mw010MVBEsz0VdAgsNDwEsQZ6rPJr59F+4YjsAk5H76H0jxIiMSCqK3r3naTKYVhZ3MH NA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5nkw966j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:43:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3274h39n023597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 04:43:03 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 20:42:55 -0800
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_mmanikan@quicinc.com>,
        <quic_gurus@quicinc.com>, <loic.poulain@linaro.org>,
        <quic_eberman@quicinc.com>, <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 09/11] arm64: dtsi: qcom: ipq5018: enable nodes required for multipd
Date:   Tue, 7 Mar 2023 10:11:35 +0530
Message-ID: <1678164097-13247-10-git-send-email-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d15xTPv3UfwuBtOMlPu1eInsqlpyi_09
X-Proofpoint-ORIG-GUID: d15xTPv3UfwuBtOMlPu1eInsqlpyi_09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=841 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable nodes required for multipd remoteproc bring up

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 130 ++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 084fb7b30dfd..4fa0990ab543 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -95,6 +95,24 @@ tz: tz@4ac00000 {
 			reg = <0x0 0x4ac00000 0x0 0x00400000>;
 			no-map;
 		};
+
+		q6_region: wcnss@4b000000 {
+			no-map;
+			reg = <0x0 0x4b000000 0x0 0x01700000>;
+		};
+
+		smem@4ab00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4ab00000 0x0 0x00100000>;
+			hwlocks = <&tcsr_mutex 0>;
+			no-map;
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-ipq5018", "qcom,scm";
+		};
 	};
 
 	timer {
@@ -105,6 +123,30 @@ timer {
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
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
+
 	soc: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -217,5 +259,93 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x8000>;
+			#hwlock-cells = <1>;
+		};
+
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq5018-apcs-apps-global";
+			reg = <0x0b111000 0x1000>;
+			#clock-cells = <1>;
+			#mbox-cells = <1>;
+		};
+
+		q6v5_wcss: remoteproc@cd00000 {
+			compatible = "qcom,ipq5018-q6-mpd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0x0cd00000 0x4040>;
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
+			q6_wcss_pd1: remoteproc_pd1 {
+				compatible = "qcom,ipq5018-wcss-ahb-mpd";
+			};
+
+			q6_wcss_pd2: remoteproc_pd2 {
+				compatible = "qcom,ipq5018-wcss-pcie-mpd";
+				interrupts-extended = <&wcss_smp2p_in 16 0>,
+					<&wcss_smp2p_in 17 0>,
+					<&wcss_smp2p_in 20 0>,
+					<&wcss_smp2p_in 19 0>;
+				interrupt-names = "fatal",
+					"ready",
+					"spawn-ack",
+					"stop-ack";
+
+				qcom,smem-states = <&wcss_smp2p_out 16>,
+						<&wcss_smp2p_out 17>,
+						<&wcss_smp2p_out 18>;
+				qcom,smem-state-names = "shutdown",
+							"stop",
+							"spawn";
+				status = "disabled";
+			};
+
+			q6_wcss_pd3: remoteproc_pd3 {
+				compatible = "qcom,ipq5018-wcss-pcie-mpd";
+				interrupts-extended = <&wcss_smp2p_in 24 0>,
+							<&wcss_smp2p_in 25 0>,
+							<&wcss_smp2p_in 28 0>,
+							<&wcss_smp2p_in 27 0>;
+				interrupt-names = "fatal",
+						"ready",
+						"spawn-ack",
+						"stop-ack";
+
+				qcom,smem-states = <&wcss_smp2p_out 24>,
+						<&wcss_smp2p_out 25>,
+						<&wcss_smp2p_out 26>;
+				qcom,smem-state-names = "shutdown",
+							"stop",
+							"spawn";
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
2.34.1

