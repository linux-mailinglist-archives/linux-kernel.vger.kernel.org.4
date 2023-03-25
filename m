Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8816C8DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCYLww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCYLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5916CA0C;
        Sat, 25 Mar 2023 04:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107C660C16;
        Sat, 25 Mar 2023 11:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B33C433EF;
        Sat, 25 Mar 2023 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679745167;
        bh=sXbV/TftLmQpAeNMA8vvVMJeReclVGKSSqB68qrbnuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubqWOFT8flEnrgUaz9YwteMc4/d9/scmIctBM3gPDxYj3jR14qeHbOMt2aGGD21IS
         YwE26lU7nEdeLOBF8pts6rVWF6dsDMXiHoLw50B/+prM7qZtnTSx8Y3KJgfMla4rjq
         HRD9ZNkMR6+dRchgdhx0vzUb1ox2o/pArKrMSNDl9mauavSk6ZrO8nODiVQMzeFSxF
         2g+uKsEXPe/FGC+TkYuQZqYjXo8+XS4m3uil78Xx0c2w+5Owyrj80rWMd+tIS+vJT5
         Z2tVY4oUL90HzwpWgBtGJAhTpwgvjYjZFoDcWlH+dhK6GeFgQLfyyGS+Uf6kEVXOdP
         GC9ZSXEtNrZqw==
Date:   Sat, 25 Mar 2023 11:52:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v14 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <baea06f3-1a89-4b37-8ac9-120ea7a7e5ff@spud>
References: <20230306094858.1614819-1-conor.dooley@microchip.com>
 <20230306094858.1614819-2-conor.dooley@microchip.com>
 <20230322105536.kgt3ffowefqlg6eu@pengutronix.de>
 <48c7dbdc-04a2-42de-964f-fd86cf070797@spud>
 <20230323091409.rdi4bqrcsfvxnht5@pengutronix.de>
 <142f0d8d-5814-4747-bfac-2479fcee92d3@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XrvFPcAPd6qmvVig"
Content-Disposition: inline
In-Reply-To: <142f0d8d-5814-4747-bfac-2479fcee92d3@spud>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XrvFPcAPd6qmvVig
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 06:43:03PM +0000, Conor Dooley wrote:
> On Thu, Mar 23, 2023 at 10:14:09AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Mar 22, 2023 at 10:49:40PM +0000, Conor Dooley wrote:
> > > On Wed, Mar 22, 2023 at 11:55:36AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Mon, Mar 06, 2023 at 09:48:58AM +0000, Conor Dooley wrote:
> > > > > Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> > > > > +static void mchp_core_pwm_calc_period(const struct pwm_state *st=
ate, unsigned long clk_rate,
> > > > > +				      u16 *prescale, u16 *period_steps)
> > > > > +{
> > > > > +	u64 tmp;
> > > > > +
> > > > > +	/*
> > > > > +	 * Calculate the period cycles and prescale values.
> > > > > +	 * The registers are each 8 bits wide & multiplied to compute t=
he period
> > > > > +	 * using the formula:
> > > > > +	 *           (prescale + 1) * (period_steps + 1)
> > > > > +	 * period =3D -------------------------------------
> > > > > +	 *                      clk_rate
> > > > > +	 * so the maximum period that can be generated is 0x10000 times=
 the
> > > > > +	 * period of the input clock.
> > > > > +	 * However, due to the design of the "hardware", it is not poss=
ible to
> > > > > +	 * attain a 100% duty cycle if the full range of period_steps i=
s used.
> > > > > +	 * Therefore period_steps is restricted to 0xFE and the maximum=
 multiple
> > > > > +	 * of the clock period attainable is 0xFF00.
> > > > > +	 */
> > > > > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_S=
EC);
> > > > > +
> > > > > +	/*
> > > > > +	 * The hardware adds one to the register value, so decrement by=
 one to
> > > > > +	 * account for the offset
> > > > > +	 */
> > > > > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > > > > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > > > > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> > > > > +
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * The optimal value for prescale can be calculated using the m=
aximum
> > > > > +	 * permitted value of period_steps, 0xff.
> > > >=20
> > > > I had to think about that one for a while. The maximal value for
> > > > (period_steps + 1) is 0xff with the reasoning above?! That's also w=
hat
> > > > the code uses.
> > >=20
> > > I've become really disenfranchised with these register/variable names.
> > > I feel like just changing them to disconnect the variables used for
> > > calculation from the register names a little, so that the "is there a=
 +1
