Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF06C353B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCUPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCUPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:12:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE73864F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:12:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pedeY-0006wY-W4; Tue, 21 Mar 2023 16:11:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pedeY-005ije-B3; Tue, 21 Mar 2023 16:11:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pedeX-006n6j-Je; Tue, 21 Mar 2023 16:11:57 +0100
Date:   Tue, 21 Mar 2023 16:11:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v1] .mailmap: add entry for Leonard =?utf-8?B?R8O2aHJz?=
Message-ID: <20230321151157.5uu7ezvso4pcznzt@pengutronix.de>
References: <20230321145525.1317230-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7u3zscmdbmjyirh"
Content-Disposition: inline
In-Reply-To: <20230321145525.1317230-1-l.goehrs@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n7u3zscmdbmjyirh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 03:55:25PM +0100, Leonard G=F6hrs wrote:
> My very first kernel commit:
>=20
>   e4e1d47c7906 ("ALSA: ppc: remove redundant checks in PS3 driver probe")
>=20
> was sent with the umlaut in my last name transcribed (G=F6hrs -> Goehrs).
>=20
> Add a mailmap entry so all my commits use the same name.
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n7u3zscmdbmjyirh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQZyTwACgkQj4D7WH0S
/k6mEgf/bnSA8IeKAjQVaLBvKg2n2PfHQoi4x6ngAD0IKq5767J2Ydwy+fbwcKGV
Np+9mlKPhXbKOu2tQm0p/lM75dTKYH/5ehqetTrC+icdwmQAMsm6zHEVrjpqJ7aF
nJwz8PfvEa5eA1640MKIM1eZsKUbKHJDVo+BdLyMa6QnYKQSaOEkKm9LRTetccVC
fdS2I+ALHqhXOH64MHFy1BVRaxAylWz5yuzk5nCLFXSVgzfLMIr9yQmJevgRiH9S
6ppa1Tn0cTv6hwTPGePzU5BuZL1TcouPGQtjSr4W78+1WKIhnVcbbkU7mSGJZXMi
uAk3gU6na566KiI9uTGYPSn5wIHKEA==
=+dR+
-----END PGP SIGNATURE-----

--n7u3zscmdbmjyirh--
