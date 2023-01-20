Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E7675E33
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjATTkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:40:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A31859B78;
        Fri, 20 Jan 2023 11:40:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC31FB82A52;
        Fri, 20 Jan 2023 19:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BED6C4339B;
        Fri, 20 Jan 2023 19:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674243636;
        bh=XwfKwgfengOAeie8NkJ0IoN7XbRpPslgW2u+/kjN/88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkxzIN8Uq3cBx2VVFviRHm52YUEz4ST4CEz5vRml9C+uVmn+iUnPQAF1sAb0K4XDg
         CLTvnJzx+CAZ1IhF2jsmWyGf7FMmr2DCc+rETIKlSITl5ivK4UkKhlVz68gHgte8cq
         +f53vT+vx46gH6QsKesjZ7Kms+d9i8fvfa8DAgeb4i4BLKm4ZkpbyN1CgxXz+NxX7+
         xYVO6JaA1VWkXQwFukQ3EpE11ssN3D507hYNfEwWL+fR8Lv3lWzS8gmPbGnRb/onev
         ipTEcb4DzUTHq/z6ot0cxVS+MIy40eW6+FpLgFjmAZzAno8ioPV8MibnhxwW+awAV/
         v6eIkNsX/2Ruw==
Date:   Fri, 20 Jan 2023 19:40:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y8ruML/XnJHjVWy/@spud>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
 <20230112120141.fpjwhtjuaxrwqt5m@pengutronix.de>
 <Y8Ai0aF5A+O43kjZ@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X3JjaQUEq6UBbiBW"
Content-Disposition: inline
In-Reply-To: <Y8Ai0aF5A+O43kjZ@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X3JjaQUEq6UBbiBW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 03:10:09PM +0000, Conor Dooley wrote:
> On Thu, Jan 12, 2023 at 01:01:41PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Tue, Jan 10, 2023 at 11:48:05PM +0100, Uwe Kleine-K=F6nig wrote:
> > > Hello Conor,
> > >=20
> > > On Wed, Dec 21, 2022 at 11:29:12AM +0000, Conor Dooley wrote:
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
> > >=20
> > > (We have:
> > > 	          (prescale + 1) * (period_steps + 1)
> > > 	period =3D ------------------------------------
> > > 	                       clk_rate
> > >=20
> >=20
> > We want prescale small such that period_steps can be big to give
> > fine-grained control over the available duty_cycles. period_steps is a
> > 8-bit value < 0xff, so we get:
> >=20
> >                     period * clk_rate  =20
> > 	prescale =3D ------------------- - 1
> >                    NSEC_PER_SEC * 0xff
> >=20
> > which in code then reads:
> >=20
> > 	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX)
> > 	if (*prescale)
> > 		*prescale -=3D 1;
> >=20
> >=20
> > > You calculate
> > > 	            period * clk_rate
> > > 	prescale =3D -------------------
> > > 	           NSEC_PER_SEC * 0xff
> > >=20
> > > 	                     period * clk_rate
> > > 	period_steps =3D ----------------------------- - 1
> > > 	               NSEC_PER_SEC * (prescale + 1)
> >=20
> > The formula for period_steps is right.
>=20
> I stood in front of the whiteboard for a bit to puzzle it all out and
> have come to the realisation that you are right. I was implicitly
> converting in my head from "mathematical" values to register values &
> therefore not subtracting. I must've hyperfocused on the underflow when
> I adjusted your suggestion back in v5 or w/e it was.
>=20
> I must also have got rather unlucky that the configurations I picked to
> check whether the calculations worked out, happened to. I suppose as
> well, the way in which it was mis-calculating also avoids the PWM_DEBUG
> complaints too.
>=20
> Perhaps I'll insert your nice formulae in the next version in comments,
> so they're there for next time.

*sigh*, me again...

Picked this up this afternoon to try and respin a v14 and ran into a bit
of an issue with this suggestion:

> > 	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX)
> > 	if (*prescale)
> > 		*prescale -=3D 1;

In theory this works out, but with integer division it doesn't AFAICT.

Take for example:
period_ns =3D 10,000
clk_rate =3D 62.5 MHz

The prescale calculation is:
(10000 * 62.5E6) / (1E9 * 255) - 1 =3D 1.451 -> 1

For period_steps then:
(10000 * 62.5E6) / (1E9 * (1 + 1)) - 1 =3D 311.5 -> 311

prescale is a u16, since it's valid for that division to return 256.
The register is only 8 bits wide though, so 311 overflows it and 55 ends
up in the register.
The period then is:
(55 + 1) * (1 + 1) / 62.5E6, or a period of 1792 ns.

I think it needs to be a div_u64_round_up(), which I know is not a real
function, otherwise we compute invalid values for period steps.

Quoting you previously:
> I thought a bit about that (without pencil and paper on my way to work
> today), and the optimal solution is non-trivial. In fact you have to
> pick parameters A and B such that for a given C
>=20
> 	(A + 1) * (B + 1) is maximal with
>=20
> 	0 <=3D A < 0x100
> 	0 <=3D B < 0xff
> 	(A + 1) * (B + 1) <=3D C

As we need (period_steps + 1) * (prescale + 1) maximal, *but* also want
to maximise period_steps so that duty resolution etc is maximal too.
We pick prescale, using the formula below, by setting period_steps to
the maximum possible value:
> 	            period * clk_rate
> 	prescale =3D -------------------
> 	           NSEC_PER_SEC * 0xff

Given we set period_steps to the max here, we only actually pick the
lower bound on prescale, not the actual value of it.
We must round it to the nearest possible value before using it to go
back and calculate period_steps.

With the previous code, missing the -=3D 1, the division result was purely
truncated:
(10000 * 62.5E6) / (1E9 * 255) =3D 2.451 -> 2
That 2 was written into the register, and then the hardware rounds that
up to 3, as does the period_steps calculation.

period_steps here is:
(10000 * 62.5E6) / (1E9 * (2 + 1)) - 1 =3D 207.833 -> 207

Finally, the period:
(207 + 1) * (2 + 1) / 62.5E6, or a period of 9984 ns.

This is the same operation, unless I am yet again overlooking something,
as doing a div_u64_round_up() type thing, followed by a subtraction of 1

We don't need to worry about writing something too big into the register
either, as we are protected against values of tmp that, when divided by
0xff, would produce values larger than 255:
> /*
>  * The hardware adds one to the register value, so decrement by one to
>  * account for the offset
>  */
> if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) { (PERIOD_MAX is 0xff00)
> 	*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> 	*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
>=20
> 	return;
> }

What am I missing this time? haha

Thanks,
Conor.


--X3JjaQUEq6UBbiBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8rt/gAKCRB4tDGHoIJi
0iatAQCiWUr71+kleFkmD8TZsQPgqyV+CuLMFzAXskATxG8f5wD9GL2ayz3Z6LYH
EyPlTYu1CUtEgw1sWG2MzlfWerdhOQY=
=1rPs
-----END PGP SIGNATURE-----

--X3JjaQUEq6UBbiBW--
