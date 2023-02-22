Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B469FB53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjBVSlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjBVSkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D942BDB;
        Wed, 22 Feb 2023 10:40:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t13so8682117wrv.13;
        Wed, 22 Feb 2023 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o8MOEwE/dVfgMCl7bmAyjT+NEpiVZUInhrQfgLr0Hc=;
        b=Yx2QEGus5g1VMWhkonYwCdyHoxp3C8oP8Q0n3M8/VPVHeQKFGxLnPfR4bUiZq1Ossb
         esiN/rcW1ZRqywDyPJdN2Pxi6Yj7sIGXsgd7dCzmLH9IWXNLdGLLqqtIa47hnCRHuwdX
         DDIfSX5akeCRMItSM+XSqNg4lauRkvOOG9cG6XU80bJL469BaReUKJ1MbOA4pKvjZQXR
         TFm3r5RI2wEp6FLz1iTW1QhZD7ao14+7umhOcDt1oISGA9H9GKUnJgrIAU3Dd3BWh6d2
         xQ6VfilK6Csvq5wZ8lgvbOL/EOIvW2jKvKFS4VJ6MvyzHxm4oR+D2ODo4Ji6ZVVg6EgC
         hi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o8MOEwE/dVfgMCl7bmAyjT+NEpiVZUInhrQfgLr0Hc=;
        b=EaIdvXn3klr+C5cqSLHC5Ghfra7hQmuvaw40BaxfwxACMIahZhp8azRLePUMKjVJFZ
         zOhAzLJ/YTCW2gMi6hy7NcEaZ63WYLghB1kG06HQlvg2qNHbnbuiocU3FQT/FFKHUEaM
         rMfF3ohsIdNEhJhtDb6xUkxBht0+X1kRoW9CVRmhiomZWabJeLnVjY2ue9J+x7Iby6YQ
         yOnRtAsQiYI6h2+Qd/CVBkQc7FhdROWf4d/VdLKE5SFy+A8jDfu5Y3te4KAxWsROorVG
         dhZUs+siq9HTkozaEGu+Te8WFE3e6HbRLArI59T8hC9PWvbaMfCW3BUxuvy2ZQd8ecYh
         /iTA==
X-Gm-Message-State: AO0yUKWTdA42UsIh9IirsRPAjcmiStdIZToInBWpTPKwrrBJd6bten4o
        128PxOow5WunbUUvFzgoVd4=
X-Google-Smtp-Source: AK7set8b55tFD4C1QYxIyA5oqOb4rTVXxGtnb3DL9lq2HAxP0/eGyZXITvhlPkLgw/mSUH+jnV4anw==
X-Received: by 2002:a5d:5912:0:b0:2c5:58aa:35cb with SMTP id v18-20020a5d5912000000b002c558aa35cbmr8652823wrd.47.1677091225071;
        Wed, 22 Feb 2023 10:40:25 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:24 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 09/16] dt-bindings: pinctrl: mediatek: rt305x: split binding
Date:   Wed, 22 Feb 2023 21:39:25 +0300
Message-Id: <20230222183932.33267-10-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
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

The RT3352 and RT5350 SoCs each contain different pin muxing information,
therefore, should be split. This can be done now that there are compatible
strings to distinguish them from other SoCs.

Split the schema out to mediatek,rt3352-pinctrl.yaml and
mediatek,rt5350-pinctrl.yaml.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../pinctrl/mediatek,rt305x-pinctrl.yaml      |  78 +-----
 .../pinctrl/mediatek,rt3352-pinctrl.yaml      | 247 ++++++++++++++++++
 .../pinctrl/mediatek,rt5350-pinctrl.yaml      | 210 +++++++++++++++
 3 files changed, 462 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
index 61fcf3ab1091..1e6c7e7f2fe2 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
@@ -11,8 +11,7 @@ maintainers:
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  MediaTek RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
-  SoCs.
+  MediaTek RT305X pin controller for RT3050, RT3052, and RT3350 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
@@ -36,21 +35,9 @@ patternProperties:
           function:
             description:
               A string containing the name of the function to mux to the group.
-            anyOf:
-              - description: For RT3050, RT3052 and RT3350 SoCs
-                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
-                       pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
-                       uartlite]
-
-              - description: For RT3352 SoC
-                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
-                       lna, mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi,
-                       spi_cs1, uartf, uartlite, wdg_cs1]
-
-              - description: For RT5350 SoC
-                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
-                       pcm gpio, pcm i2s, pcm uartf, spi, spi_cs1, uartf,
-                       uartlite, wdg_cs1]
+            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
+                   pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
+                   uartlite]
 
           groups:
             description:
@@ -69,17 +56,7 @@ patternProperties:
             then:
               properties:
                 groups:
-                  anyOf:
-                    - description: For RT3050, RT3052 and RT3350 SoCs
-                      enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf,
-                             uartlite]
-
-                    - description: For RT3352 SoC
-                      enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
-                             uartf, uartlite]
-
-                    - description: For RT5350 SoC
-                      enum: [i2c, jtag, led, spi, spi_cs1, uartf, uartlite]
+                  enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf, uartlite]
 
           - if:
               properties:
@@ -126,24 +103,6 @@ patternProperties:
                 groups:
                   enum: [jtag]
 
-          - if:
-              properties:
-                function:
-                  const: led
-            then:
-              properties:
-                groups:
-                  enum: [led]
-
-          - if:
-              properties:
-                function:
-                  const: lna
-            then:
-              properties:
-                groups:
-                  enum: [lna]
-
           - if:
               properties:
                 function:
