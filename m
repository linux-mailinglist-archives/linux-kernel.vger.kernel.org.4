Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72CD6CA8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjC0P25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjC0P2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:28:48 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891B2D69;
        Mon, 27 Mar 2023 08:28:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32RFSb5O120976;
        Mon, 27 Mar 2023 10:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679930917;
        bh=vjPmgr1P1Mrys6D8p7H2HqoMmj6Qy1uYR6ihimvAk8o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MT47KrI44Sdl+iUToBkoLKEF/zOsjsO5dNlYyMsQE5W+bvDsDkWNYQSZocvmgr5oA
         FTbLhjPhqh0tdE/W5TmANIydOXSuz2M3mReunnrW+7Vfu+uvUTb6lJ0aCfrwAOX4i+
         7vDp5E95qYljlYPsViG3ukMZvlezfCWadp40VRJQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32RFSaZv098690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:28:37 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 10:28:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 10:28:36 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32RFSZML103666;
        Mon, 27 Mar 2023 10:28:36 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v8 2/3] dt-bindings: remoteproc: ti: Add new compatible for AM62 SoC family
Date:   Mon, 27 Mar 2023 20:58:31 +0530
Message-ID: <20230327152832.923480-3-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327152832.923480-1-devarsht@ti.com>
References: <20230327152832.923480-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 family of devices don't have a R5F cluster, instead they have
single core DM R5F.  Add new compatible string ti,am62-r5fss to support
this scenario.

When this new compatible is used cluster-mode property can only be set
to value 3 i.e.  CLUSTER_MODE_SINGLECORE which is also the default value
in case cluster-mode is not defined in device-tree.

While at it, also sort the compatible lists in alphabetical order.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

---
V2: Avoid acronyms, use "Device Manager" instead of "DM"
V3:
- Use separate if block for each compatible for ti,cluster-mode
property
- Rearrange compatibles as per alphabatical order
V4: Place each enum in separate line in allOf
V5: No change (fixing typo in email address)
V6: Remove reviewed-by due to new modifications to Use cluster-mode=3
for am62x
V7: No change
V8: Add Reviewed-By
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

