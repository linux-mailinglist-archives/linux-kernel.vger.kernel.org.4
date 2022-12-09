Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F00B647DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLIGoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLIGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:44:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF1A941BB;
        Thu,  8 Dec 2022 22:44:20 -0800 (PST)
X-UUID: eb894b8fba2045b49573c0165c30a366-20221209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=d1GDowZFHehwCGTuyFuI4huVFHOriEhMR24XBfSvdpk=;
        b=UWzwv0P41hlPrPEZ1107TYs1toUcq9K7vf8Zeh4NXnSFgA36H5+4YERNkCqP2vQE0WRcDEMG4oxdvZBqDcRGT4m1nrLUEt45flNc2cmyEvMfMo6TzlfW3MYPcQEBPQiamBtlqwG+Rs8BswLYKxSUweI3rzBG8QkK1UpjFGY6eo4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:7b3fb0d7-934a-4393-ab57-f5fa03d7649c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.14,REQID:7b3fb0d7-934a-4393-ab57-f5fa03d7649c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:dcaaed0,CLOUDID:845ec624-4387-4253-a41d-4f6f2296b154,B
        ulkID:2212081430262R31UJUY,BulkQuantity:7,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: eb894b8fba2045b49573c0165c30a366-20221209
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1987654912; Fri, 09 Dec 2022 14:44:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Dec 2022 14:44:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 9 Dec 2022 14:44:10 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/9] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
Date:   Fri, 9 Dec 2022 14:43:12 +0800
Message-ID: <20221209064317.2828-5-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
References: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings documentation of SPI NAND controller
for MediaTek MT7986 SoC platform. And add optional
nfi_hclk property which is needed for MT7986.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 51 +++++++++++++++----
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
index 6e6e02c91780..bab23f1b11fd 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
@@ -18,14 +18,12 @@ description: |
   using the accompanying ECC engine. There should be only one spi
   slave device following generic spi bindings.
 
-allOf:
-  - $ref: /schemas/spi/spi-controller.yaml#
-
 properties:
   compatible:
     enum:
       - mediatek,mt7622-snand
       - mediatek,mt7629-snand
+      - mediatek,mt7986-snand
 
   reg:
     items:
@@ -36,14 +34,12 @@ properties:
       - description: NFI interrupt
 
   clocks:
-    items:
-      - description: clock used for the controller
-      - description: clock used for the SPI bus
+    minItems: 2
+    maxItems: 3
 
   clock-names:
-    items:
-      - const: nfi_clk
-      - const: pad_clk
+    minItems: 2
+    maxItems: 3
 
   nand-ecc-engine:
     description: device-tree node of the accompanying ECC engine.
@@ -57,6 +53,43 @@ required:
   - clock-names
   - nand-ecc-engine
 
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt7622-snand
+            - mediatek,mt7629-snand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: clock used for the controller
+            - description: clock used for the SPI bus
+        clock-names:
+          items:
+            - const: nfi_clk
+            - const: pad_clk
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt7986-snand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: clock used for the controller
+            - description: clock used for the SPI bus
+            - description: clock used for the AHB bus
+        clock-names:
+          items:
+            - const: nfi_clk
+            - const: pad_clk
+            - const: nfi_hclk
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

