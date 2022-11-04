Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2868619DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiKDQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiKDQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:47 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C14AF05;
        Fri,  4 Nov 2022 09:47:37 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D92CB40003;
        Fri,  4 Nov 2022 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4XXOMBEfkOnV0QqjTL56rdfmw5ub9qZ5YqwWMsqScM=;
        b=kACEsRxzfU7VRr3rXIFdBQuRKCNwXA/whF8DcKXCqTUeTFQ3e3W5msdthKkpzSBrUpMRJy
        atsfrvsau1gDCjGTk2uov+YZlkdvqTTfC7h4TPZIVcUCoLrfNqUlSdpgv1uOICC46hF5F8
        LFGy6zX7/NUWmkbNoNdSuwnifcjVD9EPgXSz/s+L0rywdOq6hYPo4v/okslvgXFgR/lQv3
        44rCmB2dQXYaZICplkg4B+NQI91NMz/FHT6Xptkc22toY3dnQl8uvccj3ZIK32v2IposLc
        vEh14j7OYkskKv0xJSMttYiN+qlDl4NQFMp9vnWqexlqBRgG3SugyJq7cLq8xg==
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 15/17] dt-bindings: mtd: Argue in favor of keeping additionalProperties set to true
Date:   Fri,  4 Nov 2022 17:47:16 +0100
Message-Id: <20221104164718.1290859-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most cases we try to avoid it but in some cases this is
needed. Clarify why by adding a small comment.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/mtd.yaml                  | 1 +
 Documentation/devicetree/bindings/mtd/nand-chip.yaml            | 1 +
 Documentation/devicetree/bindings/mtd/nand-controller.yaml      | 1 +
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml | 1 +
 4 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
index 2494ec2d80e3..9ee285b7d162 100644
--- a/Documentation/devicetree/bindings/mtd/mtd.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -60,6 +60,7 @@ patternProperties:
     required:
       - compatible
 
+# This is a generic file other binding inherit from
 additionalProperties: true
 
 examples:
diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
index 8d5d2d3ef56b..6e2dc025d694 100644
--- a/Documentation/devicetree/bindings/mtd/nand-chip.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
@@ -70,4 +70,5 @@ properties:
 required:
   - reg
 
+# This file can be referenced by more specific devices (like spi-nands)
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 3f2a1480e1eb..220aa2c8c0b5 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -129,6 +129,7 @@ required:
   - "#address-cells"
   - "#size-cells"
 
+# This is a generic file other binding inherit from and extend
 additionalProperties: true
 
 examples:
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index f1a02d840b12..8bdec706ba9b 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -60,4 +60,5 @@ then:
     $nodename:
       pattern: '^partition-.*$'
 
+# This is a generic file other binding inherit from and extend
 additionalProperties: true
-- 
2.34.1

