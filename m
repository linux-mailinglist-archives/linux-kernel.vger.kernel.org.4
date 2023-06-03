Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFCD72132D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 23:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFCVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFCVXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 17:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CEBB;
        Sat,  3 Jun 2023 14:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D368614CF;
        Sat,  3 Jun 2023 21:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63BCC433EF;
        Sat,  3 Jun 2023 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685827410;
        bh=dSIm5Wvz5LRZtbhpsX9D9prPNXaAd8xtjahnGUMHopU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLatQoL/jRjSCgyl5b6BC3oACHLf7Ne19JoLUCLcmVYCh5lmpSvW2X4N97aNtGxnt
         h0O1DQrE2jrnVb5chXwPD7yR96d8YLm/bG+sGFdvjarcGdwklRr8SRDw0UXVe/vuL7
         D4g5AHDPWDIK5vX88qYR5oFodDzV8eDvc/TQ8SJ7pTOv80vS6VTRJm4Q10k56xFl/4
         hjHWsUkBoitHOlxk8GWQA7Z2MlIHmdj/Jj9oQsVrylrPPd780F6OcrM+UjGjfgRzPX
         Sk82NubtpCij7kjdzOBBZJiRnCQBA7U9oDz/wdriLjUEamZAoSjJyHtdBmsUmZvtII
         1z5kwLAbipwmw==
Date:   Sat, 3 Jun 2023 22:23:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, sre@kernel.org,
        broonie@kernel.org, arnd@arndb.de, gregory.clement@bootlin.com,
        sudeep.holla@arm.com, balamanikandan.gunasundar@microchip.com,
        mihai.sain@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
Subject: Re: [PATCH 15/21] dt-bindings: irqchip/atmel-aic5: Add support for
 sam9x7 aic
Message-ID: <20230603-sanded-blunderer-73cdd7c290c1@spud>
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-16-varshini.rajendran@microchip.com>
 <20230603-fervor-kilowatt-662c84b94853@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5+h50twaFI8/uBg6"
Content-Disposition: inline
In-Reply-To: <20230603-fervor-kilowatt-662c84b94853@spud>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5+h50twaFI8/uBg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 03, 2023 at 10:19:50PM +0100, Conor Dooley wrote:
> Hey Varshini,
>=20
> On Sun, Jun 04, 2023 at 01:32:37AM +0530, Varshini Rajendran wrote:
> > Document the support added for the Advanced interrupt controller(AIC)
> > chip in the sam9x7 soc family
>=20
> Please do not add new family based compatibles, but rather use per-soc
> compatibles instead.

These things leave me penally confused. Afaiu, sam9x60 is a particular
SoC. sam9x7 is actually a family, containing sam9x70, sam9x72 and
sam9x75. It would appear to me that each should have its own compatible,
no?

>=20
> Cheers,
> Conor.
>=20
> >=20
> > Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> > ---
> >  .../devicetree/bindings/interrupt-controller/atmel,aic.txt      | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/atm=
el,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,a=
ic.txt
> > index 7079d44bf3ba..2c267a66a3ea 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.=
txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.=
txt
> > @@ -4,7 +4,7 @@ Required properties:
> >  - compatible: Should be:
> >      - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
> >        "sama5d3" or "sama5d4"
> > -    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
> > +    - "microchip,<chip>-aic" where <chip> can be "sam9x60", "sam9x7"
> > =20
> >  - interrupt-controller: Identifies the node as an interrupt controller.
> >  - #interrupt-cells: The number of cells to define the interrupts. It s=
hould be 3.
> > --=20
> > 2.25.1
> >



--5+h50twaFI8/uBg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHuvSQAKCRB4tDGHoIJi
0nQIAQCdCq0rnVwR27l81/lR1+KVZHZ2Pax5fjYvVUG5dr0aWQEA0SNTjHs2HGgK
8L0e/r5CdXbUHSFnJSvMJ1FSh638bwc=
=UztW
-----END PGP SIGNATURE-----

--5+h50twaFI8/uBg6--
