Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FDE6B0178
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCHIbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCHIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:30:45 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E1B3713;
        Wed,  8 Mar 2023 00:30:17 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 01B1024E33E;
        Wed,  8 Mar 2023 16:28:04 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 16:28:04 +0800
Received: from ubuntu.localdomain (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 16:28:02 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v2 1/3] dt-bindings: phy: Add StarFive JH7110 USB dt-binding
Date:   Wed, 8 Mar 2023 16:27:58 +0800
Message-ID: <20230308082800.3008-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308082800.3008-1-minda.chen@starfivetech.com>
References: <20230308082800.3008-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add StarFive JH7110 SoC USB 3.0 phy dt-binding.
USB controller is cadence USB 3.0 IP.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/phy/starfive,jh7110-usb-phy.yaml | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
new file mode 100644
index 000000000000..daa88d065deb
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/starfive,jh7110-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive USB 2.0 and 3.0 PHY
+
+maintainers:
+  - Minda Chen<minda.chen@starfivetech.com>
+
+properties:
+  compatible:
+    items:
+      - const: starfive,jh7110-usb
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: usb3
+      - const: usb2
+
+  clocks:
+    items:
+      - description: usb 125m clock
+      - description: app 125m clock
+      - description: lpm clock
+      - description: stb clock
+      - description: apb clock
+      - description: axi clock
+      - description: utmi apb clock
+
+  clock-names:
+    items:
+      - const: usb_125m
+      - const: usb0_app_125
+      - const: usb0_lpm
+      - const: usb0_stb
+      - const: usb0_apb
+      - const: usb0_axi
+      - const: usb0_utmi_apb
+
+  resets:
+    items:
+      - description: USB0_PWRUP reset
+      - description: USB0_APB reset
+      - description: USB0_AXI reset
+      - description: USB0_UTMI_APB reset
+
+  starfive,sys-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle to System Register Controller sys_syscon node.
+        - description: offset of SYS_SYSCONSAIF__SYSCFG register for USB.
+    description:
+      The phandle to System Register Controller syscon node and the offset
+      of SYS_SYSCONSAIF__SYSCFG register for USB.
+
+  starfive,stg-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle to System Register Controller stg_syscon node.
+        - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for USB.
+        - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for USB.
+        - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for USB.
+        - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for USB.
+    description:
+      The phandle to System Register Controller syscon node and the offset
+      of STG_SYSCONSAIF__SYSCFG register for USB. Total 4 regsisters offset
+      for USB.
+
+  dr_mode:
+    description: PHY mode.
+    enum:
+      - host
+      - peripheral
+      - otg
+
+  "#address-cells":
+    maximum: 2
+
+  "#size-cells":
+    maximum: 2
+
+  ranges: true
+
+  starfive,usb2-only:
+    type: boolean
+    description: Set USB using usb 2.0 phy. Supprt USB 2.0 only
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - starfive,sys-syscon
+  - starfive,stg-syscon
+  - dr_mode
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    type: object
+    description: |
+      usbphy node should have '1' usb controller subnode.
+      It could be Cadence USB3 DRD controller.
+      Cadence USB3 should follow the bindings specified in
+      Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    usbphy@10200000 {
+      compatible = "starfive,jh7110-usb";
+      reg = <0x10210000 0x1000>,
+            <0x10200000 0x1000>;
+      reg-names = "usb3", "usb2";
+      clocks = <&syscrg 95>,
+               <&stgcrg 6>,
+               <&stgcrg 4>,
+               <&stgcrg 5>,
+               <&stgcrg 1>,
+               <&stgcrg 3>,
+               <&stgcrg 2>;
+      clock-names = "usb_125m", "usb0_app_125", "usb0_lpm",
+                    "usb0_stb", "usb0_apb", "usb0_axi", "usb0_utmi_apb";
+      resets = <&stgcrg 10>,
+               <&stgcrg 8>,
+               <&stgcrg 7>,
+               <&stgcrg 9>;
+      starfive,stg-syscon = <&stg_syscon 0x4 0xc4 0x148 0x1f4>;
+      starfive,sys-syscon = <&sys_syscon 0x18>;
+      dr_mode = "host";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      usb@10100000 {
+        compatible = "cdns,usb3";
+        reg = <0x10100000 0x10000>,
+              <0x10110000 0x10000>,
+              <0x10120000 0x10000>;
+        reg-names = "otg", "xhci", "dev";
+        interrupts = <100>, <108>, <110>;
+        interrupt-names = "host", "peripheral", "otg";
+        phy-names = "cdns3,usb3-phy", "cnds3,usb2-phy";
+        maximum-speed = "super-speed";
+      };
+    };
-- 
2.17.1

