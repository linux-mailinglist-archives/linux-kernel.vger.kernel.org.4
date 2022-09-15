Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0CB5B9668
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIOIco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiIOIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:32:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FB9569E;
        Thu, 15 Sep 2022 01:32:37 -0700 (PDT)
X-UUID: 8bed5012100d42258b60ba20f626b509-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2V4ISJ1pSA6PqL2bSlrt/KFVdLf7Qresglb+Otewhw8=;
        b=gYXijqSQhE3/J/2NToiB2wQqFbam+DeNvKZLztSmC+CHfRSniaQBDPctaznvMYslFNdZt5Ftlpl+g+esEnIedIoLcbwWvAOh8ZLY00WMrXuLrmXwOWl7AQ9v4OJUIw+MPtTg70XkG4zqayzhi9/1mgPO/hxqYYRZZKWxJHX30mU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:177355e2-3559-440d-8837-51d1c5acb34a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:177355e2-3559-440d-8837-51d1c5acb34a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:81f37ff6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:220915161402LYR09JH6,BulkQuantity:134,Recheck:0,SF:28|17|19|48,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 8bed5012100d42258b60ba20f626b509-20220915
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 272185181; Thu, 15 Sep 2022 16:32:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 15 Sep 2022 16:32:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 15 Sep 2022 16:32:31 +0800
Message-ID: <7cec789d6d54f4bb85e9129d39a3da52e26293dd.camel@mediatek.com>
Subject: Re: [PATCH 1/4] arm64: dts: mt8195: Add dp-intf nodes
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 15 Sep 2022 16:32:31 +0800
In-Reply-To: <f882ab40-b9bf-3f38-d62e-c175135383c3@collabora.com>
References: <20220915075849.1920-1-rex-bc.chen@mediatek.com>
         <20220915075849.1920-2-rex-bc.chen@mediatek.com>
         <f882ab40-b9bf-3f38-d62e-c175135383c3@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-15 at 16:13 +0800, AngeloGioacchino Del Regno wrote:
> Il 15/09/22 09:58, Bo-Chen Chen ha scritto:
> > Add dp-intf0 and dp-intf1 nodes for MT8195.
> > 
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 23
> > +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 905d1a90b406..93e6a106a9b8 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -2155,5 +2155,28 @@
> >   			clock-names = "apb", "smi", "gals";
> >   			power-domains = <&spm
> > MT8195_POWER_DOMAIN_VDOSYS1>;
> >   		};
> > +
> > +		dp_intf0: dp-intf@1c015000 {
> 
> Please keep the devicetree nodes ordered by mmio.
> dp_intf0 goes between mutex@1c016000 and larb@1c018000.
> 

Hello Angelo,

Thanks for your review.

I think it should be merge@1c014000 and mutex@1c016000?
I will move dp-intf@1c015000 between them.

> > +			status = "disabled";
> 
> status = "disabled" across the entire mt8195.dtsi nodes is always at
> the end.
> Please keep consistency.
> 

OK, I will modify this in next version.

BRs,
Bo-Chen

> > +			compatible = "mediatek,mt8195-dp-intf";
> > +			reg = <0 0x1c015000 0 0x1000>;
> > +			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH
> > 0>;
> > +			clocks = <&vdosys0  CLK_VDO0_DP_INTF0>,
> > +				 <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
> > +				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
> > +			clock-names = "engine", "pixel", "pll";
> > +		};
> > +
> > +		dp_intf1: dp-intf@1c113000 {
> > +			compatible = "mediatek,mt8195-dp-intf";
> > +			reg = <0 0x1c113000 0 0x1000>;
> > +			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH
> > 0>;
> > +			power-domains = <&spm
> > MT8195_POWER_DOMAIN_VDOSYS1>;
> > +			clocks = <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
> > +				 <&vdosys1 CLK_VDO1_DPINTF>,
> > +				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
> > +			clock-names = "engine", "pixel", "pll";
> > +			status = "disabled";
> > +		};
> >   	};
> >   };
> 
> 

