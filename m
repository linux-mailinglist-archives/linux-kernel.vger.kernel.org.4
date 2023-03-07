Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F06AD4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCGCgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCGCgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:36:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDF360B4;
        Mon,  6 Mar 2023 18:36:21 -0800 (PST)
X-UUID: d54e1c74bc9011ed945fc101203acc17-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XNsNsqm+tac4TqBDM7eY2YSHOJMel3hNuiOtLlMEMKY=;
        b=eF94pGKlpfUnCLQ0/hcIM69hmO5NHdYiHRndX6QtivTxoONDa0WqC4xcxphRuJ4zXx/aPAMgpNpe032tuNQcXjqBEPdnGCWQ9cP1grSrY+G9f2XCt+s7RTlwx/NZCW/Yygf6lTJ1VLMbJGIFE7xqMDEZiuW7F9BxrLhZjVP9bU0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:c5670c87-f1c3-4df4-b32e-d9c88ee98ee4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.20,REQID:c5670c87-f1c3-4df4-b32e-d9c88ee98ee4,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:25b5999,CLOUDID:1b7969b2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230307103617MJZV16F3,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: d54e1c74bc9011ed945fc101203acc17-20230307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1828845615; Tue, 07 Mar 2023 10:36:15 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 10:36:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 10:36:13 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, <nfraprado@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <jianjiao.zeng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v5 03/11] iommu/mediatek: Improve comment for the current region/bank
Date:   Tue, 7 Mar 2023 10:34:59 +0800
Message-ID: <20230307023507.13306-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307023507.13306-1-yong.wu@mediatek.com>
References: <20230307023507.13306-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Just add more comment about the current region/bank
in the code.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d5a4955910ff..aa4bdcb65ea7 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -197,12 +197,33 @@ struct mtk_iommu_plat_data {
 
 	char			*pericfg_comp_str;
 	struct list_head	*hw_list;
-	unsigned int		iova_region_nr;
-	const struct mtk_iommu_iova_region	*iova_region;
 
-	u8                  banks_num;
-	bool                banks_enable[MTK_IOMMU_BANK_MAX];
-	unsigned int        banks_portmsk[MTK_IOMMU_BANK_MAX];
+	/*
+	 * The IOMMU HW may support 16GB iova. In order to balance the IOVA ranges,
+	 * different masters will be put in different iova ranges, for example vcodec
+	 * is in 4G-8G and cam is in 8G-12G. Meanwhile, some masters may have the
+	 * special IOVA range requirement, like CCU can only support the address
+	 * 0x40000000-0x44000000.
+	 * Here list the iova ranges this SoC supports and which larbs/ports are in
+	 * which region.
+	 *
+	 * 16GB iova all use one pgtable, but each a region is a iommu group.
+	 */
+	struct {
+		unsigned int	iova_region_nr;
+		const struct mtk_iommu_iova_region	*iova_region;
+	};
+
+	/*
+	 * The IOMMU HW may have 5 banks. Each bank has a independent pgtable.
+	 * Here list how many banks this SoC supports/enables and which ports are in which bank.
+	 */
+	struct {
+		u8		banks_num;
+		bool		banks_enable[MTK_IOMMU_BANK_MAX];
+		unsigned int	banks_portmsk[MTK_IOMMU_BANK_MAX];
+	};
+
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
-- 
2.25.1

