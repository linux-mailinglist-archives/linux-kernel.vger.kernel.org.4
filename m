Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0522660248F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJRGiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJRGiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:38:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E08A7DC;
        Mon, 17 Oct 2022 23:38:01 -0700 (PDT)
X-UUID: 368b31d11a3a4dba8c4129cb21b9e595-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eM+soasMJzB6uxzurzAYBD4NNpjZ9qTL1sEyE6FK3J8=;
        b=WfOuPQb2y10opBmhNbzJD5LV31CgOox0UNaRcXkVQsg8p7K9Cu4C3lPUri1c47FM5KXXk6GwHxmKZwipysdb0E2zcf3vrbR/5qzw6JqqB1pXQ/oKV4NrgilEXcimxTAtwKVio+q+uC0vA9U7Tp4iam4Aqr8Y8RbuQG2NQGm2oBk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:6cf3a249-a9b5-42b6-b1b9-1618c24b7655,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:8f0921a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 368b31d11a3a4dba8c4129cb21b9e595-20221018
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1704619019; Tue, 18 Oct 2022 14:37:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 18 Oct 2022 14:37:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 18 Oct 2022 14:37:54 +0800
Message-ID: <b5d18b4b631cb19d435f37ccacd296a2282c2a1a.camel@mediatek.com>
Subject: Re: [PATCH] arm64: dts: mt8195: Add Ethernet controller
From:   Biao Huang <biao.huang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <macpaul.lin@mediatek.com>
Date:   Tue, 18 Oct 2022 14:37:54 +0800
In-Reply-To: <d6bda69e-d331-3e64-2100-d41e84c3fab7@linaro.org>
References: <20221017095834.7675-1-biao.huang@mediatek.com>
         <d6bda69e-d331-3e64-2100-d41e84c3fab7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Dear Krzysztof,
	Thanks for your comments!

