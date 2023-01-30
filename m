Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD34680456
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjA3DdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjA3DdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:33:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB913D5B;
        Sun, 29 Jan 2023 19:33:14 -0800 (PST)
X-UUID: d0f265b2a04e11eda06fc9ecc4dadd91-20230130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=S7zFVnLR8eXEvS0Y7l7+sbTIVYZrc5SlkBvc9Y6wViE=;
        b=YhZxEBoNyySQVS/iNrMJM60UwLc2Jdp8T7jSf3Wk3G/EPjQGQY2BewFBW/YkLe1gkZEkZFrinU9wG6kEV8UxMD4evc95nEWtYMwAJjQ2G6rSfzPmlc0WCxsYlk6UNFmYmDpciTF44EhwE9wU69eY0O87nqghpKjPSNfYUBWnZ1Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:89c74771-33d5-4945-b985-f63fbd14af5a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-55
X-CID-META: VersionHash:3ca2d6b,CLOUDID:2733b355-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: d0f265b2a04e11eda06fc9ecc4dadd91-20230130
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1618978660; Mon, 30 Jan 2023 11:33:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 30 Jan 2023 11:33:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 30 Jan 2023 11:33:07 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yunfei.dong@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 1/6] media: dt-bindings: media: mediatek: Rename child node names for decoder
Date:   Mon, 30 Jan 2023 11:33:00 +0800
Message-ID: <20230130033305.31830-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230130033305.31830-1-allen-kh.cheng@mediatek.com>
References: <20230130033305.31830-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
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

In order to make the names of the child nodes more generic, we rename
"vcodec-lat" and "vcodec-core" to "video-codec" for decoder in
patternProperties and example.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../media/mediatek,vcodec-subdev-decoder.yaml | 61 ++-----------------
 1 file changed, 5 insertions(+), 56 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index c4f20acdc1f8..46308cdaacc0 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -91,12 +91,13 @@ properties:
 
 # Required child node:
 patternProperties:
-  '^vcodec-lat@[0-9a-f]+$':
+  '^video-codec@[0-9a-f]+$':
     type: object
 
     properties:
       compatible:
         enum:
+          - mediatek,mtk-vcodec-core
           - mediatek,mtk-vcodec-lat
           - mediatek,mtk-vcodec-lat-soc
 
@@ -145,59 +146,6 @@ patternProperties:
 
     additionalProperties: false
 
-  '^vcodec-core@[0-9a-f]+$':
-    type: object
-
-    properties:
-      compatible:
-        const: mediatek,mtk-vcodec-core
-
-      reg:
-        maxItems: 1
-
-      interrupts:
-        maxItems: 1
-
-      iommus:
-        minItems: 1
-        maxItems: 32
-        description: |
-          List of the hardware port in respective IOMMU block for current Socs.
-          Refer to bindings/iommu/mediatek,iommu.yaml.
-
-      clocks:
-        maxItems: 5
-
-      clock-names:
-        items:
-          - const: sel
-          - const: soc-vdec
-          - const: soc-lat
-          - const: vdec
-          - const: top
-
-      assigned-clocks:
-        maxItems: 1
-
-      assigned-clock-parents:
-        maxItems: 1
-
-      power-domains:
-        maxItems: 1
-
-    required:
-      - compatible
-      - reg
-      - interrupts
-      - iommus
-      - clocks
-      - clock-names
-      - assigned-clocks
-      - assigned-clock-parents
-      - power-domains
-
-    additionalProperties: false
-
 required:
   - compatible
   - reg
@@ -211,6 +159,7 @@ if:
     compatible:
       contains:
         enum:
+          - mediatek,mtk-vcodec-core
           - mediatek,mtk-vcodec-lat
 
 then:
@@ -241,7 +190,7 @@ examples:
             #size-cells = <2>;
             ranges = <0 0 0 0x16000000 0 0x40000>;
             reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
-            vcodec-lat@10000 {
+            video-codec@10000 {
                 compatible = "mediatek,mtk-vcodec-lat";
                 reg = <0 0x10000 0 0x800>;
                 interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -264,7 +213,7 @@ examples:
                 power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
             };
 
-            vcodec-core@25000 {
+            video-codec@25000 {
                 compatible = "mediatek,mtk-vcodec-core";
                 reg = <0 0x25000 0 0x1000>;
                 interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.18.0

