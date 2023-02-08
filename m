Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C068EB4F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjBHJZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBHJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:24:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66974670B;
        Wed,  8 Feb 2023 01:22:20 -0800 (PST)
X-UUID: 11a9de1aa79211eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=36B6VWd/Dngl55WokMdl1KV+2n0caKFJHAg4r5STBew=;
        b=fm7WsKgOtiKwhPbpUs/uUUIkMPqLL2jMHcd/TG6DRbfWm1PwhffOJlVWVvOw//vQ9I5HekHHcIFMiE3Ve0MGcElnJydXHrsoJYEy8AFUO0HFsvPypIHcqna3BYfTEklmS044HCNjue73iljdYZycC+u1lRfohjN6cpO622gXRNc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:d1237edc-a5bf-4964-825d-d0919dcc80bc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:7e85458e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 11a9de1aa79211eda06fc9ecc4dadd91-20230208
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1256575190; Wed, 08 Feb 2023 17:22:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Feb 2023 17:22:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:22:10 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v4 04/16] arm64: dts: mediatek: mt8195: add MDP3 nodes
Date:   Wed, 8 Feb 2023 17:21:57 +0800
Message-ID: <20230208092209.19472-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208092209.19472-1-moudy.ho@mediatek.com>
References: <20230208092209.19472-1-moudy.ho@mediatek.com>
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

Add device nodes for Media Data Path 3 (MDP3) modules.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 426 +++++++++++++++++++++++
 1 file changed, 426 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8fc527570791..0aa7f140897b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1801,6 +1801,135 @@
 			#clock-cells = <1>;
 		};
 
