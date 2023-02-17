Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7168169B586
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBQWcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:32:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D35F82F;
        Fri, 17 Feb 2023 14:32:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB84562079;
        Fri, 17 Feb 2023 22:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD74C433EF;
        Fri, 17 Feb 2023 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676673134;
        bh=ljIRf4v/2Lck45BTBTKuuhmK3+RkCe6yFCOyrKX7H3I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R13VLdJsuoHYn0xU8tfr9mc13V7jn7ydQx+MIweScZeogkDB132Jv3B8bp86RCvRW
         uMWku/J8hS8vdLDuQOBQ3UYFETswKyLpNHvhBwXypGSlEkFY9INAbyrUq0X59XKnUJ
         Zmmrl5N1qMQQyvLQzDEJP5TRPlPwL1StkzuYz/bGFDsKvULYaj9XxlmBW+E1IQrARV
         r8ySbb9uHqTXGVfM8nq+JLqfa/K7Kyhtt4G/CF/5BsaYOKgm830t7zXG8D2xN3HY91
         GOnXe6QxpCAd3ujDY3SgT0yz1GfKB8+jKT3WxunNBBygBHlzR5TBb41UewvzvDhlfC
         xYJWgqyjCghzg==
Message-ID: <3601c73df55dd9d9756869817420f368.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2cfd99ac-a3fe-5014-1a51-19a0ee95eaa1@ti.com>
References: <20221226095745.19757-1-a-bhatia1@ti.com> <20221226095745.19757-2-a-bhatia1@ti.com> <8980856c1138571976f00413b94cfeb8.sboyd@kernel.org> <1856e963-4514-92f3-5d43-d5b711083193@ti.com> <367fba29-bc08-1f27-249c-09e406adfbbb@ideasonboard.com> <f324c845f0d291d041a13046a349ae95.sboyd@kernel.org> <2cfd99ac-a3fe-5014-1a51-19a0ee95eaa1@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: fixed-factor: Add TI AM62 SoC OLDI clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 17 Feb 2023 14:32:11 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aradhya Bhatia (2023-02-05 21:34:53)
> Hi Stephen,
>=20
> On 26-Jan-23 05:36, Stephen Boyd wrote:
> > Quoting Tomi Valkeinen (2023-01-17 01:40:24)
> >> On 16/01/2023 11:51, Aradhya Bhatia wrote:
> >>> Hi Stephen,
> >>>
> >>> Thanks for taking a look at the patch.
> >>>
> >>> On 12-Jan-23 01:14, Stephen Boyd wrote:
> >>>> Quoting Aradhya Bhatia (2022-12-26 01:57:44)
> >>>>> Add "ti,k3-am62-oldi-clk-div" to the fixed factor clock compatible =
enum
> >>>>> list.
> >>>>>
> >>>>> "ti,k3-am62-oldi-clk-div" is a fixed-factor clock that helps the TI
> >>>>> display subsystem request a pixel clock for itself and a correspond=
ing
> >>>>> serial clock for its OLDI Transmitters. The serial clock is 7 times=
 the
> >>>>> pixel clock. This clock needs the clock set rate request to be
> >>>>> propagated to the parent clock provider.
> >>>>>
> >>>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> >>>>> ---
> >>>>> =C2=A0 Documentation/devicetree/bindings/clock/fixed-factor-clock.y=
aml | 1 +
> >>>>> =C2=A0 1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git=20
> >>>>> a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml=20
> >>>>> b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> >>>>> index 8f71ab300470..0696237530f7 100644
> >>>>> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.ya=
ml
> >>>>> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.ya=
ml
> >>>>> @@ -14,6 +14,7 @@ properties:
> >>>>> =C2=A0=C2=A0=C2=A0 compatible:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fixed-factor-clock
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ti,k3-am62-oldi-clk-div
> >>>>
> >>>> I don't see this compatible anywhere in the kernel tree. Is there a
> >>>> patch that adds a node using this? I wonder why the display subsystem
> >>>> can't add this fixed factor clk directly in the driver. Does the OLDI
> >>>> Transmitter send a clk to the display subsystem?
> >>>>
> >>>> I'm asking all these questions because we got rid of vendor compatib=
les
> >>>> here in hopes of simplifying the logic. Maybe the problem can be
> >>>> approached differently, but I don't know all the details.
> >>>
> >>>
> >>> +--------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +------------------+
> >>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>> |=C2=A0 PLL=C2=A0=C2=A0 +---+----+------------->| OLDI Transmitter |
> >>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>> +--------+=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 +------------->| OLDI Transmitter |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 +----------+=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 /7=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Display=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +-->|=C2=A0=C2=A0 Clock=C2=A0 +--->| Sub-System (DSS) |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 Div=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +----------+=C2=A0=C2=A0=C2=A0 +------------=
------+
> >>>
> >>> This is how the the clock architecture for DSS looks like.
> >>>
> >>> The clock divider is not a part of DSS, but outside it.
> >=20
> > The divider is fixed as well? And presumably inside the SoC?
> Yes, and yes!

Ok.

>=20
> >=20
> >>>
> >>> The clock request flow is initiated by the DSS driver because it has =
the
> >>> required timing parameter information. It requests a certain pixel
> >>> frequency. But the frequency required by the OLDI TXes is 7 times
> >>> that pixel frequency.
> >>>
> >>> (Just for clarification, in some cases, the OLDI TX does require only
> >>> 3.5 times the pixel frequency, but in those situations there is anoth=
er
> >>> divider in-front of OLDI TX that gets activated with a signal and
> >>> divides the incoming frequency by 2, thereby requiring the PLL to sti=
ll
> >>> generate a 7x frequency.)
> >>>
> >>> Hence, the idea is that the clock divider is able to propagate the set
> >>> rate request back to PLL, asking for a frequency 7 times more than the
> >>> DSS's asking rate.
> >=20
> > Got it. Can the PLL driver provide a pll_div_7 clk that is used for the
> > DSS pixel clk?
> >=20
> The PLL driver can not map the clock divider and hence can't provide the
> pll_div_7 clock directly to DSS.

Isn't the divider fixed? So what is there to map?

>=20
> >>>
> >>> If this is something less than ideal and should not go up, then I can
> >>> implement a new clock device with a separate but similar clock driver.
> >>>
> >>> Let me know what you think!
> >>
> >> As a clarification I would also add to the above that on other TI SoCs=
=20
> >> with DSS, and also for the second video port on AM62, the clock=20
> >> framework provides DSS a clock using the pclk frequency.
> >>
> >=20
> > Are you saying that adding a fixed div-7 clk in the DSS driver is wrong?
> Yes. All variants of DSS accept a pixel clock and it would be wrong to
> implement a fixed div-7 in the DSS driver.

The reason being that it has an input of a pixel clk divided by 7?
That's why I suggested having the PLL provide a clk output that is
divided by 7.

>=20
> All that said, I now understand that the new compatible shouldn't go
> there. I will implement a new driver and post it. =3D)
>=20

The block diagram above shows the fixed divider living outside of the
PLL or display subsystem or OLDI transmitter(s). It could just as well
be drawn where the PLL has two outputs, one divided by 7 and sent as the
pixel clk and the other not divided by 7. For all I know the PLL and the
fixed divider are shipped by the same hardware engineer, so it looks
totally arbitrary.

Isn't it easier to _not_ create a struct device, _not_ create a
different device node, and simply make the PLL have another output clk,
so that we don't need to implement this as a new compatible string and
update the basic clk type code? To clarify, I don't understand why this
must be implemented through devicetree. We already have a driver for the
PLL and that knows what SoC it is, so why can't we add the fixed divider
there?
