Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95E6A0399
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjBWINs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjBWIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:13:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97093498B4;
        Thu, 23 Feb 2023 00:13:27 -0800 (PST)
X-UUID: ef8ecdbab35111ed945fc101203acc17-20230223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QsyCwrGwGh6nf4heZThET+LTLXoG42t7GpLMsbNCMTs=;
        b=EQhUWMEhiLzo52BoAhc3eABLKbhW/C/kAk/DV+8M4V59q8DnMckVNZ4aKojfAAN3a0AWoKtzhZevyQgVncFmB4KQDNcSwfINnWxsff9S2U5HNrDKYw4lDq8ZP87nP9R0FTYL5zzSRvySv47zcToX6GsUkZIUArXtI81Lz4af+nY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:d4e45d69-c2f2-441d-ada6-d244e96eef0a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.20,REQID:d4e45d69-c2f2-441d-ada6-d244e96eef0a,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:25b5999,CLOUDID:10607826-564d-42d9-9875-7c868ee415ec,B
        ulkID:230223161322DDLYE2TR,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: ef8ecdbab35111ed945fc101203acc17-20230223
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1281582550; Thu, 23 Feb 2023 16:13:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 23 Feb 2023 16:13:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 23 Feb 2023 16:13:19 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        "Irui Wang" <irui.wang@mediatek.com>
Subject: [V1,5/7] media: mtk-jpeg: Remove some unnecessary variables
Date:   Thu, 23 Feb 2023 16:13:10 +0800
Message-ID: <20230223081312.29296-6-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223081312.29296-1-irui.wang@mediatek.com>
References: <20230223081312.29296-1-irui.wang@mediatek.com>
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

remove is_jpgenc_multihw, is_jpgdec_multihw,
and unnecessary initialization.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  4 ---
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 29 ++++++++-----------
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 18 ++++--------
 3 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index e118a0175f75..83cf35a12b7a 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -204,12 +204,10 @@ struct mtk_jpegdec_comp_dev {
  * @variant:		driver variant to be used
  * @reg_encbase:	jpg encode register base addr
  * @enc_hw_dev:		jpg encode hardware device
- * @is_jpgenc_multihw:	the flag of multi-hw core
  * @enc_hw_wq:		jpg encode wait queue
  * @enchw_rdy:		jpg encode hw ready flag
  * @reg_decbase:	jpg decode register base addr
  * @dec_hw_dev:		jpg decode hardware device
- * @is_jpgdec_multihw:	the flag of dec multi-hw core
  * @dec_hw_wq:		jpg decode wait queue
  * @dec_workqueue:	jpg decode work queue
  * @dechw_rdy:		jpg decode hw ready flag
@@ -229,13 +227,11 @@ struct mtk_jpeg_dev {
 
 	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
 	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
-	bool is_jpgenc_multihw;
 	wait_queue_head_t enc_hw_wq;
 	atomic_t enchw_rdy;
 
 	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
 	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
-	bool is_jpgdec_multihw;
 	wait_queue_head_t dec_hw_wq;
 	struct workqueue_struct	*dec_workqueue;
 	atomic_t dechw_rdy;
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 8c07fa02fd9a..5b47bd83c5ce 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -608,23 +608,18 @@ static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 	dev->plat_dev = pdev;
 	dev->dev = &pdev->dev;
 
-	if (!master_dev->is_jpgdec_multihw) {
-		master_dev->is_jpgdec_multihw = true;
-		for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
-			master_dev->dec_hw_dev[i] = NULL;
-
-		init_waitqueue_head(&master_dev->dec_hw_wq);
-		master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
-								WQ_MEM_RECLAIM
-								| WQ_FREEZABLE);
-		if (!master_dev->workqueue)
-			return -EINVAL;
-
-		ret = devm_add_action_or_reset(&pdev->dev, mtk_jpegdec_destroy_workqueue,
-					       master_dev->workqueue);
-		if (ret)
-			return ret;
-	}
+	init_waitqueue_head(&master_dev->dec_hw_wq);
+	master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
+							WQ_MEM_RECLAIM
+							| WQ_FREEZABLE);
+	if (!master_dev->workqueue)
+		return -EINVAL;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       mtk_jpegdec_destroy_workqueue,
+				       master_dev->workqueue);
+	if (ret)
+		return ret;
 
 	atomic_set(&master_dev->dechw_rdy, MTK_JPEGDEC_HW_MAX);
 	spin_lock_init(&dev->hw_lock);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 867f4c1a09fa..c2bc0b531b32 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -340,18 +340,12 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
 	dev->plat_dev = pdev;
 	dev->dev = &pdev->dev;
 
-	if (!master_dev->is_jpgenc_multihw) {
-		master_dev->is_jpgenc_multihw = true;
-		for (i = 0; i < MTK_JPEGENC_HW_MAX; i++)
-			master_dev->enc_hw_dev[i] = NULL;
-
-		init_waitqueue_head(&master_dev->enc_hw_wq);
-		master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
-								WQ_MEM_RECLAIM
-								| WQ_FREEZABLE);
-		if (!master_dev->workqueue)
-			return -EINVAL;
-	}
+	init_waitqueue_head(&master_dev->enc_hw_wq);
+	master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
+							WQ_MEM_RECLAIM
+							| WQ_FREEZABLE);
+	if (!master_dev->workqueue)
+		return -EINVAL;
 
 	atomic_set(&master_dev->enchw_rdy, MTK_JPEGENC_HW_MAX);
 	spin_lock_init(&dev->hw_lock);
-- 
2.18.0

