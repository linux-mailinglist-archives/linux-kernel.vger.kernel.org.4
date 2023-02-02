Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6EC6880B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjBBOxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjBBOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:53:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E4A3C24;
        Thu,  2 Feb 2023 06:52:57 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312DsRF9001719;
        Thu, 2 Feb 2023 14:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=NKg+buQ61NH+8eNOC2tz/6bTj6nJ7m3J/rWhZSWO/5Q=;
 b=fN4Lgw9f5XJEGTSJ9cLpUFs1Ky9hVK92tuxeJ2IywLEyg9tkqid94nohClotUD5K4sJ0
 PbNok5Jy/MpyTwRGVvETOBVojjdh1jQcElbefCYWtkf2JHyD5xmxy9D5ho8QRT08W00R
 e1X25xei8+CaO5ien/XhQC/UPGZdQLOLYaugmUGIK5+y1VW8kMD9V3+HE+Knf7fUYNO0
 Fycae2ktvxY4pUgcjBnCJv2pKHdARXogKm2c765EGN9Vs59d7QlRu2POii3zdhchDcw/
 LVdo2+h4KX33tOZuN2mUWpg3CQxBS5gtm5XAFT8jhKMB+SiQQmt9jtCrRnDSQ8KrI4Pa wg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfqsyavex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:52:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312Eqq4e019715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 14:52:52 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 06:52:48 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 6/6] arm64: dts: qcom: ipq5332: enable the CPUFreq support
Date:   Thu, 2 Feb 2023 20:22:08 +0530
Message-ID: <20230202145208.2328032-7-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ObdVxgaFqcwL-m64ip_YkdBQkAGQvQH_
X-Proofpoint-ORIG-GUID: ObdVxgaFqcwL-m64ip_YkdBQkAGQvQH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the APCS, A53 PLL, cpu-opp-table nodes to enable the CPU frequency
above 800MHz.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 7f0ba2ec339c..483bd89817b6 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -35,6 +36,8 @@ CPU0: cpu@0 {
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU1: cpu@1 {
@@ -43,6 +46,8 @@ CPU1: cpu@1 {
 			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU2: cpu@2 {
@@ -51,6 +56,8 @@ CPU2: cpu@2 {
 			reg = <0x2>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU3: cpu@3 {
@@ -59,6 +66,8 @@ CPU3: cpu@3 {
 			reg = <0x3>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		L2_0: l2-cache {
@@ -67,6 +76,16 @@ L2_0: l2-cache {
 		};
 	};
 
+	cpu_opp_table: opp-table-cpu{
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq5332", "qcom,scm";
@@ -203,6 +222,23 @@ v2m2: v2m@2 {
 			};
 		};
 
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq5332-apcs-apps-global";
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
2.34.1

