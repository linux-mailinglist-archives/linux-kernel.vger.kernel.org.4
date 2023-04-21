Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CBA6EA7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjDUKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDUKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:09:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC79EE4;
        Fri, 21 Apr 2023 03:09:12 -0700 (PDT)
X-UUID: 8e301da0e02c11edb6b9f13eb10bd0fe-20230421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4/XAwCB7RYfwLn3KM/ff3HebXoCyXF6+AnRXC40z1tg=;
        b=Io6IzqT8Un7Rb19L5hnnMNPWw7mxCuc3L1wnz8ZQ/doqrnyVXtXDMj4BmmbfzGuZQUjR5xYooh3mM1/qg+sAI0zGqiDJg/M9o8WxeTek5JgsE6mK6PRCousUCIZJ4zFJOSVSJw1IvLxVuSGQEmSVLykRWANbUza31WQlRHu5ZBk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:9356a11d-32db-4930-bfbb-03b68650cf88,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:441817a2-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 8e301da0e02c11edb6b9f13eb10bd0fe-20230421
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1084427410; Fri, 21 Apr 2023 18:09:08 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 21 Apr 2023 18:09:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 21 Apr 2023 18:09:08 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio properties
Date:   Fri, 21 Apr 2023 18:09:05 +0800
Message-ID: <20230421100905.28045-8-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230421100905.28045-1-trevor.wu@mediatek.com>
References: <20230421100905.28045-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/sound/mediatek,mt8188-afe.yaml      | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
index 82ccb32f08f2..812e0702ca36 100644
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
 
@@ -52,6 +56,7 @@ properties:
       - description: mux for i2si1_mck
       - description: mux for i2si2_mck
       - description: audio 26m clock
+      - description: audio pll1 divide 4
 
   clock-names:
     items:
@@ -73,6 +78,7 @@ properties:
       - const: i2si1_m_sel
       - const: i2si2_m_sel
       - const: adsp_audio_26m
+      - const: apll1_d4
 
   mediatek,etdm-in1-cowork-source:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -147,6 +153,8 @@ required:
   - power-domains
   - clocks
   - clock-names
+  - assigned-clocks
+  - assigned-clock-parents
 
 additionalProperties: false
 
@@ -184,7 +192,8 @@ examples:
                  <&topckgen 78>, //CLK_TOP_I2SO2
                  <&topckgen 79>, //CLK_TOP_I2SI1
                  <&topckgen 80>, //CLK_TOP_I2SI2
-                 <&adsp_audio26m 0>; //CLK_AUDIODSP_AUDIO26M
+                 <&adsp_audio26m 0>, //CLK_AUDIODSP_AUDIO26M
+                 <&topckgen 136>; //CLK_TOP_APLL1_D4
         clock-names = "clk26m",
                       "apll1",
                       "apll2",
@@ -202,7 +211,10 @@ examples:
                       "i2so2_m_sel",
                       "i2si1_m_sel",
                       "i2si2_m_sel",
-                      "adsp_audio_26m";
+                      "adsp_audio_26m",
+                      "apll1_d4";
+        assigned-clocks = <&topckgen 83>; //CLK_TOP_A1SYS_HP
+        assigned-clock-parents =  <&clk26m>;
     };
 
 ...
-- 
2.18.0

