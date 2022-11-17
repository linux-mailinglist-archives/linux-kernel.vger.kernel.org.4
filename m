Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742AB62D457
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiKQHpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiKQHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:45:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4E45ED9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:45:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovZaH-0000v6-1X; Thu, 17 Nov 2022 08:45:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovZaC-004o5M-UR; Thu, 17 Nov 2022 08:45:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovZaD-00HDqE-7v; Thu, 17 Nov 2022 08:45:13 +0100
Date:   Thu, 17 Nov 2022 08:45:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 3/3] hwmon: (max6639) Change from pdata to dt
 configuration
Message-ID: <20221117074510.qqtjc6h3bnh5rccx@pengutronix.de>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
 <20221116213615.1256297-4-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ka6u4pp26b6usojr"
Content-Disposition: inline
In-Reply-To: <20221116213615.1256297-4-Naresh.Solanki@9elements.com>
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


--ka6u4pp26b6usojr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 16, 2022 at 10:36:15PM +0100, Naresh Solanki wrote:
> max6639_platform_data is not used by any in-kernel driver and does not
> address the MAX6639 fans separately.
> Move to device tree configuration with explicit properties to configure
> each fan.
>=20
> Non-DT platform can still use this module with its default
> configuration.
>=20
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

What changed here since v5? Please either add a changelog below the
tripple-dash for a new revision, or make sure that all relevant people
get the cover letter.

It seems you didn't address my comments for v5 :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ka6u4pp26b6usojr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN15oMACgkQwfwUeK3K
7AmqXAf/VDOQ7mnov3rgf8/GY+ERfUHmK13LG3T9l7PjEcDOYnnBpmjIfb46EAQe
knIQpR4Hur3Oy6TDvQ6BEzNeqaY8uelToGLeQCPY629HPd8nBGDTOf49A7eAWKdv
UhhNkqPWZZSEpGN989ITsutCS3KklmdROR7mQbSLBvU+dMb5bhVgDz1vkNxa9aJ1
p5hWQjSPWnYOW8ZI0UfXgkCESDdOASeuPhxRq2YX/GM7gUgiJlUD9vm40xAt2N8v
p8FxVsEBJPw4b8+AZmdEz/EjrOjdmqRrsiEbyk0Ik65U+w3jopKq5Is9HyR8BJBo
ewRscdLuuLMT9Xsq3IaRYhwfhXet6w==
=HbtU
-----END PGP SIGNATURE-----

--ka6u4pp26b6usojr--
