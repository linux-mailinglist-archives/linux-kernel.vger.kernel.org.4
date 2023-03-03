Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65F86A8DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCCAak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCCAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:37 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C65A6EE;
        Thu,  2 Mar 2023 16:30:11 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y14so768067ljq.4;
        Thu, 02 Mar 2023 16:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIiEAPTO8hoNXgl/LxoqTt9NNqmG3B3Oy7Nn4t7CBLM=;
        b=TaU7EXcBXgw/CbfmBEl9ytxLFQPRgTkDzyVbFpjwbLWCgEBwdOl52Ks+nlBHfrqkjZ
         fEvmivMoWjSsuGVQhsLW+ya5OD0RyTjRdEoRZZ0oa6r4CrJFUowHsQ4Kf+mRuUnVJ/ap
         mYBFN1bT/nhAKwa7BxHpgFtd59npVD0ypQlXCMoOLHtiGzsi+phlBKWzuBD/46a9Q8tP
         rXEe51Vdn94E3YUiBxOlFyx/vXLD94TFG96/paRTIEPRt3ovawu2qNoVTu/GaQoONXWq
         k4MaIUvdUpgdURloLjXIAkdWIPyxYWuEdJtzYd79IcQV3RDz0rrsIavGskbhPYl7Rk4c
         k9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIiEAPTO8hoNXgl/LxoqTt9NNqmG3B3Oy7Nn4t7CBLM=;
        b=uO/f0RD2pFyXGEu3RRTj9hA4kPdrkyRAMc3dB0j6RPXPgmmS6/3v9QS7xTpf8WOCxY
         Aqn9mMw5ZdnCRoh1+bKN8yb2Y2vFmYlORBYwlhN2PLho7aXBsfHmNdbbLTNKfbe3JwsW
         ybLgLTYHsHKy6u1WU0nevdRlInvptadMpTBb+y2VpUaKn/bsuXh/P+/m1wz3LjKbe50l
         AwLzGN8YOEzr2jryWcXrl4K19KVv3k/rF8PDOvOGEH0CPQn9J204LYnmpmkn7byrj7BM
         SpB9kgwPb4X/TVDO5hppADP1tcRgMceQE8I9A7jZR+VXEpFPhF3nv4Q2qlaTX+ACAXS1
         jeMA==
X-Gm-Message-State: AO0yUKWX+bdNkx6G4ZwKLldG8qAqaQURqjxgUSOebpFoJdscLLvYzrCd
        U/lRIqvkExftDWhiKuLBOhg=
X-Google-Smtp-Source: AK7set9868oEKPzDAUX1PtsbLKPRyzAb9dwq8fJ9VSnzNhzN8flaCAGO3fiUcBM5qQyp+aOiAqOO/g==
X-Received: by 2002:a05:651c:516:b0:295:d385:88cd with SMTP id o22-20020a05651c051600b00295d38588cdmr3617059ljp.19.1677803408796;
        Thu, 02 Mar 2023 16:30:08 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:08 -0800 (PST)
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
Subject: [PATCH 07/20] dt-bindings: pinctrl: ralink: improve bindings
Date:   Fri,  3 Mar 2023 03:28:36 +0300
Message-Id: <20230303002850.51858-8-arinc.unal@arinc9.com>
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

Move additionalProperties to the top. It's easier to read than after a long
indented section.

Drop the quotes from the referred schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../bindings/pinctrl/ralink,mt7620-pinctrl.yaml          | 9 ++++-----
 .../bindings/pinctrl/ralink,mt7621-pinctrl.yaml          | 9 ++++-----
 .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml          | 9 ++++-----
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml          | 9 ++++-----
 .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml          | 9 ++++-----
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index 1e63ea34146a..cde6de77e228 100644
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
@@ -632,12 +635,8 @@ patternProperties:
                 groups:
                   enum: [i2c, spi cs1, uart0]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
index 1b1d37b981d9..fb8c5459ea93 100644
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
@@ -236,12 +239,8 @@ patternProperties:
                 groups:
                   enum: [wdt]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 7fd0df880a76..e51667316b2e 100644
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
@@ -116,12 +119,8 @@ patternProperties:
                 groups:
                   enum: [pci]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 4d66ca752a30..8b1256af09c3 100644
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
@@ -249,12 +252,8 @@ patternProperties:
                 groups:
                   enum: [spi_cs1]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
index 008d93181aea..adc4f42a175d 100644
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
@@ -236,12 +239,8 @@ patternProperties:
                 groups:
                   enum: [uartlite]
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
-- 
2.37.2

