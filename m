Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D84666D11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjALIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjALIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:53:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C192D3;
        Thu, 12 Jan 2023 00:52:05 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C82YEV032159;
        Thu, 12 Jan 2023 08:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=vaaXR6/xLkXfr+cdrvDTRu6EKhyxTeql7XGBY3p8j5Q=;
 b=G1F09zrNKvnVjMTT448WSCBa18uF8aCRNBUAlx/czYS9dxCN7CEK8LETI3l5tB568G75
 mg5C+9r4Ikcc+dM46rjvmtLWMmNrL8SB9Y0E8axesjbpmG+qJAHLqjxQLPW1wKAauI9N
 qqi3p/flNNyN80koMiFGhIEZVZdYNdyr7NxIQjPwuW2zaoHzuB2K3Xd7mM7EPApsoawh
 9/kfkYgccZXe9R0x3UBRIb3/GG9obdtK+lGZm5TD0nOzk60H+jgokrVhwGXMp2HwFQT3
 9bK/r3p9xXCbdAaGUYGiQEuLGTndvxVgYmC9zouJrKi30UNdOHZo3NA6l9OzDr5iWB0y ZA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1m6p38mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:51:56 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C8ptkS008059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:51:55 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 00:51:52 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8450: Add TCSR halt register space
Date:   Thu, 12 Jan 2023 14:21:41 +0530
Message-ID: <1673513501-29938-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: txpHnp4PFXodNVrk9QuQ9ybv9x0U-bqD
X-Proofpoint-GUID: txpHnp4PFXodNVrk9QuQ9ybv9x0U-bqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_04,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=875
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120061
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
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5704750..e0fa733 100644
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
+			compatible = "syscon";
+			reg = <0x0 0x1fc0000 0x0 0x30000>;
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8450-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.7.4

