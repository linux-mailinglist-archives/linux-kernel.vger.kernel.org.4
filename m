Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7728D6165E0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKBPSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKBPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E6E205DE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:18:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h9so25084649wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD8JTdstVPfn/tUEjX06HES3dCtvTTrPyjIaOvLx60A=;
        b=cc4G6KxfaQokcHNYhyRODdH1eFv6BTOKMuRaQcIv9vK7XoG48SK8Jf1IkkMBNQcomJ
         KaMgtz9nqRLbfGkbCpHXuSA0pGpd7l1q0xaR+Ldvrilil38dLRUqL0rTVz9pFd8pohef
         GUzeQt3y6CEArQkXIL2e78KzuEK1aGVZv8ruCuToJ2I6Jh7Vf5m9QfMGL897pWKzgVGo
         P080kkWWb9+i3quhZYYyxmDWv6nWAfrmQ0wPuIreNEQCD5ZMBoEXSLI8w4mnsvmSTGi0
         e6GjDBVLL75NYHEEHyV5OW1BLI4Cr8BcP9RDgUsQyH6ogsIbRXZEws8hv7do+hGjkd3Z
         ZyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XD8JTdstVPfn/tUEjX06HES3dCtvTTrPyjIaOvLx60A=;
        b=Zw2H88H0Yn5Gk9/+/xzjyG0o4RKthk5Xp4izI0wxH1w1iiHgI9C3sHv54xSxapMHEW
         TeDth8c1RZO21NFcdtkIRxHs9pIk07m55Rh1541wAHZLyaNcdxiARdjYQFuy7KDcDgit
         Dp5ORdgu+UvzTlXt/7LAqT2/6B7gu0wRWxGO0a9iVVoBBjNcMURJSuQGlUEyplUUdNDp
         RTYZmSIs1Scdpi67HeA1YSzEAnJ4ESG0dRDzV4nDuMJIjqh3odEeD0khIYyJzIWJc8JX
         Ao0xZyJJc6VudfB6nHe5ayWlp6/Psbnr7Fa2mt20NYpEhZbSdx3vwKl2EcLGoLBk0X1T
         xj2A==
X-Gm-Message-State: ACrzQf35hHAsrs+GL8xHTKtNgh2JmIR537E/j1v2Kxva5RL7k0SqRHqW
        9sOlNG9Z4IP0dElRmzu3IDDEKA==
X-Google-Smtp-Source: AMsMyM54U8ef+hPMLaNfLq4J54lhNC4U17ZBgk6H0dN4zR8Zb9oU2JOmpOfxTvAVT2qoUHvFUJ43mQ==
X-Received: by 2002:a05:6000:801:b0:236:617f:d962 with SMTP id bt1-20020a056000080100b00236617fd962mr15884621wrb.75.1667402292745;
        Wed, 02 Nov 2022 08:18:12 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id bq13-20020a5d5a0d000000b002365921c9aesm13332818wrb.77.2022.11.02.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:18:12 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 02 Nov 2022 16:18:07 +0100
Subject: [PATCH v6 1/3] dt-bindings: iommu: mediatek: add binding documentation for
 MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v6-1-be4fe8da254b@baylibre.com>
References: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
In-Reply-To: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6368; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=5/uPU5oCsnBuU7Z/wg3JNmSvklPo8fkTK5NWaHQiobk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjYooyBuYKC7CMc3q48r1T+qWWNhdb6+Q47Hp59WyC
 M8Lv8EuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY2KKMgAKCRArRkmdfjHURd7RD/
 4gnKP6mMK1wgnySZx6fAyfIpjbtOMuAnLyYCjtXGMQjnvrgEVoneED6a1x0aAVud8ATbRdpX/dwnq3
 wl9hJG5LUUGebUGkqs4agVaDr1yJ8T4rjk4ffmlrj94Qk/LTvEEu/k/IoBdUrfsQyUl1cyGm91KugU
 Tg99PYFBrmKRSjWtV7xO008WdrW4+/UxZDvVDlxdevfxJud0pFozMOuC0FwNSoh40rxQO8AyAq9+jf
 obGeOVVT6mi0e2SYF+6bBcR650Cq4+EIf1/2kPqNLvmWhaJN4n1rRtmWXIu3m5fnN5dk410sRS7ShB
 yH3i3k6FdSjqZpSAJuGX6ePrbz3amlFpkUKKfiKEZ2IilkqedJO41XClFjce601yfmdyqFVGGFmHou
 AbjjuPfMon707u+4Z+V2sfN2HdktUXA1LvD5W3PWc7AFwvtNWqHIUAIUN5JH4dfrlZaNOHMnPb1ODm
 8TkWKRXBtNbwZzARYXYDEEjopW4/w+arsthWErF6PiMEANf5miX5D2ZfCmAaZ8S3vfONyuHSy4iMdQ
 l/SmqCild6fzzMTDjKpm1sAeOnuoE7Bnkw161ap7RJWW62730BNESCtNM3CeZTo/myOMnivefmqVUy
 h+scmSBxihUEtdJzWry8D/6rRdXt7zLHHBKpMW2zrsbUSlVmJaY7NVKI2S1A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add IOMMU binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
 .../dt-bindings/memory/mediatek,mt8365-larb-port.h | 90 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index fee0241b5098..725434d9d646 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -81,6 +81,7 @@ properties:
           - mediatek,mt8195-iommu-vdo        # generation two
           - mediatek,mt8195-iommu-vpp        # generation two
           - mediatek,mt8195-iommu-infra      # generation two
