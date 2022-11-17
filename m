Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48162D5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiKQJGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiKQJGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:06:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2B58BCB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:06:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovaqV-0004HD-N6; Thu, 17 Nov 2022 10:06:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovaqT-004p0y-Tx; Thu, 17 Nov 2022 10:06:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovaqT-00HEYW-UH; Thu, 17 Nov 2022 10:06:05 +0100
Date:   Thu, 17 Nov 2022 10:06:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 7/7] pinctrl: intel: Enumerate PWM device when
 community has a capability
Message-ID: <20221117090605.ktgyaverpzl3irjo@pengutronix.de>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
 <20221114165545.56088-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmyufltz4xble7qf"
Content-Disposition: inline
In-Reply-To: <20221114165545.56088-8-andriy.shevchenko@linux.intel.com>
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


--jmyufltz4xble7qf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 14, 2022 at 06:55:45PM +0200, Andy Shevchenko wrote:
> Some of the Communities may have PWM capability. In such cases,

Is "Communities" is proper name in this context? If not, I'd not
capitalize it.

> enumerate the PWM device via respective driver. User is still

s/User/A user/ ?

> responsible for setting correct pin muxing for the line that
> needs to output the signal.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/inte=
l/pinctrl-intel.c
> index 52ecd66ce357..d61c22e9d531 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -21,6 +21,8 @@
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinconf-generic.h>
> =20
> +#include <linux/platform_data/x86/pwm-lpss.h>
> +
>  #include "../core.h"
>  #include "pinctrl-intel.h"
> =20
> @@ -46,6 +48,8 @@
>  #define PADOWN_MASK(p)			(GENMASK(3, 0) << PADOWN_SHIFT(p))
>  #define PADOWN_GPP(p)			((p) / 8)
> =20
> +#define PWMC				0x204
> +
>  /* Offset from pad_regs */
>  #define PADCFG0				0x000
>  #define PADCFG0_RXEVCFG_SHIFT		25
> @@ -1499,6 +1503,30 @@ static int intel_pinctrl_pm_init(struct intel_pinc=
trl *pctrl)
>  	return 0;
>  }
> =20
> +static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
> +				   struct intel_community *community)
> +{
> +	static const struct pwm_lpss_boardinfo info =3D {
> +		.clk_rate =3D 19200000,
> +		.npwm =3D 1,
> +		.base_unit_bits =3D 22,
> +		.bypass =3D true,
> +	};
> +	struct pwm_lpss_chip *pwm;
> +
> +	if (!(community->features & PINCTRL_FEATURE_PWM))
> +		return 0;
> +
> +	if (!IS_REACHABLE(CONFIG_PWM_LPSS))
> +		return 0;
> +
> +	pwm =3D devm_pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
> +	if (IS_ERR(pwm))
> +		return PTR_ERR(pwm);
> +
> +	return 0;

The last 3 codelines can be replaced by

	return PTR_ERR_OR_ZERO(pwm);

(but I know it's subjective if you like that or not, so I won't insist;
see also b784c77075023e1a71bc06e6b4f711acb99e9c73).

> +}
> +
>  static int intel_pinctrl_probe(struct platform_device *pdev,
>  			       const struct intel_pinctrl_soc_data *soc_data)
>  {
> @@ -1584,6 +1612,10 @@ static int intel_pinctrl_probe(struct platform_dev=
ice *pdev,
>  			ret =3D intel_pinctrl_add_padgroups_by_size(pctrl, community);
>  		if (ret)
>  			return ret;
> +
> +		ret =3D intel_pinctrl_probe_pwm(pctrl, community);
> +		if (ret)
> +			return ret;
>  	}
> =20
>  	irq =3D platform_get_irq(pdev, 0);

intel_pinctrl_add_padgroups_by_size() doesn't need cleanup in the error
path, so this hunk is fine.

All in all this is all very minor, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

even if you keep the patch as is.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jmyufltz4xble7qf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN1+XoACgkQwfwUeK3K
7An41Qf9H02Ebbtnsoac/a/Q2UCAszSvtVhYehJVq0uC9RJYSyNVchLpxavRk4rV
NGb6mfjl7A6OgS1gqoyQtqt0VP64FGKlp9YTNA+1AJvl6lvwcyNqgQ4nN3slp0pj
sennz3ouKLREc3mSorDAz1tgr09xqU9etJYHDPUo4oipv74QGFT6KjWqr9bVE/yR
5b1LYYvy8to+/tQwwt8FdnJmiP7TrtNz6LcEAH6BmmKw4/bMFFHAshHVlZTvINVZ
q/D+qqzfrvD2evY/LOopcOCdl9movJwkltHbHhsJ4qODZjTIj2oJ39O9PgVf5V7V
+1Vi14LTUaPMblRWJe7tNhCP2H9v0g==
=TlVN
-----END PGP SIGNATURE-----

--jmyufltz4xble7qf--