> > > needed here or not" stuff becomes a little clearer.
> >=20
> > Full ack, I considered asking for that, but after some time I was in the
> > "I reviewed the patch today"-mode (which is quite similar to the mode
> > you described :-) and forgot. (Even in that mode the PREG_TO_VAL macro
> > annoyed me a bit.)
> >=20
> > > It always makes sense to be when I am in an "I respun the patch today"
> > > mode, but by the time we're in the review stage I get muddled.
> > > God forbid I have to look at this in 10 years time.
> > >=20
> > > That said, there is a bit of a mistake here. The comment two above sa=
ys
> > > "Therefore period_steps is restricted to 0xFE" when I'm capping things
> > > off. Some inaccuracies have probably snuck in during the various
> > > respins, and I think the comment above is "correct" but misleading, as
> > > it muddies the waters about variable versus register names.
> >=20
> > I think it's sensible to only talk about either the register values or
> > the factors. I tend to think that talking about the register values is
> > easier at the end and recommend not to hide the +1 (or -1) in a macro.
>=20
> Yeah, I think the macro had value about 14 versions ago, but the number
> of users has dropped over the revisions.
> I think what I am going to to do for the next version is drop that
> macro, and only ever hold the registers values in variables.
> That had the advantage of making the maths in get_state() better match
> the comments that are now quite prevalent in the driver, as the +1s done
> there are more obvious.
> I'm loathe to link a git tree but, without changes to the period
> calculation logic, this is what it looks like w/ a consistent approach
> to what period_steps and prescale mean:
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/tree/driv=
ers/pwm/pwm-microchip-core.c?h=3Dpwm-dev-v15
> [I blindly pushed that before leaving work & without even building it, so
> there's probably some silly mistake in it, but that's besides the point
> of displaying variable/comment changes]
>=20
> From the chopped out bits of the previous email:
> > Consider
> >=20
> > 	clk_rate =3D 1000000
> > 	period =3D 64009000
> >=20
> > then your code gives:
> >=20
> >               period * clk_rate
> > 	tmp =3D ----------------- =3D 64009
> >                 NSEC_PER_SEC
> >=20
> > and so *prescale =3D 251 and *period_steps =3D 253.=20
> >=20
> > Wasn't the intention to pick *prescale =3D 250 and then
> > *period_steps =3D 255?
> >=20
> > Depending on your semantics of "optimal", either (252, 252) or (250,
> > 255) is better than (251, 253). I think that means you shouldn't ignore
> > the -1?
>=20
> So, putting this one aside because it merits more thinking about.
>=20
> I went through and checked some arbitrary values of tmp, rather than
> dealing with "real" ones computed from frequencies I know are easily
> available for me to use in the FPGA bitstream I use to test this stuff.
>=20
> I think my "integer maths" truncation approach is not actually valid.
> Consider tmp =3D 255... *prescale gets computed as 255/(254 + 1) =3D 1, p=
er my
> algorithm. Then, *period_steps is 255/(1 + 1) - 1 =3D 127.
> The period is (1 + 1)(127 + 1), which is not 255.
>=20
> Or take tmp =3D 510. prescale is 510/(254 + 1) =3D 2. period_steps is then
> 510/(2 + 1) - 1 =3D 169. period is (2 + 1)(169 + 1), which is 510. The
> calculated period is right, but that is not the "optimal" value!
>=20
> I think you're right in that I do actually need to consider the -1, and
> do a ceiling operation, when calculating prescale, IOW:
> 	*prescale =3D ceil(div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX + 1)) - 1;
> 	*period_steps =3D div_u64(tmp, *prescale + 1) - 1;
> 	[I know I can't actually call ceil()]
>=20
> That'd do the same thing as the truncation where
> div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX + 1) is not a round number,
> but it improves the round number case, eg tmp =3D 510:
> prescale =3D 510/(254 + 1) - 1 =3D 1, period_steps =3D 510/(1 + 1) - 1 =
=3D 254
> period =3D (1 + 1)(254 + 1) =3D 510
>=20
> It does mean a zero period would need to be special cased, but I don't
> mind that.
>=20
> > One thing I think is strange is that with clk_rate =3D 1000001 and your
> > algorithm we get:
> >=20
> > requested period =3D 1274998 ns -> real period =3D 1269998.73000127  (p=
rescale =3D 4, period_steps =3D 253)
> > requested period =3D 1274999 ns -> real period =3D 1271998.728001272 (p=
rescale =3D 5, period_steps =3D 211)
>=20
> This second one here, where tmp =3D 1275, is a good example of the above.
> With the ceil() change, this would be prescale =3D 4, period_steps =3D 254
> which I think makes more sense.
> >=20
> > while 1271998.728001272 would be a better match for a request with
> > period =3D 1274998 than 1269998.73000127.
> >=20
> > I spend too much time to think about that now. I'm unsure if this is
> > because the -1 is missing, or if there is a bug in the idea to pick a
> > small prescale to allow a big period_steps value (in combination with
> > the request to pick the biggest possible period).
>=20
> With the inconsistency fixed, I think getting the slightly less accurate
> period is a byproduct of prioritising the finegrainedness of the duty
> cycle.
>=20
> > Hmm, maybe you understand that better than me? I'll have to think about
> > it.
>=20
> [end of snip from the last mail]
>=20
> >=20
> > Having said that here are my results of thinking a bit about how to
> > choose register values:
> >=20
> > Let r(p) denote the period that is actually configured if p is
> > requested.
> >=20
> > The nice properties we want (i.e. those a consumer might expect?) are:
> >=20
> >  a) =E2=88=80p: r(p) =E2=89=A4 p
> >     i.e. never configure a bigger period than requested
> >     (This is a bit arbitrary, but nice to get a consistent behaviour for
> >     all drivers and easier to handle than requesting the nearest
> >     possible period.)
> >=20
> >  b) =E2=88=80p, q: p =E2=89=A4 q =E2=9F=B9 r(p) =E2=89=A4 r(q)
> >     i.e. monotonicity
> >=20
> >  c) =E2=88=80p: r(roundup(r(p))) =3D r(p)
> >     i.e. idempotency
> >=20
> >  d) =E2=88=80p, q: r(p) =E2=89=A4 q =E2=9F=B9 r(p) =E2=89=A4 r(q)
> >     i.e. pick the biggest possible period
> >=20
> > (Sidenote: d) and a) imply b) and c))
> >=20
> > If you always set period_steps to 0xfe
> > (in Python syntax:
> >=20
> > 	tmp =3D p * clkrate // NSPS
> > 	period_steps =3D 0xfe
> > 	prescale =3D tmp // (period_steps + 1) - 1
> >=20
> > ) you get this consistent behaviour.
> >=20
> > This has the upside of being easy to implement and cheap to run.
> > Downside is that it's coarse and fails to implement periods that would
> > require e.g prescale =3D 0 and period_steps < 0xfe. As period_steps is
> > big, the domain to chose the duty cycle from is good.
>=20
> I want to maintain support for prescale =3D 0, so I'm not really
> interested in a computation that forsakes that.
>=20
> > If you pick period_steps and prescale such that
> > 	(period_steps + 1) * (prescale + 1)
> > is the maximal value that makes r(p) =E2=89=A4 p you have an increased =
runtime
> > because you have to test multiple values for period_steps. I don't think
> > there is an algorithm without a loop to determine an optimal pair?!
> > Usually this gives a better match that the easy algorithm above for the
> > period, but the domain for duty_cycle is (usually) smaller.
> > I think we have a) and d) here, so that's good.
> >=20
> > I think for most consumers a big domain for duty_cycle is more important
> > that a good match for the requested period. So I tend to recommend the
> > easy algorithm, but I'm not religious about that and open for other
> > opinion and reasoning.
>=20
> I'll be honest and say that I am getting a bit fatigued with the way
> that issues w/ the calculations keep cropping up. I'll put a bit of time
> into trying to figure out how to fix the tmp =3D 6400900 case that you
> mentioned above, but if it comes out in the wash that that is a facet of
> the way this stuff is computed, then I might be inclined to forge ahead
> without resolving it... I'd certainly want to explain in a comment
> somewhere (limitations section?) the point at which it starts getting
> less accurate though. I'll write a script to iterate through the values
> of tmp & see if the reason is obvious.

