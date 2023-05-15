Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08132702A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbjEOKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjEOKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:14:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D181700;
        Mon, 15 May 2023 03:14:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FAAt1X003592;
        Mon, 15 May 2023 10:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fr0/amL9fESiq6HiNnuJ+IWCWGVBCZYuEb+7C93doRc=;
 b=PF/V/2iLT5ilzP0H+l0jWaUnhHz6lL3XUN+Yy0+9/1Qzybq7o649PeBulnVytHnoc+1d
 cm9MaSTEARQ9s6RupvwqgunsRPpbBdQ2pRrtb7ZmFzjUioEHU+GJVl3rSWfbOc4JMmK/
 bwXbnHYFmhtx9+Ju1cOcYilZ1eSZ9aCTUr0DJt5WwCEMqEOEAJ9FZVjVmhuS/1uePGCl
 piE53cTgsCFYIYABxuSK4uhZJOhmxDLgbyCvCkY4RE3TljvXBtM8PyA2dXB+Y6oHzKV7
 3DbfANHTEFk0+lbqhQ1E47ZlLoT5QVmMmDisnaI9CuLb8uMdmIkJ+C9g7wCxHYM+5Vt2 4g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjr000hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 10:14:03 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FAE2xn031720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 10:14:02 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 May 2023 03:13:57 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Praveenkumar I <quic_ipkumar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574 compatible
Date:   Mon, 15 May 2023 15:43:33 +0530
Message-ID: <37adcf5d8d545a076e8ed971a4fb6c6c2833ef3c.1684140883.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1684140883.git.quic_varada@quicinc.com>
References: <cover.1684140883.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mm_XQMBsnNpJ_OfITEVzaeItapsiJOhv
X-Proofpoint-GUID: Mm_XQMBsnNpJ_OfITEVzaeItapsiJOhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
[v3]:
	Fix dt_binding_check & dtbs_check errors (Used
	Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
	as reference/example)

	Drop 'Acked-by: Rob Herring' as suggested in review

[v2]:
	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
	for the tip to make qcom,ipq8074-tsens as fallback.
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d9aa54c..57e3908 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,6 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: qcom,tsens-v0_1
+      - const: qcom,tsens-v1
+      - const: qcom,tsens-v2
+      - const: qcom,ipq8074-tsens
+
       - description: msm8960 TSENS based
         items:
           - enum:
@@ -66,8 +71,10 @@ properties:
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt
-        enum:
-          - qcom,ipq8074-tsens
+        items:
+          - enum:
+              - qcom,ipq9574-tsens
+          - const: qcom,ipq8074-tsens
 
   reg:
     items:
@@ -279,6 +286,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-tsens
+              - qcom,ipq9574-tsens
     then:
       properties:
         interrupts:
@@ -294,6 +302,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-tsens
+              - qcom,ipq9574-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
-- 
2.7.4

