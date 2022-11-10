Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842A623FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiKJK26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJK2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:28:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0532A178A3;
        Thu, 10 Nov 2022 02:28:52 -0800 (PST)
X-UUID: 9962ac843c3840c989f0afcd23038fb5-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9k9uk4PP+p/ezx83CEQ8H7xrIryZqMyMXaSUInDHGYI=;
        b=dkrlsSzn0dYR4Sy5NY/+P8g6YTsQSXm9OLFHUV3vG7EhaW1e1/nL9Vyk3rQ/zixYGZ3+2at+9mEduT7jA4UeUHkZc49iyfoe+y4AAJo4ml0FlyEJgjL3uVi3B1pNFyn3EWOQq8k9U5XpvzNxds6d8f4aK43gAnXLspp9nTJ6988=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:69b481b4-2c77-474a-8f33-6c1ccccfd625,IP:0,U
        RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-55
X-CID-META: VersionHash:d12e911,CLOUDID:4dbdea50-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9962ac843c3840c989f0afcd23038fb5-20221110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 497916881; Thu, 10 Nov 2022 18:28:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 18:28:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 10 Nov 2022 18:28:41 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,1/3] media: dt-bindings: media: mediatek: vcodec: Fix clock num not correctly
Date:   Thu, 10 Nov 2022 18:28:32 +0800
Message-ID: <20221110102834.8946-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

mt8195 and mt8192 have different clock numbers, can't write 'clocks' and
'clock-names' with const value.

Move 'assigned-clocks' and 'assigned-clock-parents' to parent node.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/mediatek,vcodec-subdev-decoder.yaml | 119 +++++++++++-------
 1 file changed, 72 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index c4f20acdc1f8..794012853834 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -89,23 +89,33 @@ properties:
 
   ranges: true
 
+  clocks:
+    minItems: 1
+    maxItems: 5
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
 # Required child node:
 patternProperties:
-  '^vcodec-lat@[0-9a-f]+$':
+  '^vcodec-lat-soc@[0-9a-f]+$':
     type: object
 
     properties:
       compatible:
         enum:
-          - mediatek,mtk-vcodec-lat
           - mediatek,mtk-vcodec-lat-soc
 
       reg:
         maxItems: 1
 
-      interrupts:
-        maxItems: 1
-
       iommus:
         minItems: 1
         maxItems: 32
@@ -114,22 +124,55 @@ patternProperties:
           Refer to bindings/iommu/mediatek,iommu.yaml.
 
       clocks:
+        minItems: 1
         maxItems: 5
 
       clock-names:
-        items:
-          - const: sel
-          - const: soc-vdec
-          - const: soc-lat
-          - const: vdec
-          - const: top
+        minItems: 1
+        maxItems: 5
 
-      assigned-clocks:
+      power-domains:
         maxItems: 1
 
-      assigned-clock-parents:
+    required:
+      - compatible
+      - reg
+      - iommus
+      - clocks
+      - clock-names
+      - power-domains
+
+    additionalProperties: false
+
+  '^vcodec-lat@[0-9a-f]+$':
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - mediatek,mtk-vcodec-lat
+
+      reg:
+        maxItems: 1
+
+      interrupts:
         maxItems: 1
 
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description: |
+          List of the hardware port in respective IOMMU block for current Socs.
+          Refer to bindings/iommu/mediatek,iommu.yaml.
+
+      clocks:
+        minItems: 1
+        maxItems: 5
+
+      clock-names:
+        minItems: 1
+        maxItems: 5
+
       power-domains:
         maxItems: 1
 
@@ -139,8 +182,6 @@ patternProperties:
       - iommus
       - clocks
       - clock-names
-      - assigned-clocks
-      - assigned-clock-parents
       - power-domains
 
     additionalProperties: false
@@ -166,15 +207,12 @@ patternProperties:
           Refer to bindings/iommu/mediatek,iommu.yaml.
 
       clocks:
+        minItems: 1
         maxItems: 5
 
       clock-names:
-        items:
-          - const: sel
-          - const: soc-vdec
-          - const: soc-lat
-          - const: vdec
-          - const: top
+        minItems: 1
+        maxItems: 5
 
       assigned-clocks:
         maxItems: 1
@@ -188,12 +226,9 @@ patternProperties:
     required:
       - compatible
       - reg
-      - interrupts
       - iommus
       - clocks
       - clock-names
-      - assigned-clocks
-      - assigned-clock-parents
       - power-domains
 
     additionalProperties: false
@@ -205,17 +240,10 @@ required:
   - mediatek,scp
   - dma-ranges
   - ranges
-
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - mediatek,mtk-vcodec-lat
-
-then:
-  required:
-    - interrupts
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-parents
 
 additionalProperties: false
 
@@ -241,6 +269,11 @@ examples:
             #size-cells = <2>;
             ranges = <0 0 0 0x16000000 0 0x40000>;
             reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
+            clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+                <&topckgen CLK_TOP_MAINPLL_D4>;
+            clock-names = "sel", "top";
+            assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+            assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
             vcodec-lat@10000 {
                 compatible = "mediatek,mtk-vcodec-lat";
                 reg = <0 0x10000 0 0x800>;
@@ -253,14 +286,10 @@ examples:
                     <&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
                     <&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
                     <&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
-                clocks = <&topckgen CLK_TOP_VDEC_SEL>,
-                    <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+                clocks = <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
                     <&vdecsys_soc CLK_VDEC_SOC_LAT>,
-                    <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
-                    <&topckgen CLK_TOP_MAINPLL_D4>;
+                    <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
                 clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
-                assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
-                assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
                 power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
             };
 
@@ -279,14 +308,10 @@ examples:
                     <&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
                     <&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
                     <&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
-                clocks = <&topckgen CLK_TOP_VDEC_SEL>,
-                    <&vdecsys CLK_VDEC_VDEC>,
+                clocks = <&vdecsys CLK_VDEC_VDEC>,
                     <&vdecsys CLK_VDEC_LAT>,
-                    <&vdecsys CLK_VDEC_LARB1>,
-                    <&topckgen CLK_TOP_MAINPLL_D4>;
+                    <&vdecsys CLK_VDEC_LARB1>;
                 clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
-                assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
-                assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
                 power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
             };
         };
-- 
2.18.0

