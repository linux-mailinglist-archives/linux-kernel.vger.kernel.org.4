Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97796F1AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbjD1OxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbjD1OxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:53:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B7526F;
        Fri, 28 Apr 2023 07:53:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SDwjMI020795;
        Fri, 28 Apr 2023 14:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YT6sin7qrQa3ZRjEgGewAlX1Cnjc9ZhEG9Kem6mKXIQ=;
 b=L/kMKjLu8B96FnI2QrDW4EGqN3H1nhbrptJBk61+aB7amOV1RHBZnyCvVWroDIWFJ5N5
 3AzHmfDxDnzDvIS4gDT989MfNprSc0Ck33hUpXVoNivz66HsJZY0F+CJWNFD1rQ38a5d
 HJYZfnFUBIC1ywYYDXnQBAliJGspjJdj3Z7h11XghT22pi/ITJKDRsqZw2cx6XM9vHMA
 vOchM8PJaQGZdSGKzGwwMNAsE06gTwuoODX2MIZThwmwxoR+lKPGe5LmKvsFrNjRFlN2
 E0/EITz1NFO09AqZBXl0G/R2yx5mG5O7fYGhNfxn96Mt46pO5uh8VhDjNlwJZhoAqzS8 Iw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7wq8ar9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:53:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SEr6h2023689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:53:06 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 28 Apr 2023 07:53:00 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Praveenkumar I <quic_ipkumar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 1/4] dt-bindings: thermal: tsens: Add ipq9574 compatible
Date:   Fri, 28 Apr 2023 20:22:31 +0530
Message-ID: <3c6f7510d175ba5a3c81730b010f6c421b2fbf2d.1682682753.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1682682753.git.quic_varada@quicinc.com>
References: <cover.1682682753.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u19mM4K03FclkrL0CAp6FaLnV1KquR3l
X-Proofpoint-ORIG-GUID: u19mM4K03FclkrL0CAp6FaLnV1KquR3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=946
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d1ec963..8e2208c 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -66,6 +66,7 @@ properties:
       - description: v2 of TSENS with combined interrupt
         enum:
           - qcom,ipq8074-tsens
+          - qcom,ipq9574-tsens
 
   reg:
     items:
@@ -277,6 +278,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-tsens
+              - qcom,ipq9574-tsens
     then:
       properties:
         interrupts:
@@ -292,6 +294,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-tsens
+              - qcom,ipq9574-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
-- 
2.7.4

