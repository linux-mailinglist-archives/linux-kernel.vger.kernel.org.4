Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08715BD32D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiISRF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiISREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:04:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0EA33E20;
        Mon, 19 Sep 2022 10:03:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y5so120162wrh.3;
        Mon, 19 Sep 2022 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=irGWMkl8qUFam0imc80097PpbaXvAeQyox20hOP4xjI=;
        b=jLdfWdxdINpeTArvS9WB1IlacLqjYkNlJtgNcPykhgIHYbrVYvpMUJWDiw3r0Xs+Lm
         T7UpGq/Oj4DapTBO2hVlnmTcn2RZajn9IOWCT7j/0uILGa0QdrmZdG3gzy9Ko5OusJwa
         FX52X+80j8iCfCQTwGsuzswoCUqEj7hxAjHgmGLpE0yhiwvjk4OVnjstbr9Of0jXSRD0
         ou9bzw6F5BLHwt8nI3huJt91J4/ugP7sGxHHj6HTB4OwgEv+nBm2yI0DNjN2WbuBmnvI
         UMq8LuHlz6aBZTGMAbAnBWIeENgAGoKPNLM+tm0899JlRa1dkvQVMpfC4Zz6f3vImhgf
         8cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=irGWMkl8qUFam0imc80097PpbaXvAeQyox20hOP4xjI=;
        b=rmMLiOyM3yUnsgf8xl5/mI6SduIXs1ZHmhQV+Alfcy4ZUVRHqiJYiKmEm6ZtlrrrDz
         lNkT2DZGZ5eI70sABUSDM4iOV0OOE4+vp7aYW8LVEKcuqK8x+TrkMlfICjhGx/YjVJNT
         PSa3JXHNusWJJxIh9DoJgjSqYU5E+XICkJ6Tl/+uFtnF1mohaMRDjQ96FDcGhNjzaubX
         BugqlKzspZPpMfdbOlo+70pSpu7SEh+b3UCOBur0Vs7udO+IJoc7ed6lUAMzoj3dArIH
         /dBUn69FEjbl/e3d/itqY8hs1tA8E82g7naQ8phpTdKmIcf/Jk/pbzP3Z6FY9dycFXCt
         0tqA==
X-Gm-Message-State: ACrzQf0Wnhi0GxntYIQnvqmGPuP3LBchP9+6ChYy/e532Ah5YeeG8/MX
        QFjzcXzrCIoT1cDbR1wi0e4=
X-Google-Smtp-Source: AMsMyM67d5AUO+yeeD3E1j+NrTgOG+aZmNf4pnquOpGuX4xugvryw8gLbWkErcH1CfqCytHQK+bz9w==
X-Received: by 2002:a5d:453a:0:b0:228:7873:1101 with SMTP id j26-20020a5d453a000000b0022878731101mr11097993wra.241.1663607020579;
        Mon, 19 Sep 2022 10:03:40 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ci10-20020a5d5d8a000000b0021e6c52c921sm17562487wrb.54.2022.09.19.10.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:03:40 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl binding docs
Date:   Mon, 19 Sep 2022 20:01:12 +0300
Message-Id: <20220919170115.94873-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919170115.94873-1-y.oudjana@protonmail.com>
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Documents for MT6779, MT6795 and MT6797 that currently exist share
most properties, and each one has slightly differently worded
descriptions for those properties. Combine all three documents into
one common document for all MT67xx SoC pin controllers, picking a few
parts from each and accounting for differences such as items in reg
and reg-names properties. Also document the MT6765 pin controller
which currently has a driver but no DT binding documentation. It should
be possible to also include bindings for MT8183 and MT8188, but these
have some additional properties that might complicate things a bit,
so they are left alone for now.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 207 ------------------
 .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 ---------------
 ...6795.yaml => mediatek,mt67xx-pinctrl.yaml} | 181 +++++++++++----
 MAINTAINERS                                   |   2 +-
 4 files changed, 135 insertions(+), 431 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.yaml => mediatek,mt67xx-pinctrl.yaml} (65%)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
