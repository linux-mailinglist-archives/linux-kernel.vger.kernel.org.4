Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF06045DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiJSMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiJSMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:50:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2CF261;
        Wed, 19 Oct 2022 05:32:40 -0700 (PDT)
X-UUID: 8391c8b1306241f7b2270faf053eac1f-20221019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o5916h49GoAG6xeAWSGfCno/8ZvL5ib9tYz8ie01VQ8=;
        b=qyIaG0o2L6bu0TxRJ7zMVtigPxrrARDzaDeT5jTyyezOGtoNcF4gFDKicCyy3hwTqoDEuTI27X+qrRcu3o1y0BusdUm8C5zXbYyNt3AIXj7zuYb+3aD0MNWNCh9abY1B2wF25kHc4vI2SVxM21SbR+o1S2bw0Y+Ypmgr6CeL6mE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:03789396-f43e-48e0-ac04-2439bafe2328,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:0f9ec4ee-314c-4293-acb8-ca4299dd021f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8391c8b1306241f7b2270faf053eac1f-20221019
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 575222394; Wed, 19 Oct 2022 17:15:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 19 Oct 2022 17:15:18 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Oct 2022 17:15:18 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Biao Huang <biao.huang@mediatek.com>,
        <macpaul.lin@mediatek.com>
Subject: [PATCH v2] arm64: dts: mt8195: Add Ethernet controller
Date:   Wed, 19 Oct 2022 17:15:15 +0800
Message-ID: <20221019091515.21878-2-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019091515.21878-1-biao.huang@mediatek.com>
References: <20221019091515.21878-1-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet controller node for mt8195.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 86 +++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 4fbd99eb496a..0e8496d837ef 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -258,6 +258,72 @@ &mt6359_vsram_others_ldo_reg {
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
+		pins-power {
+			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO92__FUNC_GPIO92>;
+			input-disable;
+			bias-disable;
+		};
+	};
+
 	gpio_keys_pins: gpio-keys-pins {
 		pins {
 			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
@@ -434,6 +500,28 @@ &xhci0 {
 	status = "okay";
 };
 
+&eth {
+	phy-mode ="rgmii-rxid";
+	phy-handle = <&ethernet_phy0>;
+	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
+	snps,reset-delays-us = <0 10000 10000>;
+	mediatek,tx-delay-ps = <2030>;
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
index 905d1a90b406..7f7d9f8e72ee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1042,6 +1042,92 @@ spis1: spi@1101e000 {
 			status = "disabled";
 		};
 
+		stmmac_axi_setup: stmmac-axi-config {
+			snps,wr_osr_lmt = <0x7>;
+			snps,rd_osr_lmt = <0x7>;
+			snps,blen = <0 0 0 0 16 8 4>;
+		};
+
+		mtl_rx_setup: rx-queues-config {
+			snps,rx-queues-to-use = <4>;
+			snps,rx-sched-sp;
+			queue0 {
+				snps,dcb-algorithm;
+				snps,map-to-dma-channel = <0x0>;
+			};
+			queue1 {
+				snps,dcb-algorithm;
+				snps,map-to-dma-channel = <0x0>;
+			};
+			queue2 {
+				snps,dcb-algorithm;
+				snps,map-to-dma-channel = <0x0>;
+			};
+			queue3 {
+				snps,dcb-algorithm;
+				snps,map-to-dma-channel = <0x0>;
+			};
+		};
+
+		mtl_tx_setup: tx-queues-config {
+			snps,tx-queues-to-use = <4>;
+			snps,tx-sched-wrr;
+			queue0 {
+				snps,weight = <0x10>;
+				snps,dcb-algorithm;
+				snps,priority = <0x0>;
+			};
+			queue1 {
+				snps,weight = <0x11>;
+				snps,dcb-algorithm;
+				snps,priority = <0x1>;
+			};
+			queue2 {
+				snps,weight = <0x12>;
+				snps,dcb-algorithm;
+				snps,priority = <0x2>;
+			};
+			queue3 {
+				snps,weight = <0x13>;
+				snps,dcb-algorithm;
+				snps,priority = <0x3>;
+			};
+		};
+
+		eth: ethernet@11021000 {
+			compatible = "mediatek,mt8195-gmac", "snps,dwmac-5.10a";
+			reg = <0 0x11021000 0 0x4000>;
+			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			clock-names = "axi",
+				      "apb",
+				      "mac_cg",
+				      "mac_main",
+				      "ptp_ref",
+				      "rmii_internal";
+			clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_BUS>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>,
+				 <&topckgen CLK_TOP_SNPS_ETH_250M>,
+				 <&topckgen CLK_TOP_SNPS_ETH_62P4M_PTP>,
+				 <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>;
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
+		};
+
 		xhci0: usb@11200000 {
 			compatible = "mediatek,mt8195-xhci",
 				     "mediatek,mtk-xhci";
-- 
2.25.1

