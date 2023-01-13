Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC6D669B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjAMPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjAMPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:13:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181B39FB8;
        Fri, 13 Jan 2023 07:04:01 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBuSHE005819;
        Fri, 13 Jan 2023 15:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=q/DwU4oKf/dRUlMNTrR2gxvc1Jy2rfrh+1KG4ThitS8=;
 b=FNGWuG/ghgEO57ownTzminsc3T4XZzSVlwL1j9cdZ/vwdJMJ633AkLrWLJ1yWOzCJJMP
 VF3NvIqjdJ3CiC5X0k7f/fFVct+o71gt/QBpf8WNvZPDLHzfo85XU2MRubzWW3BykYnS
 IYEJZp726B5NIFl4xgWWhO3bnV7A0NNm9x41Y7JJWfpY4IaCLM5pduLtHlcTt8HrI+YI
 KOlzXqOxpH4cPI1plQtmrw0xizlO0koCj53oxN8qzT6dQE/8eIW5pI5hX3eSFjXoe1ay
 wl6UFKl/g1rLrGk8En0MdbgmRCofLRIhfnd/upa/5/YEWRn2c0Y0Excx1SW+Kjn+vj5s wQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2wun1sc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:03:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DF3uvH028034
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:03:56 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 07:03:51 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 5/6] arm64: dts: qcom: ipq9574: Add cpufreq & RPM related nodes
Date:   Fri, 13 Jan 2023 20:33:09 +0530
Message-ID: <20230113150310.29709-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113150310.29709-1-quic_devipriy@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qU16GqnnAhG3WO1UJBZKfaydsmVNSqhr
X-Proofpoint-GUID: qU16GqnnAhG3WO1UJBZKfaydsmVNSqhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=899 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130099
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU Freq and RPM related nodes in the device tree

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 5a2244b437ed..79fa5d91882c 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq9574.h>
 #include <dt-bindings/reset/qcom,gcc-ipq9574.h>
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -75,6 +76,10 @@
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu0-supply = <&ipq9574_s1>;
 		};
 
 		CPU1: cpu@1 {
@@ -83,6 +88,10 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU2: cpu@2 {
@@ -91,6 +100,10 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		CPU3: cpu@3 {
@@ -99,6 +112,10 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&ipq9574_s1>;
 		};
 
 		L2_0: l2-cache {
@@ -107,6 +124,42 @@
 		};
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
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <787500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <862500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <200000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <987500>;
+			clock-latency-ns = <200000>;
+		};
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -128,6 +181,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		rpm_msg_ram: memory@60000 {
+			reg = <0x0 0x00060000 0x0 0x6000>;
+			no-map;
+		};
+
 		tz_region: memory@4a600000 {
 			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
@@ -324,6 +382,28 @@
 		};
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: glink-channel {
+			compatible = "qcom,rpm-ipq9574";
+			qcom,glink-channels = "rpm_requests";
+
+			regulators {
+				compatible = "qcom,rpm-ipq9574-mp5496-regulators";
+
+				ipq9574_s1: s1 {
+					regulator-min-microvolt = <587500>;
+					regulator-max-microvolt = <1075000>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.17.1

