Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27686C0ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjCTK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjCTK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:28:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E39C14A;
        Mon, 20 Mar 2023 03:28:51 -0700 (PDT)
X-UUID: fe9b18b0c70911ed91027fb02e0f1d65-20230320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wC2QahDcPJmqLLDqgN8MhygHA1dyne9/iAbypMczX/M=;
        b=SOaaB6JnTdrkwJNdaM5s2u87L/cVzpNQN4iYajoGvf93yOE74kIVl3QlzZNx4oPOMIRa1hylH3Sfy5jkiWYnvQlbUCGwpdr22mdBi1bx8IID5wmMRi9Qivh4Kh5YpgGyurUw40T/iK2Eq1hfAnMSut7iG7Scz8mpMG9CH/OZC0I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:4542406d-6fe5-4d9d-b4a4-aeb7aaaa04c5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:4542406d-6fe5-4d9d-b4a4-aeb7aaaa04c5,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:df84c8b3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:2303201828484XK8UHOP,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: fe9b18b0c70911ed91027fb02e0f1d65-20230320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 120901241; Mon, 20 Mar 2023 18:28:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 20 Mar 2023 18:28:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 18:28:44 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 5/6 RESEND] media: mediatek: vcodec: Change dbgfs interface to support encode
Date:   Mon, 20 Mar 2023 18:28:37 +0800
Message-ID: <20230320102838.8313-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320102838.8313-1-yunfei.dong@mediatek.com>
References: <20230320102838.8313-1-yunfei.dong@mediatek.com>
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

Extern dbgfs init interface to support encode and create encode
dbgfs file.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c  | 7 +++++--
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h  | 4 ++--
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c    | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 8a03f986a857..7d0021f34b3c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -124,11 +124,14 @@ void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id)
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_remove);
 
-void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
+void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_decode)
 {
 	struct dentry *vcodec_root;
 
-	vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-dec", NULL);
+	if (is_decode)
+		vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-dec", NULL);
+	else
+		vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-enc", NULL);
 	if (IS_ERR(vcodec_dev->dbgfs.vcodec_root))
 		pr_info("create dir err:%d\n", IS_ERR(vcodec_dev->dbgfs.vcodec_root));
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index 2d0b617e762e..6adfc4f417ef 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -26,7 +26,7 @@ struct mtk_vcodec_dbgfs {
 void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx);
 void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id);
 
-void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev);
+void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_decode);
 void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev);
 #else
 static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
@@ -37,7 +37,7 @@ static inline void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, in
 {
 }
 
-static inline void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
+static inline void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_decode)
 {
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 8c2443a18f5e..9260273f26cf 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -433,7 +433,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		mtk_v4l2_debug(0, "media registered as /dev/media%d", vfd_dec->minor);
 	}
 
-	mtk_vcodec_dbgfs_init(dev);
+	mtk_vcodec_dbgfs_init(dev, true);
 	mtk_v4l2_debug(0, "decoder registered as /dev/video%d", vfd_dec->minor);
 
 	return 0;
-- 
2.25.1

