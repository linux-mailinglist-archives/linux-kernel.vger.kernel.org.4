Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0E633903
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiKVJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKVJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:49:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0152FC0E;
        Tue, 22 Nov 2022 01:49:58 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AM8SFA6009976;
        Tue, 22 Nov 2022 09:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dADRdeJhfcLVNECqNJsH9cCZ7N1ekDPfsaAxXCG77b4=;
 b=pJNGjHIT+iG15Ep6oKcyrLFs+0TiPWKb37Ikb8SciuYPb9Koox+ae0keynsMRs+q0Aeb
 7tCwPzhK1J7bHSIeB+u8s90zOOsILlY29uYC919JzAAZLoX41moQW2IsVa5fSHr12g1y
 EHtGPqmY00/T4c8sRoNZe2skj3Wm2aSS7zd5P51dUPhFgirTm+vIBmpOZsY9F9BNeP1I
 qmOcOn/m5pPFGBiVFD4QmwSCdd370s1b7ceKoxd693TopPypTfoV28/yvM/rLuqygI/+
 N2rJMzqSkSYTHr58kOK0XieW0vA7KFegWlhutaFzycHAzWrmndJd4yPMqZAa0TGmWBiY dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0nsj8qub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 09:49:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AM9nrr8010948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 09:49:53 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 22 Nov 2022 01:49:49 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD Pro boards
Date:   Tue, 22 Nov 2022 15:19:20 +0530
Message-ID: <20221122094921.23109-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9_nPgwKzXnzjApXSDOomZxNQ6kczKtrt
X-Proofpoint-ORIG-GUID: 9_nPgwKzXnzjApXSDOomZxNQ6kczKtrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=745 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220072
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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

