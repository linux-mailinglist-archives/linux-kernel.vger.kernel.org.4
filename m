Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C777D6BF435
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjCQVc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCQVbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33488B6D3C;
        Fri, 17 Mar 2023 14:31:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so25499431edc.3;
        Fri, 17 Mar 2023 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0VhD6TWwJqs+7/MwqgfsHWYoMGA/MgmyVTpHFe9EaI=;
        b=cVflFt8JOb2TkDnZzV2H7jv58vmV4KqxYyXKORJ1N7Bw/GFpY9qBm+khXVVOHyJUfM
         y+hhYpRqYLnW5nW/JGJLZlrptNmkWtJVJROx4pnz4wv2+nrSpoSjuabTVqXt0Fi3jfyC
         lChWAbCaS3eAKP0cXU7sZS0JbGV2klERxGVbfyrWNkjlnhKVforA8gcOq4LZ6kjWV/IZ
         qyS4iTcZpbfJv1Z5BHB7cOrm/Fqpx7hS8Ak32B7AGjyriwpe17+kqxR8BlhPhEFA1N7f
         5asI8b0kjnXu8pZScn05ASP3K4X31yNbrMDplS1ZR+kXoNcf2h7BQd1tW48io7MsbUFa
         y4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0VhD6TWwJqs+7/MwqgfsHWYoMGA/MgmyVTpHFe9EaI=;
        b=Ncl5dLMezyF7TC2u5tGFTnE9bw7Ecw8dgUA7goBkzyoGiZ+oSYuldJxCiz6ORtNAU+
         4Bw2kC5RPS6AY3VC7LW6SQZdAgHzVMDsQBDAR3nqAQfLMkIpaY4hAnUw0KRyFbVaiD9G
         Kk7/Q1l8xOdOap/kc/tuyx9jUTGsrwUcT+llz2UWdzr8LKkMxTgfxWCwdzesH2v8f7vo
         dGBC2HotNOEawZFOcrmfinLcm+2RNtp4v0/SjcejpyT7g3hUSw2tIKuK6vfKb/ZNW3a4
         D3IHcJuk8soSBeZCV9w4xCpMQLFM+cc2tb3xq5US0WzmFIJFSrO2wM4Ks9TnHAn7suoQ
         DYnw==
X-Gm-Message-State: AO0yUKWnU5VXHE5A0c2HrLfJTHnx51nFjH8HZtsPjVyAub4Nlcuv6L02
        vPLxJ6xt00Uz+MN3NI7dXj4=
X-Google-Smtp-Source: AK7set+bS6MuHR5h08NZKukD2yRpT4F2I/UXrRCHKNAhQ++gJbrsukm5FrI8wOF6Ivhjodb753L7yQ==
X-Received: by 2002:a17:906:af10:b0:8b1:7ae9:647 with SMTP id lx16-20020a170906af1000b008b17ae90647mr567714ejb.76.1679088666948;
        Fri, 17 Mar 2023 14:31:06 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:31:06 -0700 (PDT)
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
Subject: [PATCH v3 20/21] dt-bindings: pinctrl: mediatek: mt7620: split binding
Date:   Sat, 18 Mar 2023 00:30:10 +0300
Message-Id: <20230317213011.13656-21-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7628 and MT7688 SoCs contain different pin muxing information,
therefore, should be split. This can be done now that there are compatible
strings to distinguish them from other SoCs.

Split the schema out to mediatek,mt76x8-pinctrl.yaml.

Remove mediatek,mt76x8-pinctrl from mt7620.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 379 +--------------
 .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 450 ++++++++++++++++++
 2 files changed, 459 insertions(+), 370 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
index 808dd8bd276f..591bc0664ec6 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
@@ -11,15 +11,13 @@ maintainers:
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description: |
-  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
+  MediaTek MT7620 pin controller for MT7620 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
 properties:
   compatible:
-    enum:
-      - ralink,mt7620-pinctrl
-      - ralink,mt76x8-pinctrl
+    const: ralink,mt7620-pinctrl
 
 patternProperties:
   '-pins$':
@@ -37,19 +35,10 @@ patternProperties:
           function:
             description:
               A string containing the name of the function to mux to the group.
-            anyOf:
-              - description: For MT7620 SoC
-                enum: [ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa,
-                       pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf, refclk,
-                       rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite, wdt refclk,
-                       wdt rst, wled]
-
-              - description: For MT7628 and MT7688 SoCs
-                enum: [antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn,
-                       p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
-                       p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1, pwm_uart2,
-                       refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1,
-                       spis, sw_r, uart0, uart1, uart2, utif, wdt, wled_an, wled_kn, -]
+            enum: [ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand,
+                   pa, pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf,
+                   refclk, rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite,
+                   wdt refclk, wdt rst, wled]
 
           groups:
             description:
