Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E305B5851
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiILK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiILK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0016B386A2;
        Mon, 12 Sep 2022 03:28:38 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7B256601FE0;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978517;
        bh=DRiZC5zI3w4caCIF0yPN0iBcoObFd36g1UxxkKSXqgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4BzXAj26aLaZmdDj4BImvIfeWREijDpm2B8zCBilMMWF9oGicJ0hITLLrr5f9y74
         C+ZqG//Lc1lwKZefepmYeGPis009R2ZQUPqeWOErugyfJ8l2mVECA8t0ojmQ8RYRbN
         7iddZ0DcsLusCLzZxKG90rwHvBHimtf0TgL0TC4EUMwAzsv3MbE3OU00VDXSGWDuDl
         7aKShpsTj1Lh9CiTlI+F6/SALVXMxe1wO4fJC+ODcP1h9vV5tzBe/8nmrGiJpCGOaX
         lf08Db8RLQG8YXvU2lWjlGC9tzINW4SyesnxpHdgGFZfcD6OftcN6KYv5oWm8sVA/6
         6zsLXIA7ijVJQ==
Received: by mercury (Postfix, from userid 1000)
        id 403B81063360; Sun, 11 Sep 2022 14:55:45 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:55:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mithil Bavishi <bavishimithil@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, contact@paulk.fr
Subject: Re: [PATCH 03/10] power: reset: Add TWL6030 power driver, with
 minimal support for power off
Message-ID: <20220911125545.73afzbirtnsdbmgo@mercury.elektranox.org>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
 <20220820071659.1215-4-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kq6iicrq5qwpzlb4"
