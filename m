Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAB7253E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjFGGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjFGGLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:11:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5E1BC0;
        Tue,  6 Jun 2023 23:11:38 -0700 (PDT)
X-UUID: 25ca0f3a04fa11eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kG4oQaK4Zaxtm+4MwnnkBztaVJAJ0cyCWrff9ZPLH9c=;
        b=BsAHJ8JVCU1VgvRCahvl9liVljAlI60w8ZNoub91cfqULAL5Q29eLz0GaCSkk2NgKemXunXozeGrvoCtbPe/Hku1M4tht76x18we5IyTxQQO5kT0vXoaxdE+odWkBv93I47JkFuifgxOZssgm4FtLfchc/3KLM8rVzNqLLXp8Hg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:817ec412-5e43-4a6f-9781-bdee94024f09,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:28d4d33d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 25ca0f3a04fa11eeb20a276fd37b9834-20230607
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 436065168; Wed, 07 Jun 2023 14:11:31 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 14:11:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 14:11:30 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chein Sung <shawn.sung@mediatek.com>,
        Fei Shao <fshao@google.com>
Subject: [PATCH v1 1/6] dt-bindings: display/mediatek: mt8188: Add documentations for VDOSYS1
Date:   Wed, 7 Jun 2023 14:11:16 +0800
Message-ID: <20230607061121.6732-2-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230607061121.6732-1-shawn.sung@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree documentations for MT8188 VDOSYS1.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,mmsys.yaml |  1 +
 .../display/mediatek/mediatek,ethdr.yaml      |  5 +-
 .../display/mediatek/mediatek,mdp-rdma.yaml   |  5 +-
 .../display/mediatek/mediatek,merge.yaml      |  1 +
 .../display/mediatek/mediatek,padding.yaml    | 80 +++++++++++++++++++
 5 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 536f5a5ebd24..642fa2e4736e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -32,6 +32,7 @@ properties:
               - mediatek,mt8183-mmsys
               - mediatek,mt8186-mmsys
               - mediatek,mt8188-vdosys0
+              - mediatek,mt8188-vdosys1
               - mediatek,mt8192-mmsys
               - mediatek,mt8195-vdosys1
               - mediatek,mt8195-vppsys0
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
index 801fa66ae615..e3f740ab0564 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
@@ -23,7 +23,10 @@ description:

 properties:
   compatible:
-    const: mediatek,mt8195-disp-ethdr
+    oneOf:
+      - enum:
+        - mediatek,mt8188-disp-ethdr
+        - mediatek,mt8195-disp-ethdr

   reg:
     maxItems: 7
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
index dd12e2ff685c..07c345fa9178 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
@@ -21,7 +21,10 @@ description:

 properties:
   compatible:
-    const: mediatek,mt8195-vdo1-rdma
+    oneOf:
+      - enum:
+        - mediatek,mt8188-vdo1-rdma
+        - mediatek,mt8195-vdo1-rdma

   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
index 2f8e2f4dc3b8..600f1b4608f8 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
@@ -23,6 +23,7 @@ properties:
     oneOf:
       - enum:
           - mediatek,mt8173-disp-merge
+          - mediatek,mt8188-disp-merge
           - mediatek,mt8195-disp-merge

   reg:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
new file mode 100644
index 000000000000..8a9e74cbf6dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,padding.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek PADDING
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description:
+  MediaTek PADDING provides ability to VDOSYS1 to fill pixels to
+  width and height of a layer with a specified color.
+  Since MIXER in VDOSYS1 requires the width of a layer to be 2-pixel-align, or
+  4-pixel-align when ETHDR is enabled, we need PADDING to deal with odd width.
+  Please notice that even if the PADDING is in bypass mode,
+  settings in the registers must be cleared to 0, otherwise
+  undeinfed behaviors could happen.
+
+properties:
+  compatible:
+    const: mediatek,mt8188-vdo1-padding
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: RDMA Clock
+
+  mediatek,gce-client-reg:
+    description:
+      The register of display function block to be set by gce. There are 4 arguments,
+      such as gce node, subsys id, offset and register size. The subsys id that is
+      mapping to the register of display function blocks is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h of each chips.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle of GCE
+        - description: GCE subsys id
+        - description: register offset
+        - description: register size
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - clocks
+  - mediatek,gce-client-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8188-clk.h>
+    #include <dt-bindings/power/mt8188-power.h>
+    #include <dt-bindings/gce/mt8188-gce.h>
+    #include <dt-bindings/memory/mt8188-memory-port.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        vdo1_padding0: vdo1_padding0@1c11d000 {
+            compatible = "mediatek,mt8188-vdo1-padding";
+            reg = <0 0x1c11d000 0 0x1000>;
+            clocks = <&vdosys1 CLK_VDO1_PADDING0>;
+            power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+            mediatek,gce-client-reg =
+                <&gce0 SUBSYS_1c11XXXX 0xd000 0x1000>;
+        };
+    };
--
2.18.0

