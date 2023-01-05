Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BAE65F147
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAEQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjAEQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:36:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECED5C1F5;
        Thu,  5 Jan 2023 08:36:02 -0800 (PST)
Received: from mercury (dyndsl-085-016-198-020.ewe-ip-backbone.de [85.16.198.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8CB856602D05;
        Thu,  5 Jan 2023 16:36:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672936560;
        bh=MnPwaUoQ0C35/ls1pQRopCEmVNldekDhFBc4/K3a63M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIVk0nC0fhdlpYVwVdFKP6GsCvnu2MD4i17ThhL6mjqgCBcqBZp3DG+zSNgNo/X2Q
         hUkiQwIzq4700Um86Q4d9BcFs2R/2mcbnXCfBdLfMMx+1pxzLpZWkM2YLjzfuytPfG
         wwhOrbUO/DHrKjcrfhsBgwsPd4n4H5jbfpsnPloVVla4AeqXxsRzPnr/D7mTGw/eBz
         /5L1jqxUBmLJ3Ol19fDcGVKtnCrAOdVDmuD16mRqM9WPdoQb3Tx2/4DoUdJCWL6Pr0
         FQPOIYvVLpHOHwQeBGy0ZPpLwRhwAbAg8WeAfv6mzPDxh6xSGyPex2SAEiC6wv8BWB
         tagVxMwSVBFTw==
Received: by mercury (Postfix, from userid 1000)
        id 00DCF1060772; Thu,  5 Jan 2023 17:35:57 +0100 (CET)
Date:   Thu, 5 Jan 2023 17:35:57 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        Peter Edwards <sweetlilmre@gmail.com>
Subject: Re: [PATCH 06/27] power: remove z2_battery driver
Message-ID: <20230105163557.waq3ckjshtkzu357@mercury.elektranox.org>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5scsoqmnkympzuvc"
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-7-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5scsoqmnkympzuvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 05, 2023 at 02:46:01PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The PXA z2 platform is gone, and this driver is now orphaned.
>=20
> Cc: linux-pm@vger.kernel.org
> Cc: Peter Edwards <sweetlilmre@gmail.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This should go through the same tree as the patch removing
arch/arm/mach-pxa/z2.c, which includes z2_battery.h removed
by this patch, so:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/Kconfig      |   6 -
>  drivers/power/supply/Makefile     |   1 -
>  drivers/power/supply/z2_battery.c | 318 ------------------------------
>  include/linux/z2_battery.h        |  17 --
>  4 files changed, 342 deletions(-)
>  delete mode 100644 drivers/power/supply/z2_battery.c
>  delete mode 100644 include/linux/z2_battery.h
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 98d4e9364606..b7fdcfd5d4e7 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -422,12 +422,6 @@ config BATTERY_MAX1721X
>  	  Say Y here to enable support for the MAX17211/MAX17215 standalone
>  	  battery gas-gauge.
> =20
> -config BATTERY_Z2
> -	tristate "Z2 battery driver"
> -	depends on I2C && MACH_ZIPIT2
> -	help
> -	  Say Y to include support for the battery on the Zipit Z2.
> -
>  config BATTERY_TWL4030_MADC
>  	tristate "TWL4030 MADC battery driver"
>  	depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 2fb02f19a9e0..38737ea9b9d5 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -54,7 +54,6 @@ obj-$(CONFIG_BATTERY_DA9150)	+=3D da9150-fg.o
>  obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
>  obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
>  obj-$(CONFIG_BATTERY_MAX1721X)	+=3D max1721x_battery.o
> -obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
>  obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
>  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
>  obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_battery.o
> diff --git a/drivers/power/supply/z2_battery.c b/drivers/power/supply/z2_=
battery.c
> deleted file mode 100644
> index 0ba4a590a0a5..000000000000
> diff --git a/include/linux/z2_battery.h b/include/linux/z2_battery.h
> deleted file mode 100644
> index 9e8be7a7cd25..000000000000
> --=20
> 2.39.0
>=20

--5scsoqmnkympzuvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmO2/GkACgkQ2O7X88g7
+ppsfg/+LK69xDiO3ua++NzncMxGfJn1kFs4h46Nsekit7Kr90tHmoz/cbe1bLJ/
4BcasBHgOaSxtjZhs5gfRczdoMVK8dlzH0ghAMbxton0jvFch4FvqlqmLqWYbxJZ
n2rRgaLWSk+3zysi9efnLr7IB2Z8YaWakI2OGSPkPd94kmZt8QZ9x7gpb3Zhn8Nc
Yhinw92K3Mbtai1+SWYroeXasw/H0ilqOfd9Pb3NCnLjqaY3ynA2UXcgqubuRpLM
qAbSP7rFfbCYeqGzRxUg/HpDrg34WvqfSE5lqzru47Q6yP2gkwQAS/rR35wa1/Yx
JVdJg1C7maLe7lpCI1At2V0RkYdGgg5+5cHD24KgDPCr6IubFUCrU+ixAKcoY9f5
qSa0tbh5kfBF0u4jFGMtjcJ7f7/G7pKPcNWFnlJeqTXHik9Oo+fOZJCwp4t0PApY
Yj4OUcP18QXHH1lF0yDzTN0bwKRRE+iM+Yl97e6+4TV8msYrOCOhgLL6jvFtqw0l
A4dN57nQvvKFcJyf7M1r3p7J7EUYyLupDZFQv7r/TCtpL2MLWl8giRBXhaT6UnJE
WP8KhOAkSyBFXZJieTed5fPmFKITtoAvyfESXb7onQCQ8aEaT1po5yhFiP+GfXow
CaJNAuHrlb1x2sxxNg7O8HolsL0VUWGqYLFX854FBNUFnypWoKs=
=cFGK
-----END PGP SIGNATURE-----

--5scsoqmnkympzuvc--
