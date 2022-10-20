Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAA7605A25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJTIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiJTIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:49:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19362BD6;
        Thu, 20 Oct 2022 01:49:23 -0700 (PDT)
X-UUID: ec1b701215e74bd3a5ab5010d5e23aba-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6UnHp2k2ghaZjkzv46YbDogoalXYu7CQABpaiFjEGJo=;
        b=XkBlh9/eFNlxUIteYYySCnk9ahJfHMVTwweiSjUiaTW3L9/s7CqdQUkANlx264wxaPDqys6dofr/wn6EyAImZ4uCJ0+Bvt9Pu9T/FJEzGHAmJ+6Ihr+SKKgDwKQ7kpkkvjt7pYb60zQTcnaSCLlNR3xETORcyDMxu/7AQQj8yGM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:cffe546c-63ec-4813-b880-3993dec29334,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:69da67a3-73e4-48dd-a911-57b5d5484f14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ec1b701215e74bd3a5ab5010d5e23aba-20221020
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1656399006; Thu, 20 Oct 2022 16:49:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 20 Oct 2022 16:49:15 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 20 Oct 2022 16:49:13 +0800
Message-ID: <5e80cef1df473b2b401b803c5ad6fc1dddba17fc.camel@mediatek.com>
Subject: Re: [PATCH v3] arm64: dts: mt8195: Add Ethernet controller
From:   Biao Huang <biao.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <macpaul.lin@mediatek.com>
Date:   Thu, 20 Oct 2022 16:49:13 +0800
In-Reply-To: <0fb91a39-e356-4785-3ab1-11cbc3e78877@collabora.com>
References: <20221020024155.24520-1-biao.huang@mediatek.com>
         <20221020024155.24520-2-biao.huang@mediatek.com>
         <0fb91a39-e356-4785-3ab1-11cbc3e78877@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Dear Angelo,
	Thanks for your comments~

On Thu, 2022-10-20 at 10:09 +0200, AngeloGioacchino Del Regno wrote:
> Il 20/10/22 04:41, Biao Huang ha scritto:
> > Add Ethernet controller node for mt8195.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88
> > ++++++++++++++++++++
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 88
> > ++++++++++++++++++++
> >   2 files changed, 176 insertions(+)
> > 
> 
> ..snip..
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 905d1a90b406..7efaf92c5ff3 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1042,6 +1042,94 @@ spis1: spi@1101e000 {
> >   			status = "disabled";
> >   		};
> >   
> > +		eth: ethernet@11021000 {
> > +			compatible = "mediatek,mt8195-gmac",
> > "snps,dwmac-5.10a";
> 
> ..snip..
> 
> > +			#address-cells = <0>;
> > +			#size-cells = <0>;
> 
> I'm truly sorry for a partial bad suggestion, you don't need to
> specify address nor
> size cells = <0>; in the ethernet node, or you get a warning:
> 
> arch/arm64/boot/dts/mediatek/mt8195.dtsi:1174.26-1260.5: Warning 
> (avoid_unnecessary_addr_size): /soc/ethernet@11021000: unnecessary 
> #address-cells/#size-cells without "ranges" or child "reg" property
> 
> So please remove these two.
OK, will remove in next send.
> 
> After which...
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
OK, will add in next send.
> 
> 
Best Regards!
Biao

