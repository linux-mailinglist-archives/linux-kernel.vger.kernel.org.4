Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223AE6E657D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDRNJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDRNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:09:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54ECEE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:08:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pol4Z-00064i-5n; Tue, 18 Apr 2023 15:08:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pol4Y-00C6xv-AH; Tue, 18 Apr 2023 15:08:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pol4X-00EDgz-Fr; Tue, 18 Apr 2023 15:08:37 +0200
Date:   Tue, 18 Apr 2023 15:08:37 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v16 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230418130837.zfueixeuxrallhtc@pengutronix.de>
References: <20230411-wizard-cautious-3c048db6b4d2@wendy>
 <20230411-bronzing-crust-d302408a1259@wendy>
 <20230411105547.ypkktubgfx4jfen3@pengutronix.de>
 <20230411-ligament-wagon-6c8cacb966e8@wendy>
 <20230411162554.4tl2z2tcbfg5hb7e@pengutronix.de>
 <20230418-armhole-cartwheel-cee37778a840@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4p2zd3wi3otb6xo7"
Content-Disposition: inline
In-Reply-To: <20230418-armhole-cartwheel-cee37778a840@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4p2zd3wi3otb6xo7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 12:27:33PM +0100, Conor Dooley wrote:
> Hey Uwe,
>=20
> On Tue, Apr 11, 2023 at 06:25:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Apr 11, 2023 at 02:56:15PM +0100, Conor Dooley wrote:
> > > On Tue, Apr 11, 2023 at 12:55:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, Apr 11, 2023 at 09:56:34AM +0100, Conor Dooley wrote:
> > > > > Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> > > > > +static int mchp_core_pwm_calc_period(const struct pwm_state *sta=
te, unsigned long clk_rate,
> > > > > +				     u16 *prescale, u16 *period_steps)
> > > > > +{
> > > > > +	u64 tmp;
> > > > > +	u32 remainder;
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
> > > > > +	 * Therefore period_steps is restricted to 0xfe and the maximum=
 multiple
> > > > > +	 * of the clock period attainable is (0xff + 1) * (0xfe + 1) =
=3D 0xff00
> > > > > +	 *
> > > > > +	 * The prescale and period_steps registers operate similarly to
> > > > > +	 * CLK_DIVIDER_ONE_BASED, where the value used by the hardware =
is that
> > > > > +	 * in the register plus one.
> > > > > +	 * It's therefore not possible to set a period lower than 1/clk=
_rate, so
> > > > > +	 * if tmp is 0, abort. Without aborting, we will set a period t=
hat is
> > > > > +	 * greater than that requested and, more importantly, will trig=
ger the
> > > > > +	 * neg-/pos-edge issue described in the limitations.
> > > > > +	 */
> > > > > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_S=
EC);
> > > > > +	if (!tmp)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > > > > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX;
> > > > > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX;
> > > > > +
> > > > > +		return 0;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * There are multiple strategies that could be used to choose t=
he
> > > > > +	 * prescale & period_steps values.
> > > > > +	 * Here the idea is to pick values so that the selection of dut=
y cycles
> > > > > +	 * is as finegrain as possible.
> > > > > +	 * This "optimal" value for prescale can be calculated using th=
e maximum
> > > > > +	 * permitted value of period_steps, 0xfe.
> > > > > +	 *
> > > > > +	 *                period * clk_rate
> > > > > +	 * prescale =3D ------------------------- - 1
> > > > > +	 *            NSEC_PER_SEC * (0xfe + 1)
> > > > > +	 *
> > > > > +	 * However, we are purely interested in the integer upper bound=
 of this
> > > > > +	 * calculation, so this division should be rounded up before su=
btracting
> > > > > +	 * 1
> > > > > +	 *
> > > > > +	 *  period * clk_rate
> > > > > +	 * ------------------- was precomputed as `tmp`
> > > > > +	 *    NSEC_PER_SEC
> > > > > +	 */
> > > > > +	*prescale =3D DIV64_U64_ROUND_UP(tmp, MCHPCOREPWM_PERIOD_STEPS_=
MAX + 1) - 1;
> > > >=20
> > > > If state->period * clk_rate is 765000000001 you get tmp =3D 765 and=
 then
> > > > *prescale =3D 2. However roundup(765000000001 / (1000000000 * 255))=
 - 1 is
> > > > 3. The problem here is that you're rounding down in the calculation=
 of
