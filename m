Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5936E6E24A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDNNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDNNtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:49:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B185B777;
        Fri, 14 Apr 2023 06:48:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ECMWoW018605;
        Fri, 14 Apr 2023 13:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NsKLEWUUMp+f01Q80V7D0nGNgF5lJe5NNwIA05M+kU4=;
 b=kPZEWXIzOZdLdQYPF0utDIgDIDKr29Zo7Gq8OZfAJB/Sa5auWozanBp9QMxHT8yKl4ad
 jp7sUmegW40iIQx144SBUF9ZElV6kKNPJoNfeHI/ZSRk+rSm0xkIG3o7MNTxqgL2y0R6
 gBajUymywsmYFr9tYQfmVY3tSmfUyfxpyDt9xinm2tCs6NfJ0OgML/7WD4T9RJ3rMoSD
 m4QnoV86FVO9m/mvN/eyNlCyHpdbQO3pduqTDElcXOgJZQGXZvzrwEjBVMN5RRapGDXc
 THC8XCJND+sLb6Rr4YEL1ruBcVexQZpL8x9nM4H5QsTZanG/wm7Ad4eURO6urEXwWQXH 0g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py1wpgtnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:48:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EDmnsO006234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:48:49 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 14 Apr 2023 06:48:44 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V1 3/4] arm64: dts: qcom: ipq9574: Drop Bias PLL clock & update intc node
Date:   Fri, 14 Apr 2023 19:18:11 +0530
Message-ID: <20230414134812.16812-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414134812.16812-1-quic_devipriy@quicinc.com>
References: <20230414134812.16812-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7qlyuEPCD8z3fYEeK-NNBnI0WYnhCtH2
X-Proofpoint-ORIG-GUID: 7qlyuEPCD8z3fYEeK-NNBnI0WYnhCtH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 mlxlogscore=928 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unused backup source bias_pll_ubi_nc_clk.
Also, update the size of GICC and GICV region to 8kB and add target CPU
encoding.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes since V9:
	- Dropped the unused backup clock source bias_pll_ubi_nc_clk
	- Updated the size of GICC and GICV region to 8kB
	- Added target CPU encoding

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 3bb7435f5e7f..f1f959b43180 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -16,12 +16,6 @@
 	#size-cells = <2>;
 
 	clocks {
-		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
-			compatible = "fixed-clock";
-			clock-frequency = <353000000>;
-			#clock-cells = <0>;
-		};
-
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -131,7 +125,6 @@
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
-				 <&bias_pll_ubi_nc_clk>,
 				 <0>,
 				 <0>,
 				 <0>,
@@ -172,14 +165,14 @@
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>,  /* GICD */
-			      <0x0b002000 0x1000>,  /* GICC */
+			      <0x0b002000 0x2000>,  /* GICC */
 			      <0x0b001000 0x1000>,  /* GICH */
-			      <0x0b004000 0x1000>;  /* GICV */
+			      <0x0b004000 0x2000>;  /* GICV */
 			#address-cells = <1>;
 			#size-cells = <1>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 			ranges = <0 0x0b00c000 0x3000>;
 
 			v2m0: v2m@0 {
-- 
2.17.1

