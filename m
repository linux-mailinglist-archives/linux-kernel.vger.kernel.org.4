Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD86C5299
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCVRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCVRgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:36:09 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D3D5A1AA;
        Wed, 22 Mar 2023 10:35:56 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id f17-20020a9d7b51000000b00697349ab7e7so10774853oto.9;
        Wed, 22 Mar 2023 10:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8pgjNLgTfMWBbJ8AnTbw7pnuGrKkNboaIvf8UVBNTc=;
        b=dSalATgXk2CI28Ukjq0vQJKNrCtdtLV+ch80ttiHMaV0ZdGOrlRJT+jWWJJDH0PAwr
         9aGqwTz7HSTYxb5CMv3ngrqVm+G85EhgYdhj//JHBphdVIhQI8ABtZMfOF9d4Jp9GVNT
         Cv6Lx5I66y4bWIGrIZZL94HqdL2jc1s/+cXkNY3IZYKMFgj2hEglH77whY0aY2Px4iwz
         wkmR+Yfb5+9B/ZVMRfXmRuHSgUz34rE/PaK2tDehDDviITKrqF7ZDvFAmQlLjdXVjvTr
         0Dv3YMHVouLZzLBmGr3fWJsdXhAfaloGk8Nt9mqBRm17T3iizVcBfUj6k/K5ro2R8D4L
         hLfw==
X-Gm-Message-State: AO0yUKW9ox14FvLI8P13yoDxsgskuAqcqkkNGcYwEcTnSaULMeK6DE+x
        6cG+AHMsUdBGNVGAjDCaQg==
X-Google-Smtp-Source: AK7set8rTNt0p0QO6Z1R7F4xwgbwGcsYwzKCKhE8A0gUpCzXX6IigCet2LpUQKbEFE9nwisADJwMcQ==
X-Received: by 2002:a05:6830:1308:b0:68d:416e:3d9d with SMTP id p8-20020a056830130800b0068d416e3d9dmr2117154otq.7.1679506555322;
        Wed, 22 Mar 2023 10:35:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e13-20020a9d63cd000000b0069f9a73a65fsm847319otl.29.2023.03.22.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:35:54 -0700 (PDT)
Received: (nullmailer pid 3972257 invoked by uid 1000);
        Wed, 22 Mar 2023 17:35:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: clock: Drop unneeded quotes
Date:   Wed, 22 Mar 2023 12:35:48 -0500
Message-Id: <20230322173549.3972106-1-robh@kernel.org>
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
 Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml  | 4 ++--
 .../devicetree/bindings/clock/mediatek,apmixedsys.yaml        | 4 ++--
 .../devicetree/bindings/clock/mediatek,topckgen.yaml          | 4 ++--
 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml | 4 ++--
 .../bindings/clock/renesas,rcar-usb2-clock-sel.yaml           | 4 ++--
 .../devicetree/bindings/clock/renesas,rzg2l-cpg.yaml          | 4 ++--
 .../devicetree/bindings/clock/samsung,exynos850-clock.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml | 4 ++--
 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml  | 4 ++--
 .../devicetree/bindings/clock/xlnx,clocking-wizard.yaml       | 4 ++--
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml b/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
index 90eadf6869b2..b5533f81307c 100644
--- a/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
+++ b/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
@@ -81,11 +81,11 @@ properties:
     maxItems: 1
 
   lock-offset:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: Offset to the unlocking register for the oscillator
 
   vco-offset:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: Offset to the VCO register for the oscillator
     deprecated: true
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index dae25dba4ba6..372c1d744bc2 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/mediatek,apmixedsys.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/mediatek,apmixedsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek AP Mixedsys Controller
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 0fdf56414833..6d087ded7437 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/mediatek,topckgen.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/mediatek,topckgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Top Clock Generator Controller
 
diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
index e57bc40d307a..9c3dc6c4fa94 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/renesas,cpg-mssr.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/renesas,cpg-mssr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Clock Pulse Generator / Module Standby and Software Reset
 
diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml b/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml
index 81f09df7147e..c84f29f1810f 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/renesas,rcar-usb2-clock-sel.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/renesas,rcar-usb2-clock-sel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas R-Car USB 2.0 clock selector
 
diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index 487f74cdc749..fe2fba18ae84 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/renesas,rzg2l-cpg.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/renesas,rzg2l-cpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas RZ/{G2L,V2L,V2M} Clock Pulse Generator / Module Standby Mode
 
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 141cf173f87d..7737fbec482c 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -183,7 +183,7 @@ allOf:
             - description: External RTC clock (32768 Hz)
             - description: CMU_HSI bus clock (from CMU_TOP)
             - description: SD card clock (from CMU_TOP)
-            - description: "USB 2.0 DRD clock (from CMU_TOP)"
+            - description: USB 2.0 DRD clock (from CMU_TOP)
 
         clock-names:
           items:
diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
index 785a12797a42..1703e305e6d8 100644
--- a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Unisoc Inc.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: SC9863A Clock Control Unit
 
diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
index 5f747b0471cf..43d2b6c31357 100644
--- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -2,8 +2,8 @@
 # Copyright 2022 Unisoc Inc.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: UMS512 Soc clock controller
 
diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
index 634b7b964606..c1f04830a832 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/clock/xlnx,clocking-wizard.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/clock/xlnx,clocking-wizard.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Xilinx clocking wizard
 
-- 
2.39.2

