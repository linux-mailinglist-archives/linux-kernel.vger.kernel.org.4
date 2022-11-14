Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6562788A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiKNJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiKNJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:44 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02DF1A3A2;
        Mon, 14 Nov 2022 01:03:42 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D7972FF808;
        Mon, 14 Nov 2022 09:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PyU/TfI7zG+vFv5AqFpSCNXPLiST9CWSE91HtqUC5QU=;
        b=ALFHtwkDEZnD7s7RXo5XGBYtlV7xf8OA/UzzOLAwjOup3Lso7zhlnRXwQ0gRLSPRMDiwyk
        5VIBEbN4EJ9FqjF1yg5dTQ/PfpMrjY+GRq1dQOhOtvdPucEj6SuwBOzBTpXipmhPGE/Huh
        NZtGVLpnEqIKjqCZS0491w5CIECHeZQTnDg7O+Rkq4KQsQAPkEm3Ue0eDIw372+kX0G+jV
        H5IBVXOg1q7upLRwHhSqXVJoOBE8kxAiJeDFAdpQfXU+O7qesB/H225NJke+gMIMOMc+i6
        KZIG2ZID2RtzqEkB5CJVQuyKR/zXRJ4Wo297+z1IL/N5dVoeQ3AVEbZXVW4JYA==
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
Subject: [PATCH v3 08/17] dt-bindings: mtd: sunxi-nand: Add an example to validate the bindings
Date:   Mon, 14 Nov 2022 10:03:06 +0100
Message-Id: <20221114090315.848208-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-1-miquel.raynal@bootlin.com>
References: <20221114090315.848208-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy-paste an existing DT node to ensure the dt_binding_check target
would catch any unforeseen difference.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../mtd/allwinner,sun4i-a10-nand.yaml         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index 465aa69f0f10..e7ec0c59bca6 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -86,4 +86,27 @@ required:
 
 unevaluatedProperties: false
 
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun6i-rtc.h>
+    #include <dt-bindings/clock/sun8i-a23-a33-ccu.h>
+    #include <dt-bindings/reset/sun8i-a23-a33-ccu.h>
+
+    nand-controller@1c03000 {
+        compatible = "allwinner,sun8i-a23-nand-controller";
+        reg = <0x01c03000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_NAND>, <&ccu CLK_NAND>;
+        clock-names = "ahb", "mod";
+        resets = <&ccu RST_BUS_NAND>;
+        reset-names = "ahb";
+        dmas = <&dma 5>;
+        dma-names = "rxtx";
+        pinctrl-names = "default";
+        pinctrl-0 = <&nand_pins &nand_cs0_pin &nand_rb0_pin>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
 ...
-- 
2.34.1

