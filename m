Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4E6081E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJUW6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJUW6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:58:53 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C8826FFA1;
        Fri, 21 Oct 2022 15:58:52 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1om0yX-0002ry-Ay; Sat, 22 Oct 2022 00:58:49 +0200
Date:   Fri, 21 Oct 2022 23:58:41 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: pwm: mediatek: Add compatible string
 for MT7986
Message-ID: <Y1MkIdFXrBrrv958@makrotopia.org>
References: <Y1K53n7LnjoMoIfj@makrotopia.org>
 <20221021222338.GA565200-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021222338.GA565200-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:23:38PM -0500, Rob Herring wrote:
> On Fri, Oct 21, 2022 at 04:25:18PM +0100, Daniel Golle wrote:
> > Add new compatible string for MT7986 PWM.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index 554c96b6d0c3e0..6f4e60c9e18b81 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >     - "mediatek,mt7623-pwm": found on mt7623 SoC.
> >     - "mediatek,mt7628-pwm": found on mt7628 SoC.
> >     - "mediatek,mt7629-pwm": found on mt7629 SoC.
> > +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
> 
> This version of the PWM h/w is not compatible with any of the existing 
> chips? If it is, it should have a fallback compatible.

No, it is unique because it comes with just 2 PWM channels.
Otherwise the driver behaves just like for MT8183 (4 channels) or
MT8365 (3 channels) which also got distinct compatible strings.

> 
> >     - "mediatek,mt8183-pwm": found on mt8183 SoC.
> >     - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm": found on mt8195 SoC.
> >     - "mediatek,mt8365-pwm": found on mt8365 SoC.
> > -- 
> > 2.38.1
> > 
> > 
> 
