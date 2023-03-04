Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED436AA91B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 11:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCDKSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 05:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCDKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 05:18:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E617CDF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 02:18:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYOyB-0006Z6-CZ; Sat, 04 Mar 2023 11:18:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYOy9-001lQT-BQ; Sat, 04 Mar 2023 11:18:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYOy8-0025Pj-IL; Sat, 04 Mar 2023 11:18:24 +0100
Date:   Sat, 4 Mar 2023 11:18:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lorenz Brun <lorenz@brun.one>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pwm: mediatek: support inverted polarity
Message-ID: <20230304101824.ja7otxatkrrv2xxq@pengutronix.de>
References: <20230303205821.2285418-1-lorenz@brun.one>
 <20230303211725.7wtxdxjqpxlrp77b@pengutronix.de>
 <J6UYQR.PWF59DFFYYO71@brun.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gtzva4fuv4iy5elv"
Content-Disposition: inline
In-Reply-To: <J6UYQR.PWF59DFFYYO71@brun.one>
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


--gtzva4fuv4iy5elv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lorenz,

On Fri, Mar 03, 2023 at 11:23:07PM +0100, Lorenz Brun wrote:
> On Fri, Mar 3 2023 at 22:17:25 +01:00:00, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Mar 03, 2023 at 09:58:21PM +0100, Lorenz Brun wrote:
> > >  According to the MT7986 Reference Manual the Mediatek  PWM
> > > controller
> > >  doesn't appear to have support for inverted polarity.
> > >=20
> > >  This implements the same solution as in pwm-meson and just inverts
> > > the
> > >  duty cycle instead, which results in the same outcome.
> >=20
> > This idea is broken. This was recently discussed on the linux-pwm list
> > and I hope will be fixed soon. See
> > https://lore.kernel.org/linux-pwm/20230228093911.bh2sbp4tyfir2z5g@pengu=
tronix.de/T/#meda75ffbd4ef2048991ea2cd091c0c14b1bb09c2
> >=20
> Is the issue here emulating PWM_POLARITY_INVERSED by inverting the period=
 or
> the overflow issues?
> This driver currently rejects PWM_POLARITY_INVERSED, but the problem is t=
hat
> I have a board which inverts the output of the PWM peripheral (low-side
> MOSFET for higher-voltage open-drain output), thus I need to set the PWM
> node to output an inverted signal so that the final open-drain output
> behaves correctly as the signal has been inverted twice now.
>=20
> In my specific case this logic could also be added to pwm-fan, but this
> would lead to more complexity there as this type of circuit is generally
> handled by the PWM driver.

The issue is clear, and I'm sure the motivation was similar for meson.

However just inverting duty_cycle might hurt consumers who rely on
actually inversed polarity.

There is an approach available: You could implement support for
=2Eusage_power. However I don't like that concept because its semantic is
unclear (but in the past there is no agreement about that betweeen
Thierry and me).

My favourite would be to add a u64 duty_offset to struct pwm_state that
would allow to request something like:

       ________          ________          ________
   ___/        \________/        \________/        \______
   ^                 ^                 ^                 ^
   <->                duty_offset
      <------->       duty_cycle
   <----------------> period

Then todays requests would be equivalent to .duty_offset =3D 0, and
drivers would be advised to implement the biggest duty_offset not bigger
than requested (i.e. similar to how period and duty_cycle work).

This could even replace .polarity by setting .duty_offset =3D .period -
=2Eduty_cycle. And a consumer who doesn't care about polarity but only
about percentage of the active time during a period could signal that by
=2Eduty_offset =3D .period (or .period - 1?).

Of course that would be a bigger effort.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gtzva4fuv4iy5elv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQDGu0ACgkQwfwUeK3K
7AmsnAf/fWQuuTY0c+1r1b43FElwpoyXMnsuq1QzKB5KQRU60v/Z2fTek2f8fy0A
f+0KbZCb+OGdv6V0Ct83X41A4tIYWGDVs1dJYX6ZxbGFbaCWZ6dRIU/P9qpni2BO
3ezvTFrtY75hX6mrXNlEAmOG7oliIyw4vcSA+J4uR3z+lg8xNuj8/EVaWv1UVo8l
n8uUfImwADeST1FTJqTZnWTXywWoITc4Cql5ITWn+ZAmCTfTGBOkc3v1hvta7rOs
vBoIajVUbbL9QU9m/uuKaBk/YRLiuIIBxVdrNgV+RzY0mG3w/EpfSdXVVDPmz7vd
1pZRniBxLaHUN7aoSwm50Uczd6/UvA==
=Q76Z
-----END PGP SIGNATURE-----

--gtzva4fuv4iy5elv--
