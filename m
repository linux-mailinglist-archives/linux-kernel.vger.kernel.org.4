Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737C15B936F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 06:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIOEAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 00:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOEAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 00:00:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CA7FE46;
        Wed, 14 Sep 2022 21:00:46 -0700 (PDT)
X-UUID: 00915933d2e14e81b4d06fabd70aef1f-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QyzP8AuS/Yj0m/junatFACxq+Em7ckmn0zUUcXx/+6Y=;
        b=jNUOM6Aa7TMxJMOdy654GIdhBC/Oc19rbw9iyarUcTXy8t2X49Svo/F7pMC0Gp9muKzAiYNKUC/hV5ssILbODkJF+JCwa8Szo52PDeu8+hcWbCtwWfPGDQYt2VohlVbUA1efBRZW9doJv/VeuzTNb5GqYK76fjAibpGIapiozvs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:16e903de-09ca-4471-b54e-783b31bc17a6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:3e3bb65d-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 00915933d2e14e81b4d06fabd70aef1f-20220915
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 48536846; Thu, 15 Sep 2022 12:00:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 12:00:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 15 Sep 2022 12:00:40 +0800
Message-ID: <47ad92dfc593681508fcf09df1303cdfe86c4202.camel@mediatek.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Date:   Thu, 15 Sep 2022 12:00:40 +0800
In-Reply-To: <06eb15ea-56b3-4f18-be18-3fc710cef779@collabora.com>
References: <20220914124552.16964-1-johnson.wang@mediatek.com>
         <20220914124552.16964-3-johnson.wang@mediatek.com>
         <06eb15ea-56b3-4f18-be18-3fc710cef779@collabora.com>
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

Hi Angelo,

Thanks for your review.

On Wed, 2022-09-14 at 15:46 +0200, AngeloGioacchino Del Regno wrote:
> Il 14/09/22 14:45, Johnson Wang ha scritto:
> > Add the new binding documentation for MediaTek frequency hopping
> > and spread spectrum clocking control.
> > 
> > Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> > Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > ---
> >   .../bindings/arm/mediatek/mediatek,fhctl.yaml | 47
> > +++++++++++++++++++
> >   1 file changed, 47 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
> > l
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
> > l
> > new file mode 100644
> > index 000000000000..7b0fd0889bb6
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
> > l
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml*__;Iw!!CTRNKA9wMg0ARbw!3sumdhtrK5Ah5_rfIilgm4UUmnwkkqMpc3r_ZfkLfsXsLn-_AKm9ZokhJGD1Fl-gJpckAKHZh-jNVW64KRU8Duv1kg$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!3sumdhtrK5Ah5_rfIilgm4UUmnwkkqMpc3r_ZfkLfsXsLn-_AKm9ZokhJGD1Fl-gJpckAKHZh-jNVW64KRWMb8jIsw$
> >  
> > +
> > +title: MediaTek frequency hopping and spread spectrum clocking
> > control
> > +
> > +maintainers:
> > +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
> > +
> > +description: |
> > +  Frequency hopping control (FHCTL) is a piece of hardware that
> > control
> > +  some PLLs to adopt "hopping" mechanism to adjust their
> > frequency.
> > +  Spread spectrum clocking (SSC) is another function provided by
> > this hardware.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8186-fhctl
> > +
> > +  reg:
> > +    maxItems: 1
> 
> There are still a few issues in this binding that I can immediately
> see...
> 
> > +
> > +  clocks:
> 
> MT8195 has 23 PLLs, MT8186 has 14, but perhaps in the future we may
> see
> something more than that on some newer SoC, so...
> 
>    clocks:
>      maxItems: 30

May I add "minItems: 1" to clocks property?

Without this, dt_binding_check will fail because we don't have enough
clocks in the example. (Both MT8195 and MT8186 don't have 30 PLLs)

> 
> > +    description: Phandles of the PLL with FHCTL hardware
> > capability.
> > +
> > +  mediatek,hopping-ssc-percents:
> > +    description: The percentage of spread spectrum clocking for
> > one PLL.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> This is an array, so...
> $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> ...also, maxItems?

As you know, mediatek,hopping-ssc-percents property is used to specify
ssc rate for matching clocks.

If we have to add maxItems, I think we should specify the same value
as clocks property. Is my understanding wrong?


Thanks!

BRs,
Johnson Wang
> 
> and you should also specify:
> 
> default: 0   <- because, by default, SSC is disabled
> minimum: 0   <- because this is the minimum accepted value
> 
> 
> Regards,
> Angelo
> 
> > +    maximum: 8
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8186-clk.h>
> > +    fhctl: fhctl@1000ce00 {
> > +        compatible = "mediatek,mt8186-fhctl";
> > +        reg = <0x1000c000 0xe00>;
> > +        clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
> > +        mediatek,hopping-ssc-percents = <3>;
> > +    };
> 
> 