@@ -61,24 +50,6 @@ patternProperties:
           - function
 
         allOf:
-          - if:
-              properties:
-                function:
-                  const: antenna
-            then:
-              properties:
-                groups:
-                  enum: [i2s]
-
-          - if:
-              properties:
-                function:
-                  const: debug
-            then:
-              properties:
-                groups:
-                  enum: [i2c]
-
           - if:
               properties:
                 function:
@@ -95,17 +66,8 @@ patternProperties:
             then:
               properties:
                 groups:
-                  anyOf:
-                    - description: For MT7620 SoC
-                      enum: [ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2,
-                             spi, spi refclk, uartf, uartlite, wdt, wled]
-
-                    - description: For MT7628 and MT7688 SoCs
-                      enum: [gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an,
-                             p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
-                             p4led_an, p4led_kn, perst, pwm0, pwm1, refclk,
-                             sdmode, spi, spi cs1, spis, uart0, uart1, uart2,
-                             wdt, wled_an, wled_kn]
+                  enum: [ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi,
+                         spi refclk, uartf, uartlite, wdt, wled]
 
           - if:
               properties:
@@ -134,15 +96,6 @@ patternProperties:
                 groups:
                   enum: [i2c]
 
-          - if:
-              properties:
-                function:
-                  const: i2s
-            then:
-              properties:
-                groups:
-                  enum: [i2s]
-
           - if:
               properties:
                 function:
@@ -152,17 +105,6 @@ patternProperties:
                 groups:
                   enum: [uartf]
 
-          - if:
-              properties:
-                function:
-                  const: jtag
-            then:
-              properties:
-                groups:
-                  enum: [p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
-                         p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn,
-                         sdmode]
-
           - if:
               properties:
                 function:
@@ -181,96 +123,6 @@ patternProperties:
                 groups:
                   enum: [nd_sd]
 
-          - if:
-              properties:
-                function:
-                  const: p0led_an
-            then:
-              properties:
-                groups:
-                  enum: [p0led_an]
-
-          - if:
-              properties:
-                function:
-                  const: p0led_kn
-            then:
-              properties:
-                groups:
-                  enum: [p0led_kn]
-
-          - if:
-              properties:
-                function:
-                  const: p1led_an
-            then:
-              properties:
-                groups:
-                  enum: [p1led_an]
-
-          - if:
-              properties:
-                function:
-                  const: p1led_kn
-            then:
-              properties:
-                groups:
-                  enum: [p1led_kn]
-
-          - if:
-              properties:
-                function:
-                  const: p2led_an
-            then:
-              properties:
-                groups:
-                  enum: [p2led_an]
-
-          - if:
-              properties:
-                function:
-                  const: p2led_kn
-            then:
-              properties:
-                groups:
-                  enum: [p2led_kn]
-
-          - if:
-              properties:
-                function:
-                  const: p3led_an
-            then:
-              properties:
-                groups:
-                  enum: [p3led_an]
-
-          - if:
-              properties:
-                function:
-                  const: p3led_kn
-            then:
-              properties:
-                groups:
-                  enum: [p3led_kn]
-
-          - if:
-              properties:
-                function:
-                  const: p4led_an
-            then:
-              properties:
-                groups:
-                  enum: [p4led_an]
-
-          - if:
-              properties:
-                function:
-                  const: p4led_kn
-            then:
-              properties:
-                groups:
-                  enum: [p4led_kn]
-
           - if:
               properties:
                 function:
@@ -280,15 +132,6 @@ patternProperties:
                 groups:
                   enum: [pa]
 
-          - if:
-              properties:
-                function:
-                  const: pcie
-            then:
-              properties:
-                groups:
-                  enum: [gpio]
-
           - if:
               properties:
                 function:
@@ -307,15 +150,6 @@ patternProperties:
                 groups:
                   enum: [pcie]
 
-          - if:
-              properties:
-                function:
-                  const: pcm
-            then:
-              properties:
-                groups:
-                  enum: [i2s]
-
           - if:
               properties:
                 function:
@@ -343,51 +177,6 @@ patternProperties:
                 groups:
                   enum: [uartf]
 
-          - if:
-              properties:
-                function:
-                  const: perst
-            then:
-              properties:
-                groups:
-                  enum: [perst]
-
-          - if:
-              properties:
-                function:
-                  const: pwm
-            then:
-              properties:
-                groups:
-                  enum: [uart1, uart2]
-
-          - if:
-              properties:
-                function:
-                  const: pwm0
-            then:
-              properties:
-                groups:
-                  enum: [pwm0]
-
-          - if:
-              properties:
-                function:
-                  const: pwm1
-            then:
-              properties:
-                groups:
-                  enum: [pwm1]
-
-          - if:
-              properties:
-                function:
-                  const: pwm_uart2
-            then:
-              properties:
-                groups:
-                  enum: [spis]
-
           - if:
               properties:
                 function:
