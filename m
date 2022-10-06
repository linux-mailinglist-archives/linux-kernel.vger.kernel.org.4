Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142565F6024
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJFEfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJFEfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:35:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE4356D7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 21:35:06 -0700 (PDT)
X-UUID: 612e2e2bd02c417587ff21691b56ca06-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oeUlVgx+QgZwWz9wCjYV71PSLvTf5NrW0pJ9W294SgA=;
        b=SlfHEHHwaCAPwhYdq4R97XUehV+hyssq9Bj/yxW6tGK6Y/ZCrwlg8pPl1IaACNrFnsXveEcI91Pkr08xG+20Ws2TqtqJ/HG6R/fYadivcv+g9YgnlRPtvfa3wbu+dC3+TMDo00Qr2bNdh9CjqL5kRr/tz28UGmX6rGrY/8fYbHM=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.11,REQID:95c7bd7b-3c55-4af7-9fe9-c410187a24a6,IP:0,U
        RL:0,TC:0,Content:59,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:159
X-CID-INFO: VERSION:1.1.11,REQID:95c7bd7b-3c55-4af7-9fe9-c410187a24a6,IP:0,URL
        :0,TC:0,Content:59,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_US65DF41,ACTI
        ON:quarantine,TS:159
X-CID-META: VersionHash:39a5ff1,CLOUDID:948265fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:221006123502A2191ENS,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824|801,TC:nil,Content:3,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:
        nil,COL:0
X-UUID: 612e2e2bd02c417587ff21691b56ca06-20221006
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1139609805; Thu, 06 Oct 2022 12:35:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 6 Oct 2022 12:34:59 +0800
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
Subject: [PATCH v9, 1/4] mailbox: mtk-cmdq: Use GCE_CTRL_BY_SW definition instead of number
Date:   Thu, 6 Oct 2022 12:34:53 +0800
Message-ID: <20221006043456.8754-2-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
References: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GCE_CTRL_BY_SW definition instead of number

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 9465f9081515..c3cb24f51699 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -38,6 +38,7 @@
 #define CMDQ_THR_PRIORITY		0x40
 
 #define GCE_GCTL_VALUE			0x48
+#define GCE_CTRL_BY_SW				GENMASK(2, 0)
 
 #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
 #define CMDQ_THR_ENABLED		0x1
@@ -129,7 +130,8 @@ static void cmdq_init(struct cmdq *cmdq)
 
 	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
 	if (cmdq->control_by_sw)
-		writel(0x7, cmdq->base + GCE_GCTL_VALUE);
+		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
+
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
 		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
-- 
2.25.1

