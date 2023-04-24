Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12B6ECB10
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDXLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjDXLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:10:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB53A93;
        Mon, 24 Apr 2023 04:10:11 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OAHWEa025533;
        Mon, 24 Apr 2023 11:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PVanemxTGHNwW7sECOC/oZd3nV8/hXz7nJyVF8PWJVk=;
 b=aKSt9Rvj6uoLUiE29kzQQlQk53m2FrWQzePmU/CoELmm8JBDheHSvFK2YMzk0Anien3T
 y3g90SHRLFJqjfmZyavPRwMnNPCNR82+Mswr8MkAmzvkP0zT5ER/ND0b4neYYuNEO4QP
 oK4KYjKE3wcRKd/kLxu/u5/LaAGxIl++FkNRXiNVzMENT+/U/6iiQXG3tTyAV1b6cWVg
 1LzFftt2DiaHi1HOVK11UFIjWIY0i9lGGgWdDMoOTnazURHiXvyz5cJ3cFQLnTErjKTB
 urGD+nH9EciXR6Q98W0sOPw4v4ikF+1vbz1nkXZMO29eUkdX+8C1Np5CXOeelTl0QJzc jg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5qv1r3w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:10:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33OBA3Ih011595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:10:03 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 04:09:58 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <andersson@kernel.org>, <ulf.hansson@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <wingers@google.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
Date:   Mon, 24 Apr 2023 16:39:33 +0530
Message-ID: <20230424110933.3908-4-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424110933.3908-1-quic_mkshah@quicinc.com>
References: <20230424110933.3908-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RybY1rszcCwfGnq6Pw9kD0_dXzfMR8TK
X-Proofpoint-ORIG-GUID: RybY1rszcCwfGnq6Pw9kD0_dXzfMR8TK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=959 suspectscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domains for cpuidle states to use psci os-initiated idle states.

Cc: devicetree@vger.kernel.org
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 31728f461422..88e234b4dee3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -170,9 +170,8 @@
 			reg = <0x0 0x0>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -196,9 +195,8 @@
 			reg = <0x0 0x100>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_100>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -218,9 +216,8 @@
 			reg = <0x0 0x200>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_200>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -240,9 +237,8 @@
 			reg = <0x0 0x300>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_300>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -262,9 +258,8 @@
 			reg = <0x0 0x400>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_400>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -284,9 +279,8 @@
 			reg = <0x0 0x500>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_500>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -306,9 +300,8 @@
 			reg = <0x0 0x600>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_600>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -328,9 +321,8 @@
 			reg = <0x0 0x700>;
 			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_700>;
 			operating-points-v2 = <&cpu7_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
@@ -422,9 +414,11 @@
 				min-residency-us = <5555>;
 				local-timer-stop;
 			};
+		};
 
+		domain-idle-states {
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state";
+				compatible = "domain-idle-state";
 				idle-state-name = "cluster-power-down";
 				arm,psci-suspend-param = <0x40003444>;
 				entry-latency-us = <3263>;
@@ -790,6 +784,59 @@
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD1: cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD2: cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD3: cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD4: cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD5: cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD6: cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD7: cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
+		};
+
+		CLUSTER_PD: cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
 	};
 
 	qspi_opp_table: opp-table-qspi {
@@ -5283,6 +5330,7 @@
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
-- 
2.17.1

