Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A716669FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjALEMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjALEL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:11:56 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9F14C700;
        Wed, 11 Jan 2023 20:11:48 -0800 (PST)
X-UUID: 390dd42a922f11eda06fc9ecc4dadd91-20230112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lcuCv0HZr2C2o7pqLKbqyavho3YBaOUbCp1tDuk6hkQ=;
        b=WsOsV5GNRMbtsJF2LAjH5ENvo35ny8qiCQ92EmtphxCkg0Xp6pkgbZN2S/s4aJ4NQZkDXBJu5P1/YCPic2IiH5MlCbATJmunDQW6lLu7fsJCAp9WKfUDAZViLfTBFeCLa8ltdJtrnxWhouTQrboV8lEOSJZrVT6UwNX1DtMU0Xs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:b1178831-d4f6-4b39-8466-bcc79f54fc5f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:b1178831-d4f6-4b39-8466-bcc79f54fc5f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:0f8295f5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230112121144INYVB5PY,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0
X-UUID: 390dd42a922f11eda06fc9ecc4dadd91-20230112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 735739956; Thu, 12 Jan 2023 12:11:43 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Jan 2023 12:11:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Jan 2023 12:11:41 +0800
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
Subject: [PATCH v3,0/7] media: mediatek: vcodec: Fix power_VideoCall test fail
Date:   Thu, 12 Jan 2023 12:11:33 +0800
Message-ID: <20230112041140.833-1-yunfei.dong@mediatek.com>
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

