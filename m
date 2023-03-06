Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1716ABA67
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCFJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCFJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:53:04 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11557D516;
        Mon,  6 Mar 2023 01:53:01 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BCDE024E2EE;
        Mon,  6 Mar 2023 17:52:59 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:52:59 +0800
Received: from ubuntu.localdomain (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:52:59 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH 1/3] dt-bindings: phy: Add StarFive JH7110 USB dt-binding
Date:   Mon, 6 Mar 2023 17:52:57 +0800
Message-ID: <20230306095257.25957-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add StarFive JH7110 SoC USB 3.0 phy dt-binding.
USB controller is cadence USB 3.0 IP.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/phy/starfive,jh7110-usb-phy.yaml | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
new file mode 100644
index 000000000000..05b6c47d4a86
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
@@ -0,0 +1,116 @@
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
+      - const: starfive,jh7110-usb-phy
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
+    maxItems: 8
+
+  clock-names:
+    items:
+       - const: usb_125m
+       - const: usb0_app_125
+       - const: usb0_lpm
+       - const: usb0_stb
+       - const: usb0_apb
+       - const: usb0_axi
+       - const: usb0_utmi_apb
+
+  resets:
+    items:
+       - description: USB0_PWRUP reset
+       - description: USB0_APB reset
+       - description: USB0_AXI reset
+       - description: USB0_UTMI_APB reset
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
+      items:
+        - description: phandle to System Register Controller stg_syscon node.
+        - description: offset of STG_SYSCONSAIF__SYSCFG register for USB.
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
+  starfive,usb2-only
+    description: Set USB using usb 2.0 phy. Supprt USB 2.0 only
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - reset
+  - starfive,sys-syscon
+  - starfive,stg-syscon
+  - dr_mode
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    usbphy@10200000 {
+      compatible = "starfive,jh7110-usb";
+      reg = <0x0 0x10210000 0x0 0x1000>,
+            <0x0 0x10200000 0x0 0x1000>;
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
+      #phy-cells = <0>;
+    };
-- 
2.17.1

