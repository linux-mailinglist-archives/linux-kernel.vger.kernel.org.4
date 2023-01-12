Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04CE666CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbjALIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjALIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:46:14 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE72F7BD;
        Thu, 12 Jan 2023 00:45:16 -0800 (PST)
X-UUID: 6b47c2fe925511eda06fc9ecc4dadd91-20230112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Wxi9Qy3WCX4lZPEMGHKiUq/2jxBrcJqTGD7hJUEmIKM=;
        b=IOgilVKvgl/W0FWZXFD/9ozXr0u8kRejx3mamiakCo1XMf5xGr+VvQIOnDaXPQobewOxvpgbFlg0EAzeLYHxu+prFGvTWn+kyWgebACw9KOuih99koVzny8FGHFRI39F4c+9Kru4dbhqve1ty02GTO5QWzNJJnWr8oM/27ZtG9Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:20405a3e-7f59-4a7b-a7ed-4d36ca9bd6ba,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:dc697354-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 6b47c2fe925511eda06fc9ecc4dadd91-20230112
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 545303540; Thu, 12 Jan 2023 16:45:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Jan 2023 16:45:08 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Jan 2023 16:45:06 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
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
Subject: [V1,2/2] arm64: dts: mt8195: add jpeg decode device node
Date:   Thu, 12 Jan 2023 16:45:03 +0800
Message-ID: <20230112084503.4277-3-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112084503.4277-1-irui.wang@mediatek.com>
References: <20230112084503.4277-1-irui.wang@mediatek.com>
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

From: kyrie wu <kyrie.wu@mediatek.com>

add mt8195 jpegdec device node

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index af49ec352bfe..d5d0aeac57e4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2192,6 +2192,66 @@
 			};
 		};
 
+		jpgdec-master {
+			compatible = "mediatek,mt8195-jpgdec";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+			iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
+					<&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
+					<&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
+					<&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
+					<&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+					<&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			jpgdec@1a040000 {
+				compatible = "mediatek,mt8195-jpgdec-hw";
+				reg = <0 0x1a040000 0 0x10000>;/* JPGDEC_C0 */
+				iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+				interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&vencsys CLK_VENC_JPGDEC>;
+				clock-names = "jpgdec";
+				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+			};
+
+			jpgdec@1a050000 {
+				compatible = "mediatek,mt8195-jpgdec-hw";
+				reg = <0 0x1a050000 0 0x10000>;/* JPGDEC_C1 */
+				iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+						<&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+				interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&vencsys CLK_VENC_JPGDEC_C1>;
+				clock-names = "jpgdec";
+				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+			};
+
+			jpgdec@1b040000 {
+				compatible = "mediatek,mt8195-jpgdec-hw";
+				reg = <0 0x1b040000 0 0x10000>;/* JPGDEC_C2 */
+				iommus = <&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA0>,
+						<&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA0>,
+						<&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA1>,
+						<&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA1>,
+						<&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET1>,
+						<&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET0>;
+				interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&vencsys_core1 CLK_VENC_CORE1_JPGDEC>;
+				clock-names = "jpgdec";
+				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC2>;
+			};
+		};
+
 		larb20: larb@1b010000 {
 			compatible = "mediatek,mt8195-smi-larb";
 			reg = <0 0x1b010000 0 0x1000>;
-- 
2.18.0

