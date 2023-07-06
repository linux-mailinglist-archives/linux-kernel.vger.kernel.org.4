Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67B74984A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjGFJYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGFJYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:24:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2881725;
        Thu,  6 Jul 2023 02:24:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36667WVm007554;
        Thu, 6 Jul 2023 09:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=0umufOmZA1MptyMAvrzeN1H8MciRvBw9A6+yixLNph0=;
 b=maSV5pWPehJGXk+LQ6YH/f8szGJ9S+2zuJOHrWxPYbdTqgNlN3iHzosEUM+GEzDcSwxU
 o+ovAIW+cBLJN74eM6h9H+K2RzSDyuBe+XiPbTasySb5JPIyEfm5KSmSQa+VGiRoDZ+U
 XoQyVFwl2oA4m0DlC7+h6NY9XpN+oijKBBKzGoDpox1Fi9jxMlr6K8nEWEXaIf4nZCYv
 sNIqhNPbp2YQiK51QhS9YBoCLmvagk3GYQzlr6MBB+F7VeIZqUkGezfoeKaXJ16BLXvD
 FEQGd8HN5KP89fBMeb5mzRwukIVKrp/PWfXcEXETrj45XTq19ioDsTP8ZgeoEaXtNY4L GQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5mftrds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 09:23:54 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3669KLuZ015099;
        Thu, 6 Jul 2023 09:23:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7ky1dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 09:23:51 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3669NoKq019315;
        Thu, 6 Jul 2023 09:23:50 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3669NoTT019310;
        Thu, 06 Jul 2023 09:23:50 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 244FA5FCC; Thu,  6 Jul 2023 14:53:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: Update the PD macros in dts
Date:   Thu,  6 Jul 2023 14:53:48 +0530
Message-Id: <1688635428-25127-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688635428-25127-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688635428-25127-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rCdGjKd3d5VyrftUPXJCwIe6ix9LdQll
X-Proofpoint-ORIG-GUID: rCdGjKd3d5VyrftUPXJCwIe6ix9LdQll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_06,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=722 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060082
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the PD macros according to the new macros.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi |   4 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi        |   8 +-
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi        |   8 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi        |  16 +--
 arch/arm64/boot/dts/qcom/msm8996.dtsi        |   8 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi        |  10 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi        |  10 +-
 arch/arm64/boot/dts/qcom/qdu1000.dtsi        |   2 +-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi        |  12 +--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi        |  94 ++++++++---------
 arch/arm64/boot/dts/qcom/sc7180.dtsi         |  88 ++++++++--------
 arch/arm64/boot/dts/qcom/sc7280.dtsi         | 126 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sc8180x.dtsi        |  22 ++--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi       | 150 +++++++++++++--------------
 arch/arm64/boot/dts/qcom/sdm630.dtsi         |  12 +--
 arch/arm64/boot/dts/qcom/sdm660.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi         |  34 +++---
 arch/arm64/boot/dts/qcom/sdm845.dtsi         |  88 ++++++++--------
 arch/arm64/boot/dts/qcom/sm6115.dtsi         |  14 +--
 arch/arm64/boot/dts/qcom/sm6125.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi         |  18 ++--
 arch/arm64/boot/dts/qcom/sm6375.dtsi         |  28 ++---
 arch/arm64/boot/dts/qcom/sm8150.dtsi         |  20 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi         |  76 +++++++-------
 arch/arm64/boot/dts/qcom/sm8350.dtsi         |  74 ++++++-------
 arch/arm64/boot/dts/qcom/sm8450.dtsi         |  36 +++----
 arch/arm64/boot/dts/qcom/sm8550.dtsi         |  28 ++---
 28 files changed, 499 insertions(+), 499 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index b1a7eaf..67f44b953 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -67,7 +67,7 @@
 		vdd_l4_l5_l6-supply = <&pm8916_s4>;
 		vdd_l7-supply = <&pm8916_s4>;
 
-		/* pm8916_s1 is managed by rpmpd (MSM8916_VDDCX) */
+		/* pm8916_s1 is managed by rpmpd (VDDCX) */
 
 		pm8916_s3: s3 {
 			regulator-min-microvolt = <1250000>;
@@ -98,7 +98,7 @@
 			regulator-always-on; /* Needed for LPDDR RAM */
 		};
 
-		/* pm8916_l3 is managed by rpmpd (MSM8916_VDDMX) */
+		/* pm8916_l3 is managed by rpmpd (VDDMX) */
 
 		l4 {};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7582c7d..24ef634 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1907,8 +1907,8 @@
 			interrupt-names = "wdog", "fatal", "ready",
 					  "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8916_VDDCX>,
-					<&rpmpd MSM8916_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
@@ -2366,8 +2366,8 @@
 					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8916_VDDCX>,
-					<&rpmpd MSM8916_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			qcom,smem-states = <&wcnss_smp2p_out 0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
index adb96cd..2cfbb7d 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -46,8 +46,8 @@
 		vdd_l4_l5_l6-supply = <&pm8916_s4>;
 		vdd_l7-supply = <&pm8916_s4>;
 
-		/* pm8916_s1 is managed by rpmpd (MSM8939_VDDMDCX) */
-		/* pm8916_s2 is managed by rpmpd (MSM8939_VDDCX) */
+		/* pm8916_s1 is managed by rpmpd (VDDMDCX) */
+		/* pm8916_s2 is managed by rpmpd (VDDCX) */
 		pm8916_s3: s3 {
 			regulator-min-microvolt = <1250000>;
 			regulator-max-microvolt = <1350000>;
@@ -76,7 +76,7 @@
 			regulator-always-on; /* Needed for LPDDR RAM */
 		};
 
-		/* pm8916_l3 is managed by rpmpd (MSM8939_VDDMX) */
+		/* pm8916_l3 is managed by rpmpd (VDDMX) */
 
 		l4 {};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 895cafc..56105df 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1538,8 +1538,8 @@
 				      "bus",
 				      "mem",
 				      "xo";
-			power-domains = <&rpmpd MSM8939_VDDMDCX>,
-					<&rpmpd MSM8939_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDMDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 			qcom,smem-states = <&hexagon_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
@@ -1956,8 +1956,8 @@
 
 			memory-region = <&wcnss_mem>;
 
