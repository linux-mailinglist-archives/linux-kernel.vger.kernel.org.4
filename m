Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F06B924E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjCNL4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCNL40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:56:26 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB13A029F;
        Tue, 14 Mar 2023 04:56:06 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtgKl051569;
        Tue, 14 Mar 2023 06:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678794942;
        bh=ddovUNv2LEGp3gIShbawH913wqA8KX1RQrHrCXJXEQo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BEODxeeC3mjlTpmQjBsG4eppkr2hZxdsR65mf3hk8Yost8oHEeV8RffpRHtd07iAv
         VDZJqBEnDFMRZKNWsrvXWzYDeSzErKJmi0GFnzNPIYCFSrRxlTaicVS2p1YN8X3sk9
         gma7io2O4HBdWYU1BDzPsVKwjml+vFrNLyBPq+oc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EBtfmK112617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 06:55:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 06:55:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 06:55:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtelG002476;
        Tue, 14 Mar 2023 06:55:41 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mripard@kernel.org>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>
CC:     <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <martyn.welch@collabora.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v7 12/13] media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver
Date:   Tue, 14 Mar 2023 17:25:15 +0530
Message-ID: <20230314115516.667-13-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314115516.667-1-vaishnav.a@ti.com>
References: <20230314115516.667-1-vaishnav.a@ti.com>
MIME-Version: 1.0
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

From: Pratyush Yadav <p.yadav@ti.com>

TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
parts together.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

(no changes since v5)

Changes in v5:
- Add Laurent's and Rob's R-by.

Changes in v2:
- Rename to ti,j721e-csi2rx.yaml
- Add an entry in MAINTAINERS.
- Add a description for the binding.
- Change compatible to ti,j721e-csi2rx to make it SoC specific.
- Remove description from dmas, reg, power-domains.
- Remove a limit of 2 from #address-cells and #size-cells.
- Fix add ^ to csi-bridge subnode regex.
- Make ranges mandatory.
- Add unit address in example.
- Add a reference to cdns,csi2rx in csi-bridge subnode.
- Expand the example to include the csi-bridge subnode as well.
- Re-order subject prefixes.

 .../bindings/media/ti,j721e-csi2rx.yaml       | 101 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml

diff --git a/Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
new file mode 100644
index 000000000000..db87cfd65bed
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/ti,j721e-csi2rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI J721E CSI2RX Wrapper Device Tree Bindings
+
+description: |
+  The TI J721E CSI2RX Wrapper is a wrapper around Cadence CSI2RX bridge that
+  enables sending captured frames to memory over PSI-L DMA. In the J721E
+  Technical Reference Manual (SPRUIL1B) it is referred to as "SHIM" under the
+  CSI_RX_IF section.
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,j721e-csi2rx
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx0
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+patternProperties:
+  "^csi-bridge@":
+    type: object
+    description: CSI2 bridge node.
+    $ref: cdns,csi2rx.yaml#
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - power-domains
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    ti_csi2rx0: ticsi2rx@4500000 {
+        compatible = "ti,j721e-csi2rx";
+        dmas = <&main_udmap 0x4940>;
+        dma-names = "rx0";
+        reg = <0x4500000 0x1000>;
+        power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        cdns_csi2rx: csi-bridge@4504000 {
+            compatible = "cdns,csi2rx";
+            reg = <0x4504000 0x1000>;
+            clocks = <&k3_clks 26 2>, <&k3_clks 26 0>, <&k3_clks 26 2>,
+              <&k3_clks 26 2>, <&k3_clks 26 3>, <&k3_clks 26 3>;
+            clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+              "pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+            phys = <&dphy0>;
+            phy-names = "dphy";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                csi2_0: port@0 {
+
+                    reg = <0>;
+
+                    csi2rx0_in_sensor: endpoint {
+                        remote-endpoint = <&csi2_cam0>;
+                        bus-type = <4>; /* CSI2 DPHY. */
+                        clock-lanes = <0>;
+                        data-lanes = <1 2>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 69c2b0f48073..796be64bc54f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20905,6 +20905,7 @@ TI J721E CSI2RX DRIVER
 M:	Vaishnav Achath <vaishnav.a@ti.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
 F:	drivers/media/platform/ti/j721e-csi2rx/
 
 TI DAVINCI MACHINE SUPPORT
-- 
2.17.1

