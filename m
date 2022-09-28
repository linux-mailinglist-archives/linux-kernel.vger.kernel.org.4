Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF05ED910
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiI1Jdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiI1JdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:33:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B74C631;
        Wed, 28 Sep 2022 02:33:17 -0700 (PDT)
X-UUID: 8f0e5a844bdb4487a6dfce6c2b12adc8-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Hz88Syoy+G8j4J0n1mFi4xfGKZ7lBu4ZQMbzCmNOGoU=;
        b=E1UINXMhZcgFFdWD6aVLrOr4nLqFoUMAWN51n4A8iUCQoKsZe1wr355eRnWmN4dD/b97wJcVmzJk65s9AiuQ5SSMNwUr9DwnD4T6wZ8fd3CSQC0UFgyov7BBwwn+ydm+85dnS3/h74qYbnAHTZnj+jNgL/7ya8su9S0USJyNiCY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:0c46e4e6-3be7-4257-aa3c-591a8a2e3c0d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:0c46e4e6-3be7-4257-aa3c-591a8a2e3c0d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:6beb82e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220928173313NR18UKQ7,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:n
        il,COL:0
X-UUID: 8f0e5a844bdb4487a6dfce6c2b12adc8-20220928
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1131965432; Wed, 28 Sep 2022 17:33:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 28 Sep 2022 17:33:10 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Sep 2022 17:33:08 +0800
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
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>
Subject: [V16,02/15] mtk-jpegenc: export jpeg encoder functions
Date:   Wed, 28 Sep 2022 17:32:45 +0800
Message-ID: <20220928093258.32384-3-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928093258.32384-1-irui.wang@mediatek.com>
References: <20220928093258.32384-1-irui.wang@mediatek.com>
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

From: kyrie wu <kyrie.wu@mediatek.com>

mtk jpeg encoder is built as a module, export some functions to make them
visible by other modules.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 1cf037bf72dd..368f512ea86e 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -36,12 +36,14 @@ void mtk_jpeg_enc_reset(void __iomem *base)
 	writel(JPEG_ENC_RESET_BIT, base + JPEG_ENC_RSTB);
 	writel(0, base + JPEG_ENC_CODEC_SEL);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_enc_reset);
 
 u32 mtk_jpeg_enc_get_file_size(void __iomem *base)
 {
 	return readl(base + JPEG_ENC_DMA_ADDR0) -
 	       readl(base + JPEG_ENC_DST_ADDR0);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_enc_get_file_size);
 
 void mtk_jpeg_enc_start(void __iomem *base)
 {
@@ -51,6 +53,7 @@ void mtk_jpeg_enc_start(void __iomem *base)
 	value |= JPEG_ENC_CTRL_INT_EN_BIT | JPEG_ENC_CTRL_ENABLE_BIT;
 	writel(value, base + JPEG_ENC_CTRL);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_enc_start);
 
 void mtk_jpeg_set_enc_src(struct mtk_jpeg_ctx *ctx,  void __iomem *base,
 			  struct vb2_buffer *src_buf)
@@ -67,6 +70,7 @@ void mtk_jpeg_set_enc_src(struct mtk_jpeg_ctx *ctx,  void __iomem *base,
 			writel(dma_addr, base + JPEG_ENC_SRC_CHROMA_ADDR);
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_src);
 
 void mtk_jpeg_set_enc_dst(struct mtk_jpeg_ctx *ctx, void __iomem *base,
 			  struct vb2_buffer *dst_buf)
@@ -86,6 +90,7 @@ void mtk_jpeg_set_enc_dst(struct mtk_jpeg_ctx *ctx, void __iomem *base,
 	writel(dma_addr & ~0xf, base + JPEG_ENC_DST_ADDR0);
 	writel((dma_addr + size) & ~0xf, base + JPEG_ENC_STALL_ADDR0);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_dst);
 
 void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 {
@@ -152,3 +157,4 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 
 	writel(ctx->restart_interval, base + JPEG_ENC_RST_MCU_NUM);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_params);
-- 
2.18.0

