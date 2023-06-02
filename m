Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2B71FC5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjFBIpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjFBIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:45:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E344E1A2;
        Fri,  2 Jun 2023 01:44:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35269ODH022599;
        Fri, 2 Jun 2023 08:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kbzgij/Tqdpm7oSf07loDtrlT0CmONVxqft9buSMc1I=;
 b=j79eDxFO6C9RX+RYKc5Dx7buW9dShLNuDLvac/GxQggBi9NPXr4ZEHmuKp58GhGu/Na3
 lm8+copulk2jiyY5q3UKkwa8rTjI1rypHQQSFOBld4bBnfYLm5mg6Q+90bq7YtJImhm+
 FID3q1/upKEqju4uSgphGmQdN6t3PN8LevCrcPKz1sMCSfuzayKcwR0Ubt2muc0OK/Yn
 L2WUrVnGEcXEuA0GA8vHk+p86l+JeB+MOpI9tecPJkIFzFnEZ+Nm6RKAoZXV8U6XjvcP
 1qXr+LipDYYqM4zj3Cg3bfZppJrCKIy7o75E2Z5AVGgr1gQFYGQEO0rk8u1h8ysnK028 kw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugrt69y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 08:44:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3528inH9007256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 08:44:49 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 01:44:44 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: ipq9574: add few more reserved memory region
Date:   Fri, 2 Jun 2023 14:14:31 +0530
Message-ID: <20230602084431.19134-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YZa9cvT2tKm2ycR0M_vh10rl-arWTQTC
X-Proofpoint-GUID: YZa9cvT2tKm2ycR0M_vh10rl-arWTQTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=481 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In IPQ SoCs, bootloader will collect the system RAM contents upon crash
for post-morterm analysis. If we don't reserve the memory region used
by bootloader, obviously linux will consume it and upon next boot on
crash, bootloader will be loaded in the same region, which will lead to
loss of some data, sometimes we may miss out critical information.
So lets reserve the region used by the bootloader.

Similarly SBL copies some data into the reserved region and it will be
used in the crash scenario. So reserve 1MB for SBL as well.

While at it, drop the size padding in the reserved memory region,
wherever applicable

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 0baeb10bbdae..7d21ec0909fb 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -156,6 +156,16 @@
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
 		tz_region: tz@4a600000 {
 			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
@@ -163,7 +173,7 @@
 
 		smem@4aa00000 {
 			compatible = "qcom,smem";
-			reg = <0x0 0x4aa00000 0x0 0x00100000>;
+			reg = <0x0 0x4aa00000 0x0 0x100000>;
 			hwlocks = <&tcsr_mutex 0>;
 			no-map;
 		};
-- 
2.17.1

