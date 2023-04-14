Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5826E1BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDNFkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDNFkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:40:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE8271E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:40:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCAC-0006SE-0k; Fri, 14 Apr 2023 07:40:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCAA-00B80H-9r; Fri, 14 Apr 2023 07:39:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnCA9-00D4DJ-Hw; Fri, 14 Apr 2023 07:39:57 +0200
Date:   Fri, 14 Apr 2023 07:39:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenz Brun <lorenz@brun.one>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] pwm: mediatek: support inverted polarity
Message-ID: <20230414053956.brgzufk4qjsswhqn@pengutronix.de>
References: <20230309010410.2106525-1-lorenz@brun.one>
 <ZC7LaC19YjNwTIi1@orome>
 <20230406135358.x3et6gvvxqsknfn6@pengutronix.de>
 <ZC7Xf8Wy1x9gnaAY@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhkhdogtpy7q73k5"
Content-Disposition: inline
In-Reply-To: <ZC7Xf8Wy1x9gnaAY@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhkhdogtpy7q73k5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2023 at 04:30:23PM +0200, Thierry Reding wrote:
> On Thu, Apr 06, 2023 at 03:53:58PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry,
> >=20
> > On Thu, Apr 06, 2023 at 03:38:48PM +0200, Thierry Reding wrote:
> > > On Thu, Mar 09, 2023 at 02:04:10AM +0100, Lorenz Brun wrote:
> > > > +	 * appear to have the capability to invert the output.
> > > > +	 * This means that inverted mode can not be fully supported as the
> > > > +	 * waveform will always start with the low period and end with th=
e high
> > > > +	 * period. Thus reject non-normal polarity if the shape of the wa=
veform
> > > > +	 * matters, i.e. usage_power is not set.
> > > > +	 */
> > > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL && !state->usage_pow=
er)
> > > >  		return -EINVAL;
> > > > =20
> > > >  	if (!state->enabled) {
> > > > @@ -213,7 +221,11 @@ static int pwm_mediatek_apply(struct pwm_chip =
*chip, struct pwm_device *pwm,
> > > >  		return 0;
> > > >  	}
> > > > =20
> > > > -	err =3D pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, st=
ate->period);
> > > > +	duty_cycle =3D state->duty_cycle;
> > > > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > > > +		duty_cycle =3D state->period - state->duty_cycle;
> > >=20
> > > That's not really what state->usage_power was meant to address.
> >=20
> > I don't understand your concern here. I don't like .usage_power, but
> > AFAICT this is a legitimite use. With .usage_power =3D true, the lowlev=
el
> > driver is free to shift the phase_offset and even modify the period size
> > and the goal is just that the average power-output matches.
> >=20
> > Lorenz's patch does exactly this: It even keeps the period and only
> > shifts the phase (by period - duty_cycle). If you consider this not
> > legitmate, I think we have to improve the docs about .usage_power.
>=20
> I realize that I'm being nitpicky here. Setting usage_power =3D true and
> duty =3D period - duty is a lazy way of achieving what you can easily do
> by adjusting the input duty cycle.
>=20
> If you all really want this, then it should go into the core, because
> it's something that can be implemented on basically every single PWM
> controller.

You'd need something like:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e01147f66e15..6bb851c2e55e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -556,6 +556,7 @@ static void pwm_apply_state_debug(struct pwm_device *pw=
m,
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
+	bool retry_inverted =3D true;
 	int err;
=20
 	/*
@@ -580,10 +581,19 @@ int pwm_apply_state(struct pwm_device *pwm, const str=
uct pwm_state *state)
 	    state->usage_power =3D=3D pwm->state.usage_power)
 		return 0;
=20
+retry:
 	err =3D chip->ops->apply(chip, pwm, state);
 	trace_pwm_apply(pwm, state, err);
-	if (err)
+	if (err) {
+		if (err =3D=3D -EINVAL && state->usage_power && retry_inverted) {
+			state->duty_cycle =3D state->period - state->duty_cycle;
+			state->polarity =3D 1 - state->polarity;
+			retry_inverted =3D false;
+			goto retry;
+		}
+
 		return err;
+	}
=20
 	pwm->state =3D *state;
=20
(Just to show the idea. It doesn't work like that, because *state is const.)

I don't like that .apply() is called twice and without having thought
much about it, I'd prefer explicit support in the lowlevel drivers over
this approach.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yhkhdogtpy7q73k5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ45ysACgkQj4D7WH0S
/k5KvwgAu/DxWjR+8IVUMgiC/Mt03EWw9prFOkM7WuY9uVichi8FtqTAcz9ZvFoi
DUWrejfZtFimOpBC/f8it5jUvMNvfJWyDHAkhFoCadF9a7KJcuD6/LytbLZ9lBhf
kKwuje4NMiMqcx/IBwK40og+b9HX0EKv3cj538DBS1rJfGNeb0Zi7U0oGWtcKLWh
2cKuSR+zwpTSbz/EIsLxkQ1HxDoLcvRnWDcdyuRwSJ83fajsyOGwp9HYQxG4ufZd
X5TelDTm2426/4bGkNT3+NBmmAXh9ch2twTfUYr2cEVyf2+yfPWRvzqwEfST8L7M
Q+sAwmCE76u4VOXYfuhz4I45STGmSQ==
=GjxX
-----END PGP SIGNATURE-----

--yhkhdogtpy7q73k5--
