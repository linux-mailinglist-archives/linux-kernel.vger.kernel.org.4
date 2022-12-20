Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C46652860
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiLTV0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLTV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:26:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0A963E9;
        Tue, 20 Dec 2022 13:26:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7165A615C2;
        Tue, 20 Dec 2022 21:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A0BC433EF;
        Tue, 20 Dec 2022 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671571573;
        bh=S5/irmbdxPHRGjloGu2y2uI3gxorhqGUs8rELs0Mt1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b89knfYZlcl38WQkiGRpaBqBApY5hUs2S/aKIKXC+AC2zW9UlG2rT1zozbgOYyQYr
         QlrgGtoXRAacuK1DGl9ldAm/+npm77BPnUGKrnVJa15xA523jHpJKk0rTl7PHncgue
         05UCdMXCtlpxq+OLIggWjkzIbYlQ9tabdCNhWq+Dm5X54FQL5fxwEoSD4RLIApbUk2
         vQYlrgvY9LQD8nazrhiDVuBD8lm9VYHs1h5YgxiQeoMNEuG1Tn2UxtUmHboFexaYv0
         rBqAbktDmO5WCAHhLaWGVkppG20n5ILPS8owoOB7uqZtjXNfddyKdhPBEYVQJg2jpI
         LKlDqyIveRHqw==
Date:   Tue, 20 Dec 2022 21:26:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
Message-ID: <Y6Iob3csmKMl0rB/@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8xrhEquv/3PxHBwz"
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-8-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8xrhEquv/3PxHBwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 09:12:47AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add a minimal device tree for StarFive JH7110 VisionFive 2 board
> which has version A and version B. Support booting and basic
> clock/reset/pinctrl/uart drivers.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>  .../jh7110-starfive-visionfive-2-va.dts       |  13 ++
>  .../jh7110-starfive-visionfive-2-vb.dts       |  13 ++
>  .../jh7110-starfive-visionfive-2.dtsi         | 111 ++++++++++++++++++
>  4 files changed, 138 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfi=
ve-2-va.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfi=
ve-2-vb.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfi=
ve-2.dtsi
>=20
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/=
starfive/Makefile
> index 0ea1bc15ab30..79e925a4a227 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7100-beaglev-starlight.dtb
> +dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7110-starfive-visionfive-2-va.dtb jh71=
10-starfive-visionfive-2-vb.dtb

Could you rebase on top of v6.2-rc1 when you submit your next version
squash this in please (unless Emil hates it):
diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/st=
arfive/Makefile
index c38a9ade7f48..b3744420253a 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7100-beaglev-starlight.dtb jh7100-starfi=
ve-visionfive-v1.dtb
-dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7110-starfive-visionfive-2-va.dtb jh7110=
-starfive-visionfive-2-vb.dtb
+dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7100-beaglev-starlight.dtb
+dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7100-starfive-visionfive-v1.dtb
+dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7110-starfive-visionfive-2-va.dtb
+dtb-$(CONFIG_SOC_STARFIVE) +=3D jh7110-starfive-visionfive-2-vb.dtb

I'd rather have more, but easier to read lines than long ones.

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> new file mode 100644
> index 000000000000..c60280b89c73
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110.dtsi"
> +#include "jh7110-pinfunc.h"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	cpus {
> +		timebase-frequency =3D <4000000>;
> +	};
> +
> +	memory@40000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x40000000 0x1 0x0>;

Is this a good idea when you have SKUs with 2, 4 & 8 GiB of DDR?

Anyways, I can't review this as I've got neither board nor
documentation, so with the above stuff sorted out:
Acked-by: Conor Dooley <conor.dooley@microchip.com>
I'll not apply it until the clock binding header is in my tree.

Thanks,
Conor.


--8xrhEquv/3PxHBwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6IobwAKCRB4tDGHoIJi
0jwaAQD7o1TKtLNZlBTk13ECBN0bhssFOZvOLHHDM950ZiX1dAD/Vwfu94KObi+g
P1wOYMlvne8eqaD+rVW4wZn2KtuR4wU=
=PJBb
-----END PGP SIGNATURE-----

--8xrhEquv/3PxHBwz--
