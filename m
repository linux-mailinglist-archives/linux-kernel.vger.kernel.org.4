Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2C7094D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjESKcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjESKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:31:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595EFE6E;
        Fri, 19 May 2023 03:31:58 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J40xvq000399;
        Fri, 19 May 2023 10:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=C0T4KVjVwdjmQPY3G2mJg6JS5CPGQY9lwL2Bi+l7VkI=;
 b=e1sIwyi7BQFSoYa1c9iA4Xa6F/EIo/kXVaUAudFO0D9dqrQXWXg/ao+MfFJbEzFHKrCA
 HudRJ+iNdLZGOfO0zGGyt4cSKnIuaBTUljEnVRl8Ca2VOq+vUteygQqN/06NSTzrlZ77
 7U0NsllfGR3RtX8GpMJFOdreEf2GWB6hOAk0rbEF5M0nS7XJB0q+/DrQqHSaTTKj/8Ih
 GY8E4mw9lqz1a91Ail45u8VQTEKNcYZ5u6WMCAe5VIL+CM9OAnT+F0Jz/84nzPdVfKdM
 H4LlXFcuP9PHKQbxWmZbq5sH3W+6PCOdY+4FOgwc3C+0wqz1GITKGzd6TpSl6Y6FGYUl EA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp0gk8ub1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:31:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JAVqG4000565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:31:52 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 03:31:47 -0700
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
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-C9 board based on IPQ9574 family
Date:   Fri, 19 May 2023 16:01:27 +0530
Message-ID: <20230519103128.30783-2-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519103128.30783-1-quic_poovendh@quicinc.com>
References: <20230519103128.30783-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cQWyEffFBd8nvbRleb6bM6-JQ37uvRXr
X-Proofpoint-ORIG-GUID: cQWyEffFBd8nvbRleb6bM6-JQ37uvRXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305190089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>

Document AL02-C9 (Reference Design Platform 454) board based on IPQ9574
family of SoCs.

Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index febf057012d4..fe7ed853e598 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -88,6 +88,7 @@ description: |
         ap-al02-c2
         ap-al02-c6
         ap-al02-c7
+        ap-al02-c9
         ap-mi01.2
         ap-mi01.6
         cdp
@@ -356,6 +357,7 @@ properties:
               - qcom,ipq9574-ap-al02-c2
               - qcom,ipq9574-ap-al02-c6
               - qcom,ipq9574-ap-al02-c7
+              - qcom,ipq9574-ap-al02-c9
           - const: qcom,ipq9574
 
       - description: Sierra Wireless MangOH Green with WP8548 Module
-- 
2.17.1

