Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6016BF424
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCQVcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCQVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3932F07C;
        Fri, 17 Mar 2023 14:30:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so25311475edb.13;
        Fri, 17 Mar 2023 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+Cbog22+6j+VeMCe1DOeI/RCKtalEeyJ2KLFOjeE24=;
        b=BximcnbpdSRuuS88COyoeeqbC3tBRXhEqTRpHldbjH1ZfoA5lN76Xzp7No9fEPLJjz
         ZBYvjHE7Auk+uuh1dipfWUyZnKWpOEXztr/8vOtoGKxgKRXuawprcXJS2MQWoOBb4989
         fptJleglrrnq51uBcXZdt6UehL7cViLqcvbuBtb4rJ4bDxeBqe5juT5A9qyMQfuvcTSl
         21WJV90azhdfEh3UgM3xvdRIPSPYCbYMJuIb8O4/3ECdCU0OQl01QqBXOjqMySoenhyW
         vjLOD0ZYDqNWeth6gPubQywwmtYmJkJnzk/XpAZRxME9aaKT4l6M188Ri6iyxJr3M/tj
         CK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+Cbog22+6j+VeMCe1DOeI/RCKtalEeyJ2KLFOjeE24=;
        b=k3qEY0xbY9SyNuI3O835ktuYyhXWUrTKemv4CcshhODgSwX/m/Z6mvmSdTeByYAPwt
         4TEO/YM5cbpM0z74cnJ8IEHqWSikf+87n8eIKuUlLkQZZQuX+aylT/uT6d53j2IzKM+G
         I/pKPDMrZQqLbEa9mJ4yBe1H9TQLXI6oQJFlLRUJxVp8tATPK2k6ewjrELVkcG70DqAD
         jSi6Y9pMoyLB+TpstlRZcniz6NBziwW3wQmDQ02fC/DNn9WMb9bIR82QY1QJxLrW54u/
         b0nTWxmVF+N7xOrHNtd+QmGmBdJ0KoW1AIe8PKXvqt+SBENZLDepQ4zSjjcTuvjDkp57
         raOA==
X-Gm-Message-State: AO0yUKVOz6KeZ9r7lNvC+6/WZf+cXx0g/Uzq6NidhO6gF3nJ21ppr4su
        /OThkBQoLc3H1jfOymsNmnY=
X-Google-Smtp-Source: AK7set+IepPc2a8TznbC1ZVXswq+bHqZM81zMzV0a40YrvcG32iL6GZZ686SKAmBy6MZlwSfxV+95A==
X-Received: by 2002:a17:906:5645:b0:932:e9c7:c32 with SMTP id v5-20020a170906564500b00932e9c70c32mr853224ejr.59.1679088654459;
        Fri, 17 Mar 2023 14:30:54 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:54 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 15/21] dt-bindings: pinctrl: {mediatek,ralink}: fix formatting
Date:   Sat, 18 Mar 2023 00:30:05 +0300
Message-Id: <20230317213011.13656-16-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Change the style of description properties to plain style where there's no
need to preserve the line endings, and vice versa.

Fix capitalisation and indentation.

Fit the schemas to 80 columns for each line.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      | 22 +++---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 33 +++++----
 .../pinctrl/mediatek,mt6795-pinctrl.yaml      | 41 +++++-----
 .../pinctrl/mediatek,mt7620-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,mt7621-pinctrl.yaml      |  2 +-
 .../pinctrl/mediatek,mt7622-pinctrl.yaml      | 26 +++----
 .../pinctrl/mediatek,mt7981-pinctrl.yaml      | 33 +++++----
 .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 68 ++++++++---------
 .../pinctrl/mediatek,mt8183-pinctrl.yaml      | 26 ++++---
 .../pinctrl/mediatek,mt8186-pinctrl.yaml      | 47 ++++++------
 .../pinctrl/mediatek,mt8188-pinctrl.yaml      | 74 ++++++++++---------
 .../pinctrl/mediatek,mt8192-pinctrl.yaml      | 47 ++++++------
 .../pinctrl/mediatek,mt8195-pinctrl.yaml      | 41 +++++-----
 .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 28 +++----
 .../pinctrl/ralink,rt2880-pinctrl.yaml        |  2 +-
 .../pinctrl/ralink,rt305x-pinctrl.yaml        |  2 +-
 .../pinctrl/ralink,rt3883-pinctrl.yaml        |  2 +-
 17 files changed, 258 insertions(+), 238 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index 77b1b52f5799..5e80621800a9 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT65xx Pin Controller
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
+description:
   The MediaTek's MT65xx Pin controller is used to control SoC pins.
 
 properties:
@@ -30,7 +30,7 @@ properties:
 
   pins-are-numbered:
     $ref: /schemas/types.yaml#/definitions/flag
-    description: |
+    description:
       Specify the subnodes are using numbered pinmux to specify pins. (UNUSED)
     deprecated: true
 
