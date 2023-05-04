Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737226F66D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjEDIHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEDIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:06:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70246A0;
        Thu,  4 May 2023 01:06:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34485XDI087733;
        Thu, 4 May 2023 03:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683187533;
        bh=4EBtpAG5F3Ym7EmSZz91biGLB+dh0uAAY7RS7+0C628=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sWe2lTU0nQvzLqazu9/wSJ6dpEFBKG5y7IVeXA8mPasQi1jlkG5EbM9utb1VKmrE5
         LaTC+3ZjFKP1eT8I5CY2b86q4qRXPqPf046G20cgrf435FO9MmtLUF33fMAeUeHRPr
         N5N0aVmCV5HasOMKOp3LWRO8+embyaF0GXNOI3ds=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34485Xvu109292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 03:05:33 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 03:05:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 03:05:33 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34485R1P090093;
        Thu, 4 May 2023 03:05:31 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v6 1/3] dt-bindings: misc: esm: Add ESM support for TI K3 devices
Date:   Thu, 4 May 2023 13:35:24 +0530
Message-ID: <20230504080526.133149-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504080526.133149-1-n-francis@ti.com>
References: <20230504080526.133149-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/misc/ti,j721e-esm.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml

diff --git a/Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml b/Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml
new file mode 100644
index 000000000000..0c9a8444844c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/ti,j721e-esm.yaml#
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
+    maxItems: 1
+
+  ti,esm-pins:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      integer array of ESM interrupt pins to route to external event pin
+      which can be used to reset the SoC.
+    minItems: 1
+    maxItems: 255
+
+required:
+  - compatible
+  - reg
+  - ti,esm-pins
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        esm@700000 {
+            compatible = "ti,j721e-esm";
+            reg = <0x0 0x700000 0x0 0x1000>;
+            ti,esm-pins = <344>, <345>;
+        };
+    };
-- 
2.34.1

