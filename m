Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE326A69AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCAJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCAJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:21:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7192A2FCD8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:21:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXIdp-0004k8-VR; Wed, 01 Mar 2023 10:20:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXIdn-0014Ab-4C; Wed, 01 Mar 2023 10:20:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXIdm-001Fi4-CX; Wed, 01 Mar 2023 10:20:50 +0100
Date:   Wed, 1 Mar 2023 10:20:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nylon7717@gmail.com,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Subject: Re: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED
 algorithm
Message-ID: <20230301092050.gwwbfsltyuow7pq6@pengutronix.de>
References: <20230130093229.27489-1-nylon.chen@sifive.com>
 <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
 <CAHh=Yk_hFOjwY1mbmYk8yqH_AKDs1_3J+5pYQStseNsZukPSoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uloatnw5mqumdhea"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk_hFOjwY1mbmYk8yqH_AKDs1_3J+5pYQStseNsZukPSoA@mail.gmail.com>
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


--uloatnw5mqumdhea
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nylon,

On Wed, Feb 01, 2023 at 04:56:42PM +0800, Nylon Chen wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=
=B9=B41=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:17=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> > > The `frac` variable represents the pulse inactive time, and the resul=
t of
> > > this algorithm is the pulse active time. Therefore, we must reverse t=
he
> > > result.
> > >
> > > The reference is SiFive FU740-C000 Manual[0].
> > >
> > > [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86e=
d8b16acba_fu740-c000-manual-v1p6.pdf
> > >
> > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index 62b6acc6373d..a5eda165d071 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > >       /* The hardware cannot generate a 100% duty cycle */
> > >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> >
> > The same problem exists in pwm_sifive_get_state(), doesn't it?
> >
> > As fixing this is an interruptive change anyhow, this is the opportunity
> > to align the driver to the rules tested by PWM_DEBUG.
> >
> > The problems I see in the driver (only checked quickly, so I might be
> > wrong):
> >
> >  - state->period !=3D ddata->approx_period isn't necessarily a problem.=
 If
> >    state->period > ddata->real_period that's fine and the driver should
> >    continue
> >
> >  - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> >    is wrong for two reasons:
> >    it should round down and use the real period.
> >
> I need a little time to clarify your assumptions. If possible, I will
> make similar changes.
>=20
> e.g.
> rounddown(num, state->period);
> if (state->period < ddata->approx_period)
>     ...

the idea is that for a given request apply should do the following to
select the hardware setting:

 - Check polarity, if the hardware doesn't support it, return -EINVAL.
   (A period always starts with the active phase for the duration of
   duty_cycle. For normal polarity active =3D high.)
 - Pick the biggest period length possible that is not bigger than the
   requested period.
 - For the picked period, select the biggest duty_cycle possible that is
   not bigger than the requested duty_cycle.

Then if possible switch to the selected setting in an atomic step.

Does this clearify your doubts?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uloatnw5mqumdhea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmP/GO8ACgkQwfwUeK3K
7AmiBQf/QkDz4UZYVBJc3n2y9z64RYU6Ri68Em2lO8oxTfUYy7I/4IePztOJf0un
riimd6Yxxwu7+b+wmtMyaMmHyzIZP+ecScJejXrSedMLGdC+SIvdGtNVEVUa/Lue
41IHyN6Bv0SgKb7CSNGzo8luaU1n3R2v9pujlMCPW7kaS03SOfEf3TN5ior4DEdt
9fl5PaVY1OY0M3Y+wkK3QLaD8u4GUkppSknT6tuQ0OP8r8rZil0p173UYRgpQ1rh
EJt0oVvaSIDRC9oSL4qFqIf8k5sIjvP8rc0c6bfunPNW6saV2DK05Dg7F3A9/NrO
uyu2CPKCuZ0h82DWo5SHFN3TKgF0QA==
=5dcD
-----END PGP SIGNATURE-----

--uloatnw5mqumdhea--