@@ -395,12 +184,7 @@ patternProperties:
             then:
               properties:
                 groups:
-                  anyOf:
-                    - description: For MT7620 SoC
-                      enum: [mdio]
-
-                    - description: For MT7628 and MT7688 SoCs
-                      enum: [gpio, refclk, spi cs1]
+                  enum: [mdio]
 
           - if:
               properties:
@@ -420,15 +204,6 @@ patternProperties:
                 groups:
                   enum: [rgmii2]
 
-          - if:
-              properties:
-                function:
-                  const: rsvd
-            then:
-              properties:
-                groups:
-                  enum: [p0led_an, p0led_kn, wled_an, wled_kn]
-
           - if:
               properties:
                 function:
@@ -438,42 +213,6 @@ patternProperties:
                 groups:
                   enum: [nd_sd]
 
-          - if:
-              properties:
-                function:
-                  const: sdxc
-            then:
-              properties:
-                groups:
-                  enum: [sdmode]
-
-          - if:
-              properties:
-                function:
-                  const: sdxc d5 d4
-            then:
-              properties:
-                groups:
-                  enum: [uart2]
-
-          - if:
-              properties:
-                function:
-                  const: sdxc d6
-            then:
-              properties:
-                groups:
-                  enum: [pwm1]
-
-          - if:
-              properties:
-                function:
-                  const: sdxc d7
-            then:
-              properties:
-                groups:
-                  enum: [pwm0]
-
           - if:
               properties:
                 function:
@@ -483,15 +222,6 @@ patternProperties:
                 groups:
                   enum: [spi]
 
-          - if:
-              properties:
-                function:
-                  const: spi cs1
-            then:
-              properties:
-                groups:
-                  enum: [spi cs1]
-
           - if:
               properties:
                 function:
@@ -501,51 +231,6 @@ patternProperties:
                 groups:
                   enum: [spi refclk]
 
-          - if:
-              properties:
-                function:
-                  const: spis
-            then:
-              properties:
-                groups:
-                  enum: [spis]
-
-          - if:
-              properties:
-                function:
-                  const: sw_r
-            then:
-              properties:
-                groups:
-                  enum: [uart1]
-
-          - if:
-              properties:
-                function:
-                  const: uart0
-            then:
-              properties:
-                groups:
-                  enum: [uart0]
-
-          - if:
-              properties:
-                function:
-                  const: uart1
-            then:
-              properties:
-                groups:
-                  enum: [uart1]
-
-          - if:
-              properties:
-                function:
-                  const: uart2
-            then:
-              properties:
-                groups:
-                  enum: [uart2]
-
           - if:
               properties:
                 function:
@@ -564,25 +249,6 @@ patternProperties:
                 groups:
                   enum: [uartlite]
 
-          - if:
-              properties:
-                function:
-                  const: utif
-            then:
-              properties:
-                groups:
-                  enum: [p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
-                         p3led_kn, p4led_an, p4led_kn, pwm0, pwm1, sdmode, spis]
-
-          - if:
-              properties:
-                function:
-                  const: wdt
-            then:
-              properties:
-                groups:
-                  enum: [wdt]
-
           - if:
               properties:
                 function:
@@ -610,33 +276,6 @@ patternProperties:
                 groups:
                   enum: [wled]
 
