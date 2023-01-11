Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575AF66572F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjAKJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbjAKJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:17:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BEBE3B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:15:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFXCj-0003bM-QK; Wed, 11 Jan 2023 10:15:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFXCi-005GgP-TK; Wed, 11 Jan 2023 10:15:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFXCi-00BveW-8A; Wed, 11 Jan 2023 10:15:28 +0100
Date:   Wed, 11 Jan 2023 10:15:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230111091528.dh4nlk4xlpgn6paw@pengutronix.de>
References: <20221221112912.147210-1-conor@kernel.org>
 <20221221112912.147210-2-conor@kernel.org>
 <20230110224805.3pqxd3yv4wyci2zj@pengutronix.de>
 <Y73/oUwuOwQFR0NZ@spud>
 <20230111070250.w7egzcufa4waxg2n@pengutronix.de>
 <Y75ss+aSCjx7E9SZ@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6gsm32m6fyt25ymx"
Content-Disposition: inline
In-Reply-To: <Y75ss+aSCjx7E9SZ@wendy>
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


--6gsm32m6fyt25ymx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Wed, Jan 11, 2023 at 08:00:51AM +0000, Conor Dooley wrote:
> > > [...]
> > > Perhaps I need to watch a lecture on how to write a PWM driver since I
> > > am clearly no good at it, given the 15 revisions. Do you know of any?
> >=20
> > I'm not aware of such a lecture.
>=20
> I thought you were doing one at FOSDEM!

Oh that knowledge already spread? Anyhow that doesn't help you today
:-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6gsm32m6fyt25ymx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO+fi0ACgkQwfwUeK3K
7AklXAf/WNPDNf10f5a7E1fnSiX74OV7ET+g8/DfocYVDgMGuXcplwCLnXNk6a05
iD98QEPw3H4wH5bMGsEMhJ8gFWvvmbF+T0U62n0EpKIo9OlB30ICh8lSOnbTsrJw
KLbfjnk0pLWMnkA5QD3RHOli7WIP5d8RIUNDuufetrwEJCPuu2p7vvpkEBgSlvbX
S5SswsoTW5v82AeDhudq3lQkahbqOOVXG2IQoU+QozB+8gFaKZi6UL7ZpZ1+RUB8
f9UuLZZAVt2sOWEh9K6SxOhqxl28FXVUQuLvN/r8TPEoPPWM0BBYs7vhM6znP3I3
qfYSJ89UqAR4MbjXsrETyVbThuRvkQ==
=HCWT
-----END PGP SIGNATURE-----

--6gsm32m6fyt25ymx--
