Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7396FD4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjEJD51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjEJDzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:55:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268E3C27;
        Tue,  9 May 2023 20:55:40 -0700 (PDT)
X-UUID: 8162fbc4eee611ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Vv3Eid5W9dGzETuxCnnJ2VkvQnLPs7amsAJ8mVLEG4c=;
        b=q9gxUitNJsvlc/d8xASM7rgRA3RaoL05BXL7YLSRfIDJ5KsH/Y0+ZmnCfZ0b/1qvuoJNapua2gxObI63fOOq/gOchPeuP97A0dL5kOu6LTsJjnX3SK6gImkJaHm6Gyra4FI7wdklDBF2ULi6L94jDCcCeIs9Wes0aOp8i5eniVk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:cf44fd73-98c6-4bfc-bd1d-d1b1f77193c5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:178d4d4,CLOUDID:a86758c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 8162fbc4eee611ed9cb5633481061a41-20230510
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 794113051; Wed, 10 May 2023 11:55:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 11:55:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 11:55:29 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 8/9] ASoC: dt-bindings: mediatek,mt8188-afe: correct clock name
Date:   Wed, 10 May 2023 11:55:25 +0800
Message-ID: <20230510035526.18137-9-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230510035526.18137-1-trevor.wu@mediatek.com>
References: <20230510035526.18137-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original clock names are different from the list in driver code.
Correct the mismatched binding names in the patch.

Because no mt8188 upstream dts exists, it doesn't affect the existing
dts file.

Fixes: 692d25b67e10 ("ASoC: dt-bindings: mediatek,mt8188-afe: add audio afe document")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../bindings/sound/mediatek,mt8188-afe.yaml   | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
index 82ccb32f08f2..9e877f0d19fb 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
@@ -63,15 +63,15 @@ properties:
       - const: apll12_div2
       - const: apll12_div3
       - const: apll12_div9
-      - const: a1sys_hp_sel
-      - const: aud_intbus_sel
-      - const: audio_h_sel
-      - const: audio_local_bus_sel
-      - const: dptx_m_sel
-      - const: i2so1_m_sel
-      - const: i2so2_m_sel
-      - const: i2si1_m_sel
-      - const: i2si2_m_sel
+      - const: top_a1sys_hp
+      - const: top_aud_intbus
+      - const: top_audio_h
+      - const: top_audio_local_bus
+      - const: top_dptx
+      - const: top_i2so1
+      - const: top_i2so2
+      - const: top_i2si1
+      - const: top_i2si2
       - const: adsp_audio_26m
 
   mediatek,etdm-in1-cowork-source:
@@ -193,15 +193,15 @@ examples:
                       "apll12_div2",
                       "apll12_div3",
                       "apll12_div9",
-                      "a1sys_hp_sel",
-                      "aud_intbus_sel",
-                      "audio_h_sel",
-                      "audio_local_bus_sel",
-                      "dptx_m_sel",
-                      "i2so1_m_sel",
-                      "i2so2_m_sel",
-                      "i2si1_m_sel",
-                      "i2si2_m_sel",
+                      "top_a1sys_hp",
+                      "top_aud_intbus",
+                      "top_audio_h",
+                      "top_audio_local_bus",
+                      "top_dptx",
+                      "top_i2so1",
+                      "top_i2so2",
+                      "top_i2si1",
+                      "top_i2si2",
                       "adsp_audio_26m";
     };
 
-- 
2.18.0

