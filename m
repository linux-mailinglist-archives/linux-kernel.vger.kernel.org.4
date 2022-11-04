Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A9619DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiKDQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiKDQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:47:35 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D3E40447;
        Fri,  4 Nov 2022 09:47:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E073440015;
        Fri,  4 Nov 2022 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRDFGN+zRO7AC+X4pkKNuDHyPBAeUFzjW6kshWON1O0=;
        b=j60Y7aIsofHslJoIacsEQGtjo0nM1/27uO6nXcszwdWCIxxEJqr6vUscDjY6J5i63BFMbp
        3TYA5sCjL1oTMDdBzsfPAUtD2+p9NT7B3NI1oIt5d3OAb4lkshrm9GkXERRJ6zZ/Zb0aVd
        1v5PRs78PMysm+O8OacpszphDDASGuBDj4QdkZK8SCVFest8Chw1r7tkFTJfz3/0kTf3Tp
        D9bpQJ7bddiYBX7GnOyyOSn2eGaDGbW/0izcnJfmgFsQAPVYqaf1bWJ49yO75cfCY9Udrr
        H585MAQI250G7MPzZaQfut3GwVsMIYOYQcWENUtZyqRWJGRetiExdP/8PBEMwg==
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
Subject: [PATCH v2 08/17] dt-bindings: mtd: sunxi-nand: Add an example to validate the bindings
Date:   Fri,  4 Nov 2022 17:47:09 +0100
Message-Id: <20221104164718.1290859-9-miquel.raynal@bootlin.com>
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

Copy-paste an existing DT node to ensure the dt_binding_check target
would catch any unforeseen difference.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

