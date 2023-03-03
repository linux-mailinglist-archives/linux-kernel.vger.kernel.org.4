Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739576A8E25
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCCAbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCCAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:58 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377D58493;
        Thu,  2 Mar 2023 16:30:37 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a32so739236ljr.9;
        Thu, 02 Mar 2023 16:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2nojjkshDZlMK4hU9tYl1P+c5EVo/6poZY9UvogPvM=;
        b=Sl4IZTrjaRWrtPLv+ZDgaBDyKB/JB1SD7/+7fYzDs1PHZk/36hXPimxVcFTpXQfFq6
         SZUg0X+GL2vlQZkM6fnCxAVM5ficYxyyg4vJ2uuf3q2IG2h6xRMaLfU/MU+BxjM/CLnK
         JaQXBiTdditGAWsJNEov82XJXvrYCtDQBsgU4ihQGlb1iCZ2mS6H2NolMHOOpKktff8a
         WpqzGmgBBdKZtQFqi5bMcIJPYRHmRXmop2fibd3jsDT7+T4jE8wCYuJY/1CBNDKt0zZT
         o1itOPytQ+JR/uwRZgw2GGVLBuPw2y9cySKqgfjC6r3WBSA8bB2egW2+u2Tra0C0GkCA
         w7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2nojjkshDZlMK4hU9tYl1P+c5EVo/6poZY9UvogPvM=;
        b=kfVHyWiRDZ+BXuyR8lLFX9l/LiXItmb/rClZhCa4UWf+MAjc9IqqV9Re9eQ4uP8BzG
         OG79pJmnvyE0n5ErVWNPn83VYH0Kk6LfAWIVLDJOBeVzPAVWsb2UmQfB2B90FHXdb5RN
         JiDIuj+YG++XNDW8TiMLB7g8fv3CMkMn4YMLKEEskyjJfWKP/0BO7IbsZWONwgibCmjf
         6/WEJoxmFqiy8aUKd6wSZqNRxZaQgAAW5AtDS8mHBLFKAoH6S+alIEUojvoz216Y/0vA
         XcF1lVeLGIHYVwaIcQu/bR3aI/odj0sYMjHxDDs6ygfvIgrcHa4Ayk0qkO6yowAU8IoC
         ocgg==
X-Gm-Message-State: AO0yUKXVf4RbTg69PkYFK1zuQ79CvkocYjlO1gXp8DErnjoP/udSeJBh
        Bidfd010mECKF8UYHkZM73M=
X-Google-Smtp-Source: AK7set/FNqqGbkfq8g6krbkN5rvlkH9FoN8KAOunoO/JZ5zzFsqjQbDqz4/uTY1dhX5ralrL+phiOg==
X-Received: by 2002:a2e:9c06:0:b0:295:b054:6809 with SMTP id s6-20020a2e9c06000000b00295b0546809mr3545934lji.8.1677803432715;
        Thu, 02 Mar 2023 16:30:32 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:32 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Subject: [PATCH 16/20] dt-bindings: pinctrl: mediatek: drop quotes from referred schemas
Date:   Fri,  3 Mar 2023 03:28:45 +0300
Message-Id: <20230303002850.51858-17-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
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

Drop the quotes from the referred schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml           | 4 ++--
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml           | 4 ++--
 .../bindings/pinctrl/mediatek,mt6795-pinctrl.yaml           | 4 ++--
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml           | 6 +++---
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml           | 6 +++---
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml           | 4 ++--
 .../bindings/pinctrl/mediatek,mt8186-pinctrl.yaml           | 2 +-
 .../bindings/pinctrl/mediatek,mt8188-pinctrl.yaml           | 2 +-
 .../bindings/pinctrl/mediatek,mt8192-pinctrl.yaml           | 4 ++--
 .../bindings/pinctrl/mediatek,mt8195-pinctrl.yaml           | 4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index 3191d08ecf13..66633810f7b8 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -67,7 +67,7 @@ required:
   - "#gpio-cells"
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 patternProperties:
   'pins$':
