Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C444607000
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiJUG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUG0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:26:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A21373B1;
        Thu, 20 Oct 2022 23:26:02 -0700 (PDT)
X-UUID: fb972c37d2134745aff88d03b8978f5e-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yQQ5dcOP01lW+CR5DSVRsuTLttECvIhe0xnkTBZzjFU=;
        b=uiVsS1pNLueO2/Ac6m7oB1RK8Zyv/zh/W1CI6TIxi0fipsSoWQBhGEf5LXLB4syOtfQC/OJscKaxYUl4H9gKpPJK2bXO/VZG3Sz5o6DtoaDCyNKkEF89oW/t9a3DXZeXu/Cr+WGW3ODfTizVSrHtQ86KAczxom62PdOLRKhHugg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:79bde120-94ff-47d6-a011-654be3a38eb2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.12,REQID:79bde120-94ff-47d6-a011-654be3a38eb2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:62cd327,CLOUDID:69fa3ae4-e572-4957-be22-d8f73f3158f9,B
        ulkID:221021142557YZQZOZPR,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: fb972c37d2134745aff88d03b8978f5e-20221021
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 858624205; Fri, 21 Oct 2022 14:25:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 14:25:53 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 21 Oct 2022 14:25:52 +0800
Message-ID: <616a128698656e71a4e28d59bbced17443c5cebc.camel@mediatek.com>
Subject: Re: [PATCH 6/8] arm64: dts: mt2712-evb: Fix usb vbus regulators
 unit names
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <matthias.bgg@gmail.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sam.shih@mediatek.com>, <hanks.chen@mediatek.com>,
        <weiyi.lu@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <andrew-sh.cheng@mediatek.com>, <viresh.kumar@linaro.org>,
        <fparent@baylibre.com>, <mars.cheng@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Oct 2022 14:25:52 +0800
In-Reply-To: <96ab6836-4650-ee53-a0c9-54b8328b8667@collabora.com>
References: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
         <20221013152212.416661-7-angelogioacchino.delregno@collabora.com>
         <3b7fc7414f282ca044c24dae280f9bc9533a5b7b.camel@mediatek.com>
         <96ab6836-4650-ee53-a0c9-54b8328b8667@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-14 at 09:35 +0200, AngeloGioacchino Del Regno wrote:
> Il 14/10/22 04:43, Chunfeng Yun ha scritto:
> > On Thu, 2022-10-13 at 17:22 +0200, AngeloGioacchino Del Regno
> > wrote:
> > > Update the names to regulator-usb-p{0-3}-vbus to fix
> > > unit_address_vs_reg
> > > warnings for those.
> > > 
> > > Fixes: 1724f4cc5133 ("arm64: dts: Add USB3 related nodes for
> > > MT2712")
> > > Signed-off-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >   arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> > > b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> > > index 638908773706..d31a194124c9 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> > > @@ -50,7 +50,7 @@ extcon_usb1: extcon_iddig1 {
> > >   		id-gpio = <&pio 14 GPIO_ACTIVE_HIGH>;
> > >   	};
> > >   
> > > -	usb_p0_vbus: regulator@2 {
> > > +	usb_p0_vbus: regulator-usb-p0-vbus {
> > 
> > Can we modify dt-binding of fixed regulator instead of changing the
> > node name,
> > since all nodes using fixed regulator may need be changed.
> > 
> 
> These regulators have no MMIO, nor need any index, so it would be
> simply
> wrong to change the binding and leave them as they are here in the
> devicetree.
You are right, then many files need be modified?

Thanks

> 
> Regards,
> Angelo

