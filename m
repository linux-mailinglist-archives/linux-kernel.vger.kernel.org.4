Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5926771745C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjEaD1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjEaD1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:27:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136B011B;
        Tue, 30 May 2023 20:27:32 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V2NZ6f010286;
        Wed, 31 May 2023 03:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tX6rH1JkVelYdRyg7Jqv9Z2A0EdgfjRkbtdmNrlWaJo=;
 b=cq/Tl1anBVTdIjA/1yrr4+hJwOHSjsKHDuj/oMssGvRDk3HuIcOe4cSn2Hnw3BUqWXaL
 l7S7LTq82RLHU8ocLCo/Zg8jiYgfngfrRbUdUb9zfME+0QZ7t8Yf+hlGHtGzBjdfWfzd
 81ntH71OYzfJJDoOXxukK97movcTdiyMNsDbbyLp/CyI9GiSE3abGmLIg+ZIzcWLpL7E
 ok297bAusZV7PAsN7SLx3OMZyKLHPo7+aBNZ3qkKM/gQI1tlEuYRhBs+UfeIAIshHHm7
 8NDoXOjpvESzlKAU+3mT92njgXS9Z3hEHZpkYVT0IQQ0X7Qq34pnp9SRsHblLiiIdP57 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwwbtg35k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 03:27:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V3RPcf024123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 03:27:25 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 20:27:20 -0700
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 1/2] dt-bindings: arm: qcom: document AL02-C9 board based on IPQ9574 family
Date:   Wed, 31 May 2023 08:56:47 +0530
Message-ID: <20230531032648.23816-2-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230531032648.23816-1-quic_poovendh@quicinc.com>
References: <20230531032648.23816-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IEniWx28uh9KxCOaLLfnX1I8m9BlARSo
X-Proofpoint-ORIG-GUID: IEniWx28uh9KxCOaLLfnX1I8m9BlARSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=995 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document AL02-C9 (Reference Design Platform 454) board based on IPQ9574
family of SoCs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
Changes in V2:
	- Picked up the Acked-by tag

 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 8302d1ee280d..8be798123385 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -90,6 +90,7 @@ description: |
         ap-al02-c6
         ap-al02-c7
         ap-al02-c8
+        ap-al02-c9
         ap-mi01.2
         ap-mi01.3
         ap-mi01.6
@@ -361,6 +362,7 @@ properties:
               - qcom,ipq9574-ap-al02-c6
               - qcom,ipq9574-ap-al02-c7
               - qcom,ipq9574-ap-al02-c8
+              - qcom,ipq9574-ap-al02-c9
           - const: qcom,ipq9574
 
       - description: Sierra Wireless MangOH Green with WP8548 Module
-- 
2.17.1

