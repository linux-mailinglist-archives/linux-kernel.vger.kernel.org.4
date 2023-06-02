Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89CB71FFF5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjFBLEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjFBLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:04:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE3137;
        Fri,  2 Jun 2023 04:04:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352ArvWc000361;
        Fri, 2 Jun 2023 11:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Bk8ZQLXKXg7MG36rOTQbk7zW98lzKa6E9RwBjKbQxFE=;
 b=YnS2qPwSWmRe23xSm7ckxB7nygo7ZzSbb0AhvBIBMUKhOX9jxSQ1iHM6qlyTY/UU42Sm
 uhDEEaIhfrDDw2aXXjWs+hxoUq/eCiasxwjJjMiXGvd4R7EcOME9q1MS4OD8qwZpx2tt
 TboiYaVSfwyVpycg4j6ERlOSlv19u8CVmMr9tCQDGNRKfqea3hDAQ/94moN8tKciyPxW
 tuOrc9A1HH0N5eoR4PQj5/wucif9rCIr5lvjUAaaZFNnhBfs5RPchO4OQSUJAp6UIhMh
 nGOm1mO+Jgtz6dELWzGrCeswwxIdkYPRI9p4W9EQ3IJsBdTwPOvm52F632geznVvKqlN zw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qy1bchf7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 11:04:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352B49cP006041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 11:04:09 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 04:04:04 -0700
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
Subject: [PATCH v5 1/3] dt-bindings: thermal: tsens: Add ipq9574 compatible
Date:   Fri, 2 Jun 2023 16:33:50 +0530
Message-ID: <1daf835b3c77fd84ad55b0195816fabc3f0ab800.1685703605.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1685703605.git.quic_varada@quicinc.com>
References: <cover.1685703605.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LyBJT1tXh83vM9kL2xmpQs4KRRtYWb67
X-Proofpoint-GUID: LyBJT1tXh83vM9kL2xmpQs4KRRtYWb67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
[v5]:
        Fix dt_binding_check & dtbs_check errors without removing existing entries
[v4]:
        Add description about IPQ9574 and remove unnecessary
        additions to the file
[v3]:
        Fix dt_binding_check & dtbs_check errors (Used
        Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
        as reference/example)

        Drop 'Acked-by: Rob Herring' as suggested in review

[v2]:
        Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
        for the tip to make qcom,ipq8074-tsens as fallback.
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d1ec963..e7d0341 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -67,6 +67,12 @@ properties:
         enum:
           - qcom,ipq8074-tsens
 
+      - description: v2 of TSENS with combined interrupt
+        items:
+          - enum:
+              - qcom,ipq9574-tsens
+          - const: qcom,ipq8074-tsens
+
   reg:
     items:
       - description: TM registers
-- 
2.7.4

