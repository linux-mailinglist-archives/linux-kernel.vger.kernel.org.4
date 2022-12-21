Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7801653059
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiLULoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLULoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:44:32 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DF5272D;
        Wed, 21 Dec 2022 03:44:29 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p7xWM-0005Zr-Jf; Wed, 21 Dec 2022 12:44:26 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ty <zonyitoo@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
Date:   Wed, 21 Dec 2022 12:44:25 +0100
Message-ID: <2673859.iZASKD2KPV@diego>
In-Reply-To: <CAMmci2UgwqDyPPJXwGRsMW1Y1Cy2c6LMybk+7v7pGz-LtYzGTw@mail.gmail.com>
References: <Y6KfFEChA67E7oX/@VM-66-53-centos> <5a7907e3-f79e-5de9-ed1b-ec24ea52c437@linaro.org> <CAMmci2UgwqDyPPJXwGRsMW1Y1Cy2c6LMybk+7v7pGz-LtYzGTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. Dezember 2022, 11:46:36 CET schrieb ty:
> Dear Kozlowski,
> 
> Sorry that we didn't fully get the idea in your previous comments.
> 
> >
> > On 21/12/2022 06:52, Yuteng Zhong wrote:
> > > from: DHDAXCW <lasstp5011@gmail.com>
> > >
> > > LubanCat 1 is a Rockchip RK3566 SBC based
> > > is developed by EmbedFire Electronics Co., Ltd.
> > > Mini Linux Card Type Cheap Computer Development Board
> >
> > This is a friendly reminder during the review process.
> >
> > It seems my previous comments were not fully addressed. Maybe my
> > feedback got lost between the quotes, maybe you just forgot to apply it.
> > Please go back to the previous discussion and either implement all
> > requested changes or keep discussing them.
> >
> > Thank you.
> 
> Your pervious comment were:
> 
> > Please wrap commit message according to Linux coding style / submission
> > process:
> > https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
> 
> So I think there must be something wrong in the message but I didn't
> notice. This message has a `from` line, and the body was wrapped at 75
> columns. Please help me make it better.
> 
> 
> 
> > >
> > > Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> > > Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > index 88ff4422a8c1..84d39a3a8843 100644
> > > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > @@ -781,6 +781,11 @@ properties:
> > >            - const: rockchip,rk3568-bpi-r2pro
> > >            - const: rockchip,rk3568
> > >
> > > +      - description: EmbedFire LubanCat 1
> > > +        items:
> > > +          - const: embedfire,lubancat-1
> > > +          - const: rockchip,rk3566
> >
> > Here as well.
> 
> This change was addressing the previous comment in V2:
> 
> > This is separate patch. Does not look like properly ordered. Don't add
> > stuff at the end of files/lists.

for context sorting order in that file is alphabetical by description


Heiko


