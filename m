Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E086B12D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCHUTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCHUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:19:07 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF36286E;
        Wed,  8 Mar 2023 12:19:06 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 328GtvkC017364;
        Wed, 8 Mar 2023 10:55:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678294557;
        bh=nEXDI2pP8NrRKO9ZRFc0Igp655a88nKLbVqk5OIrnVs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rEtoy58UESPPfcrT/8wanfDyNo0o+xU4dQvOuBH040BFoZIwI+MQIkv7DxW0WGGXL
         2rwUneTQ+eVfnJM6AIbFtLmIsq1RdIlfemfRIK29Pjzhp9kVjBgaYz3gz5JKH5noyx
         UFOjUUsOq+bO4c1x0kxcqNCBAyo+CM68uVDq3f04=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 328GtvGs018199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 10:55:57 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 10:55:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 10:55:57 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 328Gtvaj014057;
        Wed, 8 Mar 2023 10:55:57 -0600
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v6 1/9] dt-bindings: mfd: Add TI-Nspire misc registers
Date:   Wed, 8 Mar 2023 10:55:48 -0600
Message-ID: <20230308165557.2242-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308165557.2242-1-afd@ti.com>
References: <20230308165557.2242-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI Nspire devices contain a set of registers with a seemingly
miscellaneous set of functionality. This area is known simply as the
"misc" region.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/ti,nspire-misc.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
new file mode 100644
index 000000000000..28cd5164d46f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,nspire-misc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Nspire MISC hardware block
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+description:
+  System controller node represents a register region containing a set
+  of miscellaneous registers. The registers are not cohesive enough to
+  represent as any specific type of device. Currently there is a reset
+  controller.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,nspire-misc
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+
+required:
+  - compatible
+  - reg
+  - reboot
+
+additionalProperties: false
+
+examples:
+  - |
+    misc: misc@900a0000 {
+      compatible = "ti,nspire-misc", "syscon", "simple-mfd";
+      reg = <0x900a0000 0x1000>;
+
+      reboot {
+        compatible = "syscon-reboot";
+        offset = <0x08>;
+        value = <0x02>;
+      };
+    };
-- 
2.39.2