@@ -38,10 +38,10 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   mediatek,pctl-regmap:
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -49,7 +49,7 @@ properties:
       maxItems: 1
     minItems: 1
     maxItems: 2
-    description: |
+    description:
       Should be phandles of the syscfg node.
 
   interrupt-controller: true
@@ -77,7 +77,7 @@ patternProperties:
       '(^pins|pins?$)':
         type: object
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
@@ -88,14 +88,14 @@ patternProperties:
         properties:
           pinmux:
             description:
-              integer array, represents gpio pin number and mux setting.
+              Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
               defined as macros in <soc>-pinfunc.h directly.
 
           bias-disable: true
 
           bias-pull-up:
-            description: |
+            description:
               Besides generic pinconfig options, it can be used as the pull up
               settings for 2 pull resistors, R0 and R1. User can configure those
               special pins. Some macros have been defined for this usage, such
@@ -117,7 +117,7 @@ patternProperties:
           input-schmitt-disable: true
 
           drive-strength:
-            description: |
+            description:
               Can support some arguments, such as MTK_DRIVE_4mA, MTK_DRIVE_6mA,
               etc. See dt-bindings/pinctrl/mt65xx.h for valid arguments.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index c2fea29fa02f..1d038f6f8971 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -11,8 +11,8 @@ maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
 description:
-  The MediaTek pin controller on MT6779 is used to control pin
-  functions, pull up/down resistance and drive strength options.
+  The MediaTek pin controller on MT6779 is used to control pin functions, pull
+  up/down resistance and drive strength options.
 
 properties:
   compatible:
@@ -29,22 +29,22 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   gpio-ranges:
     minItems: 1
     maxItems: 5
-    description: |
+    description:
       GPIO valid number range.
 
   interrupt-controller: true
 
   interrupts:
     maxItems: 1
-    description: |
+    description:
       Specifies the summary IRQ.
 
   "#interrupt-cells":
@@ -118,19 +118,20 @@ patternProperties:
     patternProperties:
       '-pins*$':
         type: object
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
 
         properties:
           pinmux:
             description:
-              integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are defined
-              as macros in boot/dts/<soc>-pinfunc.h directly.
+              Integer array, represents gpio pin number and mux setting.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in boot/dts/<soc>-pinfunc.h directly.
 
           bias-disable: true
 
@@ -159,7 +160,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -170,7 +172,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
index a78df32e6c39..c3bf98749fa4 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Sean Wang <sean.wang@kernel.org>
 
-description: |
+description:
   The MediaTek's MT6795 Pin controller is used to control SoC pins.
 
 properties:
@@ -20,10 +20,10 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
@@ -32,7 +32,7 @@ properties:
 
   reg:
     description:
-      Physical address base for gpio base and eint registers.
+      Physical address base for GPIO base and eint registers.
     minItems: 2
 
   reg-names:
