Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B072F2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbjFNDUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjFNDUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:20:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269AB196
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:20:47 -0700 (PDT)
X-UUID: 7156041e0a6211eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1/s8AXfgIYanEpx23IMghmlP5JEa40ydHjcG277YD10=;
        b=uGOAruZ8HaqxCp6/ZcLTXK5wljWDVF0MOX+0V3xy2GQ61CpJFCkwNVzfzjpqYznFDsUL5OStpCYxiuhKvOMRB3icBxDzPf44unTnTIJeKGKnbuArwVyen/MOoaRKYU2qJcsKtBG29V/L/zcSZmUkCN+aUPI1Yz6bb5S0spzTM3o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b02c0a7b-3e86-413a-a7b5-4346422a784c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:cb9a4e1,CLOUDID:19c45a3e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7156041e0a6211eeb20a276fd37b9834-20230614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 753357967; Wed, 14 Jun 2023 11:20:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 11:20:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 11:20:40 +0800
From:   Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <wei-chin.tsai@mediatek.com>,
        <mel.lee@mediatek.com>, <ivan.tseng@mediatek.com>,
        Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/3] export symbols for process and memory related functions
Date:   Wed, 14 Jun 2023 11:20:32 +0800
Message-ID: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v1 -> v2: Add export symbol for "smap_gather_stats" and "arch_vma_name".
	  Modify the mbraink_main.c class and device register flow.

v1:       Export symbol for "sched_process_fork" and "sched_process_exit".
          attached the mediatek_mbraink data collect driver which uses
          these export symbols. 

Wei Chin Tsai (3):
  kernel : process fork/exit: export symbol for fork/exit tracing
    functions
  memory: export symbols for memory related functions
  misc : mediatek_mbraink : Collect the system process and memory data

 arch/arm/kernel/process.c                     |   1 +
 drivers/misc/mediatek_mbraink/Kconfig         |  15 +
 drivers/misc/mediatek_mbraink/Makefile        |   5 +
 drivers/misc/mediatek_mbraink/mbraink_data.c  | 417 ++++++++++++++++++
 drivers/misc/mediatek_mbraink/mbraink_data.h  |  66 +++
 .../mbraink_ioctl_struct_define.h             |  44 ++
 drivers/misc/mediatek_mbraink/mbraink_main.c  | 239 ++++++++++
 drivers/misc/mediatek_mbraink/mbraink_main.h  |  36 ++
 fs/proc/task_mmu.c                            |   5 +-
 kernel/exit.c                                 |   2 +
 kernel/fork.c                                 |   2 +
 kernel/signal.c                               |   1 +
 12 files changed, 831 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/mediatek_mbraink/Kconfig
 create mode 100644 drivers/misc/mediatek_mbraink/Makefile
 create mode 100644 drivers/misc/mediatek_mbraink/mbraink_data.c
 create mode 100644 drivers/misc/mediatek_mbraink/mbraink_data.h
 create mode 100644 drivers/misc/mediatek_mbraink/mbraink_ioctl_struct_define.h
 create mode 100644 drivers/misc/mediatek_mbraink/mbraink_main.c
 create mode 100644 drivers/misc/mediatek_mbraink/mbraink_main.h

-- 
2.18.0

