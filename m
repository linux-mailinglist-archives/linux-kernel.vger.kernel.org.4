Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562DA6E5C43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjDRIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjDRIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:37:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8876A0;
        Tue, 18 Apr 2023 01:36:56 -0700 (PDT)
X-UUID: 264099faddc411eda9a90f0bb45854f4-20230418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Z3KYhpR7iezgc+p/HsJAhbAKno3UBwH6W6pY8rrBZwg=;
        b=JQV+wPXyRPxYrLTZS7CWkB76/By23pMKQ3y1ketgVvMgHHrnlUVG4aC5IAj2fjvzPofcVp+bN3KLtJP/2i79naE1imp6KSRC1d4OI+fWxgSWW2lvPeQE0dGvrfIMVyxmpTXiGaZ8z8/UmP3coIDfDQ5RbxqPo4g8czuibhkHxBg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:07e13ed3-1480-4ff3-b73a-8724f88c699e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:07e13ed3-1480-4ff3-b73a-8724f88c699e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:970058eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230418163646A7UGOZ7M,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 264099faddc411eda9a90f0bb45854f4-20230418
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1390489620; Tue, 18 Apr 2023 16:36:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 18 Apr 2023 16:36:43 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 18 Apr 2023 16:36:42 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <jianjiao.zeng@mediatek.com>,
        <chengci.xu@mediatek.com>
Subject: [PATCH v11 7/7] MAINTAINERS: iommu/mediatek: Update the header file name
Date:   Tue, 18 Apr 2023 16:35:14 +0800
Message-ID: <20230418083514.4379-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418083514.4379-1-yong.wu@mediatek.com>
References: <20230418083514.4379-1-yong.wu@mediatek.com>
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

We add the prefix "mediatek," for the lastest ports header file name,
For example, include/dt-bindings/memory/mediatek,mt8188-memory-port.h.
Add a new entry for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8ebab595b2a..fdab5d6d51b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13056,6 +13056,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/iommu/mediatek*
 F:	drivers/iommu/mtk_iommu*
+F:	include/dt-bindings/memory/mediatek,mt*-port.h
 F:	include/dt-bindings/memory/mt*-port.h
 
 MEDIATEK JPEG DRIVER
-- 
2.25.1

