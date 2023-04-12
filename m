Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C696DFBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDLQvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjDLQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:51:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0114EDB;
        Wed, 12 Apr 2023 09:50:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGj4w8029053;
        Wed, 12 Apr 2023 16:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Hb+1ofwDe8tPgBwB5flRxmCp0ulTxVP43RknkDd2Gj4=;
 b=m1ZgSXL0rpHd8WN5E670YQZKwc0OBIeLUDefJ9DuSIYaed0RmSo9Aef4eCI1q8oF2BI2
 KgrRnZtmINBfkfUbdC/4+l0Zf0Wz6dZ2M/UvsunwVV9UwOq0qJDdA+vgf8FRcpsXaxH/
 1QcrWRpdRHny1PGkW3QmJDsBTxXf7VgYNMcfvweDFqGjicg6XTMO3lhM9QeoxHdolPZb
 TK31Ij4pYOy6SFmcw+IArFB8ey+lO+gNTtf8j+bymi/V0egp5kjomMc7f3X2iOBEsGwe
 ReQNPTgyYCUw4Q6UkBBqjB1FLeL2km3IKuAcJVvQQL5J3wqnM8Ml6PoCQ1coSrKk+wQv RA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqensbnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:49:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CGnm49023344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:49:48 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 12 Apr 2023 09:49:45 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq5332: add few more reserved memory region
Date:   Wed, 12 Apr 2023 22:19:20 +0530
Message-ID: <20230412164920.21862-4-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230412164920.21862-1-quic_kathirav@quicinc.com>
References: <20230412164920.21862-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0xIDPXGuxARhHVvCN8zyF8JUmZKwY4jx
X-Proofpoint-ORIG-GUID: 0xIDPXGuxARhHVvCN8zyF8JUmZKwY4jx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=613 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In IPQ SoCs, U-boot will collect the system RAM contents upon crash for
the post morterm analysis. If we don't reserve the memory region used by
U-boot, obviously linux will consume it and upon next boot on crash, uboot
will be loaded in the same region, which will lead to loose some of the
data, sometimes we may miss out critical information. So lets reserve the
region used by the U-boot.

Similarly SBL copies some data into the reserved region and it will be
used in the crash scenario. So reserve 1MB for SBL as well.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index c32217530b41..aec60840a2f0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -114,6 +114,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		uboot@4a100000 {
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
-- 
2.17.1

