Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4777D623C59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiKJHHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiKJHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:07:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F827B3C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:07:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1ej-0006Ue-Ex; Thu, 10 Nov 2022 08:07:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1eg-003Omm-Vx; Thu, 10 Nov 2022 08:07:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1eh-00FZqn-40; Thu, 10 Nov 2022 08:07:19 +0100
Date:   Thu, 10 Nov 2022 08:07:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/6] pwm: Add a stub for devm_pwmchip_add()
Message-ID: <20221110070718.bqpam7h3hjf2hkip@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbekflahz2byd2ag"
Content-Disposition: inline
In-Reply-To: <20221108142226.63161-2-andriy.shevchenko@linux.intel.com>
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


--hbekflahz2byd2ag
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello=20

On Tue, Nov 08, 2022 at 04:22:21PM +0200, Andy Shevchenko wrote:
> devm_pwmchip_add() can be called by a module that optionally
> instantiates PWM chip. In case of CONFIG_PWM=3Dn, the compilation
> can't be performed. Hence, add a necessary stub.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  include/linux/pwm.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d70c6e5a839d..bba492eea96c 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -478,6 +478,11 @@ static inline int pwmchip_remove(struct pwm_chip *ch=
ip)
>  	return -EINVAL;
>  }
> =20
> +static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *=
chip)
> +{
> +	return -EINVAL;
> +}
> +

I'm a bit surprised to see this returning -EINVAL and not -ENOSYS. But
that's in line with the other stubs, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hbekflahz2byd2ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNsoyQACgkQwfwUeK3K
7AkwtAgAlngwWjscEhoQXRiD28VBXc9a5O4+98O/r+kYB2f4/9rN6+2ET0CWOpzd
8KDQ9B5IuGoSKhII3IwDcM4rRDI3DwECHp23BbLQL6NXjgxtw3eYZ7hJwUDEXpRE
85aPp4cSqFMMkEpCOx8dLnj6rRxrR+l2kmsonH8ZpOM38kVvvkpD8+UPKFL7X/Kj
ENy05dR+v2QEWE1UzYNuHHxWS3D61v9+H2Ae2DGHI0JH9+24hSTLwYvAE4SivcIY
O1mTM7pKNsoFuCORxf1Vit/f8ZDWD+3miMg0cfIU0AgqxaPACkZpjf/7CZ99WjJr
okFGA+bWbJp7tPxqjDpAhJPJTb7Ctw==
=4ga8
-----END PGP SIGNATURE-----

--hbekflahz2byd2ag--
