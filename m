Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9601A6528CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiLTWPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLTWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:15:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794491F631;
        Tue, 20 Dec 2022 14:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1A0615C8;
        Tue, 20 Dec 2022 22:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C14C433EF;
        Tue, 20 Dec 2022 22:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671574515;
        bh=/hXbsdZlpPJ092brHoQdM/vjvfB74qXktqitZJsVKZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHSQ22X8muE+CwnZqqGtUeYuyyk0+PRIYvmBqqB8UfP0aE6/Dr8/0Ux5uZVL4t5d2
         rsVF/fIglHI3PPCJ+5AjFHCgsiOCBZztKBEKWsLOtGVHxC2vzjy31PTGrvrAYgdxXN
         QJLWqmxKi91UZnaUSSVQSqA77Y2PgTFn/X9Exu4/9bhDHM6pL1tfrXVF+/+QKuVhxq
         UbPE9OdVKs+VvBDmfGDMVTRXHDPfz2m5YllUGciZ9ZfLiPh+Fyu/1lvyCSNV0CznO/
         dyzxJ5sU1xA9UpIZCohRQ1G4bKgC49gPDg0jsziHV7HrJGD7pKjSqzyRAJxg7Hp/hz
         +mVICg5lrS7jA==
Date:   Tue, 20 Dec 2022 22:15:10 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] reset: Create subdirectory for StarFive drivers
Message-ID: <Y6Iz7pzG3Zmecm3S@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-4-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zh1KmNPWKa/82vyz"
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-4-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zh1KmNPWKa/82vyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 08:50:46AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> This moves the StarFive JH7100 reset driver to a new subdirectory in
> preparation for adding more StarFive reset drivers.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS                                          | 2 +-
>  drivers/reset/Kconfig                                | 8 +-------
>  drivers/reset/Makefile                               | 2 +-
>  drivers/reset/starfive/Kconfig                       | 8 ++++++++
>  drivers/reset/starfive/Makefile                      | 2 ++
>  drivers/reset/{ =3D> starfive}/reset-starfive-jh7100.c | 0
>  6 files changed, 13 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/reset/starfive/Kconfig
>  create mode 100644 drivers/reset/starfive/Makefile
>  rename drivers/reset/{ =3D> starfive}/reset-starfive-jh7100.c (100%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd90403c33bd..117024b52d06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19651,7 +19651,7 @@ STARFIVE JH7100 RESET CONTROLLER DRIVER
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> -F:	drivers/reset/reset-starfive-jh7100.c
> +F:	drivers/reset/starfive/reset-starfive-jh7100.c
>  F:	include/dt-bindings/reset/starfive-jh7100.h
> =20
>  STATIC BRANCH/CALL
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index de176c2fbad9..1e8e1c4954cd 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -232,13 +232,6 @@ config RESET_SOCFPGA
>  	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
>  	  driver gets initialized early during platform init calls.
> =20
> -config RESET_STARFIVE_JH7100
> -	bool "StarFive JH7100 Reset Driver"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> -	default SOC_STARFIVE
> -	help
> -	  This enables the reset controller driver for the StarFive JH7100 SoC.
> -
>  config RESET_SUNPLUS
>  	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
>  	default ARCH_SUNPLUS
> @@ -320,6 +313,7 @@ config RESET_ZYNQ
>  	help
>  	  This enables the reset controller driver for Xilinx Zynq SoCs.
> =20
> +source "drivers/reset/starfive/Kconfig"
>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  source "drivers/reset/tegra/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 3e7e5fd633a8..fee17a0e3a16 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y +=3D core.o
>  obj-y +=3D hisilicon/
> +obj-$(CONFIG_SOC_STARFIVE) +=3D starfive/
>  obj-$(CONFIG_ARCH_STI) +=3D sti/
>  obj-$(CONFIG_ARCH_TEGRA) +=3D tegra/
>  obj-$(CONFIG_RESET_A10SR) +=3D reset-a10sr.o
> @@ -30,7 +31,6 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) +=3D reset-rzg2l-=
usbphy-ctrl.o
>  obj-$(CONFIG_RESET_SCMI) +=3D reset-scmi.o
>  obj-$(CONFIG_RESET_SIMPLE) +=3D reset-simple.o
>  obj-$(CONFIG_RESET_SOCFPGA) +=3D reset-socfpga.o
> -obj-$(CONFIG_RESET_STARFIVE_JH7100) +=3D reset-starfive-jh7100.o
>  obj-$(CONFIG_RESET_SUNPLUS) +=3D reset-sunplus.o
>  obj-$(CONFIG_RESET_SUNXI) +=3D reset-sunxi.o
>  obj-$(CONFIG_RESET_TI_SCI) +=3D reset-ti-sci.o
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kcon=
fig
> new file mode 100644
> index 000000000000..cddebdba7177
> --- /dev/null
> +++ b/drivers/reset/starfive/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config RESET_STARFIVE_JH7100
> +	bool "StarFive JH7100 Reset Driver"
> +	depends on SOC_STARFIVE || COMPILE_TEST
> +	default SOC_STARFIVE

You could in theory drop the default that I added & replace it with a y,
since the subdir is gated by the symbol. I don't really care though tbh.
The movement seems fine to me..
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

> +	help
> +	  This enables the reset controller driver for the StarFive JH7100 SoC.
> diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Mak=
efile
> new file mode 100644
> index 000000000000..670d049423f5
> --- /dev/null
> +++ b/drivers/reset/starfive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RESET_STARFIVE_JH7100)		+=3D reset-starfive-jh7100.o
> diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/starfi=
ve/reset-starfive-jh7100.c
> similarity index 100%
> rename from drivers/reset/reset-starfive-jh7100.c
> rename to drivers/reset/starfive/reset-starfive-jh7100.c
> --=20
> 2.38.1
>=20
>=20

--zh1KmNPWKa/82vyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6Iz7gAKCRB4tDGHoIJi
0kwrAQD7r8oFTH5a1/NbDQ7ZWs5mjPOXmg4cAFGBu3Vqn0qaLgD+L5pc3W4etT/y
5+k6f4WdYdsVirsXBaQu5wFN5I19LgQ=
=9xHl
-----END PGP SIGNATURE-----

--zh1KmNPWKa/82vyz--