I threw together a python script to go through the various values of tmp
& check which ones ended up with these "non-optimal" prescale values.
For tmp < 1000, I saw:
tmp: 511 | 255 - period_steps: 86
tmp: 766 | 255 - period_steps: 65
tmp: 767 | 255 - period_steps: 65
That then grows as tmp moves upwards, so:
tmp: 1021  | 255 - period_steps: 52
tmp: 1022  | 255 - period_steps: 52
tmp: 1023  | 255 - period_steps: 52

That looks oddly like (tmp % (254 + 1)) < prescale and seems to be an
"artifact" of using 254 to calculate the prescaler rather than 255.
I think that that can be worked around while keeping the current simple
approach to calculating prescale/period_steps. Looks like 32385 out of
the 65280 valid values for tmp can benefit! That's in comparison to the
127 that would produce the invalid period_steps value of 255.

I'll go submit something fixing this next week then I suppose.

> I would like to keep (something resembling) the current simple
> implementation of the period calculation, as simplicity is a significant
> advantage! I do also like the strategy of trying to maximise the number
> of available duty cycle steps, I think it makes perfect sense to make
> that the goal.
>=20
> Thanks again for spending time on this Uwe,
> Conor.
>=20



--XrvFPcAPd6qmvVig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZB7giwAKCRB4tDGHoIJi
0nECAQC/cjx9DvreTXIZmXb1qCw0gURsMFsESUUgIa7VL6A3bQEA0WhAtJcoLKhM
1ZyGA28Js4NbaimCJblIvDKwSDA6vAk=
=Gwm3
-----END PGP SIGNATURE-----

--XrvFPcAPd6qmvVig--