@@ -83,7 +83,7 @@ patternProperties:
           pins it needs, and how they should be configured, with regard to muxer
           configuration, pullups, drive strength, input enable/disable and input
           schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        $ref: /schemas/pinctrl/pincfg-node.yaml
 
         properties:
           pinmux:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 17046d204087..a795beec56ec 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -58,7 +58,7 @@ required:
   - "#gpio-cells"
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
   - if:
       properties:
         compatible:
@@ -124,7 +124,7 @@ patternProperties:
           pins it needs, and how they should be configured, with regard to muxer
           configuration, pullups, drive strength, input enable/disable and input
           schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        $ref: /schemas/pinctrl/pincfg-node.yaml
 
         properties:
           pinmux:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
index 5bd78e88fea3..52f30ed1a611 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
@@ -82,7 +82,7 @@ patternProperties:
               }
             };
           };
-        $ref: "pinmux-node.yaml"
+        $ref: pinmux-node.yaml
 
         properties:
           pinmux:
@@ -156,7 +156,7 @@ patternProperties:
           - pinmux
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index 740a26e1ede1..f761751251a1 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -43,7 +43,7 @@ properties:
     const: 2
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
@@ -70,7 +70,7 @@ patternProperties:
         additionalProperties: false
         description:
           pinmux configuration nodes.
-        $ref: "/schemas/pinctrl/pinmux-node.yaml"
+        $ref: /schemas/pinctrl/pinmux-node.yaml
         properties:
           function:
             description:
@@ -249,7 +249,7 @@ patternProperties:
         additionalProperties: false
         description:
           pinconf configuration nodes.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        $ref: /schemas/pinctrl/pincfg-node.yaml
 
         properties:
           groups:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 6d7dd19cad4c..46b7228920ed 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -57,7 +57,7 @@ properties:
     const: 2
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
@@ -128,7 +128,7 @@ patternProperties:
           "wf_dbdc"         "wifi"      74, 75, 76, 77, 78, 79, 80, 81, 82, 83,
                                         84, 85
 
-        $ref: "/schemas/pinctrl/pinmux-node.yaml"
+        $ref: /schemas/pinctrl/pinmux-node.yaml
         properties:
           function:
             description:
@@ -261,7 +261,7 @@ patternProperties:
         additionalProperties: false
         description:
           pinconf configuration nodes.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        $ref: /schemas/pinctrl/pincfg-node.yaml
 
         properties:
           pins:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index 3b1be7949e8c..cc10a9850af5 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -57,7 +57,7 @@ properties:
     const: 2
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
@@ -80,7 +80,7 @@ patternProperties:
           pins it needs, and how they should be configured, with regard to muxer
           configuration, pullups, drive strength, input enable/disable and input
           schmitt.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        $ref: /schemas/pinctrl/pincfg-node.yaml
 
         properties:
           pinmux:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
index c7abc13a167d..90998f78bd07 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
@@ -94,7 +94,7 @@ patternProperties:
               }
             };
           };
-        $ref: "pinmux-node.yaml"
+        $ref: pinmux-node.yaml
 
         properties:
           pinmux:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
index 51b3d1247614..7f3828df2273 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
@@ -74,7 +74,7 @@ patternProperties:
     patternProperties:
       '^pins':
         type: object
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        $ref: /schemas/pinctrl/pincfg-node.yaml
         additionalProperties: false
         description:
           A pinctrl node should contain at least one subnode representing the
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
index 88a466769938..8aaf29dd7e1e 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
@@ -65,7 +65,7 @@ patternProperties:
           pins it needs, and how they should be configured, with regard to muxer
           configuration, pullups, drive strength, input enable/disable and input
           schmitt.
-        $ref: "pinmux-node.yaml"
+        $ref: pinmux-node.yaml
 
         properties:
           pinmux:
@@ -126,7 +126,7 @@ patternProperties:
         additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
index c1c8c99ba139..bf25b8773cee 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
@@ -87,7 +87,7 @@ patternProperties:
               }
             };
           };
-        $ref: "pinmux-node.yaml"
+        $ref: pinmux-node.yaml
 
         properties:
           pinmux:
@@ -217,7 +217,7 @@ patternProperties:
           - pinmux
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
-- 
2.37.2