On Mon, 2022-10-17 at 22:01 -0400, Krzysztof Kozlowski wrote:
> On 17/10/2022 05:58, Biao Huang wrote:
> > Add Ethernet controller node for mt8195.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88
> > ++++++++++++++++++++
> >  arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 87
> > +++++++++++++++++++
> >  2 files changed, 175 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > index 4fbd99eb496a..02e04f82a4ae 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > @@ -258,6 +258,72 @@ &mt6359_vsram_others_ldo_reg {
> >  };
> >  
> >  &pio {
> > +	eth_default: eth_default {
> 
> No underscores in node names. Please also be sure your patch does not
> bring new warnings with `dtbs_check` (lack of suffix above could mean
> it
> brings...)
OK, I'll fix the underscores issue in next send.
As to "lack of suffix" issue, do you mean I should write it like:
	eth-default: eth-default@0 {
		...
	}
If yes, other nodes in current file don't have such suffix.
e.g.
	gpio_keys_pins: gpio-keys-pins

Should I keep unified style with other nodes?
> 
> > +		txd_pins {
> 
> No underscores
OK, will fix in next send.
> 
> > +			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
> > +				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
> > +				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
> > +				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
> > +			drive-strength = <MTK_DRIVE_8mA>;
> > +		};
> > +		cc_pins {
> 
> Ditto... and so on.
OK, will fix in next send.
> 
> > +			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
> > +				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
> > +				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
> > +				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
> > +			drive-strength = <MTK_DRIVE_8mA>;
> > +		};
> > +		rxd_pins {
> > +			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
> > +				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
> > +				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
> > +				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
> > +		};
> > +		mdio_pins {
> > +			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
> > +				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
> > +			input-enable;
> > +		};
> > +		power_pins {
> > +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> > +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> > +			output-high;
> > +		};
> > +	};
> > +
> > +	eth_sleep: eth_sleep {
> > +		txd_pins {
> > +			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
> > +				 <PINMUX_GPIO78__FUNC_GPIO78>,
> > +				 <PINMUX_GPIO79__FUNC_GPIO79>,
> > +				 <PINMUX_GPIO80__FUNC_GPIO80>;
> > +		};
> > +		cc_pins {
> > +			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
> > +				 <PINMUX_GPIO88__FUNC_GPIO88>,
> > +				 <PINMUX_GPIO87__FUNC_GPIO87>,
> > +				 <PINMUX_GPIO86__FUNC_GPIO86>;
> > +		};
> > +		rxd_pins {
> > +			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
> > +				 <PINMUX_GPIO82__FUNC_GPIO82>,
> > +				 <PINMUX_GPIO83__FUNC_GPIO83>,
> > +				 <PINMUX_GPIO84__FUNC_GPIO84>;
> > +		};
> > +		mdio_pins {
> > +			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
> > +				 <PINMUX_GPIO90__FUNC_GPIO90>;
> > +			input-disable;
> > +			bias-disable;
> > +		};
> > +		power_pins {
> > +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> > +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> > +			input-disable;
> > +			bias-disable;
> > +		};
> > +	};
> > +
> >  	gpio_keys_pins: gpio-keys-pins {
> >  		pins {
> >  			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
> > @@ -434,6 +500,28 @@ &xhci0 {
> >  	status = "okay";
> >  };
> >  
> > +&eth {
> > +	phy-mode ="rgmii-rxid";
> > +	phy-handle = <&eth_phy0>;
> > +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
> > +	snps,reset-delays-us = <0 10000 10000>;
> > +	mediatek,tx-delay-ps = <2030>;
> > +	pinctrl-names = "default", "sleep";
> > +	pinctrl-0 = <&eth_default>;
> > +	pinctrl-1 = <&eth_sleep>;
> > +	status = "okay";
> > +
> > +	mdio {
> > +		compatible = "snps,dwmac-mdio";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		eth_phy0: eth_phy0@1 {
> 
> ethernet-phy@1
OK, will modify in next send.
> 
> > +			compatible = "ethernet-phy-id001c.c916";
> > +			reg = <0x1>;
> > +		};
> > +	};
> > +};
> > +
> >  &xhci1 {
> >  	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> >  	status = "okay";
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 905d1a90b406..aa1fcc3b9cb6 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1042,6 +1042,93 @@ spis1: spi@1101e000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		stmmac_axi_setup: stmmac-axi-config {
> > +			snps,wr_osr_lmt = <0x7>;
> > +			snps,rd_osr_lmt = <0x7>;
> > +			snps,blen = <0 0 0 0 16 8 4>;
> > +		};
> > +
> > +		mtl_rx_setup: rx-queues-config {
> > +			snps,rx-queues-to-use = <4>;
> > +			snps,rx-sched-sp;
> > +			queue0 {
> > +				snps,dcb-algorithm;
> > +				snps,map-to-dma-channel = <0x0>;
> > +			};
> > +			queue1 {
> > +				snps,dcb-algorithm;
> > +				snps,map-to-dma-channel = <0x0>;
> > +			};
> > +			queue2 {
> > +				snps,dcb-algorithm;
> > +				snps,map-to-dma-channel = <0x0>;
> > +			};
> > +			queue3 {
> > +				snps,dcb-algorithm;
> > +				snps,map-to-dma-channel = <0x0>;
> > +			};
> > +		};
> > +
> > +		mtl_tx_setup: tx-queues-config {
> > +			snps,tx-queues-to-use = <4>;
> > +			snps,tx-sched-wrr;
> > +			queue0 {
> > +				snps,weight = <0x10>;
> > +				snps,dcb-algorithm;
> > +				snps,priority = <0x0>;
> > +			};
> > +			queue1 {
> > +				snps,weight = <0x11>;
> > +				snps,dcb-algorithm;
> > +				snps,priority = <0x1>;
> > +			};
> > +			queue2 {
> > +				snps,weight = <0x12>;
> > +				snps,dcb-algorithm;
> > +				snps,priority = <0x2>;
> > +			};
> > +			queue3 {
> > +				snps,weight = <0x13>;
> > +				snps,dcb-algorithm;
> > +				snps,priority = <0x3>;
> > +			};
> > +		};
> > +
> > +		eth: ethernet@11021000 {
> > +			compatible = "mediatek,mt8195-gmac",
> > "snps,dwmac-5.10a";
> > +			reg = <0 0x11021000 0 0x4000>;
> > +			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH
> > 0>;
> > +			interrupt-names = "macirq";
> > +			mac-address = [00 55 7b b5 7d f7];
> 
> How is this property of a SoC? Are you saying now that all MT8195
> SoCs
> have the same MAC address?
The mac-address here is taken as a default mac address in eth driver
rather than a randome one.
Actually, there will be a tool to customize eth mac address (e.g
through "ifconfig eth0 hw ether xx:xx:xx:xx:xx:xx"), so every
MT8195 SoCs will get their specified mac address in real product.
> 
> Best regards,
> Krzysztof
> 
Best Regards!
Biao

