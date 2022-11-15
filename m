Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715846291BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiKOGJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiKOGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:09:43 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B52AEE;
        Mon, 14 Nov 2022 22:09:42 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AF69bok087478;
        Tue, 15 Nov 2022 00:09:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668492577;
        bh=K2f76TnhL36/ffM13oFq1jnEmiuARv0SpdvGfCglXrE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=E5niqfdb7NG34NFnAkHewvgUfZh5E0szPBNNJxEMpLsZEdPJK/7LNo7I7fbWTwbpl
         aX0+5HfSBBRhpHIkcEHT8KSKazdS+mbs6CjPS3RgFdw4N05DSQl0k3tTIFABii5j3n
         drCiH7ojx9vRz5TyyHMDmt2OjNcQ0XRxjLl1ne18=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AF69b5L006746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 00:09:37 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 00:09:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 00:09:36 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AF69Zf7034469;
        Tue, 15 Nov 2022 00:09:36 -0600
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>
Subject: [PATCH 1/2] Documentation: dt-bindings: k3-r5f-rproc: Add new compatible for AM62 SoC family
Date:   Tue, 15 Nov 2022 11:39:33 +0530
Message-ID: <20221115060934.13279-2-devarsht@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115060934.13279-1-devarsht@ti.com>
References: <20221115060934.13279-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 family of devices don't have a R5F cluster, instead
they have single core DM R5F.
Add new compatible string ti,am62-r5fss to support this scenario.

When this new compatible is used don't allow cluster-mode
property usage in device-tree as this implies that there
is no R5F cluster available and only single R5F core
is present.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 48 +++++++++++++------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index fb9605f0655b..1f5eae806c2f 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -21,6 +21,9 @@ description: |
   called "Single-CPU" mode, where only Core0 is used, but with ability to use
   Core1's TCMs as well.
 
+  AM62 SoC family support a single R5F core only which is used for DM firmware
+  and can also be used as a remote processor with IPC communication.
+
   Each Dual-Core R5F sub-system is represented as a single DTS node
   representing the cluster, with a pair of child DT nodes representing
   the individual R5F cores. Each node has a number of required or optional
@@ -28,6 +31,9 @@ description: |
   the device management of the remote processor and to communicate with the
   remote processor.
 
+  Since AM62 SoC family only support a single core, there is no cluster-mode
+  property setting required for it.
+
 properties:
   $nodename:
     pattern: "^r5fss(@.*)?"
@@ -38,6 +44,7 @@ properties:
       - ti,j721e-r5fss
       - ti,j7200-r5fss
       - ti,am64-r5fss
+      - ti,am62-r5fss
       - ti,j721s2-r5fss
 
   power-domains:
@@ -80,7 +87,8 @@ patternProperties:
       node representing a TI instantiation of the Arm Cortex R5F core. There
       are some specific integration differences for the IP like the usage of
       a Region Address Translator (RAT) for translating the larger SoC bus
-      addresses into a 32-bit address space for the processor.
+      addresses into a 32-bit address space for the processor. For AM62x,
+      should only define one R5F child node as it has only one core available.
 
       Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
       internal memories split between two banks - TCMA and TCMB (further
@@ -104,6 +112,7 @@ patternProperties:
           - ti,j721e-r5f
           - ti,j7200-r5f
           - ti,am64-r5f
+          - ti,am62-r5f
           - ti,j721s2-r5f
 
       reg:
@@ -207,20 +216,31 @@ patternProperties:
       - firmware-name
 
     unevaluatedProperties: false
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
+    else:
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
+        ti,cluster-mode: false
 
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
 
 required:
   - compatible
-- 
2.17.1

