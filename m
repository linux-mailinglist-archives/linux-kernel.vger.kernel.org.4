Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482AE5FC472
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJLLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJLLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:44:53 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0053AE60;
        Wed, 12 Oct 2022 04:44:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29CBidwM068551;
        Wed, 12 Oct 2022 06:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665575079;
        bh=hBQquky27/WmpcDWuG9jEk6g3EmaTkPF5wYbeAKAj/s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hNlIk7PKwC1qan0ofR0NybXZ/0R2MVXOX/SCclPJDriWF2ne93vO81lVDbQIuPduE
         2XA+6nAiXz/EquD/bkUO99KImH0xJES/aZnQduLpVz7Ozba1FIt0DdyYlBSKc3mujO
         /tXKvx9jz5R2AHzhfaBcuXty1R6+A+k5Q8omHMY4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29CBidwd029158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Oct 2022 06:44:39 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 12
 Oct 2022 06:44:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 12 Oct 2022 06:44:39 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29CBidL1025228;
        Wed, 12 Oct 2022 06:44:39 -0500
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 29CBibNp017356;
        Wed, 12 Oct 2022 06:44:38 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <srk@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH v6 1/5] dt-bindings: remoteproc: Add PRU consumer bindings
Date:   Wed, 12 Oct 2022 17:14:25 +0530
Message-ID: <20221012114429.2341215-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012114429.2341215-1-danishanwar@ti.com>
References: <20221012114429.2341215-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Suman Anna <s-anna@ti.com>

Add a YAML binding document for PRU consumers. The binding includes
all the common properties that can be used by different PRU consumer
or application nodes and supported by the PRU remoteproc driver.
These are used to configure the PRU hardware for specific user
applications.

The application nodes themselves should define their own bindings.

Co-developed-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../bindings/remoteproc/ti,pru-consumer.yaml  | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
new file mode 100644
index 000000000000..16be98b7d600
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common TI PRU Consumer Binding
+
+maintainers:
+  - Suman Anna <s-anna@ti.com>
+
+description: |
+  A PRU application/consumer/user node typically uses one or more PRU device
+  nodes to implement a PRU application/functionality. Each application/client
+  node would need a reference to at least a PRU node, and optionally define
+  some properties needed for hardware/firmware configuration. The below
+  properties are a list of common properties supported by the PRU remoteproc
+  infrastructure.
+
+  The application nodes shall define their own bindings like regular platform
+  devices, so below are in addition to each node's bindings.
+
+properties:
+  ti,prus:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandles to the PRU, RTU or Tx_PRU nodes used
+    minItems: 1
+    maxItems: 6
+    items:
+      maxItems: 1
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 6
+    description: |
+      firmwares for the PRU cores, the default firmware for the core from
+      the PRU node will be used if not provided. The firmware names should
+      correspond to the PRU cores listed in the 'ti,prus' property
+
+  ti,pruss-gp-mux-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      enum: [0, 1, 2, 3, 4]
+    description: |
+      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
+      This selects the internal muxing scheme for the PRU instance. Values
+      should correspond to the PRU cores listed in the 'ti,prus' property. The
+      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
+      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
+      same slice in the associative array. If the array size is smaller than
+      the size of 'ti,prus' property, the default out-of-reset value (0) for the
+      PRU core is used.
+
+required:
+  - ti,prus
+
+additionalProperties: true
+
+examples:
+  - |
+    /* PRU application node full example */
+    icssg2_eth: icssg2-eth {
+      compatible = "ti,am654-icssg-prueth";
+      pinctrl-names = "default";
+      pinctrl-0 = <&icssg2_rgmii_pins_default>;
+      sram = <&msmc_ram>;
+      ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
+        <&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
+      firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+          "ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+          "ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+          "ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+          "ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+          "ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+      ti,pruss-gp-mux-sel = <2>,      /* MII mode */
+                <2>,
+                <2>,
+                <2>,  /* MII mode */
+                <2>,
+                <2>;
+
+      ti,mii-g-rt = <&icssg2_mii_g_rt>;
+      ti,mii-rt = <&icssg2_mii_rt>;
+      iep = <&icssg2_iep0>,  <&icssg2_iep1>;
+
+      interrupt-parent = <&icssg2_intc>;
+      interrupts = <24 0 2>, <25 1 3>;
+      interrupt-names = "tx_ts0", "tx_ts1";
+
+      dmas = <&main_udmap 0xc300>, /* egress slice 0 */
+             <&main_udmap 0xc301>, /* egress slice 0 */
+             <&main_udmap 0xc302>, /* egress slice 0 */
+             <&main_udmap 0xc303>, /* egress slice 0 */
+             <&main_udmap 0xc304>, /* egress slice 1 */
+             <&main_udmap 0xc305>, /* egress slice 1 */
+             <&main_udmap 0xc306>, /* egress slice 1 */
+             <&main_udmap 0xc307>, /* egress slice 1 */
+
+             <&main_udmap 0x4300>, /* ingress slice 0 */
+             <&main_udmap 0x4301>, /* ingress slice 1 */
+             <&main_udmap 0x4302>, /* mgmnt rsp slice 0 */
+             <&main_udmap 0x4303>; /* mgmnt rsp slice 1 */
+      dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+            "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+            "rx0", "rx1",
+            "rxmgm0", "rxmgm1";
+
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        port@0 {
+          reg = <0>;
+          phy-handle = <&icssg2_phy0>;
+          phy-mode = "rgmii-rxid";
+          ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+        port@1 {
+          reg = <1>;
+          phy-handle = <&icssg2_phy1>;
+          phy-mode = "rgmii-rxid";
+          ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
-- 
2.25.1

