Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C855BC0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiISB1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiISB05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:26:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FF18383;
        Sun, 18 Sep 2022 18:26:49 -0700 (PDT)
X-UUID: 35544346aa4344c4aaffec1f52702330-20220919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=s3/mQJDAI8RaGvwS50/sSfM3dEzv5HFd1WDBKbk/QrE=;
        b=RbZFb2KOPK+WwjuvFG4JxLna+rt5kZNqAuQcbOeDV+6sE0EWr9wdNH8mZjoOpT1Q/6iSSK56onFlz0QMx0SsWTLr4w3iDjpIUWApLmDOBgO7VjsEnNFjQxhjcEAWAC17vJrvSnsNv+iSo/tJsz3PLLcJ5k9uNCRNVK24C0zjoC0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:cbf665b8-85a3-48b8-807a-56898a6583b8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.11,REQID:cbf665b8-85a3-48b8-807a-56898a6583b8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:39a5ff1,CLOUDID:d610d0f6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:2209160605436LY6U0LQ,BulkQuantity:208,Recheck:0,SF:28|17|19|48|823|8
        24,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil
        ,COL:0
X-UUID: 35544346aa4344c4aaffec1f52702330-20220919
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1177479252; Mon, 19 Sep 2022 09:26:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Sep 2022 09:26:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Sep 2022 09:26:35 +0800
Message-ID: <871b6996647bdc71723569a56e7f238f325fa9c7.camel@mediatek.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 19 Sep 2022 09:26:35 +0800
In-Reply-To: <17cacc6f-173f-ad6c-9056-1b17635c984d@linaro.org>
References: <20220915161817.10307-1-jason-jh.lin@mediatek.com>
         <20220915161817.10307-2-jason-jh.lin@mediatek.com>
         <e6921ed7-a14c-aadb-abd4-1e7ee0a63be9@gmail.com>
         <f30bd382eb8923256d6f39342ec7832774c0f547.camel@mediatek.com>
         <17cacc6f-173f-ad6c-9056-1b17635c984d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the reviews.

On Sun, 2022-09-18 at 10:31 +0100, Krzysztof Kozlowski wrote:
> On 16/09/2022 04:34, Jason-JH Lin wrote:
> > Hi Matthias,
> > 
> > Thanks for the review.
> > 
> > On Fri, 2022-09-16 at 00:05 +0200, Matthias Brugger wrote:
> > > 
> > > On 15/09/2022 18:18, Jason-JH.Lin wrote:
> > > > For previous MediaTek SoCs, such as MT8173, there are 2 display
> > > > HW
> > > > pipelines binding to 1 mmsys with the same power domain, the
> > > > same
> > > > clock driver and the same mediatek-drm driver.
> > > > 
> > > > For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines
> > > > binding
> > > > to
> > > > 2 different power domains, different clock drivers and
> > > > different
> > > > mediatek-drm drivers.
> > > > 
> > > > Moreover, Hardware pipeline of VDOSYS0 has these components:
> > > > COLOR,
> > > > CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
> > > > Quality)
> > > > and they makes VDOSYS0 supports PQ function while they are not
> > > > including in VDOSYS1.
> > > > 
> > > > Hardware pipeline of VDOSYS1 has the component ETHDR (HDR
> > > > related
> > > > component). It makes VDOSYS1 supports the HDR function while
> > > > it's
> > > > not
> > > > including in VDOSYS0.
> > > > 
> > > > To summarize0:
> > > > Only VDOSYS0 can support PQ adjustment.
> > > > Only VDOSYS1 can support HDR adjustment.
> > > > 
> > > > Therefore, we need to separate these two different mmsys
> > > > hardwares
> > > > to
> > > > 2 different compatibles for MT8195.
> > > > 
> > > > Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add
> > > > mt8195
> > > > SoC binding")
> > > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > > ---
> > > >  
> > > > .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml       
> > > >  |
> > > > 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > index 6ad023eec193..0e267428eaa6 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > +++
> > > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > @@ -31,7 +31,7 @@ properties:
> > > >                 - mediatek,mt8183-mmsys
> > > >                 - mediatek,mt8186-mmsys
> > > >                 - mediatek,mt8192-mmsys
> > > > -              - mediatek,mt8195-mmsys
> > > > +              - mediatek,mt8195-vdosys0
> > > 
> > > Nack, we miss the fallback compatible, as I already said twice.
> > > 
> > > Regards,
> > > Matthias
> > 
> > I'm sorry this happened again.
> > I'll keep the compatible "mediatek,mt8195-mmsys" at next version.
> > 
> > The patch "dt-bindings: arm: mediatek: mmsys: remove the unused
> > compatible for mt8195" should be sent after accepting the vdosys1
> > series, right?
> 
> I don't think there will be no such patch...
> 
> You need to add a bindings change which will accept device nodes
> like:
> foo {
>   compatible = "mediatek,mt8195-vdosys0", "mediatek,mt8195-mmsys";
> 
> }
> 
> Example-schema shows how to do it.

OK, I got the point!
I'll fix it at the next version.
Thank you very much!

Regards,
Jason-JH.Lin

> 
> Best regards,
> Krzysztof
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

