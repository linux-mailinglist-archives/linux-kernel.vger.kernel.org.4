Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC16BF3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCQVbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCQVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0D47835;
        Fri, 17 Mar 2023 14:30:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so25443266edd.5;
        Fri, 17 Mar 2023 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hanRZ+so1ArYmepo5CCKfRMoCoks9bBU/s/2qIAgcfA=;
        b=ROtgY41T1mOUeAcWsz3h2hwpWmqmsiAYvHi8MtcsIKwe9n1jmGo5bS4Ztw1lJ5GSuo
         wt7WpnMJZNM8bht2BbO28u2/ck60OCTwmy1UEQg3ZmsHu74i/fEWwO5RAAcNurb6xgSe
         G3wahpAR4MrUMoEmlwNtW+7KOMdYey9JnJkI2pdILB71svg6WvEom+Ive++MLl2VHwGs
         uyz9CY3+FWgTj4SjLn0jW4WHONkK3X7GhHP1ZcWxHnySP5dIi/kDeg2pt+Ls5Cf+wV62
         +NxAXlkNs370AvC6NdOpayuUruHNaqQHPGpnDXoqtPVUsnYRUX458Vc7M4TBzPFKPiqu
         km4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hanRZ+so1ArYmepo5CCKfRMoCoks9bBU/s/2qIAgcfA=;
        b=uMYaLYaN+RRoLYk0PoF2Kar/AJK2rXiabMzc+D3frWVStDfYvND07rPcUWNTVocsju
         HUaBz0yDYr5nX9c9sc1d2UtGFzQDUZVa9jYBWfUnQWGwmsdaaY+3rFab0INWYfRTWo0G
         4jS8dGmE4tTvRnvMXSeiSTYPtdkpAAIGDrPOJsifHVRgqZskwJy8ClXSAhfDdTrE5YNP
         GhW7PqEMHg57kXRqgRnOs0rizJRTLkNYCyrMV6Kv6kc4+3TGpWFDCdJhqy0+Gu381fMe
         u2xNQgUAbml42CSXaUUqaKUcI31llthEay1HLBQUn9lM6Xdrvs3lHb/TkBS/6fl2WLKl
         Ue0g==
X-Gm-Message-State: AO0yUKWFEgGBPgoZdmJFcTRBITyJu2eM9ttb1jK4fR1fdjRICwqqG8EY
        guiuZA1E+9YXBwVBYx6uUWLL8A1/ZiaYnISJ
X-Google-Smtp-Source: AK7set9DUcJ6esYQL+HblhXNZcVXi9BWwPw82pZ6p5dHNh8f5Q2liYaFJQnTMyg1nF/Hika2gJc5jg==
X-Received: by 2002:aa7:d4d6:0:b0:4ea:a9b0:a511 with SMTP id t22-20020aa7d4d6000000b004eaa9b0a511mr4986552edr.37.1679088631693;
        Fri, 17 Mar 2023 14:30:31 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:31 -0700 (PDT)
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
Subject: [PATCH v3 06/21] dt-bindings: pinctrl: ralink: move additionalProperties to top
Date:   Sat, 18 Mar 2023 00:29:56 +0300
Message-Id: <20230317213011.13656-7-arinc.unal@arinc9.com>
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

Move additionalProperties to the top. It's easier to read than after a long
indented section.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++----
 .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++----
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index 1e63ea34146a..b25e0db77cb3 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -632,10 +635,6 @@ patternProperties:
                 groups:
                   enum: [i2c, spi cs1, uart0]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index 1b1d37b981d9..60f6273930f5 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -236,10 +239,6 @@ patternProperties:
                 groups:
                   enum: [wdt]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 7fd0df880a76..4f3e0af7d18f 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -116,10 +119,6 @@ patternProperties:
                 groups:
                   enum: [pci]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 4d66ca752a30..9e45d851def6 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -23,11 +23,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -249,10 +252,6 @@ patternProperties:
                 groups:
                   enum: [spi_cs1]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index 008d93181aea..4bea19d4ad7b 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -22,11 +22,14 @@ properties:
 patternProperties:
   '-pins$':
     type: object
+    additionalProperties: false
+
     patternProperties:
       '^(.*-)?pinmux$':
         type: object
         description: node for pinctrl.
         $ref: pinmux-node.yaml#
+        additionalProperties: false
 
         properties:
           function:
@@ -236,10 +239,6 @@ patternProperties:
                 groups:
                   enum: [uartlite]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
   - $ref: "pinctrl.yaml#"
 
-- 
2.37.2

