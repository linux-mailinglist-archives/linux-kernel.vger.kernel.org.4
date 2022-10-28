Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F015F611456
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ1OSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1OSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:18:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21F91D79B4;
        Fri, 28 Oct 2022 07:18:29 -0700 (PDT)
Received: from mercury (unknown [37.84.150.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FC946602925;
        Fri, 28 Oct 2022 15:18:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666966708;
        bh=sSytXEZ9e5b02eEiUXjT4cPkNC0qO9sd2fptksEdkqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJMlUK2qbL6Y2lz8LfbzrMhhOseaqn+kRBX91zpjJlhXbEdkd8GL3OkHyJ+5rgNJm
         ESR8yuyu1jx+Hs4mxJ5CzLPHTf5kVQPcqp/7Xxf2d06tyqNpETcBWpqgfxB9IXwihK
         XFGEg6OWRDmpGI405/rs5knZZQb7Tz5/Hu9Z/RipojEfWwQJ2LyAbGrCIAVa718CcY
         y0kvvj6kNor0q9MXa0ExXTMAObWse43RoL+DOs3KKy6LebW9p8vkVCX0nhNfbATysj
         A/2ZU4BMjJVmOWqzmaMT6ICyAyLIXDMto1HPIDUDKTPvro980QAKvT7UiaGaAeN4BY
         8Y0wdnl4tcz5Q==
Received: by mercury (Postfix, from userid 1000)
        id ED9E010607E8; Fri, 28 Oct 2022 16:18:25 +0200 (CEST)
Date:   Fri, 28 Oct 2022 16:18:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/21] power: remove s3c adc battery driver
Message-ID: <20221028141825.z2hct63dzzguzds5@mercury.elektranox.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwefcm3vjwimuv4y"
Content-Disposition: inline
In-Reply-To: <20221021203329.4143397-7-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hwefcm3vjwimuv4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 21, 2022 at 10:27:40PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The s3c-adc driver is removed along with the s3c24xx platform,
> so the battery driver is no longer needed either.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I suppose queuing this via power-supply will result in temporary
build failures because the header is included in s3c24xx arch code.
So better to merge via the same tree that is killing the arch code:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  MAINTAINERS                            |   7 -
>  drivers/power/supply/Kconfig           |   6 -
>  drivers/power/supply/Makefile          |   1 -
>  drivers/power/supply/s3c_adc_battery.c | 453 -------------------------
>  include/linux/s3c_adc_battery.h        |  39 ---
>  5 files changed, 506 deletions(-)
>  delete mode 100644 drivers/power/supply/s3c_adc_battery.c
>  delete mode 100644 include/linux/s3c_adc_battery.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 071d64e2a7ca..2caf42b0328a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17920,13 +17920,6 @@ S:	Supported
>  W:	http://www.ibm.com/developerworks/linux/linux390/
>  F:	drivers/s390/scsi/zfcp_*
> =20
> -S3C ADC BATTERY DRIVER
> -M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> -L:	linux-samsung-soc@vger.kernel.org
> -S:	Odd Fixes
> -F:	drivers/power/supply/s3c_adc_battery.c
> -F:	include/linux/s3c_adc_battery.h
> -
>  S3C24XX SD/MMC Driver
>  M:	Ben Dooks <ben-linux@fluff.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 568b3ede993a..e2f8dfcdd2a9 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -406,12 +406,6 @@ config BATTERY_MAX1721X
>  	  Say Y here to enable support for the MAX17211/MAX17215 standalone
>  	  battery gas-gauge.
> =20
> -config BATTERY_S3C_ADC
> -	tristate "Battery driver for Samsung ADC based monitoring"
> -	depends on S3C_ADC
> -	help
> -	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
> -
>  config BATTERY_TWL4030_MADC
>  	tristate "TWL4030 MADC battery driver"
>  	depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index af43866b3980..8cb3c7f5c111 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -54,7 +54,6 @@ obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
>  obj-$(CONFIG_BATTERY_MAX1721X)	+=3D max1721x_battery.o
>  obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
>  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
> -obj-$(CONFIG_BATTERY_S3C_ADC)	+=3D s3c_adc_battery.o
>  obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_battery.o
>  obj-$(CONFIG_CHARGER_88PM860X)	+=3D 88pm860x_charger.o
>  obj-$(CONFIG_CHARGER_PCF50633)	+=3D pcf50633-charger.o
> diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/suppl=
y/s3c_adc_battery.c
> deleted file mode 100644
> index 68d31a3bee48..000000000000
> diff --git a/include/linux/s3c_adc_battery.h b/include/linux/s3c_adc_batt=
ery.h
> deleted file mode 100644
> index 57f982c375f8..000000000000
> --=20
> 2.29.2
>=20

--hwefcm3vjwimuv4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNb5LEACgkQ2O7X88g7
+ppXihAAn49VyObGmxLIEAGrlmjo5FQ1Vpft85/+KtJmC8QWvyZyzXdO9tDEftda
o0QxTkaN31dkhnqMqIQqHtPd8BwU1X2G+BdeCDNAH0GJ59Sj82WptaCi+QbfEBPA
cyo/Ffi3JU5o7tQvafN+Bh81dlL7flEZCWpnbLGH1hVkeN5YRvkNAIi4DzqS1DHV
1kIC1ubevpx5BA3YnYZaWq5aYpMWjhcQGANJxQ8Ppwv4+DilQaYS8SF9wbSDPwqF
I+OO/AkZucu+YMNoRVViQ3S9t8uA6voibIO4lRZsU1ET2cnzjIvM3GIyXxN0NFRp
osHaOkOolNPTC+ntMZ6OP/mPiZejh7OnzaW0TwZx+fkLrAZs2VOsILdNTnSjRphr
3T7rsfkY+upU0aQF7SoWVhVywYD+BczKKHxe4McWw4jx7PlFrFLXGbchkeY0e6PX
YFjFU2d+du+CQveB+Z2P40l3xB+wbVvfB1TmdUrzlb+Uok5/Hv3mp/kRBZXGrl0A
pUQjJEzriy7PJQIToyzTw+owvxtCRIs7LXI1mYEuSWlp0XJneNscEEeWHItupUlE
lN58v10knLN9D3u1qHzTbn9H9gRuDSOjj48TWfJfFOIXtEEVckCFcaygd57dvU36
bdw8Z/VUPwpkwola9SXqAzk7oEN47wRuboJhJeo0sCXqajOpDvs=
=zSFi
-----END PGP SIGNATURE-----

--hwefcm3vjwimuv4y--
