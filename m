Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319475B7646
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIMQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiIMQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:17:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC06A50D6;
        Tue, 13 Sep 2022 08:13:27 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30F676601AED;
        Tue, 13 Sep 2022 16:12:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663081924;
        bh=zYmprvmiD0Ggudf5RYZlEYhp1RhtGi504V5iOcdPNZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSV9wHK5X9N5e+5GfH4mSj4JfFSR5tk2mUKjfbofPDsKeeciyuiZt+aqIU6v9hcNI
         Nd2v/A6m6OHlxj1eV022YHEVWsARn1VpqOZ18TMGJmvphhyc82odPCJRkZCayzcBYY
         oKzEK25yxW9ZP0thnSgnCgoSN+HU3f47Nt4ZSwNo67J5TzwnR8ZiDWe1qExsBSfnjU
         du+bgpKUIFfO4V99TZ8nGwclaFSbP09HE5ai+VC453KCtaaE/aPQg5Kc1Iif+FfC/n
         X6JyA/+Z+x8m3zF4AmZKBmvn2zdYcFmgHUE6ZQnJaQ/w8cKgZWQkfJ3ag7mlVu6RgX
         IZTnKX8/FBEKg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     joro@8bytes.org
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/3] dt-bindings: mediatek: Add bindings for MT6795 M4U
Date:   Tue, 13 Sep 2022 17:11:46 +0200
Message-Id: <20220913151148.412312-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
References: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iommu/mediatek,iommu.yaml        |  4 +
 include/dt-bindings/memory/mt6795-larb-port.h | 95 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index f5bfe28efa89..a8288691ed87 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -73,6 +73,7 @@ properties:
           - mediatek,mt2701-m4u  # generation one
           - mediatek,mt2712-m4u  # generation two
           - mediatek,mt6779-m4u  # generation two
+          - mediatek,mt6795-m4u  # generation two
           - mediatek,mt8167-m4u  # generation two
           - mediatek,mt8173-m4u  # generation two
           - mediatek,mt8183-m4u  # generation two
@@ -129,6 +130,7 @@ properties:
       dt-binding/memory/mt2701-larb-port.h for mt2701 and mt7623,
       dt-binding/memory/mt2712-larb-port.h for mt2712,
       dt-binding/memory/mt6779-larb-port.h for mt6779,
+      dt-binding/memory/mt6795-larb-port.h for mt6795,
       dt-binding/memory/mt8167-larb-port.h for mt8167,
       dt-binding/memory/mt8173-larb-port.h for mt8173,
       dt-binding/memory/mt8183-larb-port.h for mt8183,
@@ -153,6 +155,7 @@ allOf:
             enum:
               - mediatek,mt2701-m4u
               - mediatek,mt2712-m4u
+              - mediatek,mt6795-m4u
               - mediatek,mt8173-m4u
               - mediatek,mt8186-iommu-mm
               - mediatek,mt8192-m4u
@@ -182,6 +185,7 @@ allOf:
           contains:
             enum:
               - mediatek,mt2712-m4u
+              - mediatek,mt6795-m4u
               - mediatek,mt8173-m4u
 
     then:
diff --git a/include/dt-bindings/memory/mt6795-larb-port.h b/include/dt-bindings/memory/mt6795-larb-port.h
new file mode 100644
index 000000000000..58cf6a6b6372
--- /dev/null
+++ b/include/dt-bindings/memory/mt6795-larb-port.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_MEMORY_MT6795_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT6795_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+#define M4U_LARB4_ID			4
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_OVL1		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_DISP_RDMA2		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_DISP_WDMA1		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_OD_R		MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define M4U_PORT_DISP_OD_W		MTK_M4U_ID(M4U_LARB0_ID, 8)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 9)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 10)
+#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 11)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 12)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB0_ID, 13)
+
+/* larb1 */
+#define M4U_PORT_VDEC_MC		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_VDEC_PP		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_VDEC_UFO		MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_VDEC_VLD		MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_VDEC_VLD2		MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_VDEC_AVC_MV		MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_VDEC_PRED_RD		MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_VDEC_PRED_WR		MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_VDEC_PPWRAP		MTK_M4U_ID(M4U_LARB1_ID, 8)
+
+/* larb2 */
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_CAM_RRZO		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_CAM_LCSO		MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_CAM_IMGO_S		MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_CAM_LSCI_D		MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_CAM_BPCI		MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_CAM_BPCI_D		MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_CAM_UFDI		MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB2_ID, 11)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB2_ID, 12)
+#define M4U_PORT_CAM_IMG3O		MTK_M4U_ID(M4U_LARB2_ID, 13)
+#define M4U_PORT_CAM_VIPI		MTK_M4U_ID(M4U_LARB2_ID, 14)
+#define M4U_PORT_CAM_VIP2I		MTK_M4U_ID(M4U_LARB2_ID, 15)
+#define M4U_PORT_CAM_VIP3I		MTK_M4U_ID(M4U_LARB2_ID, 16)
+#define M4U_PORT_CAM_LCEI		MTK_M4U_ID(M4U_LARB2_ID, 17)
+#define M4U_PORT_CAM_RB			MTK_M4U_ID(M4U_LARB2_ID, 18)
+#define M4U_PORT_CAM_RP			MTK_M4U_ID(M4U_LARB2_ID, 19)
+#define M4U_PORT_CAM_WR			MTK_M4U_ID(M4U_LARB2_ID, 20)
+
+/* larb3 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_REMDC_SDMA		MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_REMDC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_JPGENC_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_JPGENC_SDMA		MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 10)
+#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 11)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 12)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 13)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 14)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 15)
+#define M4U_PORT_REMDC_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 16)
+#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 17)
+#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 18)
+
+/* larb4 */
+#define M4U_PORT_MJC_MV_RD		MTK_M4U_ID(M4U_LARB4_ID, 0)
+#define M4U_PORT_MJC_MV_WR		MTK_M4U_ID(M4U_LARB4_ID, 1)
+#define M4U_PORT_MJC_DMA_RD		MTK_M4U_ID(M4U_LARB4_ID, 2)
+#define M4U_PORT_MJC_DMA_WR		MTK_M4U_ID(M4U_LARB4_ID, 3)
+
+#endif
-- 
2.37.2

