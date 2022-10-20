Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8960554D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJTCFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJTCFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:05:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00670129756;
        Wed, 19 Oct 2022 19:05:28 -0700 (PDT)
X-UUID: 20feeda39a5942278c66c40810c63f14-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VO5xvhLVQhzMCqtvS6hNx0N5unp8zokjIFS9QG53Czc=;
        b=cgtZ90yVJBMD/NNXA2lDVvu8VmY3DDNey99o0ywOVB3jM7h7kyW9ZAu801iaoRGWKDv+fiXiwcTo1NQdFtjrJETmclFy3Xeo+NGSqGNDiyEwEOEnmlTA0xXn8XQpApkM5oaG1LBCbj5EW5XAzxomG5b5S0g0JES6Hm6P/oX+S+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:bbd6fbd9-774d-42bd-8490-38af96895deb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:26315ba4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 20feeda39a5942278c66c40810c63f14-20221020
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 345631413; Thu, 20 Oct 2022 10:05:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 20 Oct 2022 10:05:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 20 Oct 2022 10:05:21 +0800
Message-ID: <d4a6eb562dfd06f616267be6beaf9c37d88cff37.camel@mediatek.com>
Subject: Re: [PATCH v2] arm64: dts: mt8195: Add Ethernet controller
From:   Biao Huang <biao.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <macpaul.lin@mediatek.com>
Date:   Thu, 20 Oct 2022 10:05:20 +0800
In-Reply-To: <cf0d4a88-16d0-bb10-8402-30d60feafa1b@collabora.com>
References: <20221019091515.21878-1-biao.huang@mediatek.com>
         <20221019091515.21878-2-biao.huang@mediatek.com>
         <cf0d4a88-16d0-bb10-8402-30d60feafa1b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Angelo,
	Thanks for your comments!

On Wed, 2022-10-19 at 15:57 +0200, AngeloGioacchino Del Regno wrote:
> Il 19/10/22 11:15, Biao Huang ha scritto:
> > Add Ethernet controller node for mt8195.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88
> > ++++++++++++++++++++
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 86
> > +++++++++++++++++++
> >   2 files changed, 174 insertions(+)
> > 
> 
> ..snip..
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 905d1a90b406..7f7d9f8e72ee 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1042,6 +1042,92 @@ spis1: spi@1101e000 {
> >   			status = "disabled";
> >   		};
> >   
> > +		stmmac_axi_setup: stmmac-axi-config {
> 
> Didn't you get a warning during dtb build for these ones?
> And if you did, why have you ignored it? :-)
I checked some dts, they keep stmmac-axi-config outside ethernet node,
so I keep the similar way with them, maybe that's old style.
> 
> > +			snps,wr_osr_lmt = <0x7>;
> > +			snps,rd_osr_lmt = <0x7>;
> > +			snps,blen = <0 0 0 0 16 8 4>;
> > +		};
> > +
> 
> ..snip..
> 
> > +
> > +		eth: ethernet@11021000 {
> > +			compatible = "mediatek,mt8195-gmac",
> > "snps,dwmac-5.10a";
> > +			reg = <0 0x11021000 0 0x4000>;
> > +			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH
> > 0>;
> > +			interrupt-names = "macirq";
> > +			clock-names = "axi",
> > +				      "apb",
> > +				      "mac_cg",
> > +				      "mac_main",
> > +				      "ptp_ref",
> > +				      "rmii_internal";
> > +			clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET>,
> > +				 <&pericfg_ao
> > CLK_PERI_AO_ETHERNET_BUS>,
> > +				 <&pericfg_ao
> > CLK_PERI_AO_ETHERNET_MAC>,
> > +				 <&topckgen CLK_TOP_SNPS_ETH_250M>,
> > +				 <&topckgen
> > CLK_TOP_SNPS_ETH_62P4M_PTP>,
> > +				 <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>;
> > +			assigned-clocks = <&topckgen
> > CLK_TOP_SNPS_ETH_250M>,
> > +					  <&topckgen
> > CLK_TOP_SNPS_ETH_62P4M_PTP>,
> > +					  <&topckgen
> > CLK_TOP_SNPS_ETH_50M_RMII>;
> > +			assigned-clock-parents = <&topckgen
> > CLK_TOP_ETHPLL_D2>,
> > +						 <&topckgen
> > CLK_TOP_ETHPLL_D8>,
> > +						 <&topckgen
> > CLK_TOP_ETHPLL_D10>;
> > +			power-domains = <&spm
> > MT8195_POWER_DOMAIN_ETHER>;
> > +			mediatek,pericfg = <&infracfg_ao>;
> > +			snps,axi-config = <&stmmac_axi_setup>;
> > +			snps,mtl-rx-config = <&mtl_rx_setup>;
> > +			snps,mtl-tx-config = <&mtl_tx_setup>;
> > +			snps,txpbl = <16>;
> > +			snps,rxpbl = <16>;
> > +			snps,clk-csr = <0>;
> > +			status = "disabled";
> 
> Please move stmmac-axi-config, rx-queues-config, tx-queues-config
> here as a subnode
> or in the root node, respecting address/size cells being zero.
> Of course adding that here means also specifying {address,size}-cells 
> = <0> in this
> ethernet node.
OK, I'll move them to ethernet node, and add address/size-cells in
thernet node.
> 
> Regards,
> Angelo
Best Regards!
Biao

