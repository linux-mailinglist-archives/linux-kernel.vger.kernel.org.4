Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA36F7B0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEECev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEECet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:34:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A0012095;
        Thu,  4 May 2023 19:34:41 -0700 (PDT)
X-UUID: 5ffb98c6eaed11ed9cb5633481061a41-20230505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=c/gpMxHSMBF9nw2cBYHvnoTyggukET34MrMEfdLJ3R8=;
        b=ZSRPj/cOgF/YJrUvE3p8h3h6GXxuHGru/ZprNILyKbmdNfe4OsDCCQ6gnZ8p/1onbkAlo82qSVbj+sk92+mJ0tGCmNHgN/aXM1ZEa6jAO3NJM+PdZeu868kNB6dv3pQTA2LH6cwvsSI8qUuQRS7XecHRH0LrUpLya+fqNDejsFo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:06162b39-c0eb-407e-a485-3d828b488987,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.23,REQID:06162b39-c0eb-407e-a485-3d828b488987,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:697ab71,CLOUDID:2769d9bf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230505103436HVAXJSXD,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5ffb98c6eaed11ed9cb5633481061a41-20230505
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 871325226; Fri, 05 May 2023 10:34:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 May 2023 10:34:34 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 5 May 2023 10:34:33 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4,0/2] media: mediatek: vcodec: add hevc stateless decoder driver in MT8195
Date:   Fri, 5 May 2023 10:34:30 +0800
Message-ID: <20230505023432.22559-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hevc stateless decoder driver to support hardware decode in MT8195, and the driver
need num_delta_pocs_of_ref_rps_idx value to parse slice header short_term_ref_pic_set().

patch 1 add num_delta_pocs_of_ref_rps_idx field.
patch 2 add hevc stateless decoder driver.
---
Changed from v3:
- add the dependency patch to this patch series for patch 1.

Changed from v2:
- fix one build warning.
- add the dependency patch link.

Changed from v1:
- fix build error when build 32bit system.
- hevc fluster test result: 132/147 (not support: 10bit => 11 and resolution => 4).
---
Benjamin Gaignard (1):
  media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field

Yunfei Dong (1):
  media: mediatek: vcodec: support stateless hevc decoder

 .../media/v4l/ext-ctrls-codec-stateless.rst   |    7 +
 .../media/platform/mediatek/vcodec/Makefile   |    1 +
 .../vcodec/mtk_vcodec_dec_stateless.c         |   59 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
 .../vcodec/vdec/vdec_hevc_req_multi_if.c      | 1101 +++++++++++++++++
 .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
 .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
 include/uapi/linux/v4l2-controls.h            |    6 +-
 8 files changed, 1178 insertions(+), 2 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c

-- 
2.18.0

