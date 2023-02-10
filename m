Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F96691843
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBJGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjBJGEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:04:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903BE765D7;
        Thu,  9 Feb 2023 22:04:33 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A4V17U025590;
        Fri, 10 Feb 2023 06:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UeMlyh4FfsbRIupeQJiM1UXlmc2sh69KJ1r1HQ/EkDs=;
 b=ZM3r5qfMTamqbytvP8ZSgX58fjyecQfXrTTGP7ysMDVvoqsecM/jeJ1pqyovb6vg+Nzi
 rN4ysydGfw258jBETc8go71hodsGoTor9VHGvG5UeIqdVOJwutfyociI3+Oam8hgXcua
 EMS5b2Sk1Pwiq5wykM7f3tdRWZZpmf5LwQ7tTnbxy1hgH6DLIfWLYSYRh1r1byZiUKf3
 w9qmMRjKRVE6uGnmsUCnFCOzYuKameC8Oztpk2FKlXdDN5p0SuFJo8yHZa04d3jArxvu
 nReMTwDX9Hp17mb5skQHWtXwcQL0XU4+xu9MPk1LUm+HqXJUXzOEL9G/GwPjNxZQo+xv 0Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmg9embds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:04:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A64Twv017580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:04:29 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 9 Feb 2023 22:04:24 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 2/2] arm64: dts: qcom: ipq5332: add SMEM support
Date:   Fri, 10 Feb 2023 11:34:01 +0530
Message-ID: <20230210060401.24383-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230210060401.24383-1-quic_kathirav@quicinc.com>
References: <20230210060401.24383-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 90-SmIpmi1JeKMU2VQaOtj7H_W9k35GN
X-Proofpoint-ORIG-GUID: 90-SmIpmi1JeKMU2VQaOtj7H_W9k35GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_01,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=657
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SMEM support by adding required nodes.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Rebased on V4 series of baseport patches
	  https://lore.kernel.org/linux-arm-msm/20230208155232.11500-1-quic_kathirav@quicinc.com/

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index ad6481dd57ba..0eaf6a5a3da6 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -99,6 +99,14 @@
 			reg = <0x0 0x4a600000 0x0 0x200000>;
 			no-map;
 		};
+
+		smem@4a800000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4a800000 0x0 0x00100000>;
+			no-map;
+
+			hwlocks = <&tcsr_mutex 0>;
+		};
 	};
 
 	soc@0 {
@@ -143,6 +151,12 @@
 				 <0>;
 		};
 
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
 		tcsr: syscon@1937000 {
 			compatible = "qcom,tcsr-ipq5332", "syscon";
 			reg = <0x01937000 0x21000>;
-- 
2.17.1

