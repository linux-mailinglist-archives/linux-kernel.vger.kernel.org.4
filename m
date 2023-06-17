Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0609273402A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346247AbjFQKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjFQKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:33:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB22129;
        Sat, 17 Jun 2023 03:33:08 -0700 (PDT)
X-UUID: 54bf0bbc0cfa11eeb20a276fd37b9834-20230617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bhlkZzcYDzvFOj/Dy9+tos0NhgT/advdqqmvDOVVSMM=;
        b=Cmd+zkip7USvRh+GvAy5zQOvYaAtpmFsk6zD0kQxU+3hjOPEMGIKTW/cQDtC3gU1Q9sWbqzogrv7qLY0Y2KZQwLmKT+sY4K7zwb/caIzsNpFhfGYWJU6o0pMfm+/pyGeVBCG4MX10FNpI5XXnslgYB+XU7cKVrsPAtfQHR97z4Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:e55f55a2-5b35-4ff2-ad2d-e9ffd011c7f6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:cb9a4e1,CLOUDID:eb94bc3e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 54bf0bbc0cfa11eeb20a276fd37b9834-20230617
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2603498; Sat, 17 Jun 2023 18:32:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 17 Jun 2023 18:32:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 17 Jun 2023 18:32:57 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3,01/11] media: mediatek: vcodec: remove unused parameter
Date:   Sat, 17 Jun 2023 18:32:45 +0800
Message-ID: <20230617103255.20239-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230617103255.20239-1-yunfei.dong@mediatek.com>
References: <20230617103255.20239-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused parameter in struct mtk_vcodec_dev.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h     | 6 ------
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 2 --
 3 files changed, 10 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index d41f2121b94f..03721eda2769 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -336,8 +336,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_core_workq;
 	}
 
-	init_waitqueue_head(&dev->queue);
-
 	vfd_dec = video_device_alloc();
 	if (!vfd_dec) {
 		mtk_v4l2_err("Failed to allocate video device");
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index f17d67e781c9..e3230a4d7b8e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -448,10 +448,7 @@ struct mtk_vcodec_enc_pdata {
  * @decode_workqueue: decode work queue
  * @encode_workqueue: encode work queue
  *
- * @int_cond: used to identify interrupt condition happen
- * @int_type: used to identify what kind of interrupt condition happen
  * @dev_mutex: video_device lock
- * @queue: waitqueue for waiting for completion of device commands
  *
  * @dec_irq: decoder irq resource
  * @enc_irq: h264 encoder irq resource
@@ -496,10 +493,7 @@ struct mtk_vcodec_dev {
 
 	struct workqueue_struct *decode_workqueue;
 	struct workqueue_struct *encode_workqueue;
-	int int_cond;
-	int int_type;
 	struct mutex dev_mutex;
-	wait_queue_head_t queue;
 
 	int dec_irq;
 	int enc_irq;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 5df0a22ff3b5..a56652e476c2 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -311,8 +311,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	init_waitqueue_head(&dev->queue);
-
 	/* allocate video device for encoder and register it */
 	vfd_enc = video_device_alloc();
 	if (!vfd_enc) {
-- 
2.18.0

