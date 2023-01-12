Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C66678F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjALPT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjALPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:18:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7D33DBF6;
        Thu, 12 Jan 2023 07:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673536234; x=1705072234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcC3ycvPUa6E240Qla/RTH3/APdFORNAqQ+R0bSawE4=;
  b=hNxhNOohSGd18ddwf5aebrDIqzliZFVZz19xFFXA7MmvUE+5Dv5+jiWG
   68Aw3sIoI4TQ6y9rMewGT/fD9blcqbkxn1JA8sLUr2omkaeQ1Lqbw+X6e
   IEb9K7XfB+PrjUrbv181c0QEy0i8/DycLob5BwFDWi8y1Vr4DMJFM5TAd
   CWZKKmYctdytqNrcZnHVHSOkDEoqQnnG7UxDHTIjwXt41sOtM/zuEiHCg
   PE8kQQq/c1D5wH8yWLRM2PyeHfUuxTgza3PkrfoA1XOibA/nh6fnPNccA
   UOU8i954KohY4SfyhCTOeCq0zn0POo9riUqWNF2+FRA6AcAjCU0nl2qBL
   w==;
X-IronPort-AV: E=Sophos;i="5.97,211,1669100400"; 
   d="asc'?scan'208";a="196375836"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 08:10:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 08:10:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 12 Jan 2023 08:10:32 -0700
Date:   Thu, 12 Jan 2023 15:10:09 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Conor Dooley <conor@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y8Ai0aF5A+O43kjZ@wendy>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
 <20230112120141.fpjwhtjuaxrwqt5m@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fVFk6pos5f7gI6TJ"
Content-Disposition: inline
In-Reply-To: <20230112120141.fpjwhtjuaxrwqt5m@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fVFk6pos5f7gI6TJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 01:01:41PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Jan 10, 2023 at 11:48:05PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Conor,
> >=20
> > On Wed, Dec 21, 2022 at 11:29:12AM +0000, Conor Dooley wrote:
> > > +static void mchp_core_pwm_calc_period(const struct pwm_state *state,=
 unsigned long clk_rate,
> > > +				      u16 *prescale, u8 *period_steps)
> > > +{
> > > +	u64 tmp;
> > > +
> > > +	/*
> > > +	 * Calculate the period cycles and prescale values.
> > > +	 * The registers are each 8 bits wide & multiplied to compute the p=
eriod
> > > +	 * using the formula:
> > > +	 * (clock_period) * (prescale + 1) * (period_steps + 1)
> > > +	 * so the maximum period that can be generated is 0x10000 times the
> > > +	 * period of the input clock.
> > > +	 * However, due to the design of the "hardware", it is not possible=
 to
> > > +	 * attain a 100% duty cycle if the full range of period_steps is us=
ed.
> > > +	 * Therefore period_steps is restricted to 0xFE and the maximum mul=
tiple
> > > +	 * of the clock period attainable is 0xFF00.
> > > +	 */
> > > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> > > +
> > > +	/*
> > > +	 * The hardware adds one to the register value, so decrement by one=
 to
> > > +	 * account for the offset
> > > +	 */
> > > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX - 1;
> > > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
> > > +
> > > +		return;
> > > +	}
> > > +
> > > +	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
> > > +	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
> > > +	*period_steps =3D div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
> >=20
> > This looks wrong, but I didn't think long about that. Did we discuss
> > this already and/or are you sure this is correct?
> >=20
> > (We have:
> > 	          (prescale + 1) * (period_steps + 1)
> > 	period =3D ------------------------------------
> > 	                       clk_rate
> >=20
>=20
> We want prescale small such that period_steps can be big to give
> fine-grained control over the available duty_cycles. period_steps is a
> 8-bit value < 0xff, so we get:
>=20
>                     period * clk_rate  =20
> 	prescale =3D ------------------- - 1
>                    NSEC_PER_SEC * 0xff
>=20
> which in code then reads:
>=20
> 	*prescale =3D div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX)
> 	if (*prescale)
> 		*prescale -=3D 1;
>=20
>=20
> > You calculate
> > 	            period * clk_rate
> > 	prescale =3D -------------------
> > 	           NSEC_PER_SEC * 0xff
> >=20
> > 	                     period * clk_rate
> > 	period_steps =3D ----------------------------- - 1
> > 	               NSEC_PER_SEC * (prescale + 1)
>=20
> The formula for period_steps is right.

I stood in front of the whiteboard for a bit to puzzle it all out and
have come to the realisation that you are right. I was implicitly
converting in my head from "mathematical" values to register values &
therefore not subtracting. I must've hyperfocused on the underflow when
I adjusted your suggestion back in v5 or w/e it was.

I must also have got rather unlucky that the configurations I picked to
check whether the calculations worked out, happened to. I suppose as
well, the way in which it was mis-calculating also avoids the PWM_DEBUG
complaints too.

Perhaps I'll insert your nice formulae in the next version in comments,
so they're there for next time.

Thanks again & sorry for consuming so much of your time on this,
Conor.


--fVFk6pos5f7gI6TJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8Ai0QAKCRB4tDGHoIJi
0sQnAQDsop1eRPZcbZgK9DgYp3wSCMO28qbboB6YdQAdQMzbTQD/VPhbn4dHc/6C
yTsaXuUHVY4G3F0m8oPsFcTOlB0TeQ8=
=VQbM
-----END PGP SIGNATURE-----

--fVFk6pos5f7gI6TJ--
