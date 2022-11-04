Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B9619D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiKDQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKDQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:28 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3131F8C;
        Fri,  4 Nov 2022 09:47:25 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 77FA74000D;
        Fri,  4 Nov 2022 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiQPntzC2ir2r9t3qv3kzKf1NvJ5V3BTdHExODnectk=;
        b=G/ygxGmxnKtQ3TngXx5aoy/hQTBclVESME1UOBdg1JJhAPSb+yPYEKraCOXI+VnAM7axic
        z4kfKTUpF0n3ccGXD2C7whJsL77DyarR0EPLUxybaj3HifBpxIZbbowO2zdcBnrpzhCoTc
        XeKvqV26JRME2feyaNzskFRVSiv/lul0FRmoYJrp9G5D+qMhkiUhgEY2NAgqlQ+P6HktNW
        KeieFzzvrYVHBCIzQZYHCveZvGoH12Qk3Vt1Hk2y/pUa/tFKHU1Q1QArMDz5XmdycgsOsW
        enjYhuSdElXEvh/nOAVP8Tw1gpaS7UBclrnVdfSNXA0/ZTOtpcJe20ThcXSjDQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 04/17] dt-bindings: mtd: nand: Drop common properties already defined in generic files
Date:   Fri,  4 Nov 2022 17:47:05 +0100
Message-Id: <20221104164718.1290859-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic files, so let's drop these properties from the individual NAND
controller bindings when no additional information is provided rather
than the possible presence of the property.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml         |  9 +--------
 .../bindings/mtd/arasan,nand-controller.yaml           |  5 +----
 .../devicetree/bindings/mtd/intel,lgm-ebunand.yaml     | 10 +---------
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml  |  3 ---
 4 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index 4741864da48e..65521924ee1c 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -14,9 +14,6 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 properties:
-  "#address-cells": true
-  "#size-cells": true
-
   compatible:
     enum:
       - allwinner,sun4i-a10-nand
@@ -49,11 +46,7 @@ properties:
   dma-names:
     const: rxtx
 
-  pinctrl-names: true
-
 patternProperties:
-  "^pinctrl-[0-9]+$": true
-
   "^nand@[a-f0-9]+$":
     type: object
     properties:
@@ -91,6 +84,6 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 ...
diff --git a/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
index f013fb976d95..d028269cdbaa 100644
--- a/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
@@ -35,9 +35,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  "#address-cells": true
-  "#size-cells": true
-
 required:
   - compatible
   - reg
@@ -45,7 +42,7 @@ required:
   - clock-names
   - interrupts
 
-additionalProperties: true
+unevaluatedProperties: true
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
index 741c66ee06c3..7c83a328845e 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml
@@ -39,12 +39,6 @@ properties:
       - const: tx
       - const: rx
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 0
-
 patternProperties:
   "^nand@[a-f0-9]+$":
     type: object
@@ -67,10 +61,8 @@ required:
   - clocks
   - dmas
   - dma-names
-  - "#address-cells"
-  - "#size-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 482a2c068740..3cc90c64e974 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -31,9 +31,6 @@ properties:
       - const: core
       - const: aon
 
-  "#address-cells": true
-  "#size-cells": true
-
 patternProperties:
   "^nand@[a-f0-9]$":
     type: object
-- 
2.34.1

