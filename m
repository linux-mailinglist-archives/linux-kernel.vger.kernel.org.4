Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3412666575C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjAKJZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbjAKJYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:24:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8DB85A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:24:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFXL7-0004YD-Bm; Wed, 11 Jan 2023 10:24:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFXL5-005GhI-VR; Wed, 11 Jan 2023 10:24:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFXL5-00Bvi4-7u; Wed, 11 Jan 2023 10:24:07 +0100
Date:   Wed, 11 Jan 2023 10:24:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230111092407.j45jxtukctchto3q@pengutronix.de>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
 <Y73/oUwuOwQFR0NZ@spud>
 <20230111070250.w7egzcufa4waxg2n@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhjecy72luuqdxw2"
Content-Disposition: inline
In-Reply-To: <20230111070250.w7egzcufa4waxg2n@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhjecy72luuqdxw2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 11, 2023 at 08:02:50AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Jan 11, 2023 at 12:15:29AM +0000, Conor Dooley wrote:
> > On Tue, Jan 10, 2023 at 11:48:05PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Dec 21, 2022 at 11:29:12AM +0000, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > > > +		delay_us =3D DIV_ROUND_UP_ULL(remaining_ns, NSEC_PER_USEC);
> > > > +		if ((delay_us / 1000) > MAX_UDELAY_MS)
> > > > +			msleep(delay_us / 1000 + 1);
> > >=20
> > > Is this better than
> > >=20
> > > 	msleep(DIV_ROUND_UP(delay_us, 1000);
> > >=20
> > > ? Also I wonder about your usage of MAX_UDELAY_MS. This is about
> >=20
> > I probably started hacking on the example you gave and didn't notice
> > the U. What I have here is ~what you suggested last time.
>=20
> A series with (up to now) 13 revisions and long delays between the
> review rounds (which are mostly attributed to my time schedule) is
> difficult to handle on both sides. Some repetition isn't easy to prevent
> in such a case. Sorry for that.=20
>=20
> > > udelay() but you're using usleep_range()?
> > >=20
> > > > +		else
> > > > +			usleep_range(delay_us, delay_us * 2);
> > >=20
> > > I wonder if there isn't a function that implements something like
> > >=20
> > > 	wait_until(mchp_core_pwm->update_timestamp);
> > >=20
> > > which would be a bit nicer than doing this by hand. Maybe fsleep()?
> >=20
> > That'd be fsleep(delay_us), but does at least clean up some of the
> > messing.
> >=20
> > > > +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct=
 pwm_device *pwm,
> > > > +				     const struct pwm_state *state, u64 duty_steps,
> > > > +				     u8 period_steps)
> > > > +{
> > > > +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chi=
p);
> > > > +	u8 posedge, negedge;
> > > > +	u8 period_steps_val =3D PREG_TO_VAL(period_steps);
> > > > +
> > > > +	/*
> > > > +	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
> > > > +	 * so that's an unsuitable setting to model duty_steps =3D 0.
> > > > +	 * In that case set the unwanted edge to a value that never
> > > > +	 * triggers.
> > > > +	 */
> > > > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> > > > +		negedge =3D !duty_steps ? period_steps_val : 0u;
> > >=20
> > > IMHO
> > >=20
> > > 		negedge =3D duty_steps ? 0 : period_steps_val;
> > >=20
> > > is a bit easier to parse.
> > >=20
> > > > +		posedge =3D duty_steps;
> > > > +	} else {
> > > > +		posedge =3D !duty_steps ? period_steps_val : 0u;
> > > > +		negedge =3D duty_steps;
> > > > +	}
> > >=20
> > > The following code is equivalent:
> > >=20
> > > 	u8 first_edge =3D 0, second_edge =3D duty_steps;
> > >=20
> > > 	/*
> > > 	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
> > > 	 * so that's an unsuitable setting to model duty_steps =3D 0.
> > > 	 * In that case set the unwanted edge to a value that never
> > > 	 * triggers.
> > > 	 */
> > > 	if (duty_steps =3D=3D 0)
> > > 		first_edge =3D period_steps_val;
> > >=20
> > > 	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> > > 		negedge =3D first_edge;
> > > 		posedge =3D second_edge;
> > > 	} else {
> > > 		posedge =3D first_edge;
> > > 		negedge =3D second_edge;
> > > 	}
> > >=20
> > > I'm not sure if it's easier to understand. What do you think?
> >=20
> > Despite having used them, I dislike ternary statements.
>=20
> My variant is a bit longer and uses more variables, but has less
> repetition. I don't expect a relevant change on the generated code. I
> slightly prefer my variant, but I let you choose which one you prefer.
>=20
> > > > +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE=
(pwm->hwpwm));
> > > > +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE=
(pwm->hwpwm));
> > > > +}
> > > > +
> > > > +static void mchp_core_pwm_calc_period(const struct pwm_state *stat=
e, unsigned long clk_rate,
> > > > +				      u16 *prescale, u8 *period_steps)
> > > > +{
> > > > +	u64 tmp;
> > > > +
> > > > +	/*
> > > > +	 * Calculate the period cycles and prescale values.
> > > > +	 * The registers are each 8 bits wide & multiplied to compute the=
 period
> > > > +	 * using the formula:
> > > > +	 * (clock_period) * (prescale + 1) * (period_steps + 1)
> > > > +	 * so the maximum period that can be generated is 0x10000 times t=
he
> > > > +	 * period of the input clock.
> > > > +	 * However, due to the design of the "hardware", it is not possib=
le to
> > > > +	 * attain a 100% duty cycle if the full range of period_steps is =
used.
> > > > +	 * Therefore period_steps is restricted to 0xFE and the maximum m=
ultiple
> > > > +	 * of the clock period attainable is 0xFF00.
> > > > +	 */
> > > > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC=
);
> > > > +
> > > > +	/*
> > > > +	 * The hardware adds one to the register value, so decrement by o=
ne to
> > > > +	 * account for the offset
> > > > +	 */
> > > > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > > > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > > > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> > > > +
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> > > > +	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
> > > > +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
> > >=20
> > > This looks wrong, but I didn't think long about that. Did we discuss
> > > this already and/or are you sure this is correct?
> >=20
> > We did discuss it previously AFAICT;
> > https://lore.kernel.org/linux-pwm/896d73ac-05af-8673-8379-29011800be83@=
microchip.com/
> >=20
> > [...]
> > Unfortunately, I don't think I am seeing what you're seeing.
>=20
> Well, the calculation lands in the right ballpark for sure, but if my
> intuition is right, it's not as exact as it could be. I need some time
> with pencil and paper ...