@@ -65,8 +65,8 @@ patternProperties:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
           An example of using macro:
           pincontroller {
             /* GPIO0 set as multifunction GPIO0 */
@@ -86,11 +86,10 @@ patternProperties:
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
-              directly.
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -100,20 +99,20 @@ patternProperties:
               - type: boolean
               - enum: [100, 101, 102, 103]
                 description: mt6795 pull down PUPD/R0/R1 type define value.
-            description: |
-               For normal pull down type, it is not necessary to specify R1R0
-               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
-               will set different resistance values.
+            description:
+              For normal pull down type, it is not necessary to specify R1R0
+              values; When pull down type is PUPD/R0/R1, adding R1R0 defines
+              will set different resistance values.
 
           bias-pull-up:
             oneOf:
               - type: boolean
               - enum: [100, 101, 102, 103]
                 description: mt6795 pull up PUPD/R0/R1 type define value.
-            description: |
-               For normal pull up type, it is not necessary to specify R1R0
-               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
-               will set different resistance values.
+            description:
+              For normal pull up type, it is not necessary to specify R1R0
+              values; When pull up type is PUPD/R0/R1, adding R1R0 defines will
+              set different resistance values.
 
           bias-disable: true
 
@@ -132,7 +131,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -143,7 +143,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
index 0dcdc3788e66..808dd8bd276f 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
index 32506c538459..e568b9c13727 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   MediaTek MT7621 pin controller for MT7621 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index 3531b63ca4bf..38dc41c735eb 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT7622 Pin Controller
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
+description:
   The MediaTek's MT7622 Pin controller is used to control SoC pins.
 
 properties:
@@ -29,10 +29,10 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   interrupt-controller: true
 
@@ -68,18 +68,18 @@ patternProperties:
       '^mux(-|$)':
         type: object
         additionalProperties: false
-        description: |
+        description:
           pinmux configuration nodes.
         $ref: "/schemas/pinctrl/pinmux-node.yaml"
         properties:
           function:
-            description: |
+            description:
               A string containing the name of the function to mux to the group.
             enum: [emmc, eth, i2c, i2s, ir, led, flash, pcie, pmic, pwm, sd,
                    spi, tdm, uart, watchdog, wifi]
 
           groups:
-            description: |
+            description:
               An array of strings. Each string contains the name of a group.
 
           drive-strength:
@@ -247,18 +247,18 @@ patternProperties:
       '^conf(-|$)':
         type: object
         additionalProperties: false
-        description: |
+        description:
           pinconf configuration nodes.
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
 
         properties:
           groups:
-            description: |
+            description:
               An array of strings. Each string contains the name of a group.
               Valid values are the same as the pinmux node.
 
           pins:
-            description: |
+            description:
               An array of strings. Each string contains the name of a pin.
             enum: [GPIO_A, I2S1_IN, I2S1_OUT, I2S_BCLK, I2S_WS, I2S_MCLK, TXD0,
                    RXD0, SPI_WP, SPI_HOLD, SPI_CLK, SPI_MOSI, SPI_MISO, SPI_CS,
@@ -315,14 +315,14 @@ patternProperties:
             enum: [0, 1]
 
           mediatek,tdsel:
-            description: |
+            description:
               An integer describing the steps for output level shifter duty
               cycle when asserted (high pulse width adjustment). Valid arguments
               are from 0 to 15.
             $ref: /schemas/types.yaml#/definitions/uint32
 
           mediatek,rdsel:
-            description: |
+            description:
               An integer describing the steps for input level shifter duty cycle
               when asserted (high pulse width adjustment). Valid arguments are
               from 0 to 63.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
index c3373290a8a1..10717cee9058 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
@@ -37,7 +37,7 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: >
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
       the amount of cells must be specified as 2. See the below mentioned gpio
       binding representation for description of particular cells.
@@ -111,7 +111,9 @@ patternProperties:
           "watchdog1"            "watchdog"  13
           "udi"                  "udi"       9, 10, 11, 12, 13
           "drv_vbus"             "usb"       14
-          "emmc_45"              "flash"     15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25
+          "emmc_45"              "flash"     15, 16, 17, 18, 19, 20, 21, 22, 23,
+                                             24, 25
+
           "snfi"                 "flash"     16, 17, 18, 19, 20, 21
           "spi0"                 "spi"       16, 17, 18, 19
           "spi0_wp_hold"         "spi"       20, 21
@@ -148,7 +150,7 @@ patternProperties:
           "wf5g_led0"            "led"       31
           "wf5g_led1"            "led"       35
           "mt7531_int"           "eth"       38
-          "ant_sel"              "ant"       14, 15, 16, 17, 18, 19, 20, 21, 22
+          "ant_sel"              "ant"       14, 15, 16, 17, 18, 19, 20, 21, 22,
                                              23, 24, 25, 34, 35
 
         $ref: /schemas/pinctrl/pinmux-node.yaml
@@ -256,7 +258,8 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [gbe_led0, gbe_led1, wf2g_led0, wf2g_led1, wf5g_led0, wf5g_led1]
+                  enum: [gbe_led0, gbe_led1, wf2g_led0, wf2g_led1, wf5g_led0,
+                         wf5g_led1]
           - if:
               properties:
                 function:
@@ -275,7 +278,8 @@ patternProperties:
               properties:
                 groups:
                   items:
-                    enum: [spi1_0, spi0, spi0_wp_hold, spi1_1, spi2, spi2_wp_hold]
+                    enum: [spi1_0, spi0, spi0_wp_hold, spi1_1, spi2,
+                           spi2_wp_hold]
                   maxItems: 4
           - if:
               properties:
@@ -332,13 +336,14 @@ patternProperties:
                      JTAG_JTDO, JTAG_JTDI, JTAG_JTMS, JTAG_JTCLK, JTAG_JTRST_N,
                      WO_JTAG_JTDO, WO_JTAG_JTDI, WO_JTAG_JTMS, WO_JTAG_JTCLK,
                      WO_JTAG_JTRST_N, USB_VBUS, PWM0, SPI0_CLK, SPI0_MOSI,
-                     SPI0_MISO, SPI0_CS, SPI0_HOLD, SPI0_WP, SPI1_CLK, SPI1_MOSI,
-                     SPI1_MISO, SPI1_CS, SPI2_CLK, SPI2_MOSI, SPI2_MISO, SPI2_CS,
-                     SPI2_HOLD, SPI2_WP, UART0_RXD, UART0_TXD, PCIE_CLK_REQ,
-                     PCIE_WAKE_N, SMI_MDC, SMI_MDIO, GBE_INT, GBE_RESET,
-                     WF_DIG_RESETB, WF_CBA_RESETB, WF_XO_REQ, WF_TOP_CLK,
-                     WF_TOP_DATA, WF_HB1, WF_HB2, WF_HB3, WF_HB4, WF_HB0,
-                     WF_HB0_B, WF_HB5, WF_HB6, WF_HB7, WF_HB8, WF_HB9, WF_HB10]
+                     SPI0_MISO, SPI0_CS, SPI0_HOLD, SPI0_WP, SPI1_CLK,
+                     SPI1_MOSI, SPI1_MISO, SPI1_CS, SPI2_CLK, SPI2_MOSI,
+                     SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP, UART0_RXD,
+                     UART0_TXD, PCIE_CLK_REQ, PCIE_WAKE_N, SMI_MDC, SMI_MDIO,
+                     GBE_INT, GBE_RESET, WF_DIG_RESETB, WF_CBA_RESETB,
+                     WF_XO_REQ, WF_TOP_CLK, WF_TOP_DATA, WF_HB1, WF_HB2, WF_HB3,
+                     WF_HB4, WF_HB0, WF_HB0_B, WF_HB5, WF_HB6, WF_HB7, WF_HB8,
+                     WF_HB9, WF_HB10]
             maxItems: 57
 
           bias-disable: true
