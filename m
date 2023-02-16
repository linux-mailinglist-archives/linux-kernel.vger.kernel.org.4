Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAEC699F09
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBPVeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBPVeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:34:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439724C3FF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:34:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSltC-0006tf-NA; Thu, 16 Feb 2023 22:34:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSltA-005RFo-8Z; Thu, 16 Feb 2023 22:34:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSltA-0048nA-I1; Thu, 16 Feb 2023 22:34:00 +0100
Date:   Thu, 16 Feb 2023 22:33:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v7 07/10] pwm: dwc: make timer clock configurable
Message-ID: <20230216213358.6f4jljom2dduqroa@pengutronix.de>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <20221223153820.404565-8-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36b3bowq6mlmgiap"
Content-Disposition: inline
In-Reply-To: <20221223153820.404565-8-ben.dooks@sifive.com>
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


--36b3bowq6mlmgiap
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2022 at 03:38:17PM +0000, Ben Dooks wrote:
> Add a configurable clock base rate for the pwm as when being built
> for non-PCI the block may be sourced from an internal clock.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--36b3bowq6mlmgiap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPuoUMACgkQwfwUeK3K
7AnR9Af/crQHqsN0SX2Kb44nAkY5ubApKUTq1eZKOFYC0CZsE5PB/Q+0FXcCzXqc
xDTYD80vxcP477YUa0NufCblXjgcudBI0bvP4WGIPEPV8L3Z+8hvHBXmErEZjoYE
wb4qM/shLbcO6xOY5I8mWev69GUnpGcz25+bFSgsgPXRCpeZXVr8visVKr7+txoX
uX2uY9ha+F7FfOdqoigQyZH1L+hBlUkhxOooUmofGMeneDMKctUnlxKXsNYCV8WY
JAqhbiNVky/ZuFt6RXwaSWvnnwQibu66V33aKmKKd2gOr5dPRB7Wzl1R8diHhKe5
EO8bkVjlXsbC5gtGzcjGJ86JCWfQaA==
=oejy
-----END PGP SIGNATURE-----

--36b3bowq6mlmgiap--
