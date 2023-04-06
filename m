Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECB56D9913
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjDFOIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbjDFOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:07:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C14AD1C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:07:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkQGi-0005t8-0J; Thu, 06 Apr 2023 16:07:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkQGf-009P6h-7W; Thu, 06 Apr 2023 16:07:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pkQGe-00B4LC-Gz; Thu, 06 Apr 2023 16:07:12 +0200
Date:   Thu, 6 Apr 2023 16:07:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/5] clocksource: Convert to platform remove callback
 returning void
Message-ID: <20230406140712.v73dyrxkbszxey5v@pengutronix.de>
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
 <0a42d419-7ec2-6d09-9b19-15aa25888625@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xk57upxb6dtjlhaj"
Content-Disposition: inline
In-Reply-To: <0a42d419-7ec2-6d09-9b19-15aa25888625@linaro.org>
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


--xk57upxb6dtjlhaj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

On Thu, Apr 06, 2023 at 03:54:11PM +0200, Daniel Lezcano wrote:
> On 13/03/2023 08:54, Uwe Kleine-K=F6nig wrote:
> > this patch series adapts the platform drivers below drivers/clk
> > to use the .remove_new() callback. Compared to the traditional .remove()
> > callback .remove_new() returns no value. This is a good thing because
> > the driver core doesn't (and cannot) cope for errors during remove. The
> > only effect of a non-zero return value in .remove() is that the driver
> > core emits a warning. The device is removed anyhow and an early return
> > from .remove() usually yields a resource leak.
> >=20
> > Most clocksource drivers are not supposed to be removed. Two drivers are
> > adapted here to actually prevent removal. One driver is fixed not to
> > return an error code in .remove() and then the two remaining drivers
> > with a remove callback are trivially converted to .remove_new().
> >=20
>=20
> Applied and fixed up patch #2

Great. Thank you.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xk57upxb6dtjlhaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQu0g8ACgkQj4D7WH0S
/k5gfAgAoMsAoS863CM3KocI1YpfLtjIOgiqNbEC/+aV8R+deWfCAZbI0Uyuvfum
EEtkYZN6LOJLQRBmrmax1DbJ/TmR41teaU2agD9317k5bFJp5iqTygjH8Qjvalj7
fdH7b88VwKTwH1g3m8IFCfNEKLGlhFa4QXUqZYtjUAdKqf7wrI6JLegYaaUErR3h
V5nSi7RzqLWNXLzjWAKL7qoryTpa4oCqOdhJ6W+cYSo3qzEI7t+aJPnSXulD0yUB
BeQ1ox/59XA+YkrTvX20K8TciphTFnqk+M4xq3SPaztFsSnshkQCHyvhGXOHGi5C
9LXqquRiJnSkq+febMXlI5KRXzKokQ==
=7ttN
-----END PGP SIGNATURE-----

--xk57upxb6dtjlhaj--
