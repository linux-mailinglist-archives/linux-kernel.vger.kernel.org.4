Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39863A2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiK1IY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiK1IYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:24:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADBBD72
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:24:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZRS-0005PL-St; Mon, 28 Nov 2022 09:24:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZRR-000mOL-0D; Mon, 28 Nov 2022 09:24:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZRR-000sND-57; Mon, 28 Nov 2022 09:24:41 +0100
Date:   Mon, 28 Nov 2022 09:24:41 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: sifive: Always let the first pwm_apply_state
 succeed
Message-ID: <20221128082441.wsqcpuxqk6cynako@pengutronix.de>
References: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
 <20221109120102.ylnseq2w33rvt7fz@pengutronix.de>
 <CAJM55Z-EVXB6FTWwh_vY_B3LoVv+b7TCQCE7asB8G8wkEwui_g@mail.gmail.com>
 <20221109153311.cszr7fgfmyelwra3@pengutronix.de>
 <CAJM55Z8vpJ0XtQqnsFMLE4rkyV11ePbNjtYx0u4pgM9-MT=Kvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaygonhhwcbbtokq"
Content-Disposition: inline
In-Reply-To: <CAJM55Z8vpJ0XtQqnsFMLE4rkyV11ePbNjtYx0u4pgM9-MT=Kvg@mail.gmail.com>
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


--kaygonhhwcbbtokq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 16, 2022 at 06:41:06PM +0100, Emil Renner Berthing wrote:
> On Wed, 9 Nov 2022 at 16:33, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Nov 09, 2022 at 01:45:43PM +0100, Emil Renner Berthing wrote:
> > > How about we merge this bug fix that can easily be backported first
> > > and then look at how it should be handled properly?
> >
> > I thought it wouldn't be that hard to do it right from the start,
> > but I admit it's harder than I expected to get right. My prototype looks
> > as follows:
>=20
> This works for me (modulo the two extra {'s). I'd still prefer merging

Yeah, didn't even try to compile it.

> the simpler version and then this on top for ease of backporting, but
> as long as the race is fixed I'm fine. Will you send a cleaned up
> version of this?

I'd let Thierry decide what he want here. Depending on his choice I can
clean up my suggestion (inclusive compile test) on the then relevant
state of the driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kaygonhhwcbbtokq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEcEUACgkQwfwUeK3K
7AnD8gf/dT+Idh5F//NM08TsmrSjFwGL4iPC9RfTbR+drkH+TzqExwotU0ZXtyez
PP7g1a7fBGQyKwwXxmk56rPjoxw4XQIHKdnodzgu8PajwgKKdjTNBhd3HZHUx8I+
2vA+/X60pzU/HBAuXkHm8wLj0BoShsgQYEclABI92tJKbUiM+46D0bTQjAXgrFcf
xT4HrrftNnRB1cdjyD2DJdBSgVZBkr62NJf1LVklhnxMtmwXPHtROWfJqOZsIJBc
drH9DgITkhN6r5oIQtpQ+idbxKYdU137CNSbGbWIFDgwAeammcyPqxXjeVQnk9oT
RcGUSJSsXZ7y5O2nm4FJtqsgl1qjMQ==
=cKDE
-----END PGP SIGNATURE-----

--kaygonhhwcbbtokq--
