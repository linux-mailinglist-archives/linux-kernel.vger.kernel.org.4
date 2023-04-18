Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF26E5FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjDRL16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDRL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:27:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9F444A5;
        Tue, 18 Apr 2023 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681817273; x=1713353273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4loqyVZ/FY1kZPUDFHCZ1Vtr/RHKPOwn8fc0/+s0MwQ=;
  b=p0n47JYCx/+j0RZ4kRZDcuQWPbBA2mFwdYZdXJ7kZRfzPpuWNQIWklil
   Vz77fVSoLS2RaDTefE3HEccB8q2XOyeWaXDZB6ymKKDyQeenRqpFzIiaD
   r456o9pIcZkoFOe2qlUVgqoj2d6cEREvLnOrwHWFmTm9oJcETfHizxefm
   sTGVP5FxAbqJAcsNILRiQpt2679pIfijBCWu2NyMTlRSXpJqcbVhyr1gZ
   Lt7q4oyjKbDxA98qTUbFakIxinWoMFCP8MqXSNb70qFPSmFauFxOYzMLe
   FN5xEyIylOs2X22xgcraCW6H9JeiiPnIonic1qQ911cr5jIZCwhNlVH3O
   g==;
X-IronPort-AV: E=Sophos;i="5.99,207,1677567600"; 
   d="asc'?scan'208";a="207038849"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Apr 2023 04:27:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 18 Apr 2023 04:27:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 18 Apr 2023 04:27:50 -0700
Date:   Tue, 18 Apr 2023 12:27:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v16 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230418-armhole-cartwheel-cee37778a840@wendy>
References: <20230411-wizard-cautious-3c048db6b4d2@wendy>
 <20230411-bronzing-crust-d302408a1259@wendy>
 <20230411105547.ypkktubgfx4jfen3@pengutronix.de>
 <20230411-ligament-wagon-6c8cacb966e8@wendy>
 <20230411162554.4tl2z2tcbfg5hb7e@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZZsscCipmNrXS3at"
Content-Disposition: inline
In-Reply-To: <20230411162554.4tl2z2tcbfg5hb7e@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ZZsscCipmNrXS3at
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Uwe,

On Tue, Apr 11, 2023 at 06:25:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Apr 11, 2023 at 02:56:15PM +0100, Conor Dooley wrote:
> > On Tue, Apr 11, 2023 at 12:55:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Apr 11, 2023 at 09:56:34AM +0100, Conor Dooley wrote:
> > > > Add a driver that supports the Microchip FPGA "soft" PWM IP core.

> > > > +static int mchp_core_pwm_calc_period(const struct pwm_state *state=
, unsigned long clk_rate,
> > > > +				     u16 *prescale, u16 *period_steps)
> > > > +{
> > > > +	u64 tmp;
> > > > +	u32 remainder;
> > > > +
> > > > +	/*
> > > > +	 * Calculate the period cycles and prescale values.
> > > > +	 * The registers are each 8 bits wide & multiplied to compute the=
 period
> > > > +	 * using the formula:
> > > > +	 *           (prescale + 1) * (period_steps + 1)
> > > > +	 * period =3D -------------------------------------
> > > > +	 *                      clk_rate
> > > > +	 * so the maximum period that can be generated is 0x10000 times t=
he
> > > > +	 * period of the input clock.
> > > > +	 * However, due to the design of the "hardware", it is not possib=
le to
> > > > +	 * attain a 100% duty cycle if the full range of period_steps is =
used.
> > > > +	 * Therefore period_steps is restricted to 0xfe and the maximum m=
ultiple
> > > > +	 * of the clock period attainable is (0xff + 1) * (0xfe + 1) =3D =
0xff00
> > > > +	 *
> > > > +	 * The prescale and period_steps registers operate similarly to
> > > > +	 * CLK_DIVIDER_ONE_BASED, where the value used by the hardware is=
 that
> > > > +	 * in the register plus one.
> > > > +	 * It's therefore not possible to set a period lower than 1/clk_r=
ate, so
> > > > +	 * if tmp is 0, abort. Without aborting, we will set a period tha=
t is
> > > > +	 * greater than that requested and, more importantly, will trigge=
r the
> > > > +	 * neg-/pos-edge issue described in the limitations.
> > > > +	 */
> > > > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC=
);
> > > > +	if (!tmp)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > > > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX;
> > > > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX;
> > > > +
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * There are multiple strategies that could be used to choose the
> > > > +	 * prescale & period_steps values.
> > > > +	 * Here the idea is to pick values so that the selection of duty =
cycles
> > > > +	 * is as finegrain as possible.
> > > > +	 * This "optimal" value for prescale can be calculated using the =
maximum
> > > > +	 * permitted value of period_steps, 0xfe.
> > > > +	 *
> > > > +	 *                period * clk_rate
> > > > +	 * prescale =3D ------------------------- - 1
> > > > +	 *            NSEC_PER_SEC * (0xfe + 1)
> > > > +	 *
> > > > +	 * However, we are purely interested in the integer upper bound o=
f this
> > > > +	 * calculation, so this division should be rounded up before subt=
racting
> > > > +	 * 1
> > > > +	 *
> > > > +	 *  period * clk_rate
> > > > +	 * ------------------- was precomputed as `tmp`
> > > > +	 *    NSEC_PER_SEC
> > > > +	 */
> > > > +	*prescale =3D DIV64_U64_ROUND_UP(tmp, MCHPCOREPWM_PERIOD_STEPS_MA=
X + 1) - 1;
> > >=20
> > > If state->period * clk_rate is 765000000001 you get tmp =3D 765 and t=
hen
> > > *prescale =3D 2. However roundup(765000000001 / (1000000000 * 255)) -=
 1 is
