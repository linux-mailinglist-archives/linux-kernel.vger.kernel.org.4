Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50E6BF418
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCQVbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCQVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC432F066;
        Fri, 17 Mar 2023 14:30:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so25506177edo.2;
        Fri, 17 Mar 2023 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9p6wOBW5PQerq1HTDlv49KWPwyL5YVG4dkYohadujA=;
        b=Y1q8QX8fRYbHlhtBrofBLj8DHlx58qpzQNb2sU660jMYBN0Cvcu2wiBXRKD5v14jDQ
         MoUm3JyBSMR2hueHrlm5SE1/rdc0uv0lGM/vKflFx7Ur7VpNmepcnOoaZV9aEZifZzn3
         VwZAU+zKUBLPUsJplSTaT/hJRbDwRRrXvO6YHcKsHb6UxcczqDtWb6dY1DPkuVq93dHX
         EotKsaotbGWLuGzxPKFwmJGWlL9E8EAQpfGLWEpfpXXdyDk2xBuMY3J3SviRfoZj9VqD
         AqVyCWZ8fg0AblH035+Jiin60j4ZUtLPz85nHU1L1oWQ30kS6CoZsVNftsXd3y7nCfOU
         HrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9p6wOBW5PQerq1HTDlv49KWPwyL5YVG4dkYohadujA=;
        b=7BChCISIDIJ5dN9eXe4JLbkrjGo5fpCQ8ZoJr4Je2OrFB40sFxLNHDJaVnd5t0x+DM
         Tk1ZUcTSrHXcBUhMrdQNw73rUM5VmfWE4L17prbeU6xOS2knQG1iFeM4FoGUCcQwYPDy
         y4ygfYEBB2ZM2k9S8/ue56MevFwj+pyw5xEOewnSY/1Mc8owLhQmf7HcD2D8abJdatZa
         rNbqOCZ2cHQfMCKYUrxaSnEKzLvJimUOElf33r0JPuitLYmbmqsWd+I6lpKBCPfrJUon
         r84+WoTUzZkUkKBb560pPFflrTww6VZrX27pNMVO/9G9OKUSY4raAbCNocOm5b1fuPZ/
         BUog==
X-Gm-Message-State: AO0yUKVJuIKYpKK++YtR6NETAuuTrCat+fJKIyXbLh0lgPbb8sKHsjPT
        o+FM+8AAtpPTvVQM+oAbaDY=
X-Google-Smtp-Source: AK7set+IGDu520sNWxrl5Nt2zELXj95368h87QzdpUDuEjvmJBAAH0mYRZTkmUFEZDIUfOSMgwKOkg==
X-Received: by 2002:a17:907:7f87:b0:925:6bcb:4796 with SMTP id qk7-20020a1709077f8700b009256bcb4796mr951351ejc.38.1679088651611;
        Fri, 17 Mar 2023 14:30:51 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:51 -0700 (PDT)
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
Subject: [PATCH v3 14/21] dt-bindings: pinctrl: mediatek: fix naming inconsistency
Date:   Sat, 18 Mar 2023 00:30:04 +0300
Message-Id: <20230317213011.13656-15-arinc.unal@arinc9.com>
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

Some schemas include "MediaTek", some "Mediatek". Rename all to "MediaTek"
to address the naming inconsistency.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

