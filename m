Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289B6F9392
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEFSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEFSZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:25:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2B1568D;
        Sat,  6 May 2023 11:25:00 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 346IAGgB030752;
        Sat, 6 May 2023 18:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Yv4g18ExX5u0yvs/fL8uwt6a4Lfy32SRuuoBb4ZVqCk=;
 b=kpryvZxqToCZruosQctcRqEWYLQ55fIm66CO/r2clgbzu0R6wENmx51510rvk1+nWBDq
 V/DpfdUUUbx4f0ZZn6mwcMCeCVeK/uoxXkPTjEkacGO9K+5I953qpZ2lfDlVEqJ2fliY
 NFxmT2u0EYMzIKjxBzHrD7VWDgRi4RLna4Sj/WsZeGBZW5yPcEUVzS0mCmx/NIqCaEJn
 TMbp0A57q96D6Bt/SkXiEyc3JGABfNeg8XEkBXKZpIKeQZd0VGOBEyCFCaBa2LnriyPU
 U7obdfrVqxQFlkUfkCXBDjL3hg1Gs5xGxcNkWmaMmd6642mWpo5C9ckv/o/KUX/8v3Cr CQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qdf040tqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 May 2023 18:24:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 346IOmDC012609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 6 May 2023 18:24:48 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 6 May 2023 11:24:47 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v5 1/2] dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
Date:   Sat, 6 May 2023 11:24:27 -0700
Message-ID: <20230506182428.25343-2-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230506182428.25343-1-quic_nkela@quicinc.com>
References: <20230506182428.25343-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hoNskiPvXpYw_7Hy9BRaPcha9ehhexzw
X-Proofpoint-ORIG-GUID: hoNskiPvXpYw_7Hy9BRaPcha9ehhexzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305060144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smc/hvc calls are made with smc-id only. The parameters are
all set to zeros. This change defines a new compatible string that can
be used to pass shmem address(4KB-page, offset) as two parameters in
SMC/HVC doorbell.

This is useful when multiple scmi instances are used with common smc-id.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..ad776911f990 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -34,6 +34,10 @@ properties:
       - description: SCMI compliant firmware with ARM SMC/HVC transport
         items:
           - const: arm,scmi-smc
+      - description: SCMI compliant firmware with ARM SMC/HVC transport
+                     with shmem address(4KB-page, offset) as parameters
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

