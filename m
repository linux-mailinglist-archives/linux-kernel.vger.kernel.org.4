Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF04473975D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjFVGXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFVGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:23:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEED19AD;
        Wed, 21 Jun 2023 23:23:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M4s6xa024323;
        Thu, 22 Jun 2023 06:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=m5zDPMjDUmczsmZklZCWVRMSvrMknEgqEwD+AUmnzNI=;
 b=CVvW97zCOR72eLLT98hnpAsz62SRgkeiR3lS448xBi9AcO6OynMvYg+dJcYuUgLl//Mq
 AydwxTdrTFnGd7tdWxkNp2bJ/VxRHNqopQlR4H57TE5ETgTbtbxhqpCiKCBIgDtEfEWy
 3mEw9f2Yq2DC0JOq1+WdADAgfVG5QXzhkSUnVwMroRTuuJWn++PcYNWk4gNBUMdNWw+T
 YZkZDLD/EYIOYojQWTnRVBNvIf7AmrDxmss2SQP9oEcBOGk45RNYxq04VLaqGy3VRFhu
 ++4m+CAgkz8xzoTVzLNWni170edk/XWhzU1Ks3tpanH854J5fV2y94FsdYU5RTJDcg/9 RA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqjbb3av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 06:22:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35M6McIo029155
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 06:22:38 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 23:22:30 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 1/6] dt-bindings: usb: dwc3: Add IPQ5332 compatible
Date:   Thu, 22 Jun 2023 11:52:08 +0530
Message-ID: <072f84347f18ba0b5fc6bf791b555aa7857c9fdc.1687414716.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1687414716.git.quic_varada@quicinc.com>
References: <cover.1687414716.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4NNQP6Lf8IZxKZYJ3aX-VoocbMcYgn3w
X-Proofpoint-GUID: 4NNQP6Lf8IZxKZYJ3aX-VoocbMcYgn3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=632
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the IPQ5332 dwc3 compatible.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v1:
	Add ipq5332 to interrupts sections
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index ae24dac..9447b54 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - qcom,ipq4019-dwc3
+          - qcom,ipq5332-dwc3
           - qcom,ipq6018-dwc3
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
@@ -246,6 +247,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-dwc3
               - qcom,msm8994-dwc3
               - qcom,qcs404-dwc3
     then:
@@ -410,6 +412,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-dwc3
               - qcom,sdm660-dwc3
     then:
       properties:
-- 
2.7.4