-			power-domains = <&rpmpd MSM8939_VDDCX>,
-					<&rpmpd MSM8939_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			qcom,smem-states = <&wcnss_smp2p_out 0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index b711cf9..a713c2a 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1071,9 +1071,9 @@
 			interrupt-names = "wdog", "fatal", "ready",
 					  "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8953_VDDCX>,
-					<&rpmpd MSM8953_VDDMX>,
-					<&rpmpd MSM8953_VDDMD>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>,
+					<&rpmpd RPMPD_VDDMD>;
 			power-domain-names = "cx", "mx","mss";
 
 			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
@@ -1175,7 +1175,7 @@
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 
-			power-domains = <&rpmpd MSM8953_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			operating-points-v2 = <&sdhc1_opp_table>;
 
 			pinctrl-names = "default", "sleep";
@@ -1235,7 +1235,7 @@
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 
-			power-domains = <&rpmpd MSM8953_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			pinctrl-names = "default", "sleep";
@@ -1487,8 +1487,8 @@
 					      <&smp2p_wcnss_in 3 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
-			power-domains = <&rpmpd MSM8953_VDDCX>,
-					<&rpmpd MSM8953_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			qcom,smem-states = <&smp2p_wcnss_out 0>;
@@ -1624,7 +1624,7 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd MSM8953_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			memory-region = <&adsp_fw_mem>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0cb2d4f0..e8efca1 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2410,7 +2410,7 @@
 			qcom,smem-states = <&slpi_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			power-domains = <&rpmpd MSM8996_VDDSSCX>;
+			power-domains = <&rpmpd RPMPD_VDDSSCX>;
 			power-domain-names = "ssc_cx";
 
 			status = "disabled";
@@ -2456,8 +2456,8 @@
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";
 
-			power-domains = <&rpmpd MSM8996_VDDCX>,
-					<&rpmpd MSM8996_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			qcom,smem-states = <&mpss_smp2p_out 0>;
@@ -3410,7 +3410,7 @@
 			qcom,smem-states = <&adsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			power-domains = <&rpmpd MSM8996_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0e943f..a89a32b 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1444,8 +1444,8 @@
 
 			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
 
-			power-domains = <&rpmpd MSM8998_VDDCX>,
-					<&rpmpd MSM8998_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>,
+					<&rpmpd RPMPD_VDDMX>;
 			power-domain-names = "cx", "mx";
 
 			status = "disabled";
@@ -1491,7 +1491,7 @@
 			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
 			iommus = <&adreno_smmu 0>;
 			operating-points-v2 = <&gpu_opp_table>;
-			power-domains = <&rpmpd MSM8998_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDMX>;
 			status = "disabled";
 
 			gpu_opp_table: opp-table {
@@ -1602,7 +1602,7 @@
 			qcom,smem-states = <&slpi_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			power-domains = <&rpmpd MSM8998_SSCCX>;
+			power-domains = <&rpmpd RPMPD_SSCCX>;
 			power-domain-names = "ssc_cx";
 
 			status = "disabled";
@@ -2786,7 +2786,7 @@
 			qcom,smem-states = <&adsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			power-domains = <&rpmpd MSM8998_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 0ed11e8..85c5eaf 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -724,7 +724,7 @@
 
 			resets = <&gcc GCC_SDCC1_BCR>;
 
-			power-domains = <&rpmpd QCM2290_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			iommus = <&apps_smmu 0xc0 0x0>;
 
 			qcom,dll-config = <0x000f642c>;
@@ -752,7 +752,7 @@
 
 			resets = <&gcc GCC_SDCC2_BCR>;
 
-			power-domains = <&rpmpd QCM2290_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			iommus = <&apps_smmu 0xa0 0x0>;
 
@@ -1095,7 +1095,7 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd QCM2290_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			memory-region = <&pil_modem_mem>;
 
@@ -1130,8 +1130,8 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd QCM2290_VDD_LPI_CX>,
-					<&rpmpd QCM2290_VDD_LPI_MX>;
+			power-domains = <&rpmpd RPMPD_LPI_CX>,
+					<&rpmpd RPMPD_LPI_MX>;
 
 			memory-region = <&pil_adsp_mem>;
 
diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 1c0e5d2..c84a7be 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -874,7 +874,7 @@
 			interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr", "cpu-sdhc";
-			power-domains = <&rpmhpd QDU1000_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc1_opp_table>;
 
 			iommus = <&apps_smmu 0x80 0x0>;
diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
index ffb7ab6..3cc27c4 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -10,24 +10,24 @@
 #include "sm8150.dtsi"
 
 &dispcc {
-	power-domains = <&rpmhpd SA8155P_CX>;
+	power-domains = <&rpmhpd RPMHPD_CX>;
 };
 
 &mdss_dsi0 {
-	power-domains = <&rpmhpd SA8155P_CX>;
+	power-domains = <&rpmhpd RPMHPD_CX>;
 };
 
 &mdss_dsi1 {
-	power-domains = <&rpmhpd SA8155P_CX>;
+	power-domains = <&rpmhpd RPMHPD_CX>;
 };
 
 &mdss_mdp {
-	power-domains = <&rpmhpd SA8155P_CX>;
+	power-domains = <&rpmhpd RPMHPD_CX>;
 };
 
 &remoteproc_slpi {
-	power-domains = <&rpmhpd SA8155P_CX>,
-			<&rpmhpd SA8155P_MX>;
+	power-domains = <&rpmhpd RPMHPD_CX>,
+			<&rpmhpd RPMHPD_MX>;
 };
 
 &rpmhpd {
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index b130136..febc9db 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -486,7 +486,7 @@
 				 <0>,
 				 <0>,
 				 <0>;
-			power-domains = <&rpmhpd SA8775P_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 		};
 
 		ipcc: mailbox@408000 {
@@ -527,7 +527,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -548,7 +548,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -569,7 +569,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -590,7 +590,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -611,7 +611,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -630,7 +630,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -653,7 +653,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -674,7 +674,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -689,7 +689,7 @@
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
 				interconnect-names = "qup-core", "qup-config";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -708,7 +708,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -731,7 +731,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -752,7 +752,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -773,7 +773,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -794,7 +794,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -815,7 +815,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 		};
@@ -849,7 +849,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -870,7 +870,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -891,7 +891,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -912,7 +912,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -933,7 +933,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -954,7 +954,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -975,7 +975,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -996,7 +996,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1017,7 +1017,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1038,7 +1038,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1059,7 +1059,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1080,7 +1080,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1095,7 +1095,7 @@
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>;
 				interconnect-names = "qup-core", "qup-config";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 		};
