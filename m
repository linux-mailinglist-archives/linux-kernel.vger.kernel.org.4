Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59832603B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJSIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJSIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:37:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C343E52;
        Wed, 19 Oct 2022 01:37:10 -0700 (PDT)
X-UUID: 70f2929a6e4d4d15882d70b0aebf317a-20221019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VXEyPaTCrLxGpSY/5IgutvS9DnC8wiZbTJnfp0Z5oLk=;
        b=H3jy3jdr9uCQ3VXN6SO1gA7LGwtCgbwgbU8Yavzn38a20dHoJ3p5t02rCBt55+NzqVvrYRN0qjh55+TOMoEBOaWMCHp/6cABbzFe42C+jhD0LsX8xmOX16IHnfsjx6Q17k5Dgy6DFJ6MJgbzHWZnlRoIMdu6l93sZw2CU9K+I94=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0eb8f19d-8858-4a4c-b694-82e39c7a1d5b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.12,REQID:0eb8f19d-8858-4a4c-b694-82e39c7a1d5b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:62cd327,CLOUDID:080ac3ee-314c-4293-acb8-ca4299dd021f,B
        ulkID:221018100211ICU4VPNE,BulkQuantity:143,Recheck:0,SF:38|28|17|19|48|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0
X-UUID: 70f2929a6e4d4d15882d70b0aebf317a-20221019
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1076513339; Wed, 19 Oct 2022 16:37:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 19 Oct 2022 16:37:02 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 19 Oct 2022 16:37:02 +0800
Message-ID: <8c04c2f898ecc1466c3f14eace30762956c83885.camel@mediatek.com>
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
Date:   Wed, 19 Oct 2022 16:37:02 +0800
In-Reply-To: <37fff2b8-a798-dea3-c010-714a2bac695f@linaro.org>
References: <20221017095834.7675-1-biao.huang@mediatek.com>
         <d6bda69e-d331-3e64-2100-d41e84c3fab7@linaro.org>
         <b5d18b4b631cb19d435f37ccacd296a2282c2a1a.camel@mediatek.com>
         <37fff2b8-a798-dea3-c010-714a2bac695f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Dear Krzysztof,
	Thanks for your comments~

On Tue, 2022-10-18 at 08:51 -0400, Krzysztof Kozlowski wrote:
> On 18/10/2022 02:37, Biao Huang wrote:
> > Dear Krzysztof,
> > 	Thanks for your comments!
> > 
> > On Mon, 2022-10-17 at 22:01 -0400, Krzysztof Kozlowski wrote:
> > > On 17/10/2022 05:58, Biao Huang wrote:
> > > > Add Ethernet controller node for mt8195.
> > > > 
> > > > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > > > ---
> > > >  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88
> > > > ++++++++++++++++++++
> > > >  arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 87
> > > > +++++++++++++++++++
> > > >  2 files changed, 175 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > index 4fbd99eb496a..02e04f82a4ae 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > @@ -258,6 +258,72 @@ &mt6359_vsram_others_ldo_reg {
> > > >  };
> > > >  
> > > >  &pio {
> > > > +	eth_default: eth_default {
> > > 
> > > No underscores in node names. Please also be sure your patch does
> > > not
> > > bring new warnings with `dtbs_check` (lack of suffix above could
> > > mean
> > > it
> > > brings...)
> > 
> > OK, I'll fix the underscores issue in next send.
> > As to "lack of suffix" issue, do you mean I should write it like:
> > 	eth-default: eth-default@0 {
> 
> I don't know whether you should have here suffix or not - please
> check
> your bindings. Several pinctrl bindings require suffixes (or
> prefixes),
> thus I asked.
> 
> BTW, In the label you must use underscore.
OK, I'll check the pinctrl-mt8195.yaml, and modify the eth related
node.
> 
> > 		...
> > 	}
> > If yes, other nodes in current file don't have such suffix.
> > e.g.
> > 	gpio_keys_pins: gpio-keys-pins
> > 
> > Should I keep unified style with other nodes?
> 
> Check what bindings are requiring.
OK.
> 
> > > 
> > > > +		txd_pins {
> 
> (...)
> 
> > > > +
> > > > +		eth: ethernet@11021000 {
> > > > +			compatible = "mediatek,mt8195-gmac",
> > > > "snps,dwmac-5.10a";
> > > > +			reg = <0 0x11021000 0 0x4000>;
> > > > +			interrupts = <GIC_SPI 716
> > > > IRQ_TYPE_LEVEL_HIGH
> > > > 0>;
> > > > +			interrupt-names = "macirq";
> > > > +			mac-address = [00 55 7b b5 7d f7];
> > > 
> > > How is this property of a SoC? Are you saying now that all MT8195
> > > SoCs
> > > have the same MAC address?
> > 
> > The mac-address here is taken as a default mac address in eth
> > driver
> > rather than a randome one.
> > Actually, there will be a tool to customize eth mac address (e.g
> > through "ifconfig eth0 hw ether xx:xx:xx:xx:xx:xx"), so every
> > MT8195 SoCs will get their specified mac address in real product.
> 
> So this means this is not one MAC address for all SoCs, so this does
> not
> belong to DTSI. Actually it doesn't belong to DTS either. Look how
> others are doing...
OK, will remove it in next send.
> 
> 
> Best regards,
> Krzysztof
> 

