Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0860371F359
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjFAUDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFAUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA1613D;
        Thu,  1 Jun 2023 13:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28883635D3;
        Thu,  1 Jun 2023 20:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C279C433D2;
        Thu,  1 Jun 2023 20:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685649793;
        bh=F82WUzOdnr/NfRpYPJ5s+LlZ3AUJ/0QHGxbssVtekR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJqxA2BcVQnYeORdYB6lSOoOR5CXmnao2o4im+lV8fG/jS/LblFQEyh/INFIahx2z
         fzvBNUhPEpDgZZ72eo1lUZ/7SIaQUzbcPVkNCsm731gdrJ2g9emLJPbXl6Eehrd9iN
         6Q4W2bG7HMhjFyLmZNfalepduXuBIoHaYebcbH94vURVu3THb7adC6BXoKhSaBmq6T
         TvLcXhM2cQg7fpifRPJsv+lmU449y0p2RZlEi7+eionFvLfNCPnLXX5vkbUCQIZyaU
         rY3V7+VAAxBnwxtTyBs9hToQfijfWQvGLljuKXFHd6y1iltycQKS/FsTYh2AfpaUy1
         WvGlryGNL6fOg==
Date:   Thu, 1 Jun 2023 21:03:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
Message-ID: <20230601-magnolia-liability-8cbe2e2e2d1e@spud>
References: <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
 <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
 <20230523-flaccid-fossil-c9d09838dc64@spud>
 <658510B5-702B-464A-BA55-01E2B315BE39@geanix.com>
 <20230524-ellipse-dagger-72f850253ea0@wendy>
 <24418459-DE19-4575-835B-8673F279993C@geanix.com>
 <b9297205-82fa-8cdf-550e-a53c073e0a9d@linaro.org>
 <4BD5682B-1A36-427A-8BDA-3159182DA057@geanix.com>
 <24c2b94a-40de-b214-1931-ec44162f4973@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yo3r8RT7fhIPzLah"
Content-Disposition: inline
In-Reply-To: <24c2b94a-40de-b214-1931-ec44162f4973@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yo3r8RT7fhIPzLah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Not trimming any of this in case Lee wants to chime in and needs the
context...

On Thu, Jun 01, 2023 at 05:25:21PM +0200, Krzysztof Kozlowski wrote:
> On 01/06/2023 16:05, Sean Nyekjaer wrote:
> >> On 1 Jun 2023, at 09.12, Krzysztof Kozlowski <krzysztof.kozlowski@lina=
ro.org> wrote:
> >> On 24/05/2023 12:30, Sean Nyekjaer wrote:
> >>>> On 24 May 2023, at 12.08, Conor Dooley <conor.dooley@microchip.com> =
wrote:
> >>>> On Wed, May 24, 2023 at 10:16:13AM +0200, Sean Nyekj=C3=A6r wrote:
> >>>>>> On 23 May 2023, at 19.29, Conor Dooley <conor@kernel.org> wrote:
> >>>>>> On Tue, May 23, 2023 at 11:55:50AM +0200, Sean Nyekj=C3=A6r wrote:
> >>>>>>>> On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
> >>>>>>>> On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
> >>>>>>>>> Document the new optional "fsl,pmic-poweroff" property.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >>>>>>>>> ---
> >>>>>>>>> Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 +++++=
+++
> >>>>>>>>> 1 file changed, 8 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.y=
aml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>>>>>>>> index 9573e4af949e..5183a7c660d2 100644
> >>>>>>>>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>>>>>>>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>>>>>>>> @@ -26,6 +26,14 @@ properties:
> >>>>>>>>>
> >>>>>>>>> interrupt-controller: true
> >>>>>>>>>
> >>>>>>>>> +  st,pmic-poweroff:
> >>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>>>>>>>> +    description: |
> >>>>>>>>> +      if present, configure the PMIC to shutdown all power rai=
ls when
> >>>>>>>>> +      power off sequence have finished.
> >>>>>>>>> +      Use this option if the SoC should be powered off by exte=
rnal power management
> >>>>>>>>> +      IC (PMIC).
> >>>>>>>>
> >>>>>>>> Just reading this description, this is sounding quite like a "so=
ftware
> >>>>>>>> behaviour" type of property, which are not permitted, rather than
> >>>>>>>> describing some element of the hardware. Clearly you are trying =
to solve
> >>>>>>>> an actual problem though, so try re-phrasing the description (and
> >>>>>>>> property name) to focus on what exact hardware configuration it =
is that
> >>>>>>>> you are trying to special-case.
> >>>>>>>> Krzysztof suggested that the samsung,s2mps11-acokb-ground proper=
ty in
> >>>>>>>> samsung,s2mps11.yaml is addressing a similar problem, so that co=
uld be
> >>>>>>>> good to look at.
> >>>>>>>
> >>>>>>> Better wording?
> >>>>>>>    Indicates that the power management IC (PMIC) is used to power=
 off the board.