Just a small heads up:

I thought a bit about that (without pencil and paper on my way to work
today), and the optimal solution is non-trivial. In fact you have to
pick parameters A and B such that for a given C

	(A + 1) * (B + 1) is maximal with

	0 <=3D A < 0x100
	0 <=3D B < 0xff
	(A + 1) * (B + 1) <=3D C

A consistent non-optimal choice that is easier to calculate than a
complete search would be nice. But I think we're not there yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mhjecy72luuqdxw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO+gDQACgkQwfwUeK3K
7AltbQf9H1ghpi5yxykLUDlGt2l0EF3YVHc6Av8M/Wwd6egluj/tuF4Y/cVih0FN
0YYZ1lTzqgfL+aC0r1YgCfZq+jPkndV+otUOLkH4UiFSd8fl1GCbgBf6Xx0P3Qbp
arFtMeBjDKRsERULwqGsPqWXmFeNM3h62dLxoCfyUskVCFmePeddLR+XwJAIhpNy
mwnrk9MJbBqtYiqzMl+lbdTYkHxLFlsaXpxRai2XaXS1AkYyZwh6nH65+Crs/pf3
HruUmLB8ow4gZUE+XnmuQTAlJSRx3T1DgctdWKQRuW7Nxi+oDndJNg8wli1sbLmw
WqlzIf/h3yr7/5sWbK4RZmXhXnZ1eA==
=IZv2
-----END PGP SIGNATURE-----

--mhjecy72luuqdxw2--
