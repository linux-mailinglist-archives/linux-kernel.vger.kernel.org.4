Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10A5B810F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiINFnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:43:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219A6C120;
        Tue, 13 Sep 2022 22:43:03 -0700 (PDT)
X-UUID: fc5106fa49fb4d63a2d5902ecb05f796-20220914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HiauB9ANq4Y2Q0NtJvs5OWH/ggmKqoFe3c2E0fWAmmw=;
        b=kmABBap7pgxwMUt7iFQj+xpj679zZxB3fCStH7ixjLbVI1NK+apPVL1Tsx8PNmMlZ+Hn0T9d4D6F1T6t5u1jjubNtNTBeTw2K9ZBkP4XRYuiahq4i5vYHV6DjCxERbrQVHpUW77z8cg293DsLfJ2dDlRtVBvQbwr8oQ92m+luzs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:7b7e2adc-34c4-4bd8-bc16-9c5e8d520b06,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:69b75dec-2856-4fce-b125-09d4c7ebe045,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fc5106fa49fb4d63a2d5902ecb05f796-20220914
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 383026811; Wed, 14 Sep 2022 13:42:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 14 Sep 2022 13:42:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Sep 2022 13:42:55 +0800
Message-ID: <207b8c4ef0999a7b859c5e2eaf270293d2f18f75.camel@mediatek.com>
Subject: Re: [PATCH 2/7] dt-bindings: phy: mediatek,tphy: add property to
 set pre-emphasis
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Wed, 14 Sep 2022 13:42:55 +0800
In-Reply-To: <8090e2e1-afce-9341-2ae7-3f4e094409b6@linaro.org>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
         <20220819091344.2274-2-chunfeng.yun@mediatek.com>
         <438da392-f419-ad76-7e91-aa4aab36e12c@linaro.org>
         <816ecf6287533137b750c8bde9de5830e4229c56.camel@mediatek.com>
         <bee8abe5-0299-d05e-643c-4810aa33f978@linaro.org>
         <1a16cce9fe164bafc06ae193310be71c6f645d75.camel@mediatek.com>
         <000babd8-5980-3d77-f156-324b3442cbe7@linaro.org>
         <114c357f8d7f049d21ede789a292a8e2d45f4c61.camel@mediatek.com>
         <0a82842d-283c-e266-84f4-6306f29b61da@linaro.org>
         <8dcb4de53a52ab44d40f490099b6ed13e5ef7fe0.camel@mediatek.com>
         <3c180570-ecf9-3db4-c698-39c1b4679c6e@linaro.org>
         <3b18a9c687af38f7299261c9a589ef3dfc5a1aa7.camel@mediatek.com>
         <8090e2e1-afce-9341-2ae7-3f4e094409b6@linaro.org>
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