> > > > tmp. Of course this is constructed because 765000000001 is prime, b=
ut
> > > > I'm sure you get the point :-)
> > >=20
> > > Hold that thought for a moment..
> >=20
> > OK, so the correction below is to make up for the wrong rounding here.
> > I'd like to have that in a comment. Otherwise it wasn't clear to me.
>=20
> Sure, no problem.
>=20
> > > > Also we know that tmp is < 0xff00, so we don't need a 64 bit divisi=
on
> > > > here.
> > >=20
> > > Neither here nor below, true.
> > >=20
> > > > > +	/*
> > > > > +	 * Because 0xff is not a permitted value some error will seep i=
nto the
> > > > > +	 * calculation of prescale as prescale grows. Specifically, thi=
s error
> > > > > +	 * occurs where the remainder of the prescale calculation is le=
ss than
> > > > > +	 * prescale.
> > > > > +	 * For small values of prescale, only a handful of values will =
need
> > > > > +	 * correction, but overall this applies to almost half of the v=
alid
> > > > > +	 * values for tmp.
> > > > > +	 *
> > > > > +	 * To keep the algorithm's decision making consistent, this cas=
e is
> > > > > +	 * checked for and the simple solution is to, in these cases,
> > > > > +	 * decrement prescale and check that the resulting value of per=
iod_steps
> > > > > +	 * is valid.
> > > > > +	 *
> > > > > +	 * period_steps can be computed from prescale:
> > > > > +	 *                      period * clk_rate
> > > > > +	 * period_steps =3D ----------------------------- - 1
> > > > > +	 *                NSEC_PER_SEC * (prescale + 1)
> > > > > +	 *
> > > > > +	 */
> > > > > +	div_u64_rem(tmp, (MCHPCOREPWM_PERIOD_STEPS_MAX + 1), &remainder=
);
> > > > > +	if (remainder < *prescale) {
> > > > > +		u16 smaller_prescale =3D *prescale - 1;
> > > > > +
> > > > > +		*period_steps =3D div_u64(tmp, smaller_prescale + 1) - 1;
> > > > > +		if (*period_steps < 255) {
> > > > > +			*prescale =3D smaller_prescale;
> > > > > +
> > > > > +			return 0;
> > > > > +		}
> > > > > +	}
> > >=20
> > > ...so in your prime case above, we would initially compute a prescale
> > > value that is too large, and then wind up hitting the test of the
> > > remainder here, thereby realising that the smaller prescale value is a
> > > better fit?
> > > Perhaps that's not an acceptable way to handle the issue though.
> >=20
> > IMHO it is, but the comment explaining needs some improvement. It should
> > also make clear why rounding cannot lead to prescale - 2 being a
> > good/better candidate. (I haven't thought it through, maybe needs some
> > improvement?) I wonder if the computation can find all improvements
> > given that it only used tmp, but not ->period and clk_rate?!
>=20
> For tmp > 0xff00 it may be off by more than 255, but that isn't possible
> at this stage as we've already eliminated the possibility above.
>=20
> > > > I don't understand that part. It triggers for tmp =3D 511. So you p=
refer
> > > >=20
> > > > 	prescale =3D 1
> > > > 	period_steps =3D 254
> > > >=20
> > > > yielding period =3D 510 / clkrate over
> > > >=20
> > > > 	prescale =3D 2
> > > > 	period_steps =3D 170
> > > >=20
> > > > yielding 513 / clkrate. I wonder why.
> >=20
> > I missed the -=3D 1 in my example. So it's:
> >=20
> > 	It triggers for tmp =3D 511. So you prefer
> >=20
> > 		prescale =3D 1
> > 		period_steps =3D 254
> >=20
> > 	yielding period =3D 510 / clkrate over
> >=20
> > 		prescale =3D 2
> > 		period_steps =3D 169
> >=20
> > 	yielding 510 / clkrate.
> >=20
> > Here it's obvious that the former is the better one. But I wonder why
> > the former isn't found instantly. Wouldn't
> >=20
> > 	*prescale =3D tmp / (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) - 1
> >=20
> > give a better approximation in general? (Of course with an additional
> > check that *prescale >=3D 0 then.)=20
> >=20
> > ... thinking a bit ... yes, I think that's true:
> >=20
> > If you pick *prescale =3D tmp / (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) - 1,
> > then for each period_steps value =E2=89=A4 254 we have:
> >=20
> > 	  (*prescale + 1) * (period_steps + 1)
> > 	=E2=89=A4 (*prescale + 1) * 255
> > 	=E2=89=A4 (tmp // (MCHPCOREPWM_PERIOD_STEPS_MAX + 1)) * 255
> > 	=E2=89=A4 (tmp // 255) * 255
> > 	=E2=89=A4 (tmp / 255) * 255
> > 	=3D tmp
>=20
> tmp =3D 256
>=20
> *prescale =3D 256 // (254 + 1) - 1
>           =E2=89=88 0
>=20
> *prescale =3D 256 // (prescale + 1) - 1
>           =3D 256 / (0 + 1) - 1
> 	  =3D 255

I don't understand what you wanna say here. If tmp =3D 256 my suggestion
is to pick prescale =3D 0 and period_steps =3D 254. Then

	 (prescale + 1) * (period_steps + 1) =E2=89=A4 tmp

and period_steps is big enough to ensure a a finegrained choice for the
duty_cycle.

> That's then gonna give us one of the broken configurations from the
> limitations.
>=20
> tmp =3D 257
>=20
> *prescale =3D 257 // (254 + 1) - 1
>           =E2=89=88 0
>=20
> *prescale =3D 257 // (prescale + 1) - 1
>           =3D 257 / (0 + 1) - 1
> 	  =3D 256
> 	  =3D 0 (registers are 8-bit)

I think you mean s/prescale/period_steps/ in the second part, but that's
not what I meant. I meant to suggest:

	*prescale =3D tmp / (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) - 1
	period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX =3D 254

> I'm quite obviously missing something that you may think is obvious
> here, but is not immediately clear to me.

That would be an explanation, yes. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4p2zd3wi3otb6xo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ+llQACgkQj4D7WH0S
/k7saAf+Pi0/CwMKKblfq3A+hKJD7MXAoWMkEywj9+FUgBsAi3jR2ss4YF1PSb6V
x6bU/APWpb+tuwF9kVtNfTz4HIqlMjnucHJO0jUUrOgFPI4OFxyuDqNDn9sB8Lin
+qFAaLulJLS++ZuxtFWipBTcR48+PInMc09BERWaemXS5ySvNpgD5TqG0YiWvC6z
EwmAA7RyvBD1+KiHRWGUIflwXg110QbQfMpATH3BWCF7nnsB5WcFLkVYkaVwuY3v
pu2PS0c01Vgm9KHNMEYCNk5EmPZQTbt3l8de/GPgxNaVxE6FtJnYw+V3iafCV2W1
JvXXRo/CtPKrCA3NCPpGG86yc3O0xA==
=nt+3
-----END PGP SIGNATURE-----

--4p2zd3wi3otb6xo7--
