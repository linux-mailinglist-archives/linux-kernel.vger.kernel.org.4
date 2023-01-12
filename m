Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60771666CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbjALIqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbjALIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:46:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA01CB26;
        Thu, 12 Jan 2023 00:45:15 -0800 (PST)
X-UUID: 6ae3f558925511ed945fc101203acc17-20230112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=11aNuTnXnc1zBHf/DOng+UuHFjCbI3B9XtmDQSCZXi0=;
        b=T/oYtKrzSUMMz50t8hgsKIi4kVvByvmyG67UG8u+vBcfT/HN3APhTLSQ9EcHYAWEVXQz4qSAmkkQ0k0v5WzJTeyyFNh6x/D2Bah92P8ab89qWq06DoVT07gmiMBtrXJZU3HI/QMLt6rzWpguMfSXVy1SYuKGq/AhlYx5mZmGIwI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:1d47a175-7a12-481d-92c7-b21f73eac2aa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:1d47a175-7a12-481d-92c7-b21f73eac2aa,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:cd610e8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230112164509NT883R14,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 6ae3f558925511ed945fc101203acc17-20230112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 410630771; Thu, 12 Jan 2023 16:45:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Jan 2023 16:45:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Jan 2023 16:45:05 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, Irui Wang <irui.wang@mediatek.com>
Subject: [V1,1/2] arm64: dts: mt8195: add jpeg encode device node
Date:   Thu, 12 Jan 2023 16:45:02 +0800
Message-ID: <20230112084503.4277-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112084503.4277-1-irui.wang@mediatek.com>
References: <20230112084503.4277-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

add mt8195 jpegenc device node

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d31536f4c48..af49ec352bfe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2152,6 +2152,46 @@
 			#clock-cells = <1>;
 		};
 
+
+		jpgenc-master {
+			compatible = "mediatek,mt8195-jpgenc";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+			iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
+					<&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
+					<&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
+					<&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
+			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			jpgenc@1a030000 {
+				compatible = "mediatek,mt8195-jpgenc-hw";
+				reg = <0 0x1a030000 0 0x10000>;
+				iommus = <&iommu_vdo M4U_PORT_L19_JPGENC_Y_RDMA>,
+						<&iommu_vdo M4U_PORT_L19_JPGENC_C_RDMA>,
+						<&iommu_vdo M4U_PORT_L19_JPGENC_Q_TABLE>,
+						<&iommu_vdo M4U_PORT_L19_JPGENC_BSDMA>;
+				interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&vencsys CLK_VENC_JPGENC>;
+				clock-names = "jpgenc";
+				power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+			};
+
+			jpgenc@1b030000 {
+				compatible = "mediatek,mt8195-jpgenc-hw";
+				reg = <0 0x1b030000 0 0x10000>;
+				iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
+						<&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
+						<&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
+						<&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
+				interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&vencsys_core1 CLK_VENC_CORE1_JPGENC>;
+				clock-names = "jpgenc";
+				power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+			};
+		};
+
 		larb20: larb@1b010000 {
 			compatible = "mediatek,mt8195-smi-larb";
 			reg = <0 0x1b010000 0 0x1000>;
-- 
2.18.0

