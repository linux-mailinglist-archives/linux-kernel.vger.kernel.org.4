Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67FB722CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjFEQaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjFEQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:29:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D16E9;
        Mon,  5 Jun 2023 09:29:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355Cg6Y9008662;
        Mon, 5 Jun 2023 16:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=6xUxlmfWo1XCW7QF3JIN02Aeg3QcbpmcklUfU5FyWWc=;
 b=JDqCcqwTdIbhsPChdWAr6BjrMvHbPKHmbuzColmWSUWBHj1T6JlkALV49aX8bnrCjBLz
 TYy+7dBllK9LmgrqHNEKMc4CB49oapLNN7jjbgQT9pz9l5bJY1Tyl+7f+fm75CI398nU
 8tylJveuEcJWarJIg/wlXMmbGuUc/hJ4fZfP/0A7+fDgmaN5GAH2Z80+aiv2zKN9O8m3
 jcUb5NPtKXsaw48093Co06uITJ87zzoIp0nF0MXo124gfJHmsX5JcOiAZfHaOsjeXAIU
 SQausj1ZGjeK4FTwypbOlLKfVwMW1f6jJv8GflYbWCk7rkbgjz6tNBFxgKAebj7Ds9jb Hg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1e9brrg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 16:29:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 355GTLBN030422;
        Mon, 5 Jun 2023 16:29:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkkq42s-1;
        Mon, 05 Jun 2023 16:29:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355GTJSN030342;
        Mon, 5 Jun 2023 16:29:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 355GTJDi030326;
        Mon, 05 Jun 2023 16:29:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E59A95F20; Mon,  5 Jun 2023 21:59:20 +0530 (+0530)
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
Subject: [PATCH v2 10/10] arm64: dts: qcom: Add the support of cpufreq on SDX75
Date:   Mon,  5 Jun 2023 21:59:17 +0530
Message-Id: <1685982557-28326-11-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: plyLN7QVquspxC1Fh7bhhIFI4jJWxdZD
X-Proofpoint-ORIG-GUID: plyLN7QVquspxC1Fh7bhhIFI4jJWxdZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 mlxlogscore=746
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050141
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of cpufreq to enable the cpufreq scaling
on SDX75 SoC. Also add CPU specific information to build
energy model for EAS.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index 47170ae..e1887a4 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -47,10 +47,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -64,10 +68,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_100>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -78,10 +86,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_200>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -92,10 +104,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
 			next-level-cache = <&L2_300>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -605,6 +621,20 @@
 			};
 
 		};
+
+		cpufreq_hw: cpufreq@17d91000 {
+			compatible = "qcom,sdx75-cpufreq-epss", "qcom,cpufreq-epss";
+			reg = <0 0x17d91000 0 0x1000>;
+			reg-names = "freq-domain0";
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GPLL0>;
+			clock-names = "xo",
+				      "alternate";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0";
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.7.4

