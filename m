Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B1705FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjEQGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjEQGOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:14:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E28468A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:14:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzAQJ-0005tA-Eb; Wed, 17 May 2023 08:14:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzAQI-000mGL-L7; Wed, 17 May 2023 08:14:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzAQH-005Ewr-FP; Wed, 17 May 2023 08:14:05 +0200
Date:   Wed, 17 May 2023 08:13:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/43] pwm: ep93xx: drop legacy pinctrl
Message-ID: <20230517061355.5o2ksfkpupsbpuha@pengutronix.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-37-nikita.shubin@maquefel.me>
 <20230515143222.dlhxcze5254773r4@pengutronix.de>
 <f43addc54fd6bafca831d2f2802cc09c4e5baef9.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gw7u2sguz6vwjysm"
Content-Disposition: inline
In-Reply-To: <f43addc54fd6bafca831d2f2802cc09c4e5baef9.camel@maquefel.me>
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


--gw7u2sguz6vwjysm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nikita,

On Tue, May 16, 2023 at 01:43:27PM +0300, Nikita Shubin wrote:
> On Mon, 2023-05-15 at 16:32 +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 24, 2023 at 03:34:52PM +0300, Nikita Shubin wrote:
> > > diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
> > > index 8bfe6cfbb3db..657adb011aeb 100644
> > > --- a/drivers/pwm/pwm-ep93xx.c
> > > +++ b/drivers/pwm/pwm-ep93xx.c
> > > @@ -45,20 +45,6 @@ static inline struct ep93xx_pwm
> > > *to_ep93xx_pwm(struct pwm_chip *chip)
> > > =A0=A0=A0=A0=A0=A0=A0=A0return container_of(chip, struct ep93xx_pwm, =
chip);
> > > =A0}
> > > =A0
> > > -static int ep93xx_pwm_request(struct pwm_chip *chip, struct
> > > pwm_device *pwm)
> > > -{
> > > -=A0=A0=A0=A0=A0=A0=A0struct platform_device *pdev =3D to_platform_de=
vice(chip-
> > > >dev);
> > > -
> > > -=A0=A0=A0=A0=A0=A0=A0return ep93xx_pwm_acquire_gpio(pdev);
> >=20
> > I didn't get the whole series and didn't spot a relevant followup
> > change
>=20
> https://lore.kernel.org/all/20230424123522.18302-1-nikita.shubin@maquefel=
=2Eme/

Yeah, I looked there, but didn't find it. Applied the whole series now
and found "ARM: ep93xx: soc: drop defines". A few things I noticed while
doing so:

 - git am warns about new blank lines at EOF in several patches.

 - b4 am 20230424123522.18302-1-nikita.shubin@maquefel.me
   warns about broken DKIM signatures. The copy I got directly via Cc is
   OK though. The relevant problem is that your To: header is empty but
   part of the signed payload + the copy I got via vger.kernel.org had
   the To header mangled to

	To:     unlisted-recipients:; (no To-header on input)=20

   This results in:

	$ curl -s https://lore.kernel.org/lkml/20230424123522.18302-37-nikita.shub=
in@maquefel.me/raw | dkimverify
	signature verification failed
	$ curl -s https://lore.kernel.org/lkml/20230424123522.18302-37-nikita.shub=
in@maquefel.me/raw | sed 's/^To:.*/To:/' | dkimverify=20
	signature ok

   I don't know who is to blame here (i.e. is an empty To allowed?) but
   I'd recommend to put the people you want to merge the patches into
   the To header anyhow.

> > on lore.k.o, so: I assume ep93xx_pwm_acquire_gpio() and
> > ep93xx_pwm_release_gpio() will be unused in the end? Do you drop
> > them?
> >=20
> > I assume this series target to be taken via arm-soc (once the review
> > feedback is positive)?

You didn't reply to that one. Still assuming this to be true, I'll mark
this patch as handled-elsewhere in the PWM patchwork.

> > I wonder if this change breaks non-dt machine support?
>=20
> The aim for the whole series is fully converting to dt, this means
> platform files will be dropped.
>=20
> The v1 series tries not to break anything until platform removal
> commit, before this commit non-dt version should be compilable and
> fully functional.

OK, the pwm patch looks fine to me,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards and thanks for your efforts,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gw7u2sguz6vwjysm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRkcKIACgkQj4D7WH0S
/k66AQgApBlpGxKurVIar8vOJEAJIDsakYGLp5W4nQvnDQ6MhtYWPPlhOAMIJutb
yGK/w6VdeWkCQ39Bf0nJLk1U6Mr2ZxPJx+c7A8Lm2J5dR6qelbBVONW+8RLt6Po1
hoJ3G38tVl6DHbwsMdGoBAwEmIpSlLveu6+ojMAmL/OsuVqYLqBRdEwsmbJTzpVn
D9kUQ8bUy/v7w1UXX2tHzU2v12hwOzEyxsxhYfVJmp+/M7vw0aEsN78lOQ5ySFgD
VoPG65pnywTb5ksLOZr845MXyE1SqtCXt0a4NDsbOk0IgkoF1Wiwik5xN2uEvyoE
JJLZ6DVCvwGrqPX/HfRyeQ6AmrAz/A==
=tUOA
-----END PGP SIGNATURE-----

--gw7u2sguz6vwjysm--
