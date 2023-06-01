Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC17193B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFAG6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjFAG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:58:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F517A3;
        Wed, 31 May 2023 23:58:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35158YRR022577;
        Thu, 1 Jun 2023 06:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ksX52XQkyOLXrPtHRR5XkYgyP7703TmZUwHinw78i2c=;
 b=PWnju1vORMJe+u1LXyNa+HLaL4tfrKfjB9MFeTYCVJEailLgtYJS54cFezbCLr1FAOJu
 55/Qg5a5eScfWynrykBNMY97hHzb1Mru/ZCgefXDmTd/34gnBK6cPX0AWA09SG2E5aHH
 2XNx6XTsFwXYAnw+RB12wsN5rZgGOic6PkcfgUnhpqYu6vJ1UhKiGtv7ulPalgsA8x3g
 bWzOE42Swg4bfNAYovTG/EheoPjXal5yR1Qdcxn4Tcs4zNH9Tdg+fBpor10f8SKnbl7x
 /XV5A+A9JA8wQju3mNoLIRDWjyUgN6KEHxfZ1it033YRdysioTuEe44qfUMTbXRuhGJT Sg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx39d2jw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 06:58:14 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3516w9Ce022046;
        Thu, 1 Jun 2023 06:58:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3quaxm7e8c-1;
        Thu, 01 Jun 2023 06:58:10 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3516wALF022057;
        Thu, 1 Jun 2023 06:58:10 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3516wAus022055;
        Thu, 01 Jun 2023 06:58:10 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 44344529756; Thu,  1 Jun 2023 12:28:09 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/4] arm64: dts: qcom: qdu1000: Add SDHCI node
Date:   Thu,  1 Jun 2023 12:28:03 +0530
Message-Id: <20230601065805.18079-3-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
References: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xx1A3YHHR16vrl8xVrid827ypMlUialU
X-Proofpoint-ORIG-GUID: Xx1A3YHHR16vrl8xVrid827ypMlUialU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_04,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxlogscore=922 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 734438113bba..6df07334f1d3 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -842,6 +842,53 @@
 			#hwlock-cells = <1>;
 		};

+		sdhc: mmc@8804000 {
+			compatible = "qcom,qdu1000-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x08804000 0x0 0x1000>,
+			      <0x0 0x08805000 0x0 0x1000>;
+			reg-names = "hc", "cqhci";
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC5_AHB_CLK>,
+				 <&gcc GCC_SDCC5_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
+
+			resets = <&gcc GCC_SDCC5_BCR>;
+
+			interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+			power-domains = <&rpmhpd QDU1000_CX>;
+			operating-points-v2 = <&sdhc1_opp_table>;
+
+			iommus = <&apps_smmu 0x80 0x0>;
+			dma-coherent;
+
+			bus-width = <8>;
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+
+			status = "disabled";
+
+			sdhc1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <6528000 1652800>;
+					opp-avg-kBps = <400000 0>;
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
 			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
--
2.17.1

