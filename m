Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1E623CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiKJHiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKJHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:38:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99119B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:38:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot28v-0001tJ-Hq; Thu, 10 Nov 2022 08:38:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot28t-003PEh-Dn; Thu, 10 Nov 2022 08:38:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot28t-00FaO3-9c; Thu, 10 Nov 2022 08:38:31 +0100
Date:   Thu, 10 Nov 2022 08:38:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/6] pwm: lpss: Add pwm_lpss_probe() stub
Message-ID: <20221110073831.ggudvgl6jzgbo2vb@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c2ikj363pkmkwzsq"
Content-Disposition: inline
In-Reply-To: <20221108142226.63161-6-andriy.shevchenko@linux.intel.com>
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


--c2ikj363pkmkwzsq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 04:22:25PM +0200, Andy Shevchenko wrote:
> In case the PWM LPSS module is not provided, allow users to be
> compiled with a help of a pwm_lpss_probe() stub.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  include/linux/platform_data/x86/pwm-lpss.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/p=
latform_data/x86/pwm-lpss.h
> index 296bd837ddbb..c868b396ed2c 100644
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
>  struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *b=
ase,
>  				     const struct pwm_lpss_boardinfo *info);
> +#else
> +static inline
> +struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *b=
ase,
> +				     const struct pwm_lpss_boardinfo *info)
> +{
> +	return ERR_PTR(-ENODEV);

Would it be more consistent to return the same value as the pwmchip_add
stub does?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c2ikj363pkmkwzsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNsqnQACgkQwfwUeK3K
7Akn9wf9H/bc8ldHeuoeAwBk70DIIRDsgQ1NPv2mRbmhXfgZR4IffDdmU/OqZFPo
jWCw2AUBKxMOMW8wzmhdYkUd183UYX0eAIvW1PFkuZk3shrGkiV/XMh2MVfR/8FT
owv6sQ7VCcPWgy6fBkACC1hQy/7gdoyIUaRXySDwlBd0Krj3FMhYQHR1Wv1vhCrJ
V4Grgfym9zH99n1cBFro6x3QW9KAx27W9yjCZoymuNnbHVpB7OnkvJrJNj/w4O59
YPiuNjtVPZvmTZKvnpmOxFCHM+5VfWp0nhV4capqArNjD2pqSK8+f645Jkl6vgoe
nnrEX+PYEGHdmCjmVcgVNeAXmWMiGQ==
=LgpM
-----END PGP SIGNATURE-----

--c2ikj363pkmkwzsq--
