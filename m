Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61586E823B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDST6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDST6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:58:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781326B5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:58:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ppDwR-0005x6-CV; Wed, 19 Apr 2023 21:58:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ppDwM-00CPGS-AB; Wed, 19 Apr 2023 21:58:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ppDwL-00Eat3-Ez; Wed, 19 Apr 2023 21:58:05 +0200
Date:   Wed, 19 Apr 2023 21:58:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Lin <CTLIN0@nuvoton.com>, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>, Peter Rosin <peda@axentia.se>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: nau8825: fix delay time range check
Message-ID: <20230419195805.fpil775pw2wsrav4@pengutronix.de>
References: <20230419114546.820921-1-arnd@kernel.org>
 <c6bc42c6-4a98-4bb6-9639-acf4c2010b68@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k7olzqvscnyzsee5"
Content-Disposition: inline
In-Reply-To: <c6bc42c6-4a98-4bb6-9639-acf4c2010b68@sirena.org.uk>
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


--k7olzqvscnyzsee5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2023 at 12:48:52PM +0100, Mark Brown wrote:
> On Wed, Apr 19, 2023 at 01:45:39PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > clang points out that the recently added range check is nonsensical:
>=20
> Someone already sent a patch for tihs.

FTR: https://lore.kernel.org/r/20230418120955.3230705-1-trix@redhat.com

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k7olzqvscnyzsee5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRAR8wACgkQj4D7WH0S
/k4TkQf/T0DEUGoTk9H/hfDu9v/xHFjLghN1ZIsuA02IHW/nDmfHyCGX1I51xV/d
5zX4GHGk4AyO+qJ27KYo9K0Fj/TJKQEuR8cws86p8uqLztxDuRSLFhusRKpCjcpU
33uann83bN3tSs3cvFUuRLt/bJ/Juc4SHKKWicYvraDRHnLCKgKTZwEQDBhBFa1f
TfVZ7m1RnqSLvv4dpJ+I1IwMCVh7Q01wBM1EHSDDoit/OeyVlrkdQb13Ojz1sYs2
yzhWzY+pEEY/X+1pHmsOZUO+IWHDnlQRf2AsqDhFbA3DEf1QTqb0SWZBZeIeffeE
T7gPx9FOH5kgFoPxHly+IWO1SLLXLg==
=SxS9
-----END PGP SIGNATURE-----

--k7olzqvscnyzsee5--
