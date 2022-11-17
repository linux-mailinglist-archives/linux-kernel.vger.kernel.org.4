Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D845962D9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiKQL4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiKQL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:56:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C28CC5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:56:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdVM-0007R9-Ut; Thu, 17 Nov 2022 12:56:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdVI-004qBl-J9; Thu, 17 Nov 2022 12:56:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdVI-00HGd9-RM; Thu, 17 Nov 2022 12:56:24 +0100
Date:   Thu, 17 Nov 2022 12:56:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] pwm: mediatek: Add support for MT7986
Message-ID: <20221117115624.t2kbwscxvkvffo7x@pengutronix.de>
References: <Y1K5ym1EL8kwzQEt@makrotopia.org>
 <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aq4gg466ou5l6xl3"
Content-Disposition: inline
In-Reply-To: <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
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


--aq4gg466ou5l6xl3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 02:35:43PM +0800, Sam Shih wrote:
> Hi Daniel:
>=20
> On Fri, 2022-10-21 at 16:24 +0100, Daniel Golle wrote:
> > Add support for PWM on MT7986 which has 2 PWM channels, one of them
> > is
> > typically used for a temperature controlled fan.
> >=20
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index 6901a44dc428de..2219cba033e348 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -329,6 +329,12 @@ static const struct pwm_mediatek_of_data
> > mt8365_pwm_data =3D {
> >  	.has_ck_26m_sel =3D true,
> >  };
> > =20
> > +static const struct pwm_mediatek_of_data mt7986_pwm_data =3D {
> > +	.num_pwms =3D 2,
> > +	.pwm45_fixup =3D false,
> > +	.has_ck_26m_sel =3D true,
>=20
> For MT7986 SoC, I think the value of "has_ck_26m_sel" should be 'false'=
=20

The status of the discussion isn't clear to me. You didn't visibly agree
which value is right now. Will there be a v2 of this patch? Or is it
expected to be picked up as is.

=46rom my side (i.e. not having checked the hw details just judging with
the PWM hat on) the patch is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aq4gg466ou5l6xl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2IWUACgkQwfwUeK3K
7AkCGgf8D0n16cUNaduKAMRMUuH4hjmKpk5FX5dK1EbfYOZDiNUshNbRP0Sq6gLP
KNs+9hYKqp9R54iZZq5OkcoCDBw7T5fnK/lwx6Q16p1vmOiDJWE9MjRNW2ubFf23
B7CbL2X4NGn2iZBUYhHwpiOk59l8IbR9ShI9h6nY71/kMyGhhK7C0sLhCy6LRu3f
EL6LUG3x0sayHV30vX2fXqslsiJTH3bej15hl9W+DlmWAX7pBQKh/nzOaWWx1eFT
rHqIAsDZ7KB5VqZipJL5mv1rfVtqdALei2WOIU1wb83W/gS7g4lhyCpEUGnfs1Nd
oku3o1XXF73XMFAkszSDVOD39zYPVw==
=sK3N
-----END PGP SIGNATURE-----

--aq4gg466ou5l6xl3--
