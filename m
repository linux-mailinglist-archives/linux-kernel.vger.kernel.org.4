Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9747C6A8E13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCCAbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjCCAas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305C05A6F2;
        Thu,  2 Mar 2023 16:30:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z5so744118ljc.8;
        Thu, 02 Mar 2023 16:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIyRY7TAQ7V6fBVxNRjh5iohVjcgkpwqxbFfnDhQVbI=;
        b=ljzr7TOW63wyzf8b1d3XSpxXJ1uU1SbN3J43WA+QTSiLQJIUV4c530Mlr18PZsABPT
         wZBRCM5JHbPobo6eQ4LTrxH3I+FzGLMWiupxxx43cZCYy9qxVzrhOVETw3l9oau13tgn
         4tbSRCflh1iT1Vk8KD4g/SPoF5KI05zSftssxmZV4PQbUqloqkYKGSAtGCOa1GdkMUlx
         wEKFjEcYJsEMtWajYJ/CbWL7O6CorjRZnzoqxYCx+2dW3xAzODRYvESfS0Loi70cQ6MZ
         x7Ag1UDeZ+3CS0aGA5FDMZpZ2Amv4NJmocL9clDciX9Q/S7/n9Fat9lNv1NZnDKrpOzC
         vHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIyRY7TAQ7V6fBVxNRjh5iohVjcgkpwqxbFfnDhQVbI=;
        b=JzxPhUq6ElonxMy7Y83hLWy2lfa0IXXo3DYtmjeBoOCK7COQF+zRlfl1PdK4dLKEol
         M8fvgUR4yctcu6VkYOP4fHTu9ALMHismkT9wdLtw0+FxgyzYgl1Vg/XAW2gI8TGnuFrE
         TiEKPB0L2LqOgqWbvgloXswLwny/YfkjHKM3IgwLIp0ae3yi9LRaH69VvZFJ+Uw5OVna
         o8caPD9ecvljqveJr13ftWcIAbWV7w5M6ZJ/K4lmIxTAzJKtf6KQ7g3wHJKa3YrAHFFU
         pYb+vA+iOAlkAU8A7m068wDMSbvJ0wuCmHO4e06hwOg2nVQs2VPaO0D/d1PDprvhJtqt
         YDkg==
X-Gm-Message-State: AO0yUKXLAyqtjeABS8thNq8VQsQ0q8dUOmegeXo+j8ZOHCTZ9S/WAN25
        xlvsVBZOwUDwgj/TfMpXCHw=
X-Google-Smtp-Source: AK7set/BEHPxNho/TaooYSWMdsGBRP1obHleYMqILnotARCJIvuhtnGjC7EM9IU9zpYvWtlw25Kpyg==
X-Received: by 2002:a2e:bc06:0:b0:295:c386:35f6 with SMTP id b6-20020a2ebc06000000b00295c38635f6mr5180052ljf.44.1677803427295;
        Thu, 02 Mar 2023 16:30:27 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:26 -0800 (PST)
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
Subject: [PATCH 14/20] dt-bindings: pinctrl: mediatek: fix naming inconsistency
Date:   Fri,  3 Mar 2023 03:28:43 +0300
Message-Id: <20230303002850.51858-15-arinc.unal@arinc9.com>
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

Some schemas include "MediaTek", some "Mediatek". Rename all to "MediaTek"
to address the naming inconsistency.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  | 4 ++--
 .../devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  | 2 +-
 .../devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml  | 4 ++--
 .../devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml  | 2 +-
 .../devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml  | 2 +-
 .../devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  | 2 +-
 .../devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  | 2 +-
 .../devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml  | 4 ++--
 .../devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml  | 4 ++--
 .../devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml  | 4 ++--
 .../devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index a55c8e4ff26e..77b1b52f5799 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt65xx-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT65xx Pin Controller
+title: MediaTek MT65xx Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
 
 description: |+
-  The Mediatek's Pin controller is used to control SoC pins.
+  The MediaTek's MT65xx Pin controller is used to control SoC pins.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index a2141eb0854e..c2fea29fa02f 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt6779-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT6779 Pin Controller
+title: MediaTek MT6779 Pin Controller
 
 maintainers:
   - Andy Teng <andy.teng@mediatek.com>
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
index c5131f053b61..a78df32e6c39 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt6795-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT6795 Pin Controller
+title: MediaTek MT6795 Pin Controller
 
 maintainers:
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
   - Sean Wang <sean.wang@kernel.org>
 
 description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+  The MediaTek's MT6795 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index ac93eb8f01a6..3531b63ca4bf 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7622-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT7622 Pin Controller
+title: MediaTek MT7622 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
index 74c66fbcb2ae..c3373290a8a1 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7981-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT7981 Pin Controller
+title: MediaTek MT7981 Pin Controller
 
 maintainers:
   - Daniel Golle <daniel@makrotopia.org>
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 216b356cd519..71033831d03d 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7986-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT7986 Pin Controller
+title: MediaTek MT7986 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index c30cd0d010dd..3e34b03e11fc 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8183 Pin Controller
+title: MediaTek MT8183 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@kernel.org>
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
index 32d64416eb16..a0519acc92fe 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8186-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8186 Pin Controller
+title: MediaTek MT8186 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
 description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+  The MediaTek's MT8186 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
index e764cb0f8c1a..3c3dd142a989 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8192-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8192 Pin Controller
+title: MediaTek MT8192 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
 description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+  The MediaTek's MT8192 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
index 7b3dfc14eedc..d4d5357cdd1d 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8195-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8195 Pin Controller
+title: MediaTek MT8195 Pin Controller
 
 maintainers:
   - Sean Wang <sean.wang@mediatek.com>
 
 description: |
-  The Mediatek's Pin controller is used to control SoC pins.
+  The MediaTek's MT8195 Pin controller is used to control SoC pins.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 4b96884a1afc..42964dfa9fdb 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8365-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mediatek MT8365 Pin Controller
+title: MediaTek MT8365 Pin Controller
 
 maintainers:
   - Zhiyong Tao <zhiyong.tao@mediatek.com>
-- 
2.37.2

