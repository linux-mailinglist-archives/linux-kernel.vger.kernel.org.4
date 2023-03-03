Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE7D6A8EE0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCCBjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCCBi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:38:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD651559D5;
        Thu,  2 Mar 2023 17:38:57 -0800 (PST)
X-UUID: 250dcb4ab96411ed945fc101203acc17-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9DQofAeFrBxPPPvGnYQlYOOSVP8o9jLoEG7CCSLrzSw=;
        b=MSpSyLl4HRXqwxI1IZw9epQMrFY9U7OP8waozNBW0n1HOYX1U0p73YLJTGwCIl7vNvNxHW0lVPIrzzLrsePqZRMQjBX6Wh85KyXgYr72c6xhrUzv9Bp+CNkBAUVWjJV9a7yAwzlrK1WzTY9LYxbijr8vstzeaaUiTp/KBw8B5PA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:5d2a662d-f5b5-40b3-8754-4498fb8b0470,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.20,REQID:5d2a662d-f5b5-40b3-8754-4498fb8b0470,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:25b5999,CLOUDID:b3880db2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230303093850BO85MRVR,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 250dcb4ab96411ed945fc101203acc17-20230303
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1681171590; Fri, 03 Mar 2023 09:38:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 09:38:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 09:38:47 +0800
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
Subject: [RESEND 5/6] media: dt-bindings: media: mediatek: vcodec: Change the max reg value to 2
Date:   Fri, 3 Mar 2023 09:38:41 +0800
Message-ID: <20230303013842.23259-6-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230303013842.23259-1-allen-kh.cheng@mediatek.com>
References: <20230303013842.23259-1-allen-kh.cheng@mediatek.com>
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

From: Yunfei Dong <yunfei.dong@mediatek.com>

Need to add racing control register base in device node for mt8195 support
inner racing mode. Changing the max reg value from 1 to 2.

Adding the description for VDEC_SYS and VDEC_MISC.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bindings/media/mediatek,vcodec-subdev-decoder.yaml      | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index 51c0ff7baa52..cfd13a6b6b68 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -61,7 +61,10 @@ properties:
       - mediatek,mt8195-vcodec-dec
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: VDEC_SYS register space
+      - description: VDEC_RACING_CTRL register space
 
   iommus:
     minItems: 1
@@ -98,6 +101,7 @@ patternProperties:
 
       reg:
         maxItems: 1
+        description: VDEC_MISC register space
 
       interrupts:
         maxItems: 1
-- 
2.18.0

