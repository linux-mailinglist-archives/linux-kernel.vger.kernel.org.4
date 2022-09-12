Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B325B56D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiILI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiILI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:57:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC4F186EF;
        Mon, 12 Sep 2022 01:57:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28C8v4CM009441;
        Mon, 12 Sep 2022 03:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662973024;
        bh=i6LveOgiJZ1X0nkjVcO6bCbjbMf2g4faEss3nMkVqUA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JoNyQQ8nbTOr2nZ+ziEn3fhm06Ca6BqMenmlh+mpFbW5UIT5dFXlVUPyznQlqJ321
         s2AhzK7Kjrgrl3QYFVA5s8qboB7Bk8HmqXQhSLylq3+iE+nY3+/bUTFdPlwjK9z5eK
         NoIRgPdnXl00iD8WLOuNv7Nb0wK1G/IfSQGgjmBE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28C8v4pB004825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Sep 2022 03:57:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 12
 Sep 2022 03:57:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 12 Sep 2022 03:57:04 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28C8up6w104303;
        Mon, 12 Sep 2022 03:57:00 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v5 2/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
Date:   Mon, 12 Sep 2022 14:26:49 +0530
Message-ID: <20220912085650.83263-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912085650.83263-1-s-vadapalli@ti.com>
References: <20220912085650.83263-1-s-vadapalli@ti.com>
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

TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
that are not supported on earlier SoCs. Add a compatible for it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../mfd/ti,j721e-system-controller.yaml       |  6 +++++
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 25 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index 1aeac43cad92..873ee0c0973f 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -54,6 +54,12 @@ patternProperties:
     description:
       Clock provider for TI EHRPWM nodes.
 
+  "phy@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
+    description:
+      The phy node corresponding to the ethernet MAC.
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index 016a37db1ea1..da7cac537e15 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -53,12 +53,25 @@ properties:
       - ti,am43xx-phy-gmii-sel
       - ti,dm814-phy-gmii-sel
       - ti,am654-phy-gmii-sel
+      - ti,j7200-cpsw5g-phy-gmii-sel
 
   reg:
     maxItems: 1
 
   '#phy-cells': true
 
+  ti,qsgmii-main-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Required only for QSGMII mode. Array to select the port for
+      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
+      ports automatically. Any one of the 4 CPSW5G ports can act as the
+      main port with the rest of them being the QSGMII_SUB ports.
+    maxItems: 1
+    items:
+      minimum: 1
+      maximum: 4
+
 allOf:
   - if:
       properties:
@@ -73,6 +86,18 @@ allOf:
         '#phy-cells':
           const: 1
           description: CPSW port number (starting from 1)
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ti,j7200-cpsw5g-phy-gmii-sel
+    then:
+      properties:
+        ti,qsgmii-main-ports: false
+
   - if:
       properties:
         compatible:
-- 
2.25.1

