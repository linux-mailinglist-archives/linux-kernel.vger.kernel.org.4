Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE96CBC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjC1Kbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1Kbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE56A61
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:31:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6c6-0001e0-Cn; Tue, 28 Mar 2023 12:31:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6c5-007HgE-Li; Tue, 28 Mar 2023 12:31:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6c5-008f0E-0g; Tue, 28 Mar 2023 12:31:37 +0200
Date:   Tue, 28 Mar 2023 12:31:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] clocksource/drivers/imx-gpt: Drop unused function
 mxc_timer_init()
Message-ID: <20230328103136.xafgjdkvdwnn7pwi@pengutronix.de>
References: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AHrXrJZJ2NY3GN56zf=meA5r3rWpD7GVuszBL7zcye5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qr7wgp5lkzg6t45a"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AHrXrJZJ2NY3GN56zf=meA5r3rWpD7GVuszBL7zcye5Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qr7wgp5lkzg6t45a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 07:14:24AM -0300, Fabio Estevam wrote:
> Hi Uwe,
>=20
> On Tue, Mar 28, 2023 at 7:06=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The last caller is gone since v5.10-rc1~28.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> I have already submitted this change:
> https://lore.kernel.org/linux-arm-kernel/20230307124313.708255-1-festevam=
@denx.de/

I don't care much which of them is included. Before patch #3 of my
series is applied, either of the two must be applied first.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qr7wgp5lkzg6t45a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQiwgcACgkQj4D7WH0S
/k7Tygf/d59wVvjwnKqGrkp5jN15xXtzk5MNJOpdV56evpERei8Va/3U7wPg+7zg
ptkXc/WdtBlm5F5u+ZGxIU30QzqFjUyw1R2d98Hz2UBuj921iuApF2A4YiOeB8jO
TkvMjDVLDXvA0i1EyLLrb2Xh/It1O0c22jEZma1a5+lpkXfgVmwzncZzHYEE4DEd
M5dbI15FVHDLSizpQYwfHAqSX8dAugq3wdu2HtdeSuoEHxoZQaZjxtvVVUkd544l
EyGvuwKvIoCr3cPHEkXjcYulKQg/C0/EWq8951wXVI/t2peGnvhpho8rC7OGiaeX
nEehush+/99tHr4m+GrKf96VC5ilow==
=evRv
-----END PGP SIGNATURE-----

--qr7wgp5lkzg6t45a--
