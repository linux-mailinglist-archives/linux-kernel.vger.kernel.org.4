Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899DB6D9005
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjDFHCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjDFHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:02:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40993AD0B;
        Thu,  6 Apr 2023 00:01:24 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3366dnsH031473;
        Thu, 6 Apr 2023 07:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=c5n0Io+nI3jAJhMEhIDADWL55PCDRw/hMJE8Y3nCFpg=;
 b=DaDCCSJ4lFnFj6O9LRcUVR0zVk1Rtwiy5YImYKrGA/FvMKy2I7XD/Lm4MQqJ7L2L5vi/
 ig5p3MDfvKz1BFwUmePpHZTbRfLtb/lwwphzZcLn4GLN/+kfT7FTUfV9HTk69MdOLMXJ
 1SgC6qTvBsNIsVMXiSvIhLhg/P3b+fzvnPBgEV4Vup199Q+FOnjL+OZOOZ0FyV4wd1rE
 clTpi+CY5nz/Wt8+z2ALIMMe6Rsv3F7IB6iY/UAHXA+WyDoN/9Po5/blUX09ZWnHG73z
 KbO3bow8/ZrRCQHYDL0pVTlYiMiWYAI7wSVNJH5nfJdK0z2ZtIDVS46luirGlUyggmln lA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pss0rr1kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 07:01:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33671KVr015058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 07:01:20 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Apr 2023 00:01:14 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 5/5] arm64: dts: qcom: ipq9574: Add cpufreq support
Date:   Thu, 6 Apr 2023 12:30:32 +0530
Message-ID: <20230406070032.22243-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406070032.22243-1-quic_devipriy@quicinc.com>
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HuYSwljrkVIFJUQ2hsY6631WxfTeLVFI
X-Proofpoint-ORIG-GUID: HuYSwljrkVIFJUQ2hsY6631WxfTeLVFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=939
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060061
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu freq nodes in the device tree to bump cpu frequency above 800MHz.

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- No change

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 58 +++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 1f9b7529e7ed..cfef87b5fd22 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -6,6 +6,7 @@
  * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
@@ -37,6 +38,10 @@
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU1: cpu@1 {
@@ -45,6 +50,10 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU2: cpu@2 {
@@ -53,6 +62,10 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU3: cpu@3 {
@@ -61,6 +74,10 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		L2_0: l2-cache {
@@ -75,6 +92,47 @@
 		reg = <0x0 0x40000000 0x0 0x0>;
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-936000000 {
+			opp-hz = /bits/ 64 <936000000>;
+			opp-microvolt = <725000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <787500>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <862500>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <987500>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq9574", "qcom,scm";
-- 
2.17.1

