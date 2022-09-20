Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A619C5BEB44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiITQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiITQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:41:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A9667C98
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:41:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oagJY-0005mP-QD; Tue, 20 Sep 2022 18:41:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oagJZ-001tcg-8N; Tue, 20 Sep 2022 18:41:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oagJX-002H6n-0M; Tue, 20 Sep 2022 18:41:39 +0200
Date:   Tue, 20 Sep 2022 18:41:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Olof Johansson <olof@lixom.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2] serial: sifive: enable clocks for UART when probed
Message-ID: <20220920164135.7hjewp2kyi6zp5o7@pengutronix.de>
References: <20220920160017.7315-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrbdrldkip7w62to"
Content-Disposition: inline
In-Reply-To: <20220920160017.7315-1-olof@lixom.net>
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


--lrbdrldkip7w62to
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 20, 2022 at 09:00:18AM -0700, Olof Johansson wrote:
> When the PWM driver was changed to disable clocks if no PWMs are enabled,
> it ended up also disabling the shared parent with the UART, since the
> UART doesn't do any clock enablement on its own.
>=20
> To avoid these surprises, switch to clk_get_enabled().
>=20
> Fixes: ace41d7564e655 ("pwm: sifive: Ensure the clk is enabled exactly on=
ce per running PWM")
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lrbdrldkip7w62to
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMp7T0ACgkQwfwUeK3K
7AknbwgAidqEwlEPF6FyfKvgD30uVgZYJzrAa2GklHNToKfFbYIP/KAmbMUAROdU
DSl4HX/GMirbjcttlXI5mcxCQ9V5M0NDwWnDSfy6iZuTmO08ftRBAumEdq9MaJtU
e2mG5WG8MMHqv8IyoVl//VNEEzijDiq93nslyjtaVI+xvhhefxe0+IGt3noXgH71
aRArAwESn7fATUuZK0XjhlQ/10TId6hjz9Slwkr+7uYU3jGvMdA0ZbQ46BtY7EZj
xy+GMUAe0Nbaq0NAcgn96W5TEs4a957umPqgoyVXDxhHic/LogWcm7rdIEEE8oht
xTL5C7pnyaxn3YGoL5W+GnRRodC6Bw==
=x2AC
-----END PGP SIGNATURE-----

--lrbdrldkip7w62to--
