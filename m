Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8365B6EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjABTWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjABTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:22:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13173B7EE;
        Mon,  2 Jan 2023 11:22:08 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 295B96600366;
        Mon,  2 Jan 2023 19:22:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672687327;
        bh=ax85ysWHxGBboN/YbL/BniKZvLGAF1s7cHi/6Es2iL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiWCmoLFB61xPaZRXra8T62Tr+N0vCOXpJpx5CkKDpa6taqF/Bgv/jcBhiiyW/QsH
         XulqguF7e5fKvWWEvMXLyX6iZcB28mjhXg4+kwnQNpaPXRi8xS/LQlgIiNldl3Ff75
         Rvc4O3VdJiv7wAlQoecPYZTLqtaqbw4x8TNNHz/9F/mJI+D5SfX87hZrUZbOROVpv9
         vC/aAS8/iUX1qxnuMzGBA/JwsMfxl9/F0qih7dDxpVD1P3GwP7ZGAyu7vezS0OEy2J
         3vbtidmWOivdjXoSHUCmv9vYv7VVy9zwCvfiy1u3H0+sOHclsqBCoAbVl52n2wdjV5
         /PSNaGzXAeyhQ==
Received: by mercury (Postfix, from userid 1000)
        id 7C76A106076E; Mon,  2 Jan 2023 20:22:04 +0100 (CET)
Date:   Mon, 2 Jan 2023 20:22:04 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v2 4/4] power: reset: Add new driver for RZ/V2M PWC
 poweroff
Message-ID: <20230102192204.hcqhtrl5gbpuqhyd@mercury.elektranox.org>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-5-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gildbygudiea755e"
Content-Disposition: inline
In-Reply-To: <20221221210917.458537-5-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gildbygudiea755e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 21, 2022 at 09:09:17PM +0000, Fabrizio Castro wrote:
> The RZ/V2M PWC IP controls external power supplies and therefore
> can turn the power supplies off when powering down the system.
>=20
> Add driver to poweroff the system.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> v1->v2: Dropped OF match table and syscon as a result of the change in
>         DT model
>=20
>  drivers/power/reset/Kconfig              |  9 ++++
>  drivers/power/reset/Makefile             |  1 +
>  drivers/power/reset/rzv2m-pwc-poweroff.c | 67 ++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
>  create mode 100644 drivers/power/reset/rzv2m-pwc-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index a8c46ba5878f..1fcf691ae68e 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -303,4 +303,13 @@ config POWER_MLXBF
>  	help
>  	  This driver supports reset or low power mode handling for Mellanox Bl=
ueField.
> =20
> +config POWER_RESET_RZV2M_PWC
> +	tristate "Renesas RZ/V2M PWC Power OFF support"
> +	depends on MFD_RZV2M_PWC_CORE || COMPILE_TEST
> +	help
> +	  The RZ/V2M PWC IP controls external power supplies and therefore can
> +	  turn the power supplies off when powering down the system.
> +	  Enable this driver when PWC is in control of the system power supplies
> +	  and it's the preferred way to shutdown the system.
> +
>  endif
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 0a39424fc558..f05a8abff2eb 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -36,3 +36,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mod=
e.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
> +obj-$(CONFIG_POWER_RESET_RZV2M_PWC) +=3D rzv2m-pwc-poweroff.o
> diff --git a/drivers/power/reset/rzv2m-pwc-poweroff.c b/drivers/power/res=
et/rzv2m-pwc-poweroff.c
> new file mode 100644
> index 000000000000..f5bc383c22e1
> --- /dev/null
> +++ b/drivers/power/reset/rzv2m-pwc-poweroff.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Reset driver for Renesas RZ/V2M External Power Sequence Controller (P=
WC)
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include "../../mfd/rzv2m-pwc.h"
> +
> +#define PWC_PWCRST_RSTSOFTAX		0x1
> +#define PWC_PWCCKEN_ENGCKMAIN		0x1
> +#define PWC_PWCCTL_PWOFF		0x1
> +
> +struct rzv2m_pwc_poweroff_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +};
> +
> +static int rzv2m_pwc_poweroff(struct sys_off_data *data)
> +{
> +	struct rzv2m_pwc_poweroff_priv *priv =3D
> +		(struct rzv2m_pwc_poweroff_priv *)data->cb_data;
> +
> +	writel(PWC_PWCRST_RSTSOFTAX, priv->base + PWC_PWCRST);
> +	writel(PWC_PWCCKEN_ENGCKMAIN, priv->base + PWC_PWCCKEN);
> +	writel(PWC_PWCCTL_PWOFF, priv->base + PWC_PWCCTL);
> +
> +	mdelay(150);
> +
> +	dev_err(priv->dev, "Failed to power off the system");
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int rzv2m_pwc_poweroff_probe(struct platform_device *pdev)
> +{
> +	struct rzv2m_pwc_priv *pdata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct rzv2m_pwc_poweroff_priv *priv;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D pdata->base;
> +	priv->dev =3D &pdev->dev;
> +
> +	return devm_register_power_off_handler(&pdev->dev, rzv2m_pwc_poweroff,
> +					       priv);
> +}
> +
> +static struct platform_driver rzv2m_pwc_poweroff_driver =3D {
> +	.probe =3D rzv2m_pwc_poweroff_probe,
> +	.driver =3D {
> +		.name =3D "rzv2m_pwc_poweroff",
> +	},
> +};
> +module_platform_driver(rzv2m_pwc_poweroff_driver);
> +
> +MODULE_ALIAS("platform:rzv2m_pwc_poweroff");
> +MODULE_SOFTDEP("pre: rzv2m_pwc");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/V2M PWC power OFF driver");
> --=20
> 2.34.1
>=20

--gildbygudiea755e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzLtQACgkQ2O7X88g7
+prTTg/9HkvNJVx9BOHDiQcRZH+EsFjNs11wFNtFgW/M/6FE6hk02XJ5BU0QqBze
wDCZD98NCE/rQqjJGFSMxwrZI+i5zm6caKEB1+A+55CJ3EMcEW/XhmfMFYEZk4qC
Rb7mC/jZMpYKc5jrGuMSFu6OIlHda50InxsanXGpSPb42/fShElu6MrtqqAzhmWB
+MMfFV6Wv6nI6Qk3RgAi48VtHCOr5Ue3RziJTAwryLloqJoEZgIJksI2c7j+Qj+9
tgHAOOrSQ9XdOU/aexM74/RvM+Eej7nh0jat+YtSpVQSKRClH9G+nXsR1jG9oxVk
bLPxYv0veN90V522p5ZG/c19ZWurgBtrzaK+LrlmH29yAv4Z30UXLQcS77SGZdjx
ytwBV/wYLyv3r3piSm/XySuMmtk+Jsa6LPZkYI4OLathsQQ4U/nqdBhWVttbz5f8
2C+xdmHlYuBy5JY1ZMW1U4ReJRbXfpT9bgrpsAn0POGckjqIaRwIa/Huobpbwrbp
ov+J/UcivMNjHveglfxSC/zB8eNCyQfvYPXbsBp+FPjWVHGuHktsenF/9jZGl4al
VLHYkX6ImpgTbvS9LRRGsPCZSQlO1jBcslPK6R0djmSMJQgiU69U55MZ2pRe5V9R
IcheJrJDoix0msZmTu2c1QzZTiLLdzjfUPHM2syKoQLRk/j8CSc=
=40sW
-----END PGP SIGNATURE-----

--gildbygudiea755e--
