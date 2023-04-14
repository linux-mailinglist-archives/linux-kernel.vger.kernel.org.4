Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665626E214B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjDNKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDNKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:52:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F180549E7;
        Fri, 14 Apr 2023 03:52:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EAqWrC022563;
        Fri, 14 Apr 2023 05:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681469552;
        bh=wjW5Q9o+zPh4H7+BmKkO/pXqv81GHjtQdM7IPo0mjJo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WZPibKXaZpeYvLV/YitX7KkMprTMRdIuXq4rSWZmO8J3zIT0Khsd7wWfRNsEnsbjN
         6vaWAN5TuVSrXGkaWi5+iG5SWJBNgB3MSSzIqaj9zc4feTw6uvx8nzmq1AQo7A1PSS
         4FbMWe1qvNC6c1NvWY9LqoL8TTr394nflKSeXl9w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EAqWpL114099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 05:52:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 05:52:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 05:52:31 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EAqPpf077262;
        Fri, 14 Apr 2023 05:52:29 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <u-boot@lists.denx.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH 1/3] dt-bindings: misc: esm: Add ESM support for TI K3 devices
Date:   Fri, 14 Apr 2023 16:22:23 +0530
Message-ID: <20230414105225.194195-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414105225.194195-1-n-francis@ti.com>
References: <20230414105225.194195-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for TI K3 ESM (Error Signaling Module) block.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 .../devicetree/bindings/misc/esm-k3.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/esm-k3.yaml

diff --git a/Documentation/devicetree/bindings/misc/esm-k3.yaml b/Documentation/devicetree/bindings/misc/esm-k3.yaml
new file mode 100644
index 000000000000..5e637add3b0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/esm-k3.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/esm-k3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 ESM Binding
+
+maintainers:
+  - Neha Malcom Francis <n-francis@ti.com>
+
+description: |
+  The ESM (Error Signaling Module) is an IP block on TI K3 devices
+  that allows handling of safety events somewhat similar to what interrupt
+  controller would do. The safety signals have their separate paths within
+  the SoC, and they are handld by the ESM, which routes them to the proper
+  destination, which can be system reset, interrupt controller, etc. In the
+  simplest configuration the signals are just routed to reset the SoC.
+
+properties:
+  compatible:
+    const: ti,j721e-esm
+
+  reg:
+    items:
+      - description: physical address and length of the registers which
+          contain revision and debug features
+      - description: physical address and length of the registers which
+          indicate strapping options
+
+  ti,esm-pins:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      integer array of ESM event IDs to route to external event pin which can
+      be used to reset the SoC. The array can have an arbitrary amount of event
+      IDs listed on it.
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
+    main_esm: esm@700000 {
+        compatible = "ti,j721e-esm";
+        reg = <0x0 0x700000 0x0 0x1000>;
+        ti,esm-pins = <344>, <345>;
+    };
-- 
2.34.1

