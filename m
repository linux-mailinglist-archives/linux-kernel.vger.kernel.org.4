Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53866C3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjAPPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjAPPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:21:52 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DBB22DC5;
        Mon, 16 Jan 2023 07:19:24 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30GFJBqb009706;
        Mon, 16 Jan 2023 09:19:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673882351;
        bh=vHrxstu4j6B6NPSRXPP63UQmzs8+3dWvGgCFr8Nrku4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=m28/A0UWW35F4UNxgXkNey9exUtIcFaI74SVyloqNTaakfgM6VtWMGWzTGRIlZyH8
         40fdPoZvziwSwvRQUqFI9uahIk18zDcjPppEHkyTN36UAGjE3U+nXogFctgS72FNIl
         XLvpldDIw2Fe1vsB7hPZ6qSvPYb/dZ9l639zJX4s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30GFJBSn039175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 09:19:11 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 09:19:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 09:19:10 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30GFJ9nX007251;
        Mon, 16 Jan 2023 09:19:10 -0600
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v6 2/3] dt-bindings: remoteproc: ti: Add new compatible for AM62 SoC family
Date:   Mon, 16 Jan 2023 20:49:05 +0530
Message-ID: <20230116151906.549384-3-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116151906.549384-1-devarsht@ti.com>
References: <20230116151906.549384-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 family of devices don't have a R5F cluster, instead
they have single core DM R5F.
Add new compatible string ti,am62-r5fss to support this scenario.

When this new compatible is used cluster-mode
property can only be set to value 3 i.e.
CLUSTER_MODE_SINGLECORE which is also the default value
in case cluster-mode is not defined in device-tree.

While at it, also sort the compatible lists in alphabetical order.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: Avoid acronyms, use "Device Manager" instead of "DM"
V3:
- Use separate if block for each compatible for ti,cluster-mode
property
- Rearrange compatibles as per alphabatical order
V4: Place each enum in separate line in allOf
V5: No change (fixing typo in email address)
V6: Use cluster-mode=3 for am62x
---
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 76 ++++++++++++++-----
 1 file changed, 55 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index fb9605f0655b..fcc3db97fe8f 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -21,6 +21,9 @@ description: |
   called "Single-CPU" mode, where only Core0 is used, but with ability to use
   Core1's TCMs as well.
 
+  AM62 SoC family support a single R5F core only which runs Device Manager
+  firmware and can also be used as a remote processor with IPC communication.
+
   Each Dual-Core R5F sub-system is represented as a single DTS node
   representing the cluster, with a pair of child DT nodes representing
   the individual R5F cores. Each node has a number of required or optional
@@ -34,10 +37,11 @@ properties:
 
   compatible:
     enum:
+      - ti,am62-r5fss
+      - ti,am64-r5fss
       - ti,am654-r5fss
-      - ti,j721e-r5fss
       - ti,j7200-r5fss
-      - ti,am64-r5fss
+      - ti,j721e-r5fss
       - ti,j721s2-r5fss
 
   power-domains:
@@ -64,10 +68,17 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Configuration Mode for the Dual R5F cores within the R5F cluster.
-      Should be either a value of 1 (LockStep mode) or 0 (Split mode) on
+      For most SoCs (AM65x, J721E, J7200, J721s2),
+      It should be either a value of 1 (LockStep mode) or 0 (Split mode) on
       most SoCs (AM65x, J721E, J7200, J721s2), default is LockStep mode if
-      omitted; and should be either a value of 0 (Split mode) or 2
-      (Single-CPU mode) on AM64x SoCs, default is Split mode if omitted.
+      omitted.
+      For AM64x SoCs,
+      It  should be either a value of 0 (Split mode) or 2 (Single-CPU mode) and
+      default is Split mode if omitted.
+      For AM62x SoCs,
+      It should be set as 3 (Single-Core mode) which is also the default if
+      omitted.
+
 
 # R5F Processor Child Nodes:
 # ==========================
@@ -80,7 +91,9 @@ patternProperties:
       node representing a TI instantiation of the Arm Cortex R5F core. There
       are some specific integration differences for the IP like the usage of
       a Region Address Translator (RAT) for translating the larger SoC bus
-      addresses into a 32-bit address space for the processor.
+      addresses into a 32-bit address space for the processor. For AM62x,
+      the R5F Sub-System device node should only define one R5F child node
+      as it has only one core available.
 
       Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
       internal memories split between two banks - TCMA and TCMB (further
@@ -100,10 +113,11 @@ patternProperties:
     properties:
       compatible:
         enum:
+          - ti,am62-r5f
+          - ti,am64-r5f
           - ti,am654-r5f
-          - ti,j721e-r5f
           - ti,j7200-r5f
-          - ti,am64-r5f
+          - ti,j721e-r5f
           - ti,j721s2-r5f
 
       reg:
@@ -208,19 +222,39 @@ patternProperties:
 
     unevaluatedProperties: false
 
-if:
-  properties:
-    compatible:
-      enum:
-        - ti,am64-r5fss
-then:
-  properties:
-    ti,cluster-mode:
-      enum: [0, 2]
-else:
-  properties:
-    ti,cluster-mode:
-      enum: [0, 1]
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-r5fss
+    then:
+      properties:
+        ti,cluster-mode:
+          enum: [0, 2]
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am654-r5fss
+            - ti,j7200-r5fss
+            - ti,j721e-r5fss
+            - ti,j721s2-r5fss
+    then:
+      properties:
+        ti,cluster-mode:
+          enum: [0, 1]
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am62-r5fss
+    then:
+      properties:
+        ti,cluster-mode:
+          enum: [3]
 
 required:
   - compatible
-- 
2.34.1

