Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53B6B8A01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCNFBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjCNFA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:00:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C9D6BC0B;
        Mon, 13 Mar 2023 22:00:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3WXDS009533;
        Tue, 14 Mar 2023 05:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eGPDFMKmLWan6mmYyvO09gGtE/SBlL/QncfFhTJysy8=;
 b=XaQNA5JT7K1u6uXDA/NnHQLjlcZp1aibBhnssu7zJ5cTzflVHb88jnFH12YLdmf8WC9y
 qRUiGONvOwHpEgWGvqhh5KPAEtGqa7eOFzjfNzlCVehqPKvSjnCBl941+Mdxbi6M25uJ
 W9xb+dptVRFf3B44qkTSyR/p4CzDh7SmAvfepWbU4L6qV+lw02ygY1zCs1ev4/fgm5/Z
 lwK46gzRzxfLQz6RjxvYZbD2i+RXnZ6lV5MkGYilNW+WeIFG0bUJbY5YqTRBeHWhcaOa
 EZPl6AiC9IS6x6xhmUvKB8F8FBHzypAs4lTglJFsOMvfP+00Q4lcGE5jGr17QpiOG6bp TA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa203tj4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:00:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E50PRX017261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:00:25 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 13 Mar 2023 22:00:21 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 1/3] dt-bindings: mailbox: qcom: use fallback for IPQ8074 SoC
Date:   Tue, 14 Mar 2023 10:30:03 +0530
Message-ID: <20230314050005.10409-2-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314050005.10409-1-quic_kathirav@quicinc.com>
References: <20230314050005.10409-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zte2T1aHnhfD2wRm6cngq97MY8AoPB76
X-Proofpoint-GUID: Zte2T1aHnhfD2wRm6cngq97MY8AoPB76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the IPQ8074 mailbox is compatible with the IPQ6018, lets create
the fallback to ipq6018 compatible, so that we don't bloat the of_device_id
table in the driver.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Fixed the dtbs_check warning for IPQ6018

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index d888ead09282..9598471d537f 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -19,11 +19,11 @@ properties:
       - items:
           - enum:
               - qcom,ipq5332-apcs-apps-global
+              - qcom,ipq8074-apcs-apps-global
           - const: qcom,ipq6018-apcs-apps-global
       - items:
           - enum:
               - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
               - qcom,msm8996-apcs-hmss-global
               - qcom,msm8998-apcs-hmss-global
               - qcom,qcm2290-apcs-hmss-global
@@ -111,7 +111,6 @@ allOf:
           contains:
             enum:
               - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         clocks:
@@ -152,7 +151,6 @@ allOf:
           contains:
             enum:
               - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         '#clock-cells':
-- 
2.17.1

