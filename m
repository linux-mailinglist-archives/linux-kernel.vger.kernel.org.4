Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336325F05E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiI3HlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI3HlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:41:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CB1032E2;
        Fri, 30 Sep 2022 00:41:04 -0700 (PDT)
X-QQ-mid: bizesmtp64t1664523533tfs8q1ju
Received: from localhost.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 15:38:51 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: k8Irs33ik7vaMfpcnYWCuh3AHagj5K0mh271a0EEiwEVFUL7rSfkc84AaA7xx
        FgVUPVwT/bikpDFHdgNhxbLCszQfXzRjkBFWClSgjKwYqaFgUEc+6KJehrpi+KbWQOhgJ9D
        hfDzq8j5+S8X0DeV5We0ny9HZyOuhv2nWBulRgG4Ojbch1Ef9mB8WUs8B/SJI1uvt6ci5C4
        C0iwQU7s+ajU5SVtZpib1WaES9ba4RsGW63jrR5XOO6AVPlpWIqwlrdTdq6Y/GuNytIrnE4
        aGKYYRTzuqP7U/k12ijT6UMYg9Qr18UwtUWSikyluGgcZG7QyFmcymmM7/7kfVuQSYPdAMR
        cPQ7PxQIDV6a1ZmNDoHMahsZ6B4QbodHR6LIR2uftqy/MW5Bgf+VvQRNTs7+T7CvQIa1U+g
        G+A3mq2f1JSSsGDzG8X2+w==
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 25/30] dt-bindings: pinctrl: Add StarFive JH7110 pinctrl bindings
Date:   Fri, 30 Sep 2022 15:38:45 +0800
Message-Id: <20220930073845.6309-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlong Huang <jianlong.huang@starfivetech.com>

Add pinctrl bindings for StarFive JH7110 SoC.

Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 .../pinctrl/starfive,jh7110-pinctrl.yaml      | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml
new file mode 100644
index 000000000000..482012ad8a14
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Pin Controller Device Tree Bindings
+
+description: |
+  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
+
+maintainers:
+  - Jianlong Huang <jianlong.huang@starfivetech.com>
+
+properties:
+  compatible:
+    enum:
+    - starfive,jh7110-sys-pinctrl
+    - starfive,jh7110-aon-pinctrl
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: control
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+    description: The GPIO parent interrupt.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  ngpios:
+    enum:
+    - 64
+    - 4
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - "#gpio-cells"
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available on the machine. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, system signal configuration, pin groups for
+          vin/vout module, pin voltage, mux functions for output, mux functions
+          for output enable, mux functions for input.
+
+        properties:
+          starfive,pins:
+            description: |
+              The list of pin identifiers that properties in the node apply to.
+              This should be set using the PAD_GPIOX macros.
+              This has to be specified.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 63
+
+          starfive,pinmux:
+            description: |
+              The list of GPIOs and their mux functions that properties in the
+              node apply to. This should be set using the PAD_GPIOX_FUNC_SEL
+              macro with its value.
+              This is optional for some pins.
+              The value of PAD_GPIOX_FUNC_SEL macro can selects:
+                0: GPIOX mux function 0,
+                1: GPIOX mux function 1,
+                2: GPIOX mux function 2.
+
+          starfive,pin-ioconfig:
+            description: |
+              This is used to configure the core settings of system signals.
+              The combination of GPIO_IE or GPIO_DS or GPIO_PU or GPIO_PD or
+              GPIO_SLEW or GPIO_SMT or GPIO_POS.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          starfive,padmux:
+            description: |
+              The padmux is for vin/vout module to select pin groups.
+              0: vout will be set at pins from PAD_GPIO7 to PAD_GPIO34,
+                 when PAD_GPIOX_FUNC_SEL is set as 1.
+                 vin will be set at pins from PAD_GPIO6 to PAD_GPIO20.
+                 when PAD_GPIOX_FUNC_SEL is set as 2.
+              1: vout will be set at pins from PAD_GPIO36 to PAD_GPIO63,
+                 when PAD_GPIOX_FUNC_SEL is set as 1.
+                 vin will be set at pins from PAD_GPIO21 to PAD_GPIO35.
+                 when PAD_GPIOX_FUNC_SEL is set as 2.
+              2: vin will be set at pins from PAD_GPIO36 to PAD_GPIO50,
+                 when PAD_GPIOX_FUNC_SEL is set as 2
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2]
+
+          starfive,pin-syscon:
+            description: |
+              This is used to set pin voltage,
+              0: 3.3V, 1: 2.5V, 2: 1.8V.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2]
+
+          starfive,pin-gpio-dout:
+            description: |
+              This is used to set their mux functions for output.
+              This should be set using the GPO_XXX macro,
+              such as GPO_LOW, GPO_UART0_SOUT.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 107
+
+          starfive,pin-gpio-doen:
+            description: |
+              This is used to set their mux functions for output enable.
+              This should be set using the OEN_XXX macro,
+              such as OEN_LOW, OEN_I2C0_IC_CLK_OE.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 49
+
+          starfive,pin-gpio-din:
+            description: |
+              This is used to set their mux functions for input.
+              This should be set using the GPI_XXX macro,
+              such as GPI_CAN0_CTRL_RXD, GPI_I2C0_IC_CLK_IN_A.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 90
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive-jh7110-sys.h>
+    #include <dt-bindings/reset/starfive-jh7110.h>
+    #include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
+
+    gpio: gpio@13040000 {
+      compatible = "starfive,jh7110-sys-pinctrl";
+      reg = <0x0 0x13040000 0x0 0x10000>;
+      reg-names = "control";
+      clocks = <&clkgen JH7110_SYS_IOMUX_PCLK>;
+      resets = <&rstgen RSTN_U0_SYS_IOMUX_PRESETN>;
+      interrupts = <86>;
+      interrupt-controller;
+      #gpio-cells = <2>;
+      ngpios = <64>;
+      status = "okay";
+
+      uart0_pins: uart0-pins {
+        uart0-pins-tx {
+          starfive,pins = <PAD_GPIO5>;
+          starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_DS(3))>;
+          starfive,pin-gpio-dout = <GPO_UART0_SOUT>;
+          starfive,pin-gpio-doen = <OEN_LOW>;
+        };
+
+        uart0-pins-rx {
+          starfive,pins = <PAD_GPIO6>;
+          starfive,pinmux = <PAD_GPIO6_FUNC_SEL 0>;
+          starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_PU(1))>;
+          starfive,pin-gpio-doen = <OEN_HIGH>;
+          starfive,pin-gpio-din =  <GPI_UART0_SIN>;
+        };
+      };
+    };
+
+    &uart0 {
+      pinctrl-names = "default";
+      pinctrl-0 = <&uart0_pins>;
+      status = "okay";
+    };
+
+...
-- 
2.17.1

