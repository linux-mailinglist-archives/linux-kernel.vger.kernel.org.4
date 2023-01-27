Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8151D67E915
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjA0PLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjA0PLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:11:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929080179;
        Fri, 27 Jan 2023 07:11:23 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RDlNHZ021451;
        Fri, 27 Jan 2023 15:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=91idBUbdIfOr0IZ3DR2hHSVL5JCnzTMJNpoHN5YShWg=;
 b=hS2IeEjNEoZ5VmW+mtHdbH/aEeFblPqGHt95S/rSTSeZTNhk4eFE+EI2NQcReFbm31SC
 J2du9HnKeWtqszCFQbx3aY4znIP1OYYWpK/0WIcLN1dOAo0v6WyQWO6UrZqGQ/5cMnXe
 i+Op+q6xnskzJgdwEaSFV/14mzaGxsr2b/4RU4EE6o2pHhSOBYntF5W56gO7pMcevUPq
 VEOTuz4kWXpJZ4SeMECoO6pKDFfR/OU8NgB1jVS/zLBvevYBXNgZt0N3L1bZUqTWWx1x
 q07bk0O1PYpGvhv1KcjWokwJUeysLrrGfttBdaKgICRQIFd+uF7Q4MJeabE5dAxcBlnP fQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbyma1m4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:11:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RFB8Ch024156
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:11:08 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 07:11:05 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: ramoops: Inherit reserve memory property
Date:   Fri, 27 Jan 2023 20:40:35 +0530
Message-ID: <1674832236-6754-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mBHyGmpBQl6jFonsw6XyjZMtziCOeB7h
X-Proofpoint-GUID: mBHyGmpBQl6jFonsw6XyjZMtziCOeB7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301270143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved memory region for ramoops is assumed to be at a
fixed and known location when read from the devicetree. This
is not desirable in an environment where it is preferred the
region to be dynamically allocated at runtime, as opposed to
being fixed at compile time.

So, update the ramoops binding by inheriting some reserve memory
property to allocate the ramoops region dynamically.

Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v3:
 - Fixed yaml error and updated commit text as per comment.

Change in v2:
  - Added this patch as per changes going to be done in patch 3/3

 .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
index 0391871..8741626 100644
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
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reserved-memory {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            ramoops: ramoops_region {
+                compatible = "ramoops";
+                alloc-ranges = <0x00000000 0xffffffff>;
+                size = <0x0 0x10000>;       /* 64kB */
+                console-size = <0x8000>;    /* 32kB */
+                record-size = <0x400>;      /*  1kB */
+                ecc-size = <16>;
+            };
+        };
+    };
-- 
2.7.4

