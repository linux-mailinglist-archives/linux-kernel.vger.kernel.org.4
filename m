Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96674D3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjGJKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjGJKiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:38:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E8E3;
        Mon, 10 Jul 2023 03:38:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A8xhIe008012;
        Mon, 10 Jul 2023 10:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=u/DwDH2n/Z0MxREbI5gMlCljTRrvD0J9NWub+hZfLOU=;
 b=h7b+ltl+yiarms2ZBzsuoVMziCpNVidHC2a0WvQicJzufJwHAovrScpndwQPWEukhyGf
 Z+CK6/VX2NGMiCoaa6/mQoQdBHpLYgid3cdej7ESNM/OIuGL6YwLWWgTUqIbPZ6+D7Z8
 XzKr3k4MGXVAMsB0Q0ADvVXHb7V8VfQVDhRWYhZdwJWSksxw/cqYTpCs3XuFa6jxNzeW
 y8LsshUdzrJ1R341GuIUNqcHTBkKet79Rsi6abeXvSl0HtKqKSYlEymHMzdz/NSRKPrR
 7C2CuSZNfy4TOi37l73cWYyAnaDc8LXQ9hGxqG1SBmgu2maB4EDczJy1k7swufRhNOM4 ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyd6uag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AAcAr9017283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:10 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:38:05 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 3/6] dt-bindings: thermal: tsens: Add ipq5332 compatible
Date:   Mon, 10 Jul 2023 16:07:32 +0530
Message-ID: <20230710103735.1375847-4-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LUbr4zSV2sMbANqKIGt0_PVh6CVBKtTa
X-Proofpoint-ORIG-GUID: LUbr4zSV2sMbANqKIGt0_PVh6CVBKtTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 uses TSENS v2.3.3 with combined interrupt. RPM is not
available in the SoC, hence adding new compatible to have the
sensor enablement and calibration function.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 8b7863c3989e..ee57713f6131 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -68,8 +68,10 @@ properties:
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt
-        enum:
-          - qcom,ipq8074-tsens
+        items:
+          - enum:
+              - qcom,ipq8074-tsens
+              - qcom,ipq5332-tsens
 
       - description: v2 of TSENS with combined interrupt
         items:
@@ -289,6 +291,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-tsens
+              - qcom,ipq5332-tsens
     then:
       properties:
         interrupts:
@@ -304,6 +307,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-tsens
+              - qcom,ipq5332-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

