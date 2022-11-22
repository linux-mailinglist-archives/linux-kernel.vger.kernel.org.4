Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521BB6341DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiKVQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiKVQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:48:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFCB6A68E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:48:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxWQM-0006Ic-4f; Tue, 22 Nov 2022 17:47:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxWQK-005t7P-10; Tue, 22 Nov 2022 17:47:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxWQJ-000q57-MW; Tue, 22 Nov 2022 17:47:03 +0100
Date:   Tue, 22 Nov 2022 17:47:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 6/7] pwm: lpss: Add devm_pwm_lpss_probe() stub
Message-ID: <20221122164703.e3z42rou7ivu3djv@pengutronix.de>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
 <20221117110806.65470-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rb5tprcr5gddrgn6"
Content-Disposition: inline
In-Reply-To: <20221117110806.65470-7-andriy.shevchenko@linux.intel.com>
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


--rb5tprcr5gddrgn6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 01:08:05PM +0200, Andy Shevchenko wrote:
> In case the PWM LPSS module is not provided, allow users to be
> compiled with the help of the devm_pwm_lpss_probe() stub.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  include/linux/platform_data/x86/pwm-lpss.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/p=
latform_data/x86/pwm-lpss.h
> index c852fe24fe2a..6ef21b8baec7 100644
> --- a/include/linux/platform_data/x86/pwm-lpss.h
> +++ b/include/linux/platform_data/x86/pwm-lpss.h
> @@ -4,6 +4,8 @@
>  #ifndef __PLATFORM_DATA_X86_PWM_LPSS_H
>  #define __PLATFORM_DATA_X86_PWM_LPSS_H
> =20
> +#include <linux/err.h>
> +#include <linux/kconfig.h>
>  #include <linux/types.h>
> =20
>  struct device;
> @@ -27,7 +29,16 @@ struct pwm_lpss_boardinfo {
>  	bool other_devices_aml_touches_pwm_regs;
>  };
> =20
> +#if IS_REACHABLE(CONFIG_PWM_LPSS)
>  struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iom=
em *base,
>  					  const struct pwm_lpss_boardinfo *info);
> +#else
> +static inline
> +struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iom=
em *base,
> +					  const struct pwm_lpss_boardinfo *info)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +#endif	/* CONFIG_PWM_LPSS */

Hmm, this is actually never used, because if
!IS_REACHABLE(CONFIG_PWM_LPSS), the only caller (that is added in patch
7) has:

	if (!IS_REACHABLE(CONFIG_PWM_LPSS))
		return 0;

before devm_pwm_lpss_probe() is called.

Not sure if it's safe to just drop this patch. The return value is
neither -ENOSYS (which I would expect for a stub function like that) nor
-EINVAL (which for reasons unknown to me is used in the stub for
pwmchip_add()).

I would have a better feeling with -ENOSYS in your stub, but I don't
feel really strong here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rb5tprcr5gddrgn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN8/QEACgkQwfwUeK3K
7AljCgf9H8/JxkHipEZ8Aa79BqTgZHZ1aAEQGc0UHy6EhjUXQfsBafl8GepzjEJK
P0NYAWNFQPaGmrJ6sXkK2F3SQiSK6wg6ByzxqxIkA/6mgR7wOMlRHy+wHdlZRx2O
oz+tNuuPGbNaoI4b3Cb0SpZ4WdkhbSSQQPowk6iKyHKsGEkj65bgR5Vepz03SeDO
4tTECcpqTPkqKmeWf9zu0FScFybpLDv2qhhzVtDrXelYAhRIysd/NawvEcf6QN0t
3+Ex63Kr/lof0zOEyNDXxqzJcfvu7PfssPhKk/Tkcy3aRjBYIjyXDZkBlGI2UI7P
KhY11oGTg82MSaWbbMhTQeJuGCDtzQ==
=FMlB
-----END PGP SIGNATURE-----

--rb5tprcr5gddrgn6--
