Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6570E2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbjEWR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbjEWR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C683DD;
        Tue, 23 May 2023 10:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0579061662;
        Tue, 23 May 2023 17:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D57C4339B;
        Tue, 23 May 2023 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862959;
        bh=nRFEeON5TTeTRfrNJSFYHGfUbaFOG80hxmTyINj72VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIBCRYYSV+CIIa78/f/pA/2PZpk18/VXhWbvFvtGd+ayEHshv94B7oyW0TaW8L0Ad
         HarSzEi7Ftorr2Y4RJkylO08XKlmW6wpMu41X0SfKIHgXsr2BVhp0ONC8LeRlE3q1I
         jv7emAZOSxPaF226IfFuruduJ3m2gfJnR578EroixBtKnIEA6aueUzD4smB8qR8CC5
         55Bn0FvoQ539GlfA+C6btkpDqC2nJXef4tie/pzBEt8qW1bA0CDK/6iCGUcPmryHSB
         6DgJUUB51kdIDgwclRQqUX2VhxVilxbQ2e8crQDN+TUV9gVruKXlm1Rlk0/BvSXgxh
         Ya/8FwRoGSVVA==
Date:   Tue, 23 May 2023 18:29:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean@geanix.com>
Cc:     robh+dt@kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
Message-ID: <20230523-flaccid-fossil-c9d09838dc64@spud>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
 <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="23BiRCaMKPuGXfik"
Content-Disposition: inline
In-Reply-To: <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--23BiRCaMKPuGXfik
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 11:55:50AM +0200, Sean Nyekj=E6r wrote:
> > On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
> > On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
> >> Document the new optional "fsl,pmic-poweroff" property.
> >>=20
> >> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >> ---
> >> Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 ++++++++
> >> 1 file changed, 8 insertions(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/D=
ocumentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >> index 9573e4af949e..5183a7c660d2 100644
> >> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >> @@ -26,6 +26,14 @@ properties:
> >>=20
> >>   interrupt-controller: true
> >>=20
> >> +  st,pmic-poweroff:
> >> +    $ref: /schemas/types.yaml#/definitions/flag
> >> +    description: |
> >> +      if present, configure the PMIC to shutdown all power rails when
> >> +      power off sequence have finished.
> >> +      Use this option if the SoC should be powered off by external po=
wer management
> >> +      IC (PMIC).
> >=20
> > Just reading this description, this is sounding quite like a "software
> > behaviour" type of property, which are not permitted, rather than
> > describing some element of the hardware. Clearly you are trying to solve
> > an actual problem though, so try re-phrasing the description (and
> > property name) to focus on what exact hardware configuration it is that
> > you are trying to special-case.
> > Krzysztof suggested that the samsung,s2mps11-acokb-ground property in
> > samsung,s2mps11.yaml is addressing a similar problem, so that could be
> > good to look at.
>=20
> Better wording?
>       Indicates that the power management IC (PMIC) is used to power off =
the board.
>       So as the last step in the power off sequence set the SWOFF bit in =
the
>       main control register (MAIN_CR) register, to shutdown all power rai=
ls.

The description for the property that Krzysztof mentioned is
  samsung,s2mps11-acokb-ground:
    description: |
      Indicates that ACOKB pin of S2MPS11 PMIC is connected to the ground so
      the PMIC must manually set PWRHOLD bit in CTRL1 register to turn off =
the
      power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD pin go=
es
      low, the rising ACOKB will trigger power off.

In other words, I am asking what (abnormal?) scenario there is that means
you need the property, rather than what setting the property does.
Or am I totally off, and this is the only way this PMIC works?

Cheers,
Conor.

--23BiRCaMKPuGXfik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGz36wAKCRB4tDGHoIJi
0oHHAP9hYw2Fyk+QQUizn6YRH4cacENB1d9ChPXpsSyLDtFVvwD/aKAC10F+wFva
WT7XqtDEaJikR4HUtbr8QjftlyFbtwE=
=Fjiv
-----END PGP SIGNATURE-----

--23BiRCaMKPuGXfik--
