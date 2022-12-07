Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1364539A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLGFv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLGFvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:51:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6B58021;
        Tue,  6 Dec 2022 21:51:22 -0800 (PST)
X-UUID: aa79dd9176624a75a3e3bbf05e4c54d2-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1G5CgmoJNqi0WF3OrbuFaLqD9wd1bS/NEuB81IeqtVY=;
        b=aY2TYQZO47pJZhU3otENs3N4iz2SL2et78Z4N7MdSVodd8B2BuOaMaufARBRf8yF2HIdSa5yquadGWY2HR4BtpEfqPjeSrr7bbAPQ0vTRyTWqiRHLIs6e/ImEe2rMpzSuez6RnwN3BY5xZ6wcHaUk8pvZSTLVpphBtlv87CR/aU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:60f0f88d-9957-4ad1-ad07-42a6495b2a3c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:60f0f88d-9957-4ad1-ad07-42a6495b2a3c,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:dbffdfd1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:221207135113MJWTABTL,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: aa79dd9176624a75a3e3bbf05e4c54d2-20221207
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 541522236; Wed, 07 Dec 2022 13:51:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 13:51:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 13:51:10 +0800
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
Subject: [PATCH v6 2/3] media: dt-bindings: media: mediatek: Remove "dma-ranges" property for decoder
Date:   Wed, 7 Dec 2022 13:51:06 +0800
Message-ID: <20221207055107.11333-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221207055107.11333-1-allen-kh.cheng@mediatek.com>
References: <20221207055107.11333-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Because the decoder nodes already make use of the iommus property to
configure the IOMMU for address translations, having a dma-ranges
property makes no sense.

In fact, after commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for
bus controllers"), having a dma-ranges property causes IOMMU faults.

Remove the dma-ranges property and update the example.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index 46308cdaacc0..7efc70ae4406 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -76,11 +76,6 @@ properties:
       The node of system control processor (SCP), using
       the remoteproc & rpmsg framework.
 
-  dma-ranges:
-    maxItems: 1
-    description: |
-      Describes the physical address space of IOMMU maps to memory.
-
   "#address-cells":
     const: 2
 
@@ -151,7 +146,6 @@ required:
   - reg
   - iommus
   - mediatek,scp
-  - dma-ranges
   - ranges
 
 if:
@@ -185,7 +179,6 @@ examples:
             compatible = "mediatek,mt8192-vcodec-dec";
             mediatek,scp = <&scp>;
             iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
-            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
             #address-cells = <2>;
             #size-cells = <2>;
             ranges = <0 0 0 0x16000000 0 0x40000>;
-- 
2.18.0

