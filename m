Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E442716719
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjE3Pbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjE3Pba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:31:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0895DBE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:31:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q41Jd-0001Dl-UW; Tue, 30 May 2023 17:31:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q41Jc-003uHn-V1; Tue, 30 May 2023 17:31:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q41Jc-009Xg1-2o; Tue, 30 May 2023 17:31:16 +0200
Date:   Tue, 30 May 2023 17:31:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/imx-gpt: Use only a single name for
 functions
Message-ID: <20230530153115.fpjgg6ubqjrbn73r@pengutronix.de>
References: <20230328091514.874724-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45ksup5wl6ujl7av"
Content-Disposition: inline
In-Reply-To: <20230328091514.874724-1-u.kleine-koenig@pengutronix.de>
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


--45ksup5wl6ujl7av
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Helo Daniel,

On Tue, Mar 28, 2023 at 11:15:14AM +0200, Uwe Kleine-K=F6nig wrote:
> When looking at the data structs defining the different behaviours of
> the GPT blocks in different SoCs it's not helpful that the same
> functions are used with different names.
>=20
> So drop the cpp defines and use the original names.
>=20
> This commit was generated using:
>=20
> 	perl -i -e 'my %m; while (<>) { if (/^#define (imx[a-zA-Z0-6_]*)\s(imx[a=
-zA-Z0-6_]*)/) {$m{$1} =3D $2; } else { foreach my $f (keys %m) {s/$f/$m{$f=
}/; } print; } }' drivers/clocksource/timer-imx-gpt.c
>=20
> This patch has no effect on the generated code.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch was generated against v6.3-rc1. On the upside it still
applies fine to v6.4-rc1 and even current next/master. On the downside I
didn't get any feedback on it. Is this patch still on your radar?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--45ksup5wl6ujl7av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR2FsMACgkQj4D7WH0S
/k7tDgf+Ps4cKXwCQQ104nlF6rNbXfTYDedYM2GQlYd5awgX6F5ZpHBswAhZsSER
lzyAkAsTJyEY8IoUBFO9X8q+85itCr59Qz+1kHW6AVuf81T7R0QWAiXBHN+Xiu8Q
6rRgvyPjpvSN9MSxW/1uzOzBztjiLltksqfHr6DOgIn1Z2mEstIEPjlsS+wzv71m
28k4Byldr04qPkNeO7a3KiMOSUKzth6mGJZMmSjoJnYCBUIEuAupKs/95UgGw+4H
BMpjZhSzH2RTMK0MOmz9O2HHS1uw0idx/QxOuZM+AXouDYey9oSFP15V1vbCF7BZ
kzxcntMpvAADrevB0n1Uq68ufem4xA==
=5Mdu
-----END PGP SIGNATURE-----

--45ksup5wl6ujl7av--
