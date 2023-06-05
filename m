Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C44722CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjFEQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjFEQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:29:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9DD9;
        Mon,  5 Jun 2023 09:29:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355Co2ds015778;
        Mon, 5 Jun 2023 16:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=tkXjIno05T5Gn5aWvcwiFQsgZ0JFsJ8oSWtY1w53KMU=;
 b=p6kAe/nlwOKxXNT+ubYqeC9Q0psafHq1pUK87qCEOike5Lh0uPHEwK35jnSH+9bo+KcK
 RvlxQTuwBvBaDkBNMd/9ag2YpDothMgwmOujOuMbGmgM9qn6yPbVLQHzg7f3U7gFSPyH
 gUx/NlBpOINMr6p4N5RSJSzQioOJJO686cc2bE0Z8x1mJjf8e0wUE7jFRJobpJS+/UbE
 pE9mimfRcziu04k1LnTMmYkUXh8xTtVr9LXn6fN1ef8Y+zGELzbMKoGgDVSKzrwD9tqx
 VKJ1jrlaPGFOmRInn5UWw+hGAZQFuSO6RRAq+AYGLboxt0ey81vEulAs0GzmYV2tKX2b lA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1aughe61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 16:29:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 355GTKOf030377;
        Mon, 5 Jun 2023 16:29:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkkq42g-1;
        Mon, 05 Jun 2023 16:29:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355GTJSL030342;
        Mon, 5 Jun 2023 16:29:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 355GTJDg030326;
        Mon, 05 Jun 2023 16:29:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 447FF5F03; Mon,  5 Jun 2023 21:59:20 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        tglx@linutronix.de, maz@kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, mani@kernel.org,
        robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 08/10] arm64: dts: qcom: Add QUPv3 UART console node for SDX75
Date:   Mon,  5 Jun 2023 21:59:15 +0530
Message-Id: <1685982557-28326-9-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bpvy3jEqU05SuztDDVwCY5bfJGdwiXBM
X-Proofpoint-ORIG-GUID: Bpvy3jEqU05SuztDDVwCY5bfJGdwiXBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=856 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306050141
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the debug uart console node in devicetree.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index f83eef8..47170ae 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -385,6 +385,34 @@
 			#power-domain-cells = <1>;
 		};
 
+		qupv3_id_0: geniqup@9c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x009c0000 0x0 0x2000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb",
+				      "s-ahb";
+			iommus = <&apps_smmu 0xe3 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			uart1: serial@984000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x00984000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&qupv3_se1_2uart_tx_active>,
+					    <&qupv3_se1_2uart_rx_active>;
+				pinctrl-1 = <&qupv3_se1_2uart_sleep>;
+				pinctrl-names = "default",
+						"sleep";
+				status = "disabled";
+			};
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -413,6 +441,27 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
+
+			qupv3_se1_2uart_tx_active: qupv3-se1-2uart-tx-active-state {
+				pins = "gpio12";
+				function = "qup_se1_l2_mira";
+				drive-strength= <2>;
+				bias-disable;
+			};
+
+			qupv3_se1_2uart_rx_active: qupv3-se1-2uart-rx-active-state {
+				pins = "gpio13";
+				function = "qup_se1_l3_mira";
+				drive-strength= <2>;
+				bias-disable;
+			};
+
+			qupv3_se1_2uart_sleep: qupv3-se1-2uart-sleep-state {
+				pins = "gpio12", "gpio13";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
 		};
 
 		apps_smmu: iommu@15000000 {
-- 
2.7.4