deleted file mode 100644
index 8c79fcef7c52..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ /dev/null
@@ -1,207 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/mediatek,mt6779-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mediatek MT6779 Pin Controller
-
-maintainers:
-  - Andy Teng <andy.teng@mediatek.com>
-
-description: |+
-  The pin controller node should be the child of a syscon node with the
-  required property:
-  - compatible: "syscon"
-
-properties:
-  compatible:
-    const: mediatek,mt6779-pinctrl
-
-  reg:
-    minItems: 9
-    maxItems: 9
-
-  reg-names:
-    items:
-      - const: "gpio"
-      - const: "iocfg_rm"
-      - const: "iocfg_br"
-      - const: "iocfg_lm"
-      - const: "iocfg_lb"
-      - const: "iocfg_rt"
-      - const: "iocfg_lt"
-      - const: "iocfg_tl"
-      - const: "eint"
-
-  gpio-controller: true
-
-  "#gpio-cells":
-    const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
-
-  gpio-ranges:
-    minItems: 1
-    maxItems: 5
-    description: |
-      GPIO valid number range.
-
-  interrupt-controller: true
-
-  interrupts:
-    maxItems: 1
-    description: |
-      Specifies the summary IRQ.
-
-  "#interrupt-cells":
-    const: 2
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
-  - interrupt-controller
-  - interrupts
-  - "#interrupt-cells"
-
-patternProperties:
-  '-[0-9]*$':
-    type: object
-    additionalProperties: false
-
-    patternProperties:
-      '-pins*$':
-        type: object
-        description: |
-          A pinctrl node should contain at least one subnodes representing the
-          pinctrl groups available on the machine. Each subnode will list the
-          pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and input schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
-
-        properties:
-          pinmux:
-            description:
-              integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are defined
-              as macros in boot/dts/<soc>-pinfunc.h directly.
-
-          bias-disable: true
-
-          bias-pull-up: true
-
-          bias-pull-down: true
-
-          input-enable: true
-
-          input-disable: true
-
-          output-low: true
-
-          output-high: true
-
-          input-schmitt-enable: true
-
-          input-schmitt-disable: true
-
-          mediatek,pull-up-adv:
-            description: |
-              Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
-              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
-              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
-              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
-              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
-
-          mediatek,pull-down-adv:
-            description: |
-              Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
-              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
-              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
-              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
-              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
-
-        required:
-          - pinmux
-
-        additionalProperties: false
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/pinctrl/mt6779-pinfunc.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        pio: pinctrl@10005000 {
-            compatible = "mediatek,mt6779-pinctrl";
-            reg = <0 0x10005000 0 0x1000>,
-                <0 0x11c20000 0 0x1000>,
-                <0 0x11d10000 0 0x1000>,
-                <0 0x11e20000 0 0x1000>,
-                <0 0x11e70000 0 0x1000>,
-                <0 0x11ea0000 0 0x1000>,
-                <0 0x11f20000 0 0x1000>,
-                <0 0x11f30000 0 0x1000>,
-                <0 0x1000b000 0 0x1000>;
-            reg-names = "gpio", "iocfg_rm",
-              "iocfg_br", "iocfg_lm",
-              "iocfg_lb", "iocfg_rt",
-              "iocfg_lt", "iocfg_tl",
-              "eint";
-            gpio-controller;
-            #gpio-cells = <2>;
-            gpio-ranges = <&pio 0 0 210>;
-            interrupt-controller;
-            #interrupt-cells = <2>;
-            interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
-
-            mmc0_pins_default: mmc0-0 {
-                cmd-dat-pins {
-                    pinmux = <PINMUX_GPIO168__FUNC_MSDC0_DAT0>,
-                        <PINMUX_GPIO172__FUNC_MSDC0_DAT1>,
-                        <PINMUX_GPIO169__FUNC_MSDC0_DAT2>,
-                        <PINMUX_GPIO177__FUNC_MSDC0_DAT3>,
-                        <PINMUX_GPIO170__FUNC_MSDC0_DAT4>,
-                        <PINMUX_GPIO173__FUNC_MSDC0_DAT5>,
-                        <PINMUX_GPIO171__FUNC_MSDC0_DAT6>,
-                        <PINMUX_GPIO174__FUNC_MSDC0_DAT7>,
-                        <PINMUX_GPIO167__FUNC_MSDC0_CMD>;
-                    input-enable;
-                    mediatek,pull-up-adv = <1>;
-                };
-                clk-pins {
-                    pinmux = <PINMUX_GPIO176__FUNC_MSDC0_CLK>;
-                    mediatek,pull-down-adv = <2>;
-                };
-                rst-pins {
-                    pinmux = <PINMUX_GPIO178__FUNC_MSDC0_RSTB>;
-                    mediatek,pull-up-adv = <0>;
-                };
-            };
-        };
-
-        mmc0 {
-           pinctrl-0 = <&mmc0_pins_default>;
-           pinctrl-names = "default";
-        };
-    };
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
deleted file mode 100644
index 637a8386e23e..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
+++ /dev/null
@@ -1,176 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/mediatek,mt6797-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mediatek MT6797 Pin Controller
-
-maintainers:
-  - Sean Wang <sean.wang@kernel.org>
-
-description: |+
-  The MediaTek's MT6797 Pin controller is used to control SoC pins.
-
-properties:
-  compatible:
-    const: mediatek,mt6797-pinctrl
-
-  reg:
-    minItems: 5
-    maxItems: 5
-
-  reg-names:
-    items:
-      - const: gpio
-      - const: iocfgl
-      - const: iocfgb
-      - const: iocfgr
-      - const: iocfgt
-
-  gpio-controller: true
-
-  "#gpio-cells":
-    const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
-
-  interrupt-controller: true
-
-  interrupts:
-    maxItems: 1
-
-  "#interrupt-cells":
-    const: 2
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - gpio-controller
-  - "#gpio-cells"
-
-patternProperties:
-  '-[0-9]+$':
-    type: object
-    additionalProperties: false
-    patternProperties:
-      'pins':
-        type: object
-        additionalProperties: false
-        description: |
-          A pinctrl node should contain at least one subnodes representing the
-          pinctrl groups available on the machine. Each subnode will list the
-          pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and input
-          schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
-
-        properties:
-          pinmux:
-            description:
-              integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are
-              defined as macros in <soc>-pinfunc.h directly.
-
-          bias-disable: true
-
-          bias-pull-up: true
-
-          bias-pull-down: true
-
-          input-enable: true
-
-          input-disable: true
-
-          output-enable: true
-
-          output-low: true
-
-          output-high: true
-
-          input-schmitt-enable: true
-
-          input-schmitt-disable: true
-
-          drive-strength:
-            enum: [2, 4, 8, 12, 16]
-
-          slew-rate:
-            enum: [0, 1]
-
-          mediatek,pull-up-adv:
-            description: |
-              Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
-              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
-              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
-              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
-              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
-
-          mediatek,pull-down-adv:
-            description: |
-              Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
-              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
-              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
-              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
-              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
-
-          mediatek,tdsel:
-            description: |
-              An integer describing the steps for output level shifter duty
-              cycle when asserted (high pulse width adjustment). Valid arguments
-              are from 0 to 15.
-            $ref: /schemas/types.yaml#/definitions/uint32
-
-          mediatek,rdsel:
-            description: |
-              An integer describing the steps for input level shifter duty cycle
-              when asserted (high pulse width adjustment). Valid arguments are
-              from 0 to 63.
-            $ref: /schemas/types.yaml#/definitions/uint32
-
-        required:
-          - pinmux
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/pinctrl/mt6797-pinfunc.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        pio: pinctrl@10005000 {
-            compatible = "mediatek,mt6797-pinctrl";
-            reg = <0 0x10005000 0 0x1000>,
-                  <0 0x10002000 0 0x400>,
-                  <0 0x10002400 0 0x400>,
-                  <0 0x10002800 0 0x400>,
-                  <0 0x10002C00 0 0x400>;
-            reg-names = "gpio", "iocfgl", "iocfgb", "iocfgr", "iocfgt";
-            gpio-controller;
-            #gpio-cells = <2>;
-
-            uart_pins_a: uart-0 {
-                pins1 {
-                    pinmux = <MT6797_GPIO232__FUNC_URXD1>,
-                            <MT6797_GPIO233__FUNC_UTXD1>;
-                };
-            };
-        };
-    };
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml
similarity index 65%
rename from Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml
index 73ae6e11410b..1a1a03cede3c 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml
@@ -1,53 +1,154 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/mediatek,pinctrl-mt6795.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt67xx-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT6795 Pin Controller
+title: Mediatek MT67xx Pin Controller
 
 maintainers:
