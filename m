Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BEE6BE112
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCQGJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCQGJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:09:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D154DBF0;
        Thu, 16 Mar 2023 23:09:29 -0700 (PDT)
X-UUID: 441da61ec48a11edbd2e61cc88cc8f98-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DoDZEvcJe6SCsiv7wUVBoObkJh/dH0y2SlsmhsC2mlo=;
        b=BQiOX3u7NpCHDcwi2hPfatZr4bCKNh3M2V7rsxO8JS5w0lQICJ2S8gPlfyM2gnlscPgBHtpSR3t5NWtXfYssboV+qqFxpwR/IvK/DwfmpMuUKyTVOYcxFGOXJmu+p0Gl0zqJobrgIBZandzAoLC+Qm/MbNMd9q666ItX7T5zNBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:931aba75-0550-4be8-8544-d67e2ec87571,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:db4a16f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 441da61ec48a11edbd2e61cc88cc8f98-20230317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2080938058; Fri, 17 Mar 2023 14:09:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 14:09:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 14:09:23 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v4 7/7] arm64: dts: mediatek: mt8186: Add display nodes
Date:   Fri, 17 Mar 2023 14:09:17 +0800
Message-ID: <20230317060917.15175-8-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230317060917.15175-1-allen-kh.cheng@mediatek.com>
References: <20230317060917.15175-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
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

Add display nodes and the GCE (Global Command Engine) properties
to the display nodes in order to enable the usage of the CMDQ
(Command Queue), which is required for operating the display.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 125 +++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index b9d5af26771e..29fb970e174e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -20,6 +20,13 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		ovl0 = &ovl0;
+		ovl_2l0 = &ovl_2l0;
+		rdma0 = &rdma0;
+		rdma1 = &rdma1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1251,6 +1258,20 @@
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
+				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
+		};
+
+		mutex: mutex@14001000 {
+			compatible = "mediatek,mt8186-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+			interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
+					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
 		};
 
 		smi_common: smi@14002000 {
@@ -1284,6 +1305,49 @@
 			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
 		};
 
+		ovl0: ovl@14005000 {
+			compatible = "mediatek,mt8186-disp-ovl",
+				     "mediatek,mt8192-disp-ovl";
+			reg = <0 0x14005000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_OVL0>;
+			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&iommu_mm IOMMU_PORT_L0_OVL_RDMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		ovl_2l0: ovl@14006000 {
+			compatible = "mediatek,mt8186-disp-ovl-2l",
+				     "mediatek,mt8192-disp-ovl-2l";
+			reg = <0 0x14006000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
+			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&iommu_mm IOMMU_PORT_L1_OVL_2L_RDMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		rdma0: rdma@14007000 {
+			compatible = "mediatek,mt8186-disp-rdma",
+				     "mediatek,mt8183-disp-rdma";
+			reg = <0 0x14007000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&iommu_mm IOMMU_PORT_L1_DISP_RDMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		color: color@14009000 {
+			compatible = "mediatek,mt8186-disp-color",
+				     "mediatek,mt8173-disp-color";
+			reg = <0 0x14009000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
+			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x8000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
 		dpi: dpi@1400a000 {
 			compatible = "mediatek,mt8186-dpi";
 			reg = <0 0x1400a000 0 0x1000>;
@@ -1301,6 +1365,56 @@
 			};
 		};
 
+		ccorr: ccorr@1400b000 {
+			compatible = "mediatek,mt8186-disp-ccorr",
+				     "mediatek,mt8192-disp-ccorr";
+			reg = <0 0x1400b000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		aal: aal@1400c000 {
+			compatible = "mediatek,mt8186-disp-aal",
+				     "mediatek,mt8183-disp-aal";
+			reg = <0 0x1400c000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_AAL0>;
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		gamma: gamma@1400d000 {
+			compatible = "mediatek,mt8186-disp-gamma",
+				     "mediatek,mt8183-disp-gamma";
+			reg = <0 0x1400d000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
+			interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		postmask: postmask@1400e000 {
+			compatible = "mediatek,mt8186-disp-postmask",
+				     "mediatek,mt8192-disp-postmask";
+			reg = <0 0x1400e000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
+		dither: dither@1400f000 {
+			compatible = "mediatek,mt8186-disp-dither",
+				     "mediatek,mt8183-disp-dither";
+			reg = <0 0x1400f000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
 		dsi0: dsi@14013000 {
 			compatible = "mediatek,mt8186-dsi";
 			reg = <0 0x14013000 0 0x1000>;
@@ -1334,6 +1448,17 @@
 			#iommu-cells = <1>;
 		};
 
+		rdma1: rdma@1401f000 {
+			compatible = "mediatek,mt8186-disp-rdma",
+				     "mediatek,mt8183-disp-rdma";
+			reg = <0 0x1401f000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
+			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&iommu_mm IOMMU_PORT_L1_DISP_RDMA1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xf000 0x1000>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
+		};
+
 		wpesys: clock-controller@14020000 {
 			compatible = "mediatek,mt8186-wpesys";
 			reg = <0 0x14020000 0 0x1000>;
-- 
2.18.0

