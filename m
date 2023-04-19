Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22B6E762E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjDSJ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjDSJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:26:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7103AF;
        Wed, 19 Apr 2023 02:26:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J9Q6YP071096;
        Wed, 19 Apr 2023 04:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681896366;
        bh=OE6isOxwACqnkPpdmJsY1U2qyVXgwLkbhOi8+TI5Qps=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aOPWHUmeAPRfYR/FbbB+GSHBOvTBaqVUsDM6xserzqby1CnJCwAVUV/VTaHEI4rcW
         xduIUgZgt/NOWMjlL8Gmqew05nqeC8TLkRW7Bu12BtLK2wrmEQRgPhPK5wjicSfQxI
         eQ6WmiRgO0LR/J5ix3ai1s/VTCbWcnT4qRyrQ7oI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J9Q6xH110879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 04:26:06 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 04:26:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 04:26:06 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J9Pxnc086968;
        Wed, 19 Apr 2023 04:26:03 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: misc: esm: Add ESM support for TI K3 devices
Date:   Wed, 19 Apr 2023 14:55:57 +0530
Message-ID: <20230419092559.673869-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419092559.673869-1-n-francis@ti.com>
References: <20230419092559.673869-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for TI K3 ESM (Error Signaling Module) block.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 .../bindings/hwmon/ti,j721e-esm.yaml          | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml b/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
new file mode 100644
index 000000000000..7b23ac7cb3ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,j721e-esm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 ESM
+
+maintainers:
+  - Neha Malcom Francis <n-francis@ti.com>
+
+description:
+  The ESM (Error Signaling Module) is an IP block on TI K3 devices
+  that allows handling of safety events somewhat similar to what interrupt
+  controller would do. The safety signals have their separate paths within
+  the SoC, and they are handled by the ESM, which routes them to the proper
+  destination, which can be system reset, interrupt controller, etc. In the
+  simplest configuration the signals are just routed to reset the SoC.
+
+properties:
+  compatible:
+    const: ti,j721e-esm
+
+  reg:
+    items:
+      - description: the ESM register set
+
+  ti,esm-pins:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      integer array of ESM interrupt pins to route to external event pin
+      which can be used to reset the SoC.
+    minItems: 1
+    maxItems: 255
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - ti,esm-pins
+
+examples:
+  - |
+    cbass_main {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+        esm@700000 {
+            compatible = "ti,j721e-esm";
+            reg = <0x0 0x700000 0x0 0x1000>;
+            ti,esm-pins = <344>, <345>;
+        };
+    };
-- 
2.34.1

