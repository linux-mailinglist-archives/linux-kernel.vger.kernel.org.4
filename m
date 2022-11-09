Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493966224B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKIHfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:35:42 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6AB1AF08;
        Tue,  8 Nov 2022 23:35:37 -0800 (PST)
X-UUID: e6ccc4b1ab0347dd88563f77eb9b12e9-20221109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9k9uk4PP+p/ezx83CEQ8H7xrIryZqMyMXaSUInDHGYI=;
        b=SAcaJ7grows0j199lNHgbQLtWukDIPjB987Z9eC0Bekpv4iY8jicYxD0d8yaY7D9bZ0Y/Hp9fQuFH+AM0w35kXrWh0jGTexCFVrkkw5r2dmmZMy7eoR3hGHIS1ouK8oR9k9kioAPaYWMu8L3guge7BbQtf2wMeSDm41Xeur9PZM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:142ee2fc-1dba-4584-8981-dc99586e8ea9,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:142ee2fc-1dba-4584-8981-dc99586e8ea9,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:75d498fa-5f3f-42f2-9a97-16904f30874b,B
        ulkID:221109153533NP9T1N9V,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e6ccc4b1ab0347dd88563f77eb9b12e9-20221109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1864707884; Wed, 09 Nov 2022 15:35:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 9 Nov 2022 15:35:31 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 9 Nov 2022 15:35:30 +0800
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
Subject: [PATCH 1/3] media: dt-bindings: media: mediatek: vcodec: Fix clock num not correctly
Date:   Wed, 9 Nov 2022 15:35:27 +0800
Message-ID: <20221109073529.26765-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
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

