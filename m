Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CEA6E0BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjDMKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDMKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:47:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629BE4A;
        Thu, 13 Apr 2023 03:47:26 -0700 (PDT)
X-UUID: 8fdbf8eed9e811edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gg5XIv0JoxYh7+Q/MXFr/X6SWUKuH88SYwHbABhmj9Y=;
        b=SvUp+XcAtYKDtvp6YSsytflb2YVFvLuJYu3mCWxDDunScK075N8hvAtEeVE/CZon2nrtRHm2PkTx7/tLLBpM4TpnmpkcVu71L5ALCZFifnhjGpXkHM10PTwuaMSEyVRmItGYJhAUdQhckzfAJHSGfJGi9uKOB8/ZT8HKqjixHj4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:bbb6df5c-2546-4fc0-ba1b-7653372616bf,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:bbb6df5c-2546-4fc0-ba1b-7653372616bf,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:305ed9ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230413184721HQGIUYN1,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 8fdbf8eed9e811edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 755087442; Thu, 13 Apr 2023 18:47:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 18:47:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 18:47:18 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio properties
Date:   Thu, 13 Apr 2023 18:47:13 +0800
Message-ID: <20230413104713.7174-8-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230413104713.7174-1-trevor.wu@mediatek.com>
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign top_a1sys_hp clock to 26M, and add apll1_d4 to clocks for switching
the parent of top_a1sys_hp dynamically
On the other hand, "mediatek,infracfg" is included for bus protection.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../bindings/sound/mediatek,mt8188-afe.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
index 82ccb32f08f2..03301d5082f3 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
@@ -29,6 +29,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of the mediatek topckgen controller
 
+  mediatek,infracfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the mediatek infracfg controller
+
   power-domains:
     maxItems: 1
 
@@ -37,6 +41,7 @@ properties:
       - description: 26M clock
       - description: audio pll1 clock
       - description: audio pll2 clock
+      - description: audio pll1 divide 4
       - description: clock divider for i2si1_mck
       - description: clock divider for i2si2_mck
       - description: clock divider for i2so1_mck
@@ -58,6 +63,7 @@ properties:
       - const: clk26m
       - const: apll1
       - const: apll2
+      - const: apll1_d4
       - const: apll12_div0
       - const: apll12_div1
       - const: apll12_div2
@@ -74,6 +80,12 @@ properties:
       - const: i2si2_m_sel
       - const: adsp_audio_26m
 
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
   mediatek,etdm-in1-cowork-source:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -147,6 +159,8 @@ required:
   - power-domains
   - clocks
   - clock-names
+  - assigned-clocks
+  - assigned-clock-parents
 
 additionalProperties: false
 
@@ -170,6 +184,7 @@ examples:
         clocks = <&clk26m>,
                  <&apmixedsys 9>, //CLK_APMIXED_APLL1
                  <&apmixedsys 10>, //CLK_APMIXED_APLL2
+                 <&topckgen 136>, //CLK_TOP_APLL1_D4
                  <&topckgen 186>, //CLK_TOP_APLL12_CK_DIV0
                  <&topckgen 187>, //CLK_TOP_APLL12_CK_DIV1
                  <&topckgen 188>, //CLK_TOP_APLL12_CK_DIV2
@@ -188,6 +203,7 @@ examples:
         clock-names = "clk26m",
                       "apll1",
                       "apll2",
+                      "apll1_d4",
                       "apll12_div0",
                       "apll12_div1",
                       "apll12_div2",
@@ -203,6 +219,8 @@ examples:
                       "i2si1_m_sel",
                       "i2si2_m_sel",
                       "adsp_audio_26m";
+        assigned-clocks = <&topckgen 83>; //CLK_TOP_A1SYS_HP
+        assigned-clock-parents =  <&clk26m>;
     };
 
 ...
-- 
2.18.0

