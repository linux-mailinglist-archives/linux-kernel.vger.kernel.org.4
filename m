Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615DE605EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiJTLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJTLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:19:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD712ACB;
        Thu, 20 Oct 2022 04:19:36 -0700 (PDT)
X-UUID: c25fa4b800954077aa228d5ae01489eb-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5dI92auzLHY/lelM7TtgPzOdqw5RFORtpBKAr7npXJw=;
        b=kyQX7SbTLrIhjI8F9TpyeZcFVT/k7sb8ExF3W5gMHkr0m4Y2M3sl9SvCU+Q7MCp+nBF+Y9KGjypIvXrEs1DZQw+u7NlakakdffiXDC6nE8wQgLbaLgy4ppMvNSlz0Oq737tsofQsQJuRYqHZNJ7h8xr8SjV69W7jJVGwqcdmQuA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:43cfbeaa-e4ad-4c38-aa22-3d48e69e7eff,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:43cfbeaa-e4ad-4c38-aa22-3d48e69e7eff,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:0de46ca4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:221020191931XVBKLZPW,BulkQuantity:2,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0
X-UUID: c25fa4b800954077aa228d5ae01489eb-20221020
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 411466777; Thu, 20 Oct 2022 19:19:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 20 Oct 2022 19:19:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 20 Oct 2022 19:19:26 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v2 2/3] arm64: dts: mt8195: Add pcie and pcie phy nodes
Date:   Thu, 20 Oct 2022 19:19:24 +0800
Message-ID: <20221020111925.30002-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221020111925.30002-1-tinghan.shen@mediatek.com>
References: <20221020111925.30002-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcie and pcie phy nodes for mt8195.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 150 +++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d03f0c2b8233..2128fa007480 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
+#include <dt-bindings/reset/mt8195-resets.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -1182,6 +1183,110 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie@112f0000 {
+			compatible = "mediatek,mt8195-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x112f0000 0 0x4000>;
+			reg-names = "pcie-mac";
+			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x20000000
+				  0x0 0x20000000 0 0x200000>,
+				 <0x82000000 0 0x20200000
+				  0x0 0x20200000 0 0x3e00000>;
+
+			iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE0 0x2>;
+			iommu-map-mask = <0x0>;
+
+			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P0>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_26M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_32K>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+			clock-names = "pl_250m", "tl_26m", "tl_96m",
+				      "tl_32k", "peri_26m", "peri_mem";
+			assigned-clocks = <&topckgen CLK_TOP_TL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
+
+			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P0_SWRST>;
+			reset-names = "mac";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@112f8000 {
+			compatible = "mediatek,mt8195-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x112f8000 0 0x4000>;
+			reg-names = "pcie-mac";
+			interrupts = <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x24000000
+				  0x0 0x24000000 0 0x200000>,
+				 <0x82000000 0 0x24200000
+				  0x0 0x24200000 0 0x3e00000>;
+
+			iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE1 0x2>;
+			iommu-map-mask = <0x0>;
+
+			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P1>,
+				 <&clk26m>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+				 <&clk26m>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+				 /* Designer has connect pcie1 with peri_mem_p0 clock */
+				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+			clock-names = "pl_250m", "tl_26m", "tl_96m",
+				      "tl_32k", "peri_26m", "peri_mem";
+			assigned-clocks = <&topckgen CLK_TOP_TL_P1>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
+
+			phys = <&u3port1 PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
+
+			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P1_SWRST>;
+			reset-names = "mac";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		nor_flash: spi@1132c000 {
 			compatible = "mediatek,mt8195-nor",
 				     "mediatek,mt8173-nor";
@@ -1241,6 +1346,34 @@
 				reg = <0x189 0x2>;
 				bits = <7 5>;
 			};
+			pciephy_rx_ln1: pciephy-rx-ln1@190 {
+				reg = <0x190 0x1>;
+				bits = <0 4>;
+			};
+			pciephy_tx_ln1_nmos: pciephy-tx-ln1-nmos@190 {
+				reg = <0x190 0x1>;
+				bits = <4 4>;
+			};
+			pciephy_tx_ln1_pmos: pciephy-tx-ln1-pmos@191 {
+				reg = <0x191 0x1>;
+				bits = <0 4>;
+			};
+			pciephy_rx_ln0: pciephy-rx-ln0@191 {
+				reg = <0x191 0x1>;
+				bits = <4 4>;
+			};
+			pciephy_tx_ln0_nmos: pciephy-tx-ln0-nmos@192,1 {
+				reg = <0x192 0x1>;
+				bits = <0 4>;
+			};
+			pciephy_tx_ln0_pmos: pciephy-tx-ln0-pmos@192,2 {
+				reg = <0x192 0x1>;
+				bits = <4 4>;
+			};
+			pciephy_glb_intr: pciephy-glb-intr@193 {
+				reg = <0x193 0x1>;
+				bits = <0 4>;
+			};
 		};
 
 		u3phy2: t-phy@11c40000 {
@@ -1461,6 +1594,23 @@
 			};
 		};
 
+		pciephy: phy@11e80000 {
+			compatible = "mediatek,mt8195-pcie-phy";
+			reg = <0 0x11e80000 0 0x10000>;
+			reg-names = "sif";
+			nvmem-cells = <&pciephy_glb_intr>, <&pciephy_tx_ln0_pmos>,
+				      <&pciephy_tx_ln0_nmos>, <&pciephy_rx_ln0>,
+				      <&pciephy_tx_ln1_pmos>, <&pciephy_tx_ln1_nmos>,
+				      <&pciephy_rx_ln1>;
+			nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
+					   "tx_ln0_nmos", "rx_ln0",
+					   "tx_ln1_pmos", "tx_ln1_nmos",
+					   "rx_ln1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_PHY>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		ufsphy: ufs-phy@11fa0000 {
 			compatible = "mediatek,mt8195-ufsphy", "mediatek,mt8183-ufsphy";
 			reg = <0 0x11fa0000 0 0xc000>;
-- 
2.18.0