+  - Andy Teng <andy.teng@mediatek.com>
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Sean Wang <sean.wang@kernel.org>
+  - Yassine Oudjana <y.oudjana@protonmail.com>
 
-description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+description:
+  The MediaTek pin controller on MT67xx SoCs is used to control
+  pin functions, pull up/down resistance and drive strength options.
 
 properties:
   compatible:
-    const: mediatek,mt6795-pinctrl
+    oneOf:
+      - enum:
+          - mediatek,mt6765-pinctrl
+          - mediatek,mt6795-pinctrl
+          - mediatek,mt6797-pinctrl
+      - items:
+          - const: mediatek,mt6779-pinctrl
+          - const: syscon
+
+  reg:
+    description: Physical addresses for GPIO base(s) and EINT registers.
+
+  reg-names: true
 
   gpio-controller: true
 
-  '#gpio-cells':
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+  "#gpio-cells":
     const: 2
+    description: |
+      Number of cells in GPIO specifier. Since the generic GPIO binding
+      is used, the amount of cells must be specified as 2. See the below
+      mentioned gpio binding representation for description of particular
+      cells.
 
   gpio-ranges:
     description: GPIO valid number range.
     maxItems: 1
 
-  reg:
-    description:
-      Physical address base for gpio base and eint registers.
-    minItems: 2
-
-  reg-names:
-    items:
-      - const: base
-      - const: eint
+  interrupts:
+    description: The interrupt outputs to sysirq.
 
   interrupt-controller: true
 
