Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538CD66504D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjAKAPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbjAKAPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:15:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996A41B9EB;
        Tue, 10 Jan 2023 16:15:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BBF6617F1;
        Wed, 11 Jan 2023 00:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA43AC433EF;
        Wed, 11 Jan 2023 00:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673396133;
        bh=S8NALjqA1f9q2qsyutdUstZwUdlgPhnHQ8ChH2jhBM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ls3LRdB8UnvmaIGCqcbdiGYlSrFpOt/wlyzqMQ+vIgqo/xSmseexLIOeh+ZcOpkBl
         Tmr/FbThk1VjVU6FuexmJaCjEaDYKyBO0PHOqoe5u7zI5r0TvKzHIGBpNO4XRDVYSK
         2epowly4t5XLw1xvBq3BzJz8xmbrNFI3WG/Y49bYB7ZKfLDXj96uhwMMSEaK7x2qgZ
         q1epxeyEJvoesP44P9vOJPkKbrwJegg4SKaL0ZFOGUt4jtdg46k0LWo1mn0HISlOnP
         AVkxYfPO2exSk4gp+hAV3WXNEzFN6HrRxUOOWjWoJ7LVy6V0S1HThUcSPqy7hfNsXo
         4i35pqlFLQIzA==
Date:   Wed, 11 Jan 2023 00:15:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y73/oUwuOwQFR0NZ@spud>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yEYmw9zT0Jb9K0Do"
Content-Disposition: inline
In-Reply-To: <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yEYmw9zT0Jb9K0Do
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2023 at 11:48:05PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Dec 21, 2022 at 11:29:12AM +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>

> > +		delay_us =3D DIV_ROUND_UP_ULL(remaining_ns, NSEC_PER_USEC);
> > +		if ((delay_us / 1000) > MAX_UDELAY_MS)
> > +			msleep(delay_us / 1000 + 1);
>=20
> Is this better than
>=20
> 	msleep(DIV_ROUND_UP(delay_us, 1000);
>=20
> ? Also I wonder about your usage of MAX_UDELAY_MS. This is about

I probably started hacking on the example you gave and didn't notice
the U. What I have here is ~what you suggested last time.

> udelay() but you're using usleep_range()?
>=20
> > +		else
> > +			usleep_range(delay_us, delay_us * 2);
>=20
> I wonder if there isn't a function that implements something like
>=20
> 	wait_until(mchp_core_pwm->update_timestamp);
>=20
> which would be a bit nicer than doing this by hand. Maybe fsleep()?

That'd be fsleep(delay_us), but does at least clean up some of the
messing.

> > +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm=
_device *pwm,
> > +				     const struct pwm_state *state, u64 duty_steps,
> > +				     u8 period_steps)
> > +{
> > +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> > +	u8 posedge, negedge;
> > +	u8 period_steps_val =3D PREG_TO_VAL(period_steps);
> > +
> > +	/*
> > +	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
> > +	 * so that's an unsuitable setting to model duty_steps =3D 0.
> > +	 * In that case set the unwanted edge to a value that never
> > +	 * triggers.
> > +	 */
> > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> > +		negedge =3D !duty_steps ? period_steps_val : 0u;
>=20
> IMHO
>=20
> 		negedge =3D duty_steps ? 0 : period_steps_val;
>=20
> is a bit easier to parse.
>=20
> > +		posedge =3D duty_steps;
> > +	} else {
> > +		posedge =3D !duty_steps ? period_steps_val : 0u;
> > +		negedge =3D duty_steps;
> > +	}
>=20
> The following code is equivalent:
>=20
> 	u8 first_edge =3D 0, second_edge =3D duty_steps;
>=20
> 	/*
> 	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
> 	 * so that's an unsuitable setting to model duty_steps =3D 0.
> 	 * In that case set the unwanted edge to a value that never
> 	 * triggers.
> 	 */
> 	if (duty_steps =3D=3D 0)
> 		first_edge =3D period_steps_val;
>=20
> 	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> 		negedge =3D first_edge;
> 		posedge =3D second_edge;
> 	} else {
> 		posedge =3D first_edge;
> 		negedge =3D second_edge;
> 	}
>=20
> I'm not sure if it's easier to understand. What do you think?

Despite having used them, I dislike ternary statements.

