Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323235E8B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiIXKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIXKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:05:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD0FA0E3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:05:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc22i-0000tq-Ry; Sat, 24 Sep 2022 12:05:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc22j-002chF-GV; Sat, 24 Sep 2022 12:05:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc22h-003By3-9d; Sat, 24 Sep 2022 12:05:51 +0200
Date:   Sat, 24 Sep 2022 12:05:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 5/9] pwm: lpss: Use device_get_match_data to get
 device data
Message-ID: <20220924100548.pezwsw7k7acmtnok@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhonvq75h552opqb"
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-6-andriy.shevchenko@linux.intel.com>
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


--jhonvq75h552opqb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 04:56:54PM +0300, Andy Shevchenko wrote:
> device_get_match_data() in ACPI case calls similar to the
> acpi_match_device(). We may simplify the code and make it
> generic by replacing the latter with the former.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jhonvq75h552opqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMu1nkACgkQwfwUeK3K
7AnlzAf/f/RnI2PpHy3+KLcE+C55gbaKKNaMobR21VOrrdZrRLyMtPfA2cUHJQr3
2+FLTgtFOhFONujKZMzEWn8x/b4GBZVqubCdihn44KSHR0FXpQ9fUBGsnEIiGdn8
/vg4u5o/abskAMPvyEN04KIFoIQ6mvSXDk6oAUL/gWGgPi2qE/1F1gclv7Y9YgCP
gUXbqtBBXJJMSvGVF65XE/CEW2Mrv76jcd4isXhXQFZhNUmdwqlaDlaXWZ/iM+l6
dHDIh98vJgQ+33hPQqOnjH0JuFlZOHm4X/K/aWanED2GjgVaJNYa60yrT8puMPEA
U0HfpDQgLgh4di3lmE5vT2Lhm6Hyzg==
=LKiH
-----END PGP SIGNATURE-----

--jhonvq75h552opqb--