@@ -1129,7 +1129,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1150,7 +1150,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1171,7 +1171,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1192,7 +1192,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1213,7 +1213,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1234,7 +1234,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1249,7 +1249,7 @@
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
 				interconnect-names = "qup-core", "qup-config";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1270,7 +1270,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1291,7 +1291,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1306,7 +1306,7 @@
 						 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0
 						 &config_noc SLAVE_QUP_1 0>;
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
@@ -1328,7 +1328,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1349,7 +1349,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1370,7 +1370,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1391,7 +1391,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1406,7 +1406,7 @@
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
 				interconnect-names = "qup-core", "qup-config";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1427,7 +1427,7 @@
 				interconnect-names = "qup-core",
 						     "qup-config",
 						     "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 		};
@@ -1461,7 +1461,7 @@
 				interconnect-names = "qup-core",
 							 "qup-config",
 							 "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 
@@ -1482,7 +1482,7 @@
 				interconnect-names = "qup-core",
 							 "qup-config",
 							 "qup-memory";
-				power-domains = <&rpmhpd SA8775P_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e25dc2b..669f0ad 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -726,7 +726,7 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			power-domains = <&rpmhpd SC7180_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 		};
 
 		qfprom: efuse@784000 {
@@ -770,7 +770,7 @@
 			interconnects = <&aggre1_noc MASTER_EMMC 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_EMMC_CFG 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
-			power-domains = <&rpmhpd SC7180_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc1_opp_table>;
 
 			bus-width = <8>;
@@ -830,7 +830,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -845,7 +845,7 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -861,7 +861,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -884,7 +884,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -899,7 +899,7 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -915,7 +915,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -938,7 +938,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -951,7 +951,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -974,7 +974,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -989,7 +989,7 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -1005,7 +1005,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -1028,7 +1028,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1041,7 +1041,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_default>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -1064,7 +1064,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1079,7 +1079,7 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -1095,7 +1095,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
@@ -1131,7 +1131,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1146,7 +1146,7 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1162,7 +1162,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1185,7 +1185,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1198,7 +1198,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1221,7 +1221,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1236,7 +1236,7 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1252,7 +1252,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1275,7 +1275,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1288,7 +1288,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1311,7 +1311,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1326,7 +1326,7 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1342,7 +1342,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1365,7 +1365,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				status = "disabled";
 			};
@@ -1380,7 +1380,7 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1396,7 +1396,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
@@ -1993,9 +1993,9 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC7180_CX>,
-					<&rpmhpd SC7180_MX>,
-					<&rpmhpd SC7180_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mx", "mss";
 
 			memory-region = <&mpss_mem>;
@@ -2671,7 +2671,7 @@
 			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
-			power-domains = <&rpmhpd SC7180_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			bus-width = <4>;
@@ -2710,7 +2710,7 @@
 			interconnects = <&gem_noc MASTER_APPSS_PROC 0
 					&config_noc SLAVE_QSPI_0 0>;
 			interconnect-names = "qspi-config";
-			power-domains = <&rpmhpd SC7180_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";
 		};
@@ -2862,7 +2862,7 @@
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc VENUS_GDSC>,
 					<&videocc VCODEC0_GDSC>,
-					<&rpmhpd SC7180_CX>;
+					<&rpmhpd RPMHPD_CX>;
 			power-domain-names = "venus", "vcodec0", "cx";
 			operating-points-v2 = <&venus_opp_table>;
 			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
@@ -2993,7 +2993,7 @@
 						       <19200000>,
 						       <19200000>;
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -3068,7 +3068,7 @@
 				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -3161,7 +3161,7 @@
 				phy-names = "dp";
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SC7180_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				#sound-dai-cells = <0>;
 
@@ -3681,7 +3681,7 @@
 			clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "iface", "bi_tcxo";
