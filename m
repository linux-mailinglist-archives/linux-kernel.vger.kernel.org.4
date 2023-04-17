Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C53D6E4F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDQRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDQRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:45:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BFC16A;
        Mon, 17 Apr 2023 10:45:20 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HDtfgN011126;
        Mon, 17 Apr 2023 17:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bL1nb4ZZwTYBubW2qkx1/JhoI/53lfN5atG1UAAhM74=;
 b=EfQWDOt0+ILVQQmD4XZfcbmb8Wqz5slGHWAQ2MyHJSvGSaQcpwROiPclRnxsKRWrKIH9
 bll3YMvXnAx4J8Ho78ixxY6E46qU/GuxDOX+ZSsWJG0TNymYShEti+dKneodb8Ydy+QI
 utvzo6o5UkRoJ29SrsCrl8VUDt26aTTTNR5HJVMUXupF/6I47vMkUdX6gkUzMZ36DZWl
 eD7Fl3ArhVHNdJTfLUiGAw5yqcYPPdma96FGqHfMn/vbdbW6YkApzcOV+XZRy+//OFIz
 VktNaxcCSLsNJapJnzN1bgqQc0nDbqs1FspECk0RTjJZtErV+97IJAU+tmLTTNSYHnuP 9w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymp4cbpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 17:44:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HHiMvD023049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 17:44:22 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 10:44:21 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v3 1/2] dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
Date:   Mon, 17 Apr 2023 10:44:00 -0700
Message-ID: <20230417174401.19563-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230417174401.19563-1-quic_nkela@quicinc.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230417174401.19563-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k1w59saeLgfXEkMcmaKqiV-HEQLWDSJ8
X-Proofpoint-ORIG-GUID: k1w59saeLgfXEkMcmaKqiV-HEQLWDSJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_11,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smc/hvc calls are made with smc-id only. The parameters are
all set to zeros. This patch defines a new compatible string that can
be used to pass shmem address as one parameter in SMC/HVC doorbell.

This is useful when multiple scmi instances are used with common smc-id.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..e1f39a10d405 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -34,6 +34,10 @@ properties:
       - description: SCMI compliant firmware with ARM SMC/HVC transport
         items:
           - const: arm,scmi-smc
+      - description: SCMI compliant firmware with ARM SMC/HVC transport
+                     with shmem address as parameter
+        items:
+          - const: arm,scmi-smc-param
       - description: SCMI compliant firmware with SCMI Virtio transport.
                      The virtio transport only supports a single device.
         items:
@@ -299,7 +303,9 @@ else:
     properties:
       compatible:
         contains:
-          const: arm,scmi-smc
+          enum:
+            - arm,scmi-smc
+            - arm,scmi-smc-param
   then:
     required:
       - arm,smc-id
-- 
2.17.1

