Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1531A5F0CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiI3Nsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiI3Nsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:48:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C0083F06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:48:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGNk-0006BJ-9U; Fri, 30 Sep 2022 15:48:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGNj-003oQC-Po; Fri, 30 Sep 2022 15:48:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeGNh-004g9f-JT; Fri, 30 Sep 2022 15:48:45 +0200
Date:   Fri, 30 Sep 2022 15:48:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Message-ID: <20220930134845.ivmme6vwcluezmt5@pengutronix.de>
References: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
 <YzbdmJvcPiYAIalt@alley>
 <20220930132424.wnnrs4bpwiuukclk@pengutronix.de>
 <YzbyWL7rZhLUOjTR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yzcnse57zp3ulxfq"
Content-Disposition: inline
In-Reply-To: <YzbyWL7rZhLUOjTR@smile.fi.intel.com>
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


--yzcnse57zp3ulxfq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 04:42:48PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 30, 2022 at 03:24:24PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Sep 30, 2022 at 02:14:16PM +0200, Petr Mladek wrote:
> > > On Fri 2022-09-30 13:10:50, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > > If get_bla() returns NULL then it means a super fault. It means
> > > that get_bla() failed and did not know why.
> >=20
> > OK, I think we agree that a function that might return an error pointer
> > shouldn't return NULL with the semantic "This is also an error."
>=20
> But it neither means "success".

Have you read and understood the patch and the discussion?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yzcnse57zp3ulxfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM287oACgkQwfwUeK3K
7Aketgf/TFoAr/z/039cTDlIJ2EF6lDigWWLk3XmbSvCdNyKNoLKrvDiLYoYfQYE
i9KMombY6D0t35Nx9uOtHEyVVDB9sB9jFMZqeD/SaOJfj1631T2xOiu8tB5PGQED
5ReCjlamWNDwNu5sZuRXB5mxgq3Cn7duZOyfRW/3JomcoPTf2DFlidNDyObsXpXr
SEuifYiXpAG59lVzbR3rp358Ho0JM/Q8W5yG4kJqviElQkqKMcC6Dp0cZdJSxK0i
5MtBbutourN2OVfLVajtKxBhmBm3eZwVIB1kgQAoz9qn2ffj9nWMI+4yrF/0EusV
z5nLNfp9op+K8ViYsawe2KNgq6+E/w==
=UdGL
-----END PGP SIGNATURE-----

--yzcnse57zp3ulxfq--