-			power-domains = <&rpmhpd SC7180_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index a0e8db8..723c82a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -878,7 +878,7 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			power-domains = <&rpmhpd SC7280_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 		};
 
 		ipcc: mailbox@408000 {
@@ -898,7 +898,7 @@
 			      <0 0x00786000 0 0x1fff>;
 			clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
 			clock-names = "core";
-			power-domains = <&rpmhpd SC7280_MX>;
+			power-domains = <&rpmhpd RPMHPD_MX>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
@@ -931,7 +931,7 @@
 			interconnects = <&aggre1_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_1 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
-			power-domains = <&rpmhpd SC7280_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc1_opp_table>;
 
 			bus-width = <8>;
@@ -1015,7 +1015,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
@@ -1033,7 +1033,7 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1052,7 +1052,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_cts>, <&qup_uart0_rts>, <&qup_uart0_tx>, <&qup_uart0_rx>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1075,7 +1075,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
@@ -1093,7 +1093,7 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1112,7 +1112,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_cts>, <&qup_uart1_rts>, <&qup_uart1_tx>, <&qup_uart1_rx>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1135,7 +1135,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
@@ -1153,7 +1153,7 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1172,7 +1172,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_cts>, <&qup_uart2_rts>, <&qup_uart2_tx>, <&qup_uart2_rx>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1195,7 +1195,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
@@ -1213,7 +1213,7 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1232,7 +1232,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_cts>, <&qup_uart3_rts>, <&qup_uart3_tx>, <&qup_uart3_rx>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1255,7 +1255,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
@@ -1273,7 +1273,7 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1292,7 +1292,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_cts>, <&qup_uart4_rts>, <&qup_uart4_tx>, <&qup_uart4_rx>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1315,7 +1315,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
@@ -1333,7 +1333,7 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1352,7 +1352,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_cts>, <&qup_uart5_rts>, <&qup_uart5_tx>, <&qup_uart5_rx>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1375,7 +1375,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
@@ -1393,7 +1393,7 @@
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1412,7 +1412,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_cts>, <&qup_uart6_rts>, <&qup_uart6_tx>, <&qup_uart6_rx>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1435,7 +1435,7 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
@@ -1453,7 +1453,7 @@
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1472,7 +1472,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_cts>, <&qup_uart7_rts>, <&qup_uart7_tx>, <&qup_uart7_rx>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
@@ -1530,7 +1530,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
@@ -1548,7 +1548,7 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1567,7 +1567,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_cts>, <&qup_uart8_rts>, <&qup_uart8_tx>, <&qup_uart8_rx>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1590,7 +1590,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
@@ -1608,7 +1608,7 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1627,7 +1627,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_cts>, <&qup_uart9_rts>, <&qup_uart9_tx>, <&qup_uart9_rx>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1650,7 +1650,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
@@ -1668,7 +1668,7 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1687,7 +1687,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_cts>, <&qup_uart10_rts>, <&qup_uart10_tx>, <&qup_uart10_rx>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1710,7 +1710,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
@@ -1728,7 +1728,7 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1747,7 +1747,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_cts>, <&qup_uart11_rts>, <&qup_uart11_tx>, <&qup_uart11_rx>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1770,7 +1770,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
@@ -1788,7 +1788,7 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1807,7 +1807,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart12_cts>, <&qup_uart12_rts>, <&qup_uart12_tx>, <&qup_uart12_rx>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1830,7 +1830,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
@@ -1848,7 +1848,7 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1867,7 +1867,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart13_cts>, <&qup_uart13_rts>, <&qup_uart13_tx>, <&qup_uart13_rx>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1890,7 +1890,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
@@ -1908,7 +1908,7 @@
 				interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1927,7 +1927,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart14_cts>, <&qup_uart14_rts>, <&qup_uart14_tx>, <&qup_uart14_rx>;
 				interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1950,7 +1950,7 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
@@ -1968,7 +1968,7 @@
 				interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -1987,7 +1987,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart15_cts>, <&qup_uart15_rts>, <&qup_uart15_tx>, <&qup_uart15_rx>;
 				interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
@@ -2449,7 +2449,7 @@
 				 <&apps_smmu 0x1821 0>,
 				 <&apps_smmu 0x1832 0>;
 
-			power-domains =	<&rpmhpd SC7280_LCX>;
+			power-domains =	<&rpmhpd RPMHPD_LCX>;
 			power-domain-names = "lcx";
 			required-opps = <&rpmhpd_opp_nom>;
 
@@ -2758,8 +2758,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC7280_CX>,
-					<&rpmhpd SC7280_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
@@ -3292,7 +3292,7 @@
 			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
-			power-domains = <&rpmhpd SC7280_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			bus-width = <4>;
@@ -3464,7 +3464,7 @@
 			interconnects = <&gem_noc MASTER_APPSS_PROC 0
 					&cnoc2 SLAVE_QSPI_0 0>;
 			interconnect-names = "qspi-config";
-			power-domains = <&rpmhpd SC7280_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";
 		};
@@ -3489,8 +3489,8 @@
 			clock-names = "ahb_bdg", "ahb",
 				      "rscp", "xo";
 
-			power-domains = <&rpmhpd SC7280_CX>,
-					<&rpmhpd SC7280_MX>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>;
 			power-domain-names = "cx", "mx";
 
 			memory-region = <&wpss_mem>;
@@ -3723,7 +3723,7 @@
 
 			power-domains = <&videocc MVSC_GDSC>,
 					<&videocc MVS0_GDSC>,
-					<&rpmhpd SC7280_CX>;
+					<&rpmhpd RPMHPD_CX>;
 			power-domain-names = "venus", "vcodec0", "cx";
 			operating-points-v2 = <&venus_opp_table>;
 
@@ -3876,7 +3876,7 @@
 				assigned-clock-rates = <19200000>,
 							<19200000>;
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -3958,7 +3958,7 @@
 				assigned-clock-parents = <&mdss_dsi_phy 0>, <&mdss_dsi_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				phys = <&mdss_dsi_phy>;
 
@@ -4055,7 +4055,7 @@
 				phy-names = "dp";
 
 				operating-points-v2 = <&edp_opp_table>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				status = "disabled";
 
@@ -4149,7 +4149,7 @@
 				phy-names = "dp";
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SC7280_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				#sound-dai-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index d3ae185..9677f4c 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2363,8 +2363,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8180X_CX>,
-					<&rpmhpd SC8180X_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			qcom,qmp = <&aoss_qmp>;
@@ -2395,7 +2395,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8180X_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			power-domain-names = "cx";
 
 			qcom,qmp = <&aoss_qmp>;
@@ -2714,7 +2714,7 @@
 						       <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SC8180X_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
@@ -2806,7 +2806,7 @@
 					      "bus";
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SC8180X_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 				phy-names = "dsi";
@@ -2892,7 +2892,7 @@
 					      "bus";
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SC8180X_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 				phy-names = "dsi";
@@ -2966,7 +2966,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp0_opp_table>;
-				power-domains = <&rpmhpd SC8180X_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -3040,7 +3040,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp0_opp_table>;
-				power-domains = <&rpmhpd SC8180X_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -3114,7 +3114,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&edp_opp_table>;
-				power-domains = <&rpmhpd SC8180X_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -3192,7 +3192,7 @@
 				      "dptx1_phy_pll_vco_div_clk",
 				      "edp_phy_pll_link_clk",
 				      "edp_phy_pll_vco_div_clk";
-			power-domains = <&rpmhpd SC8180X_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -3388,7 +3388,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8180X_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			power-domain-names = "cx";
 
 			qcom,qmp = <&aoss_qmp>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index ac0596d..5352550 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -848,7 +848,7 @@
 				 <&pcie4_phy>,
 				 <0>,
 				 <0>;
