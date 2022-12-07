Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8DE645397
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLGFvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLGFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:51:24 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4358BD4;
        Tue,  6 Dec 2022 21:51:16 -0800 (PST)
X-UUID: 9e5834df231243558b1907086d41a6ce-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/HG+J5HwyTK0zqSoo+Xr/2QzGdLMJsWykbO9VsHfdA0=;
        b=BDbWnE83Mg+OU37ZVDOpA7QCeDkPUnF4jPeWPoMPLhyprivMQwnXdd8NAUuaWha+brNfBdr1lVZvbQR6xAAAVthKaWdk7Q+H+EVYNe9vIqhzfHRKy7W908j0Lhwp89x85eHlHjllN+YfMrilI9QjsV+d3+iOc7/AG9nZp7YS8j0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:91bed73c-8595-419f-9ed2-98203f72731c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.14,REQID:91bed73c-8595-419f-9ed2-98203f72731c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:dcaaed0,CLOUDID:f82cc616-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:221207135112TCFL9CVT,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9e5834df231243558b1907086d41a6ce-20221207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2101725160; Wed, 07 Dec 2022 13:51:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 13:51:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 13:51:09 +0800
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
Subject: [PATCH v6 1/3] media: dt-bindings: media: mediatek: Rename child node names for decoder
Date:   Wed, 7 Dec 2022 13:51:05 +0800
Message-ID: <20221207055107.11333-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221207055107.11333-1-allen-kh.cheng@mediatek.com>
References: <20221207055107.11333-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
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

In order to make the names of the child nodes more generic, we rename
"vcodec-lat" and "vcodec-core" to "video-codec" for decoder in
patternProperties and example.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

