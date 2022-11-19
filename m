Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A59630E63
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKSLbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKSLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:31:09 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16C517A82;
        Sat, 19 Nov 2022 03:31:06 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E9449FF807;
        Sat, 19 Nov 2022 11:30:55 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     krzysztof.kozlowski+dt@linaro.org, paulus@samba.org,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        segher@kernel.crashing.org, pali@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org,
        joel@jms.id.au
Subject: [PATCH v4 01/11] dt-bindings: wiiu: Document the Nintendo Wii U devicetree
Date:   Sat, 19 Nov 2022 22:30:31 +1100
Message-Id: <20221119113041.284419-2-ash@heyquark.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119113041.284419-1-ash@heyquark.com>
References: <20220628133144.142185-1-ash@heyquark.com>
 <20221119113041.284419-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds schema for the various Wii U devicetree nodes used.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
v3->v4: Rework to match expected style and conciceness.

 .../bindings/powerpc/nintendo/wiiu.yaml       | 25 +++++++++
 .../powerpc/nintendo/wiiu/espresso-pic.yaml   | 48 ++++++++++++++++
 .../bindings/powerpc/nintendo/wiiu/gpu7.yaml  | 42 ++++++++++++++
 .../powerpc/nintendo/wiiu/latte-ahci.yaml     | 50 +++++++++++++++++
 .../powerpc/nintendo/wiiu/latte-dsp.yaml      | 35 ++++++++++++
 .../powerpc/nintendo/wiiu/latte-pic.yaml      | 55 +++++++++++++++++++
 .../powerpc/nintendo/wiiu/latte-sdhci.yaml    | 46 ++++++++++++++++
 .../bindings/powerpc/nintendo/wiiu/latte.yaml | 31 +++++++++++
 .../devicetree/bindings/usb/generic-ehci.yaml |  1 +
 9 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml

diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
new file mode 100644
index 000000000000..23703b1052d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U bindings
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Nintendo Wii U video game console binding.
+
+properties:
+  $nodename:
+    const: "/"
+
+  compatible:
+    const: nintendo,wiiu
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
new file mode 100644
index 000000000000..476a8ccda7a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/espresso-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U "Espresso" interrupt controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Interrupt controller found on the Nintendo Wii U for the "Espresso" processor.
+
+allOf:
+  - $ref: "/schemas/interrupt-controller.yaml#"
+
+properties:
+  compatible:
+    const: nintendo,espresso-pic
+
+  '#interrupt-cells':
+    # Interrupt numbers 0-32 in one cell
+    const: 1
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@c000078 {
+        compatible = "nintendo,espresso-pic";
+        reg = <0x0c000078 0x18>;
+        #interrupt-cells = <1>;
+        interrupt-controller;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
new file mode 100644
index 000000000000..d44ebe0d866c
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/gpu7.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte "GPU7" graphics processor
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  GPU7 graphics processor, also known as "GX2", found in the Latte multifunction chip of the
+  Nintendo Wii U.
+
+properties:
+  compatible:
+    const: nintendo,latte-gpu7
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    gpu@c200000 {
+        compatible = "nintendo,latte-gpu7";
+        reg = <0x0c200000 0x80000>;
+        interrupts = <2>;
+        interrupt-parent = <&espresso_pic>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
new file mode 100644
index 000000000000..a53971a11e89
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte AHCI controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Nintendo Wii U AHCI SATA controller, as found in the Latte chip.
+
+allOf:
+  - $ref: "/schemas/ata/ahci-common.yaml#"
+
+properties:
+  compatible:
+    const: nintendo,latte-ahci
+
+  reg:
+    items:
+      - description: |
+          HBA memory registers. Note that unlike the spec, space for only 6 ports exist, with 2 vendor
+          registers afterwards, thus register space should be 0x408 long (0x100+0x80*6+0x8).
+
+  interrupts:
+    items:
+      - description: Main HBA interrupt
+      - description: Vendor debugging interrupt
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    sata@d160400 {
+        compatible = "nintendo,latte-ahci";
+        reg = <0x0d160400 0x408>;
+
+        interrupt-parent = <&latte_pic>;
+        interrupts = <38>, <28>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
new file mode 100644
index 000000000000..772afe0c298c
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte DSP
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Nintendo Wii U digital signal processor, as found in the Latte chip.
+
+properties:
+  compatible:
+    const: nintendo,latte-dsp
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dsp@c005000 {
+        compatible = "nintendo,latte-dsp";
+        reg = <0x0c005000 0x200>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
new file mode 100644
index 000000000000..4b71d6b9b14d
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte interrupt controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Interrupt controller found on the Nintendo Wii U for the "Latte" devices.
+
+allOf:
+  - $ref: "/schemas/interrupt-controller.yaml#"
+
+properties:
+  compatible:
+    const: nintendo,latte-pic
+
+  '#interrupt-cells':
+    # Interrupt numbers 0-64 in one cell.
+    const: 1
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Cascade interrupt for Espresso PIC
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@d800440 {
+        compatible = "nintendo,latte-pic";
+        #interrupt-cells = <1>;
+        interrupt-controller;
+        reg = <0x0d800440 0x30>;
+
+        interrupt-parent = <&espresso_pic>;
+        interrupts = <24>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
new file mode 100644
index 000000000000..25d474fca679
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte SD Host controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  SDHCI hosts found on the Nintendo Wii U's Latte SoC for SD cards and SDIO devices.
+
+allOf:
+  - $ref: "/schemas/mmc/mmc-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: nintendo,latte-sdhci
+      - const: sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    mmc@d070000 {
+        compatible = "nintendo,latte-sdhci", "sdhci";
+        reg = <0x0d070000 0x200>;
+        interrupts = <7>;
+        interrupt-parent = <&latte_pic>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
new file mode 100644
index 000000000000..6fdf93622fcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Latte system bus
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Latte multi-function SoC, containing many of the devices found on the Nintendo Wii U.
+
+allOf:
+  - $ref: "/schemas/simple-bus.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: nintendo,latte
+      - const: simple-bus
+
+
+required:
+  - compatible
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index c5f629c5bc61..9f69b5ab21ff 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -69,6 +69,7 @@ properties:
               - ibm,usb-ehci-440epx
               - ibm,usb-ehci-460ex
               - nintendo,hollywood-usb-ehci
+              - nintendo,latte-ehci
               - st,spear600-ehci
           - const: usb-ehci
       - enum:
-- 
2.38.1

