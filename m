Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61974D3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjGJKii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjGJKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:38:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5851FB;
        Mon, 10 Jul 2023 03:38:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A9jTjN022183;
        Mon, 10 Jul 2023 10:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bfNOF/GRWeeHJbmWyRnvqYdWgqv/8yp+BQB3y1VQsOk=;
 b=WRL+3hqVse1KujBZ6Kz6IE+NuxM7XVgE75oqHRiIiiYbuJpyzS1omyguAPW3AVVNWKRF
 k7HgHrU5rPikPdj8dMmxighOV2GYOpkP49U49RzWM4WANm+M6+2Jh2n4pQ7O1lV5POms
 pAeBWyQqbINdKmvn2xMexhtzhRFyW0wbaOYxuD9NHQ6p1ZWWF5zSvRLK/bufCKHbcypi
 qWvqflpyt8hL8phL6SARCvEXdS0vi1Ind/WCJhUVclNGcGEtVnp7o2iVB845Gd7G3J4B
 3HPD/5/pGeyeH88gdPvx/iAUbkufGisYiwVet+/77iSf7vLfg58nNqfAnyZvJu6H+KNy Rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpxteuac2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AAcFIl013695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:15 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:38:10 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 4/6] arm64: dts: qcom: ipq5332: Add tsens node
Date:   Mon, 10 Jul 2023 16:07:33 +0530
Message-ID: <20230710103735.1375847-5-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q1tzYNmWuLQ9shshDY-jcNDnomCiK-pT
X-Proofpoint-ORIG-GUID: Q1tzYNmWuLQ9shshDY-jcNDnomCiK-pT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 mlxlogscore=696 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
node with nvmem cells for calibration data.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 113 ++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 8bfc2db44624..a1e3527178c0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -150,6 +150,91 @@ qfprom: efuse@a4000 {
 			reg = <0x000a4000 0x721>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			tsens_mode: mode@3e1 {
+				reg = <0x3e1 0x1>;
+				bits = <0 3>;
+			};
+
+			tsens_base0: base0@3e1 {
+				reg = <0x3e1 0x2>;
+				bits = <3 10>;
+			};
+
+			tsens_base1: base1@3e2 {
+				reg = <0x3e2 0x2>;
+				bits = <5 10>;
+			};
+
+			s0_offset: s0_offset@3e4 {
+				reg = <0x3e4 0x1>;
+				bits = <0 4>;
+			};
+
+			s3_offset: s3_offset@3e5 {
+				reg = <0x3e5 0x1>;
+				bits = <4 4>;
+			};
+
+			s4_offset: s4_offset@3e6 {
+				reg = <0x3e6 0x1>;
+				bits = <0 4>;
+			};
+
+			s5_offset: s5_offset@3e6 {
+				reg = <0x3e6 0x1>;
+				bits = <4 4>;
+			};
+
+			s6_offset: s6_offset@3e8 {
+				reg = <0x3e8 0x1>;
+				bits = <0 4>;
+			};
+
+			s7_offset: s7_offset@3e8 {
+				reg = <0x3e8 0x1>;
+				bits = <4 4>;
+			};
+
+			s8_offset: s8_offset@3a4 {
+				reg = <0x3a4 0x1>;
+				bits = <0 4>;
+			};
+
+			s9_offset: s9_offset@3a4 {
+				reg = <0x3a4 0x1>;
+				bits = <4 4>;
+			};
+
+			s10_offset: s10_offset@3a5 {
+				reg = <0x3a5 0x1>;
+				bits = <0 4>;
+			};
+
+			s11_offset: s11_offset@3a5 {
+				reg = <0x3a5 0x1>;
+				bits = <4 4>;
+			};
+
+			s12_offset: s12_offset@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <0 4>;
+			};
+
+			s13_offset: s13_offset@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <4 4>;
+			};
+
+			s14_offset: s14_offset@3ad {
+				reg = <0x3ad 0x2>;
+				bits = <7 4>;
+			};
+
+			s15_offset: s0_offset@3ae {
+				reg = <0x3ae 0x1>;
+				bits = <3 4>;
+			};
 		};
 
 		rng: rng@e3000 {
@@ -159,6 +244,34 @@ rng: rng@e3000 {
 			clock-names = "core";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5332-tsens";
+			reg = <0x4a9000 0x1000>,
+			      <0x4a8000 0x1000>;
+			nvmem-cells = <&tsens_mode>, <&tsens_base0>,
+					<&tsens_base1>, <&s0_offset>,
+					<&s3_offset>, <&s4_offset>,
+					<&s5_offset>, <&s6_offset>,
+					<&s7_offset>, <&s8_offset>,
+					<&s9_offset>, <&s10_offset>,
+					<&s11_offset>, <&s12_offset>,
+					<&s13_offset>, <&s14_offset>,
+					<&s15_offset>;
+			nvmem-cell-names = "mode", "base0",
+						"base1", "s0_offset",
+						"s3_offset", "s4_offset",
+						"s5_offset", "s6_offset",
+						"s7_offset", "s8_offset",
+						"s9_offset", "s10_offset",
+						"s11_offset", "s12_offset",
+						"s13_offset", "s14_offset",
+						"s15_offset";
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "combined";
+			#qcom,sensors = <16>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5332-tlmm";
 			reg = <0x01000000 0x300000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

