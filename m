Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F76EDC02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjDYHAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjDYHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:00:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F0BBA4;
        Tue, 25 Apr 2023 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682406005; x=1713942005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qlzMot14ZbRwpU+p0kHRrBvsH2BXDjmtgQ5WyFC/dCk=;
  b=p+VBUVaGOtfieV8NYSrEt2rtNXAGI7/SEru/2od6RbU0KoVV/lRZhzSF
   nhGMZi3xpMvsmTzVw2gbFOQ6S44sv1bMbA+4zL7E89vWFaOfCm3qtQG8Q
   nav9A/AtUPE03UlIir+CxWBufR1jcIwtWUc8xQfk31yUMTNTspDpJNSVG
   UglVs4+xkopQcaU1IDVchPq8sl641M1TdcnBznFO7N64gC1NZ0xFQXA1R
   uwIjSAc+ru3zovijXAAoyn29iZN8b1LVW66rYPZxvZwsN0BrczzvKJacC
   hW0zrJYU5QcHbWoM8HrGXiBIAhSS76wCzqwsb1j1MYGXH/SdEGnSgsmws
   g==;
X-IronPort-AV: E=Sophos;i="5.99,224,1677567600"; 
   d="asc'?scan'208";a="210551944"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Apr 2023 00:00:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Apr 2023 00:00:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Apr 2023 00:00:02 -0700
Date:   Tue, 25 Apr 2023 07:59:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <vkoul@kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230425-unquote-eligible-09f743d81981@wendy>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
 <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u5FAAPmwStIUzOwr"
Content-Disposition: inline
In-Reply-To: <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--u5FAAPmwStIUzOwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 11:41:38AM +0800, Changhuang Liang wrote:
> On 2023/4/25 0:52, Conor Dooley wrote:
> > On Thu, Apr 20, 2023 at 03:00:10PM +0800, Changhuang Liang wrote:
> >> On 2023/4/20 2:29, Conor Dooley wrote:
> >>> On Tue, Apr 18, 2023 at 08:56:41PM -0700, Changhuang Liang wrote:
> >>>> Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off D=
PHY
> >>>> rx/tx power switch, and it don't need the properties of reg and
> >>>> interrupts.
> >>>
> >>> Putting this here since the DT guys are more likely to see it this wa=
y..
> >>> Given how the implementation of the code driving this new
> >>> power-controller and the code driving the existing one are rather
> >>> different (you've basically re-written the entire driver in this seri=
es),
> >>> should the dphy driver implement its own power-controller?
> >>>
> >>> I know originally Changuang had tried something along those lines:
> >>> https://lore.kernel.org/linux-riscv/5dc4ddc2-9d15-ebb2-38bc-8a544ca67=
e0d@starfivetech.com/
> >>>
> >>> I see that that was shut down pretty much, partly due to the
> >>> non-standard property, hence this series adding the dphy power domain=
 to
