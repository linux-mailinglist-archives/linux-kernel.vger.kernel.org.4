Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB863FF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiLBDpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiLBDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:45:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5002C83E95;
        Thu,  1 Dec 2022 19:45:03 -0800 (PST)
X-UUID: 5faab9270cae4b65a0ef67ffb4583539-20221202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VCzoXxASQ6qGnA6F6VYifoo4ULC7Kk/0LQh8ibSLUMk=;
        b=KogGqveBfRmDHCBUfCY5XzffsbOMYJyXo8tfO0vIdJv7vRnH2tKn+fc/+0cfkHus5gk+pr+b9Arle+TBaoGy007XaHZuEyH2a+oz6z2w3402xwprAhHnPjYjOVvd+FQrvAbpAC1XhH34hR/s6wn87dENqgxfNSox03wshm5VmHI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:2c61340c-da04-4e25-a1db-7147b45226e7,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:909e566c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5faab9270cae4b65a0ef67ffb4583539-20221202
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 849256478; Fri, 02 Dec 2022 11:44:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 2 Dec 2022 11:44:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 2 Dec 2022 11:44:54 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4,3/3] arm64: dts: mt8195: Add video decoder node
Date:   Fri, 2 Dec 2022 11:44:50 +0800
Message-ID: <20221202034450.3808-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202034450.3808-1-yunfei.dong@mediatek.com>
References: <20221202034450.3808-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add video decoder node to mt8195 device tree.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 905d1a90b406..6829aa0dcf4c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1874,6 +1874,76 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
 		};
 
+		video-codec@18000000 {
+			compatible = "mediatek,mt8195-vcodec-dec";
+			mediatek,scp = <&scp>;
+			iommus = <&iommu_vdo M4U_PORT_L21_VDEC_MC_EXT>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			reg = <0 0x18000000 0 0x1000>,
+			      <0 0x18004000 0 0x1000>;
+			ranges = <0 0 0 0x18000000 0 0x26000>;
+
+			video-codec@2000 {
+				compatible = "mediatek,mtk-vcodec-lat-soc";
+				reg = <0 0x2000 0 0x800>;
+				iommus = <&iommu_vpp M4U_PORT_L23_VDEC_UFO_ENC_EXT>,
+					 <&iommu_vpp M4U_PORT_L23_VDEC_RDMA_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC>,
+					 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+					 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+					 <&topckgen CLK_TOP_UNIVPLL_D4>;
+				clock-names = "sel", "vdec", "lat", "top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+			};
+
+			video-codec@10000 {
+				compatible = "mediatek,mtk-vcodec-lat";
+				reg = <0 0x10000 0 0x800>;
+				interrupts = <GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH 0>;
+				iommus = <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_VLD_EXT>,
+					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_VLD2_EXT>,
+					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_AVC_MC_EXT>,
+					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_PRED_RD_EXT>,
+					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_TILE_EXT>,
+					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_WDMA_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC>,
+					 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+					 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+					 <&topckgen CLK_TOP_UNIVPLL_D4>;
+				clock-names = "sel", "vdec", "lat", "top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+			};
+
+			video-codec@25000 {
+				compatible = "mediatek,mtk-vcodec-core";
+				reg = <0 0x25000 0 0x1000>;		/* VDEC_CORE_MISC */
+				interrupts = <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH 0>;
+				iommus = <&iommu_vdo M4U_PORT_L21_VDEC_MC_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_UFO_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_PP_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_PRED_RD_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_PRED_WR_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_PPWRAP_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_TILE_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_VLD_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_VLD2_EXT>,
+					 <&iommu_vdo M4U_PORT_L21_VDEC_AVC_MV_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC>,
+					 <&vdecsys CLK_VDEC_VDEC>,
+					 <&vdecsys CLK_VDEC_LAT>,
+					 <&topckgen CLK_TOP_UNIVPLL_D4>;
+				clock-names = "sel", "vdec", "lat", "top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+			};
+		};
+
 		larb24: larb@1800d000 {
 			compatible = "mediatek,mt8195-smi-larb";
 			reg = <0 0x1800d000 0 0x1000>;
-- 
2.18.0

