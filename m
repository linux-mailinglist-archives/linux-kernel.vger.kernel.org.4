Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F645F6025
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJFEfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJFEfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:35:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2A37184
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 21:35:07 -0700 (PDT)
X-UUID: 74a38bc7ba73496c839b6c3651493fa4-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WN5HrWAsPKulMaT697T87yfqxj6TGX8DCcsBqqWfiB4=;
        b=kfEBBN0y9n0bag4NmYhn2kiU09LX2vH+tjT2wjgS4qEj5VIQI6oIGbIOh6iSXKFNkreDf0bm5u7X5+RRXiPlSO/vyl9ZW74LKbwB58Upc5VnJXXl2Z0vuHJGt3fQnl5TKbnicUy8PV7azS8Ue0AygHAL5Jy1pNy6nWMLFkNYWSM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:98289bc5-989a-406f-b8f2-fafac54b7985,IP:0,U
        RL:0,TC:0,Content:51,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-META: VersionHash:39a5ff1,CLOUDID:918265fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 74a38bc7ba73496c839b6c3651493fa4-20221006
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1626822091; Thu, 06 Oct 2022 12:34:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 12:34:58 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 6 Oct 2022 12:34:58 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v9, 0/4] mailbox: mtk-cmdq: add MT8186 support
Date:   Thu, 6 Oct 2022 12:34:52 +0800
Message-ID: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

base linux-next/master

change since v8:
1. move GCE_CTRL_BY_SW modification to the 1st patch
2. add commit message for patch 2 and patch 3

Yongqiang Niu (4):
  mailbox: mtk-cmdq: Use GCE_CTRL_BY_SW definition instead of number
  mailbox: mtk-cmdq: add gce software ddr enable private data
  mailbox: mtk-cmdq: add gce ddr enable support flow
  mailbox: mtk-cmdq: add MT8186 support

 drivers/mailbox/mtk-cmdq-mailbox.c | 42 +++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

-- 
2.25.1