+		dma-controller@14001000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14001000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x1000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP0_MDP_RDMA_FRAME_DONE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>,
+					<&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			iommus = <&iommu_vpp M4U_PORT_L4_MDP_RDMA>,
+				 <&iommu_vpp M4U_PORT_L4_MDP_WROT>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_RDMA>,
+				 <&topckgen CLK_TOP_CFG_VPP0>,
+				 <&topckgen CLK_TOP_CFG_26M_VPP0>,
+				 <&vppsys0 CLK_VPP0_WARP0_ASYNC_TX>,
+				 <&vppsys0 CLK_VPP0_WARP0_RELAY>,
+				 <&vppsys0 CLK_VPP0_WARP0_MDP_DL_ASYNC>,
+				 <&vppsys0 CLK_VPP0_WARP1_ASYNC_TX>,
+				 <&vppsys0 CLK_VPP0_WARP1_RELAY>,
+				 <&vppsys0 CLK_VPP0_WARP1_MDP_DL_ASYNC>,
+				 <&vppsys0 CLK_VPP0_VPP02VPP1_RELAY>,
+				 <&vppsys1 CLK_VPP1_DL_ASYNC>,
+				 <&vppsys1 CLK_VPP1_VPP0_DL_ASYNC>,
+				 <&vppsys1 CLK_VPP1_VPP0_DL_RELAY>,
+				 <&vppsys0 CLK_VPP0_VPP12VPP0_ASYNC>,
+				 <&vppsys1 CLK_VPP1_VPP0_DL1_RELAY>,
+				 <&vppsys1 CLK_VPP1_SVPP2_VDO0_DL_RELAY>,
+				 <&vppsys1 CLK_VPP1_SVPP3_VDO1_DL_RELAY>,
+				 <&vppsys1 CLK_VPP1_SVPP2_VDO1_DL_RELAY>,
+				 <&vppsys1 CLK_VPP1_SVPP3_VDO0_DL_RELAY>;
+			mboxes = <&gce1 12 CMDQ_THR_PRIO_1>,
+				 <&gce1 13 CMDQ_THR_PRIO_1>,
+				 <&gce1 14 CMDQ_THR_PRIO_1>,
+				 <&gce1 21 CMDQ_THR_PRIO_1>,
+				 <&gce1 22 CMDQ_THR_PRIO_1>;
+			#dma-cells = <1>;
+		};
+
+		display@14002000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14002000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x2000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_FG>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14003000 {
+			compatible = "mediatek,mt8195-mdp3-stitch";
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x3000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_STITCH>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14004000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14004000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x4000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_HDR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14005000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14005000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x5000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14006000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14006000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x6000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_RSZ>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14007000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14007000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x7000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_TDSHP>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14008000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14008000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x8000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@14009000 {
+			compatible = "mediatek,mt8195-mdp3-ovl";
+			reg = <0 0x14009000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x9000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_OVL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@1400a000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x1400a000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xa000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_PADDING>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		display@1400b000 {
+			compatible = "mediatek,mt8195-mdp3-tcc";
+			reg = <0 0x1400b000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xb000 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_TCC>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		dma-controller@1400c000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x1400c000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0xc000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_WROT_SOF>,
+					      <CMDQ_EVENT_VPP0_MDP_WROT_VIDO_WDONE>;
+			clocks = <&vppsys0 CLK_VPP0_MDP_WROT>;
+			iommus = <&iommu_vpp M4U_PORT_L4_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+			#dma-cells = <1>;
+		};
+
 		mutex@1400f000 {
 			compatible = "mediatek,mt8195-vpp-mutex";
 			reg = <0 0x1400f000 0 0x1000>;
@@ -1948,6 +2077,303 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
 		};
 
+		display@14f06000 {
+			compatible = "mediatek,mt8195-mdp3-split";
+			reg = <0 0x14f06000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x6000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_VPP_SPLIT>,
+				 <&vppsys1 CLK_VPP1_HDMI_META>,
+				 <&vppsys1 CLK_VPP1_VPP_SPLIT_HDMI>,
+				 <&vppsys1 CLK_VPP1_DGI_IN>,
+				 <&vppsys1 CLK_VPP1_DGI_OUT>,
+				 <&vppsys1 CLK_VPP1_VPP_SPLIT_DGI>,
+				 <&vppsys1 CLK_VPP1_VPP_SPLIT_26M>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f07000 {
+			compatible = "mediatek,mt8195-mdp3-tcc";
+			reg = <0 0x14f07000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x7000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_TCC>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		dma-controller@14f08000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14f08000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x8000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP1_MDP_RDMA_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_RDMA>,
+				 <&topckgen CLK_TOP_CFG_VPP1>,
+				 <&topckgen CLK_TOP_CFG_26M_VPP1>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_RDMA>,
+				 <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f09000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14f09000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0x9000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP2_MDP_RDMA_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_RDMA>,
+				 <&topckgen CLK_TOP_CFG_VPP1>,
+				 <&topckgen CLK_TOP_CFG_26M_VPP1>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP2_MDP_RDMA>,
+				 <&iommu_vdo M4U_PORT_L5_SVPP2_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f0a000 {
+			compatible = "mediatek,mt8195-mdp3-rdma";
+			reg = <0 0x14f0a000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xa000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_RDMA_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP3_MDP_RDMA_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_RDMA>,
+				 <&topckgen CLK_TOP_CFG_VPP1>,
+				 <&topckgen CLK_TOP_CFG_26M_VPP1>;
+			iommus = <&iommu_vpp M4U_PORT_L6_SVPP3_MDP_RDMA>,
+				 <&iommu_vpp M4U_PORT_L6_SVPP3_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		display@14f0b000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14f0b000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xb000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_FG>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f0c000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14f0c000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xc000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_FG>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f0d000 {
+			compatible = "mediatek,mt8195-mdp3-fg";
+			reg = <0 0x14f0d000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xd000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_FG>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f0e000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14f0e000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xe000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_HDR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f0f000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14f0f000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0xf000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_HDR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f10000 {
+			compatible = "mediatek,mt8195-mdp3-hdr";
+			reg = <0 0x14f10000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_HDR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f11000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14f11000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x1000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f12000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14f12000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x2000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f13000 {
+			compatible = "mediatek,mt8195-mdp3-aal";
+			reg = <0 0x14f13000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x3000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_AAL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f14000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14f14000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x4000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_RSZ>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f15000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14f15000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x5000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_RSZ>,
+				 <&vppsys1 CLK_VPP1_SVPP2_VPP_MERGE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f16000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			reg = <0 0x14f16000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x6000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_RSZ>,
+				 <&vppsys1 CLK_VPP1_SVPP3_VPP_MERGE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f17000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14f17000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x7000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_TDSHP>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f18000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14f18000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x8000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_TDSHP>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f19000 {
+			compatible = "mediatek,mt8195-mdp3-tdshp";
+			reg = <0 0x14f19000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0x9000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_TDSHP>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1a000 {
+			compatible = "mediatek,mt8195-mdp3-merge";
+			reg = <0 0x14f1a000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xa000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_MERGE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1b000 {
+			compatible = "mediatek,mt8195-mdp3-merge";
+			reg = <0 0x14f1b000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xb000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_VPP_MERGE>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1c000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14f1c000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xc000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1d000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14f1d000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xd000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1e000 {
+			compatible = "mediatek,mt8195-mdp3-color";
+			reg = <0 0x14f1e000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xe000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_COLOR>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f1f000 {
+			compatible = "mediatek,mt8195-mdp3-ovl";
+			reg = <0 0x14f1f000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f1XXXX 0xf000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_OVL>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f20000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x14f20000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_VPP_PAD>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f21000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x14f21000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x1000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_VPP_PAD>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		display@14f22000 {
+			compatible = "mediatek,mt8195-mdp3-pad";
+			reg = <0 0x14f22000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x2000 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_VPP_PAD>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		dma-controller@14f23000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x14f23000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x3000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP1_MDP_WROT_SOF>,
+					      <CMDQ_EVENT_VPP1_SVPP1_MDP_WROT_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP1_MDP_WROT>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP1_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f24000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x14f24000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x4000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP2_MDP_WROT_SOF>,
+					<CMDQ_EVENT_VPP1_SVPP2_MDP_WROT_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP2_MDP_WROT>;
+			iommus = <&iommu_vdo M4U_PORT_L5_SVPP2_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
+		dma-controller@14f25000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			reg = <0 0x14f25000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f2XXXX 0x5000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VPP1_SVPP3_MDP_WROT_SOF>,
+					<CMDQ_EVENT_VPP1_SVPP3_MDP_WROT_FRAME_DONE>;
+			clocks = <&vppsys1 CLK_VPP1_SVPP3_MDP_WROT>;
+			iommus = <&iommu_vpp M4U_PORT_L6_SVPP3_MDP_WROT>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+			#dma-cells = <1>;
+		};
+
 		imgsys: clock-controller@15000000 {
 			compatible = "mediatek,mt8195-imgsys";
 			reg = <0 0x15000000 0 0x1000>;
-- 
2.18.0

