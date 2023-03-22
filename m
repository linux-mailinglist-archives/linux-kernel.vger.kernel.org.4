Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AFA6C528A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCVRfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCVRfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:35:21 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A03D54C8C;
        Wed, 22 Mar 2023 10:35:16 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-17ab3a48158so20201222fac.1;
        Wed, 22 Mar 2023 10:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhAZgSsCmRQH32g945/1WVE6nK7KUMTNQYBc4jaotYA=;
        b=G+IfvrxS5BwP6tsoyk2gxGGslDjRpKmX3i5igE9jbjZFd0gue1RBc6iz4c+LOeA42S
         kgrKpWwrfCIzHKReR0uvoXtEu0+xqjTbAYDhbga9aWXyQMKMPE/H1VcgX0NorxLZTrYD
         dntcN/5BArp+oFbvu8EHponWXfioJE00T6EnsC61RcMZ/N/yE/e3fimBnkAEUGY0NrJp
         pTTUJv8w5YdilLM3RW1Xi8Tkmt2KH/6RT+Qc8mT3P4syDU3oRY9+OYDDukE0Ikeap54N
         XXmrINAm088hrXLL/l2guYKWSD+bl2nM8iXQn2HAKwj0Db5+M21dC19Y5AkfQMdRUlD3
         t1/g==
X-Gm-Message-State: AAQBX9eveuo2P+Tp49X1cyLVif+/7fmDszO83X9yBElH1VR5GJJhfKSQ
        R32mZEYnHoTZSAD4NECmfQ==
X-Google-Smtp-Source: AK7set+M4iXSP+InndXExCJJx+lLTOyyNjKeT0/S7UmBEckCpQGz7BKUcGuKzdFbT9+57wrsAAi/Vg==
X-Received: by 2002:a05:6870:c5a7:b0:179:e07:dbc4 with SMTP id ba39-20020a056870c5a700b001790e07dbc4mr360448oab.48.1679506515161;
        Wed, 22 Mar 2023 10:35:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020a056808210200b00387160bcd46sm2419874oiw.46.2023.03.22.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:35:14 -0700 (PDT)
Received: (nullmailer pid 3971307 invoked by uid 1000);
        Wed, 22 Mar 2023 17:35:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Qin Jian <qinjian@cqplus1.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: Drop unneeded quotes
Date:   Wed, 22 Mar 2023 12:35:07 -0500
Message-Id: <20230322173508.3971182-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reset/amlogic,meson-axg-audio-arb.yaml         | 4 ++--
 .../devicetree/bindings/reset/amlogic,meson-reset.yaml      | 4 ++--
 .../devicetree/bindings/reset/bitmain,bm1880-reset.yaml     | 4 ++--
 .../devicetree/bindings/reset/brcm,bcm6345-reset.yaml       | 4 ++--
 .../devicetree/bindings/reset/brcm,brcmstb-reset.yaml       | 4 ++--
 .../devicetree/bindings/reset/marvell,berlin2-reset.yaml    | 4 ++--
 Documentation/devicetree/bindings/reset/microchip,rst.yaml  | 6 +++---
 .../devicetree/bindings/reset/qca,ar7100-reset.yaml         | 4 ++--
 Documentation/devicetree/bindings/reset/renesas,rst.yaml    | 4 ++--
 Documentation/devicetree/bindings/reset/sunplus,reset.yaml  | 4 ++--
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
index 704a502adc5d..bc1d284785e1 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/amlogic,meson-axg-audio-arb.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/amlogic,meson-axg-audio-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic audio memory arbiter controller
 
diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index 98db2aa74dc8..d3fdee89d4f8 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/amlogic,meson-reset.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/amlogic,meson-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson SoC Reset Controller
 
diff --git a/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml
index f0aca744388c..1f40b654f6a2 100644
--- a/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Manivannan Sadhasivam <mani@kernel.org>
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/bitmain,bm1880-reset.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/bitmain,bm1880-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Bitmain BM1880 SoC Reset Controller
 
diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
index 560cf6522cb8..00150b93fca0 100644
--- a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/brcm,bcm6345-reset.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/brcm,bcm6345-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: BCM6345 reset controller
 
diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
index e00efa88a198..b115b86e2fe6 100644
--- a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/brcm,brcmstb-reset.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/brcm,brcmstb-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Broadcom STB SW_INIT-style reset controller
 
diff --git a/Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml b/Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml
index d71d0f0a13ee..dc86568bfd75 100644
--- a/Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml
@@ -2,8 +2,8 @@
 # Copyright 2015 Antoine Tenart <atenart@kernel.org>
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/marvell,berlin2-reset.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/marvell,berlin2-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Marvell Berlin reset controller
 
diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index 81cd8c837623..f2da0693b05a 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/microchip,rst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip Sparx5 Switch Reset Controller
 
@@ -36,7 +36,7 @@ properties:
     const: 1
 
   cpu-syscon:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: syscon used to access CPU reset
 
 required:
diff --git a/Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml b/Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml
index 9be60e55cd71..47f8525a9b38 100644
--- a/Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml
@@ -2,8 +2,8 @@
 # Copyright 2015 Alban Bedel <albeu@free.fr>
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/qca,ar7100-reset.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/qca,ar7100-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Atheros AR7xxx/AR9XXX reset controller
 
diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.yaml b/Documentation/devicetree/bindings/reset/renesas,rst.yaml
index 0d1b89e2fe9c..e7e487247751 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/renesas,rst.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/renesas,rst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas R-Car and RZ/G Reset Controller
 
diff --git a/Documentation/devicetree/bindings/reset/sunplus,reset.yaml b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
index f24646ba9761..205918ce324c 100644
--- a/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+++ b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) Sunplus Co., Ltd. 2021
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/sunplus,reset.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/sunplus,reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sunplus SoC Reset Controller
 
-- 
2.39.2

