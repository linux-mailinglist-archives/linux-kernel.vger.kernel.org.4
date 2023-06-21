Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A27389FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjFUPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjFUPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:43:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A822D1FE7;
        Wed, 21 Jun 2023 08:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D24615BB;
        Wed, 21 Jun 2023 15:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A828EC433C8;
        Wed, 21 Jun 2023 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687362168;
        bh=dbwfknXsqXw4p63vpLDd3iOrBiUELONzHnImHljTpEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVylD345zloFSGD1W8zwUcCpjdRN/8JljRejRGPf9ADL8ncjzZ+ZbdHaswXh1ruMk
         quAXYGU2UUL5fj0A6MiElL1TD2b40WlwmDVVf37WkNbGzqaHL6OBbCZ3WqUJrn1PMq
         jlvmG9ggh77knIvBT5BG0XpHA8opSrxdCp6DTTkQy1eKulXEb1hZggJoDFxDY/Zuju
         bIKNyUokqZQDS98EzPGV22p63kxm6tEmuSu+jhihmlROOEt0yEgnGs5MjcoWD7u1sp
         C+OrMogqa9LXv9AzD28ut+M2XV687zi+1eY7Aysor1olyzenbz+X2NxQETHTdb0Vti
         1W0YDnXjvG8Lg==
Date:   Wed, 21 Jun 2023 16:42:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033
 compatible
Message-ID: <20230621-stuffed-revolt-435d3d2dd4aa@spud>
References: <20230602130644.259933-1-raymondhackley@protonmail.com>
 <20230602131009.260239-1-raymondhackley@protonmail.com>
 <20230621150141.GE10378@google.com>
 <20230621150302.GF10378@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qinxGE0I1bfK1wN4"
Content-Disposition: inline
In-Reply-To: <20230621150302.GF10378@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qinxGE0I1bfK1wN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Raymond,

On Wed, Jun 21, 2023 at 04:03:02PM +0100, Lee Jones wrote:
> On Wed, 21 Jun 2023, Lee Jones wrote:
>=20
> > On Fri, 02 Jun 2023, Raymond Hackley wrote:
> >=20
> > > Add devicetree binding for Richtek RT5033 Flash LED charge pump used =
for
> > > camera flash LEDs.
> > >=20
> > > Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml=
 b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > > index 4d2ffe5fcfc7..37d2a93780ab 100644
> > > --- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > > +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > > @@ -20,6 +20,7 @@ properties:
> > >    compatible:
> > >      enum:
> > >        - ocs,ocp8110
> > > +      - richtek,rt5033-led
> >=20
> > Why is "-led" appended on to this one and not the others?
>=20
> It's unusual for me to have to dump through a bunch of hoops just to
> read and then subsequently reply to mail.  Can you consider removing
> whatever encryption you have enabled please?

https://www.kernel.org/doc/html/latest/process/email-clients.html#proton-ma=
il

I was under the impression that there was no way to disable this
behaviour, but I saw mention somewhere that they managed to patch the
open source version of the protonmail bridge to function. I cannot find
this on lore, because the person's domain was not a proton one and I
completely forget their name as it was several months ago.
I'll reply here if I find it.

Cheers,
Conor.

--qinxGE0I1bfK1wN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJMadAAKCRB4tDGHoIJi
0lMMAQDJuJl2PHQ+dS5xDq6nj6F2iIiHxY8ksq4Wpc2uO8gMTQD+L/To0i81S4q3
XhaNK2S5KKWDGvsHKH7itW7HPFbf6AY=
=r1cN
-----END PGP SIGNATURE-----

--qinxGE0I1bfK1wN4--
