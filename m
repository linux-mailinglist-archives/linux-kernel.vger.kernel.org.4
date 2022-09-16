Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F55BA527
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIPDeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIPDej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:34:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946C55AB;
        Thu, 15 Sep 2022 20:34:34 -0700 (PDT)
X-UUID: fcc5d1b61805480d80e9c56a554ad9b5-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uHfb45m1XChImQ98BYTCdPpUchcD7kA9WpfndA6oA2M=;
        b=gx+8k0NqxKwYgCXSmWyQZzk5BClxrb3McighRkMJuYb0+8E6HdFT9eHAAn3MR0+hbOjBHiG8HV/leBi34xtzWWx2Ob4/aivMBmaYXrGOtFrufjmQUzPQ7f+zaSUtY18gykXtdx86KSVDVicUpJkZRIqaiwwgYuWxDSoxyOZqRWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d78917b1-aa95-4643-880a-779e6e1e0ee2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:fe0b98f6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fcc5d1b61805480d80e9c56a554ad9b5-20220916
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1506722192; Fri, 16 Sep 2022 11:34:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 11:34:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 16 Sep 2022 11:34:27 +0800
Message-ID: <f30bd382eb8923256d6f39342ec7832774c0f547.camel@mediatek.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Singo Chang" <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 16 Sep 2022 11:34:27 +0800
In-Reply-To: <e6921ed7-a14c-aadb-abd4-1e7ee0a63be9@gmail.com>
References: <20220915161817.10307-1-jason-jh.lin@mediatek.com>
         <20220915161817.10307-2-jason-jh.lin@mediatek.com>
         <e6921ed7-a14c-aadb-abd4-1e7ee0a63be9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for the review.

On Fri, 2022-09-16 at 00:05 +0200, Matthias Brugger wrote:
> 
> On 15/09/2022 18:18, Jason-JH.Lin wrote:
> > For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> > pipelines binding to 1 mmsys with the same power domain, the same
> > clock driver and the same mediatek-drm driver.
> > 
> > For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding
> > to
> > 2 different power domains, different clock drivers and different
> > mediatek-drm drivers.
> > 
> > Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> > CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
> > Quality)
> > and they makes VDOSYS0 supports PQ function while they are not
> > including in VDOSYS1.
> > 
> > Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> > component). It makes VDOSYS1 supports the HDR function while it's
> > not
> > including in VDOSYS0.
> > 
> > To summarize0:
> > Only VDOSYS0 can support PQ adjustment.
> > Only VDOSYS1 can support HDR adjustment.
> > 
> > Therefore, we need to separate these two different mmsys hardwares
> > to
> > 2 different compatibles for MT8195.
> > 
> > Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195
> > SoC binding")
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> >   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        |
> > 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > index 6ad023eec193..0e267428eaa6 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > @@ -31,7 +31,7 @@ properties:
> >                 - mediatek,mt8183-mmsys
> >                 - mediatek,mt8186-mmsys
> >                 - mediatek,mt8192-mmsys
> > -              - mediatek,mt8195-mmsys
> > +              - mediatek,mt8195-vdosys0
> 
> Nack, we miss the fallback compatible, as I already said twice.
> 
> Regards,
> Matthias

I'm sorry this happened again.
I'll keep the compatible "mediatek,mt8195-mmsys" at next version.

The patch "dt-bindings: arm: mediatek: mmsys: remove the unused
compatible for mt8195" should be sent after accepting the vdosys1
series, right?

Regards,
Jason-JH.Lin
> 
> >                 - mediatek,mt8365-mmsys
> >             - const: syscon
> >         - items:
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

