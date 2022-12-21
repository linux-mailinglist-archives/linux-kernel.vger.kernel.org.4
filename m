Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648D9652BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiLUDon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiLUDo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:44:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C151EC48;
        Tue, 20 Dec 2022 19:44:21 -0800 (PST)
X-UUID: f583dd13bece4a8997b7ded1560c77f3-20221221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FxQw7bHLyA5vKeEmlF/GvXF0yb0AjLvtCurZOZUuMoM=;
        b=KK1ydztxHUjVY4ugvuUZGUXIS+MMCP9KR7Diy67C0LcVTnY6bq6xfy9ppZYBxOteJIAAhux953f8rmJq5fnxCo2iykCr/x2YBzOWQwt5VHAgAFvYTI04GTY7fVOvF9fa4YSn4BXtbSXVIXSZC0B1v4j4fgjwDwR4DT3ZBH8er9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:e9ccb55f-89fe-4435-9def-32335d8494fb,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:039ef489-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f583dd13bece4a8997b7ded1560c77f3-20221221
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 632725121; Wed, 21 Dec 2022 11:44:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 21 Dec 2022 11:44:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 21 Dec 2022 11:44:12 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 4/6] soc: mediatek: pm-domains: Add ADSP power domain data for MT8192
Date:   Wed, 21 Dec 2022 11:44:05 +0800
Message-ID: <20221221034407.19605-5-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
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

