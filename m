Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92E6F2629
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjD2UHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 16:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2UHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504771BE4;
        Sat, 29 Apr 2023 13:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCCE8611F6;
        Sat, 29 Apr 2023 20:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9749C433D2;
        Sat, 29 Apr 2023 20:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682798823;
        bh=3Tk09UQ1hIbxVg7uFnuOI3FKwaPBq7Zi+L3y4wmvTr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTeFnrRK16KIUWJZEiqYJ34YnUmXoCbXCEtVa7ei5dlYVRtVyokrWX1D6vHVCGHFC
         vVEo7d02AqFk2g7g8aPiEW7AvybvcKkP75Z8dyE/E7MeBMJqwmD/S/XdGSMonxHP7Z
         YlPbKKYXzzmmxtzU3o9Xjggv/YXJWIx6kHn9R4mtk7ZVGcyhIeLXiBsE+P64nsJ9wx
         fG0uEYYhMQm5j1dmZPZ64DfAD5dJZsQFFlNogi1WAr2wKLCVjzsYNxbM8E6BNMaFfE
         InwGUOjIl2i+13W4y3OWg11Rw+0Q33rBv1pp1wwO/PZbXN3Eacj9+Bs3CbXzGnUbgV
         STZznZC6/agig==
Received: by mercury (Postfix, from userid 1000)
        id EA42E1066F88; Sat, 29 Apr 2023 22:06:59 +0200 (CEST)
Date:   Sat, 29 Apr 2023 22:06:59 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 13/43] power: reset: Add a driver for the ep93xx reset
Message-ID: <20230429200659.36utkzfevcj45qce@mercury.elektranox.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-14-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4qfw5plufhgux5w"
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-14-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t4qfw5plufhgux5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 24, 2023 at 03:34:29PM +0300, Nikita Shubin wrote:
> Implement the reset behaviour of the various EP93xx SoCS in drivers/power=
/reset.
>=20
> It used to be located in arch/arm/mach-ep93xx.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/reset/Kconfig          | 10 +++++
>  drivers/power/reset/Makefile         |  1 +
>  drivers/power/reset/ep93xx-restart.c | 65 ++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 drivers/power/reset/ep93xx-restart.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8c87eeda0fec..2a61afbb047b 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -75,6 +75,16 @@ config POWER_RESET_BRCMSTB
>  	  Say Y here if you have a Broadcom STB board and you wish
>  	  to have restart support.
> =20
> +config POWER_RESET_EP93XX
> +	bool "Cirrus EP93XX reset driver" if COMPILE_TEST
> +	depends on MFD_SYSCON
> +	default ARCH_EP93XX
> +	help
> +	  This driver provides restart support for Cirrus EP93XX SoC.
> +
> +	  Say Y here if you have a Cirrus EP93XX SoC and you wish
> +	  to have restart support.
> +
>  config POWER_RESET_GEMINI_POWEROFF
>  	bool "Cortina Gemini power-off driver"
>  	depends on ARCH_GEMINI || COMPILE_TEST
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index d763e6735ee3..61f4e11619b2 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_POWER_RESET_ATC260X) +=3D atc260x-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AXXIA) +=3D axxia-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMKONA) +=3D brcm-kona-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMSTB) +=3D brcmstb-reboot.o
> +obj-$(CONFIG_POWER_RESET_EP93XX) +=3D ep93xx-restart.o
>  obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemini-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
> diff --git a/drivers/power/reset/ep93xx-restart.c b/drivers/power/reset/e=
p93xx-restart.c
> new file mode 100644
> index 000000000000..0dab09d4fd3c
> --- /dev/null
> +++ b/drivers/power/reset/ep93xx-restart.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Cirrus EP93xx SoC reset driver
> + *
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/notifier.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +
> +#include <linux/soc/cirrus/ep93xx.h>
> +
> +#define EP93XX_SYSCON_DEVCFG_SWRST	BIT(31)
> +
> +static int ep93xx_restart_handle(struct notifier_block *this,
> +				 unsigned long mode, void *cmd)
> +{
> +	/* Issue the reboot */
> +	ep93xx_devcfg_set_clear(EP93XX_SYSCON_DEVCFG_SWRST, 0x00);
> +	ep93xx_devcfg_set_clear(0x00, EP93XX_SYSCON_DEVCFG_SWRST);
> +
> +	mdelay(1000);
> +
> +	pr_emerg("Unable to restart system\n");
> +	return NOTIFY_DONE;
> +}
> +
> +static int ep93xx_reboot_probe(struct platform_device *pdev)
> +{
> +	struct notifier_block *res_han;
> +	struct device *dev =3D &pdev->dev;
> +	int err;
> +
> +	res_han =3D devm_kzalloc(&pdev->dev, sizeof(*res_han), GFP_KERNEL);
> +	if (!res_han)
> +		return -ENOMEM;
> +
> +	res_han->notifier_call =3D ep93xx_restart_handle;
> +	res_han->priority =3D 128;
> +
> +	err =3D register_restart_handler(res_han);
> +	if (err)
> +		dev_err(dev, "can't register restart notifier (err=3D%d)\n", err);
> +
> +	return err;
> +}
> +
> +static const struct of_device_id ep93xx_reboot_of_match[] =3D {
> +	{
> +		.compatible =3D "cirrus,ep9301-reboot",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver ep93xx_reboot_driver =3D {
> +	.probe =3D ep93xx_reboot_probe,
> +	.driver =3D {
> +		.name =3D "ep9301-reboot",
> +		.of_match_table =3D ep93xx_reboot_of_match,
> +	},
> +};
> +builtin_platform_driver(ep93xx_reboot_driver);
> --=20
> 2.39.2
>=20

--t4qfw5plufhgux5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRNeOAACgkQ2O7X88g7
+pqywA/9EILO3MqSurbHWBGdc+ayGbftXXbSnmG4gl9oYirO1rBghdyTgYBlbqpj
pZHpqgsaGMEyjfu8oXTt6kml6HJaTqMgeyrRUnwmKsj2li9DI36ogO/Zan62cqGW
Z1p3FK41y0aAvmzB0EFlt6az9GGo5oPXwOgjvUD3GOaJKPaHorZAu1fBRhAsAPaE
1MWcGEI7NPz9VSBnx0yCxbTpBEFpD2yEfjqHgLjaNlgKtCwYWEFJLOqDuWqUsQWB
vL6mHcbRwAKsuVv9VsBDpHS4Tbhu8WTEd9Qb6tJFa6MDeEws49/TNAL5ag5ygT69
WJpS7THCeoggj+mu7mr1XX6G1BDCoPIZ06/QEB32mxYKS/FvyME85GwP+Zj5PUyI
c6Cf0nOBp7i9/ZE4hUY/JDRn6YGFR27RpasYnguurXx0vuEyep0oEJrM62NZ/mKm
48MeA3jyySCCjXD2AqJoR1bYD1N1gZFKILxstRQq2DDKkO/mKsV7a5R/J7eUrkym
ZkX9XcswQkzvkaCgU19SFrszODA3DZ4HHPo+yq3yGeucK5qxNfa60sew1IvYS7zG
CweZiHVGBqBC9BPDBP/LKkQLEqIdHxs9U2YIbQQngZ20SFljhguWJty/1/pT2nwH
7Q25/3vGVRklve4tMYSDOtY4M3S2RQBXwaauMztqh0kOZQZT/48=
=5rTD
-----END PGP SIGNATURE-----

--t4qfw5plufhgux5w--