-          - if:
-              properties:
-                function:
-                  const: wled_an
-            then:
-              properties:
-                groups:
-                  enum: [wled_an]
-
-          - if:
-              properties:
-                function:
-                  const: wled_kn
-            then:
-              properties:
-                groups:
-                  enum: [wled_kn]
-
-          - if:
-              properties:
-                function:
-                  const: "-"
-            then:
-              properties:
-                groups:
-                  enum: [i2c, spi cs1, uart0]
-
 allOf:
   - $ref: pinctrl.yaml#
 
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
new file mode 100644
index 000000000000..31849dd5940b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
@@ -0,0 +1,450 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt76x8-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT76X8 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  MediaTek MT76X8 pin controller for MT7628 and MT7688 SoCs.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,mt76x8-pinctrl
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
+            enum: [antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn,
+                   p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
+                   p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1,
+                   pwm_uart2, refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7,
+                   spi, spi cs1, spis, sw_r, uart0, uart1, uart2, utif, wdt,
+                   wled_an, wled_kn, -]
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
+                  const: antenna
+            then:
+              properties:
+                groups:
+                  enum: [i2s]
+
+          - if:
+              properties:
+                function:
+                  const: debug
+            then:
+              properties:
+                groups:
+                  enum: [i2c]
+
+          - if:
+              properties:
+                function:
+                  const: gpio
+            then:
+              properties:
+                groups:
+                  enum: [gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn,
+                         p2led_an, p2led_kn, p3led_an, p3led_kn, p4led_an,
+                         p4led_kn, perst, pwm0, pwm1, refclk, sdmode, spi,
+                         spi cs1, spis, uart0, uart1, uart2, wdt, wled_an,
+                         wled_kn]
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
+                  const: i2s
+            then:
+              properties:
+                groups:
+                  enum: [i2s]
+
+          - if:
+              properties:
+                function:
+                  const: jtag
+            then:
+              properties:
+                groups:
+                  enum: [p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
+                         p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn,
+                         sdmode]
+
+          - if:
+              properties:
+                function:
+                  const: p0led_an
+            then:
+              properties:
+                groups:
+                  enum: [p0led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p0led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p0led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p1led_an
+            then:
+              properties:
+                groups:
+                  enum: [p1led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p1led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p1led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p2led_an
+            then:
+              properties:
+                groups:
+                  enum: [p2led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p2led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p2led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p3led_an
+            then:
+              properties:
+                groups:
+                  enum: [p3led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p3led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p3led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: p4led_an
+            then:
+              properties:
+                groups:
+                  enum: [p4led_an]
+
+          - if:
+              properties:
+                function:
+                  const: p4led_kn
+            then:
+              properties:
+                groups:
+                  enum: [p4led_kn]
+
+          - if:
+              properties:
+                function:
+                  const: pcie
+            then:
+              properties:
+                groups:
+                  enum: [gpio]
+
+          - if:
+              properties:
+                function:
+                  const: pcm
+            then:
+              properties:
+                groups:
+                  enum: [i2s]
+
+          - if:
+              properties:
+                function:
+                  const: perst
+            then:
+              properties:
+                groups:
+                  enum: [perst]
+
+          - if:
+              properties:
+                function:
+                  const: pwm
+            then:
+              properties:
+                groups:
+                  enum: [uart1, uart2]
+
+          - if:
+              properties:
+                function:
+                  const: pwm0
+            then:
+              properties:
+                groups:
+                  enum: [pwm0]
+
+          - if:
+              properties:
+                function:
+                  const: pwm1
+            then:
+              properties:
+                groups:
+                  enum: [pwm1]
+
+          - if:
+              properties:
+                function:
+                  const: pwm_uart2
+            then:
+              properties:
+                groups:
+                  enum: [spis]
+
+          - if:
+              properties:
+                function:
+                  const: refclk
+            then:
+              properties:
+                groups:
+                  enum: [gpio, refclk, spi cs1]
+
+          - if:
+              properties:
+                function:
+                  const: rsvd
+            then:
+              properties:
+                groups:
+                  enum: [p0led_an, p0led_kn, wled_an, wled_kn]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc
+            then:
+              properties:
+                groups:
+                  enum: [sdmode]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc d5 d4
+            then:
+              properties:
+                groups:
+                  enum: [uart2]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc d6
+            then:
+              properties:
+                groups:
+                  enum: [pwm1]
+
+          - if:
+              properties:
+                function:
+                  const: sdxc d7
+            then:
+              properties:
+                groups:
+                  enum: [pwm0]
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
+                  const: spi cs1
+            then:
+              properties:
+                groups:
+                  enum: [spi cs1]
+
+          - if:
+              properties:
+                function:
+                  const: spis
+            then:
+              properties:
+                groups:
+                  enum: [spis]
+
+          - if:
+              properties:
+                function:
+                  const: sw_r
+            then:
+              properties:
+                groups:
+                  enum: [uart1]
+
+          - if:
+              properties:
+                function:
+                  const: uart0
+            then:
+              properties:
+                groups:
+                  enum: [uart0]
+
+          - if:
+              properties:
+                function:
+                  const: uart1
+            then:
+              properties:
+                groups:
+                  enum: [uart1]
+
+          - if:
+              properties:
+                function:
+                  const: uart2
+            then:
+              properties:
+                groups:
+                  enum: [uart2]
+
+          - if:
+              properties:
+                function:
+                  const: utif
+            then:
+              properties:
+                groups:
+                  enum: [p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
+                         p3led_kn, p4led_an, p4led_kn, pwm0, pwm1, sdmode, spis]
+
+          - if:
+              properties:
+                function:
+                  const: wdt
+            then:
+              properties:
+                groups:
+                  enum: [wdt]
+
+          - if:
+              properties:
+                function:
+                  const: wled_an
+            then:
+              properties:
+                groups:
+                  enum: [wled_an]
+
+          - if:
+              properties:
+                function:
+                  const: wled_kn
+            then:
+              properties:
+                groups:
+                  enum: [wled_kn]
+
+          - if:
+              properties:
+                function:
+                  const: "-"
+            then:
+              properties:
+                groups:
+                  enum: [i2c, spi cs1, uart0]
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
+      compatible = "ralink,mt76x8-pinctrl";
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

