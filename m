Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75E668E7C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBHFjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjBHFit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:38:49 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16F442E9;
        Tue,  7 Feb 2023 21:38:41 -0800 (PST)
X-UUID: d5a2e07aa77211eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PyGFaiQpYwvJRNsu5FUdDc+UhFlL928fq4ghNZboUsU=;
        b=LVPmaJCagWVrdUTOIGC0RYk+ilj7TUvv0LTLOQ5F5cdHaS0QPK3ravJoG48806ky59/4SCLWR12DTiAPFUFazEZujMKgkOZlHBUU08KYUuZUuDYpOhWaQAOiUQgwImFe/JrAzCQyLIV49mhUUWWqnAOBD10pctZGs8NkMeTfoAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:c882f954-0690-42ee-b5ba-140a26998967,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:3121cdf7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: d5a2e07aa77211eda06fc9ecc4dadd91-20230208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1396741238; Wed, 08 Feb 2023 13:38:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 13:38:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 13:38:34 +0800
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
        <libo.kang@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v2 08/10] arm64: dts: mt8195: Add dma-ranges for the parent "soc" node
Date:   Wed, 8 Feb 2023 13:36:41 +0800
Message-ID: <20230208053643.28249-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208053643.28249-1-yong.wu@mediatek.com>
References: <20230208053643.28249-1-yong.wu@mediatek.com>
MIME-Version: 1.0
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

After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
controllers"), the dma-ranges property is not allowed for
the leaf node. But our iommu/dma-ranges is 16GB, we still expect
separate the 16GB dma-range like:
a) display is in 0 - 4GB;
b) vcodec is in 4GB - 8GB;
c) camera is in 8GB - 12GB.
We can not expect all the masters add a parent node for them,
especial for the existed drivers/nodes.
Thus, we add whole the 16GB dma-ranges in the parent "soc" node.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8f1264d5290b..0f5a31ca1b70 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -364,6 +364,7 @@
 		#size-cells = <2>;
 		compatible = "simple-bus";
 		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
 
 		gic: interrupt-controller@c000000 {
 			compatible = "arm,gic-v3";
-- 
2.18.0

