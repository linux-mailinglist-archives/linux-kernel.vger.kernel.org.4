Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4875F1954
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiJADLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiJADHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B74DD346;
        Fri, 30 Sep 2022 20:07:19 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2912gWPJ024311;
        Sat, 1 Oct 2022 03:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=alFR7iOVLCnTvfLTSQt8bXQiwXcQpDECjWx0pLV0QXo=;
 b=oRDWHwIVdoV5JjsMPUCe+cObOgtWmQcIoJEJBp2UVuECH8OfrCvV5f7U3gdK8rpwNtG3
 idigY2FAalEvVZ3bFOY9qSJ8rp3PcpJ0KJk+iQ9flKc71F7caN8PnZbiYtIAR6+N4Zkg
 cx5fo5LceswIS2RAgn8iqXz+Dw/eaGu45EEJHPavSN5q8w/tfMqI+UrrSXw7ldTUW6yg
 PtviTfdIOw8aNmA8s70VN5RHoDFtgqGYTVtxLhOuu8yLGk7PKvREGNIevReIPaqO2Jj5
 cEfGz2eFstLvDARfcuitS0D9spvCh0CHtBmc8PNt395hBlxPKRKcqIqauzrXsnr9WR3V jQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwwfck4cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:07:17 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29137G5b031984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:07:16 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:16 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 14/19] arm64: dts: qcom: qdru1000: Add cpufreq support
Date:   Fri, 30 Sep 2022 20:06:51 -0700
Message-ID: <20221001030656.29365-15-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030656.29365-1-quic_molvera@quicinc.com>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GsNt-ce9_3dmcfSGOP-A6OU03_h9VBk5
X-Proofpoint-ORIG-GUID: GsNt-ce9_3dmcfSGOP-A6OU03_h9VBk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=820 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpufreq-epss node for the QDU1000 and QRU1000 SoCs
and add references to it from the cpu nodes.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdru1000.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
index 62a6a6e8ca59..2fd449df3706 100644
--- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
@@ -45,6 +45,7 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			power-domain-names = "psci";
 			power-domains = <&CPU_PD0>;
+			qcom,freq-domains = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -62,6 +63,7 @@ CPU1: cpu@100 {
 			enable-method = "psci";
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
+			qcom,freq-domains = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 			      compatible = "cache";
@@ -77,6 +79,7 @@ CPU2: cpu@200 {
 			enable-method = "psci";
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
+			qcom,freq-domains = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 			      compatible = "cache";
@@ -91,6 +94,7 @@ CPU3: cpu@300 {
 			enable-method = "psci";
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
+			qcom,freq-domains = <&cpufreq_hw 0>;
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 			      compatible = "cache";
@@ -246,6 +250,18 @@ uart7: serial@99c000 {
 			};
 		};
 
+		cpufreq_hw: cpufreq@17d91000 {
+			compatible = "qcom, qdu1000-cpufreq-epss", "qcom, qru1000-cpufreq-epss",
+				"qcom,cpufreq-epss";
+			reg = <0x0 0x17d91000 0x0 0x1000>;
+			reg-names = "freq-domain0";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh0_int";
+			#freq-domain-cells = <1>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x1f40000 0x0 0x20000>;
-- 
2.37.3

