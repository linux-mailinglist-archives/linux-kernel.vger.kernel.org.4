Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B723264DACF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLOMBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLOMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:00:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB92A95F;
        Thu, 15 Dec 2022 04:00:31 -0800 (PST)
X-UUID: 0a16a4efc1764ac6a4620304fbafbe30-20221215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FxQw7bHLyA5vKeEmlF/GvXF0yb0AjLvtCurZOZUuMoM=;
        b=nx+NOYZciDWe4I3Rv3GJE54p3oJ2nBUhK3vRbCHaQ8Q5coVSuvD9gBn8Ujzp3XgC3qwiz49BnEVlbytMgsU7rRObOKkwcOzaFF0VOkbXeQjd3L4Z9dNbpHPVm4FMT24kjDLiJXMbVTP6lv6UkEM34ISjOI7sy391HKMH7JgpeZM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:5899478d-19cd-48ef-a7b9-bc0734f5b9c1,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:5899478d-19cd-48ef-a7b9-bc0734f5b9c1,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:60725635-a6a3-44f7-8aad-08fee1939a08,B
        ulkID:221215200023XLXFLJZU,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0a16a4efc1764ac6a4620304fbafbe30-20221215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1892519801; Thu, 15 Dec 2022 20:00:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 15 Dec 2022 20:00:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Dec 2022 20:00:19 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        "Stephen Boyd" <sboyd@kernel.org>, Ikjoon Jang <ikjn@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 2/4] soc: mediatek: pm-domains: Add ADSP power domain data for MT8192
Date:   Thu, 15 Dec 2022 20:00:14 +0800
Message-ID: <20221215120016.26611-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
References: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
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

Add ADSP pm-domains (mtcmos) data for MT8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 drivers/soc/mediatek/mt8192-pm-domains.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
index b97b2051920f..19e58f0ca1df 100644
--- a/drivers/soc/mediatek/mt8192-pm-domains.h
+++ b/drivers/soc/mediatek/mt8192-pm-domains.h
@@ -287,6 +287,22 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
+	[MT8192_POWER_DOMAIN_ADSP] = {
+		.name = "adsp",
+		.sta_mask = BIT(22),
+		.ctl_offs = 0x0358,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.ext_buck_iso_offs = 0x039C,
+		.ext_buck_iso_mask = BIT(2),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_ADSP,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+		},
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_EXT_BUCK_ISO,
+	},
 	[MT8192_POWER_DOMAIN_CAM] = {
 		.name = "cam",
 		.sta_mask = BIT(23),
-- 
2.18.0

