Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7067EA45
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjA0QCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA0QC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325418B063;
        Fri, 27 Jan 2023 08:02:01 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFavqC021454;
        Fri, 27 Jan 2023 16:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=/S22GBkuN8cVeMhaytVE3/ENZ87v5s8LO6nyMoxDA20=;
 b=bVWQfxJ9nVf+D7QwGRMEqInO3q9qTiWkFdTTcPEqzze5qG8Y3FA8PeVU6dzcHZnWpUFJ
 JmZ1jJXDvQu1BbEqYC67IS9Sb2Ssya8NuIZE1FDo8Z5ahckIb4nON41jzdjT7mQLmNIY
 zZg8HKgkEOzjH8hRsdw3nO1oH4dGuneaBAxQrimEjMYhOsb9WiGHEWjdqxGzp/RNefsF
 +WZmCeof63uqmQnP7ECfifR2TlOSH4GqwCmradvou6nCN199efaRTrKVxiutRNdmhGJW
 LJsQqH3DDJaoMsz4uXEcLFVMNWfaa69En59g0vr3tLUX4NwIQuhVwm8zvUQ16xP7t/PR VQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncchxrggh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:01:16 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RG19V1021597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:01:09 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 08:01:06 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory property
Date:   Fri, 27 Jan 2023 21:30:51 +0530
Message-ID: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VmMSqO6Cn7xkm1WzqPYAvWqmB6PsJMMJ
X-Proofpoint-GUID: VmMSqO6Cn7xkm1WzqPYAvWqmB6PsJMMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270148
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v4:
 - Addressed comment made by Krzysztof on ramoops node name.

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
+            ramoops_region: ramoops {
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

