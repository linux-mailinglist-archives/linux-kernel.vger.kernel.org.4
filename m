Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9A6860AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjBAHdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBAHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:33:34 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1227499;
        Tue, 31 Jan 2023 23:33:22 -0800 (PST)
X-UUID: b3301c6ca20211eda06fc9ecc4dadd91-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=c8zIgAIM9twVEzzFeO8jvD5x33i309731TYIWFJD0ec=;
        b=U+USV6SU1X44gtZwSiitysIs4ogeNSZNXFHD+hLVw9W0ObNrzXKENaK9xtdi0sBjOfEoHrQFojwd8ikXOMNi57KXFlBqlaWGxNqmhmbZ/xc0HCXTzCmnj0L0wWtbp7CcZDLzgJvC/pZPsoG5WoGd5ZYz2GSAtVnnNkzIKocAUoA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:71dddf32-e108-4e3f-b1f3-6649def7371f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:71dddf32-e108-4e3f-b1f3-6649def7371f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:68a41ef7-ff42-4fb0-b929-626456a83c14,B
        ulkID:230201153320X3Q14PSB,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: b3301c6ca20211eda06fc9ecc4dadd91-20230201
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 969479368; Wed, 01 Feb 2023 15:33:19 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 15:33:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 15:33:17 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4,0/7] media: mediatek: vcodec: Fix power_VideoCall test fail
Date:   Wed, 1 Feb 2023 15:33:09 +0800
Message-ID: <20230201073316.27923-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Random getting below error message when test power_VideoCall/control.49_vp9:
pc : __list_del_entry_valid+0xb0/0xfc
lr : __list_del_entry_valid+0xac/0xfc

The lat_buf in core list won't be deleted when one instance decode done.
Will access invalid released lat_buf list when queue work continue to decode.
Firstly, remove all unused lat_buf to the top of core list, making sure
these buffers can be decoded in highest priority; lastly, remove all unused
lat_buf when the instance is freed.

patch 1 add params to record lat and core lat_buf count.
patch 2 using each instance lat_buf count replace core ready list.
patch 3 move lat_buf to the top of core list.
patch 4 add core decode done event.
patch 5 remove unused lat_buf.
patch 6 making sure queue_work successfully
patch 7 change lat thread decode error condition
---
changed with v3:
- forgot to add reviewed-by for patch: 1/2/4/5/7
changed with v2:
- fix seek fail for patch 3
changed with v1:
- remove mutex for atomic for patch 1
- add patch 6 to make sure queue_work successfully
- add patch 7 change lat thread decode error condition
---
Yunfei Dong (7):
  media: mediatek: vcodec: add params to record lat and core lat_buf
    count
  media: mediatek: vcodec: using each instance lat_buf count replace
    core ready list
  media: mediatek: vcodec: move lat_buf to the top of core list
  media: mediatek: vcodec: add core decode done event
  media: mediatek: vcodec: remove unused lat_buf
  media: mediatek: vcodec: making sure queue_work successfully
  media: mediatek: vcodec: change lat thread decode error condition

 .../vcodec/mtk_vcodec_dec_stateless.c         |  6 +-
 .../vcodec/vdec/vdec_h264_req_multi_if.c      |  2 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  2 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 95 ++++++++++++++++---
 .../platform/mediatek/vcodec/vdec_msg_queue.h | 12 +++
 5 files changed, 100 insertions(+), 17 deletions(-)

-- 
2.18.0

