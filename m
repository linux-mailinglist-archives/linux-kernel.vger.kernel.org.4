Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDF96BF688
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCQXhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCQXgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:36:42 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991665BD9E;
        Fri, 17 Mar 2023 16:36:36 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id i19so3555331ila.10;
        Fri, 17 Mar 2023 16:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679096196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKoy4P5RpcU+zg25GpDCmwXljCst6ANGjCSVJiQJeeE=;
        b=pOjbm1b3dXRKvh76bluUeB21zN73KeOPiqiMxNi+I0CYzIjPgDlPNp1nlOSfBvSrKy
         vz/JJ+TUavIAtlvuLiyQC33GBgDRRYvJ+IlBR+H5bsOD7LmkuBCVGrjV3ifoX7e7JhC5
         PdyZZh28YXv8WMevrUeuJfctxjTGz/cwiXTz5zWi1p3RmSEC3RIBG4LytdzZGlr9Bihq
         PMYg/TTzjkdI70fcN2fmbqc3WqL438m2SL6k2MgtFzXQGWJwecxzqay8+A5O0aW02ngI
         0nVUiaZ6+/oTqjRKs9AL/ea1r6DVcx78FAwFyZducJOoQaBbkSMG50fY5fBScWqGFBcZ
         jfcw==
X-Gm-Message-State: AO0yUKW3FfsQnqD110A6xt2ZNxIlfPyuM+4cJEc0Ba7IZYHU7MS143se
        /sP9rrQ5DHC7s6IGxg59Jw==
X-Google-Smtp-Source: AK7set+CgCl6/tw0+Jm12fkd3AiK2RqCrk65QID25EKCIyxV/RIAtsLK79jYcrRDueMyQG+Q1KmfIA==
X-Received: by 2002:a92:d7ca:0:b0:316:e6e4:570b with SMTP id g10-20020a92d7ca000000b00316e6e4570bmr282783ilq.11.1679096195774;
        Fri, 17 Mar 2023 16:36:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d2-20020a056e020c0200b00310f9a0f8a7sm938905ile.76.2023.03.17.16.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 16:36:35 -0700 (PDT)
Received: (nullmailer pid 3968612 invoked by uid 1000);
        Fri, 17 Mar 2023 23:36:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] dt-bindings: mtd: Drop unneeded quotes
Date:   Fri, 17 Mar 2023 18:36:30 -0500
Message-Id: <20230317233631.3968509-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml     | 2 +-
 .../devicetree/bindings/mtd/arasan,nand-controller.yaml       | 2 +-
 .../devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml          | 2 +-
 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml          | 2 +-
 Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml  | 2 +-
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml      | 2 +-
 Documentation/devicetree/bindings/mtd/mtd-physmap.yaml        | 2 +-
 Documentation/devicetree/bindings/mtd/mxc-nand.yaml           | 2 +-
 Documentation/devicetree/bindings/mtd/nand-chip.yaml          | 2 +-
 Documentation/devicetree/bindings/mtd/nand-controller.yaml    | 2 +-
 .../bindings/mtd/partitions/brcm,bcm4908-partitions.yaml      | 2 +-
 .../bindings/mtd/partitions/linksys,ns-partitions.yaml        | 2 +-
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml         | 2 +-
 Documentation/devicetree/bindings/mtd/renesas-nandc.yaml      | 2 +-
 .../devicetree/bindings/mtd/rockchip,nand-controller.yaml     | 2 +-
 Documentation/devicetree/bindings/mtd/spi-nand.yaml           | 2 +-
 Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml | 2 +-
 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml       | 4 ++--
 Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml    | 4 ++--
 19 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index e7ec0c59bca6..9a88870cd865 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Allwinner A10 NAND Controller
 
 allOf:
-  - $ref: "nand-controller.yaml"
+  - $ref: nand-controller.yaml
 
 maintainers:
   - Chen-Yu Tsai <wens@csie.org>
diff --git a/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
index d028269cdbaa..2fe53cbfbee0 100644
--- a/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Arasan NAND Flash Controller with ONFI 3.1 support
 
 allOf:
-  - $ref: "nand-controller.yaml"
+  - $ref: nand-controller.yaml
 
 maintainers:
   - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
index e552875040e2..f8c0f606f451 100644
--- a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
+++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: PL353 NAND Controller
 
 allOf:
-  - $ref: "nand-controller.yaml"
+  - $ref: nand-controller.yaml
 
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 8487089b6e16..ba086c34626d 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -93,7 +93,7 @@ required:
 unevaluatedProperties: false
 
 allOf:
-  - $ref: "nand-controller.yaml"
+  - $ref: nand-controller.yaml
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
index 8c62c7d3d0cd..cc3def758e00 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Intel LGM SoC NAND Controller
 
 allOf:
-  - $ref: "nand-controller.yaml"
+  - $ref: nand-controller.yaml
 
 maintainers:
   - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 3fe981b14e2c..2bece155699f 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Rob Herring <robh@kernel.org>
 
 allOf:
-  - $ref: "mtd.yaml#"
+  - $ref: mtd.yaml#
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
index 44cd4476d1d3..f8c976898a95 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
@@ -14,7 +14,7 @@ description: |
   file systems on embedded devices.
 
 allOf:
-  - $ref: "mtd.yaml#"
+  - $ref: mtd.yaml#
   - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
index 7f6f7c9596c4..cf4198e43d7f 100644
--- a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 
 allOf:
-  - $ref: "nand-controller.yaml"
+  - $ref: nand-controller.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
index 33d079f76c05..609d4a4ddd80 100644
--- a/Documentation/devicetree/bindings/mtd/nand-chip.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 allOf:
-  - $ref: "mtd.yaml#"
+  - $ref: mtd.yaml#
 
 description: |
   This file covers the generic description of a NAND chip. It implies that the
diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index efcd415f8641..f70a32d2d9d4 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -51,7 +51,7 @@ properties:
 
 patternProperties:
   "^nand@[a-f0-9]$":
-    $ref: "nand-chip.yaml#"
+    $ref: nand-chip.yaml#
 
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
index 5bbb1c01ddee..94f0742b375c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -31,7 +31,7 @@ properties:
 
 patternProperties:
   "^partition@[0-9a-f]+$":
-    $ref: "partition.yaml#"
+    $ref: partition.yaml#
     properties:
       compatible:
         const: brcm,bcm4908-firmware
diff --git a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
index 213858f60375..c5fa78ff7125 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
@@ -32,7 +32,7 @@ properties:
 
 patternProperties:
   "^partition@[0-9a-f]+$":
-    $ref: "partition.yaml#"
+    $ref: partition.yaml#
     properties:
       compatible:
         items:
diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 07024ee45951..00c991ffa6c4 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -46,7 +46,7 @@ patternProperties:
           - 512
 
 allOf:
-  - $ref: "nand-controller.yaml#"
+  - $ref: nand-controller.yaml#
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/mtd/renesas-nandc.yaml b/Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
index f0dc78bb0515..cc6b8274e6a2 100644
--- a/Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 allOf:
-  - $ref: "nand-controller.yaml"
+  - $ref: nand-controller.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
index 566f330851f7..7eb1d0a38565 100644
--- a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Rockchip SoCs NAND FLASH Controller (NFC)
 
 allOf:
-  - $ref: "nand-controller.yaml#"
+  - $ref: nand-controller.yaml#
 
 maintainers:
   - Heiko Stuebner <heiko@sntech.de>
diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
index 4d095e613204..77a8727c7966 100644
--- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 allOf:
-  - $ref: "nand-chip.yaml#"
+  - $ref: nand-chip.yaml#
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
index 19cf1f18b61c..986e85ccebc7 100644
--- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
@@ -45,7 +45,7 @@ patternProperties:
         enum: [1, 4, 8]
 
 allOf:
-  - $ref: "nand-controller.yaml#"
+  - $ref: nand-controller.yaml#
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
index 4ac198814b7a..115682fa81b7 100644
--- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
@@ -63,10 +63,10 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    $ref: "/schemas/mtd/partitions/partition.yaml"
+    $ref: /schemas/mtd/partitions/partition.yaml
 
 allOf:
-  - $ref: "/schemas/memory-controllers/ti,gpmc-child.yaml"
+  - $ref: /schemas/memory-controllers/ti,gpmc-child.yaml
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml
index 8a79ad300216..7d3ace4f5505 100644
--- a/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml
@@ -36,10 +36,10 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    $ref: "/schemas/mtd/partitions/partition.yaml"
+    $ref: /schemas/mtd/partitions/partition.yaml
 
 allOf:
-  - $ref: "/schemas/memory-controllers/ti,gpmc-child.yaml"
+  - $ref: /schemas/memory-controllers/ti,gpmc-child.yaml
 
 required:
   - compatible
-- 
2.39.2