> >>> the existing driver.
> >>>
> >>> If it was done by looking up the pmu with a
> >>> of_find_compatible_node(NULL, "power-controller", "starfive,jh7110-ao=
n-pmu")
> >>> type thing, would that make sense? Although, maybe that is not a
> >>> question for you, and this series may actually have been better entir=
ely
> >>> bundled with the dphy series so the whole thing can be reviewed as a
> >>> unit. I've added=20
> >>>
> >>> IOW, don't change this patch, or the dts patch, but move all of the
> >>> code back into the phy driver..
> >>>
> >>
> >> Maybe this way can not do that? power domain is binding before driver =
probe,
> >> if I use "of_find_compatible_node" it phy(DPHY rx) probe. Maybe I can =
only operate=20
> >> this power switch in my phy(DPHY rx) driver, so the all patch of this =
series isn't=20
> >> make sense.
> >=20
> > I'm a wee bit lost here, as I unfortunately know little about how Linux
> > handles this power-domain stuff. If the DPHY tries to probe and some
> > pre-requisite does not yet exist, you can return -EPROBE_DEFER right?
> >=20
> > But I don't think that's what you are asking, as using
> > of_find_compatible_node() doesn't depend on there being a driver AFAIU.
> >=20
> >> In my opinion, We will also submit DPHY TX module later which use this=
 series.
> >> Maybe this series should independent?
> >=20
> > Is the DPHY tx module a different driver to the rx one?> If yes, does i=
t have a different bit you must set in the syscon?
> >=20
>=20
> Yes, DPHY tx module is a different driver to the DPHY rx. And I have do a
> different bit in PATCH 1:
>=20
> #define JH7110_PD_DPHY_TX	0
> #define JH7110_PD_DPHY_RX	1
>=20
> also in PATCH 5:
>=20
> static const struct jh71xx_domain_info jh7110_aon_power_domains[] =3D {
> 	[JH7110_PD_DPHY_TX] =3D {
> 		.name =3D "DPHY-TX",
> 		.bit =3D 30,
> 	},
> 	[JH7110_PD_DPHY_RX] =3D {
> 		.name =3D "DPHY-RX",
> 		.bit =3D 31,
> 	},
> };
>=20
> > +CC Walker, do you have a register map for the jh7110? My TRM only says
> > what the registers are, but not the bits in them. Would make life easier
> > if I had that info.
> >=20
> > I'm fine with taking this code, I just want to make sure that the soc
> > driver doing this is the right thing to do.
> > I was kinda hoping that combining with the DPHY-rx series might allow
> > the PHY folk to spot if you are doing something here with the power
> > domains that doesn't make sense.
> >=20
>=20
> I asked about our soc colleagues. This syscon register,
> offset 0x00:
> bit[31] ---> dphy rx power switch
> bit[30] ---> dphy tx power switch=20
> other bits ---> Reserved

Okay. Unless someone explicitly disagrees, I'm fine with doing this
stand-alone from the DPHY drivers.

> >>> Sorry for not asking this sooner Changhuang,
> >>> Conor.
> >>>
> >>> (hopefully this didn't get sent twice, mutt complained of a bad email
> >>> addr during sending the first time)
> >>>
> >>
> >> I'm sorry for that, I will notice later.
> >=20
> > No, this was my mail client doing things that I was unsure of. You
> > didn't do anything wrong.
> >=20
> [...]
> >>>>    - Walker Chen <walker.chen@starfivetech.com>
> >>>> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> >>>> =20
> >>>>  description: |
> >>>>    StarFive JH7110 SoC includes support for multiple power domains w=
hich can be
> >>>> @@ -17,6 +18,7 @@ properties:
> >>>>    compatible:
> >>>>      enum:
> >>>>        - starfive,jh7110-pmu
> >>>> +      - starfive,jh7110-aon-pmu
> >=20
> > I was speaking to Rob about this over the weekend, he asked:
> > 'Why isn't "starfive,jh7110-aon-syscon" just the power-domain provider
> > itself?'
>=20
> Maybe not, this syscon only offset "0x00" configure power switch.
> other offset configure other functions, maybe not power, so this
> "starfive,jh7110-aon-syscon" not the power-domain itself.
>=20
> > Do we actually need to add a new binding for this at all?
> >=20
> > Cheers,
> > Conor.
> >=20
>=20
> Maybe this patch do that.
> https://lore.kernel.org/all/20230414024157.53203-6-xingyu.wu@starfivetech=
=2Ecom/

This makes it a child-node right? I think Rob already said no to that in
and earlier revision of this series. What he meant the other day was
making the syscon itself a power domain controller, since the child node
has no meaningful properties (reg, interrupts etc).

Cheers,
Conor.

--u5FAAPmwStIUzOwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEd6YAAKCRB4tDGHoIJi
0oKpAQDFnJYW5Eb3bRjk0mIg+8hCRF6NN7S2yzKmqgK2KdAX8gEAu3+zX+61QS1D
0ABpJMSxeeX+lhfTvOD2BUnjxmNo/g4=
=1sQ7
-----END PGP SIGNATURE-----

--u5FAAPmwStIUzOwr--