On Fri, 2022-09-09 at 10:27 +0200, Krzysztof Kozlowski wrote:
> On 09/09/2022 05:03, Chunfeng Yun wrote:
> > On Wed, 2022-08-31 at 09:03 +0300, Krzysztof Kozlowski wrote:
> > > On 31/08/2022 06:00, Chunfeng Yun wrote:
> > > > On Tue, 2022-08-30 at 13:08 +0300, Krzysztof Kozlowski wrote:
> > > > > On 29/08/2022 05:37, Chunfeng Yun wrote:
> > > > > > On Fri, 2022-08-26 at 09:36 +0300, Krzysztof Kozlowski
> > > > > > wrote:
> > > > > > > On 26/08/2022 08:36, Chunfeng Yun wrote:
> > > > > > > > On Tue, 2022-08-23 at 13:24 +0300, Krzysztof Kozlowski
> > > > > > > > wrote:
> > > > > > > > > On 22/08/2022 10:07, Chunfeng Yun wrote:
> > > > > > > > > > On Fri, 2022-08-19 at 15:15 +0300, Krzysztof
> > > > > > > > > > Kozlowski
> > > > > > > > > > wrote:
> > > > > > > > > > > On 19/08/2022 12:13, Chunfeng Yun wrote:
> > > > > > > > > > > > Add a property to set usb2 phy's pre-emphasis.
> > > > > > > > > > > > 
> > > > > > > > > > > > Signed-off-by: Chunfeng Yun <
> > > > > > > > > > > > chunfeng.yun@mediatek.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  Documentation/devicetree/bindings/phy/mediatek
> > > > > > > > > > > > ,tph
> > > > > > > > > > > > y.ya
> > > > > > > > > > > > ml |
> > > > > > > > > > > > 7
> > > > > > > > > > > > +++++++
> > > > > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/Documentation/devicetree/bindings/phy/mediate
> > > > > > > > > > > > k,tp
> > > > > > > > > > > > hy.y
> > > > > > > > > > > > aml
> > > > > > > > > > > > b/Documentation/devicetree/bindings/phy/mediate
> > > > > > > > > > > > k,tp
> > > > > > > > > > > > hy.y
> > > > > > > > > > > > aml
> > > > > > > > > > > > index 848edfb1f677..aee2f3027371 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/Documentation/devicetree/bindings/phy/mediate
> > > > > > > > > > > > k,tp
> > > > > > > > > > > > hy.y
> > > > > > > > > > > > aml
> > > > > > > > > > > > +++
> > > > > > > > > > > > b/Documentation/devicetree/bindings/phy/mediate
> > > > > > > > > > > > k,tp
> > > > > > > > > > > > hy.y
> > > > > > > > > > > > aml
> > > > > > > > > > > > @@ -219,6 +219,13 @@ patternProperties:
> > > > > > > > > > > >          minimum: 1
> > > > > > > > > > > >          maximum: 15
> > > > > > > > > > > >  
> > > > > > > > > > > > +      mediatek,pre-emphasis:
> > > > > > > > > > > > +        description:
> > > > > > > > > > > > +          The selection of pre-emphasis (U2
> > > > > > > > > > > > phy)
> > > > > > > > > > > > +        $ref:
> > > > > > > > > > > > /schemas/types.yaml#/definitions/uint32
> > > > > > > > > > > > +        minimum: 1
> > > > > > > > > > > > +        maximum: 3
> > > > > > > > > > > 
> > > > > > > > > > > Instead of hard-coding register values in
> > > > > > > > > > > bindings,
> > > > > > > > > > > you
> > > > > > > > > > > should
> > > > > > > > > > > rather
> > > > > > > > > > > describe here feature/effect. If it is in units,
> > > > > > > > > > > use
> > > > > > > > > > > unit
> > > > > > > > > > > suffixes.
> > > > > > > > > > > If
> > > > > > > > > > > it is some choice, usually string enum is
> > > > > > > > > > > appropriate.
> > > > > > > > > > 
> > > > > > > > > > How about changing description as bellow:
> > > > > > > > > > 
> > > > > > > > > > "The level of pre-emphasis, increases one level,
> > > > > > > > > > boosts
> > > > > > > > > > the
> > > > > > > > > > relative
> > > > > > > > > > amplitudes of signal's higher frequencies
> > > > > > > > > > components
> > > > > > > > > > about
> > > > > > > > > > 4.16%
> > > > > > > > > > (U2
> > > > > > > > > > phy)"
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Still the question is what is the unit. 4.16%?
> > > > > > > > 
> > > > > > > > No unit, it's a level value, like an index of array.
> > > > > > > > 
> > > > > > > 
> > > > > > > So a value from register/device programming? 
> > > > > > 
> > > > > > Yes
> > > > > > > Rather a regular units
> > > > > > > should be used if that's possible. If not, this should be
> > > > > > > clearly
> > > > > > > described here, not some magical number which you encode
> > > > > > > into
> > > > > > > DTS...
> > > > > > 
> > > > > > Ok, I'll add more descriptions.
> > > > > 
> > > > > Better use logical value, e.g.
> > > > > 
> > > > 
> > > > 
> > 
> > 
https://urldefense.com/v3/__https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml*L38__;Iw!!CTRNKA9wMg0ARbw!1e-h0R_uwcaHKfKC9qYfaRWYeuWRq1sLCGy3yupNmkFyuW5s1nmRotL7Y0vFG9ETLLTA$
> > > > >  
> > > > 
> > > > Optional unit may be -percent or -bp, but the value 4.16% * X
> > > > (X=1,2,3...)is not an exact value, they are variable in a range
> > > > and
> > > > dependent more factors.
> > > > So I think use level value is simple enough.
> > > 
> > > Then again explain exactly what are the levels. How you wrote it
> > > last
> > > time, -bp would do the trick.
> > 
> > There are many different methods of measuring pre-emphasis.
> > The way used in MediaTek USB2 PHY as below:
> > 
> > pre-emphasis level equation = Vpp/Vs -1;
> > Vpp: peak-peak voltage of differential signal;
> > Vs : static voltage of differential signal, normal voltage, e.g.
> > 400mV
> > for u2 phy;
> > 
> > The pre-emphasis circuitry within t-phy can be dynamically
> > programmed
> > to three different levels of pre-emphasis. The exact value of
> > pre-emphasis cannot be predetermined, because each device requires
> > a percentage of pre-emphasis that is dependent on the output signal
> > strength and transmission path characteristics.
> > 
> > Below shows three programmable pre-emphasis levels for a
> > differential
> > drive signal of 400 mV. The amount of pre-emphasis changes
> > according
> > to the transmission path parameters.
> > 
> > programmable level   typical pre-emphasis level
> > 1                    4.16%
> > 2                    8.30%
> > 3                    12.40%
> > 
> > The reasons that why prefer to use programmable level in dt-binding 
> > as
> > following:
> > 1. as you said, -bp may do the trick, but the main problem is that
> >    pre-emphasis level is variable on different SoC, and is also
> >    variable even on different pcb for the same SoC. e.g. for the
> >    programmable level 1, pre-emphasis level may be 6% on a
> > platform,
> >    but for the programmable level 2, pre-emphasis level may be also
> >    6% on another platform;
> >    I think use pre-emphasis level in property, e.g. 4.16%, the
> >    deviation may be bigger than 40%, may cause confusion for users,
> >    due to we can't promise that the actual measurement is about
> > 4.16%,
> >    it may be 2%, or 5% when measured;
> > 2. the programmable / logical level is flexible when we support
> > more
> >    and pre-emphasis level, ans it is easy for us to tune the level
> >    due to it's continuous value.
> > 3. all other vendor properties that can't provide exact measurable
> >    value in this dt-binding make use of logic level, I want to
> >    keep them align;
> 
> Hm, that's clarifies a lot. Thanks for explanation.
I couldn't know more about pre-emphasis without your questions, thank
you very much.

>  It's ok for me.
> 
> 
> Best regards,
> Krzysztof

