Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACBE6993CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjBPMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBPMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:01:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D355E54;
        Thu, 16 Feb 2023 04:01:30 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G70kIY005288;
        Thu, 16 Feb 2023 12:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1c0O9ryNt4kuCSoWVqDiPno8xpS9i8JyJhhy6y//76M=;
 b=CmNBN7lleZDnKV10Ux6QfoIrFlk5WxJ+ydumh+V2m1QQIPjedC93/UB+0nzKxhHuLes6
 5nsZG4036rCUL0VNGVOKmqplDazi5kAeIrj/PmTsIZBB0hevyuVDcSIXQHsOgTx7WvSz
 pzU7uEUqrXfitZUXRRwkC5jnK0XDXeFBGmScoCgmEYbdOw3durKvElM8PKR34oTsrTmy
 uR4Sq7BEzBbswwg+DAyVkabrYE5se1qzoAY6iVxl/vWq2AI647H6ltYlzRRFhs+xdv5M
 XM7aIdDJb6yHVmUIhn7wKhONcL61qp5Oo/ptk6u0xhilgfZWb4N90ynvUBnfdU8L6A9d bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns85k9pds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 12:01:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GC1CmZ016275
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 12:01:12 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Feb 2023 04:01:04 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V5 4/5] arm64: dts: qcom: ipq9574: Add SMEM support
Date:   Thu, 16 Feb 2023 17:30:11 +0530
Message-ID: <20230216120012.28357-5-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230216120012.28357-1-quic_poovendh@quicinc.com>
References: <20230216120012.28357-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3mmpecprqcJ4X7MqoeGIz9Vww3ExbahY
X-Proofpoint-ORIG-GUID: 3mmpecprqcJ4X7MqoeGIz9Vww3ExbahY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_09,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=856
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required nodes to support SMEM

Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
 Changes in V5:
	- Dropped unrelated changes

 Changes in V4:
	- Added required nodes for smem support

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 099948f36efc..14a3396b0381 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -107,6 +107,13 @@
 			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
 		};
+
+		smem@4aa00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4aa00000 0x0 0x00100000>;
+			hwlocks = <&tcsr_mutex 0>;
+			no-map;
+		};
 	};
 
 	soc: soc@0 {
@@ -149,6 +156,12 @@
 			#power-domain-cells = <1>;
 		};
 
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
 		tcsr: syscon@1937000 {
 			compatible = "qcom,tcsr-ipq9574", "syscon";
 			reg = <0x01937000 0x21000>;
-- 
2.17.1

