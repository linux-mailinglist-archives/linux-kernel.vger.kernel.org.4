Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A665BA3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIPBL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIPBL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:11:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370535281B;
        Thu, 15 Sep 2022 18:11:25 -0700 (PDT)
X-UUID: 9d14abbb1a114425abe224d8fdd7e27d-20220916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aC9p5EUciWE62FXN9xCu29LXkZgaSFsdB9J57e55t1U=;
        b=bov35MI20lo6NjA1sBWjEIFc2XrdaYjH9hP/GhM5/2AECz4hp2Gq0TxXNzb9Ln90HMOdMZlPlHoswUNc+LohcSwdSqQ45U0xhu8yLzaGUW5LPxIqEIT8e/YDsPAeWSRovW0FP2k8AWvIO6rt5zQAQwSH8K83ECC20RfP1tzviA8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d17b4d39-36f8-4f9d-b16f-0ec5aff9e2c5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:aa77d25d-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9d14abbb1a114425abe224d8fdd7e27d-20220916
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1707785144; Fri, 16 Sep 2022 09:11:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 16 Sep 2022 09:11:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Sep 2022 09:11:18 +0800
Message-ID: <d87203dea8d57868751dfbbce33d210e8976da7c.camel@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: arm: mediatek: mmsys: change
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
Date:   Fri, 16 Sep 2022 09:11:18 +0800
In-Reply-To: <a8e18b62-f49f-7c99-e046-3ee609e11627@gmail.com>
References: <20220914182331.20515-1-jason-jh.lin@mediatek.com>
         <20220914182331.20515-2-jason-jh.lin@mediatek.com>
         <1b739216-8bb1-162b-1af5-24acba7324bf@gmail.com>
         <296155e2a12a474439ba092e73b4bcffbf3d3edc.camel@mediatek.com>
         <a8e18b62-f49f-7c99-e046-3ee609e11627@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-15 at 18:20 +0200, Matthias Brugger wrote:
> Hi Jason,
> 
> On 15/09/2022 03:24, Jason-JH Lin wrote:
> > Hi Matthias,
> > 
> > Thanks for the reviews.
> > 
> > On Wed, 2022-09-14 at 23:24 +0200, Matthias Brugger wrote:
> > > 
> > > On 14/09/2022 20:23, Jason-JH.Lin wrote:
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
> > > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > 
> > > I'm not sure Krzysztof gave his Acked-by tag.
> > 
> > I'll remove this tag.
> > > 
> > > > ---
> > > >    .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml    
> > > >     |
> > > > 2 ++
> > > >    1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > index 6ad023eec193..a53b32c0a608 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > +++
> > > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > @@ -32,6 +32,8 @@ properties:
> > > >                  - mediatek,mt8186-mmsys
> > > >                  - mediatek,mt8192-mmsys
> > > >                  - mediatek,mt8195-mmsys
> > > > +              - mediatek,mt8195-vdosys0
> > > 
> > > As I said in the last submission, we should make mediatek,mt8195-
> > > mmsys as a
> > > fallback of vdosys0. Actually mediatek,mt8195-mmsys is only used
> > > for
> > > the
> > > fallback of vdosys0.
> > 
> > I think adding both vdosys0 and vdosys1 can make the description of
> > this patch clearer.
> > 
> > It's find to me to only add "mediatek,mt8195-vdosys0" in this
> > patch.
> > So I'll remove the "mediatek,mt8195-vdosys1" at the next version.
> > 
> 
> That's not what I wanted to suggest. Up to now in upstream kernel
> compatible 
> mediatek,mt8195-mmsys enables support fro vdosys0. The vdosys1 is not
> yet 
> upstream, so no support.
> If we change the compatible, we should keep mediatek,mt8195-mmsys as
> fallback of 
> "mediatek,mt8195-vdosys0" so that older device tree blobs won't break
> with a Mtk811
> newer kernel.
> For "mediatek,mt8195-vdosys1" we do not need a fallback compatible as
> the code 
> never reached upstream, so no breakage expected.
> 
> Hope I explain myself now.
> 
> Regards,
> Matthias
> 

I think I misunderstood your reply to the patch "dt-bindings: arm:
mediatek: mmsys: remove the unused compatible for mt8195", so I merge
it into this patch.

Thanks for your patient explanation.
I will keep the "mediatek,mt8195-
mmsys" in this patch.

Regards,
Jason-JH.Lin

> 
> > Regards,
> > Jason-JH.Lin
> > > 
> > > Regards,
> > > Matthias
> > > 
> > > > +              - mediatek,mt8195-vdosys1
> > > >                  - mediatek,mt8365-mmsys
> > > >              - const: syscon
> > > >          - items:
> > > 
> > > 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

