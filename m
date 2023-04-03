Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57396D3FDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDCJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjDCJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:14:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C587692;
        Mon,  3 Apr 2023 02:14:35 -0700 (PDT)
X-UUID: f0931ec4d1ff11edb6b9f13eb10bd0fe-20230403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XNsNsqm+tac4TqBDM7eY2YSHOJMel3hNuiOtLlMEMKY=;
        b=mkQlX/5IRAaRrjuWEmfWaio5jeYZRgi0N/Cx1prgGHrgjUHn0PIeA0pTGljMYD6F8C04T0shGhuKTmOEFsxxO3C+B15+GQXtP8Fq9k9QBqAR9dFmLtU3dok7DMtWN+1bPO95e9HnAOEslytJaSIr1vh1XltGE+k2Z4MpTmjDx0I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:f5891834-5ce0-4ad0-ac79-bb532c8f56e4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:f5891834-5ce0-4ad0-ac79-bb532c8f56e4,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:5597b1f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230403171432W80VIW0I,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: f0931ec4d1ff11edb6b9f13eb10bd0fe-20230403
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1044971192; Mon, 03 Apr 2023 17:14:30 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 3 Apr 2023 17:14:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 3 Apr 2023 17:14:27 +0800
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
Subject: [PATCH v6 03/14] iommu/mediatek: Improve comment for the current region/bank
Date:   Mon, 3 Apr 2023 17:13:26 +0800
Message-ID: <20230403091337.26745-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403091337.26745-1-yong.wu@mediatek.com>
References: <20230403091337.26745-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
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

