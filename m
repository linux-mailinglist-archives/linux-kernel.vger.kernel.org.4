Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEB70DB70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjEWL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjEWL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:26:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B85FF;
        Tue, 23 May 2023 04:26:27 -0700 (PDT)
X-UUID: a4e5092cf95c11edb20a276fd37b9834-20230523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Lvk3JaTrwPLSWWOaMLoAICxAPDtCTseef/dYBEf8duA=;
        b=FXAaU5RGXzQ2kOenbv8WN45X6C1EVfjzi2hGrA6cTe8njHl1SKRbSJRI/4Nu42Vk4Fm4vSmaGY47sLqI4Uu+rX5kWIydghPvRWVnUBlLY6LbqPku/yeJOqnQnKPmUlu+pgZm/Ucj+3nG5P1JCAdr37zmL8iwAez33WWJdaEscBc=;
X-CID-CACHE: Type:Local,Time:202305231926+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:9dd24f03-b5bc-4808-80c7-e440b5220667,IP:0,U
        RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-35
X-CID-META: VersionHash:d5b0ae3,CLOUDID:9119c5c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a4e5092cf95c11edb20a276fd37b9834-20230523
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1094335045; Tue, 23 May 2023 19:26:21 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 19:26:17 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 May 2023 19:26:17 +0800
From:   <qii.wang@mediatek.com>
To:     <broonie@kernel.org>
CC:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, "Tim . Kuo" <Tim.kuo@mediatek.com>
Subject: [PATCH] spi: mediatek: advertise the availability of Dual and Quad mode
Date:   Tue, 23 May 2023 19:26:08 +0800
Message-ID: <20230523112608.10298-1-qii.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

From: Qii Wang <qii.wang@mediatek.com>

this patch advertise the availability of Dual and Quad SPI mode
for ipm design.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
Signed-off-by: Tim.Kuo <Tim.kuo@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 21c321f43766..1501ee8459ff 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1144,7 +1144,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (mdata->dev_comp->must_tx)
 		master->flags = SPI_MASTER_MUST_TX;
 	if (mdata->dev_comp->ipm_design)
-		master->mode_bits |= SPI_LOOP;
+		master->mode_bits |= SPI_LOOP | SPI_RX_DUAL | SPI_TX_DUAL |
+				     SPI_RX_QUAD | SPI_TX_QUAD;
 
 	if (mdata->dev_comp->ipm_design) {
 		mdata->dev = dev;
-- 
2.25.1

