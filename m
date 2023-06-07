Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3554725886
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbjFGIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjFGItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:49:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382EC19BA;
        Wed,  7 Jun 2023 01:49:13 -0700 (PDT)
X-UUID: 2976223e051011eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qHZ5pK7jB7tXpFRBJY3BYm8jPO6geMxkX0omTpVH8Vc=;
        b=L6uVfp6D/6bqAs8dC5drR4wvcclmP5HHbWED+v4yfOuOb5sXTQE4JR8r6AmVSshfh0Ojg7iunP8+BSh1N1fow5xB5f1vkfhPAsKD1dRuO9vTxPpPVBr4S89pu4zDfd4Hrcmg/S18PYqh5c2DS8oK3dOGhWHECpC7AgTFdY6zeWU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:73020a69-e774-4085-bb6b-4bb98e26b4dd,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.25,REQID:73020a69-e774-4085-bb6b-4bb98e26b4dd,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:d5b0ae3,CLOUDID:23c5a83d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230607164908LOZGFWWM,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 2976223e051011eeb20a276fd37b9834-20230607
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 576942026; Wed, 07 Jun 2023 16:49:06 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 16:49:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 16:49:04 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,02/10] media: mediatek: vcodec: align fw interface
Date:   Wed, 7 Jun 2023 16:48:53 +0800
Message-ID: <20230607084901.28021-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607084901.28021-1-yunfei.dong@mediatek.com>
References: <20230607084901.28021-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Align scp and vpu firmware interface, remove the depedency for
'struct mtk_vcodec_dev' and 'struct mtk_vcodec_ctx'. It will be
much easier to separate video encoder and decoder.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/platform/mediatek/vcodec/mtk_vcodec_fw.c   |  7 +++----
 .../media/platform/mediatek/vcodec/mtk_vcodec_fw.h   |  3 +--
 .../platform/mediatek/vcodec/mtk_vcodec_fw_priv.h    | 11 +++++------
 .../platform/mediatek/vcodec/mtk_vcodec_fw_scp.c     |  9 ++++++---
 .../platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c     | 12 ++++++++----
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
index 556e54aadac9..be9159acacf8 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
@@ -5,15 +5,14 @@
 #include "mtk_vcodec_util.h"
 #include "mtk_vcodec_drv.h"
 
-struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
-					   enum mtk_vcodec_fw_type type,
+struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
 					   enum mtk_vcodec_fw_use fw_use)
 {
 	switch (type) {
 	case VPU:
-		return mtk_vcodec_fw_vpu_init(dev, fw_use);
+		return mtk_vcodec_fw_vpu_init(priv, fw_use);
 	case SCP:
-		return mtk_vcodec_fw_scp_init(dev);
+		return mtk_vcodec_fw_scp_init(priv, fw_use);
 	default:
 		mtk_v4l2_err("invalid vcodec fw type");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
index 16824114657f..d8cfbec323d5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
@@ -25,8 +25,7 @@ struct mtk_vcodec_fw;
 typedef void (*mtk_vcodec_ipi_handler) (void *data,
 	unsigned int len, void *priv);
 
-struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
-					   enum mtk_vcodec_fw_type type,
+struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
 					   enum mtk_vcodec_fw_use fw_use);
 void mtk_vcodec_fw_release(struct mtk_vcodec_fw *fw);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
index b41e66185cec..3438a4917344 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
@@ -12,6 +12,7 @@ struct mtk_vcodec_fw {
 	const struct mtk_vcodec_fw_ops *ops;
 	struct platform_device *pdev;
 	struct mtk_scp *scp;
+	enum mtk_vcodec_fw_use fw_use;
 };
 
 struct mtk_vcodec_fw_ops {
@@ -28,22 +29,20 @@ struct mtk_vcodec_fw_ops {
 };
 
 #if IS_ENABLED(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU)
-struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
-					     enum mtk_vcodec_fw_use fw_use);
+struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use fw_use);
 #else
 static inline struct mtk_vcodec_fw *
-mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
-		       enum mtk_vcodec_fw_use fw_use)
+mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use fw_use)
 {
 	return ERR_PTR(-ENODEV);
 }
 #endif /* CONFIG_VIDEO_MEDIATEK_VCODEC_VPU */
 
 #if IS_ENABLED(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP)
-struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev);
+struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use fw_use);
 #else
 static inline struct mtk_vcodec_fw *
-mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
+mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use fw_use)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
index d8e66b645bd8..9a2472442c6f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
@@ -53,18 +53,21 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_rproc_msg = {
 	.release = mtk_vcodec_scp_release,
 };
 
-struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
+struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use fw_use)
 {
 	struct mtk_vcodec_fw *fw;
+	struct mtk_vcodec_dev *dev = priv;
+	struct platform_device *plat_dev;
 	struct mtk_scp *scp;
 
-	scp = scp_get(dev->plat_dev);
+	plat_dev = dev->plat_dev;
+	scp = scp_get(plat_dev);
 	if (!scp) {
 		mtk_v4l2_err("could not get vdec scp handle");
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
index cfc7ebed8fb7..46a028031133 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
@@ -77,10 +77,11 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
 	.release = mtk_vcodec_vpu_release,
 };
 
-struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
-					     enum mtk_vcodec_fw_use fw_use)
+struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use fw_use)
 {
 	struct platform_device *fw_pdev;
+	struct mtk_vcodec_dev *dev = priv;
+	struct platform_device *plat_dev;
 	struct mtk_vcodec_fw *fw;
 	enum rst_id rst_id;
 
@@ -94,19 +95,22 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
 		break;
 	}
 
-	fw_pdev = vpu_get_plat_device(dev->plat_dev);
+	plat_dev = dev->plat_dev;
+	fw_pdev = vpu_get_plat_device(plat_dev);
 	if (!fw_pdev) {
 		mtk_v4l2_err("firmware device is not ready");
 		return ERR_PTR(-EINVAL);
 	}
+
 	vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_handler, dev, rst_id);
 
-	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
 	if (!fw)
 		return ERR_PTR(-ENOMEM);
 	fw->type = VPU;
 	fw->ops = &mtk_vcodec_vpu_msg;
 	fw->pdev = fw_pdev;
+	fw->fw_use = fw_use;
 
 	return fw;
 }
-- 
2.18.0

