Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB37312B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjFOIuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245455AbjFOIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:49:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963912D57;
        Thu, 15 Jun 2023 01:49:19 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8bwdZ004498;
        Thu, 15 Jun 2023 08:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=y8GbwR3Om8ATjvtpQuV6B+xsxm6V6zShZPUc3AEsx/0=;
 b=ohsugmcvsoKHZLHDuJMdM/VHOxC0364Nn/IInd5h7/Tx2UAMK+OYj9TzLPPG4fvWz4Cr
 dLScST46kOPSfj0QaPdrRlP9xvuLRU0H6e8V5ds32o8ApOI3vyLYlS7nZs4npQeAonhv
 9j4jPZCVTL+UfEB+GgzXe+cVhSX2pW/EqE4ULybRcXdV1VDBDQouCZF3GNHIs8bTKmve
 X2jXwy/6CIQP6dzKCaJfW3uQYAjgpJmLZAmTb7mKWl/QFVdFaMQ9eu17iNk8FeEEf2yo
 ml7gCRyHNsJ+8OYKeXIkJncEsiVi82EfwWM9fUHJ6VkldMwcJdr3w2VMrLd5Jec0Znmu Qg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7va2gej2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:49:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F8n3F0027583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:49:03 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 15 Jun 2023 01:48:58 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: ipq9574: Use assigned-clock-rates for QUP I2C core clks
Date:   Thu, 15 Jun 2023 14:18:41 +0530
Message-ID: <20230615084841.12375-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XmG6i7Yb4grH_fWgidg7fU2DYSE2N6Xy
X-Proofpoint-ORIG-GUID: XmG6i7Yb4grH_fWgidg7fU2DYSE2N6Xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=769
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use assigned-clock-rates property for configuring the QUP I2C core clocks
to operate at nominal frequency.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 0baeb10bbdae..78bf7f9c455a 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -361,6 +361,8 @@
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			assigned-clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
 			status = "disabled";
@@ -389,6 +391,8 @@
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			assigned-clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
 			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
 			dma-names = "tx", "rx";
 			status = "disabled";
@@ -417,6 +421,8 @@
 			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			assigned-clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
 			dmas = <&blsp_dma 18>, <&blsp_dma 19>;
 			dma-names = "tx", "rx";
 			status = "disabled";
@@ -446,6 +452,8 @@
 			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			assigned-clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
+			assigned-clock-rates = <50000000>;
 			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
 			dma-names = "tx", "rx";
 			status = "disabled";
-- 
2.17.1

