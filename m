Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300270EB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbjEXCRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjEXCRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:17:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B113184;
        Tue, 23 May 2023 19:17:04 -0700 (PDT)
X-UUID: 10298d58f9d911edb20a276fd37b9834-20230524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BvH+eHnwwHPlF9AE7MZRrQpAo6ey10Th6FmdCXrmjdY=;
        b=M8iAUZa97zCoFby43wgourUgz4E6wm+C0Qw2QPChaRriOFhpWuAWMtssIVJ71JoZ/QRBdDrARZR0LM3W2ZC4wSqksTjbPO1d5Ozz4uQpKjWWNhS1wefxX9mf86XdpBkA+cHwaSwkOADDkbTA+zxMv26RJbD1bggB6VVce8gUANE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:bdf3dd11-dad2-4878-a145-f2d0878aa3f2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:7bf0cb6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 10298d58f9d911edb20a276fd37b9834-20230524
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 422319247; Wed, 24 May 2023 10:16:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 10:16:57 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 10:16:57 +0800
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
Subject: [PATCH v5,1/2] media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field
Date:   Wed, 24 May 2023 10:16:24 +0800
Message-ID: <20230524021625.13708-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524021625.13708-1-yunfei.dong@mediatek.com>
References: <20230524021625.13708-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Some drivers firmwares parse by themselves slice header and need
num_delta_pocs_of_ref_rps_idx value to parse slice header
short_term_ref_pic_set().
Use one of the 4 reserved bytes to store this value without
changing the v4l2_ctrl_hevc_decode_params structure size and padding.

This value also exist in DXVA API.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst  | 7 +++++++
 include/uapi/linux/v4l2-controls.h                         | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index 3d8411acd5b8..92ce3e126929 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -2923,6 +2923,13 @@ This structure contains all loop filter related parameters. See sections
       - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - PocLtCurr as described in section 8.3.2 "Decoding process for reference
         picture set": provides the index of the long term references in DPB array.
+    * - __u8
+      - ``num_delta_pocs_of_ref_rps_idx``
+      - When the short_term_ref_pic_set_sps_flag in the slice header is equal to 0,
+        it is the same than derived value NumDeltaPocs[RefRpsIdx]. It can be used to parse
+        the RPS data in slice headers instead of skipping it with @short_term_ref_pic_set_size.
+        When the value of short_term_ref_pic_set_sps_flag in the slice header is
+        equal to 1, num_delta_pocs_of_ref_rps_idx shall be set to 0.
     * - struct :c:type:`v4l2_hevc_dpb_entry`
       - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - The decoded picture buffer, for meta-data about reference frames.
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5e80daa4ffe0..7bf59a87a1bf 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -2385,6 +2385,9 @@ struct v4l2_ctrl_hevc_slice_params {
  * @poc_st_curr_after: provides the index of the short term after references
  *		       in DPB array
  * @poc_lt_curr: provides the index of the long term references in DPB array
+ * @num_delta_pocs_of_ref_rps_idx: same as the derived value NumDeltaPocs[RefRpsIdx],
+ *				   can be used to parse the RPS data in slice headers
+ *				   instead of skipping it with @short_term_ref_pic_set_size.
  * @reserved: padding field. Should be zeroed by applications.
  * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
@@ -2400,7 +2403,8 @@ struct v4l2_ctrl_hevc_decode_params {
 	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	reserved[4];
+	__u8	num_delta_pocs_of_ref_rps_idx;
+	__u8	reserved[3];
 	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u64	flags;
 };
-- 
2.18.0

