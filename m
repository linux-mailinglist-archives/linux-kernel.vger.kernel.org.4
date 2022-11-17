Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF762D960
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiKQL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiKQL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:28:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973445ED1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:28:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovd3o-0002Xd-9s; Thu, 17 Nov 2022 12:28:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovd3m-004q6e-8H; Thu, 17 Nov 2022 12:27:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovd3m-00HGXm-Gu; Thu, 17 Nov 2022 12:27:58 +0100
Date:   Thu, 17 Nov 2022 12:27:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Add missing dummy for devm_pwmchip_add()
Message-ID: <20221117112758.nsxfwh4ck23uln5a@pengutronix.de>
References: <12f2142991690d2b1d6890821f6e7779a4d4bdc0.1666706435.git.geert+renesas@glider.be>
 <20221026001713.kuu5mj6kogosvqnk@pengutronix.de>
 <CAMuHMdW=h922855yyiiR2Bo+P2Dg7S7r1pVBF56S+Z0ytng3fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4oa35okzj2bp3axr"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW=h922855yyiiR2Bo+P2Dg7S7r1pVBF56S+Z0ytng3fA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4oa35okzj2bp3axr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 26, 2022 at 09:05:42AM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 26, 2022 at 2:17 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Oct 25, 2022 at 04:03:42PM +0200, Geert Uytterhoeven wrote:
> > > The PWM subsystem supports compile-testing if CONFIG_PWM is disabled.
> > > However, no dummy is provided for devm_pwmchip_add(), which may lead =
to
> > > build failures.
> > >
> > > Fixes: bcda91bf86c1ff76 ("pwm: Add a device-managed function to add P=
WM chips")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Is this a problem that today yields a failure to compile? As of v6.1-rc1
> > and also in next all callers are below drivers/pwm/ which isn't included
> > in the build without PWM=3Dy.
>=20
> So none of these support compile-testing with CONFIG_PWM=3Dn...

There are not many pwm providers outside of drivers/pwm:

 - drivers/gpio/gpio-mvebu.c
 - drivers/gpu/drm/bridge/ti-sn65dsi86.c
 - drivers/leds/rgb/leds-qcom-lpg.c
 - drivers/staging/greybus/pwm.c

These all call pwmchip_add() which has a dummy.

gpio-mvebu only uses it in an if (IS_ENABLED(CONFIG_PWM)) block.
ti-sn65dsi86 has it in a big #ifdef CONFIG_PWM block (and in a dedicated
driver such that the returned error doesn't hurt).

leds-qcom-lpg.c depends on PWM as does the greybus stuff.

So the dummy isn't even needed. (Unless for the corner case GPIO_MVEBU=3Dy
+ PWM=3Dm which is probably a bug worth fixing. Maybe a similar issue
exists for ti-sn65dsi86.)

> > Am I missing something or is this just preparing that one of the drivers
> > that doesn't live in drivers/pwm might call devm_pwmchip_add in the
> > future?
>=20
> I saw it with the RZ/G2L MTU3 PWM driver[1], which is not yet applied.
> After noticing its sibling counter driver lacked a dependency on
> CONFIG_COUNTER, I tried disabling CONFIG_PWM...
>=20
> > In that case I wouldn't add that Fixes: line (and also oppose to
> > backporting that commit to stable).
>=20
> I tend to disagree: more drivers may be converted to devm_pwmchip_add()
> in the future, possibly as part of a fix, causing troubles for the
> stable team when backporting such fixes.

Please don't backport as a precaution not to miss to backport it in case
there is another patch that depends on it. In my experience the stable
maintainers are good at identifying such dependencies.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4oa35okzj2bp3axr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2GrsACgkQwfwUeK3K
7AlxUwgAoI6Bmom9R1BQ6dVKKaQSiiL4Q5yxOafXc1axVKC/IUCX60/RvBFUwEWq
ABqvQ4ZqmDv+k24vyMHgnO4qcT4fBog9MFNReXm1won9Zkr1Sw0h0olvERymjiHj
8CdXXXEMvjg6IOAbQ8jC3ZjU355baYdFVflRTO1k52dPRMzP32zBIF/avcRcrTaT
YnKGw9wmDfZdIGWx5vfokNmSzYLGsZSNxv2SsBWXf3QJRWC6reBaAalL8AZkzXq+
hqQDHwV7OQSZMc7UkQfoQmHvznyg/fPQxL2qIImziwgRN9+rvuWgVqrAJjcj8New
DfMBkJnfxbqv4pHoqmKS3rL0MBiz9Q==
=4Qj1
-----END PGP SIGNATURE-----

--4oa35okzj2bp3axr--
