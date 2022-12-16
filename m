Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACC64ED06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiLPOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiLPOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:37:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD35EDCA;
        Fri, 16 Dec 2022 06:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671201451; x=1702737451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZy1RXcVK/2x+hEiHp355FgRq9Aa9qrbXPuFKkwSAW0=;
  b=aqjSIsO65c3c1PHdOhShzdyU3uV9ZaNVFyU6o5o17mrwRYLlFDhW7nUP
   gk0lD9uFnt6LOqXYLc4W2FmDMcIoXXOqgHAZmCXqoeoRLSu7YCXyXNncE
   NYIBICZQC3bI/qZZxX9ch5FaZn4m0p6V9g42fA7bA13drbqgVuuQbMFxS
   KGTXuQS+B20QfkSUc5r20RCOF/INeaWupLY5KBPILOpBwhlxE42CFwV2p
   b6M6GXC5XXCHaMpB5olzUI8yGflkqyzFljIg+dwQ/7xzim48obsmkUpBU
   K76Wy7eOFM1ZbFkIwAA9Gqhu5Kd1wjLcTsI0IA7jwRLkKk56QKAHtcxE4
   A==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="128506511"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 07:37:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 07:37:26 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 07:37:24 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <luis.oliveira@synopsys.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Luis Oliveira <lolivei@synopsys.com>
Subject: [PATCH v5 1/4] dt-bindings: media: Document bindings for DW MIPI CSI-2 Host
Date:   Fri, 16 Dec 2022 16:37:14 +0200
Message-ID: <20221216143717.1002015-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216143717.1002015-1-eugen.hristev@microchip.com>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Synopsys DesignWare MIPI CSI-2 host.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
[eugen.hristev@microchip.com: reworked binding, converted to yaml]
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../bindings/media/snps,dw-csi.yaml           | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi.yaml

diff --git a/Documentation/devicetree/bindings/media/snps,dw-csi.yaml b/Documentation/devicetree/bindings/media/snps,dw-csi.yaml
new file mode 100644
index 000000000000..439eadc8e517
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/snps,dw-csi.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/snps,dw-csi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare CSI-2 Host controller (csi2host)
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@microchip.com>
+
+description:
+  CSI2HOST is used to receive image coming from an MIPI CSI-2 compatible
+  camera. It will convert the incoming CSI-2 stream into a dedicated
+  interface called the Synopsys IDI (Image Data Interface).
+  This interface is a 32-bit SoC internal only, and can be assimilated
+  with a CSI-2 interface.
+
+properties:
+  compatible:
+    const: snps,dw-csi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    description:
+      CSI2HOST can have two clocks connected. One clock is the
+      peripheral clock for the inside functionality of the hardware block.
+      This is named 'perclk'. The second clock can be the phy clock,
+      which is used to clock the phy via an internal link.
+      This clock is named 'phyclk', phy clock.
+    items:
+      - const: perclk
+      - const: phyclk
+
+  phys:
+    maxItems: 1
+    description: MIPI D-PHY
+
+  phy-names:
+    items:
+      - const: dphy
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port node, single endpoint describing the input port.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+            description: Endpoint connected to input device
+
+            properties:
+              bus-type:
+                const: 4
+
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  maximum: 4
+
+              clock-lanes:
+                maxItems: 1
+
+              remote-endpoint: true
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Output port node, single endpoint describing the output port.
+
+        properties:
+          endpoint:
+            unevaluatedProperties: false
+            $ref: video-interfaces.yaml#
+            description: Endpoint connected to output device
+
+            properties:
+              bus-type:
+                const: 4
+
+              remote-endpoint: true
+
+    required:
+      - port@0
+      - port@1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - ports
+
+examples:
+  - |
+    csi2: csi2@3000 {
+        compatible = "snps,dw-csi";
+        reg = <0x03000 0x7FF>;
+        phys = <&mipi_dphy_rx>;
+        phy-names = "dphy";
+        resets = <&dw_rst 1>;
+        interrupts = <2>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                csi_ep1: endpoint {
+                    bus-type = <4>; /* MIPI CSI2 D-PHY */
+                    remote-endpoint = <&camera_1>;
+                    data-lanes = <1 2>;
+                    clock-lanes = <0>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                csi_ep2: endpoint {
+                    remote-endpoint = <&idi_receiver>;
+                    bus-type = <4>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.25.1