> > > 3. The problem here is that you're rounding down in the calculation of
> > > tmp. Of course this is constructed because 765000000001 is prime, but
> > > I'm sure you get the point :-)
> >=20
> > Hold that thought for a moment..
>=20
> OK, so the correction below is to make up for the wrong rounding here.
> I'd like to have that in a comment. Otherwise it wasn't clear to me.

Sure, no problem.

> > > Also we know that tmp is < 0xff00, so we don't need a 64 bit division
> > > here.
> >=20
> > Neither here nor below, true.
> >=20
> > > > +	/*
> > > > +	 * Because 0xff is not a permitted value some error will seep int=
o the
> > > > +	 * calculation of prescale as prescale grows. Specifically, this =
error
> > > > +	 * occurs where the remainder of the prescale calculation is less=
 than
> > > > +	 * prescale.
> > > > +	 * For small values of prescale, only a handful of values will ne=
ed
> > > > +	 * correction, but overall this applies to almost half of the val=
id
> > > > +	 * values for tmp.
> > > > +	 *
> > > > +	 * To keep the algorithm's decision making consistent, this case =
is
> > > > +	 * checked for and the simple solution is to, in these cases,
> > > > +	 * decrement prescale and check that the resulting value of perio=
d_steps
> > > > +	 * is valid.
> > > > +	 *
> > > > +	 * period_steps can be computed from prescale:
> > > > +	 *                      period * clk_rate
> > > > +	 * period_steps =3D ----------------------------- - 1
> > > > +	 *                NSEC_PER_SEC * (prescale + 1)
> > > > +	 *
> > > > +	 */
> > > > +	div_u64_rem(tmp, (MCHPCOREPWM_PERIOD_STEPS_MAX + 1), &remainder);
> > > > +	if (remainder < *prescale) {
> > > > +		u16 smaller_prescale =3D *prescale - 1;
> > > > +
> > > > +		*period_steps =3D div_u64(tmp, smaller_prescale + 1) - 1;
> > > > +		if (*period_steps < 255) {
> > > > +			*prescale =3D smaller_prescale;
> > > > +
> > > > +			return 0;
> > > > +		}
> > > > +	}
> >=20
> > ...so in your prime case above, we would initially compute a prescale
> > value that is too large, and then wind up hitting the test of the
> > remainder here, thereby realising that the smaller prescale value is a
> > better fit?
> > Perhaps that's not an acceptable way to handle the issue though.
>=20
> IMHO it is, but the comment explaining needs some improvement. It should
> also make clear why rounding cannot lead to prescale - 2 being a
> good/better candidate. (I haven't thought it through, maybe needs some
> improvement?) I wonder if the computation can find all improvements
> given that it only used tmp, but not ->period and clk_rate?!

For tmp > 0xff00 it may be off by more than 255, but that isn't possible
at this stage as we've already eliminated the possibility above.

