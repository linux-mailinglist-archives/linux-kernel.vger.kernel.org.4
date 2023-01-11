Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218D46655A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAKIC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbjAKIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:01:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D3F5B7;
        Wed, 11 Jan 2023 00:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673424077; x=1704960077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pCPF/jbvTEFtAT8/l9myxQBO5ti7YRWIFj+IrkVL6+g=;
  b=ehAp04/vJZUjmz3pm3LEOTxMBGDp6sULPukh1omQlmyw9Ol08pyAHVgc
   2RlTmr+inJcmf0EsTOjZccUFeVvfhpCdoJTNQcZ6X7OUyu9ecEzeGIERo
   2u2EShAOfFL2TEGrRkANcf/YyAgdD+KtWYgGfVym3SRJb6XaAfAmKYc9g
   ZPXzIBdMJS0RRiv/EVKtDNpa6IXvEwJQTNWRTw2hOVR4uCDbeGJjs4WCN
   xmCnV8znbm04olcNc29HnGXjUhhSroPs4ijBA0I2nNU3U6FzcNlhe0XJa
   CBEH/Gz8eJGZ0g6OUMLlE7DY8iVIWCOdKZarWjnNVV1HHl4GKvtAlUL35
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="asc'?scan'208";a="196159866"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2023 01:01:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 01:01:15 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 11 Jan 2023 01:01:13 -0700
Date:   Wed, 11 Jan 2023 08:00:51 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Conor Dooley <conor@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y75ss+aSCjx7E9SZ@wendy>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
 <Y73/oUwuOwQFR0NZ@spud>
 <20230111070250.w7egzcufa4waxg2n@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E6V8omzJMHIjX4MZ"
Content-Disposition: inline
In-Reply-To: <20230111070250.w7egzcufa4waxg2n@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--E6V8omzJMHIjX4MZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Uwe,

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
> in such a case. Sorry for that.

It is what it is, you've only got so much time :)

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

Yah, I prefer anything that doesn't have ternarys in it.

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
>=20
> > [...]
> > Perhaps I need to watch a lecture on how to write a PWM driver since I
> > am clearly no good at it, given the 15 revisions. Do you know of any?
>=20
> I'm not aware of such a lecture.

I thought you were doing one at FOSDEM!

> I'm willing to take the blame for some
> of the revisions because I'm very picky and the math involved here isn't
> trivial.

I'd rather the maths was right. Fixing it up front is better than trying
to debug it from a customer complaint - so thanks for that.
And the maths was very naive to begin with, although I only submitted it
in the summer, I think I wrote the driver prior to having upstreamed a
single patch, and I think that showed in the maths.

> And I sometimes wonder about myself pointing out an issue in
> (say) v5 which was there unnoticed already in v1.

I dunno. I feel bad if I do that too - but if the problem you didn't
notice earlier on is a bug, rather than some sort of style comment, I
don't see why you wouldn't call it out.

> In sum a patch series going through such a high number of revisions is
> mostly a good sign.

Or that it was poor to begin with & barely improved over time...

> In the end we can be sure that the merged code is
> checked deep-rootedly and that both you and me have a certain amount of
> endurance. :-)

I wasn't really blaming you for the number of revisions, the number of
silly mistakes I've made really irritates me.

Thanks,
Conor.


--E6V8omzJMHIjX4MZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY75srAAKCRB4tDGHoIJi
0kKWAQDPqazsRBhltTrzGU+iYTrjjhqwkas55kbz+huUuHmgYwD+KoxtcvsbR0IB
zlz6r5+GOtTG0OjHM+4nihdmtppAGwE=
=qlzw
-----END PGP SIGNATURE-----

--E6V8omzJMHIjX4MZ--
