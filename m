Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131C771253D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbjEZLHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbjEZLHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:07:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65991A6;
        Fri, 26 May 2023 04:07:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAMLdZ004954;
        Fri, 26 May 2023 11:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=L+UZMrct2CdggSukP8m/AcuMAdqy/CL+Bb+0b7+crxA=;
 b=gqJ/9G04QAEQwo7LOKA9XxnbU/pVHVPPx7UKB9xCOl/mvI+E4oTPwWBdJiPWQGZhYnq8
 0H754kpa0vQtG9JGAH+Ekc1J/dlcrUrquzGfEAs/+E1rlJ+/u8vK8seixUzuEGZfAq/k
 c/XUVglKRLmx84k5bQhAdRg4yDE4zhYpy442QGEpi3ffRMonyD5gdndlofUJQvqAfFUO
 JmPpdyMXNqv2Oaoau5ylbEzmhczFzThFjv/TlPEnGc2duqfqa3YMrIro3u3PnvU8Jj9p
 TLSA91N7drid00/DyW7zs6myrlRgPyvB25nkYVFXDHdkdOSncGoWbFQ5LR9qEOUN0qMt tg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtp4wgq64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:07:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QB7X6N018130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:07:33 GMT
Received: from viswanat-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 04:07:28 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: add few more reserved memory region
Date:   Fri, 26 May 2023 16:36:53 +0530
Message-ID: <20230526110653.27777-4-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526110653.27777-1-quic_viswanat@quicinc.com>
References: <20230526110653.27777-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ZDnz2KCQen1LpyHc9BEhYjD9oNC1A1I
X-Proofpoint-ORIG-GUID: 8ZDnz2KCQen1LpyHc9BEhYjD9oNC1A1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=580
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In IPQ SoCs, bootloader will collect the system RAM contents upon crash
for the post morterm analysis. If we don't reserve the memory region used
by bootloader, obviously linux will consume it and upon next boot on
crash, bootloader will be loaded in the same region, which will lead to
loose some of the data, sometimes we may miss out critical information.
So lets reserve the region used by the bootloader.

Similarly SBL copies some data into the reserved region and it will be
used in the crash scenario. So reserve 1MB for SBL as well.

While at it, drop the size padding in the reserved memory region,
wherever applicable.

Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 16 +++++++++++++---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++--
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 2d77a8336111..fc64a5efbe2c 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -156,18 +156,28 @@ rpm_msg_ram: memory@60000 {
 			no-map;
 		};
 
+		bootloader@4a100000 {
+			reg = <0x0 0x4a100000 0x0 0x400000>;
+			no-map;
+		};
+
+		sbl@4a500000 {
+			reg = <0x0 0x4a500000 0x0 0x100000>;
+			no-map;
+		};
+
 		tz: memory@4a600000 {
-			reg = <0x0 0x4a600000 0x0 0x00400000>;
+			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
 		};
 
 		smem_region: memory@4aa00000 {
-			reg = <0x0 0x4aa00000 0x0 0x00100000>;
+			reg = <0x0 0x4aa00000 0x0 0x100000>;
 			no-map;
 		};
 
 		q6_region: memory@4ab00000 {
-			reg = <0x0 0x4ab00000 0x0 0x05500000>;
+			reg = <0x0 0x4ab00000 0x0 0x5500000>;
 			no-map;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 00e559de00fb..0793b691a095 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -86,17 +86,27 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		bootloader@4a600000 {
+			reg = <0x0 0x4a600000 0x0 0x400000>;
+			no-map;
+		};
+
+		sbl@4aa00000 {
+			reg = <0x0 0x4aa00000 0x0 0x100000>;
+			no-map;
+		};
+
 		smem@4ab00000 {
 			compatible = "qcom,smem";
-			reg = <0x0 0x4ab00000 0x0 0x00100000>;
+			reg = <0x0 0x4ab00000 0x0 0x100000>;
 			no-map;
 
 			hwlocks = <&tcsr_mutex 0>;
 		};
 
 		memory@4ac00000 {
+			reg = <0x0 0x4ac00000 0x0 0x400000>;
 			no-map;
-			reg = <0x0 0x4ac00000 0x0 0x00400000>;
 		};
 	};
 
-- 
2.40.1

