Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB9E665B89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjAKMhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjAKMhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:37:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E6658A;
        Wed, 11 Jan 2023 04:37:21 -0800 (PST)
X-UUID: ae8e3d7691ac11ed945fc101203acc17-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/qs5AP02dhkCWqdSuirwOLn7ESeQZZWhOOpRZScjecQ=;
        b=na3MEbNFBY/winbUnT2Xem7DQi9zQDLZhzCXY4RhYNEry3wjJVO8x8N+kW4GX2A3q9AFdvMBYSQLU7dgwvQKhUoIIE+nIpaODqUnZFsnl7i/NiCkqBXwK9BYxhZmUYmJe2Orq0PgSmXaDN02B3mSkyWF/2bz1Q7mQvHmtYzUISE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:0e39f8e8-c6cc-4e29-b1ec-d6afad077754,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.17,REQID:0e39f8e8-c6cc-4e29-b1ec-d6afad077754,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:543e81c,CLOUDID:d22285f5-ff42-4fb0-b929-626456a83c14,B
        ulkID:2301112037166JRN7V5M,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: ae8e3d7691ac11ed945fc101203acc17-20230111
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1796133815; Wed, 11 Jan 2023 20:37:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 11 Jan 2023 20:37:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 20:37:16 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 3/9] arm64: dts: mediatek: mt8186: Add SPMI node
Date:   Wed, 11 Jan 2023 20:37:05 +0800
Message-ID: <20230111123711.32020-4-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230111123711.32020-1-allen-kh.cheng@mediatek.com>
References: <20230111123711.32020-1-allen-kh.cheng@mediatek.com>
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

Add SPMI node for MT8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 3d88480913eb..a8ff984f1192 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -605,6 +605,25 @@
 			clock-names = "spi", "wrap";
 		};
 
+		spmi: spmi@10015000 {
+			compatible = "mediatek,mt8186-spmi",
+				     "mediatek,mt8195-spmi";
+			reg = <0 0x10015000 0 0x000e00>,
+			      <0 0x1001B000 0 0x000100>;
+			reg-names = "pmif", "spmimst";
+			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
+				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>,
+				 <&topckgen CLK_TOP_SPMI_MST>;
+			clock-names = "pmif_sys_ck",
+				      "pmif_tmr_ck",
+				      "spmimst_clk_mux";
+			assigned-clocks = <&topckgen CLK_TOP_SPMI_MST>;
+			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8186-timer",
 				     "mediatek,mt6765-timer";
-- 
2.18.0

