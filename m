Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A30654A86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiLWBvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLWBuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 20:50:55 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D240DFAC;
        Thu, 22 Dec 2022 17:50:50 -0800 (PST)
X-UUID: b0cd8c85dab44c18a12f31c2399e3e85-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RetU9plkC6PlzdhyrPl9diuDAf2ccELX3EGs8VyzYRM=;
        b=D52o/J04XB4Ir6uyEs8pwAOiVUOoPttG3PIaMQsuDLasJOaIq23NA1NQj570Qd5Dbt5dexrzI0BLHcGvJ/XP0EvAy6ZdCIpM5fp96R/esMgvIhtBHIaHw9L2Dbt8xwGggsMAnyi5ncz86CLpK7yb6E4HQne5no45xOJrKqlbWcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:dd3d620b-7e8a-462a-a198-f038a39e17c6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:3311298a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b0cd8c85dab44c18a12f31c2399e3e85-20221223
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1264357886; Fri, 23 Dec 2022 09:50:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 09:50:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 23 Dec 2022 09:50:41 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Biao Huang <biao.huang@mediatek.com>,
        <macpaul.lin@mediatek.com>
Subject: [PATCH v5 2/2] arm64: dts: mt8195: Add Ethernet controller
Date:   Fri, 23 Dec 2022 09:50:29 +0800
Message-ID: <20221223015029.24978-3-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223015029.24978-1-biao.huang@mediatek.com>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
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

Add Ethernet controller node for mt8195.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 81 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 86 ++++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 4fbd99eb496a..2e6979c47aa6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -258,6 +258,66 @@ &mt6359_vsram_others_ldo_reg {
 };
 
 &pio {
+	eth_default_pins: eth-default-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
+		};
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
+			input-enable;
+		};
+		pins-power {
+			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO92__FUNC_GPIO92>;
+			output-high;
+		};
+	};
+
+	eth_sleep_pins: eth-sleep-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
+				 <PINMUX_GPIO78__FUNC_GPIO78>,
+				 <PINMUX_GPIO79__FUNC_GPIO79>,
+				 <PINMUX_GPIO80__FUNC_GPIO80>;
+		};
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
+				 <PINMUX_GPIO88__FUNC_GPIO88>,
+				 <PINMUX_GPIO87__FUNC_GPIO87>,
+				 <PINMUX_GPIO86__FUNC_GPIO86>;
+		};
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
+				 <PINMUX_GPIO82__FUNC_GPIO82>,
+				 <PINMUX_GPIO83__FUNC_GPIO83>,
+				 <PINMUX_GPIO84__FUNC_GPIO84>;
+		};
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
+				 <PINMUX_GPIO90__FUNC_GPIO90>;
+			input-disable;
+			bias-disable;
+		};
+	};
+
 	gpio_keys_pins: gpio-keys-pins {
 		pins {
 			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
@@ -434,6 +494,27 @@ &xhci0 {
 	status = "okay";
 };
 
+&eth {
+	phy-mode ="rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
+	snps,reset-delays-us = <0 10000 10000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethernet_phy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <0x1>;
+		};
+	};
+};
+
 &xhci1 {
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d31536f4c48..b90d38d87aa4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1046,6 +1046,92 @@ spis1: spi@1101e000 {
 			status = "disabled";
 		};
 
+		eth: ethernet@11021000 {
+			compatible = "mediatek,mt8195-gmac", "snps,dwmac-5.10a";
+			reg = <0 0x11021000 0 0x4000>;
+			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			clock-names = "axi",
+				      "apb",
+				      "mac_main",
+				      "ptp_ref",
+				      "rmii_internal",
+				      "mac_cg";
+			clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_BUS>,
+				 <&topckgen CLK_TOP_SNPS_ETH_250M>,
+				 <&topckgen CLK_TOP_SNPS_ETH_62P4M_PTP>,
+				 <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
+			assigned-clocks = <&topckgen CLK_TOP_SNPS_ETH_250M>,
+					  <&topckgen CLK_TOP_SNPS_ETH_62P4M_PTP>,
+					  <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>;
+			assigned-clock-parents = <&topckgen CLK_TOP_ETHPLL_D2>,
+						 <&topckgen CLK_TOP_ETHPLL_D8>,
+						 <&topckgen CLK_TOP_ETHPLL_D10>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_ETHER>;
+			mediatek,pericfg = <&infracfg_ao>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <16>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <0x7>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+			};
+
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,priority = <0x0>;
+				};
+				queue1 {
+					snps,weight = <0x11>;
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+				};
+				queue2 {
+					snps,weight = <0x12>;
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+				};
+				queue3 {
+					snps,weight = <0x13>;
+					snps,dcb-algorithm;
+					snps,priority = <0x3>;
+				};
+			};
+		};
+
 		xhci0: usb@11200000 {
 			compatible = "mediatek,mt8195-xhci",
 				     "mediatek,mtk-xhci";
-- 
2.25.1

