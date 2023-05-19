Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F370988B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjESNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjESNjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:39:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597C1AC;
        Fri, 19 May 2023 06:39:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBT1Qi021149;
        Fri, 19 May 2023 13:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wV3lPgUUPliSAA1k+HMiysTT4I5LwlRhLihLK9eTSYE=;
 b=mGreMLkS7F9OEXo6MmhlpSEMKHrFFldl+jm0C5y3i3M/GghYpidJToCe0riQSf9qW8MS
 N+6Yidbnh1JKzacJnXNtnQAR7k3wJK3RH3wBq5Ix0Hy44XTIqihJ5njh8hKGP1ju2q9B
 /fLxduh+28aRMBfP223OdKUH4da9f33OAS7mQ49K/9FG6/y2jF8DV6hMzNzGNvI9soDk
 jMIJ1MUkCXH0Z4myhRPol/ZXE4xfU/4y/6nTUeKC0+Hs62rxp8LfoXwtw13C7L9OHbfo
 KA9tVmJ/Z4Kvi2pptEeRLAVvcH29ydZtm7ngdMceoPiLEJ6xCl1fm0PbkpV1HLV96pAx 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnwk4herv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:39:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JDdC4X004440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:39:13 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 06:39:09 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V3 3/3] arm64: dts: qcom: ipq5332: add few more reserved memory region
Date:   Fri, 19 May 2023 19:08:44 +0530
Message-ID: <20230519133844.23512-4-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519133844.23512-1-quic_kathirav@quicinc.com>
References: <20230519133844.23512-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yyB_SA3ce57Mgyr5ziU-F_zV-enKmgaZ
X-Proofpoint-ORIG-GUID: yyB_SA3ce57Mgyr5ziU-F_zV-enKmgaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=658 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190115
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In IPQ SoCs, bootloader will collect the system RAM contents upon crash for
the post morterm analysis. If we don't reserve the memory region used by
bootloader, obviously linux will consume it and upon next boot on crash,
bootloader will be loaded in the same region, which will lead to loose some
of the data, sometimes we may miss out critical information. So lets
reserve the region used by the bootloader.

Similarly SBL copies some data into the reserved region and it will be
used in the crash scenario. So reserve 1MB for SBL as well.

While at it, drop the size padding in the smem memory region.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V3:
	- s/u-boot/bootloader/ in commit msg and in the code as
	  suggested by Bhupesh
Changes in V2:
	- Dropped the size padding in smem memory region
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 753581e60604..ba1d20fd8059 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -114,6 +114,16 @@
 		#size-cells = <2>;
 		ranges;
 
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
 		tz_mem: tz@4a600000 {
 			reg = <0x0 0x4a600000 0x0 0x200000>;
 			no-map;
@@ -121,7 +131,7 @@
 
 		smem@4a800000 {
 			compatible = "qcom,smem";
-			reg = <0x0 0x4a800000 0x0 0x00100000>;
+			reg = <0x0 0x4a800000 0x0 0x100000>;
 			no-map;
 
 			hwlocks = <&tcsr_mutex 0>;
-- 
2.17.1

