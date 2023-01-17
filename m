Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704466DFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAQOF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjAQOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:05:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A5D39CE4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:05:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHmaF-0001cm-6Y; Tue, 17 Jan 2023 15:05:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHmaE-006gpI-EZ; Tue, 17 Jan 2023 15:05:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHmaD-00Dbhv-PJ; Tue, 17 Jan 2023 15:05:01 +0100
Date:   Tue, 17 Jan 2023 15:05:01 +0100
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
Message-ID: <20230117140501.3g3mk6htzworeqij@pengutronix.de>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-4-mubin.sayyed@amd.com>
 <20230112212514.aez6oj4zfcivknk5@pengutronix.de>
 <DM4PR12MB5938E26F6A7DFC9A1875233D9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
 <20230117112724.nnokjmfffeb2wbnp@pengutronix.de>
 <DM4PR12MB5938774A495A246EE5557BEF9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="44z4uhgknr7nhdlv"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5938774A495A246EE5557BEF9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
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


--44z4uhgknr7nhdlv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2023 at 12:55:06PM +0000, Sayyed, Mubin wrote:
> Hi Uwe,
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Tuesday, January 17, 2023 4:57 PM
> > To: Sayyed, Mubin <mubin.sayyed@amd.com>
> > Cc: robh+dt@kernel.org; treding@nvidia.com; linux-pwm@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; Paladugu, Siva Durga Prasad
> > <siva.durga.prasad.paladugu@amd.com>; mubin10@gmail.com;
> > krzk@kernel.org
> > Subject: Re: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC
> > PWM
> >=20
> > Hello Mubin,
> >=20
> > On Tue, Jan 17, 2023 at 09:58:10AM +0000, Sayyed, Mubin wrote:
> > > > On Thu, Jan 12, 2023 at 12:45:26PM +0530, Mubin Sayyed wrote:
> > > > Is there a public manual for the hardware? If yes, please mention a=
 link
> > here.
> > > [Mubin]: I did not find any public manual from cadence. However, deta=
ils
> > can be found in Zynq-7000/ Zynq UltraScale/Versal ACAP TRM available
> > publicly.
> >=20
> > Thenk please add a link to that one.
> >=20
> > > > how does the output pin behave between the writes in this function
> > > > (and the others in .apply())?
> > > [Mubin]:  ttc_pwm_apply  is disabling counters before calling this
> > > function, and enabling it back immediately after it.  So, output pin
> > > would be low during configuration.
> >=20
> > Please document this behaviour (i.e. "A disabled PWM emits a zero") in a
> > paragraph at the top of the driver in the format that e.g.
> > drivers/pwm/pwm-pxa.c is using. Also please test if it emits a zero or =
the
> > inactive level, i.e. if the output depends on the polarity setting.
>=20
> [Mubin]: will confirm behavior on hardware and document it.
> >=20
> > > > > +		rate =3D clk_get_rate(priv->clk);
> > > > > +
> > > > > +		/* Prevent overflow by limiting to the maximum possible
> > period */
> > > > > +		period_cycles =3D min_t(u64, state->period, ULONG_MAX *
> > NSEC_PER_SEC);
> > > > > +		period_cycles =3D DIV_ROUND_CLOSEST(period_cycles * rate,
> > > > > +NSEC_PER_SEC);
> > > >
> > > > DIV_ROUND_CLOSEST isn't suiteable to work with u64. (That's also the
> > > > reason for the build bot report.)
> > > >
> > > > The usual alternative trick here is to do:
> > > >
> > > > 	if (rate > NSEC_PER_SEC)
> > > > 		return -EINVAL;
> > > >
> > > > 	period_cycles =3D mul_u64_u64_div_u64(state->period, rate,
> > > > NSEC_PER_SEC);
> > > [Mubin]: Initially I tried mul_u64_u64_div_u64, it was impacting
> > > accuracy while generating PWM signal of high frequency(output
> > > frequency above 5 MHZ,  input 100 MHZ ). Usage of DIV_ROUND_CLOSEST
> > > improved accuracy. Can you please suggest better alternative for
> > > improving accuracy.
> >=20
> > Unless I'm missing something, you have to adjust your definition of acc=
uracy
> > :-)
> >=20
> > If you request (say) a period of 149 ns and the nearest actual values y=
our
> > hardware can provide left and right of that is 140 ns and 150 ns, 140ns=
 is the
> > one to select. That is pick the biggest possible period not bigger than=
 the
> > requested period. And with that pick the biggest possible duty_cycle not
> > bigger than the requested duty_cycle. (i.e. it's a bug to emit period=
=3D150ns if
> > 149 was requested.)
> >=20
> > There are ideas to implement something like
> >=20
> > 	pwm_apply_nearest(...);
> >=20
> > but that's still in the idea stage (and will depend on the lowlevel dri=
vers
> > implementing the strategy described above).
> [Mubin]: Thanks for explaining, will switch to mul_u64_u64_div_u64,
> though percentage of deviation would be more for PWM signal of high
> frequency. For example, requested period is 50 ns,  requested duty
> cycle is 49 ns(98%), actual duty cycle set by driver would be 40ns
> (80%).

Note it's a trade-off to let drivers round down and not nearest. The
motivating reasons are:

 - division rounding down is the default in C, so it's a tad easier
 - there are less corner cases
   (There are two strange effects that I'm aware of:
    - Consider for example a hardware that can implement periods of
      length 49.2 ns, 49.4 ns and 50.7 ns (and nothing in-between). If
      you request 50 ns, you get 49.4. .get_state would then tell you
      that the hardware has configured 49 ns. But if you request 49
      ns, you don't get 49.4 ns.
    - Rounding to the nearest time is different to rounding to the
      nearest frequency:
      Consider a hardware than can configure a period of 200 ns (freq:
      5 MHz) and 300 ns (freq: 3.33333 MHz). If you request 249 ns
      (freq: 4.016 MHz) you'd get 200 ns if you round to the nearest
      time, but 300 if you round to the nearest frequency.
   Both problems don't happen with rounding down.)
 - .get_state which is supposed to be the inverse of .apply() needs one
   more distinction of cases.
   (That is, if the nearest integer above or below the actual value
   should be returned. And additionally another arbitraty choice what to
   return for 50.5 ns)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--44z4uhgknr7nhdlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPGqwoACgkQwfwUeK3K
7AkM8wf+JDYaihGR6rqCYTVhy6yNXYiaq/V1gpUkE1qzcYpsiVvGJTeCfZy1Tvj6
IKMDHPqNzkj1zmLXoZR9HvuJvYZsK3uPgRcpaSgeCjbF6DaUP1SArJsnx0s1UJwn
c0EQEWzxQtTXFtS721Zi7oAGXpfF2LCO0+ayHJ8kgKi3aGL3/Ko1sSS8HbquCAPU
LgwsFCJ+G3fVSiGcQ+/8b+LiEXh5vg1ErrlSMoGKzqBYOlJ12g31MzqQT4pMj7Bg
5xSu/k+WTavFmOKSZ+BtdCt1Be68cVXIcGmex/s32O6BWVeupDZAZfgHFS7GAc1J
gtYDlbx1riMHGh0GZXsIAmWqNlbzhg==
=IAJm
-----END PGP SIGNATURE-----

--44z4uhgknr7nhdlv--
