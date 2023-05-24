Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD070F3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjEXKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEXKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:08:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A912F;
        Wed, 24 May 2023 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684922921; x=1716458921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbLik93CbdP8dn5iLZyClx7c7cBiepErVjvKm8IDhB0=;
  b=gLW76oPQzUkPVPiksA2RmD8wz3Cs7SqcI3TZygM7D+Q3DesOHPCrbTPZ
   SuNSLuwZ6bE4nxsNcS83K0opzBTqF5wslfwg72UiYXlC4uw8O5rAYouCJ
   AaFm/jCMg+ySks2r1tsWe7dFzSJYI89Aw4GjqxrHhobnkJTO3GllTIXRe
   AOzQXWsKRLhWUO3ytPZ6aAWcdMgqqp1anMtTsLL/w73NC0ffANyOJHhaR
   PTWZ75OJYyB4mCH3S2FNsnONH4EjUlYxbZ1r/yCs/W4g0GXCX2uIq9E+h
   /gLP3EEgLQOXpKJOcUlXbsDp5PwbnHG07HxsDGA/j9mkXo9bxpCBTqH+R
   g==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="asc'?scan'208";a="153680048"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 03:08:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 03:08:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 03:08:35 -0700
Date:   Wed, 24 May 2023 11:08:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean@geanix.com>
CC:     Conor Dooley <conor@kernel.org>, <robh+dt@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
Message-ID: <20230524-ellipse-dagger-72f850253ea0@wendy>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
 <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
 <20230523-flaccid-fossil-c9d09838dc64@spud>
 <658510B5-702B-464A-BA55-01E2B315BE39@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DsxYJaeHtrcJiRcO"
Content-Disposition: inline
In-Reply-To: <658510B5-702B-464A-BA55-01E2B315BE39@geanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--DsxYJaeHtrcJiRcO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 10:16:13AM +0200, Sean Nyekj=C3=A6r wrote:
> Hi Conor,
>=20
> > On 23 May 2023, at 19.29, Conor Dooley <conor@kernel.org> wrote:
> >=20
> > On Tue, May 23, 2023 at 11:55:50AM +0200, Sean Nyekj=C3=A6r wrote:
> >>> On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
> >>> On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
> >>>> Document the new optional "fsl,pmic-poweroff" property.
> >>>>=20
> >>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >>>> ---
> >>>> Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 ++++++++
> >>>> 1 file changed, 8 insertions(+)
> >>>>=20
> >>>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b=
/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>>> index 9573e4af949e..5183a7c660d2 100644
> >>>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>>> @@ -26,6 +26,14 @@ properties:
> >>>>=20
> >>>>  interrupt-controller: true
> >>>>=20
> >>>> +  st,pmic-poweroff:
> >>>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>>> +    description: |
> >>>> +      if present, configure the PMIC to shutdown all power rails wh=
en
> >>>> +      power off sequence have finished.
> >>>> +      Use this option if the SoC should be powered off by external =
power management
> >>>> +      IC (PMIC).
> >>>=20
> >>> Just reading this description, this is sounding quite like a "software
> >>> behaviour" type of property, which are not permitted, rather than
> >>> describing some element of the hardware. Clearly you are trying to so=
lve
> >>> an actual problem though, so try re-phrasing the description (and
> >>> property name) to focus on what exact hardware configuration it is th=
at
> >>> you are trying to special-case.
> >>> Krzysztof suggested that the samsung,s2mps11-acokb-ground property in
> >>> samsung,s2mps11.yaml is addressing a similar problem, so that could be
> >>> good to look at.
> >>=20
> >> Better wording?
> >>      Indicates that the power management IC (PMIC) is used to power of=
f the board.
> >>      So as the last step in the power off sequence set the SWOFF bit i=
n the
> >>      main control register (MAIN_CR) register, to shutdown all power r=
ails.
> >=20
> > The description for the property that Krzysztof mentioned is
> >  samsung,s2mps11-acokb-ground:
> >    description: |
> >      Indicates that ACOKB pin of S2MPS11 PMIC is connected to the groun=
d so
> >      the PMIC must manually set PWRHOLD bit in CTRL1 register to turn o=
ff the
> >      power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD pin=
 goes
> >      low, the rising ACOKB will trigger power off.
> >=20
> > In other words, I am asking what (abnormal?) scenario there is that mea=
ns
> > you need the property, rather than what setting the property does.
> > Or am I totally off, and this is the only way this PMIC works?
>=20
> Indicates that the power management IC (PMIC) turn-off condition is met
> by setting the SWOFF bit in the main control register (MAIN_CR) register.
> Turn-off condition can still be reached by the PONKEY input.
>=20
> ?
>=20
> I must admit I=E2=80=99m somewhat lost here :)

Sorry about that. I'm trying to understand what is different about your
hardware that it needs the property rather than what adding the property
does. If you look at the samsung one, it describes both the
configuration of the hardware ("ACOKB pin of S2MPS11 PMIC is connected to
the ground") and how that is different from normal ("Usually the ACOKB is
pulled up to VBATT so when PWRHOLD pin goes low, the rising ACOKB will
trigger power off.")

Looking at your datasheet, you don't have such a pin though - just the
sw poweroff bit & the PONKEY stuff. My angle is just that I am trying
to figure out why you need this property when it has not been needed
before. Or why you would not always want to "shutdown all power rails
when power-off sequence have finished". I'm sorry if these are silly
questions.


--DsxYJaeHtrcJiRcO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG3iDQAKCRB4tDGHoIJi
0sNhAQDrqJBu7vfQqhRTxEBUolB1pjQeSEoNGI9Axz5tG/cVZAD/aezxAmTr5Nh6
Wlk6somgMyEr4in58VhQECKZPJThVAY=
=gj9X
-----END PGP SIGNATURE-----

--DsxYJaeHtrcJiRcO--
