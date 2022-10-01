Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18B5F198C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiJAD0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiJADZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:25:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F71F80A2;
        Fri, 30 Sep 2022 20:17:49 -0700 (PDT)
X-UUID: 80f56eadce3b4ba19370e56a9f848434-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3NxniVY0kLSVgBJbuv5v98YNltI4Zo9r6UkH/bKrbJk=;
        b=GNKaPHiyMhX8bDN448Fmgmyq4ThTh3EDCcUTif4GK35mQ2P/B2Q3jKq0TNvfcWn/7RfeLY37STgtpKg82Tu/Vqg1fNzrj6Hu/zTAyFSj9f81MvsAlNG8eqKTLr/eFItFjtr1chQ5gRL9Um/okDpaVrnm2pfQPgpTa1LgbQx35wg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:27de0494-0bf4-4456-983a-defcf79a9769,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:27de0494-0bf4-4456-983a-defcf79a9769,IP:0,URL
        :25,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:3eaba107-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:2210011117469BOHLU59,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:n
        il,COL:0
X-UUID: 80f56eadce3b4ba19370e56a9f848434-20221001
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1050102750; Sat, 01 Oct 2022 11:17:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:17:42 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:17:41 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6, 1/8] dt-bindings: media: mediatek: vcodec: Adds encoder cores dt-bindings for mt8195
Date:   Sat, 1 Oct 2022 11:17:30 +0800
Message-ID: <20221001031737.18266-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221001031737.18266-1-irui.wang@mediatek.com>
References: <20221001031737.18266-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8195 has two H264 encoder hardware, which are named core0 and core1.
The two encoder cores are independent, we can just enable one core to
do encoding or enable both of them to achieve higher performance. We
pick core0 as main device and core1 as its subdevice, it just a way to
to manage the two encoder hardware, because they are two equal encoder
hardware with the same function.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../media/mediatek,vcodec-encoder-core.yaml   | 217 ++++++++++++++++++
 .../media/mediatek,vcodec-encoder.yaml        |   1 -
 2 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
new file mode 100644
index 000000000000..1dda7d7908da
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
@@ -0,0 +1,217 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek Video Encoder Accelerator With Multi Core
+
+maintainers:
+  - Irui Wang <irui.wang@mediatek.com>
+
+description: |
+  MediaTek Video Encoder is the video encoder hardware present in MediaTek
+  SoCs which supports high resolution encoding functionalities. To meet higher
+  encoder performance, there will be one or more encoder hardware inside SoC,
+  which named core0, core1, etc.. For example, mt8195 has two encoder hardware,
+  the two encoder cores block diagram, can check below.
+  --------------------------------------------------------------
+  Input frame  0     1     2     3     4     5     6
+               |     |     |     |     |     |     |
+               v     |     v     |     v     |     v
+           +-------+ | +-------+ | +-------+ | +-------+
+           | core0 | | | core0 | | | core0 | | | core0 |
+           +-------+ | +-------+ | +-------+ | +-------+
+               |     |     |     |     |     |     |
+               |     v     |     v     |     v     |
+               | +-------+ | +-------+ | +-------+ |
+               | | core1 | | | core1 | | | core1 | |
+               | +-------+ | +-------+ | +-------+ |
+               |     |     |     |     |     |     |
+               v     v     v     v     v     v     v    <parent>
+  --------------------------------------------------------------
+                            core || index               <child>
+                                 \/
+       +--------------------------------------------------+
+       |                     core0/core1                  |
+       |             enable/disable power/clk/irq         |
+       +--------------------------------------------------+
+  --------------------------------------------------------------
+  As above, there are two cores child devices, they are two encoder hardware
+  which can encode input frames in order. When start encoding, input frame 0
+  will be encoded by core0, and input frame 1 can be encoded by core1 even if
+  frame 0 has not been encoded done yet, after frame 0 encoded done, frame 2
+  will be encoded by core0, even input frames are encoded by core0 and odd
+  input frames are encoded by core1, these two encoder cores encode ench input
+  frames in this overlapping manner.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8195-vcodec-enc
+
+  reg:
+    maxItems: 1
+
+  mediatek,scp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      The node of system control processor (SCP), using
+      the remoteproc & rpmsg framework.
+
+  iommus:
+    minItems: 1
+    maxItems: 32
+    description: |
+      List of the hardware port in respective IOMMU block for current Socs.
+      Refer to bindings/iommu/mediatek,iommu.yaml.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  dma-ranges:
+    maxItems: 1
+    description: |
+      Describes the physical address space of IOMMU maps to memory.
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+# Required child node:
+patternProperties:
+  "^venc-core@[0-9a-f]+$":
+    type: object
+    description: |
+      The video encoder core device node which should be added as subnodes to
+      the main venc node, it represents a encoder hardware.
+
+    properties:
+      compatible:
+        const: mediatek,mtk-venc-hw
+
+      reg:
+        maxItems: 1
+
+      mediatek,hw-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Current encoder core id. We use it to pick which one encoder core
+          will be used to encoding current input frame.
+
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description: |
+          List of the hardware port in respective IOMMU block for current Socs.
+          Refer to bindings/iommu/mediatek,iommu.yaml.
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - mediatek,hw-id
+      - iommus
+      - interrupts
+      - clocks
+      - clock-names
+      - assigned-clocks
+      - assigned-clock-parents
+      - power-domains
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - mediatek,scp
+  - iommus
+  - interrupts
+  - clocks
+  - clock-names
+  - dma-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt8195-memory-port.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        venc: venc@1a020000 {
+            compatible = "mediatek,mt8195-vcodec-enc";
+            reg = <0 0x1a020000 0 0x10000>;
+            mediatek,scp = <&scp>;
+            iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_REC>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
+                     <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
+            interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
+            clocks = <&vencsys CLK_VENC_VENC>;
+            clock-names = "clk_venc";
+            power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            venc-core@1b020000 {
+                compatible = "mediatek,mtk-venc-hw";
+                reg = <0 0x1b020000 0 0x10000>;
+                mediatek,hw-id = <1>;
+                iommus = <&iommu_vpp M4U_PORT_L20_VENC_RCPU>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_REC>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_BSDMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_SV_COMV>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_RD_COMV>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_CUR_LUMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_CUR_CHROMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_REF_LUMA>,
+                         <&iommu_vpp M4U_PORT_L20_VENC_REF_CHROMA>;
+                interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH 0>;
+                clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>;
+                clock-names = "clk_venc_core1";
+                assigned-clocks = <&topckgen CLK_TOP_VENC>;
+                assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+                power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index 32aee09aea33..f5f79efe3ba3 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -22,7 +22,6 @@ properties:
       - mediatek,mt8183-vcodec-enc
       - mediatek,mt8188-vcodec-enc
       - mediatek,mt8192-vcodec-enc
-      - mediatek,mt8195-vcodec-enc
 
   reg:
     maxItems: 1
-- 
2.18.0

