Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEDB631938
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKUEfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKUEfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:35:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C926559;
        Sun, 20 Nov 2022 20:35:06 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL3rkCX025130;
        Mon, 21 Nov 2022 04:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=IDvus5P0RrGrf4DJnthawuTAHhoJ4KL+F4xCdkZC3EQ=;
 b=A0XJCAbzp2G89/0ACq9a5n9ro7d/s4dUWbey3nbVQTIUgZbYVOK5BvRdUjI50/Ag/+fo
 TbKIWTM8tqGZQk6zuz01MqzuIFf+kV7ek0/vuLh1jHHj6NSvEoLdDbtNPI2z2/Glvsaf
 JLG1LVCQ2jY30IglGMkU7+0bLKn6neR7i6GBAHtCpGPHFurt69WNPOhOHoITx7uolmmS
 xVjFUVm22NT3yZIg9RBR4tE3Afoa+2BRKWHa/5UXuqQj2lMDrB8/VhRpYFNtvm8ewJ+1
 Btrrok762JRLRyoc/zhVBV0iSns8eI7lLuN64z7PKuNdVoUv9ZYiSQLsPp554xM6pfQt iw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrkv3ebp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:35:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL4Z1t8009537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 04:35:01 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 20 Nov 2022 20:34:57 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD Pro boards
Date:   Mon, 21 Nov 2022 10:04:36 +0530
Message-ID: <20221121043437.21925-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bF70nfhvSvS_XqqFl8fMg-IkvjLiD9ki
X-Proofpoint-ORIG-GUID: bF70nfhvSvS_XqqFl8fMg-IkvjLiD9ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=703 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Pro SKU of the sc7280 CRD boards
which come with a Pro variant of the qcard.
The Pro qcard variant has smps9 from pm8350c ganged up with
smps7 and smps8.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..2550ab251f7b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -613,6 +613,11 @@ properties:
           - const: google,hoglin
           - const: qcom,sc7280
 
+      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro platform (newest rev)
+        items:
+          - const: google,hoglin-sku1536
+          - const: qcom,sc7280
+
       - description: Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform
         items:
           - const: qcom,sc7280-idp
-- 
2.17.1

