Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298C6BF425
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCQVcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCQVbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8553647835;
        Fri, 17 Mar 2023 14:31:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x13so25489336edd.1;
        Fri, 17 Mar 2023 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRRRjQq3YR+UffmCBrvj5g0GLFd9Ga+6nn8JCLDb/LY=;
        b=gd7/k2Dsv3cvSTMDoIhJiW+kYCEnvSwtq3EhasiCnlb8kdELNv3Yku+pkcoPbQW9Yv
         bWRTaXjlNaFwbdgalWz7ZwT/oqaLrgDVIpBHwAIhN+s5NZRo391aSb4g4X7xbgcELdrH
         oomojyX4lmS8BLqNcCwSHj8BzyaCXGMtFGrCtLFkhGGdwR+COApf2RVlDjLm6Pt9J2YM
         zGUO4GrFy4HvY/1jkaUvct3Mnwg4tHFVl39iy2pQGVjlXi0+xLQSQIxuBuKYncQoVoWV
         whSRoMX3RE7qckKUDUFGAW2hMgSFe3mZIQw27AuaM2Yi8bUbXHIOWLG7EVcBJ4vNaI4Q
         prIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRRRjQq3YR+UffmCBrvj5g0GLFd9Ga+6nn8JCLDb/LY=;
        b=Fb6CRJzzQvUu3pPZadN1wzpsGZjqDy4aLWfodAjU11zN2TSlzUQwbWGzPW797MmXhR
         Ac+4MJ+8KoE3deUp2LpU82+BA1GjWHwVB7LgwO0Up+wwP0K0jlK+4Vo7aRQikQQt6Ltz
         i0yrdeEBdVnaq8f6B7H+YxEtSnWY/XERPWfgvvhL4PASXolLTAUithpMwQfGzaAGNztr
         FTTGnTOEJaGFGRHzBKquzozq1jDX/KilQmc8NV26VFqbOPQbyt9OuatuDGOlChnScbu9
         H1YQgsVqcxUZRkL8CxsPax1yLutFCNetwhKe2SGf3bJQ7VwrVT04NQ4d6ZlFncp9NU1o
         NfYQ==
X-Gm-Message-State: AO0yUKUgaVTnI8vQPTW7RIKNPjojMXCOdbK7Yr82nw0SWlICKs1Ju/BB
        c4HUAdCFzA9CrOiIE1Qw2nU=
X-Google-Smtp-Source: AK7set/wLlTE2egESzRiiLAbGob9reK+bCtPzcpYCbbRURE3vgs3lFuaz+ljmGw5GJFnbMJTZoOQsA==
X-Received: by 2002:a17:906:37d4:b0:922:78e2:7680 with SMTP id o20-20020a17090637d400b0092278e27680mr797923ejc.52.1679088659557;
        Fri, 17 Mar 2023 14:30:59 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:59 -0700 (PDT)
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
Subject: [PATCH v3 17/21] dt-bindings: pinctrl: mediatek: drop quotes from referred schemas
Date:   Sat, 18 Mar 2023 00:30:07 +0300
Message-Id: <20230317213011.13656-18-arinc.unal@arinc9.com>
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

Drop the quotes from the referred schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
index 3b3d59140073..bccff08a5ba3 100644
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
index e5e7143674b5..7f0e2d6cd6d9 100644
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
index c3bf98749fa4..601d86aecdd4 100644
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
index 38dc41c735eb..bd72a326e6e0 100644
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
index 7157500a7f81..31c36689438c 100644
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
index 372a3aefa937..bf67d4672455 100644
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
index eb6a5cdecc6c..69136ddd0bbc 100644
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
index 028146fb173f..e994b0c70dbf 100644
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
index 8cca1ce40f25..c43338cafd61 100644
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
index b8ba260d74cd..33cb71775db9 100644
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
@@ -216,7 +216,7 @@ patternProperties:
           - pinmux
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
-- 
2.37.2

