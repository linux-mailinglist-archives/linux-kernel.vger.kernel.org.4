Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9907C5F074E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiI3JNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiI3JN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:13:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7A314DAE1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:13:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeC57-000471-U1; Fri, 30 Sep 2022 11:13:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeC58-003m3N-E7; Fri, 30 Sep 2022 11:13:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeC56-004YMC-Ar; Fri, 30 Sep 2022 11:13:16 +0200
Date:   Fri, 30 Sep 2022 11:13:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220930091316.kdkf4oeu6uvxzqa6@pengutronix.de>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
 <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
 <Yyh8v+MtHuc0LLf0@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mc44qmsettlbnrey"
Content-Disposition: inline
In-Reply-To: <Yyh8v+MtHuc0LLf0@wendy>
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


--mc44qmsettlbnrey
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2022 at 03:29:19PM +0100, Conor Dooley wrote:
> Hey Uwe,
>=20
> On Mon, Sep 19, 2022 at 03:50:08PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Sep 19, 2022 at 01:53:56PM +0100, Conor Dooley wrote:
> > > Because I was running into conflicts between the reporting here and s=
ome
> > > of the checks that I have added to prevent the PWM being put into an
> > > invalid state. On boot both negedge and posedge will be zero & this w=
as
> > > preventing me from setting the period at all.
> >=20
> > I don't understood that.
>=20
> On startup, (negedge =3D=3D posedge) is true as both are zero, but the re=
set
> values for prescale and period are actually 0x8. If on reset I try to
> set a small period, say "echo 1000 > period" apply() returns -EINVAL
> because of a check in the pwm core in pwm_apply_state() as I am
> attempting to set the period to lower than the out-of-reset duty cycle.

You're supposed to keep the period for pwm#1 untouched while configuring
pwm#0 only if pwm#1 already has a consumer. So if pwm#1 isn't requested,
you can change the period for pwm#0.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mc44qmsettlbnrey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM2sygACgkQwfwUeK3K
7AkzvAf5AVpy5bOQaZ0X+uV/8U5PrucuD6BKzlppGG7dlsaBLiSKKjzF+EAc5DKl
3zZ6Tlwuh9y/YEO55J30hnk6wZQmMGnVlStYfWyt3b7TB5EiT2sslvPnrUU50w9G
zCOZwXUH4KLI3ubaIHNHA3RWxCjxtaumas2xmWTNwkRVVTKOA1JE9A2HOxyPd/09
MRzV6dx/nc8u/h0kuf3DekqvhRoHu17rxvd/x+mezVlY+einkpatKaFODCFYHHYo
JxCLRhUEnJdeqqqpUB00FW7A+BAw+lyLXfx7CBAHWW+mc0e7wAH5tBATExeUCcl1
3nutfF6+YqiYarH75WEMvSxrXzz+4A==
=nDLE
-----END PGP SIGNATURE-----

--mc44qmsettlbnrey--