-			power-domains = <&rpmhpd SC8280XP_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 		};
 
 		ipcc: mailbox@408000 {
@@ -882,7 +882,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -898,7 +898,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -914,7 +914,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -930,7 +930,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -945,7 +945,7 @@
 				clock-names = "se";
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
@@ -960,7 +960,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -976,7 +976,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -992,7 +992,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1008,7 +1008,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1024,7 +1024,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1040,7 +1040,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1056,7 +1056,7 @@
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1072,7 +1072,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1088,7 +1088,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1104,7 +1104,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1120,7 +1120,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
 				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1136,7 +1136,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
 				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
@@ -1167,7 +1167,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1183,7 +1183,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1199,7 +1199,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1215,7 +1215,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1231,7 +1231,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1247,7 +1247,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1262,7 +1262,7 @@
 				clock-names = "se";
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
@@ -1277,7 +1277,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1293,7 +1293,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1309,7 +1309,7 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1325,7 +1325,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1341,7 +1341,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1357,7 +1357,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1373,7 +1373,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1389,7 +1389,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1405,7 +1405,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1421,7 +1421,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
@@ -1452,7 +1452,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1468,7 +1468,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1484,7 +1484,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1500,7 +1500,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1516,7 +1516,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1532,7 +1532,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1548,7 +1548,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1564,7 +1564,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1580,7 +1580,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1596,7 +1596,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1612,7 +1612,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1628,7 +1628,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1644,7 +1644,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1660,7 +1660,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1676,7 +1676,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -1692,7 +1692,7 @@
 				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
 				clock-names = "se";
 				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
 				                <&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
@@ -2470,7 +2470,7 @@
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
 
-			power-domains = <&rpmhpd SC8280XP_GFX>;
+			power-domains = <&rpmhpd RPMHPD_GFX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -2645,8 +2645,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_LCX>,
-					<&rpmhpd SC8280XP_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_adsp_mem>;
@@ -3071,7 +3071,7 @@
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			iommus = <&apps_smmu 0x4e0 0x0>;
-			power-domains = <&rpmhpd SC8280XP_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdc2_opp_table>;
 			bus-width = <4>;
 			dma-coherent;
@@ -3199,7 +3199,7 @@
 			clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
 				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
-			power-domains = <&rpmhpd SC8280XP_MX>;
+			power-domains = <&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
@@ -3217,7 +3217,7 @@
 			clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
 				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
-			power-domains = <&rpmhpd SC8280XP_MX>;
+			power-domains = <&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
@@ -3496,7 +3496,7 @@
 					      "vsync";
 				interrupt-parent = <&mdss0>;
 				interrupts = <0>;
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <19200000>;
@@ -3594,7 +3594,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&mdss0_dp0_opp_table>;
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -3672,7 +3672,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&mdss0_dp1_opp_table>;
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -3741,7 +3741,7 @@
 				interrupts = <14>;
 				phys = <&mdss0_dp2_phy>;
 				phy-names = "dp";
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
 						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
@@ -3813,7 +3813,7 @@
 				interrupts = <15>;
 				phys = <&mdss0_dp3_phy>;
 				phy-names = "dp";
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
 						  <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
@@ -3876,7 +3876,7 @@
 			clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
 				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
-			power-domains = <&rpmhpd SC8280XP_MX>;
+			power-domains = <&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
@@ -3894,7 +3894,7 @@
 			clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
 				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
-			power-domains = <&rpmhpd SC8280XP_MX>;
+			power-domains = <&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
@@ -3921,7 +3921,7 @@
 				 <0>,
 				 <0>,
 				 <0>;
-			power-domains = <&rpmhpd SC8280XP_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
@@ -4400,7 +4400,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
+			power-domains = <&rpmhpd RPMHPD_NSP>;
 			power-domain-names = "nsp";
 
 			memory-region = <&pil_nsp0_mem>;
@@ -4531,7 +4531,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
+			power-domains = <&rpmhpd RPMHPD_NSP>;
 			power-domain-names = "nsp";
 
 			memory-region = <&pil_nsp1_mem>;
@@ -4603,7 +4603,7 @@
 					      "vsync";
 				interrupt-parent = <&mdss1>;
 				interrupts = <0>;
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <19200000>;
@@ -4691,7 +4691,7 @@
 				interrupts = <12>;
 				phys = <&mdss1_dp0_phy>;
 				phy-names = "dp";
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
 						  <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
@@ -4763,7 +4763,7 @@
 				interrupts = <13>;
 				phys = <&mdss1_dp1_phy>;
 				phy-names = "dp";
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
 						  <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
@@ -4835,7 +4835,7 @@
 				interrupts = <14>;
 				phys = <&mdss1_dp2_phy>;
 				phy-names = "dp";
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
 						  <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
@@ -4907,7 +4907,7 @@
 				interrupts = <15>;
 				phys = <&mdss1_dp3_phy>;
 				phy-names = "dp";
-				power-domains = <&rpmhpd SC8280XP_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
 						  <&dispcc1 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
@@ -4970,7 +4970,7 @@
 			clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
 				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
-			power-domains = <&rpmhpd SC8280XP_MX>;
+			power-domains = <&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
@@ -4988,7 +4988,7 @@
 			clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_AUX_CLK>,
 				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
 			clock-names = "aux", "cfg_ahb";
-			power-domains = <&rpmhpd SC8280XP_MX>;
+			power-domains = <&rpmhpd RPMHPD_MX>;
 
 			#clock-cells = <1>;
 			#phy-cells = <0>;
@@ -5015,7 +5015,7 @@
 				 <0>,
 				 <0>,
 				 <0>;
-			power-domains = <&rpmhpd SC8280XP_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index bba0f36..9f21a62 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1046,7 +1046,7 @@
 				"rbcpr",
 				"core";
 
-			power-domains = <&rpmpd SDM660_VDDMX>;
+			power-domains = <&rpmpd RPMPD_VDDMX>;
 			iommus = <&kgsl_smmu 0>;
 
 			nvmem-cells = <&gpu_speed_bin>;
@@ -1319,7 +1319,7 @@
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc2_state_on>;
 			pinctrl-1 = <&sdc2_state_off>;
-			power-domains = <&rpmpd SDM660_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			status = "disabled";
 
@@ -1371,7 +1371,7 @@
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_state_on>;
 			pinctrl-1 = <&sdc1_state_off>;
-			power-domains = <&rpmpd SDM660_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			bus-width = <8>;
 			non-removable;
@@ -1527,7 +1527,7 @@
 						     "rotator-mem";
 				iommus = <&mmss_smmu 0>;
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmpd SDM660_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				ports {
 					#address-cells = <1>;
@@ -1579,7 +1579,7 @@
 				reg-names = "dsi_ctrl";
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmpd SDM660_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <4>;
@@ -2196,7 +2196,7 @@
 			clock-names = "xo";
 
 			memory-region = <&adsp_region>;
-			power-domains = <&rpmpd SDM660_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			qcom,smem-states = <&adsp_smp2p_out 0>;
diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
index f89b27c..8d0570d 100644
--- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
@@ -163,7 +163,7 @@
 
 		/* DSI1 shares the OPP table with DSI0 */
 		operating-points-v2 = <&dsi_opp_table>;
-		power-domains = <&rpmpd SDM660_VDDCX>;
+		power-domains = <&rpmpd RPMPD_VDDCX>;
 
 		interrupt-parent = <&mdss>;
 		interrupts = <5>;
diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index a1c207c..93d0b0d 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -459,7 +459,7 @@
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_state_on>;
 			pinctrl-1 = <&sdc1_state_off>;
-			power-domains = <&rpmhpd SDM670_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 
 			bus-width = <8>;
 			non-removable;
@@ -546,7 +546,7 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -567,7 +567,7 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -588,7 +588,7 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -609,7 +609,7 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -630,7 +630,7 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -651,7 +651,7 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -672,7 +672,7 @@
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -693,7 +693,7 @@
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre1_noc MASTER_BLSP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_BLSP_1 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -752,7 +752,7 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -773,7 +773,7 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -794,7 +794,7 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -815,7 +815,7 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -836,7 +836,7 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -857,7 +857,7 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -878,7 +878,7 @@
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
@@ -899,7 +899,7 @@
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM670_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&aggre2_noc MASTER_BLSP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_BLSP_2 0 &mem_noc SLAVE_EBI_CH0 0>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 02a6ea0..51950d6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1280,7 +1280,7 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
@@ -1319,7 +1319,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1337,7 +1337,7 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
@@ -1376,7 +1376,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1394,7 +1394,7 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
@@ -1433,7 +1433,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1451,7 +1451,7 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
@@ -1490,7 +1490,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1508,7 +1508,7 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
@@ -1547,7 +1547,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_default>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1565,7 +1565,7 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
@@ -1604,7 +1604,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1622,7 +1622,7 @@
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
@@ -1661,7 +1661,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1679,7 +1679,7 @@
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1711,7 +1711,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
@@ -1767,7 +1767,7 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
@@ -1806,7 +1806,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -1824,7 +1824,7 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
@@ -1863,7 +1863,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -1881,7 +1881,7 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
@@ -1920,7 +1920,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -1938,7 +1938,7 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
@@ -1977,7 +1977,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -1995,7 +1995,7 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
@@ -2034,7 +2034,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart12_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -2052,7 +2052,7 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
@@ -2091,7 +2091,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart13_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -2109,7 +2109,7 @@
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
@@ -2148,7 +2148,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart14_default>;
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -2166,7 +2166,7 @@
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
@@ -2205,7 +2205,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart15_default>;
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
@@ -3300,9 +3300,9 @@
 
 			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
 
-			power-domains = <&rpmhpd SDM845_CX>,
-					<&rpmhpd SDM845_MX>,
-					<&rpmhpd SDM845_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mx", "mss";
 
 			status = "disabled";
@@ -3358,8 +3358,8 @@
 
 			qcom,qmp = <&aoss_qmp>;
 
-			power-domains = <&rpmhpd SDM845_CX>,
-					<&rpmhpd SDM845_MX>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
@@ -3866,7 +3866,7 @@
 				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "iface", "core", "xo";
 			iommus = <&apps_smmu 0xa0 0xf>;
-			power-domains = <&rpmhpd SDM845_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			status = "disabled";
@@ -3906,7 +3906,7 @@
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			power-domains = <&rpmhpd SDM845_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
 			status = "disabled";
 		};
@@ -4164,7 +4164,7 @@
 			power-domains = <&videocc VENUS_GDSC>,
 					<&videocc VCODEC0_GDSC>,
 					<&videocc VCODEC1_GDSC>,
-					<&rpmhpd SDM845_CX>;
+					<&rpmhpd RPMHPD_CX>;
 			power-domain-names = "venus", "vcodec0", "vcodec1", "cx";
 			operating-points-v2 = <&venus_opp_table>;
 			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
@@ -4491,7 +4491,7 @@
 				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <19200000>;
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -4574,7 +4574,7 @@
 				phy-names = "dp";
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				ports {
 					#address-cells = <1>;
@@ -4642,7 +4642,7 @@
 				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -4714,7 +4714,7 @@
 				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SDM845_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 
 				phys = <&mdss_dsi1_phy>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 5511857..c699523 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -948,7 +948,7 @@
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 
-			power-domains = <&rpmpd SM6115_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			iommus = <&apps_smmu 0x00a0 0x0>;
 			resets = <&gcc GCC_SDCC2_BCR>;
@@ -1397,7 +1397,7 @@
 					      "vsync";
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmpd SM6115_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -1470,7 +1470,7 @@
 				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmpd SM6115_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				phys = <&mdss_dsi0_phy>;
 
 				#address-cells = <1>;
@@ -1565,7 +1565,7 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd SM6115_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			memory-region = <&pil_modem_mem>;
 
@@ -2209,8 +2209,8 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd SM6115_VDD_LPI_CX>,
-					<&rpmpd SM6115_VDD_LPI_MX>;
+			power-domains = <&rpmpd RPMPD_LPI_CX>,
+					<&rpmpd RPMPD_LPI_MX>;
 
 			memory-region = <&pil_adsp_mem>;
 
@@ -2281,7 +2281,7 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd SM6115_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			memory-region = <&pil_cdsp_mem>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index a596baa..db7497f 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -699,7 +699,7 @@
 			clock-names = "iface", "core", "xo";
 			iommus = <&apps_smmu 0x160 0x0>;
 
-			power-domains = <&rpmpd SM6125_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			qcom,dll-config = <0x000f642c>;
 			qcom,ddr-config = <0x80040873>;
@@ -730,7 +730,7 @@
 			pinctrl-1 = <&sdc2_off_state>;
 			pinctrl-names = "default", "sleep";
 
-			power-domains = <&rpmpd SM6125_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040873>;
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 30e7701..cb8b19b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -830,7 +830,7 @@
 			resets = <&gcc GCC_SDCC1_BCR>;
 			qcom,dll-config = <0x000f642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd SM6350_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc1_opp_table>;
 			bus-width = <8>;
 			non-removable;
@@ -918,7 +918,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_cts>, <&qup_uart1_rts>, <&qup_uart1_tx>, <&qup_uart1_rx>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM6350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
@@ -1256,8 +1256,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM6350_LCX>,
-					<&rpmhpd SM6350_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_adsp_mem>;
@@ -1324,8 +1324,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM6350_CX>,
-					<&rpmhpd SM6350_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&pil_modem_mem>;
@@ -1363,8 +1363,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM6350_CX>,
-					<&rpmhpd SM6350_MX>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>;
 			power-domain-names = "cx", "mx";
 
 			memory-region = <&pil_cdsp_mem>;
@@ -1470,7 +1470,7 @@
 
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd SM6350_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			bus-width = <4>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 3dba342..856e551 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -861,7 +861,7 @@
 
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmpd SM6375_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			bus-width = <4>;
 
@@ -938,7 +938,7 @@
 				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi0_default>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
@@ -970,7 +970,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
@@ -1002,7 +1002,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
@@ -1073,7 +1073,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
@@ -1103,7 +1103,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				interrupts = <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
@@ -1135,7 +1135,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				interrupts = <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
@@ -1165,7 +1165,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				interrupts = <GIC_SPI 510 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
@@ -1197,7 +1197,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				interrupts = <GIC_SPI 511 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmpd SM6375_VDDCX>;
+				power-domains = <&rpmpd RPMPD_VDDCX>;
 				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
@@ -1306,7 +1306,7 @@
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>,
 				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
-			power-domains = <&rpmpd SM6375_VDDGX>;
+			power-domains = <&rpmpd RPMPD_VDDGX>;
 			required-opps = <&rpmpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -1333,7 +1333,7 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd SM6375_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			memory-region = <&pil_mpss_wlan_mem>;
@@ -1369,8 +1369,8 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd SM6375_VDD_LPI_CX>,
-					<&rpmpd SM6375_VDD_LPI_MX>;
+			power-domains = <&rpmpd RPMPD_LPI_CX>,
+					<&rpmpd RPMPD_LPI_MX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_adsp_mem>;
@@ -1407,7 +1407,7 @@
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
-			power-domains = <&rpmpd SM6375_VDDCX>;
+			power-domains = <&rpmpd RPMPD_VDDCX>;
 			power-domain-names = "cx";
 
 			memory-region = <&pil_cdsp_mem>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 18c822a..9182c31 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2150,8 +2150,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8150_LCX>,
-					<&rpmhpd SM8150_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
@@ -2703,8 +2703,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8150_CX>,
-					<&rpmhpd SM8150_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
@@ -3330,7 +3330,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8150_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 
 			memory-region = <&cdsp_mem>;
 
@@ -3716,7 +3716,7 @@
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SM8150_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -3792,7 +3792,7 @@
 							 <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SM8150_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -3885,7 +3885,7 @@
 							 <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SM8150_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 
@@ -3950,7 +3950,7 @@
 				      "dsi1_phy_pll_out_dsiclk",
 				      "dp_phy_pll_link_clk",
 				      "dp_phy_pll_vco_div_clk";
-			power-domains = <&rpmhpd SM8150_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -4123,7 +4123,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8150_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 
 			memory-region = <&adsp_mem>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 83ab6de..495f179 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1036,7 +1036,7 @@
 				dmas = <&gpi_dma2 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1068,7 +1068,7 @@
 				dmas = <&gpi_dma2 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1100,7 +1100,7 @@
 				dmas = <&gpi_dma2 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1132,7 +1132,7 @@
 				dmas = <&gpi_dma2 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1147,7 +1147,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart17_default>;
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1177,7 +1177,7 @@
 				dmas = <&gpi_dma2 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1192,7 +1192,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart18_default>;
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1222,7 +1222,7 @@
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1290,7 +1290,7 @@
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1322,7 +1322,7 @@
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1354,7 +1354,7 @@
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1369,7 +1369,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1399,7 +1399,7 @@
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1431,7 +1431,7 @@
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1463,7 +1463,7 @@
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1495,7 +1495,7 @@
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1510,7 +1510,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1540,7 +1540,7 @@
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1605,7 +1605,7 @@
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1637,7 +1637,7 @@
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1669,7 +1669,7 @@
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1701,7 +1701,7 @@
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1733,7 +1733,7 @@
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1748,7 +1748,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart12_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1778,7 +1778,7 @@
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -2743,8 +2743,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8250_LCX>,
-					<&rpmhpd SM8250_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
@@ -3463,7 +3463,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8250_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 
 			memory-region = <&cdsp_mem>;
 
@@ -3660,7 +3660,7 @@
 			iommus = <&apps_smmu 0x4a0 0x0>;
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd SM8250_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			status = "disabled";
@@ -3836,7 +3836,7 @@
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc MVS0C_GDSC>,
 					<&videocc MVS0_GDSC>,
-					<&rpmhpd SM8250_MX>;
+					<&rpmhpd RPMHPD_MX>;
 			power-domain-names = "venus", "vcodec0", "mx";
 			operating-points-v2 = <&venus_opp_table>;
 
@@ -3897,7 +3897,7 @@
 			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>;
-			power-domains = <&rpmhpd SM8250_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao";
 			#clock-cells = <1>;
@@ -4177,7 +4177,7 @@
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
 			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
-			power-domains = <&rpmhpd SM8250_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			status = "disabled";
 			#clock-cells = <1>;
@@ -4230,7 +4230,7 @@
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -4305,7 +4305,7 @@
 				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -4397,7 +4397,7 @@
 				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 
@@ -4448,7 +4448,7 @@
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sm8250-dispcc";
 			reg = <0 0x0af00000 0 0x10000>;
-			power-domains = <&rpmhpd SM8250_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&mdss_dsi0_phy 0>,
@@ -5413,8 +5413,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8250_LCX>,
-					<&rpmhpd SM8250_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&adsp_mem>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 88ef478..db89c6e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -737,7 +737,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_120mhz>;
 				dmas = <&gpi_dma2 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 0 QCOM_GPI_SPI>;
@@ -769,7 +769,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_120mhz>;
 				dmas = <&gpi_dma2 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 1 QCOM_GPI_SPI>;
@@ -801,7 +801,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 2 QCOM_GPI_SPI>;
@@ -833,7 +833,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 3 QCOM_GPI_SPI>;
@@ -851,7 +851,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 4 QCOM_GPI_SPI>;
@@ -869,7 +869,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart18_default>;
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
@@ -896,7 +896,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
@@ -963,7 +963,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
@@ -995,7 +995,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
@@ -1027,7 +1027,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
@@ -1045,7 +1045,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default_state>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
@@ -1058,7 +1058,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
@@ -1090,7 +1090,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
@@ -1122,7 +1122,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
@@ -1154,7 +1154,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
@@ -1172,7 +1172,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
@@ -1199,7 +1199,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
@@ -1266,7 +1266,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_120mhz>;
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
@@ -1298,7 +1298,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
@@ -1330,7 +1330,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
@@ -1362,7 +1362,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
@@ -1394,7 +1394,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
@@ -1426,7 +1426,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
@@ -2003,8 +2003,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_CX>,
-					<&rpmhpd SM8350_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
@@ -2044,8 +2044,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_LCX>,
-					<&rpmhpd SM8350_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_slpi_mem>;
@@ -2114,7 +2114,7 @@
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			iommus = <&apps_smmu 0x4a0 0x0>;
-			power-domains = <&rpmhpd SM8350_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			bus-width = <4>;
 			dma-coherent;
@@ -2475,7 +2475,7 @@
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&dpu_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -2538,7 +2538,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -2606,7 +2606,7 @@
 							 <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi0_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -2704,7 +2704,7 @@
 							 <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&dsi1_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 
@@ -2795,7 +2795,7 @@
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 
-			power-domains = <&rpmhpd SM8350_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 		};
 
 		pdc: interrupt-controller@b220000 {
@@ -3188,8 +3188,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_LCX>,
-					<&rpmhpd SM8350_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_adsp_mem>;
@@ -3417,8 +3417,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_CX>,
-					<&rpmhpd SM8350_MXC>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>;
 			power-domain-names = "cx", "mxc";
 
 			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5cd7296..6b30d86 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1149,7 +1149,7 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
-				power-domains = <&rpmhpd SM8450_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
@@ -1312,7 +1312,7 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi4_data_clk>, <&qup_spi4_cs>;
-				power-domains = <&rpmhpd SM8450_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
@@ -2097,8 +2097,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_LCX>,
-					<&rpmhpd SM8450_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
@@ -2372,8 +2372,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_LCX>,
-					<&rpmhpd SM8450_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&adsp_mem>;
@@ -2477,8 +2477,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_CX>,
-					<&rpmhpd SM8450_MXC>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>;
 			power-domain-names = "cx", "mxc";
 
 			memory-region = <&cdsp_mem>;
@@ -2584,8 +2584,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_CX>,
-					<&rpmhpd SM8450_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
@@ -2613,7 +2613,7 @@
 			reg = <0 0x0aaf0000 0 0x10000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_VIDEO_AHB_CLK>;
-			power-domains = <&rpmhpd SM8450_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2705,7 +2705,7 @@
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd SM8450_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2767,7 +2767,7 @@
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -2859,7 +2859,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -2925,7 +2925,7 @@
 				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 				phy-names = "dsi";
@@ -3017,7 +3017,7 @@
 				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 				phy-names = "dsi";
@@ -3085,7 +3085,7 @@
 				 <0>,
 				 <0>, /* dp3 */
 				 <0>;
-			power-domains = <&rpmhpd SM8450_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -4243,7 +4243,7 @@
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			iommus = <&apps_smmu 0x4a0 0x0>;
-			power-domains = <&rpmhpd SM8450_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			bus-width = <4>;
 			dma-coherent;
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 41d60af..b44def9 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1989,8 +1989,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8550_CX>,
-					<&rpmhpd SM8550_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
@@ -2368,7 +2368,7 @@
 			iommus = <&apps_smmu 0x540 0>;
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd SM8550_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
@@ -2412,7 +2412,7 @@
 			reg = <0 0x0aaf0000 0 0x10000>;
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_VIDEO_AHB_CLK>;
-			power-domains = <&rpmhpd SM8550_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2471,7 +2471,7 @@
 					      "core",
 					      "vsync";
 
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <19200000>;
@@ -2560,7 +2560,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -2628,7 +2628,7 @@
 					      "iface",
 					      "bus";
 
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
@@ -2723,7 +2723,7 @@
 					      "iface",
 					      "bus";
 
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
@@ -2798,7 +2798,7 @@
 				 <0>,
 				 <0>, /* dp3 */
 				 <0>;
-			power-domains = <&rpmhpd SM8550_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -3933,8 +3933,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8550_LCX>,
-					<&rpmhpd SM8550_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
@@ -4065,9 +4065,9 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8550_CX>,
-					<&rpmhpd SM8550_MXC>,
-					<&rpmhpd SM8550_NSP>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_NSP>;
 			power-domain-names = "cx", "mxc", "nsp";
 
 			interconnects = <&nsp_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
-- 
2.7.4

