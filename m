Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087E169ED36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjBVDEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBVDEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:04:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6AA22024;
        Tue, 21 Feb 2023 19:04:45 -0800 (PST)
X-UUID: a4a0e0a8b25d11eda06fc9ecc4dadd91-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iZDnSTAwSwS5YygcvAX7evJZgTWzUfa5p+Ju9s2xDIg=;
        b=XhUhG/V5axryGi6dJv0l9iR+eIfrEMEb1v0rE4gbUEJ5JfJblhbjtrI88hSrS5RfFoWVGqv7MpsIjTKEBxAKuyMpBkFhpG/lT08ZsQJZ4pSUU1K4tL9sLNAsfGSOONQTBuzaoGm363AoxRz6z3vzXy4shb067mqgBsz36ITIOyg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:121af5ef-856f-43b4-8a14-14f329613213,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:c8bfbcf3-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: a4a0e0a8b25d11eda06fc9ecc4dadd91-20230222
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 627344900; Wed, 22 Feb 2023 11:04:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Feb 2023 11:04:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 11:04:36 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>, <mason.zhang@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>
Subject: [PATCH v2 0/7] Several UFS MCQ Code Changes
Date:   Wed, 22 Feb 2023 11:04:17 +0800
Message-ID: <20230222030427.957-1-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
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

v1 -> v2:
- Add 2 new patches
	- Update MTK driver for mcq
	- Export symbols for MTK driver
- Fix commit message in "scsi: ufs: core: Fix mcq nr_hw_queues"
- Split name change and fix into two patches

Po-Wen Kao (7):
  scsi: ufs: core: Fix mcq tag calcualtion
  scsi: ufs: core: Rename symbols
  scsi: ufs: core: Fix mcq nr_hw_queues
  scsi: ufs: core: Add hwq print for debug
  scsi: ufs: core: Remove redundant check
  scsi: ufs: core: Export symbols for MTK driver module
  scsi: ufs: mtk-host: Add MCQ support for MTK platform

 drivers/ufs/core/ufs-mcq.c      |  39 ++++++-
 drivers/ufs/core/ufshcd-priv.h  |  11 +-
 drivers/ufs/core/ufshcd.c       |  31 ++---
 drivers/ufs/host/ufs-mediatek.c | 193 +++++++++++++++++++++++++++++++-
 drivers/ufs/host/ufs-mediatek.h |  33 ++++++
 include/ufs/ufshcd.h            |   8 +-
 include/ufs/ufshci.h            |  12 ++
 7 files changed, 306 insertions(+), 21 deletions(-)

-- 
2.18.0

