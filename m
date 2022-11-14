Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82D627893
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiKNJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiKNJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:52 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281F55A9;
        Mon, 14 Nov 2022 01:03:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D19E8FF804;
        Mon, 14 Nov 2022 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YKZJpyyDpzLpLTerzSJVsOPfYXTPzoZL58epAf0oOA=;
        b=eFlckNu7ReBGeuAQdoMEvTq3NXIMYg49Pxpxyr5KZjIzIQ+7QTHmBzDnhcQ6w4B6vDkCAj
        Ax+3TfBMlmilH+LCZ/00U6xLBlZpEvIzHJ8ZQ9fpujf/wkUEl0DtU4KSByGkzMHet7u7qI
        dwRc/AhFAJdp9IRDRrDL4c3TXuBwSI0Iog5EYzQj1rRZeuVDaPAQTip9ecHKtQdtga43QT
        LypO9OqeNqvMizAmXov7xxBjnEzwjp0it7pej5/8LVyXciMFb5v/zUrkBli27dQJ650uiA
        tzYlMEaU4v3Nrk5+Ue8LRooLhECZtMnjaCePxWwC4YHH9hza5i+QVy7Et4oK8g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 11/17] dt-bindings: mtd: partitions: Constrain the list of parsers
Date:   Mon, 14 Nov 2022 10:03:09 +0100
Message-Id: <20221114090315.848208-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-1-miquel.raynal@bootlin.com>
References: <20221114090315.848208-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parser compatibles cannot be used anywhere, and the list is limited. In
order to constrain this list, enumerate them all under the top
"partitions" subnode. New parsers will have to add their own compatible
here as well.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/mtd.yaml       |  3 +++
 .../mtd/partitions/arm,arm-firmware-suite.yaml       |  2 ++
 .../mtd/partitions/brcm,bcm4908-partitions.yaml      |  2 ++
 .../mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml |  2 ++
 .../mtd/partitions/linksys,ns-partitions.yaml        |  2 ++
 .../bindings/mtd/partitions/partitions.yaml          | 12 ++++++++++--
 .../bindings/mtd/partitions/qcom,smem-part.yaml      |  2 ++
 .../bindings/mtd/partitions/redboot-fis.yaml         |  6 ++++++
 8 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 2fbd0a2ff548..2494ec2d80e3 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -30,6 +30,9 @@ properties:
   partitions:
     $ref: /schemas/mtd/partitions/partitions.yaml
 
+    required:
+      - compatible
+
 patternProperties:
   "@[0-9a-f]+$":
     $ref: partitions/partition.yaml
diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
index 76c88027b6d2..97618847ee35 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
@@ -9,6 +9,8 @@ title: ARM Firmware Suite (AFS) Partitions
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
+select: false
+
 description: |
   The ARM Firmware Suite is a flash partitioning system found on the
   ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
index 7b113e5e3421..5bbb1c01ddee 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -17,6 +17,8 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+select: false
+
 properties:
   compatible:
     const: brcm,bcm4908-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
index 3484e06d6bcb..939e7b50db22 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm947xx-cfe-partitions.yaml
@@ -35,6 +35,8 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+select: false
+
 properties:
   compatible:
     const: brcm,bcm947xx-cfe-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
index 99249cdfbfb3..213858f60375 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linksys,ns-partitions.yaml
@@ -18,6 +18,8 @@ description: |
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
+select: false
+
 properties:
   compatible:
     const: linksys,ns-partitions
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index ff65795de285..9aca4e6c6047 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -13,6 +13,15 @@ description: |
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
+oneOf:
+  - $ref: arm,arm-firmware-suite.yaml
+  - $ref: brcm,bcm4908-partitions.yaml
+  - $ref: brcm,bcm947xx-cfe-partitions.yaml
+  - $ref: fixed-partitions.yaml
+  - $ref: linksys,ns-partitions.yaml
+  - $ref: qcom,smem-part.yaml
+  - $ref: redboot-fis.yaml
+
 properties:
   compatible: true
 
@@ -29,5 +38,4 @@ patternProperties:
 required:
   - compatible
 
-# Temporary value, should be set to false when constraining the parsers list
-additionalProperties: true
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
index dc07909af023..805eabece7c8 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -15,6 +15,8 @@ description: |
   varies between partition table revisions. V3 supports maximum 16 partitions
   and V4 supports 48 partitions.
 
+select: false
+
 properties:
   compatible:
     const: qcom,smem-part
diff --git a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
index fee8d81b5276..ba7445cd69e8 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
@@ -16,6 +16,8 @@ description: The FLASH Image System (FIS) directory is a flash description
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
+select: false
+
 properties:
   compatible:
     const: redboot-fis
@@ -26,6 +28,10 @@ properties:
       device. On a flash memory with 32KB eraseblocks, 0 means the first
       eraseblock at 0x00000000, 1 means the second eraseblock at 0x00008000 and so on.
 
+  '#address-cells': false
+
+  '#size-cells': false
+
 required:
   - compatible
   - fis-index-block
-- 
2.34.1