> > > I don't understand that part. It triggers for tmp =3D 511. So you pre=
fer
> > >=20
> > > 	prescale =3D 1
> > > 	period_steps =3D 254
> > >=20
> > > yielding period =3D 510 / clkrate over
> > >=20
> > > 	prescale =3D 2
> > > 	period_steps =3D 170
> > >=20
> > > yielding 513 / clkrate. I wonder why.
>=20
> I missed the -=3D 1 in my example. So it's:
>=20
> 	It triggers for tmp =3D 511. So you prefer
>=20
> 		prescale =3D 1
> 		period_steps =3D 254
>=20
> 	yielding period =3D 510 / clkrate over
>=20
> 		prescale =3D 2
> 		period_steps =3D 169
>=20
> 	yielding 510 / clkrate.
>=20
> Here it's obvious that the former is the better one. But I wonder why
> the former isn't found instantly. Wouldn't
>=20
> 	*prescale =3D tmp / (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) - 1
>=20
> give a better approximation in general? (Of course with an additional
> check that *prescale >=3D 0 then.)=20
>=20
> ... thinking a bit ... yes, I think that's true:
>=20
> If you pick *prescale =3D tmp / (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) - 1,
> then for each period_steps value =E2=89=A4 254 we have:
>=20
> 	  (*prescale + 1) * (period_steps + 1)
> 	=E2=89=A4 (*prescale + 1) * 255
> 	=E2=89=A4 (tmp // (MCHPCOREPWM_PERIOD_STEPS_MAX + 1)) * 255
> 	=E2=89=A4 (tmp // 255) * 255
> 	=E2=89=A4 (tmp / 255) * 255
> 	=3D tmp

tmp =3D 256

*prescale =3D 256 // (254 + 1) - 1
          =E2=89=88 0

*prescale =3D 256 // (prescale + 1) - 1
          =3D 256 / (0 + 1) - 1
	  =3D 255

That's then gonna give us one of the broken configurations from the
limitations.

tmp =3D 257

*prescale =3D 257 // (254 + 1) - 1
          =E2=89=88 0

*prescale =3D 257 // (prescale + 1) - 1
          =3D 257 / (0 + 1) - 1
	  =3D 256
	  =3D 0 (registers are 8-bit)

And so on...

I'm quite obviously missing something that you may think is obvious
here, but is not immediately clear to me.

> and you can use the maximal period_steps =3D 0xfe.
> (Only for tmp < 255 that isn't possible, up to you if you refuse these
> or pick a smaller value for period_steps.)
>=20
> > Because 513 > 511 & 254 > 170!
> > Is the aim not to produce a period that is less than or equal to that
> > requested? The aim of this driver is to pick a prescale/period_steps
> > combo that satisfies that constraint, while also trying to maximise the
> > "finegrainness" of the duty cycle.
> > The latter should be stated in a comment above.
>=20
> ack. I also wonder if such a change breaks the other assumptions a
> consumer might have. I'll spend some more cycles about that in the next
> round :-)
>=20
> > > Also tmp =3D 511 is the only value
> > > where this triggers. There is a mistake somewhere (maybe on my side).
> >=20
> > It should trigger for any value 255 * n < x < 256 * n, no?
> > Say for tmp of 767:
> > *prescale =3D DIV64_U64_ROUND_UP(767, 254 + 1) - 1 =3D DIV64_U64_ROUND_=
UP(3.00784...) - 1 =3D 3
> > remainder =3D 0.00784.. * (254 + 1) =3D 2
> >=20
> > Am I going nuts? Wouldn't be the first time that I've made a hames of
> > things here, there are 16 versions for a reason after all.
>=20
> Ah, I had a bogus break statement in my python test code. So it's me
> who got it wrong.

No worries :)

Pending an explanation of your calculation above, I've gone and done the
rest of these things. I shan't resend until -rc1 or I get an explanation
of your calculation - whichever happens first!

Cheers,
Conor.

--ZZsscCipmNrXS3at
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD5+pQAKCRB4tDGHoIJi
0iZZAP91hQDU7xbaEw09580fqNgKcNEekkThE/NZkY8D88Kt8wEAhT9lF42K9cAJ
wqk9gkHTPf1Wz1kws3r/fTr95S/50QI=
=Rkyh
-----END PGP SIGNATURE-----

--ZZsscCipmNrXS3at--
