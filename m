Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D88619DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiKDQrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiKDQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:29 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3B31F88;
        Fri,  4 Nov 2022 09:47:25 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 68F2C4000C;
        Fri,  4 Nov 2022 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GgQ6Sk6Ebll+26wyuvSyP9c28FQcBgUw85oCY9S6Ho=;
        b=nqyaBQwsiE7Sara4ljYb3o7J9WZa6MxhGJrJxr7kUuIPcEjxa/dk6zUl1CBXVXHZnt1iJH
        z+/t4yTAcYINIjiHpInQl+7ThCcVR7/NaKb844OOxVY+2Qs8rxOx41Owfzf+kkBXKSoNm/
        23jL7n1epPMq+jHN0rh0BbLe+g3FPd6UOCP3NG7kDaoZmVTlGX15uGCj6LC2CDLnFoMb8Z
        cQxzUfb1ZDe9STsASlvNF2NTlhoiVsWTtmG37XpUOm2YkFlHWNhEN9ntxeF0n6vx8zRJP+
        tgqimVejd9KoveCtNdB3rNEvfEDEwNX1/p1V5vbdLaD6CbXwhl5kEn+46Y8oQw==
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
Subject: [PATCH v2 02/17] dt-bindings: mtd: Remove useless file about partitions
Date:   Fri,  4 Nov 2022 17:47:03 +0100
Message-Id: <20221104164718.1290859-3-miquel.raynal@bootlin.com>
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

There is already a real partitions.yaml file, so assuming everybody
knows hot to read yaml schema now, this text file is no longer needed,
so drop it.

Depending on the situation, the lines referring to this file are either
dropped or edited to point to mtd.yaml which includes partition{,s}.yaml.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/atmel-nand.txt    |  6 ++--
 .../devicetree/bindings/mtd/ingenic,nand.yaml |  1 -
 .../devicetree/bindings/mtd/lpc32xx-mlc.txt   |  2 +-
 .../devicetree/bindings/mtd/lpc32xx-slc.txt   |  2 +-
 .../devicetree/bindings/mtd/mtk-nand.txt      |  2 +-
 .../devicetree/bindings/mtd/partition.txt     | 33 -------------------
 drivers/mtd/parsers/Kconfig                   |  2 +-
 7 files changed, 6 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/partition.txt

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 3aa297c97ab6..50645828ac20 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -45,10 +45,8 @@ Optional properties:
 - atmel,rb: an integer identifying the native Ready/Busy pin. Only meaningful
 	    on sama5 SoCs.
 
-All generic properties described in
-Documentation/devicetree/bindings/mtd/{common,nand}.txt also apply to the NAND
-device node, and NAND partitions should be defined under the NAND node as
-described in Documentation/devicetree/bindings/mtd/partition.txt.
+All generic properties are described in the generic yaml files under
+Documentation/devicetree/bindings/mtd/.
 
 * ECC engine (PMECC) bindings:
 
diff --git a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
index 8c272c842bfd..87b2944d0d1b 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
@@ -34,7 +34,6 @@ properties:
     type: object
     description:
       Node containing description of fixed partitions.
-      See Documentation/devicetree/bindings/mtd/partition.txt
 
 patternProperties:
   "^nand@[a-f0-9]$":
diff --git a/Documentation/devicetree/bindings/mtd/lpc32xx-mlc.txt b/Documentation/devicetree/bindings/mtd/lpc32xx-mlc.txt
index 6d60bc3063f5..64c06aa05ac7 100644
--- a/Documentation/devicetree/bindings/mtd/lpc32xx-mlc.txt
+++ b/Documentation/devicetree/bindings/mtd/lpc32xx-mlc.txt
@@ -19,7 +19,7 @@ accuracy:)
 - nxp,wr_low: WR_LOW
 
 Optional subnodes:
-- Partitions, see Documentation/devicetree/bindings/mtd/partition.txt
+- Partitions, see Documentation/devicetree/bindings/mtd/mtd.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mtd/lpc32xx-slc.txt b/Documentation/devicetree/bindings/mtd/lpc32xx-slc.txt
index d94edc0fc554..39f17630a301 100644
--- a/Documentation/devicetree/bindings/mtd/lpc32xx-slc.txt
+++ b/Documentation/devicetree/bindings/mtd/lpc32xx-slc.txt
@@ -20,7 +20,7 @@ clock speed:)
 - nxp,rsetup: Read setup time (R_SETUP)
 
 Optional subnodes:
-- Partitions, see Documentation/devicetree/bindings/mtd/partition.txt
+- Partitions, see Documentation/devicetree/bindings/mtd/mtd.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mtd/mtk-nand.txt b/Documentation/devicetree/bindings/mtd/mtk-nand.txt
index 4d3ec5e4ff8a..839ea2f93d04 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-nand.txt
@@ -131,7 +131,7 @@ Example:
 	};
 
 NAND chip optional subnodes:
-- Partitions, see Documentation/devicetree/bindings/mtd/partition.txt
+- Partitions, see Documentation/devicetree/bindings/mtd/mtd.yaml
 
 Example:
 	nand@0 {
diff --git a/Documentation/devicetree/bindings/mtd/partition.txt b/Documentation/devicetree/bindings/mtd/partition.txt
deleted file mode 100644
index ead90e8274d6..000000000000
--- a/Documentation/devicetree/bindings/mtd/partition.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Flash partitions in device tree
-===============================
-
-Flash devices can be partitioned into one or more functional ranges (e.g. "boot
-code", "nvram", "kernel").
-
-Different devices may be partitioned in a different ways. Some may use a fixed
-flash layout set at production time. Some may use on-flash table that describes
-the geometry and naming/purpose of each functional region. It is also possible
-to see these methods mixed.
-
-To assist system software in locating partitions, we allow describing which
-method is used for a given flash device. To describe the method there should be
-a subnode of the flash device that is named 'partitions'. It must have a
-'compatible' property, which is used to identify the method to use.
-
-When a single partition is represented with a DT node (it depends on a used
-format) it may also be described using above rules ('compatible' and optionally
-some extra properties / subnodes). It allows describing more complex,
-hierarchical (multi-level) layouts and should be used if there is some
-significant relation between partitions or some partition internally uses
-another partitioning method.
-
-Available bindings are listed in the "partitions" subdirectory.
-
-
-Deprecated: partitions defined in flash node
-============================================
-
-For backwards compatibility partitions as direct subnodes of the flash device are
-supported. This use is discouraged.
-NOTE: also for backwards compatibility, direct subnodes that have a compatible
-string are not considered partitions, as they may be used for other bindings.
diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index aaa06050c9bc..b53b8bc7c9e6 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -75,7 +75,7 @@ config MTD_OF_PARTS
 	  This provides a open firmware device tree partition parser
 	  which derives the partition map from the children of the
 	  flash memory node, as described in
-	  Documentation/devicetree/bindings/mtd/partition.txt.
+	  Documentation/devicetree/bindings/mtd/mtd.yaml.
 
 config MTD_OF_PARTS_BCM4908
 	bool "BCM4908 partitioning support"
-- 
2.34.1

