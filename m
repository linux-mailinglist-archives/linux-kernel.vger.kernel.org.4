Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F406B83A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjCMVCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCMVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:01:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA9848C5;
        Mon, 13 Mar 2023 14:00:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so2412979edd.5;
        Mon, 13 Mar 2023 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yu8jx+Bn0uWS9+tZTglcUL4SPeA/bfBOXrCTgW/Wh8=;
        b=F5imDGPBQJ4OPps0mBR+WdzIkYU1yBrvdmtvMrXf/wLC3DrIuc1a+o5ShiGLShKDoX
         af3MGAlaVwmkQlnUJB7MEAfUm8WOzejf/LlRWgzl/3e7G2uCnPGJcxcrl+bpOj7QbIJb
         jJZ3t5EtbOo09QSUGK1n1Ul5bQIsy2dENcEJL/KV5Bs+dZIZuNijjg41LlHzFCWlwtPD
         Vi70U4UjNDuPT2zgAcQLE4OY3l4TrfCiTCIZON385qiHawHpgJhI3mF0rbN4YWHbIPvE
         51w2WWJ+pjP7YSaI55uetv2iyxKtvd/dlEX0wo1D1Um4WIoke140+c6yfQ1gmwBVsk5E
         +3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yu8jx+Bn0uWS9+tZTglcUL4SPeA/bfBOXrCTgW/Wh8=;
        b=Aaw57MFvxe8257BEnYzLJZCDv8oauRM3Etq9Zen5uXQ3qDQUk5QjixZA7LDuyJYNde
         xpjEjyBH+IXaqrkPXRctwQgwy1HisUWOUPnkou1GyS6/6pvb7qP14kds6J4AG0FhN/xJ
         kC55v4j8it5RIGBDYirRV4kDjCQ5AnRcTicRGL0xOkwLfveOnVilG5isvXAiZrgqawyR
         wUkGbZNA5em20EhcxtoVypBdR7gmMP38npFJSUc+ZK+SbzoglNuu/OtvPkEkbD47dQDY
         QGCbj255Ro0pVvacNJ3dOc876/bLvETVYi3o98RvNOBYDIAk8lzKnQXvKcfsSe2w+vog
         DpIQ==
X-Gm-Message-State: AO0yUKXXyhSeny1US1+Ia15q+OX4hQ0SEELtpP0Tizq+hb9XFd22rp+H
        SZO/CE3v0mX8GDmlTzZhbps=
X-Google-Smtp-Source: AK7set8O+zTLAJ/ibIANk2plPS4xQSAYw0Zpvzwr1pmQb/b/3u3yRtdsvddNKENb9PsKBNCv5WNpqQ==
X-Received: by 2002:a17:906:5942:b0:92b:a511:c19e with SMTP id g2-20020a170906594200b0092ba511c19emr2580824ejr.34.1678741239723;
        Mon, 13 Mar 2023 14:00:39 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:39 -0700 (PDT)
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
Subject: [PATCH v2 19/21] dt-bindings: pinctrl: ralink: rt305x: split binding
Date:   Mon, 13 Mar 2023 23:59:19 +0300
Message-Id: <20230313205921.35342-20-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313205921.35342-1-arinc.unal@arinc9.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
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

Split the schema out to ralink,rt3352-pinctrl.yaml and
ralink,rt5350-pinctrl.yaml.

Remove ralink,rt3352-pinctrl and ralink,rt5350-pinctrl from rt305x.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/ralink,rt305x-pinctrl.yaml        |  83 +-----
 .../pinctrl/ralink,rt3352-pinctrl.yaml        | 243 ++++++++++++++++++
 .../pinctrl/ralink,rt5350-pinctrl.yaml        | 206 +++++++++++++++
 3 files changed, 455 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 55c6f9826e76..95a904273009 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -11,17 +11,13 @@ maintainers:
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description: |
-  Ralink RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
-  SoCs.
+  Ralink RT305X pin controller for RT3050, RT3052, and RT3350 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
 properties:
   compatible:
-    enum:
-      - ralink,rt305x-pinctrl
-      - ralink,rt3352-pinctrl
-      - ralink,rt5350-pinctrl
+    const: ralink,rt305x-pinctrl
 
 patternProperties:
   '-pins$':
@@ -39,21 +35,9 @@ patternProperties:
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
@@ -72,17 +56,7 @@ patternProperties:
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
@@ -129,24 +103,6 @@ patternProperties:
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
@@ -156,15 +112,6 @@ patternProperties:
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
@@ -219,15 +166,6 @@ patternProperties:
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
@@ -246,15 +184,6 @@ patternProperties:
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
 allOf:
   - $ref: pinctrl.yaml#
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
new file mode 100644
index 000000000000..c9bc6cfd834c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
@@ -0,0 +1,243 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt3352-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT3352 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  Ralink RT3352 pin controller for RT3352 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,rt3352-pinctrl
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+        additionalProperties: false
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
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+      compatible = "ralink,rt3352-pinctrl";
+
+      i2c_pins: i2c0-pins {
+        pinmux {
+          groups = "i2c";
+          function = "i2c";
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
new file mode 100644
index 000000000000..f248202ce866
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
@@ -0,0 +1,206 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt5350-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT5350 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  Ralink RT5350 pin controller for RT5350 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,rt5350-pinctrl
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+        additionalProperties: false
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
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+      compatible = "ralink,rt5350-pinctrl";
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

