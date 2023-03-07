Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54866AD67F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCGEo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCGEoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:44:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEAB367C0;
        Mon,  6 Mar 2023 20:43:45 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3274KHuj017089;
        Tue, 7 Mar 2023 04:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bV/tTebdqkEC/fcXxVlgJIGBuJKm7eTXWETRWlyJ25k=;
 b=XS8CbBRigRuAraGjLBYVMlKphaKmgcjDQ0Brl5ZOkp646NGpOCXCXyl1AwJqW/+II4pl
 gxNbhn3LN7iKpC68ybhraFx7vyo+jGAtMUsnTO/xs69ZZ1HJYcBl2p/akX9liBgz54mJ
 5kU5D+Sp3EnVNYMiU44rbqVXyNcoKhcWzutdCMkM9wWVKOARe/tyDOhO/hTpbnK1tess
 6s8+waSQAHcFcErD92r6m4wqkmw+HpS6i6th5Ek13Uq6K1FcmsVUtf0yZcAxx9Dg/uMk
 YyisVml3dm984D4YyZBiMhuIP1SRMp7dk87XIXIGeQ28nf9G4KvJnzv7+lLsHS1n5+IX LQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5nkw966w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:43:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3274hIwX029795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 04:43:18 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 20:43:11 -0800
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
Subject: [PATCH 11/11] arm64: dtsi: qcom: ipq9574: Add nodes to bring up multipd
Date:   Tue, 7 Mar 2023 10:11:37 +0530
Message-ID: <1678164097-13247-12-git-send-email-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: qPS7C2bFnGGR52C9N5WSF0b_6SJO9qhe
X-Proofpoint-ORIG-GUID: qPS7C2bFnGGR52C9N5WSF0b_6SJO9qhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=666 lowpriorityscore=0
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

Enable nodes required for multipd remoteproc bring up.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 145 ++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 2bb4053641da..e0645bc39db4 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -201,6 +201,11 @@ tz_region: tz@4a600000 {
 			no-map;
 		};
 
+		q6_region: wcnss@4ab00000 {
+			reg = <0x0 0x4ab00000 0x0 0x02b00000>;
+			no-map;
+		};
+
 		smem@4aa00000 {
 			compatible = "qcom,smem";
 			reg = <0x0 0x4aa00000 0x0 0x00100000>;
@@ -209,6 +214,30 @@ smem@4aa00000 {
 		};
 	};
 
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
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -829,6 +858,122 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 			msi-parent = <&v2m0>;
 			status = "disabled";
 		};
+
+		q6v5_wcss: remoteproc@cd00000 {
+			compatible = "qcom,ipq9574-q6-mpd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0x0cd00000 0x4040>;
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
+			clocks = <&gcc GCC_ANOC_WCSS_AXI_M_CLK>,
+				 <&gcc GCC_WCSS_AHB_S_CLK>,
+				 <&gcc GCC_WCSS_ECAHB_CLK>,
+				 <&gcc GCC_WCSS_ACMT_CLK>,
+				 <&gcc GCC_WCSS_AXI_M_CLK>,
+				 <&gcc GCC_Q6_AXIM_CLK>,
+				 <&gcc GCC_Q6_AXIM2_CLK>,
+				 <&gcc GCC_Q6_AHB_CLK>,
+				 <&gcc GCC_Q6_AHB_S_CLK>,
+				 <&gcc GCC_Q6SS_BOOT_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_APB_BDG_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_ATB_BDG_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_NTS_BDG_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_APB_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_ATB_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_DAPBUS_CLK>,
+				 <&gcc GCC_WCSS_DBG_IFC_NTS_CLK>,
+				 <&gcc GCC_Q6_TSCTR_1TO2_CLK>,
+				 <&gcc GCC_Q6SS_ATBM_CLK>,
+				 <&gcc GCC_Q6SS_PCLKDBG_CLK>,
+				 <&gcc GCC_Q6SS_TRIG_CLK>,
+				 <&gcc GCC_MEM_NOC_Q6_AXI_CLK>,
+				 <&gcc GCC_WCSS_Q6_TBU_CLK>,
+				 <&gcc GCC_SYS_NOC_WCSS_AHB_CLK>;
+
+			clock-names = "anoc_wcss_axi_m",
+				      "wcss_ahb_s",
+				      "wcss_ecahb",
+				      "wcss_acmt",
+				      "wcss_axi_m",
+				      "q6_axim",
+				      "q6_axim2",
+				      "q6_ahb",
+				      "q6_ahb_s",
+				      "q6ss_boot",
+				      "dbg-apb-bdg",
+				      "dbg-atb-bdg",
+				      "dbg-dapbus-bdg",
+				      "dbg-nts-bdg",
+				      "dbg-apb",
+				      "dbg-atb",
+				      "dbg-dapbus",
+				      "dbg-nts",
+				      "q6_tsctr_1to2_clk",
+				      "q6ss_atbm_clk",
+				      "q6ss_pclkdbg_clk",
+				      "q6ss_trig_clk",
+				      "mem_noc_q6_axi",
+				      "wcss_q6_tbu",
+				      "sys_noc_wcss_ahb";
+
+			assigned-clocks = <&gcc GCC_ANOC_WCSS_AXI_M_CLK>,
+				 <&gcc GCC_WCSS_AHB_S_CLK>,
+				 <&gcc GCC_WCSS_ECAHB_CLK>,
+				 <&gcc GCC_WCSS_ACMT_CLK>,
+				 <&gcc GCC_WCSS_AXI_M_CLK>,
+				 <&gcc GCC_Q6_AXIM_CLK>,
+				 <&gcc GCC_Q6_AXIM2_CLK>,
+				 <&gcc GCC_Q6_AHB_CLK>,
+				 <&gcc GCC_Q6_AHB_S_CLK>,
+				 <&gcc GCC_Q6SS_BOOT_CLK>,
+				 <&gcc GCC_MEM_NOC_Q6_AXI_CLK>,
+				 <&gcc GCC_WCSS_Q6_TBU_CLK>,
+				 <&gcc GCC_SYS_NOC_WCSS_AHB_CLK>;
+
+			assigned-clock-rates = <266666667>,
+						<133333333>,
+						<133333333>,
+						<133333333>,
+						<266666667>,
+						<533000000>,
+						<342857143>,
+						<133333333>,
+						<133333333>,
+						<342857143>,
+						<533000000>,
+						<533000000>,
+						<133333333>;
+
+			qcom,smem-states = <&wcss_smp2p_out 0>,
+					   <&wcss_smp2p_out 1>;
+			qcom,smem-state-names = "shutdown",
+						"stop";
+
+			memory-region = <&q6_region>;
+
+			glink-edge {
+				interrupts = <GIC_SPI 321 IRQ_TYPE_EDGE_RISING>;
+				label = "rtr";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 8>;
+			};
+
+			q6_wcss_pd1: remoteproc_pd1 {
+				compatible = "qcom,ipq9574-wcss-ahb-mpd";
+			};
+		};
 	};
 
 	rpm-glink {
-- 
2.34.1

