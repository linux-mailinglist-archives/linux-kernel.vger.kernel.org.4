Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E85BCDA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiISNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiISNuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:50:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130A31371
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:50:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaHA2-0002QG-Lv; Mon, 19 Sep 2022 15:50:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaHA2-001fvx-Kk; Mon, 19 Sep 2022 15:50:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaHA0-001ytC-9p; Mon, 19 Sep 2022 15:50:08 +0200
Date:   Mon, 19 Sep 2022 15:50:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yjnvpolgdstr7x3j"
Content-Disposition: inline
In-Reply-To: <YyhmZBmfJvJ9/vBg@wendy>
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


--yjnvpolgdstr7x3j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2022 at 01:53:56PM +0100, Conor Dooley wrote:
> Hey Uwe,
> Thanks (as always). I've switched up my email setup a bit so I hope
> that I've not mangled anything here.
>=20
> On Thu, Sep 15, 2022 at 09:21:52AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Wed, Aug 24, 2022 at 10:12:14AM +0100, Conor Dooley wrote:
> > > Add a driver that supports the Microchip FPGA "soft" PWM IP core.
> > >=20
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  drivers/pwm/Kconfig              |  10 +
> > >  drivers/pwm/Makefile             |   1 +
> > >  drivers/pwm/pwm-microchip-core.c | 402 +++++++++++++++++++++++++++++=
++
> > >  3 files changed, 413 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-microchip-core.c
> > >=20
>=20
> > > +static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > > +			       const struct pwm_state *state)
> > > +{
> > > +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> > > +	struct pwm_state current_state =3D pwm->state;
> > > +	bool period_locked;
> > > +	u64 duty_steps;
> > > +	u16 prescale;
> > > +	u8 period_steps;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&mchp_core_pwm->lock);
> > > +
> > > +	if (!state->enabled) {
> > > +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> > > +		mutex_unlock(&mchp_core_pwm->lock);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * If the only thing that has changed is the duty cycle or the pola=
rity,
> > > +	 * we can shortcut the calculations and just compute/apply the new =
duty
> > > +	 * cycle pos & neg edges
> > > +	 * As all the channels share the same period, do not allow it to be
> > > +	 * changed if any other channels are enabled.
> > > +	 * If the period is locked, it may not be possible to use a period
> > > +	 * less than that requested. In that case, we just abort.
> > > +	 */
> > > +	period_locked =3D mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpw=
m);
> > > +
> > > +	if (period_locked) {
> > > +		u16 hw_prescale;
> > > +		u8 hw_period_steps;
> > > +
> > > +		mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_st=
eps);
> >=20
> > Huh, if (u8 *)&prescale works depends on endianness.
>=20
> Big endian? What's that? ;)
> I think the cast can just be dropped and the u16 used directly instead.
>=20
> >=20
> > > +		hw_prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PR=
ESCALE);
> > > +		hw_period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPW=
M_PERIOD);
> > > +
> > > +		if ((period_steps + 1) * (prescale + 1) <
> > > +		    (hw_period_steps + 1) * (hw_prescale + 1)) {
> > > +			mutex_unlock(&mchp_core_pwm->lock);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		/*
> > > +		 * It is possible that something could have set the period_steps
> >=20
> > My German feel for the English language says s/could have/has/
>=20
> What I wrote is _fine_ but the could is redudant given the possible.
> I'll change it over.
>=20
> > > +		 * register to 0xff, which would prevent us from setting a 100%
> >=20
> > For my understanding: It would also prevent a 0% relative duty, right?
>=20
> Yeah, I guess the comment could reflect that.
>=20
> >=20
> > > +		 * duty cycle, as explained in the mchp_core_pwm_calc_period()
> >=20
> > s/duty/relative duty/; s/the //
> >=20
> > > +		 * above.
> > > +		 * The period is locked and we cannot change this, so we abort.
> > > +		 */
> > > +		if (period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS_MAX) {
> >=20
> > Don't you need to check hw_period_steps =3D=3D MCHPCOREPWM_PERIOD_STEPS=
_MAX
> > here?
>=20
> D'oh.
>=20
> >=20
> > > +			mutex_unlock(&mchp_core_pwm->lock);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		prescale =3D hw_prescale;
> > > +		period_steps =3D hw_period_steps;
> > > +	} else if (!current_state.enabled || current_state.period !=3D stat=
e->period) {
> > > +		ret =3D mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &p=
eriod_steps);
> >=20
> > ret is only used in this block, so the declaration can go into here,
> > too.
> >=20
> > > +		if (ret) {
> > > +			mutex_unlock(&mchp_core_pwm->lock);
> > > +			return ret;
> > > +		}
> > > +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> > > +	} else {
> > > +		prescale =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESC=
ALE);
> > > +		period_steps =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_P=
ERIOD);
> > > +		/*
> > > +		 * As above, it is possible that something could have set the
> > > +		 * period_steps register to 0xff, which would prevent us from
> > > +		 * setting a 100% duty cycle, as explained above.
> > > +		 * As the period is not locked, we are free to fix this.
> > > +		 */
> >=20
> > Are you sure this is safe? I think it isn't. Consider:
> >=20
> > 	pwm_apply_state(mypwm, { .duty =3D 0, .period =3D A, .enabled =3D true=
, });
> > 	pwm_apply_state(mypwm, { .duty =3D 0, .period =3D B, .enabled =3D fals=
e, });
> > 	pwm_apply_state(mypwm, { .duty =3D 0, .period =3D B, .enabled =3D true=
, });
> >=20
> > Then you have in the third call prescale and period_steps still
> > corresponding to A because you didn't update these registers in the 2nd
> > call as you exited early.
>=20
> Riiight. I think I am a little confused here - this comment does not
> refer to my comment but rather to the whole logic I have?
>=20
> As in, what you're concerned about is the early exit if the state is
> disabled & that I take the values in the hardware as accurate?

