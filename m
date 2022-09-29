Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAAD5EF16C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiI2JIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiI2JIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:08:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FF140192;
        Thu, 29 Sep 2022 02:08:38 -0700 (PDT)
X-UUID: effba49215be4613b7b47b790996baa0-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0vYei/7xRQfmCMrRoui2elfcoWBFf2MHbM7z05sG7q4=;
        b=Vq7HvSeb6xSYyUgXdgWk5QM1hv7+4LOLfHZBq3N7e6kgetg163NkcRdJfijbKs2DqFnNDaYfpc8t9n4Z71VHVvSETQx0ilN7kdHRlxD8K3GyCaNl1E7jhBCXxWpgmIK/jGH16sfeE1Vd/YQuqowfpVl+oH8ChAYcgSVFsb8xcas=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:c4f28d30-b31f-4bbd-8f31-b3a7a4bf4535,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:c4f28d30-b31f-4bbd-8f31-b3a7a4bf4535,IP:0,URL
        :25,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:67de6e07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220929170834RWDYXJ0O,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: effba49215be4613b7b47b790996baa0-20220929
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1152069274; Thu, 29 Sep 2022 17:08:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Sep 2022 17:08:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 29 Sep 2022 17:08:29 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [V17,08/15] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
Date:   Thu, 29 Sep 2022 17:08:10 +0800
Message-ID: <20220929090817.24272-9-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929090817.24272-1-irui.wang@mediatek.com>
References: <20220929090817.24272-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: kyrie wu <kyrie.wu@mediatek.com>

Add mediatek,mt8195-jpgdec compatible to binding document.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../media/mediatek,mt8195-jpegdec.yaml        | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
new file mode 100644
index 000000000000..71595c013dbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegdec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek JPEG Decoder
+
+maintainers:
+  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
+
+description:
+  MediaTek JPEG Decoder is the JPEG decode hardware present in MediaTek SoCs
+
+properties:
+  compatible:
+    const: mediatek,mt8195-jpgdec
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 6
+    description:
+      Points to the respective IOMMU block with master port as argument, see
+      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+      Ports are according to the HW.
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
+  "^jpgdec@[0-9a-f]+$":
+    type: object
+    description:
+      The jpeg decoder hardware device node which should be added as subnodes to
+      the main jpeg node.
+
+    properties:
+      compatible:
+        const: mediatek,mt8195-jpgdec-hw
+
+      reg:
+        maxItems: 1
+
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description:
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
+        items:
+          - const: jpgdec
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - iommus
+      - interrupts
+      - clocks
+      - clock-names
+      - power-domains
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - power-domains
+  - iommus
+  - dma-ranges
+  - ranges
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
+        jpgdec-master {
+            compatible = "mediatek,mt8195-jpgdec";
+            power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+            iommus = <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA0>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA0>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            jpgdec@1a040000 {
+                compatible = "mediatek,mt8195-jpgdec-hw";
+                reg = <0 0x1a040000 0 0x10000>;/* JPGDEC_C0 */
+                iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+                interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH 0>;
+                clocks = <&vencsys CLK_VENC_JPGDEC>;
+                clock-names = "jpgdec";
+                power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+            };
+
+            jpgdec@1a050000 {
+                compatible = "mediatek,mt8195-jpgdec-hw";
+                reg = <0 0x1a050000 0 0x10000>;/* JPGDEC_C1 */
+                iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+                         <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+                interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH 0>;
+                clocks = <&vencsys CLK_VENC_JPGDEC_C1>;
+                clock-names = "jpgdec";
+                power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+            };
+
+            jpgdec@1b040000 {
+                compatible = "mediatek,mt8195-jpgdec-hw";
+                reg = <0 0x1b040000 0 0x10000>;/* JPGDEC_C2 */
+                iommus = <&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA0>,
+                         <&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA0>,
+                         <&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA1>,
+                         <&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA1>,
+                         <&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET1>,
+                         <&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET0>;
+                interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH 0>;
+                clocks = <&vencsys_core1 CLK_VENC_CORE1_JPGDEC>;
+                clock-names = "jpgdec";
+                power-domains = <&spm MT8195_POWER_DOMAIN_VDEC2>;
+            };
+        };
+    };
-- 
2.18.0

