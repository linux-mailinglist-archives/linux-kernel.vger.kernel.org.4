Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C535866967B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbjAMMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjAMMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:07:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21138E3;
        Fri, 13 Jan 2023 03:59:26 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBA0Jp030099;
        Fri, 13 Jan 2023 11:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=tUm6z8rhz5JYg4o8nm0MDjJ+lFRhmC9Z6zMZeJ23joo=;
 b=XOjEGu0nMYAKblUuw08qsV3r01MGl/7u8E/GR/NotQEIaHrrB3BzruXvA4ynXDqA6MfW
 1JM4+DH39zqEiaRFxZVB7lNzk93ILNWz10Xu6qpli+/19jBDSXyVdUwJpmrvZQSDa7ar
 NmAHF8+7879PVggQKj8SJ8nrSkWyqv14ckuHSz/3K/YEfv8nPGBKD77a/KRcz9zZE3ZM
 aPdUmfW+3ufzrZijw4fUIImv7AbRM/JwXerlONjUxr6l7kJqHoGW27RX7SZf6sn8/4ti
 6rlMbGyGrVFI1X0zHl6fvh3lPtdMKB530sJgSQd/MNbDB41J4wQB/qb7g4catUznBDyK aA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2jghtk79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 11:59:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DBx4dq025641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 11:59:04 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 03:59:00 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <keescook@chromium.org>, <gpiccoli@igalia.com>, <corbet@lwn.net>,
        <tony.luck@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: reserved-memory: ramoops: Update the binding
Date:   Fri, 13 Jan 2023 17:28:44 +0530
Message-ID: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8eDys0jK4zvAYYr57p5RD86TQAo9kAma
X-Proofpoint-ORIG-GUID: 8eDys0jK4zvAYYr57p5RD86TQAo9kAma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ramoops region binding document with details
like region can also be reserved dynamically apart from
reserving it statically.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Change in v2:
  - Added this patch as per changes going to be done in patch 3/3

 .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
index 0391871..54e46e8 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -10,7 +10,8 @@ description: |
   ramoops provides persistent RAM storage for oops and panics, so they can be
   recovered after a reboot. This is a child-node of "/reserved-memory", and
   is named "ramoops" after the backend, rather than "pstore" which is the
-  subsystem.
+  subsystem. This region can be reserved both statically or dynamically by
+  using appropriate property in device tree.
 
   Parts of this storage may be set aside for other persistent log buffers, such
   as kernel log messages, or for optional ECC error-correction data.  The total
@@ -112,7 +113,13 @@ unevaluatedProperties: false
 
 required:
   - compatible
-  - reg
+
+oneOf:
+  - required:
+      - reg
+
+  - required:
+      - size
 
 anyOf:
   - required: [record-size]
@@ -142,3 +149,26 @@ examples:
             };
         };
     };
+
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        reserved-memory {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            ramoops: ramoops_region {
+                compatible = "ramoops";
+                alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
+                size = <0x0 0x10000>;       /* 64kB */
+                console-size = <0x8000>;    /* 32kB */
+                record-size = <0x400>;      /*  1kB */
+                ecc-size = <16>;
+            };
+        };
+    };
-- 
2.7.4