> > +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm=
->hwpwm));
> > +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm=
->hwpwm));
> > +}
> > +
> > +static void mchp_core_pwm_calc_period(const struct pwm_state *state, u=
nsigned long clk_rate,
> > +				      u16 *prescale, u8 *period_steps)
> > +{
> > +	u64 tmp;
> > +
> > +	/*
> > +	 * Calculate the period cycles and prescale values.
> > +	 * The registers are each 8 bits wide & multiplied to compute the per=
iod
> > +	 * using the formula:
> > +	 * (clock_period) * (prescale + 1) * (period_steps + 1)
> > +	 * so the maximum period that can be generated is 0x10000 times the
> > +	 * period of the input clock.
> > +	 * However, due to the design of the "hardware", it is not possible to
> > +	 * attain a 100% duty cycle if the full range of period_steps is used.
> > +	 * Therefore period_steps is restricted to 0xFE and the maximum multi=
ple
> > +	 * of the clock period attainable is 0xFF00.
> > +	 */
> > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> > +
> > +	/*
> > +	 * The hardware adds one to the register value, so decrement by one to
> > +	 * account for the offset
> > +	 */
> > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> > +
> > +		return;
> > +	}
> > +
> > +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> > +	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
> > +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
>=20
> This looks wrong, but I didn't think long about that. Did we discuss
> this already and/or are you sure this is correct?

We did discuss it previously AFAICT;
https://lore.kernel.org/linux-pwm/896d73ac-05af-8673-8379-29011800be83@micr=
ochip.com/

In that version of the code, prescale_val meant the mathematical value
used for calculations & "prescale" was the value written into the
register.

Now, we have ditched prescale_val and operate directly with what gets
written into the register.

I ran a test case through the calculation, and it seemed to work out?

> (We have:
> 	          (prescale + 1) * (period_steps + 1)
> 	period =3D ------------------------------------
> 	                       clk_rate
>=20
> You calculate
> 	            period * clk_rate
> 	prescale =3D -------------------
> 	           NSEC_PER_SEC * 0xff

Say period =3D 2000 ns, clk_rate =3D 62.5 Mhz, giving a register value for
prescale of 0.49019...=20

> 	                     period * clk_rate
> 	period_steps =3D ----------------------------- - 1
> 	               NSEC_PER_SEC * (prescale + 1)

Same numbers, but we use the PREG_TO_VAL() macro so the mathematical value
is 1.49019.

     2000 * 62.5E6
--------------------- - 1 =3D 82.88360....
  1E9 * (0.49016 + 1)

>=20
> assuming exact arithmetic putting these into the above equation we get:
>=20
>=20
>     period * clk_rate                period * clk_rate
>   (------------------- + 1) * (-----------------------------) / clk_rate
>    NSEC_PER_SEC * 0xff         NSEC_PER_SEC * (prescale + 1)
>=20
> and then substituting prescale this doesn't resolve to period, does it?
> Correct me if I'm wrong.)

(0.49016 + 1) * (82.88360 + 1)      124.99...
------------------------------ =3D ------------- =3D 0.00000199999
            62.5E6                  62.5E6

And then accounting for that fact that 2000 was really 2000E-9,
we arrive back where we started, give or take some rounding?

Doing that with integer maths works out more cleanly since 0.49016
becomes 0.
   2000 * 62.5E6
------------------ - 1 =3D 124
  1E9 * (0 + 1)

(0 + 1) * (124 + 1)      125
------------------- =3D --------- =3D 0.000002
      62.5E6            62.5E6

Unfortunately, I don't think I am seeing what you're seeing.

>     period * clk_rate                period * clk_rate
>   (------------------- + 1) * (-----------------------------) / clk_rate
>    NSEC_PER_SEC * 0xff         NSEC_PER_SEC * (prescale + 1)
                          ^
It may be this + 1, which I don't seem to have accounted for in my quick
run through a calculation?

*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);

*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;

The code does not add a 1 when it calculates prescale, only when it uses
the result to calculate period_steps, since prescale & period_steps are
the register values, not the "mathematical" ones.

Hopefully I've not gone and made a fool of myself...

> > +static inline void mchp_core_pwm_apply_period(struct mchp_core_pwm_chi=
p *mchp_core_pwm,
> > +					      u8 prescale, u8 period_steps)
> > +{
> > +	writel_relaxed(prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> > +	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD=
);
> > +}
>=20
> There is only one caller for this two-line function. I suggest to unroll =
it?

Sure.

> > +	ret =3D devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > +
> > +	/*
> > +	 * Enabled synchronous update for channels with shadow registers
> > +	 * enabled. For channels without shadow registers, this has no effect
> > +	 * at all so is unconditionally enabled.
> > +	 */
> > +	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > +	mchp_core_pwm->update_timestamp =3D ktime_get();
>=20
> This needs to be done before devm_pwmchip_add().

Makes sense, woops. I think I've revised this to the point that my
blinkers have turned on & I'll wait a while before resubmitting in order
to hopefully reset that.

Perhaps I need to watch a lecture on how to write a PWM driver since I
am clearly no good at it, given the 15 revisions. Do you know of any?

Thanks,
Conor.


--yEYmw9zT0Jb9K0Do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY73/oQAKCRB4tDGHoIJi
0kQtAP47wEjbwJd3pqvMM8aYpo0ysWTee61SPJg27vpz12bCrwD/StvsZMJkR1dh
Ls8jUMWX6cGvz11le4mdYEXFoH/EIQo=
=YK4p
-----END PGP SIGNATURE-----

--yEYmw9zT0Jb9K0Do--
