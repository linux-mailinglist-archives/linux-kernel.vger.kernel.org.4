Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0C6718B9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjARKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjARKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:11:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498119AAAE;
        Wed, 18 Jan 2023 01:18:41 -0800 (PST)
X-UUID: 16a24344971111ed945fc101203acc17-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y17TmDmZzJ4uREjBGg1ymgXuWt+fPVJmNlFq7S8gsaI=;
        b=JqUc7zmCtzD/vPGbPC8bN0ia/rPZ5ZMV16/YPt/FOne0JPSD+SSfQ0cUplFvXcHKnbm3A7OFatZCq1FqrX9joVWYaMDA/7WTWPtJy9RqyI1/A5KNpjijiNL9VEjg062uOpytgXAL/qLDGazUNGTH8AU/tb0WaDSY6Q/eTHA2ex0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:5d469433-d1d7-40ce-9023-6c67b2cb51d9,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.18,REQID:5d469433-d1d7-40ce-9023-6c67b2cb51d9,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:3ca2d6b,CLOUDID:b6379b8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230118171837RC5ZGS7T,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 16a24344971111ed945fc101203acc17-20230118
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1713104730; Wed, 18 Jan 2023 17:18:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 17:18:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 17:18:34 +0800
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
Subject: [PATCH v2 6/9] arm64: dts: mediatek: mt8186: Add audio controller node
Date:   Wed, 18 Jan 2023 17:18:26 +0800
Message-ID: <20230118091829.755-7-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
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

Add audio controller node for MT8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 62 ++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 2700c830316f..c52f9be1e750 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -998,6 +998,68 @@
 			};
 		};
 
+		afe: audio-controller@11210000 {
+			compatible = "mediatek,mt8186-sound";
+			reg = <0 0x11210000 0 0x2000>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_AUDIO>,
+				 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_BCLK>,
+				 <&topckgen CLK_TOP_AUDIO>,
+				 <&topckgen CLK_TOP_AUD_INTBUS>,
+				 <&topckgen CLK_TOP_MAINPLL_D2_D4>,
+				 <&topckgen CLK_TOP_AUD_1>,
+				 <&apmixedsys CLK_APMIXED_APLL1>,
+				 <&topckgen CLK_TOP_AUD_2>,
+				 <&apmixedsys CLK_APMIXED_APLL2>,
+				 <&topckgen CLK_TOP_AUD_ENGEN1>,
+				 <&topckgen CLK_TOP_APLL1_D8>,
+				 <&topckgen CLK_TOP_AUD_ENGEN2>,
+				 <&topckgen CLK_TOP_APLL2_D8>,
+				 <&topckgen CLK_TOP_APLL_I2S0_MCK_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S1_MCK_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S2_MCK_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S4_MCK_SEL>,
+				 <&topckgen CLK_TOP_APLL_TDMOUT_MCK_SEL>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV0>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV1>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV2>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV4>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV_TDMOUT_M>,
+				 <&topckgen CLK_TOP_AUDIO_H>,
+				 <&clk26m>;
+			clock-names = "aud_infra_clk",
+				      "mtkaif_26m_clk",
+				      "top_mux_audio",
+				      "top_mux_audio_int",
+				      "top_mainpll_d2_d4",
+				      "top_mux_aud_1",
+				      "top_apll1_ck",
+				      "top_mux_aud_2",
+				      "top_apll2_ck",
+				      "top_mux_aud_eng1",
+				      "top_apll1_d8",
+				      "top_mux_aud_eng2",
+				      "top_apll2_d8",
+				      "top_i2s0_m_sel",
+				      "top_i2s1_m_sel",
+				      "top_i2s2_m_sel",
+				      "top_i2s4_m_sel",
+				      "top_tdm_m_sel",
+				      "top_apll12_div0",
+				      "top_apll12_div1",
+				      "top_apll12_div2",
+				      "top_apll12_div4",
+				      "top_apll12_div_tdm",
+				      "top_mux_audio_h",
+				      "top_clk26m_clk";
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,apmixedsys = <&apmixedsys>;
+			mediatek,infracfg = <&infracfg_ao>;
+			mediatek,topckgen = <&topckgen>;
+			resets = <&watchdog MT8186_TOPRGU_AUDIO_SW_RST>;
+			reset-names = "audiosys";
+			status = "disabled";
+		};
+
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8186-mmc",
 				     "mediatek,mt8183-mmc";
-- 
2.18.0

