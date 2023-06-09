Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94C72924D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjFIIJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbjFIIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:09:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF333C30
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:08:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7XAK-0006kw-V8; Fri, 09 Jun 2023 10:08:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7XAH-0069Zi-QX; Fri, 09 Jun 2023 10:08:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7XAG-00CXLI-Ow; Fri, 09 Jun 2023 10:08:08 +0200
Date:   Fri, 9 Jun 2023 10:08:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/legacy_serial: check CONFIG_SERIAL_8250_CONSOLE
Message-ID: <20230609080808.cuujwvy55s2vvn4m@pengutronix.de>
References: <20230609003328.15008-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndc6ya4l57czhno4"
Content-Disposition: inline
In-Reply-To: <20230609003328.15008-1-rdunlap@infradead.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ndc6ya4l57czhno4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Randy,

On Thu, Jun 08, 2023 at 05:33:28PM -0700, Randy Dunlap wrote:
> When SERIAL_8250_CONSOLE is not set but PPC_UDBG_16550=3Dy,
> the legacy_serial code references fsl8250_handle_irq, which is
> only built when SERIAL_8250_CONSOLE is set.
>=20
> Be consistent in referencing the used CONFIG_SERIAL_8250*
> symbols so that the build errors do not happen.
>=20
> Prevents these build errors:
>=20
> powerpc-linux-ld: arch/powerpc/kernel/legacy_serial.o: in function `seria=
l_dev_init':
> legacy_serial.c:(.init.text+0x2aa): undefined reference to `fsl8250_handl=
e_irq'
> powerpc-linux-ld: legacy_serial.c:(.init.text+0x2b2): undefined reference=
 to `fsl8250_handle_irq'
>=20
> Fixes: 66eff0ef528b ("powerpc/legacy_serial: Warn about 8250 devices oper=
ated without active FSL workarounds")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/legacy_serial.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -- a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legac=
y_serial.c
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -508,9 +508,9 @@ static void __init fixup_port_irq(int in
> =20
>  	port->irq =3D virq;
> =20
> -	if (IS_ENABLED(CONFIG_SERIAL_8250) &&
> +	if (IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE) &&
>  	    of_device_is_compatible(np, "fsl,ns16550")) {
> -		if (IS_REACHABLE(CONFIG_SERIAL_8250)) {
> +		if (IS_REACHABLE(CONFIG_SERIAL_8250_CONSOLE)) {
>  			port->handle_irq =3D fsl8250_handle_irq;
>  			port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
>  		} else {

Argh, indeed there is a problem. Your patch however defeats the idea of
66eff0ef528b[1] which is still valid. And with your patch the else
branch that starts at the end of the above hunk is never taken.

With the feedback I got on
https://lore.kernel.org/linux-serial/20230605130857.85543-3-u.kleine-koenig=
@pengutronix.de
the probable outcome is that CONFIG_SERIAL_8250_FSL becomes tristate and
so the fix that is more future proof and keeps the warning, looks as
follows:

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/lega=
cy_serial.c
index fdbd85aafeb1..6ee65741dbd5 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -510,7 +510,7 @@ static void __init fixup_port_irq(int index,
=20
 	if (IS_ENABLED(CONFIG_SERIAL_8250) &&
 	    of_device_is_compatible(np, "fsl,ns16550")) {
-		if (IS_REACHABLE(CONFIG_SERIAL_8250)) {
+		if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL)) {
 			port->handle_irq =3D fsl8250_handle_irq;
 			port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 		} else {

This should to the right thing now (while CONFIG_SERIAL_8250_FSL is
still bool and only on if CONFIG_SERIAL_8250 is =3Dy) and also once
CONFIG_SERIAL_8250_FSL can be =3Dm (which would make fsl8250_handle_irq
not available for powerpc platform code).

But given that I screwed this up several times now, I will think about
this some more and do some more tests before submitting that as a proper
patch.

Best regards
Uwe

[1] Warn if the 8250 device is used but the required FSL workarounds are
not.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ndc6ya4l57czhno4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSC3ecACgkQj4D7WH0S
/k5T9Af/fgeBpi2x/JEzkhLoSz3doP+2Pv+/pfLZFelOSp4kIlGd8qnJoxVmGXwS
jTAcJ+jpz9fheIA1Obhl0K38LuODmGg8ZFankSMEUvUNDjcalTXb7mQpT/qmVX41
kDWGHNpNnbgnAKA56gg/IGt/0PVzLeFi8NuBXqS/jv52hNySnXOjIaRVC2ZE36EM
kAd7pGtf8SGNo4+o9V/JIbMWnoXZuS4Qvo+MPJcfFE5IHlk4wHmYCxtuUAH56SuM
06Rs0YdxYgN2yoc/fch7XjD7fnYuM7TgnYPn0uZSG6+brec3SKVml3VopzggGSHZ
lORWQ0Mp14HXFfYDMD9zdAF1EIj5kg==
=igw/
-----END PGP SIGNATURE-----

--ndc6ya4l57czhno4--
