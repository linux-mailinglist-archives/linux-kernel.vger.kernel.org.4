Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE33722795
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjFENff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjFENfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:35:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2242FF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:35:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6AME-0004wI-Qz; Mon, 05 Jun 2023 15:34:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6AMA-005Hnu-Sa; Mon, 05 Jun 2023 15:34:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6AM9-00BP7s-Mi; Mon, 05 Jun 2023 15:34:45 +0200
Date:   Mon, 5 Jun 2023 15:34:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Liang He <windhl@126.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel@pengutronix.de, Michael Ellerman <mpe@ellerman.id.au>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 2/2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
Message-ID: <20230605133445.vi762odw2v7pkrog@pengutronix.de>
References: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de>
 <20230605130857.85543-3-u.kleine-koenig@pengutronix.de>
 <2d70e8b-7722-71e7-76f3-d27a2b2caa55@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="63dictzrcc4iig2j"
Content-Disposition: inline
In-Reply-To: <2d70e8b-7722-71e7-76f3-d27a2b2caa55@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--63dictzrcc4iig2j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 04:22:55PM +0300, Ilpo J=E4rvinen wrote:
> On Mon, 5 Jun 2023, Uwe Kleine-K=F6nig wrote:
>=20
> > The need to handle the FSL variant of 8250 in a special way is also
> > present without console support. So soften the dependency for
> > SERIAL_8250_FSL accordingly. Note that with the 8250 driver compiled as
> > a module, some devices still might not make use of the needed
> > workarounds. That affects the ports instantiated in
> > arch/powerpc/kernel/legacy_serial.c.
> >=20
> > This issue was identified by Dominik Andreas Schorpp.
> >=20
> > To cope for CONFIG_SERIAL_8250=3Dm + CONFIG_SERIAL_8250_FSL=3Dy, 8250_f=
sl.o
> > must be put in the same compilation unit as 8250_port.o because the
> > latter defines some functions needed in the former and so 8250_fsl.o
> > must not be built-in if 8250_port.o is available in a module.
> >=20
> > Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Link: https://lore.kernel.org/r/20230531083230.2702181-1-u.kleine-koeni=
g@pengutronix.de
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/8250/Kconfig  | 2 +-
> >  drivers/tty/serial/8250/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/=
Kconfig
> > index 5313aa31930f..10c09b19c871 100644
> > --- a/drivers/tty/serial/8250/Kconfig
> > +++ b/drivers/tty/serial/8250/Kconfig
> > @@ -378,7 +378,7 @@ config SERIAL_8250_BCM2835AUX
> > =20
> >  config SERIAL_8250_FSL
> >  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM |=
| ARM64)
> > -	depends on SERIAL_8250_CONSOLE
> > +	depends on SERIAL_8250
>=20
> Just one additional thought: After the adding the arch side=20
> workaround/hack, SERIAL_8250_FSL could become a tristate?

I see no benefit for a module separate from 8250_base.ko. There are
dependencies in both directions between 8250_port.o and 8250_fsl.o[1].
So in my book a bool SERIAL_8250_FSL that modifies 8250_base.ko (with
SERIAL_8250=3Dm) is fine.

Best regards
Uwe

[1] 8250_port.o uses fsl8250_handle_irq() from 8250_fsl.o, and
8250_fsl.o uses serial8250_modem_status from 8250_port.o.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--63dictzrcc4iig2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR95HQACgkQj4D7WH0S
/k52zQgAocZvRhklmeadO7sV3zI8RBeSCtr3mtnzUj/cB7oPPaqydGQcPbZ46L5D
eQ/YltWmfP/eoevzN0UMbFvinVEZqmjNufiFdOA8GsXCmZm2+dPlU87/2g2U3R0I
R7Ybfg22K91NyzAmYf44gQFMEYdNq6tOyQb35UiatiLezXlo93W4pmM6nt8URrx9
mT8Lr33fw4se+NHFyuA9E/hduMXjJa/rW2QHsU/b1dtrglahZe2HmJehYCF9Epx/
v1qYAuOXyBUGhZHpUGezMliJVmdQypQ4N02yD7BGtDaYCZhOExcYdXogMeeLBaPR
Z1InHIVwkU0KLENwtTPPSO/+PAK4Jg==
=OkiW
-----END PGP SIGNATURE-----

--63dictzrcc4iig2j--