-  '#interrupt-cells':
+  "#interrupt-cells":
     const: 2
 
-  interrupts:
-    description: The interrupt outputs to sysirq.
-    maxItems: 1
+required:
+  - compatible
+  - reg
+  - reg-names
+  - gpio-controller
+  - "#gpio-cells"
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6765-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+
+        reg-names:
+          items:
+            - const: iocfg0
+            - const: iocfg1
+            - const: iocfg2
+            - const: iocfg3
+            - const: iocfg4
+            - const: iocfg5
+            - const: iocfg6
+            - const: iocfg7
+            - const: eint
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6779-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+
+        reg-names:
+          items:
+            - const: gpio
+            - const: iocfg_rm
+            - const: iocfg_br
+            - const: iocfg_lm
+            - const: iocfg_lb
+            - const: iocfg_rt
+            - const: iocfg_lt
+            - const: iocfg_tl
+            - const: eint
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6795-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+        reg-names:
+          items:
+            - const: base
+            - const: eint
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6797-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+
+        reg-names:
+          items:
+            - const: gpio
+            - const: iocfgl
+            - const: iocfgb
+            - const: iocfgr
+            - const: iocfgt
+  - if:
+      properties:
+        reg-names:
+          contains:
+            const: eint
+    then:
+      required:
+        - interrupts
+        - interrupt-controller
+        - "#interrupt-cells"
 
 # PIN CONFIGURATION NODES
 patternProperties:
@@ -59,24 +160,24 @@ patternProperties:
         type: object
         additionalProperties: false
         description: |
-          A pinctrl node should contain at least one subnodes representing the
+          A pinctrl node should contain at least one subnode representing the
           pinctrl groups available on the machine. Each subnode will list the
-          pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          pins it needs and how they should be configured, with regard to mux
+          configuration, pull-ups/downs, drive strength, input enable/disable
+          and schmitt input.
           An example of using macro:
           pincontroller {
             /* GPIO0 set as multifunction GPIO0 */
             gpio-pins {
               pins {
                 pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
-              }
+              };
             };
             /* GPIO45 set as multifunction SDA0 */
             i2c0-pins {
               pins {
                 pinmux = <PINMUX_GPIO45__FUNC_SDA0>;
-              }
+              };
             };
           };
         $ref: "pinmux-node.yaml"
@@ -96,20 +197,20 @@ patternProperties:
             oneOf:
               - type: boolean
               - enum: [100, 101, 102, 103]
-                description: mt6795 pull down PUPD/R0/R1 type define value.
+                description: Pull down PUPD/R0/R1 type define value.
             description: |
                For normal pull down type, it is not necessary to specify R1R0
-               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
+               values. When pull down type is PUPD/R0/R1, adding R1R0 defines
                will set different resistance values.
 
           bias-pull-up:
             oneOf:
               - type: boolean
               - enum: [100, 101, 102, 103]
-                description: mt6795 pull up PUPD/R0/R1 type define value.
+                description: Pull up PUPD/R0/R1 type define value.
             description: |
                For normal pull up type, it is not necessary to specify R1R0
-               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
+               values. When pull up type is PUPD/R0/R1, adding R1R0 defines
                will set different resistance values.
 
           bias-disable: true
@@ -151,20 +252,6 @@ patternProperties:
         required:
           - pinmux
 
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
-
 additionalProperties: false
 
 examples:
diff --git a/MAINTAINERS b/MAINTAINERS
index 677574d5c9a0..5aa093aaa85e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16213,7 +16213,7 @@ M:	Sean Wang <sean.wang@kernel.org>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
-F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt67xx-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
 F:	drivers/pinctrl/mediatek/
-- 
2.37.3