@@ -153,15 +112,6 @@ patternProperties:
                 groups:
                   enum: [mdio]
 
-          - if:
-              properties:
-                function:
-                  const: pa
-            then:
-              properties:
-                groups:
-                  enum: [pa]
-
           - if:
               properties:
                 function:
@@ -216,15 +166,6 @@ patternProperties:
                 groups:
                   enum: [spi]
 
-          - if:
-              properties:
-                function:
-                  const: spi_cs1
-            then:
-              properties:
-                groups:
-                  enum: [spi_cs1]
-
           - if:
               properties:
                 function:
@@ -243,15 +184,6 @@ patternProperties:
                 groups:
                   enum: [uartlite]
 
-          - if:
-              properties:
-                function:
-                  const: wdg_cs1
-            then:
-              properties:
-                groups:
-                  enum: [spi_cs1]
-
         additionalProperties: false
 
     additionalProperties: false
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
new file mode 100644
index 000000000000..7a74c1602afc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
@@ -0,0 +1,247 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mediatek,rt3352-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek RT3352 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description:
+  MediaTek RT3352 pin controller for RT3352 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,rt3352-pinctrl
+      - ralink,rt305x-pinctrl
+      - ralink,rt2880-pinmux
+
+patternProperties:
+  '-pins$':
+    type: object
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+
+        properties:
+          function:
+            description:
+              A string containing the name of the function to mux to the group.
+            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, lna,
+                   mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1,
+                   uartf, uartlite, wdg_cs1]
+
+          groups:
+            description:
+              An array of strings. Each string contains the name of a group.
+            maxItems: 1
+
+        required:
+          - groups
+          - function
+
+        allOf:
+          - if:
+              properties:
+                function:
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
+                         uartf, uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: gpio i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: gpio uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: i2c
+            then:
+              properties:
+                groups:
+                  enum: [i2c]
+
+          - if:
+              properties:
+                function:
+                  const: i2s uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: jtag
+            then:
+              properties:
+                groups:
+                  enum: [jtag]
+
+          - if:
+              properties:
+                function:
+                  const: led
+            then:
+              properties:
+                groups:
+                  enum: [led]
+
+          - if:
+              properties:
+                function:
+                  const: lna
+            then:
+              properties:
+                groups:
+                  enum: [lna]
+
+          - if:
+              properties:
+                function:
+                  const: mdio
+            then:
+              properties:
+                groups:
+                  enum: [mdio]
+
+          - if:
+              properties:
+                function:
+                  const: pa
+            then:
+              properties:
+                groups:
+                  enum: [pa]
+
+          - if:
+              properties:
+                function:
+                  const: pcm gpio
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: rgmii
+            then:
+              properties:
+                groups:
+                  enum: [rgmii]
+
+          - if:
+              properties:
+                function:
+                  const: spi
+            then:
+              properties:
+                groups:
+                  enum: [spi]
+
+          - if:
+              properties:
+                function:
+                  const: spi_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+          - if:
+              properties:
+                function:
+                  const: uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: uartlite
+            then:
+              properties:
+                groups:
+                  enum: [uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: wdg_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+      compatible = "mediatek,rt3352-pinctrl";
+
+      i2c_pins: i2c0-pins {
+        pinmux {
+          groups = "i2c";
+          function = "i2c";
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
new file mode 100644
index 000000000000..5184cea62640
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
@@ -0,0 +1,210 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mediatek,rt5350-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek RT5350 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description:
+  MediaTek RT5350 pin controller for RT5350 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,rt5350-pinctrl
+      - ralink,rt305x-pinctrl
+      - ralink,rt2880-pinmux
+
+patternProperties:
+  '-pins$':
+    type: object
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+
+        properties:
+          function:
+            description:
+              A string containing the name of the function to mux to the group.
+            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
+                   pcm gpio, pcm i2s, pcm uartf, spi, spi_cs1, uartf, uartlite,
+                   wdg_cs1]
+
+          groups:
+            description:
+              An array of strings. Each string contains the name of a group.
+            maxItems: 1
+
+        required:
+          - groups
+          - function
+
+        allOf:
+          - if:
+              properties:
+                function:
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  enum: [i2c, jtag, led, spi, spi_cs1, uartf, uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: gpio i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: gpio uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: i2c
+            then:
+              properties:
+                groups:
+                  enum: [i2c]
+
+          - if:
+              properties:
+                function:
+                  const: i2s uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: jtag
+            then:
+              properties:
+                groups:
+                  enum: [jtag]
+
+          - if:
+              properties:
+                function:
+                  const: led
+            then:
+              properties:
+                groups:
+                  enum: [led]
+
+          - if:
+              properties:
+                function:
+                  const: pcm gpio
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm i2s
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: pcm uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: spi
+            then:
+              properties:
+                groups:
+                  enum: [spi]
+
+          - if:
+              properties:
+                function:
+                  const: spi_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+          - if:
+              properties:
+                function:
+                  const: uartf
+            then:
+              properties:
+                groups:
+                  enum: [uartf]
+
+          - if:
+              properties:
+                function:
+                  const: uartlite
+            then:
+              properties:
+                groups:
+                  enum: [uartlite]
+
+          - if:
+              properties:
+                function:
+                  const: wdg_cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi_cs1]
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+      compatible = "mediatek,rt5350-pinctrl";
+
+      i2c_pins: i2c0-pins {
+        pinmux {
+          groups = "i2c";
+          function = "i2c";
+        };
+      };
+    };
-- 
2.37.2