> >>>>>>>    So as the last step in the power off sequence set the SWOFF bi=
t in the
> >>>>>>>    main control register (MAIN_CR) register, to shutdown all powe=
r rails.
> >>>>>>
> >>>>>> The description for the property that Krzysztof mentioned is
> >>>>>> samsung,s2mps11-acokb-ground:
> >>>>>>  description: |
> >>>>>>    Indicates that ACOKB pin of S2MPS11 PMIC is connected to the gr=
ound so
> >>>>>>    the PMIC must manually set PWRHOLD bit in CTRL1 register to tur=
n off the
> >>>>>>    power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD =
pin goes
> >>>>>>    low, the rising ACOKB will trigger power off.
> >>>>>>
> >>>>>> In other words, I am asking what (abnormal?) scenario there is tha=
t means
> >>>>>> you need the property, rather than what setting the property does.
> >>>>>> Or am I totally off, and this is the only way this PMIC works?
> >>>>>
> >>>>> Indicates that the power management IC (PMIC) turn-off condition is=
 met
> >>>>> by setting the SWOFF bit in the main control register (MAIN_CR) reg=
ister.
> >>>>> Turn-off condition can still be reached by the PONKEY input.
> >>>>>
> >>>>> ?
> >>>>>
> >>>>> I must admit I=E2=80=99m somewhat lost here :)
> >>>>
> >>>> Sorry about that. I'm trying to understand what is different about y=
our
> >>>> hardware that it needs the property rather than what adding the prop=
erty
> >>>> does. If you look at the samsung one, it describes both the
> >>>> configuration of the hardware ("ACOKB pin of S2MPS11 PMIC is connect=
ed to
> >>>> the ground") and how that is different from normal ("Usually the ACO=
KB is
> >>>> pulled up to VBATT so when PWRHOLD pin goes low, the rising ACOKB wi=
ll
> >>>> trigger power off.")
> >>>>
> >>>> Looking at your datasheet, you don't have such a pin though - just t=
he
> >>>> sw poweroff bit & the PONKEY stuff. My angle is just that I am trying
> >>>> to figure out why you need this property when it has not been needed
> >>>> before. Or why you would not always want to "shutdown all power rails
> >>>> when power-off sequence have finished". I'm sorry if these are silly
> >>>> questions.
> >>>>
> >>>
> >>> No silly questions, maybe they trick me to come up with the correct a=
nswer :D
> >>>
> >>> Basically without this, you won=E2=80=99t be able to power off the sy=
stem
> >>> other than hitting the PONKEY.
> >>> So it=E2=80=99s a new feature that wasn=E2=80=99t supported before.
> >>> Maybe this feature should not be optional?

[1]

> >>
> >> You are still describing what driver should do with registers. What you
> >> are missing is describing real cause for this. It's exactly the same
> >> case as was with s2mps11.
> >=20
> > I didn=E2=80=99t mention anything with registers in the patch:
> >=20
> > if present, configure the PMIC to shutdown all power rails when
> > power off sequence have finished.
> > Use this option if the SoC should be powered off by external power mana=
gement
> > IC (PMIC).
> >=20
> > ^^ That=E2=80=99s is exactly what is happening if the option is enabled.
> >=20
> > Do you have a suggestion wording?
> > What do you think about removing this option and make it default behavi=
our?
>=20
> Again - you write what the driver should do ("configure the PMIC") when
> something in Linux happens ("power off sequence have finished"). Exactly
> the same case as s2mps11. Look how it was worded there. You need to find
>  the real cause, why such actions are required on which board.
>=20
> Otherwise it does not warrant DT property and just perform it always.

Yeah, Sean asked that a few messages back up [1] & having looked at the
datasheet I am kinda struggling to see why you would not just always
want to do this. There does not seem to be an equivalent pin in this
PMIC as your Samsung one, so this patch isn't working around some
flaw in a board design, but rather seems to be looking to implement the
actual functionality.
I vote for do it always, obviously unless Less disagrees, and if that
causes problems we can revisit the dt property with more understanding
of whatever use case breaks if this is done unilaterally.

Cheers,
Conor.

--Yo3r8RT7fhIPzLah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHj5fAAKCRB4tDGHoIJi
0vL/AQDttfyRfESEKWkvfGQjrjQ5B9WlC8aqsFHsasj4EYqbfQD9EPQbMeFq+8Yz
CQrn/26FP+hJVKknLAsqEY6ejLyoOwc=
=VErF
-----END PGP SIGNATURE-----

--Yo3r8RT7fhIPzLah--
