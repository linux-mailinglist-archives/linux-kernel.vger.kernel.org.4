Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35486623FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKJKX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKJKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:23:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C5B93
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:23:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot4iM-0007Xk-VK; Thu, 10 Nov 2022 11:23:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot4iL-003QpS-C8; Thu, 10 Nov 2022 11:23:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot4iL-00FcfY-M3; Thu, 10 Nov 2022 11:23:17 +0100
Date:   Thu, 10 Nov 2022 11:23:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/6] pwm: lpss: Allow other drivers to enable PWM LPSS
Message-ID: <20221110102317.ea64tgqd77kvygvt@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-5-andriy.shevchenko@linux.intel.com>
 <20221110072810.meu3cxh5repuglk3@pengutronix.de>
 <CAHp75VeV+ZBQ2M7xrP8o+KxSg9uXbcsDo5=9sU+=WF9muodDvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtrga4jnrsfwiu4p"
Content-Disposition: inline
In-Reply-To: <CAHp75VeV+ZBQ2M7xrP8o+KxSg9uXbcsDo5=9sU+=WF9muodDvA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtrga4jnrsfwiu4p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 11:58:53AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 10, 2022 at 9:28 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 08, 2022 at 04:22:24PM +0200, Andy Shevchenko wrote:
> > > The PWM LPSS device can be embedded in another device.
> > > In order to enable it, allow that drivers to probe
> > > a corresponding device.
>=20
> ...
>=20
> > Now that pwm_lpss_boardinfo lives in a different file, this makes the
> > move of pwm_lpss_chip in patch 3 somewhat redundant.
>=20
> But they are independent changes. At each stage (after each patch) we
> should have a finished step, right? Not touching that makes me feel
> that the step is half-baked. If you insist I can drop that move from
> the other patch.

Given that the move is something you do just en passant in the earlier
patch , I consider my suggestion cleaner. I'd call that 0.5 * insist.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dtrga4jnrsfwiu4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNs0RIACgkQwfwUeK3K
7AmYWAgAoXw2aVzt4Pi2Ug+j6iZJ4thb0OaZnRQbnbUQPj3HrHtoyjvPqcX637xx
onDuYhduZfB3Mslbrh5X6sv/Xv44i4+VBKrhg/d/7tSIW/dYJQPWLvOsW9shpqv6
xb5yjSmfA3EWgSP0U76SSyDUwg2PKNHvxQUzgLZWhPJDebaRZf2kKv4qJN/PeTRR
x8tQLmKwFO6sOkc2TAvVECFWZayuZOChVhKSuVVjrv9fvoflEh/b93JSTyJsc3Lj
YP8+KkuZtqrB2uHjd7mERwrZFNQInJgrDjjkBUo9rRAp2UPlFeIy1Wu4uRmWCxPo
u6Uhl3VGnDGelUZ1l+WAmFKfT3OZNQ==
=V29X
-----END PGP SIGNATURE-----

--dtrga4jnrsfwiu4p--
