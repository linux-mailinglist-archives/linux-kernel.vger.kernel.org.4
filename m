Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14575B8546
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiINJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiINJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:40:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3501928C;
        Wed, 14 Sep 2022 02:39:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dLRW098641;
        Wed, 14 Sep 2022 04:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663148361;
        bh=voil66pq2xcvIlp0IN3QHMjFzxBwFruYToUKnjtNp2g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nG2m2MGGk0a8994Z679y16TG90Kcb88iVEhB+0nsaWqtKxa9qcEgJifNXjHaw+SvS
         c1b33/LmZULPMVMjK/gEnDPSS7FQ4KooyZmghuaSXir1HRtmAzMyvlMabQhHwh0m5z
         28Hgj24HYrufibFaqZrQJAUJmttcjdXFFkdvn2dc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28E9dLg2119194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Sep 2022 04:39:21 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 14
 Sep 2022 04:39:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 14 Sep 2022 04:39:21 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dBHE111966;
        Wed, 14 Sep 2022 04:39:17 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J721e
Date:   Wed, 14 Sep 2022 15:09:06 +0530
Message-ID: <20220914093911.187764-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914093911.187764-1-s-vadapalli@ti.com>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
that are not supported on earlier SoCs. Add a compatible for it.

Extend ti,qsgmii-main-ports property to support selection of upto
two main ports at once across the two QSGMII interfaces.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 52 ++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index da7cac537e15..1e19efab018b 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -54,6 +54,7 @@ properties:
       - ti,dm814-phy-gmii-sel
       - ti,am654-phy-gmii-sel
       - ti,j7200-cpsw5g-phy-gmii-sel
+      - ti,j721e-cpsw9g-phy-gmii-sel
 
   reg:
     maxItems: 1
@@ -65,12 +66,19 @@ properties:
     description: |
       Required only for QSGMII mode. Array to select the port for
       QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
-      ports automatically. Any one of the 4 CPSW5G ports can act as the
-      main port with the rest of them being the QSGMII_SUB ports.
-    maxItems: 1
-    items:
-      minimum: 1
-      maximum: 4
+      ports automatically. For J7200 CPSW5G with the compatible:
+      ti,j7200-cpsw5g-phy-gmii-sel, ti,qsgmii-main-ports is an
+      array of only one element, which is the port number ranging from
+      1 to 4. For J721e CPSW9G with the compatible:
+      ti,j721e-cpsw9g-phy-gmii-sel, ti,qsgmii-main-ports is an array
+      of two elements, which corresponds to two potential QSGMII main
+      ports. The first element and second element of the array can both
+      range from 1 to 8 each, corresponding to two QSGMII main ports.
+      For J721e CPSW9G, to configure port 2 as the first QSGMII main
+      port and port 7 as the second QSGMII main port, we specify:
+      ti,qsgmii-main-ports = <2>, <7>;
+      If only one QSGMII main port is desired, mention the same main
+      port twice.
 
 allOf:
   - if:
@@ -81,12 +89,43 @@ allOf:
               - ti,dra7xx-phy-gmii-sel
               - ti,dm814-phy-gmii-sel
               - ti,am654-phy-gmii-sel
+              - ti,j7200-cpsw5g-phy-gmii-sel
+              - ti,j721e-cpsw9g-phy-gmii-sel
     then:
       properties:
         '#phy-cells':
           const: 1
           description: CPSW port number (starting from 1)
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,j7200-cpsw5g-phy-gmii-sel
+    then:
+      properties:
+        ti,qsgmii-main-ports:
+          maxItems: 1
+          items:
+            minimum: 1
+            maximum: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,j721e-cpsw9g-phy-gmii-sel
+    then:
+      properties:
+        ti,qsgmii-main-ports:
+          minItems: 2
+          maxItems: 2
+          items:
+            minimum: 1
+            maximum: 8
+
   - if:
       not:
         properties:
@@ -94,6 +133,7 @@ allOf:
             contains:
               enum:
                 - ti,j7200-cpsw5g-phy-gmii-sel
+                - ti,j721e-cpsw9g-phy-gmii-sel
     then:
       properties:
         ti,qsgmii-main-ports: false
-- 
2.25.1

