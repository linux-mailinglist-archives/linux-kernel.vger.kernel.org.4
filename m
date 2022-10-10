Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A945F986B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiJJGec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiJJGe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:34:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF755602D;
        Sun,  9 Oct 2022 23:34:26 -0700 (PDT)
X-UUID: baa3877652294a90bfedb05f01ab8aaf-20221010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FsTaSh9VCKsrA8vd4WZHIlcZYB79KrDqTmuQM1SfHW8=;
        b=qmblZ1zx0Lm1QjxgY7v6LVEts5+u6X1MrEtoPUekUp97xjiZ7MkGG5tKi3eEz61kS3fX2b/mUaRqHWyxuZOVtBD4XjRaj8GzyfzNlASFi8HMM1g/1dvjnIUc5vlINcW5dmPSxlNsV4rUpcK8jf+e88kof0rRvj/kk9Keo+cGm2E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3cae6664-b537-42c3-9e25-ff108f8fd637,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:e9bc68e1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: baa3877652294a90bfedb05f01ab8aaf-20221010
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <mingjia.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2115615430; Mon, 10 Oct 2022 14:34:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 10 Oct 2022 14:34:19 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 10 Oct 2022 14:34:18 +0800
From:   Mingjia Zhang <mingjia.zhang@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>
Subject: [PATCH, v3] media: mediatek: vcodec: Add to support VP9 inner racing mode
Date:   Mon, 10 Oct 2022 14:33:41 +0800
Message-ID: <20221010063341.5753-1-mingjia.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

In order to reduce decoder latency, enable VP9 inner racing mode.
Send lat trans buffer information to core when trigger lat to work,
need not to wait until lat decode done.

Signed-off-by: mingjia zhang <mingjia.zhang@mediatek.com>
---
1. CTS/GTS test pass
2. Fluster result: Ran 275/303 tests successfully
---
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 72 +++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index 81de876d51267..f07015eb79218 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -436,6 +436,7 @@ struct vdec_vp9_slice_ref {
  * @frame_ctx:		4 frame context according to VP9 Spec
  * @frame_ctx_helper:	4 frame context according to newest kernel spec
  * @dirty:		state of each frame context
+ * @local_vsi:		local instance vsi information
  * @init_vsi:		vsi used for initialized VP9 instance
  * @vsi:		vsi used for decoding/flush ...
  * @core_vsi:		vsi used for Core stage
@@ -482,6 +483,8 @@ struct vdec_vp9_slice_instance {
 	struct v4l2_vp9_frame_context frame_ctx_helper;
 	unsigned char dirty[4];
 
+	struct vdec_vp9_slice_vsi local_vsi;
+
 	/* MicroP vsi */
 	union {
 		struct vdec_vp9_slice_init_vsi *init_vsi;
@@ -1616,16 +1619,10 @@ static int vdec_vp9_slice_update_single(struct vdec_vp9_slice_instance *instance
 }
 
 static int vdec_vp9_slice_update_lat(struct vdec_vp9_slice_instance *instance,
-				     struct vdec_lat_buf *lat_buf,
-				     struct vdec_vp9_slice_pfc *pfc)
+				     struct vdec_vp9_slice_vsi *vsi)
 {
-	struct vdec_vp9_slice_vsi *vsi;
-
-	vsi = &pfc->vsi;
-	memcpy(&pfc->state[0], &vsi->state, sizeof(vsi->state));
-
 	mtk_vcodec_debug(instance, "Frame %u LAT CRC 0x%08x %lx %lx\n",
-			 pfc->seq, vsi->state.crc[0],
+			 (instance->seq - 1), vsi->state.crc[0],
 			 (unsigned long)vsi->trans.dma_addr,
 			 (unsigned long)vsi->trans.dma_addr_end);
 
@@ -2090,6 +2087,13 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		return ret;
 	}
 
+	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability)) {
+		vdec_vp9_slice_vsi_from_remote(vsi, instance->vsi, 0);
+		memcpy(&instance->local_vsi, vsi, sizeof(*vsi));
+		vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
+		vsi = &instance->local_vsi;
+	}
+
 	if (instance->irq) {
 		ret = mtk_vcodec_wait_for_done_ctx(ctx,	MTK_INST_IRQ_RECEIVED,
 						   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
@@ -2102,22 +2106,25 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	}
 
 	vdec_vp9_slice_vsi_from_remote(vsi, instance->vsi, 0);
-	ret = vdec_vp9_slice_update_lat(instance, lat_buf, pfc);
+	ret = vdec_vp9_slice_update_lat(instance, vsi);
 
-	/* LAT trans full, no more UBE or decode timeout */
-	if (ret) {
-		mtk_vcodec_err(instance, "VP9 decode error: %d\n", ret);
-		return ret;
-	}
+	if (!IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
+		/* LAT trans full, no more UBE or decode timeout */
+		if (ret) {
+			mtk_vcodec_err(instance, "frame[%d] decode error: %d\n",
+				       ret, (instance->seq - 1));
+			return ret;
+		}
 
-	mtk_vcodec_debug(instance, "lat dma addr: 0x%lx 0x%lx\n",
-			 (unsigned long)pfc->vsi.trans.dma_addr,
-			 (unsigned long)pfc->vsi.trans.dma_addr_end);
 
-	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue,
-				       vsi->trans.dma_addr_end +
-				       ctx->msg_queue.wdma_addr.dma_addr);
-	vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
+	vsi->trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
+	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue, vsi->trans.dma_addr_end);
+	if (!IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
+		vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
+
+	mtk_vcodec_debug(instance, "lat trans end addr(0x%lx), ube start addr(0x%lx)\n",
+			 (unsigned long)vsi->trans.dma_addr_end,
+			 (unsigned long)ctx->msg_queue.wdma_addr.dma_addr);
 
 	return 0;
 }
@@ -2139,22 +2146,22 @@ static int vdec_vp9_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
 {
 	struct vdec_vp9_slice_instance *instance;
-	struct vdec_vp9_slice_pfc *pfc;
+	struct vdec_vp9_slice_pfc *pfc = NULL;
 	struct mtk_vcodec_ctx *ctx = NULL;
 	struct vdec_fb *fb = NULL;
 	int ret = -EINVAL;
 
 	if (!lat_buf)
-		goto err;
+		return -EINVAL;
 
 	pfc = lat_buf->private_data;
 	ctx = lat_buf->ctx;
 	if (!pfc || !ctx)
-		goto err;
+		return -EINVAL;
 
 	instance = ctx->drv_handle;
 	if (!instance)
-		goto err;
+		return -EINVAL;
 
 	fb = ctx->dev->vdec_pdata->get_cap_buffer(ctx);
 	if (!fb) {
@@ -2193,10 +2200,14 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
 		goto err;
 	}
 
-	pfc->vsi.trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
 	mtk_vcodec_debug(instance, "core dma_addr_end 0x%lx\n",
 			 (unsigned long)pfc->vsi.trans.dma_addr_end);
-	vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
+
+	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
+		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr);
+	else
+		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
+
 	ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req);
 
 	return 0;
@@ -2204,7 +2215,12 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
 err:
 	if (ctx && pfc) {
 		/* always update read pointer */
-		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
+		if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
+			vdec_msg_queue_update_ube_rptr(&ctx->msg_queue,
+						       pfc->vsi.trans.dma_addr);
+		else
+			vdec_msg_queue_update_ube_rptr(&ctx->msg_queue,
+						       pfc->vsi.trans.dma_addr_end);
 
 		if (fb)
 			ctx->dev->vdec_pdata->cap_to_disp(ctx, 1, lat_buf->src_buf_req);
-- 
2.18.0

