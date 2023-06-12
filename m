Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF372D43F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjFLWPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjFLWPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:15:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E310C6;
        Mon, 12 Jun 2023 15:15:07 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CLZcMV023342;
        Mon, 12 Jun 2023 22:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=pWQlAePSun4cHdtgRWnOJ27ATGh4e0qJ2DgAMGNTqEc=;
 b=Vv6nvSy7A/GA8Zg4FA85m2pNdy0hCfh6XVqfiCftIthG7p/lEr1xjFqB7S3cvrTAv6IW
 8MvcO42OIxhubngSK+Qrcz/c5uCpL71hXJ04fD0oQEKA2760rFqVXDl1mzwv6Y/ZZ5fr
 qfWrpaDLHrTvdOA+4k4C7R3Oz224VQm1fo4n7woz3pTIXQIVw+K2LLdATuOWYRMC/W+m
 h3c8eM1/Po1L4FCLTBZ70GbWfesLl+cfUOoFBBEC7poL2Lox8Bbsg+5TMnxTkZ5QCWvP
 NRc2+gCbCN1muu8Rjb0a/UkUjggFL0cAnWOPjG5jZ1cZZEOQyacysLh6fWKAsG/0cFky eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r690q095w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CMF23V018481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:02 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:15:02 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sc8180x: Add USB Type-C of_graph anchors
Date:   Mon, 12 Jun 2023 15:14:54 -0700
Message-ID: <20230612221456.1887533-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
References: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yizOnE78zHJdZw8dTEZQrnt9lyBQ9H-e
X-Proofpoint-GUID: yizOnE78zHJdZw8dTEZQrnt9lyBQ9H-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=859 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define anchors for wiring up the USB Type-C graph in the board files.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index a7668f9e68d6..4144beb70cb4 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2464,6 +2464,23 @@ usb_prim_qmpphy: phy@88e9000 {
 
 			status = "disabled";
 
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_prim_qmpphy_out: endpoint {};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_prim_qmpphy_dp_in: endpoint {};
+				};
+			};
+
 			usb_prim_ssphy: usb3-phy@88e9200 {
 				reg = <0 0x088e9200 0 0x200>,
 				      <0 0x088e9400 0 0x200>,
@@ -2513,6 +2530,23 @@ usb_sec_qmpphy: phy@88ee000 {
 
 			status = "disabled";
 
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_sec_qmpphy_out: endpoint {};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_sec_qmpphy_dp_in: endpoint {};
+				};
+			};
+
 			usb_sec_ssphy: usb3-phy@88e9200 {
 				reg = <0 0x088ee200 0 0x200>,
 				      <0 0x088ee400 0 0x200>,
@@ -2607,6 +2641,11 @@ usb_prim_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_prim_hsphy>, <&usb_prim_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+
+				port {
+					usb_prim_role_switch: endpoint {
+					};
+				};
 			};
 		};
 
@@ -2659,6 +2698,11 @@ usb_sec_dwc3: usb@a800000 {
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_sec_hsphy>, <&usb_sec_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+
+				port {
+					usb_sec_role_switch: endpoint {
+					};
+				};
 			};
 		};
 
@@ -2986,6 +3030,8 @@ dp0_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+						mdss_dp0_out: endpoint {
+						};
 					};
 				};
 
@@ -3060,6 +3106,8 @@ dp1_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+						mdss_dp1_out: endpoint {
+						};
 					};
 				};
 
-- 
2.25.1

