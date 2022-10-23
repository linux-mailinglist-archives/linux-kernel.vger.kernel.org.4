Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147C660947D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJWPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJWPpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:45:09 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3B3FD4E;
        Sun, 23 Oct 2022 08:45:08 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1omd9s-00009i-PB; Sun, 23 Oct 2022 17:45:04 +0200
Date:   Sun, 23 Oct 2022 16:45:02 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: pwm: mediatek: Add compatible string
 for MT7986
Message-ID: <Y1VhfqBqshkM7mNR@makrotopia.org>
References: <Y1K53n7LnjoMoIfj@makrotopia.org>
 <20221021222338.GA565200-robh@kernel.org>
 <Y1MkIdFXrBrrv958@makrotopia.org>
 <5182e3c4-9e5e-2c36-408b-9029c65c8803@linaro.org>
 <Y1UycU0JvwyAv0x2@makrotopia.org>
 <eab019f7-f801-848e-80a3-5bb526d95d53@linaro.org>
 <Y1VXTlQ1dCSoE8N2@makrotopia.org>
 <261cd2fb-05dc-3772-dcc7-3ab1f3c0222c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <261cd2fb-05dc-3772-dcc7-3ab1f3c0222c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 11:29:45AM -0400, Krzysztof Kozlowski wrote:
> On 23/10/2022 11:01, Daniel Golle wrote:
> > On Sun, Oct 23, 2022 at 08:39:34AM -0400, Krzysztof Kozlowski wrote:
> >> On 23/10/2022 08:24, Daniel Golle wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On Sat, Oct 22, 2022 at 12:35:25PM -0400, Krzysztof Kozlowski wrote:
> >>>> On 21/10/2022 18:58, Daniel Golle wrote:
> >>>>> On Fri, Oct 21, 2022 at 05:23:38PM -0500, Rob Herring wrote:
> >>>>>> On Fri, Oct 21, 2022 at 04:25:18PM +0100, Daniel Golle wrote:
> >>>>>>> Add new compatible string for MT7986 PWM.
> >>>>>>>
> >>>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >>>>>>> ---
> >>>>>>>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
> >>>>>>>  1 file changed, 1 insertion(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> >>>>>>> index 554c96b6d0c3e0..6f4e60c9e18b81 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> >>>>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> >>>>>>> @@ -8,6 +8,7 @@ Required properties:
> >>>>>>>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
> >>>>>>>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
> >>>>>>>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
> >>>>>>> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
> >>>>>>
> >>>>>> This version of the PWM h/w is not compatible with any of the existing 
> >>>>>> chips? If it is, it should have a fallback compatible.
> >>>>>
> >>>>> No, it is unique because it comes with just 2 PWM channels.
> >>>>> Otherwise the driver behaves just like for MT8183 (4 channels) or
> >>>>> MT8365 (3 channels) which also got distinct compatible strings.
> >>>>
> >>>> Then something would be here compatible. E.g. If you bound MT8183 with
> >>>> mt7986-pwm compatible, would you get working device with two channels?
> >>>
> >>> Yes, but I'd see another 2 channels which do not work, accessing them
> >>> may even cause problems (I haven't tried that) as it means accessing
> >>> an undocumented memory range of the SoC which we in general we
> >>> shouldn't be messing around with.
> >>
> >> Why on MT8183 there would be undocumented memory? Where is undocumented
> >> memory?
> > 
> > So we were talking about using the MT8183 compatible for MT7986 SoC, as
> > the PWM units are identical apart from the number of channels they
> > offer:
> 
> No, we talk about MT8183 with mt7986-pwm compatible. Read again my message.

Ok, that was not clear to me. I understood the other way around, to use
`mediatek,mt8183-pwm` on MT7986 (and not even introduce an additional
compatible for MT7986 in the driver, but only list it as compatibly with
existing MT8183 in binding docs).

So: The to-be newly introduced `mediatek,mt7986-pwm` should work on
MT8183 as well, but in that case only two of the four channels would be
accessible.

> 
> > 
> > MT7986 got 2 PWM channels. The MMIO registers used for those two
> > channels start at offsets 0x10 (pwm0) and 0x50 (pwm1)
> > 
> > MT8183 got 4 PWM channels. The MMIO registers used for those four
> > channels start of offsets 0x10 (pwm0), 0x50 (pwm1), 0x90 (pwm2) and
> > 0xd0 (pwm3).
> > 
> > Hence, when using the MT8183 compatible with MT7986, the driver will
> > access offsets 0x90 and 0xd0 in case the users enables the (bogus)
> > outputs pwm2 and pwm3. These offsets, however, are not mentioned in the
> > datasheet, so it has to be considered that writing things to these
> > undocumented offsets could cause unknown behavior.
> > 
> > I hope it's more clear now what I mean.
> 
> But even your case is not correct. On MT7986 the device would still have
> 2 channels, how the heck he would get 4? Driver binds to ,t7986-pwm
> compatible, which defines 2 channels.

If we do introduce that new compatible, then yes.
I understood you were suggesting to use `mediatek,mt8183` on MT7986
hardware which would have resulted in such behavior.

> 
> > 
> >>
> >>>
> >>> Also note that this case is the same as MT8183 vs. MT8365, they got
> >>> distinct compatible strings and also for those two the only difference
> >>> is the number of channels.
> >>
> >> So why they are not made compatible?
> > 
> > My guess is that it's for this very reason:
> > To correctly communicate the capabilities (in this case: number of
> > channels) to the driver and not have bogus pwmX show up in the OS
> > which then causes undocumented MMIO register access in case anyone
> > tries to actually use them.
> 
> No, that's not correct reason. There would be no wrong MMIO access and
> capabilities would be still correctly communicated.

So what exactly do you mean by "made compatible"?
In the driver? In DTS files? In DT-bindings?

> 
> > 
> >>
> >>>
> >>>>
> >>>> If so, they are compatible.
> >>>
> >>> By that definition you should remove the additional compatible for
> >>> MT8365 or rather, it should have been rejected for the same argument.
> >>>
> >>> I'm talking about
> >>> commit fe00faee8060402a3d85aed95775e16838a6dad2
> >>> commit 394b517585da9fbb2eea2f2103ff47d37321e976
> >>
> >> This is a pattern spreading in several Mediatek bindings and we already
> >> commented on new patches. I don't know why people working on Mediatek do
> >> not mark pieces compatible.
> > 
> > Others will have to answer that for you.
> > 
> > To me this looks a bit like a structural shortcoming of the PWM controller
> > bindings: if there was a way to tell the driver "hey, this is like MT8183,
> > but it got only two channels" that would solve it nicely.
> > This could either be done using child-nodes for each PWM channel or by
> > simply adding a 'nr-pwms' property.
> 
> No, it's rather someone did not think about Devicetree compatibles or
> did not care to design the Mediatek bindings and just copy-paste
> existing pattern...

So in that case, maybe those existing patterns should be cleaned up?
Can you suggest a change? (even informal, I can wrap it up as patch).

To me, code is almost always better documentation than actual
documentation, which is usually time consuming to read, hard to
understand (compared to reading code or existing examples), and it's
commonly full of errors. I hardly waste my time with it, if there is
code or existing examples, I will always prefer do read and understand
that.


Cheers


Daniel
