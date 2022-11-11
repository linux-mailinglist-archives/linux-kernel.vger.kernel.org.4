Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151836259C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiKKLts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiKKLtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:49:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9F427DFE;
        Fri, 11 Nov 2022 03:49:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D35761F9F;
        Fri, 11 Nov 2022 11:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3279C433D6;
        Fri, 11 Nov 2022 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167371;
        bh=qSBF/ECZfbRTbQB9J8HIoNk5t+QvNMgL7PClSWUYqHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDIzMdHf8JocXoaBMAdhZfvVkDbL8LWt55WECcKB2Aj7sGpoJ/Z1nK1+s6BvDOyxP
         6ljjxNPHydGcoROQ7RP4oeTNKFHeQQfWsssQGZS54zMriSX9rojgnr3Lpj6+1c8Bxg
         Lzw09yIadbQo7BWkA2+H08Vkwtl37yId4GXoZisap5zw5SIpoW11AEJ9s595Ztqa/J
         FdvOI9s06XauojJxWqftvcjCaZInONfEh6jwSH9CEfSXzCxiGWH51iSpnbo/8NVPGI
         lbaKylLSc8P/Czb+YHXPh70zYtCVVq1j5SN6QFSOVMLHqpRwq/BEJotuYV1/cB/9F+
         DRC1QAsO/0jWQ==
Date:   Fri, 11 Nov 2022 11:49:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, tglx@linutronix.de,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Message-ID: <Y242xYJQMC2JlMtH@sirena.org.uk>
References: <87mt8zutib.wl-maz@kernel.org>
 <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
 <86pmdvow5y.wl-maz@kernel.org>
 <ef60cbdb-f506-7bd6-a8e1-c92b6963a0f4@opensource.cirrus.com>
 <86k042q1uc.wl-maz@kernel.org>
 <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
 <87iljmve87.wl-maz@kernel.org>
 <Y21gwGDb5CFft0kp@sirena.org.uk>
 <87h6z5vs39.wl-maz@kernel.org>
 <20221111111611.GH10437@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GX9PH0gqSEqgaksu"
Content-Disposition: inline
In-Reply-To: <20221111111611.GH10437@ediswmail.ad.cirrus.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GX9PH0gqSEqgaksu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2022 at 11:16:11AM +0000, Charles Keepax wrote:
> On Fri, Nov 11, 2022 at 08:00:10AM +0000, Marc Zyngier wrote:
>=20
> > > ACPI gets to be a lot of fun here, it's just not idiomatic to describe
> > > the internals of these devices in firmware there and a lot of the
> > > systems shipping this stuff are targeted at other OSs and system
> > > integrators are therefore not in the least worried about Linux
> > > preferences.

> I would echo Mark's statement that going the way of moving this
> into DT/ACPI will actually likely necessitate the addition of a
> lot of "board file" stuff in the future. If the part gets used in
> any ACPI systems (granted support is not in yet but this is not a
> super unlikely addition in the future for cs48l32) we will need to
> support the laptops containing the part in Linux and the vendors are
> extremely unlikely to put internal CODEC IRQs into the ACPI tables.

It's a bit of a stronger issue than that in that it's not how ACPI is
usually expected to work (it draws more from the PCI model where you
just get a top level ID from the device and have to figure the rest out
yourself).

> An alternative approach would be to actually represent the MFD in
> device tree, I think this would allow things to work and look
> something like (totally not tested just for discussion):

That's what Marc's pushing for - there is an idea to do that which works
well enough for cases (like this irqchip for the most part, modulo how
to handle the top level interrupts for the chip) where the way Linux
wants to model the device maps clearly onto the hardware but like I was
mentioning with the audio/clocking split it gets tricky where things are
more up in the air and potentially changable since it's much harder to
define a suitable ABI.

--GX9PH0gqSEqgaksu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNuNsQACgkQJNaLcl1U
h9DtIAf/aeBQQ3Lh5zmka+uBR54WcnQfWacUGj+JM5RC6CDwQ1Prz7UJd1YrZzbz
NA5etQWvjvbCh/1Y+cn8KSpiNiKrNJmhVZOkqNehoPWPcyKFBbVKLhL8mRY5tk2f
xPJkQ/MxrOFacsGRpkStfSZPew2Xt+cdIBOIN7vhww9+NHMsnGmx4xLjZc5tltpA
BA9WFjV/yzMxgE2UiJYIX8QMZ8i3CftDNOIUS9KN2cXAqNa3S/+Nuxon5Qrc5Rmd
07eq77gLTHoy0syRlbyDOjD24wVosKRomLl/B+koqEy5ZUJxjZz0W9IDllZ9fIKo
B2IEu3AcIwLVXpeU0pwDN7OY6FCdFA==
=Ljlu
-----END PGP SIGNATURE-----

--GX9PH0gqSEqgaksu--