No, the thing I'm concerned about is assuming MCHPCOREPWM_PRESCALE and
MCHPCOREPWM_PERIOD correspond to state->period. So I'd drop the last
block use the 2nd last instead without further condition.

> What makes sense to me to do here (assuming I understood correctly)
> is to compare state->period against what is in the hardare rather than
> against what the pwm core thinks?
> Or else I could stop exiting early if the pwm is to be disabled &
> instead allow the period and duty to be set so that the state of the
> hardware is as close to the pwm core's representation of it as possible.

exiting early is fine.
=20
> > > [...]
> > > +	period_steps =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MC=
HPCOREPWM_PERIOD));
> > > +	state->period =3D period_steps * prescale * NSEC_PER_SEC;
> >=20
> > This is broken on 32 bit archs (here: arm):
> >=20
> > $ cat test.c
> > #include <inttypes.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> >=20
> > int main(int argc, char *argv[])
> > {
> > 	uint8_t period_steps =3D atoi(argv[1]);
> > 	uint16_t prescale =3D atoi(argv[2]);
> > 	uint64_t period;
> >=20
> > 	period =3D period_steps * prescale * 1000000000L;
> >=20
> > 	printf("period_steps =3D %" PRIu8 "\n", period_steps);
> > 	printf("prescale =3D %" PRIu16 "\n", prescale);
> > 	printf("period =3D %" PRIu64 "\n", period);
> >=20
> > 	return 0;
> > }
> >=20
> > $ make test
> > cc     test.c   -o test
> >=20
> > $ ./test 255 65535
> > period_steps =3D 255
> > prescale =3D 65535
> > period =3D 18446744073018591744
> >=20
> > The problem is that the result of 16711425 * 1000000000L isn't affected
> > by the type of period and so it's promoted to L which isn't big enough
> > to hold 16711425000000000 where longs are only 32 bit wide.
>=20
> I don't think this is ever going to be hit in the wild, since prescale
> comes from the hardware where it is limited to 255 - but preventing the
> issue seems trivially done by splitting the multiplication so no reason
> not to. Thanks for providing the test program btw :)

Even 255 * 255 * 1000000000 overflows. With a maintainer's hat on, it is
very valuable to prevent such issues because your driver might be used
as a template for the next driver.

> > > +	state->period =3D DIV64_U64_ROUND_UP(state->period, clk_get_rate(mc=
hp_core_pwm->clk));
> > > +
> > > +	posedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE=
(pwm->hwpwm));
> > > +	negedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE=
(pwm->hwpwm));
> > > +
> > > +	if ((negedge =3D=3D posedge) && state->enabled) {
> >=20
> > Why do you need that state->enabled?
>=20
> Because I was running into conflicts between the reporting here and some
> of the checks that I have added to prevent the PWM being put into an
> invalid state. On boot both negedge and posedge will be zero & this was
> preventing me from setting the period at all.

I don't understood that.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yjnvpolgdstr7x3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMoc40ACgkQwfwUeK3K
7AnWqQf/euRAqgVV+WmeX3jxNeE9x9t586LeUuGK145SnL9adalZFxcJJ0fB875y
U0T5p2i2KkSPbnI10pJUYLXCcgPnHFgSJsY8CVOBUvSYcSsI2Hz3yPIv1x6v+HZf
5AAflaZXpahU37PHuKHyx2WZb64WuMoGwpikrfO2744VC0b5kSlM5MvuvhIs939L
WWY5kq0Qh+A+VDZHmpJYRRI9JDctd4kDcEatvTPHuRmXDd4omDDdbqXj1INK67ML
NFXsvw4584d8UiDzNMEyaL5YVUUT2Ta+x3iwX8MnnFJquNremvbX4Sapho3vPu83
NBXqmVZ5ohCpuG42AtSx0hw/2VO6aQ==
=V/4c
-----END PGP SIGNATURE-----

--yjnvpolgdstr7x3j--
