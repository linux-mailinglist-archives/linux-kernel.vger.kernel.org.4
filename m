Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028DD6ED2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjDXQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjDXQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:52:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43C3C0D;
        Mon, 24 Apr 2023 09:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31C6B61A0D;
        Mon, 24 Apr 2023 16:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F60C433D2;
        Mon, 24 Apr 2023 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682355148;
        bh=4dY2lhCrM10R5LeBARPmKkqvvI9U2quAejbu+lxfOTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZmO8JEi6qzEqNA0EaJPi86lAmpWLp7Z3rqsp32sOfQadboT2ylNc3rsVkZx2XFB/
         l32F6pneY6AN1ArZAZEEzptSR2+VWuwtKfhdr8xtaKnlBh2oKb4bTsz08sH1Fy8908
         YOWqdtEdsEhMDdSz6uIAmvEeLbZvbD8ZMvsiZureGkA4nO5VEaYPiQ0BVUeW4irell
         QFQmQ234FqIxdqNoOXDGcmlKRCRJU9P3qC/4oKZ9PvMl0Zg/VTnC11GjoXfKNkmBIQ
         03BvTZCPzmqYikVlk+KWVByY5KsQBYa0mAL2wBeWybRtOo1TebxGevYdgJaD3z5lou
         e/jSi6unuDTsg==
Date:   Mon, 24 Apr 2023 17:52:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230424-baffle-punch-ec73098f2b6a@spud>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
 <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6HlvDwIotWNMJfjO"
Content-Disposition: inline
In-Reply-To: <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6HlvDwIotWNMJfjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Changhuang,

On Thu, Apr 20, 2023 at 03:00:10PM +0800, Changhuang Liang wrote:
> On 2023/4/20 2:29, Conor Dooley wrote:
> > On Tue, Apr 18, 2023 at 08:56:41PM -0700, Changhuang Liang wrote:
> >> Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY
> >> rx/tx power switch, and it don't need the properties of reg and
> >> interrupts.
> >=20
> > Putting this here since the DT guys are more likely to see it this way..
> > Given how the implementation of the code driving this new
> > power-controller and the code driving the existing one are rather
> > different (you've basically re-written the entire driver in this series=
),
> > should the dphy driver implement its own power-controller?
> >=20
> > I know originally Changuang had tried something along those lines:
> > https://lore.kernel.org/linux-riscv/5dc4ddc2-9d15-ebb2-38bc-8a544ca67e0=
d@starfivetech.com/
> >=20
> > I see that that was shut down pretty much, partly due to the
> > non-standard property, hence this series adding the dphy power domain to
> > the existing driver.
> >=20
> > If it was done by looking up the pmu with a
> > of_find_compatible_node(NULL, "power-controller", "starfive,jh7110-aon-=
pmu")
> > type thing, would that make sense? Although, maybe that is not a
> > question for you, and this series may actually have been better entirely
> > bundled with the dphy series so the whole thing can be reviewed as a
> > unit. I've added=20
> >=20
> > IOW, don't change this patch, or the dts patch, but move all of the
> > code back into the phy driver..
> >=20
>=20
> Maybe this way can not do that? power domain is binding before driver pro=
be,
> if I use "of_find_compatible_node" it phy(DPHY rx) probe. Maybe I can onl=
y operate=20
> this power switch in my phy(DPHY rx) driver, so the all patch of this ser=
ies isn't=20
> make sense.

I'm a wee bit lost here, as I unfortunately know little about how Linux
handles this power-domain stuff. If the DPHY tries to probe and some
pre-requisite does not yet exist, you can return -EPROBE_DEFER right?

But I don't think that's what you are asking, as using
of_find_compatible_node() doesn't depend on there being a driver AFAIU.

> In my opinion, We will also submit DPHY TX module later which use this se=
ries.
> Maybe this series should independent?

Is the DPHY tx module a different driver to the rx one?
If yes, does it have a different bit you must set in the syscon?

+CC Walker, do you have a register map for the jh7110? My TRM only says
what the registers are, but not the bits in them. Would make life easier
if I had that info.

I'm fine with taking this code, I just want to make sure that the soc
driver doing this is the right thing to do.
I was kinda hoping that combining with the DPHY-rx series might allow
the PHY folk to spot if you are doing something here with the power
domains that doesn't make sense.

> > Sorry for not asking this sooner Changhuang,
> > Conor.
> >=20
> > (hopefully this didn't get sent twice, mutt complained of a bad email
> > addr during sending the first time)
> >=20
>=20
> I'm sorry for that, I will notice later.

No, this was my mail client doing things that I was unsure of. You
didn't do anything wrong.

> >> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> >> ---
> >>  .../bindings/power/starfive,jh7110-pmu.yaml       | 15 +++++++++++++--
> >>  include/dt-bindings/power/starfive,jh7110-pmu.h   |  3 +++
> >>  2 files changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/starfive,jh7110-p=
mu.yaml b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> >> index 98eb8b4110e7..c50507c38e14 100644
> >> --- a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> >> +++ b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> >> @@ -8,6 +8,7 @@ title: StarFive JH7110 Power Management Unit
> >> =20
> >>  maintainers:
> >>    - Walker Chen <walker.chen@starfivetech.com>
> >> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> >> =20
> >>  description: |
> >>    StarFive JH7110 SoC includes support for multiple power domains whi=
ch can be
> >> @@ -17,6 +18,7 @@ properties:
> >>    compatible:
> >>      enum:
> >>        - starfive,jh7110-pmu
> >> +      - starfive,jh7110-aon-pmu

I was speaking to Rob about this over the weekend, he asked:
'Why isn't "starfive,jh7110-aon-syscon" just the power-domain provider
itself?'
Do we actually need to add a new binding for this at all?

Cheers,
Conor.

> >> =20
> >>    reg:
> >>      maxItems: 1
> >> @@ -29,10 +31,19 @@ properties:
> >> =20
> >>  required:
> >>    - compatible
> >> -  - reg
> >> -  - interrupts
> >>    - "#power-domain-cells"
> >> =20
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: starfive,jh7110-pmu
> >> +    then:
> >> +      required:
> >> +        - reg
> >> +        - interrupts
> >> +
> >>  additionalProperties: false
> >> =20
> >>  examples:
> >> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include=
/dt-bindings/power/starfive,jh7110-pmu.h
> >> index 132bfe401fc8..0bfd6700c144 100644
> >> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
> >> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> >> @@ -14,4 +14,7 @@
> >>  #define JH7110_PD_ISP		5
> >>  #define JH7110_PD_VENC		6
> >> =20
> >> +#define JH7110_PD_DPHY_TX	0
> >> +#define JH7110_PD_DPHY_RX	1
> >> +
> >>  #endif
> >> --=20
> >> 2.25.1
> >>

--6HlvDwIotWNMJfjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEazxwAKCRB4tDGHoIJi
0osdAQCISGBqGlz7YM9o2HVnpF3isrb+g/3DjUcQStBOFWMoIQEAqiq89P/KpxGn
wIK++nWkOGweBlPSKaS8ogGe/h/+tQE=
=Y2pV
-----END PGP SIGNATURE-----

--6HlvDwIotWNMJfjO--
