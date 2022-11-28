Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34A563AB34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiK1OjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiK1Oiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:38:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1422BC6;
        Mon, 28 Nov 2022 06:38:43 -0800 (PST)
X-UUID: 092a6639ebeb4525b2ec9bba80470fb0-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fXE3ixxnwn9kbAy+LhtuatbP6zj0qagtky4+i+jidZo=;
        b=m11KIfuMnfsG9rLFA7vXoaOlZLuBIU4w2WfvRAgxYD3Bat1WQSHZkmB4hQVdbL3+af9dgl/i0WwS0ZPcYXDV91HTrXYNgAsr1GcEeO1IIwcqe0Jwo2JnFBYalaaA/eIwLRAq618lUzc7riReDjH0oIJOKrHI0YV1zR8buNZAYhY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a7d4b020-c3eb-4032-b172-57ef6f027f47,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:a7d4b020-c3eb-4032-b172-57ef6f027f47,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:2aca7117-81a9-4b5f-95c6-b6b92590fd73,B
        ulkID:22112822383903MH7I3W,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 092a6639ebeb4525b2ec9bba80470fb0-20221128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1094259597; Mon, 28 Nov 2022 22:38:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 22:38:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 28 Nov 2022 22:38:37 +0800
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
Subject: [PATCH v5 1/3] media: dt-bindings: media: mediatek: Rename child node names for decoder
Date:   Mon, 28 Nov 2022 22:38:30 +0800
Message-ID: <20221128143832.25584-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
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
---
 .../media/mediatek,vcodec-subdev-decoder.yaml | 60 ++-----------------
 1 file changed, 4 insertions(+), 56 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index c4f20acdc1f8..695402041e04 100644
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
@@ -241,7 +189,7 @@ examples:
             #size-cells = <2>;
             ranges = <0 0 0 0x16000000 0 0x40000>;
             reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
-            vcodec-lat@10000 {
+            video-codec@10000 {
                 compatible = "mediatek,mtk-vcodec-lat";
                 reg = <0 0x10000 0 0x800>;
                 interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -264,7 +212,7 @@ examples:
                 power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
             };
 
-            vcodec-core@25000 {
+            video-codec@25000 {
                 compatible = "mediatek,mtk-vcodec-core";
                 reg = <0 0x25000 0 0x1000>;
                 interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.18.0

