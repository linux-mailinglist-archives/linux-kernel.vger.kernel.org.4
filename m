Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF97066B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjEQLa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjEQLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:30:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1772D5D;
        Wed, 17 May 2023 04:30:53 -0700 (PDT)
X-UUID: 26155172f4a411ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XqVR2v7ZkYxssEYFiD1aCjMmvqT466hEfnZaJrdFhkU=;
        b=qHZ12JHFv1DnOE7JdDHAS5OzFBkVbJUxX0G+9Rh+skFib8o7h5aA+tpysNRk1ahe720Kdq08wHxmYE4TuC/drkJrz7DMTZskPE/zQtNgyk1bVxSN7MYl2OGkp1S9G9WDoxXELFMio+F7oRjen5fEIFMCr6FjmWFcn8RlaH9r4Co=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:cd79d2b8-7113-4f40-99f4-7752a216cfaf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:cd79d2b8-7113-4f40-99f4-7752a216cfaf,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:407825c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230517191537KSX9L8LU,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 26155172f4a411ed9cb5633481061a41-20230517
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1113008477; Wed, 17 May 2023 19:15:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 19:15:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 19:15:36 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 5/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: update properties
Date:   Wed, 17 May 2023 19:15:34 +0800
Message-ID: <20230517111534.32630-6-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230517111534.32630-1-trevor.wu@mediatek.com>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
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

Add compatible string "mediatek,mt8188-nau8825" to support new board
with nau8825 codec.

ADDA_BE is used to connect to mt6359. For the machine, it must be
fixed to the same codec and configured on the machine driver. Remove
ADDA_BE from items of link-name.

Introduce two properties "dai-format" and "mediatek,clk-provider" under
dai-link subnode to configure dai-link parameters via dts.

"codec" property is removed from required property of dai-link subnode.
For co-clock case, it's possible two dai-links should be configured to
the same format, but only one dai-link builds link with codec.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../sound/mediatek,mt8188-mt6359.yaml         | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 6640272b3f4f..05e532b5d50a 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: mediatek,mt8188-mt6359-evb
+    enum:
+      - mediatek,mt8188-mt6359-evb
+      - mediatek,mt8188-nau8825
 
   model:
     $ref: /schemas/types.yaml#/definitions/string
@@ -42,7 +44,6 @@ patternProperties:
           we are going to update parameters in this node.
         items:
           enum:
-            - ADDA_BE
             - DPTX_BE
             - ETDM1_IN_BE
             - ETDM2_IN_BE
@@ -62,11 +63,28 @@ patternProperties:
         required:
           - sound-dai
 
+      dai-format:
+        description: audio format.
+        items:
+          enum:
+            - i2s
+            - right_j
+            - left_j
+            - dsp_a
+            - dsp_b
+
+      mediatek,clk-provider:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Indicates dai-link clock master.
+        items:
+          enum:
+            - cpu
+            - codec
+
     additionalProperties: false
 
     required:
       - link-name
-      - codec
 
 additionalProperties: false
 
@@ -87,7 +105,8 @@ examples:
             "AIN1", "Headset Mic";
         dai-link-0 {
             link-name = "ETDM3_OUT_BE";
-
+            dai-format = "i2s";
+            mediatek,clk-provider = "cpu";
             codec {
                 sound-dai = <&hdmi0>;
             };
-- 
2.18.0

