Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591D9666D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjALJAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbjALI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:57:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87738AC9;
        Thu, 12 Jan 2023 00:55:26 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C7sRmO004043;
        Thu, 12 Jan 2023 08:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/v2CdOrf4Z17VR11u6HItm6Vj0VBzlrchZCCWtJrPCI=;
 b=EmtIVpaWPM2eCOUs1AglbUlhmhMbiwXr2ds3AqWYfaXgIgh2qU+9U6IcOjzFZmi3Nzj1
 tzNjayk94FmhsuP5R/9Ujax1VjpMM0GcyxxwDXiP6ywlIWEXDGcY7U8HcD017nDqh6QM
 EczQyE4dCJzTX4J7fLJ4su3b2fPlNsvI46QZh2DnZHOf8US8J0R2VjnK4S3qL0YtYugp
 SWmcWs/mjdbt6n+KAkhi4Il9FWtwrDb6ray6Gg+9Wo+7XsXfdfoF05RidtQ46Mybr6/J
 aNcS6vLkr/X460xXSKS+bqNPSP2y4wWlBeF0wgyqczyLJItLGOn6g8O0yGq2xq9myp0f ow== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1km2ka87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:55:22 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C8tLYC029701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:55:21 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 00:55:18 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8450: Add TCSR halt register space
Date:   Thu, 12 Jan 2023 14:24:57 +0530
Message-ID: <1673513697-30173-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
References: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9qUDvZZ-1HEfQace3VvbGZ3zJiHKr1Ku
X-Proofpoint-GUID: 9qUDvZZ-1HEfQace3VvbGZ3zJiHKr1Ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_04,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=846 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCSR register space and refer it from scm node, so that
it can be used by SCM driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Change in v3:
  - Align with new format of compatible for Qcom SoC.

Changes in v2:
  - Added SoC compatible based on comment made by krzysztof in v1.

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5704750..d9f7a9b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -270,6 +270,7 @@
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sm8450", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x13000>;
 			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
 			#reset-cells = <1>;
 		};
@@ -1986,6 +1987,11 @@
 			#hwlock-cells = <1>;
 		};
 
+		tcsr: syscon@1fc0000 {
+			compatible = "qcom,sm8450-tcsr", "syscon";
+			reg = <0x0 0x1fc0000 0x0 0x30000>;
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8450-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.7.4

