Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1565F166
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjAEQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjAEQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:39:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A775C93A;
        Thu,  5 Jan 2023 08:39:55 -0800 (PST)
Received: from mercury (dyndsl-085-016-198-020.ewe-ip-backbone.de [85.16.198.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19B5C6602D2E;
        Thu,  5 Jan 2023 16:39:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672936794;
        bh=yXwx9n9SOieuowPORXakwLQHMJ/JC6ORQetamn1DCkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faNUYQzIkgwCvrSX0W7O408Z7BzZ/E85sc2/yCn78J+7GcX3FKtGP2sX21VvLswIk
         Y7mGik2LLnGkzSL7BQbmlEhsNbM7uifdSELmEWE3jepqDcWfCUckVJlAV1Xd/q2A1R
         OYTR1nlHibodYkKRoMtNqVyl3U2UTzO+SCMxRS17qUraAjEGmZdO2azg7KSsplUam0
         ilCOLI2okAmY1ySXFg0Ne2VSv1naENIPx/epeXnsw+KVN1ChBFPv8aySK8HcujCGKv
         3H4B2UrakjfZzNrf6Hu7qTweT5raSiB6o2bJIqCRjJNSY/BVtANQ31LCR1jnOj3kDr
         tgaprobQfs0+g==
Received: by mercury (Postfix, from userid 1000)
        id 0FB661060772; Thu,  5 Jan 2023 17:39:51 +0100 (CET)
Date:   Thu, 5 Jan 2023 17:39:51 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Anton Vorontsov <cbou@mail.ru>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 16/27] power: remove pda_power supply driver
Message-ID: <20230105163951.jidh4fu5bjpjvrj4@mercury.elektranox.org>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-17-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eprnmz3cd337hg2r"
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-17-arnd@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eprnmz3cd337hg2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 05, 2023 at 02:46:11PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver was used for a couple of Intel PXA and Samsung S3C24xx
> based PDAs, but all of those are now removed from the kernel, so
> the driver itself is no longer useful.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Anton Vorontsov <cbou@mail.ru>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This needs to go through the same tree as the patch removing the PXA
boards, since they include pda_power.h:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  Documentation/power/power_supply_class.rst |   4 +-
>  arch/arm/mach-tegra/tegra.c                |   1 -
>  drivers/power/supply/Kconfig               |   9 -
>  drivers/power/supply/Makefile              |   1 -
>  drivers/power/supply/pda_power.c           | 520 ---------------------
>  include/linux/pda_power.h                  |  39 --
>  6 files changed, 2 insertions(+), 572 deletions(-)
>  delete mode 100644 drivers/power/supply/pda_power.c
>  delete mode 100644 include/linux/pda_power.h
>=20
> diff --git a/Documentation/power/power_supply_class.rst b/Documentation/p=
ower/power_supply_class.rst
> index c04fabee0a58..da8e275a14ff 100644
> --- a/Documentation/power/power_supply_class.rst
> +++ b/Documentation/power/power_supply_class.rst
> @@ -40,8 +40,8 @@ kind of power supply, and can process/present them to a=
 user in consistent
>  manner. Results for different power supplies and machines are also direc=
tly
>  comparable.
> =20
> -See drivers/power/supply/ds2760_battery.c and drivers/power/supply/pda_p=
ower.c
> -for the example how to declare and handle attributes.
> +See drivers/power/supply/ds2760_battery.c for the example how to declare
> +and handle attributes.
> =20
> =20
>  Units
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index ab5008f35803..9ef1dfa7b926 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -19,7 +19,6 @@
>  #include <linux/of_fdt.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> -#include <linux/pda_power.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_8250.h>
>  #include <linux/slab.h>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3c37f3a6431c..e2f8dfcdd2a9 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -28,15 +28,6 @@ config POWER_SUPPLY_HWMON
>  	  Say 'Y' here if you want power supplies to
>  	  have hwmon sysfs interface too.
> =20
> -
> -config PDA_POWER
> -	tristate "Generic PDA/phone power driver"
> -	depends on !S390
> -	help
> -	  Say Y here to enable generic power driver for PDAs and phones with
> -	  one or two external power supplies (AC/USB) connected to main and
> -	  backup batteries, and optional builtin charger.
> -
>  config APM_POWER
>  	tristate "APM emulation for class batteries"
>  	depends on APM_EMULATION
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 55c1aae91d1d..8cb3c7f5c111 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -9,7 +9,6 @@ obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
>  obj-$(CONFIG_POWER_SUPPLY_HWMON) +=3D power_supply_hwmon.o
>  obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
> =20
> -obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
>  obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
>  obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o
>  obj-$(CONFIG_IP5XXX_POWER)	+=3D ip5xxx_power.o
> diff --git a/drivers/power/supply/pda_power.c b/drivers/power/supply/pda_=
power.c
> deleted file mode 100644
> index 03a37fd6be27..000000000000
> diff --git a/include/linux/pda_power.h b/include/linux/pda_power.h
> deleted file mode 100644
> index 2a69db4b60b7..000000000000
> --=20
> 2.39.0
>=20

--eprnmz3cd337hg2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmO2/VYACgkQ2O7X88g7
+ppWRA/9H5z/ZHsm6NrlNVwy9rJomhqv7MipFRX5IdVE+yMSXCD+aqWydfHkQGtd
q3CR91BZMcs7SoQLHOKHrDbpxzVgRvqYLjMdzjwn98KN0p7KkmvlMBIoA1dnvDbp
EVfkexgvZZF3j1NJo/jW/uSggBAEmb1QZAHmlXM7cBMqkMpRdXk0Q4YFEX+wvjqr
A6EnMWajRfy7meisBop7Un8keWG56nrtP0PkQcgdRUTtHy2k9CIfeCnov1KZJsoI
KfEcQznb21OoXgsDycU59P+YCl0GiVRCoTFvZhFfJ2HNf42EVBZv3GnUTeUc5qDV
cX5fBRcG/R4Vkbr8Stlmcj2R+5c24RpNb1+7vLnrnyGhBaxwCtrBepZBkrka1b03
6TEWZIp9ywDdiXKqqd7BO5Teknm/PS+L8lVcXUIYYTNrmz6g0NYCZ31PU6/7kcJl
Z2+y4p9cAZA8Uu+kJ6EmNpWs5PdSs1qEE8rr8rG+ZznUZ+nu07nPwPHVhrxvLgHz
EcaN7Od6CDZ8B0mRKIa9GScdZv2+ZszwmllVaxbjfueln8qYZA8tSUnjKcKbWTKS
jOj1pE8XeFckgcEY7KQU6/Iol0Tf0tkquvVnQOS6PVV39NtXGMPo1QqaFQbeFTV2
5GaqmDHtXRb/UPBqXUoh0ULsT561OK7etxHjjTseNImELiftQks=
=NWFd
-----END PGP SIGNATURE-----

--eprnmz3cd337hg2r--
