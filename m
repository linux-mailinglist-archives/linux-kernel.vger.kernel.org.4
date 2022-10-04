Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED85F3B72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJDChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDChm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:37:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234F21E3C2;
        Mon,  3 Oct 2022 19:37:36 -0700 (PDT)
X-UUID: bf8df480acd4453eb47ab293ea3632d2-20221004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PM37Djs2MmIM1V0fIhaR9Ne8D5kutQaAtDW0XCW/j+s=;
        b=hYm3XERFYBDN1RKEkVQ/cnZCvLa4OBaKfYWQQuIJRE3kZajk1gwEeimNhCqP0eNDTE1Fm06B2D48E9c1Hm59+l6XETOBcL9o0RRSfaMhcMbXOFvb4ysuCwfOfbf3dd3/TqNAr/6fdpy2Y4phQ3eF/Al2n3P6hfRuFx9z6Iz7Imw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3ab3e7b1-1791-4028-b8df-35221045341f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:3ab3e7b1-1791-4028-b8df-35221045341f,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:4149e007-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:2210041037312RI8J588,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: bf8df480acd4453eb47ab293ea3632d2-20221004
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1182406541; Tue, 04 Oct 2022 10:37:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 4 Oct 2022 10:37:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 4 Oct 2022 10:37:28 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH] media: platform: mtk-mdp3: remove unused VIDEO_MEDIATEK_VPU config
Date:   Tue, 4 Oct 2022 10:37:27 +0800
Message-ID: <20221004023727.28946-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since remoteproc completely replaces the VPU in MDP3, unused config
should be removed to avoid compilation warnings reported on i386 or x86_64.

Warning messages:
    WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
          Depends on [n]: MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y]
        && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] &&
        VIDEO_DEV [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y])
          Selected by [y]:
          - VIDEO_MEDIATEK_MDP3 [=y] && MEDIA_SUPPORT [=y] &&
        MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] &&
        (MTK_IOMMU [=n] || COMPILE_TEST [=y]) && VIDEO_DEV [=y] &&
        (ARCH_MEDIATEK || COMPILE_TEST [=y]) && HAS_DMA [=y] && REMOTEPROC
        [=y]

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/media/platform/mediatek/mdp3/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/Kconfig b/drivers/media/platform/mediatek/mdp3/Kconfig
index 50ae07b75b5f..846e759a8f6a 100644
--- a/drivers/media/platform/mediatek/mdp3/Kconfig
+++ b/drivers/media/platform/mediatek/mdp3/Kconfig
@@ -9,7 +9,6 @@ config VIDEO_MEDIATEK_MDP3
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	select MTK_MMSYS
-	select VIDEO_MEDIATEK_VPU
 	select MTK_CMDQ
 	select MTK_SCP
 	default n
-- 
2.18.0

