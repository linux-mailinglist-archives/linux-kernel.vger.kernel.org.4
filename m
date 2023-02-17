Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D769ADED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBQOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBQOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:21:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C106CA3D;
        Fri, 17 Feb 2023 06:21:28 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HDsEiE024326;
        Fri, 17 Feb 2023 14:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=W4CccyOiOo4G+9Es20Lt/Igbfhe3yQ8E6P+ulKFqOQ4=;
 b=KKnn2YA4C/q4bzr0pZRTSfkhxtIcbpXOgv89lNb9meIIBJYmhQTW05/m2giorExz+OIB
 skEX41ZREMfrQlCQYmSCuMT1I0B/f6c8w9+3bqmYl5xcJPSE6AG64Jyo1jsCbF4lR21q
 OGa5mhUyxqavxmR0caRk4ph8Z/ZODdJqEG6JhqycX8gDUGo65QDvskVdJ0CMFXo9AC44
 3YxBtT8n6eNas750kuvGQr0FxtI7Xq6Ymko3kzKiQhyV8HkdZxNRb5Nw2CJtEORClKKM
 gMs0bgDA+gPL2d0bq3/D2Ck1jPNYWUP4/Fo86bxBVztDCNTL/23sGGUFbvi0Q7H9/2ai RQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt5kurshh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HELO4m025162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:24 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 06:21:18 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 6/6] arm64: dts: qcom: ipq9574: Add cpufreq support
Date:   Fri, 17 Feb 2023 19:50:30 +0530
Message-ID: <20230217142030.16012-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217142030.16012-1-quic_devipriy@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _1oZblUYjUfXvl7ArZfyPYNgaUgvgJVv
X-Proofpoint-ORIG-GUID: _1oZblUYjUfXvl7ArZfyPYNgaUgvgJVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_09,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=780 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu freq nodes in the device tree to bump
cpu frequency above 800MHz

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Created a separate patch for CPU freq related nodes
	- Updated cpu0-supply to cpu-supply in CPU@0 node
	- Moved the opp-table-cpu node after memory to have it sorted
	  alphabetically
	- Added a new line between the subnodes in opp-table-cpu

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 58 +++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 2f300cbab93e..2bb4053641da 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -6,6 +6,7 @@
  * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
@@ -73,6 +74,10 @@
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU1: cpu@1 {
@@ -81,6 +86,10 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU2: cpu@2 {
@@ -89,6 +98,10 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU3: cpu@3 {
@@ -97,6 +110,10 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		L2_0: l2-cache {
@@ -111,6 +128,47 @@
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

