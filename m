Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281CB66DC58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjAQL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjAQL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:27:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4548F59CA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:27:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHk7h-0005PN-Im; Tue, 17 Jan 2023 12:27:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHk7g-006f5W-QU; Tue, 17 Jan 2023 12:27:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHk7g-00Da9f-3R; Tue, 17 Jan 2023 12:27:24 +0100
Date:   Tue, 17 Jan 2023 12:27:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Sayyed, Mubin" <mubin.sayyed@amd.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "mubin10@gmail.com" <mubin10@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>
Subject: Re: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Message-ID: <20230117112724.nnokjmfffeb2wbnp@pengutronix.de>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-4-mubin.sayyed@amd.com>
 <20230112212514.aez6oj4zfcivknk5@pengutronix.de>
 <DM4PR12MB5938E26F6A7DFC9A1875233D9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzo5pun4mtdcp2uq"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5938E26F6A7DFC9A1875233D9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
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


--qzo5pun4mtdcp2uq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mubin,

On Tue, Jan 17, 2023 at 09:58:10AM +0000, Sayyed, Mubin wrote:
> > On Thu, Jan 12, 2023 at 12:45:26PM +0530, Mubin Sayyed wrote:
> > Is there a public manual for the hardware? If yes, please mention a lin=
k here.
> [Mubin]: I did not find any public manual from cadence. However, details =
can be found in Zynq-7000/ Zynq UltraScale/Versal ACAP TRM available public=
ly.

Thenk please add a link to that one.

> > how does the output pin behave between the writes in this function (and=
 the
> > others in .apply())?
> [Mubin]:  ttc_pwm_apply  is disabling counters before calling this
> function, and enabling it back immediately after it.  So, output pin
> would be low during configuration.=20

Please document this behaviour (i.e. "A disabled PWM emits a zero") in a
paragraph at the top of the driver in the format that e.g.
drivers/pwm/pwm-pxa.c is using. Also please test if it emits a zero or
the inactive level, i.e. if the output depends on the polarity setting.

> > > +		rate =3D clk_get_rate(priv->clk);
> > > +
> > > +		/* Prevent overflow by limiting to the maximum possible period */
> > > +		period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_S=
EC);
> > > +		period_cycles =3D DIV_ROUND_CLOSEST(period_cycles * rate, NSEC_PER=
_SEC);
> >=20
> > DIV_ROUND_CLOSEST isn't suiteable to work with u64. (That's also the
> > reason for the build bot report.)
> >=20
> > The usual alternative trick here is to do:
> >=20
> > 	if (rate > NSEC_PER_SEC)
> > 		return -EINVAL;
> >=20
> > 	period_cycles =3D mul_u64_u64_div_u64(state->period, rate,
> > NSEC_PER_SEC);
> [Mubin]: Initially I tried mul_u64_u64_div_u64, it was impacting
> accuracy while generating PWM signal of high frequency(output
> frequency above 5 MHZ,  input 100 MHZ ). Usage of DIV_ROUND_CLOSEST
> improved accuracy. Can you please suggest better alternative for
> improving accuracy.

Unless I'm missing something, you have to adjust your definition of
accuracy :-)

If you request (say) a period of 149 ns and the nearest actual values
your hardware can provide left and right of that is 140 ns and 150 ns,
140ns is the one to select. That is pick the biggest possible period not
bigger than the requested period. And with that pick the biggest
possible duty_cycle not bigger than the requested duty_cycle. (i.e. it's
a bug to emit period=3D150ns if 149 was requested.)

There are ideas to implement something like

	pwm_apply_nearest(...);

but that's still in the idea stage (and will depend on the lowlevel
drivers implementing the strategy described above).

> > Another possible glitch here.
> [Mubin]: Can you please elaborate.

If you switch polarity (say from normal to inverted) and duty/period you do=
 (simplified)

	ttc_pwm_disable(priv, pwm); // might yield a falling edge
	set polarity                // might yield a raising edge
	ttc_pwm_enable(priv, pwm);  // might yield a falling edge
	... some calculations
	ttc_pwm_disable(priv, pwm); // might yield a raising edge
	setup counters
	ttc_pwm_enable(priv, pwm);  // might yield a falling edge

so during apply() the output might toggle several times at a high(?)
frequency. Depending on what you have connected to the PWM this is bad.
(A LED might blink, a backlight might flicker, a motor might stutter and
enter an error state or accelerate for a moment.)

> > > +	clksel =3D ttc_pwm_readl(priv, TTC_CLK_CNTRL_OFFSET);
> >=20
> > TTC_CLK_CNTRL_OFFSET is as parameter for ttc_pwm_ch_readl and
> > ttc_pwm_readl, is this correct?
> [Mubin]: Here TTC_CLK_CNTRL_OFFSET is being read only for 0th channel, so=
 using ttc_pwm_readl does not impact offsets.

So which clk is selected (for all channels?) depends on how channel 0's
clock setting is setup by the bootloader (or bootrom)? Sounds strange.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qzo5pun4mtdcp2uq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPGhhkACgkQwfwUeK3K
7AmfXAf/d79MZbbAZ2J8lxPnpNXsts7uzK2hIgAj7D8MEhGipbX4ifBjA/9lJqc6
FX8zlLFmyNNXveQXS3ZDqV1iE/YaksQn17afWqIkuja8TQn9R6QQ4LEa/NYBJ9sJ
gKYZ056ssshhplEHzoaPXzh7T8WeFO7ByWUBSKeDnUF5sOeDxqTwBA4dgaApsgqW
0M4iIZF3nM7VddG0SqTd/auWDsJLOu1mwXzqW0Vn8wQ2ncoJ+56/7a0XCxwwIS+6
WcPT0dmADPsJefEyaq/KInJiB2QUAFc6v12ew7swfW+6pepudV1PK/4Gv1hhPMgY
Io2FQ4hu2cM+jGGyuuAAlnEpuZyKhA==
=faKa
-----END PGP SIGNATURE-----

--qzo5pun4mtdcp2uq--
