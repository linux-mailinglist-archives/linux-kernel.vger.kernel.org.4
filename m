Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07955F0C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiI3Njv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiI3Njt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:39:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB7E1AD8A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:39:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGEp-0004vB-IS; Fri, 30 Sep 2022 15:39:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGEp-003oPC-LV; Fri, 30 Sep 2022 15:39:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGEn-004g8M-Gs; Fri, 30 Sep 2022 15:39:33 +0200
Date:   Fri, 30 Sep 2022 15:39:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220930133933.br5kanbh3clvahvr@pengutronix.de>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
 <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
 <Yyh8v+MtHuc0LLf0@wendy>
 <20220930091316.kdkf4oeu6uvxzqa6@pengutronix.de>
 <Yza61MO9hbuFytmM@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rtjav5n2d7kuyppr"
Content-Disposition: inline
In-Reply-To: <Yza61MO9hbuFytmM@wendy>
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


--rtjav5n2d7kuyppr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 10:45:56AM +0100, Conor Dooley wrote:
> On Fri, Sep 30, 2022 at 11:13:16AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Sep 19, 2022 at 03:29:19PM +0100, Conor Dooley wrote:
> > > Hey Uwe,
> > >=20
> > > On Mon, Sep 19, 2022 at 03:50:08PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Sep 19, 2022 at 01:53:56PM +0100, Conor Dooley wrote:
> > > > > Because I was running into conflicts between the reporting here a=
nd some
> > > > > of the checks that I have added to prevent the PWM being put into=
 an
> > > > > invalid state. On boot both negedge and posedge will be zero & th=
is was
> > > > > preventing me from setting the period at all.
> > > >=20
> > > > I don't understood that.
> > >=20
> > > On startup, (negedge =3D=3D posedge) is true as both are zero, but th=
e reset
> > > values for prescale and period are actually 0x8. If on reset I try to
> > > set a small period, say "echo 1000 > period" apply() returns -EINVAL
> > > because of a check in the pwm core in pwm_apply_state() as I am
> > > attempting to set the period to lower than the out-of-reset duty cycl=
e.
> >=20
> > You're supposed to keep the period for pwm#1 untouched while configuring
> > pwm#0 only if pwm#1 already has a consumer. So if pwm#1 isn't requested,
> > you can change the period for pwm#0.
>=20
> I must have done a bad job of explaining here, as I don't think this is
> an answer to my question.
>=20
> On reset, the prescale and period_steps registers are set to 0x8. If I
> attempt to set the period to do "echo 1000 > period", I get -EINVAL back
> from pwm_apply_state() (in next-20220928 it's @ L562 in pwm/core.c) as
> the duty cycle is computed as twice the period as, on reset, we have
> posedge =3D negedge =3D 0x0. The check of state->duty_cycle > state->peri=
od
> fails in pwm_apply_state() as a result.

So set duty_cycle to 0 first?

A problem of the sysfs interface is that you can only set one parameter
after the other. So there you have to find a sequence of valid
pwm_states that only differ in a single parameter between the initial
and the desired state.

That's nothing a "normal" pwm consumer would be affected by. (IMHO we
should have a userspace API that benefits from the properties of
pwm_apply().)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rtjav5n2d7kuyppr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM28ZIACgkQwfwUeK3K
7AmJ0Af/Uo5rO+tFoSMofiW5sgL/QaXfTixAJCtvamJAfhQDDzksiQLoyMz9Evj9
vPB281oL3yRgjSiLxTRl9jW51jJclF05muLkOkC/yHZgBRKjrrvuPNPsInDLDF3W
VLjCvv9F3So7LFQwWkdgbFiGnQcuBGkVvj2DgWPKRUfxmW71J3BV9DLM+aLTIWnl
/OTIxdiVtA29+G7Hm00gkbC/d1glG4bC8fHZ15l06457Ab76SDlzy/0z9Pa9/wlZ
bJ/HcBPOZNJO5R4C1x1YKGz2HLCRRmaRxnO5aSLorzwlLoGDu3sTZ72JCNSb4mqt
09gY/rxyEwV5Enqk7Ud+OS4XgGOlCA==
=BB3H
-----END PGP SIGNATURE-----

--rtjav5n2d7kuyppr--