Content-Disposition: inline
In-Reply-To: <20220820071659.1215-4-bavishimithil@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kq6iicrq5qwpzlb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 20, 2022 at 12:46:53PM +0530, Mithil Bavishi wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
>=20
> This adds a TWL6030 power driver, that currently only supports powering
> off the device when the TWL is used as system power controller.
>=20
> This driver might be extended to support more power-related features of t=
he
> TWL6030.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  drivers/power/reset/Kconfig         | 10 ++++
>  drivers/power/reset/Makefile        |  1 +
>  drivers/power/reset/twl6030-power.c | 93 +++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 drivers/power/reset/twl6030-power.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 39117b697..5156b1613 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -316,3 +316,13 @@ config TWL4030_POWER
>            and load scripts controlling which resources are switched off/=
on
>            or reset when a sleep, wakeup or warm reset event occurs.
>  endif
> +
> +config TWL6030_POWER
> +	bool "TI TWL6030 power resources"
> +	depends on TWL4030_CORE && ARM
> +	help
> +	  Say yes here if you want to use the power resources on the
> +	  TWL6030 family chips.
> +
> +	  When used as system power controller, this driver allows turning off
> +	  the main power supply.
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index e9db25b09..692d51cef 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -37,3 +37,4 @@ obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
>  obj-$(CONFIG_TWL4030_POWER) +=3D twl4030-power.o
> +obj-$(CONFIG_TWL6030_POWER) +=3D twl6030-power.o
> diff --git a/drivers/power/reset/twl6030-power.c b/drivers/power/reset/tw=
l6030-power.c
> new file mode 100644
> index 000000000..78c8a02a3
> --- /dev/null
> +++ b/drivers/power/reset/twl6030-power.c
> @@ -0,0 +1,93 @@
> +/*
> + * TWL6030 power
> + *
> + * Copyright (C) 2016 Paul Kocialkowski <contact@paulk.fr>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Please use SPDX format for license.

> +
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/mfd/twl.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#define TWL6030_PHOENIX_DEV_ON		0x25
> +
> +#define TWL6030_PHOENIX_APP_DEVOFF	BIT(0)
> +#define TWL6030_PHOENIX_CON_DEVOFF	BIT(1)
> +#define TWL6030_PHOENIX_MOD_DEVOFF	BIT(2)
> +
> +void twl6030_power_off(void)
> +{
> +	int err;
> +
> +	err =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, TWL6030_PHOENIX_APP_DEVOFF=
 |
> +		TWL6030_PHOENIX_CON_DEVOFF | TWL6030_PHOENIX_MOD_DEVOFF,
> +		TWL6030_PHOENIX_DEV_ON);
> +	if (err)
> +		pr_err("TWL6030 Unable to power off\n");
> +}
> +
> +static bool twl6030_power_use_poweroff(struct device_node *node)
> +{
> +	if (of_property_read_bool(node, "ti,system-power-controller"))
> +		return true;
> +
> +	return false;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id twl6030_power_of_match[] =3D {
> +	{
> +		.compatible =3D "ti,twl6030-power",
> +	},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, twl6030_power_of_match);
> +#endif	/* CONFIG_OF */
> +
> +static int twl6030_power_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +
> +	if (!node) {
> +		dev_err(&pdev->dev, "Platform data is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Board has to be wired properly to use this feature */
> +	if (twl6030_power_use_poweroff(node) && !pm_power_off)
> +		pm_power_off =3D twl6030_power_off;

Please devm_register_sys_off_handler or devm_register_power_off_handler().

> +
> +	return 0;
> +}
> +
> +static int twl6030_power_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Empty remove function can be removed.

> +
> +static struct platform_driver twl6030_power_driver =3D {
> +	.driver =3D {
> +		.name	=3D "twl6030_power",
> +		.of_match_table =3D of_match_ptr(twl6030_power_of_match),

The driver is not useful without CONFIG_OF, so you can just remove the
#ifdef around twl6030_power_of_match and drop of_match_ptr here.

-- Sebastian

> +	},
> +	.probe		=3D twl6030_power_probe,
> +	.remove		=3D twl6030_power_remove,
> +};
> +
> +module_platform_driver(twl6030_power_driver);
> +
> +MODULE_AUTHOR("Paul Kocialkowski <contact@paulk.fr>");
> +MODULE_DESCRIPTION("Power management for TWL6030");
> +MODULE_LICENSE("GPL");
> --=20
> 2.25.1
>=20

--kq6iicrq5qwpzlb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd2s0ACgkQ2O7X88g7
+pq7pA//c8rhoEaTQYCtLWztRJSjzmHr9CN0dA3thpfcfumLKVuJwZ8G7nzx60Ye
vaiDHTiN5yAjh6Ahwmm+qNuljUDIkt2bmLCSVGn+YimpHq1Rh+hl6JSsXIkdFQ8c
Ko/R8PwW/kGRlh87aD2Doeau1CBU3uU4XZ0xhc1cm0BLCgaPHSRN9Gq7ClQgrb6h
tgAoe/dAeV3fNusbsUhIKcX9AfGVl8tchy5Vg2AdSdIQGI2HlV2kOZrx+eP0CUm2
XIE1VtlED5ApAaYcsVSOSEgU/YjB9Q1ME70ZyW5rpTNs6IEQ/jHZ7szZEQwcLHrm
LgcDH8BS8KTiglbSc/L+PhSyRHQBVe47o1aI8Nu5PNXS/B4EkG92twf1fJ/T4lRE
lKWj8vs4swRI0jyQC/mwtpfPuxxHysmFoKzR2evPlZ7IIaa84of7biwWEERrv083
AAiVcdyGbaPFq81NZgjNyOxs4wLK8WrLkwUhuqr278aeUi656xPGSYPh0pHv/qsR
ZG4Uqyv1luV3ZyhAavMgqZHJRZHDxxPBaHYmoVOJdZ/byF0G9t5W1ZOsopFtm7Wi
8L+feuz3X2Vg6cVW487ryhbcEL82BrIKdb5t1GkNTsGE4SOhlHzZSCvyD0xBrwGP
cqwSkgMEx8OzgIxY+x/x6uGk4vx2hDoebvhG9yH7DNYJ0IE5ST8=
=rfEv
-----END PGP SIGNATURE-----

--kq6iicrq5qwpzlb4--