@@ -348,7 +353,7 @@ patternProperties:
               - type: boolean
                 description: normal pull up.
               - enum: [100, 101, 102, 103]
-                description: >
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
@@ -357,7 +362,7 @@ patternProperties:
               - type: boolean
                 description: normal pull down.
               - enum: [100, 101, 102, 103]
-                description: >
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 71033831d03d..7157500a7f81 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT7986 Pin Controller
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
+description:
   The MediaTek's MT7986 Pin controller is used to control SoC pins.
 
 properties:
@@ -37,15 +37,15 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   gpio-ranges:
     minItems: 1
     maxItems: 5
-    description: |
+    description:
       GPIO valid number range.
 
   interrupt-controller: true
@@ -81,7 +81,7 @@ patternProperties:
           The following table shows the effective values of "group", "function"
           properties and chip pinout pins
 
-          groups	    function    pins (in pin#)
+          groups            function    pins (in pin#)
           ---------------------------------------------------------------------
           "watchdog"        "watchdog"  0
           "wifi_led"        "led"       1, 2
@@ -97,8 +97,9 @@ patternProperties:
           "pwm1_0"          "pwm"       22,
           "snfi"            "flash"     23, 24, 25, 26, 27, 28
           "spi1_2"          "spi"       29, 30, 31, 32
-          "emmc_45"         "emmc"      22, 23, 24, 25, 26, 27, 28, 29, 30,
-                                        31, 32
+          "emmc_45"         "emmc"      22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+                                        32
+
           "spi1_1"          "spi"       23, 24, 25, 26
           "uart1_2_rx_tx"   "uart"      29, 30
           "uart1_2_cts_rts" "uart"      31, 32
@@ -115,8 +116,9 @@ patternProperties:
           "pcie_pereset"    "pcie"      41
           "uart1"           "uart"      42, 43, 44, 45
           "uart2"           "uart"      46, 47, 48, 49
-          "emmc_51"         "emmc"      50, 51, 52, 53, 54, 55, 56, 57, 57,
-                                        59, 60, 61
+          "emmc_51"         "emmc"      50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
+                                        60, 61
+
           "pcm"             "audio"     62, 63, 64, 65
           "i2s"             "audio"     62, 63, 64, 65
           "switch_int"      "eth"       66
@@ -129,18 +131,17 @@ patternProperties:
         $ref: "/schemas/pinctrl/pinmux-node.yaml"
         properties:
           function:
-            description: |
+            description:
               A string containing the name of the function to mux to the group.
               There is no "audio", "pcie" functions on mt7986b, you can only use
               those functions on mt7986a.
             enum: [audio, emmc, eth, i2c, led, flash, pcie, pwm, spi, uart,
                    watchdog, wifi]
           groups:
-            description: |
+            description:
               An array of strings. Each string contains the name of a group.
-              There is no "pcie_pereset", "uart1", "uart2" "emmc_51", "pcm",
-              and "i2s" groups on mt7986b, you can only use those groups on
-              mt7986a.
+              There is no "pcie_pereset", "uart1", "uart2" "emmc_51", "pcm", and
+              "i2s" groups on mt7986b, you can only use those groups on mt7986a.
         required:
           - function
           - groups
@@ -258,29 +259,30 @@ patternProperties:
       '.*conf.*':
         type: object
         additionalProperties: false
-        description: |
+        description:
           pinconf configuration nodes.
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
 
         properties:
           pins:
-            description: |
-              An array of strings. Each string contains the name of a pin.
-              There is no PIN 41 to PIN 65 above on mt7686b, you can only use
-              those pins on mt7986a.
+            description:
+              An array of strings. Each string contains the name of a pin. There
+              is no PIN 41 to PIN 65 above on mt7686b, you can only use those
+              pins on mt7986a.
             items:
               enum: [SYS_WATCHDOG, WF2G_LED, WF5G_LED, I2C_SCL, I2C_SDA, GPIO_0,
                      GPIO_1, GPIO_2, GPIO_3, GPIO_4, GPIO_5, GPIO_6, GPIO_7,
-                     GPIO_8, GPIO_9, GPIO_10, GPIO_11, GPIO_12, GPIO_13, GPIO_14,
-                     GPIO_15, PWM0, PWM1, SPI0_CLK, SPI0_MOSI, SPI0_MISO, SPI0_CS,
-                     SPI0_HOLD, SPI0_WP, SPI1_CLK, SPI1_MOSI, SPI1_MISO, SPI1_CS,
-                     SPI2_CLK, SPI2_MOSI, SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP,
-                     UART0_RXD, UART0_TXD, PCIE_PERESET_N, UART1_RXD, UART1_TXD,
-                     UART1_CTS, UART1_RTS, UART2_RXD, UART2_TXD, UART2_CTS,
-                     UART2_RTS, EMMC_DATA_0, EMMC_DATA_1, EMMC_DATA_2,
-                     EMMC_DATA_3, EMMC_DATA_4, EMMC_DATA_5, EMMC_DATA_6,
-                     EMMC_DATA_7, EMMC_CMD, EMMC_CK, EMMC_DSL, EMMC_RSTB, PCM_DTX,
-                     PCM_DRX, PCM_CLK, PCM_FS, MT7531_INT, SMI_MDC, SMI_MDIO,
+                     GPIO_8, GPIO_9, GPIO_10, GPIO_11, GPIO_12, GPIO_13,
+                     GPIO_14, GPIO_15, PWM0, PWM1, SPI0_CLK, SPI0_MOSI,
+                     SPI0_MISO, SPI0_CS, SPI0_HOLD, SPI0_WP, SPI1_CLK,
+                     SPI1_MOSI, SPI1_MISO, SPI1_CS, SPI2_CLK, SPI2_MOSI,
+                     SPI2_MISO, SPI2_CS, SPI2_HOLD, SPI2_WP, UART0_RXD,
+                     UART0_TXD, PCIE_PERESET_N, UART1_RXD, UART1_TXD, UART1_CTS,
+                     UART1_RTS, UART2_RXD, UART2_TXD, UART2_CTS, UART2_RTS,
+                     EMMC_DATA_0, EMMC_DATA_1, EMMC_DATA_2, EMMC_DATA_3,
+                     EMMC_DATA_4, EMMC_DATA_5, EMMC_DATA_6, EMMC_DATA_7,
+                     EMMC_CMD, EMMC_CK, EMMC_DSL, EMMC_RSTB, PCM_DTX, PCM_DRX,
+                     PCM_CLK, PCM_FS, MT7531_INT, SMI_MDC, SMI_MDIO,
                      WF0_DIG_RESETB, WF0_CBA_RESETB, WF0_XO_REQ, WF0_TOP_CLK,
                      WF0_TOP_DATA, WF0_HB1, WF0_HB2, WF0_HB3, WF0_HB4, WF0_HB0,
                      WF0_HB0_B, WF0_HB5, WF0_HB6, WF0_HB7, WF0_HB8, WF0_HB9,
@@ -297,7 +299,7 @@ patternProperties:
               - type: boolean
                 description: normal pull up.
               - enum: [100, 101, 102, 103]
-                description: |
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
@@ -306,7 +308,7 @@ patternProperties:
               - type: boolean
                 description: normal pull down.
               - enum: [100, 101, 102, 103]
-                description: |
+                description:
                   PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0 defines in
                   dt-bindings/pinctrl/mt65xx.h.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index 3e34b03e11fc..372a3aefa937 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT8183 Pin Controller
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
-description: |+
+description:
   The MediaTek's MT8183 Pin controller is used to control SoC pins.
 
 properties:
@@ -37,15 +37,15 @@ properties:
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   gpio-ranges:
     minItems: 1
     maxItems: 5
-    description: |
+    description:
       GPIO valid number range.
 
   interrupt-controller: true
@@ -74,7 +74,7 @@ patternProperties:
       '^pins':
         type: object
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
@@ -85,7 +85,7 @@ patternProperties:
         properties:
           pinmux:
             description:
-              integer array, represents gpio pin number and mux setting.
+              Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
               defined as macros in <soc>-pinfunc.h directly.
 
@@ -139,7 +139,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -150,7 +151,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -159,14 +161,14 @@ patternProperties:
             enum: [0, 1, 2, 3]
 
           mediatek,tdsel:
-            description: |
+            description:
               An integer describing the steps for output level shifter duty
               cycle when asserted (high pulse width adjustment). Valid arguments
               are from 0 to 15.
             $ref: /schemas/types.yaml#/definitions/uint32
 
           mediatek,rdsel:
-            description: |
+            description:
               An integer describing the steps for input level shifter duty cycle
               when asserted (high pulse width adjustment). Valid arguments are
               from 0 to 63.
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
index a0519acc92fe..eb6a5cdecc6c 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT8186 Pin Controller
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
-description: |
+description:
   The MediaTek's MT8186 Pin controller is used to control SoC pins.
 
 properties:
@@ -19,10 +19,10 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
@@ -31,14 +31,14 @@ properties:
   gpio-line-names: true
 
   reg:
-    description: |
-      Physical address base for gpio base registers. There are 8 different GPIO
+    description:
+      Physical address base for GPIO base registers. There are 8 different GPIO
       physical address base in mt8186.
     maxItems: 8
 
   reg-names:
-    description: |
-      Gpio base register names.
+    description:
+      GPIO base register names.
     items:
       - const: iocfg0
       - const: iocfg_lt
@@ -60,9 +60,9 @@ properties:
 
   mediatek,rsel-resistance-in-si-unit:
     type: boolean
-    description: |
-      Identifying i2c pins pull up/down type which is RSEL. It can support
-      RSEL define or si unit value(ohm) to set different resistance.
+    description:
+      Identifying i2c pins pull up/down type which is RSEL. It can support RSEL
+      define or si unit value(ohm) to set different resistance.
 
 # PIN CONFIGURATION NODES
 patternProperties:
@@ -77,8 +77,8 @@ patternProperties:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
           An example of using macro:
           pincontroller {
             /* GPIO0 set as multifunction GPIO0 */
@@ -98,11 +98,10 @@ patternProperties:
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
-              directly.
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -129,10 +128,10 @@ patternProperties:
               For pull down type is RSEL, it can add RSEL define & resistance
               value(ohm) to set different resistance by identifying property
               "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
-              define in mt8186. It can also support resistance value(ohm)
-              "75000" & "5000" in mt8186.
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" define in
+              mt8186. It can also support resistance value(ohm) "75000" & "5000"
+              in mt8186.
               An example of using RSEL define:
               pincontroller {
                 i2c0_pin {
@@ -174,10 +173,10 @@ patternProperties:
               For pull up type is RSEL, it can add RSEL define & resistance
               value(ohm) to set different resistance by identifying property
               "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
-              define in mt8186. It can also support resistance value(ohm)
-              "1000" & "5000" & "10000" & "75000" in mt8186.
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" define in
+              mt8186. It can also support resistance value(ohm) "1000" & "5000"
+              & "10000" & "75000" in mt8186.
               An example of using si unit resistance value(ohm):
               &pio {
                 mediatek,rsel-resistance-in-si-unit;
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
index 7e750f1e643d..51b3d1247614 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT8188 Pin Controller
 maintainers:
   - Hui Liu <hui.liu@mediatek.com>
 
-description: |
+description:
   The MediaTek's MT8188 Pin controller is used to control SoC pins.
 
 properties:
@@ -19,10 +19,10 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
-      Number of cells in GPIO specifier, should be two. The first cell
-      is the pin number, the second cell is used to specify optional
-      parameters which are defined in <dt-bindings/gpio/gpio.h>.
+    description:
+      Number of cells in GPIO specifier, should be two. The first cell is the
+      pin number, the second cell is used to specify optional parameters which
+      are defined in <dt-bindings/gpio/gpio.h>.
     const: 2
 
   gpio-ranges:
@@ -59,10 +59,11 @@ properties:
 
   mediatek,rsel-resistance-in-si-unit:
     type: boolean
-    description: |
-      We provide two methods to select the resistance for I2C when pull up or pull down.
-      The first is by RSEL definition value, another one is by resistance value(ohm).
-      This flag is used to identify if the method is resistance(si unit) value.
+    description:
+      We provide two methods to select the resistance for I2C when pull up or
+      pull down. The first is by RSEL definition value, another one is by
+      resistance value(ohm). This flag is used to identify if the method is
+      resistance(si unit) value.
 
 # PIN CONFIGURATION NODES
 patternProperties:
@@ -75,16 +76,16 @@ patternProperties:
         type: object
         $ref: "/schemas/pinctrl/pincfg-node.yaml"
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnode representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
               defined as macros in dt-bindings/pinctrl/mediatek,<soc>-pinfunc.h
@@ -106,18 +107,21 @@ patternProperties:
               - enum: [75000, 5000]
                 description: mt8188 pull down RSEL type si unit value(ohm).
             description: |
-              For pull down type is normal, it doesn't need add RSEL & R1R0 define
-              and resistance value.
+              For pull down type is normal, it doesn't need add RSEL & R1R0
+              define and resistance value.
               For pull down type is PUPD/R0/R1 type, it can add R1R0 define to
               set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
-              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" & "MTK_PUPD_SET_R1R0_11"
-              define in mt8188.
-              For pull down type is RSEL, it can add RSEL define & resistance value(ohm)
-              to set different resistance by identifying property "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" & "MTK_PULL_SET_RSEL_100"
-              & "MTK_PULL_SET_RSEL_101" & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-              define in mt8188. It can also support resistance value(ohm) "75000" & "5000" in mt8188.
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8188.
+              For pull down type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel-resistance-in-si-unit". It can support
+              "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" &
+              "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101" &
+              "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111" define in
+              mt8188. It can also support resistance value(ohm) "75000" & "5000"
+              in mt8188.
 
           bias-pull-up:
             oneOf:
@@ -131,17 +135,19 @@ patternProperties:
             description: |
               For pull up type is normal, it don't need add RSEL & R1R0 define
               and resistance value.
-              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to
-              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
-              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" & "MTK_PUPD_SET_R1R0_11"
-              define in mt8188.
-              For pull up type is RSEL, it can add RSEL define & resistance value(ohm)
-              to set different resistance by identifying property "mediatek,rsel-resistance-in-si-unit".
-              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" & "MTK_PULL_SET_RSEL_100"
-              & "MTK_PULL_SET_RSEL_101" & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-              define in mt8188. It can also support resistance value(ohm)
-              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" & "75000" in mt8188.
+              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to set
+              different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8188.
+              For pull up type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel-resistance-in-si-unit". It can support
+              "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001" &
+              "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" &
+              "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101" &
+              "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111" define in
+              mt8188. It can also support resistance value(ohm) "1000" & "1500"
+              & "2000" & "3000" & "4000" & "5000" & "10000" & "75000" in mt8188.
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
index 3c3dd142a989..8cca1ce40f25 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT8192 Pin Controller
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
-description: |
+description:
   The MediaTek's MT8192 Pin controller is used to control SoC pins.
 
 properties:
@@ -19,27 +19,27 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
-    description: gpio valid number range.
+    description: GPIO valid number range.
     maxItems: 1
 
   gpio-line-names: true
 
   reg:
-    description: |
-      Physical address base for gpio base registers. There are 11 GPIO
-      physical address base in mt8192.
+    description:
+      Physical address base for GPIO base registers. There are 11 GPIO physical
+      address base in mt8192.
     maxItems: 11
 
   reg-names:
-    description: |
-      Gpio base register names.
+    description:
+      GPIO base register names.
     maxItems: 11
 
   interrupt-controller: true
@@ -59,25 +59,26 @@ patternProperties:
     patternProperties:
       '^pins':
         type: object
-        description: |
+        description:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
         $ref: "pinmux-node.yaml"
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
-              Supported pin number and mux varies for different SoCs, and are defined
-              as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           drive-strength:
-            description: |
-              It can support some arguments, such as MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See
-              dt-bindings/pinctrl/mt65xx.h. It can only support 2/4/6/8/10/12/14/16mA in mt8192.
+            description:
+              It can support some arguments, such as MTK_DRIVE_4mA,
+              MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h. It can only
+              support 2/4/6/8/10/12/14/16mA in mt8192.
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
           drive-strength-microamp:
@@ -91,8 +92,8 @@ patternProperties:
                 description: PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0_
                   defines in dt-bindings/pinctrl/mt65xx.h.
               - enum: [200, 201, 202, 203]
-                description: RSEL pull down type. See MTK_PULL_SET_RSEL_
-                  defines in dt-bindings/pinctrl/mt65xx.h.
+                description: RSEL pull down type. See MTK_PULL_SET_RSEL_ defines
+                  in dt-bindings/pinctrl/mt65xx.h.
 
           bias-pull-up:
             oneOf:
@@ -102,8 +103,8 @@ patternProperties:
                 description: PUPD/R1/R0 pull up type. See MTK_PUPD_SET_R1R0_
                   defines in dt-bindings/pinctrl/mt65xx.h.
               - enum: [200, 201, 202, 203]
-                description: RSEL pull up type. See MTK_PULL_SET_RSEL_
-                  defines in dt-bindings/pinctrl/mt65xx.h.
+                description: RSEL pull up type. See MTK_PULL_SET_RSEL_ defines
+                  in dt-bindings/pinctrl/mt65xx.h.
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
index d4d5357cdd1d..b8ba260d74cd 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
@@ -9,7 +9,7 @@ title: MediaTek MT8195 Pin Controller
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
-description: |
+description:
   The MediaTek's MT8195 Pin controller is used to control SoC pins.
 
 properties:
@@ -19,27 +19,27 @@ properties:
   gpio-controller: true
 
   '#gpio-cells':
-    description: |
+    description:
       Number of cells in GPIO specifier. Since the generic GPIO binding is used,
-      the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
     const: 2
 
   gpio-ranges:
-    description: gpio valid number range.
+    description: GPIO valid number range.
     maxItems: 1
 
   gpio-line-names: true
 
   reg:
-    description: |
-      Physical address base for gpio base registers. There are 8 GPIO
-      physical address base in mt8195.
+    description:
+      Physical address base for GPIO base registers. There are 8 GPIO physical
+      address base in mt8195.
     maxItems: 8
 
   reg-names:
-    description: |
-      Gpio base register names.
+    description:
+      GPIO base register names.
     maxItems: 8
 
   interrupt-controller: true
@@ -53,9 +53,9 @@ properties:
 
   mediatek,rsel-resistance-in-si-unit:
     type: boolean
-    description: |
-      Identifying i2c pins pull up/down type which is RSEL. It can support
-      RSEL define or si unit value(ohm) to set different resistance.
+    description:
+      Identifying i2c pins pull up/down type which is RSEL. It can support RSEL
+      define or si unit value(ohm) to set different resistance.
 
 # PIN CONFIGURATION NODES
 patternProperties:
@@ -70,8 +70,8 @@ patternProperties:
           A pinctrl node should contain at least one subnodes representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
-          configuration, pullups, drive strength, input enable/disable and
-          input schmitt.
+          configuration, pullups, drive strength, input enable/disable and input
+          schmitt.
           An example of using macro:
           pincontroller {
             /* GPIO0 set as multifunction GPIO0 */
@@ -91,11 +91,10 @@ patternProperties:
 
         properties:
           pinmux:
-            description: |
+            description:
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
-              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
-              directly.
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -174,9 +173,9 @@ patternProperties:
               & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
               & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
               & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-              define in mt8195. It can also support resistance value(ohm)
-              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" &
-              "75000" in mt8195.
+              define in mt8195. It can also support resistance value(ohm) "1000"
+              & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" & "75000"
+              in mt8195.
               An example of using RSEL define:
               pincontroller {
                 i2c0-pins {
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 42964dfa9fdb..5aa8ba4cb547 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Zhiyong Tao <zhiyong.tao@mediatek.com>
   - Bernhard Rosenkränzer <bero@baylibre.com>
 
-description: |
+description:
   The MediaTek's MT8365 Pin controller is used to control SoC pins.
 
 properties:
@@ -26,17 +26,17 @@ properties:
       maxItems: 1
     minItems: 1
     maxItems: 2
-    description: |
+    description:
       Should be phandles of the syscfg node.
 
   gpio-controller: true
 
   "#gpio-cells":
     const: 2
-    description: |
-      Number of cells in GPIO specifier. Since the generic GPIO
-      binding is used, the amount of cells must be specified as 2. See the below
-      mentioned gpio binding representation for description of particular cells.
+    description:
+      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
+      the amount of cells must be specified as 2. See the below mentioned gpio
+      binding representation for description of particular cells.
 
   interrupt-controller: true
 
@@ -54,7 +54,7 @@ patternProperties:
       "pins$":
         type: object
         additionalProperties: false
-        description: |
+        description:
           A pinctrl node should contain at least one subnode representing the
           pinctrl groups available on the machine. Each subnode will list the
           pins it needs, and how they should be configured, with regard to muxer
@@ -65,14 +65,14 @@ patternProperties:
         properties:
           pinmux:
             description:
-              integer array, represents gpio pin number and mux setting.
+              Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
               defined as macros in <soc>-pinfunc.h directly.
 
           bias-disable: true
 
           bias-pull-up:
-            description: |
+            description:
               Besides generic pinconfig options, it can be used as the pull up
               settings for 2 pull resistors, R0 and R1. User can configure those
               special pins.
@@ -120,7 +120,8 @@ patternProperties:
           mediatek,pull-up-adv:
             description: |
               Pull up setings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -131,7 +132,8 @@ patternProperties:
           mediatek,pull-down-adv:
             description: |
               Pull down settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
+              configure those special pins. Valid arguments are described as
+              below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
               1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
               2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
@@ -140,14 +142,14 @@ patternProperties:
             enum: [0, 1, 2, 3]
 
           mediatek,tdsel:
-            description: |
+            description:
               An integer describing the steps for output level shifter duty
               cycle when asserted (high pulse width adjustment). Valid arguments
               are from 0 to 15.
             $ref: /schemas/types.yaml#/definitions/uint32
 
           mediatek,rdsel:
-            description: |
+            description:
               An integer describing the steps for input level shifter duty cycle
               when asserted (high pulse width adjustment). Valid arguments are
               from 0 to 63.
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index e51667316b2e..43b33dbf115b 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   Ralink RT2880 pin controller for RT2880 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 23fb82f9959c..55c6f9826e76 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   Ralink RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
   SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index adc4f42a175d..8d14e525b25e 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
-description:
+description: |
   Ralink RT3883 pin controller for RT3883 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
-- 
2.37.2