+          - mediatek,mt8365-m4u  # generation two
 
       - description: mt7623 generation one
         items:
@@ -130,6 +131,7 @@ properties:
       dt-binding/memory/mt8186-memory-port.h for mt8186,
       dt-binding/memory/mt8192-larb-port.h for mt8192.
       dt-binding/memory/mt8195-memory-port.h for mt8195.
+      dt-binding/memory/mediatek,mt8365-larb-port.h for mt8365.
 
   power-domains:
     maxItems: 1
diff --git a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
new file mode 100644
index 000000000000..56d5a5dd519e
--- /dev/null
+++ b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_OVL0_2L		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 8)
+#define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
+#define M4U_PORT_APU_READ		MTK_M4U_ID(M4U_LARB0_ID, 10)
+#define M4U_PORT_APU_WRITE		MTK_M4U_ID(M4U_LARB0_ID, 11)
+
+/* larb1 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_VENC_NBM_RDMA_LITE	MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_JPGENC_Y_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_JPGENC_C_RDMA		MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_JPGENC_Q_TABLE		MTK_M4U_ID(M4U_LARB1_ID, 9)
+#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 10)
+#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(M4U_LARB1_ID, 11)
+#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 12)
+#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(M4U_LARB1_ID, 13)
+#define M4U_PORT_VENC_NBM_WDMA_LITE	MTK_M4U_ID(M4U_LARB1_ID, 14)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 15)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 16)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 17)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 18)
+
+/* larb2 */
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_CAM_RRZO		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_CAM_LCS		MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_CAM_CAM_SV0		MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_CAM_CAM_SV1		MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_CAM_LSCI_D		MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_CAM_AFO		MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_CAM_SPARE		MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_CAM_BPCI		MTK_M4U_ID(M4U_LARB2_ID, 11)
+#define M4U_PORT_CAM_BPCI_D		MTK_M4U_ID(M4U_LARB2_ID, 12)
+#define M4U_PORT_CAM_UFDI		MTK_M4U_ID(M4U_LARB2_ID, 13)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB2_ID, 14)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB2_ID, 15)
+#define M4U_PORT_CAM_IMG3O		MTK_M4U_ID(M4U_LARB2_ID, 16)
+#define M4U_PORT_CAM_WPE0_I		MTK_M4U_ID(M4U_LARB2_ID, 17)
+#define M4U_PORT_CAM_WPE1_I		MTK_M4U_ID(M4U_LARB2_ID, 18)
+#define M4U_PORT_CAM_WPE_O		MTK_M4U_ID(M4U_LARB2_ID, 19)
+#define M4U_PORT_CAM_FD0_I		MTK_M4U_ID(M4U_LARB2_ID, 20)
+#define M4U_PORT_CAM_FD1_I		MTK_M4U_ID(M4U_LARB2_ID, 21)
+#define M4U_PORT_CAM_FD0_O		MTK_M4U_ID(M4U_LARB2_ID, 22)
+#define M4U_PORT_CAM_FD1_O		MTK_M4U_ID(M4U_LARB2_ID, 23)
+
+/* larb3 */
+#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_HW_VDEC_UFO_EXT	MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_HW_VDEC_TILE_EXT	MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_HW_VDEC_VLD2_EXT	MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(M4U_LARB3_ID, 10)
+
+#endif

-- 
b4 0.10.1
