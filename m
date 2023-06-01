Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F372F7190E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjFADEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFADDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:03:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40576E66;
        Wed, 31 May 2023 20:03:13 -0700 (PDT)
X-UUID: d54dfb00002811ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5NQw5nNr+V8dqKIJpGJGwWeRSbrLITZuKVgdVEn6kVQ=;
        b=kPgOQfZGgYmbBUXq5aokAueCuMxSXR/99Gydcv1SibYLUn9b9eQzU6EdOgq16eHD/nuDfpXnqKwaFgMq90k9PNjeDW06Z/m8PXQ7ZCTAiqayDrQNXSvErv9WJFUoKLULXoD5uBTGwk4cQDoLEWDl1sqqkgB68rAUjzfu6ZoRuMA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:5f562712-bb3e-41ba-b26c-08b1c6bb88e4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:ae73333d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d54dfb00002811ee9cb5633481061a41-20230601
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1889480295; Thu, 01 Jun 2023 11:03:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 11:03:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 11:03:05 +0800
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
Subject: [PATCH 7/8] mediatek: vcodec: remove unused include header
Date:   Thu, 1 Jun 2023 11:02:55 +0800
Message-ID: <20230601030256.29875-8-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601030256.29875-1-yunfei.dong@mediatek.com>
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused include header for .c files

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c         | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c     | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c      | 1 -
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c      | 1 -
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c    | 2 --
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c   | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c         | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c     | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c          | 1 -
 .../media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c   | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c      | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c  | 1 -
 .../platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c      | 1 -
 .../platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c      | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c       | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c   | 1 -
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 1 -
 drivers/media/platform/mediatek/vcodec/vdec_drv_if.h            | 1 -
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h         | 2 --
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c            | 1 -
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h            | 2 --
 drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c      | 1 -
 drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c       | 1 -
 drivers/media/platform/mediatek/vcodec/venc_vpu_if.c            | 1 -
 drivers/media/platform/mediatek/vcodec/venc_vpu_if.h            | 1 -
 25 files changed, 33 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index e55d67783d39..24d74437b76a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -11,8 +11,6 @@
 
 #include "mtk_vcodec_dec_drv.h"
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "vdec_drv_if.h"
 #include "mtk_vcodec_dec_pm.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 123c1430ce67..9dfe37143f9c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -21,8 +21,6 @@
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
-#include "mtk_vcodec_fw.h"
 
 static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_dev *dev)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index f33bb0c99911..39c3798d33a0 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -16,7 +16,6 @@
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 
 static const struct of_device_id mtk_vdec_hw_match[] = {
 	{
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index dd961a1ae2e8..12a99a1ecdd5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -12,7 +12,6 @@
 
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
-#include "mtk_vcodec_util.h"
 
 int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *pm)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index b0e1e18b2d9b..d4ac7cde6333 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -5,8 +5,6 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "vdec_drv_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index 875cbade949b..56bd9b877bbc 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -7,8 +7,6 @@
 #include <linux/module.h>
 
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "vdec_drv_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 452bcbf82d23..99f247231d95 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -11,8 +11,6 @@
 #include <linux/pm_runtime.h>
 
 #include "mtk_vcodec_enc.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "venc_drv_if.h"
 
 #define MTK_VENC_MIN_W	160U
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index b9653330e7af..deb6a8d46016 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -19,8 +19,6 @@
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
-#include "mtk_vcodec_fw.h"
 
 static const struct mtk_video_fmt mtk_video_formats_output[] = {
 	{
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
index ba619beeac59..db3ef07d0d40 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
@@ -2,7 +2,6 @@
 
 #include "mtk_vcodec_dec_drv.h"
 #include "mtk_vcodec_enc_drv.h"
-#include "mtk_vcodec_fw.h"
 #include "mtk_vcodec_fw_priv.h"
 
 struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
index 64cd9ef99766..3cee123dde35 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
index 326cb27faca2..f2e4003ca519 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 
 #include "../vdec_drv_if.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index be9f678ae6f9..4a6bd7e14546 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -6,7 +6,6 @@
 #include <media/v4l2-h264.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 171d05b9a870..2baec6cb5586 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -10,7 +10,6 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
index 46b564b3f247..dc9846153389 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index a89c477fc4cf..bb28e961673d 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -7,7 +7,6 @@
 
 #include <linux/slab.h>
 #include "../vdec_drv_if.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index f530ad00e5ea..71ad1c89afc2 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -9,7 +9,6 @@
 #include <media/videobuf2-dma-contig.h>
 #include <uapi/linux/v4l2-controls.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index e61b0dc13e08..0226c6eec526 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -9,7 +9,6 @@
 #include <media/videobuf2-dma-contig.h>
 #include <media/v4l2-vp9.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
index 7b41ce23158b..bfd297c96850 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
@@ -9,7 +9,6 @@
 #define _VDEC_DRV_IF_H_
 
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_util.h"
 
 
 /**
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index af2636244af0..654468a169b1 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -12,8 +12,6 @@
 #include <linux/slab.h>
 #include <media/videobuf2-v4l2.h>
 
-#include "mtk_vcodec_util.h"
-
 #define NUM_BUFFER_COUNT 3
 
 struct vdec_lat_buf;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index 01b66dec1403..504f8f863699 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -8,7 +8,6 @@
 #include "vdec_drv_if.h"
 #include "vdec_ipi_msg.h"
 #include "vdec_vpu_if.h"
-#include "mtk_vcodec_fw.h"
 
 static void handle_init_ack_msg(const struct vdec_vpu_ipi_init_ack *msg)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
index c9766c108209..fbb3f34a73f0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
@@ -7,8 +7,6 @@
 #ifndef _VDEC_VPU_IF_H_
 #define _VDEC_VPU_IF_H_
 
-#include "mtk_vcodec_fw.h"
-
 struct mtk_vcodec_dec_ctx;
 
 /**
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 50cad924d616..8c0b9ca84dc2 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 
 #include "../mtk_vcodec_enc_drv.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
 #include "../mtk_vcodec_enc_pm.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index 7d5077c5a2ae..acec99c6ee18 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -10,7 +10,6 @@
 #include <linux/slab.h>
 
 #include "../mtk_vcodec_enc_drv.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
 #include "../mtk_vcodec_enc_pm.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
index 9ce6a8ee80d6..5aa8db95bea5 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
@@ -5,7 +5,6 @@
  */
 
 #include "mtk_vcodec_enc_drv.h"
-#include "mtk_vcodec_fw.h"
 #include "venc_ipi_msg.h"
 #include "venc_vpu_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
index 71370ab98809..ede55fc3bd07 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
@@ -7,7 +7,6 @@
 #ifndef _VENC_VPU_IF_H_
 #define _VENC_VPU_IF_H_
 
-#include "mtk_vcodec_fw.h"
 #include "venc_drv_if.h"
 
 /*
-- 
2.25.1

