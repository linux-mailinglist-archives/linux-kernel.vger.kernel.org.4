Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA61623FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiKJKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:20:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DC19C26
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:20:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot4fc-00074I-7y; Thu, 10 Nov 2022 11:20:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot4fZ-003Qp3-KW; Thu, 10 Nov 2022 11:20:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot4fZ-00FcfD-NA; Thu, 10 Nov 2022 11:20:25 +0100
Date:   Thu, 10 Nov 2022 11:20:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/6] pwm: lpss: Include headers we are direct user of
Message-ID: <20221110102025.2tqdb3v6ndg6vyqk@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-4-andriy.shevchenko@linux.intel.com>
 <20221110072144.2s37r52qcpi6utgh@pengutronix.de>
 <CAHp75VenLc-QfuD3rHPh=5nu_SqWvEnsePbNMsBA4R-Zs+nvrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ilrfeteqmdew4gst"
Content-Disposition: inline
In-Reply-To: <CAHp75VenLc-QfuD3rHPh=5nu_SqWvEnsePbNMsBA4R-Zs+nvrw@mail.gmail.com>
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


--ilrfeteqmdew4gst
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 11:53:59AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 10, 2022 at 9:22 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 08, 2022 at 04:22:23PM +0200, Andy Shevchenko wrote:
> > > For the sake of integrity, include headers we are direct user of.
> > >
> > > While at it, move the struct pwm_lpss_chip to be after
> > > the struct pwm_lpss_boardinfo as the former uses pointer
> > > to the latter.
> >
> > That part is fine.
> >
> > > Replace device.h with a forward declaration in order to improve
> > > the compilation time due to reducing overhead of device.h parsing
> > > with entire train of dependencies.
> >
> > Together with "For the sake of integrity, include headers we are direct
> > user of." this makes an a bit schizophrenic impression on me. You add
> > <linux/types.h> because the file is a direct user of it, but you drop
> > <linux/device.h> despite being a direct user.
>=20
> But we don't use device.h.

What is the canonical header to provide struct device?

> > If you adapt the reasoning to something like:
> >
> > Replace the inclusion of <linux/device.h> by a forward declaration of
> > struct device plus a (cheaper) #include of <linux/types.h> as
> > <linux/device.h> is an expensive include (measured in compiler effort).
>=20
> Fine with me, thanks for the draft.
>=20
> > I could better live with it. I would even split this into two patches
> > then. (i.e. move struct pwm_lpss_chip vs the include and forward change)
>=20
> I think for this small change for a driver that hasn't been modified
> often it's fine to have them in one. But tell me if you are insisting
> on a split, I can do that.

I don't insist.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ilrfeteqmdew4gst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNs0GcACgkQwfwUeK3K
7Ak9iggAhGxxudCLGFL25NcgPyQ/qjyQM1LryRG9tCC0hHhkmpvNEdxRgdHghG9L
48uWXHpGmJ4CToYbKjmeN+2pk0lrCWwh9R5Av8y8/O5oDNxrda8uwtG7mOdhpC3q
0KZEvYuwlroI87pq1qG81UQdyHsQuZjusiFQctNHqgWI3XuDIOvMM8kGyET6uPe7
w9v+4ZsvUv979VgO0c49L9C+G/3XF9Ta2uJuovwnQt2clj9RN//5ai9JDQw8vnDr
pSjXFSO7sqokaRTsVEyUU4TbH0R/DI7UjuUApitn86YcEMrV/FLE8TiOg7CBbZzl
fOZ+jcg1cBba21CAv43jNGufS8NknQ==
=Gg6m
-----END PGP SIGNATURE-----

--ilrfeteqmdew4gst--
