Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3242A69A708
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBQIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBQIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:34:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1A5FBC8;
        Fri, 17 Feb 2023 00:33:56 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H6oJRT019483;
        Fri, 17 Feb 2023 08:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7NzHuwpLfAHoeS4MDg46Por/cx6TUNRnZkEsBcJGs4Y=;
 b=LXGwcxJoCqD1p5YdwzNxSv5XYxZpPwiT0zO5YbYZlfi01BgoWtymno/xaA7+x3FA51W3
 fIrXbRDAYLiMqKhAtInmJLu9PfgcYo7wA3Yn/LhevbL+3/ulpWywp7/JugvsiyR4jlmI
 F0ZOU86dVwtg6P42ol1vYJIBLGTVZQTzMsP6HdmNydmXAa54tMp4vtq0jpd0hqKmO37/
 /+KcrTExTC8RtAE21Sert3fwYmYPu+nZvWv97lFNKwNotwr+Falocwse/6FLpNbSW0b9
 XvlDmHh5u5dgrRyzR/ei8cwY486xMotY8YjyNPx8PRqpXdo5bfI9xSPyVAqbWYbjqDmO dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nshe5k8kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:33:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H8XprE012565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:33:51 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 00:33:46 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V3 5/5] arm64: dts: qcom: ipq5332: enable the CPUFreq support
Date:   Fri, 17 Feb 2023 14:03:08 +0530
Message-ID: <20230217083308.12017-6-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217083308.12017-1-quic_kathirav@quicinc.com>
References: <20230217083308.12017-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _c5teQD24S1ItNHlzX_7wyyt2WNLF2P5
X-Proofpoint-ORIG-GUID: _c5teQD24S1ItNHlzX_7wyyt2WNLF2P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_04,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxlogscore=935 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the APCS, A53 PLL, cpu-opp-table nodes to bump the CPU frequency
above 800MHz.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V3:
	- Sort the opp-table-cpu node

Changes in V2:
	- No changes

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index a2ed54264d5c..4bf8c01721d6 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -35,6 +36,8 @@
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU1: cpu@1 {
@@ -43,6 +46,8 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU2: cpu@2 {
@@ -51,6 +56,8 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU3: cpu@3 {
@@ -59,6 +66,8 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		L2_0: l2-cache {
@@ -79,6 +88,16 @@
 		reg = <0x0 0x40000000 0x0 0x0>;
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
@@ -194,6 +213,24 @@
 			};
 		};
 
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq5332-apcs-apps-global",
+				     "qcom,ipq6018-apcs-apps-global";
+			reg = <0x0b111000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&a53pll>, <&xo_board>;
+			clock-names = "pll", "xo";
+			#mbox-cells = <1>;
+		};
+
+		a53pll: clock@b116000 {
+			compatible = "qcom,ipq5332-a53pll";
+			reg = <0x0b116000 0x40>;
+			#clock-cells = <0>;
+			clocks = <&xo_board>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0b120000 0x1000>;
-- 
2.17.1

