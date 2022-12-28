Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104B65875E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiL1Wsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1Wsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:48:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D9140E9;
        Wed, 28 Dec 2022 14:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 786CBB81914;
        Wed, 28 Dec 2022 22:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A96C433D2;
        Wed, 28 Dec 2022 22:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672267730;
        bh=NpdedqY/UTF4uGtmQnKeb03AizfJv69Dyw7+UYmfMTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrtpYwSOR4m8WnCl/Mf8LMEdEVVsPneyDJF41yJ6LWb6/7YXTotxA0t2lQ60MNvrG
         pBPfRBZHNDLFWGzbZb1dXpGynJeo2YHWG1AdK8pZjEeHk+WfnFI/I6dsnnLtQ8pLIv
         TZGNX5k+YTsivGZdaEDyaj4CnwOGmmuCLjnnSHnI95SIaCmyP9jwnEpUtDGI0O9T51
         xE51e4n9UbZF9IHZBula35YMhCYhTo0koHBu00NZ4O2YH3A7j33So0AvFvvua900V7
         wSs9xfZ28XGmgpZvy/xfHrBhHn2FmduADwgy9PhgxCISlEXQwzSleIrZm+dAUd0o/T
         PpXaUKLi65t5A==
Date:   Wed, 28 Dec 2022 22:48:43 +0000
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
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Message-ID: <Y6zHy9oL4xzl+6Rd@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ANn4P8tMvc1B4Y18"
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-7-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ANn4P8tMvc1B4Y18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add initial device tree for the JH7110 RISC-V SoC by StarFive
> Technology Ltd.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 411 +++++++++++++++++++++++
>  1 file changed, 411 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> new file mode 100644
> index 000000000000..64d260ea1f29
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
> +#include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +/ {
> +	compatible =3D "starfive,jh7110";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		S76_0: cpu@0 {
> +			compatible =3D "sifive,u74-mc", "riscv";

The label here says S76 but the compatible says u74-mc.
Which is correct? Your docs say S7 and S76, so I would imagine that it
is actually an S76?

> +			reg =3D <0>;
> +			d-cache-block-size =3D <64>;
> +			d-cache-sets =3D <64>;
> +			d-cache-size =3D <8192>;
> +			d-tlb-sets =3D <1>;
> +			d-tlb-size =3D <40>;
> +			device_type =3D "cpu";
> +			i-cache-block-size =3D <64>;
> +			i-cache-sets =3D <64>;
> +			i-cache-size =3D <16384>;
> +			i-tlb-sets =3D <1>;
> +			i-tlb-size =3D <40>;
> +			mmu-type =3D "riscv,sv39";
> +			next-level-cache =3D <&ccache>;
> +			riscv,isa =3D "rv64imac";

While I was poking around trying to see if there was some logic behind
that compatible, I noticed that SiFive's docs for the S76 say it is
RV64GBC *but* the docs for the u74-mc say "4xRV64GBC and 1xRV64IMAC".
I assume that rv64imac is the correct one here?

> +			tlb-split;
> +			status =3D "disabled";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		U74_1: cpu@1 {
> +			compatible =3D "sifive,u74-mc", "riscv";
> +			reg =3D <1>;
> +			d-cache-block-size =3D <64>;
> +			d-cache-sets =3D <64>;
> +			d-cache-size =3D <32768>;
> +			d-tlb-sets =3D <1>;
> +			d-tlb-size =3D <40>;
> +			device_type =3D "cpu";
> +			i-cache-block-size =3D <64>;
> +			i-cache-sets =3D <64>;
> +			i-cache-size =3D <32768>;
> +			i-tlb-sets =3D <1>;
> +			i-tlb-size =3D <40>;
> +			mmu-type =3D "riscv,sv39";
> +			next-level-cache =3D <&ccache>;
> +			riscv,isa =3D "rv64imafdc";

That also begs the question:
Do your u74s support RV64GBC, as the (current) SiFive documentation
suggests?

Thanks,
Conor.


--ANn4P8tMvc1B4Y18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6zHywAKCRB4tDGHoIJi
0qgIAP9goDzTR6Vrk3MaunduxIAwBUWHl3xCKWlRZnoQe55+eAD9HZ6QEMK242tX
+jlk7hQ1SjjbYoeCLbpCrF0OoheU2Q4=
=lZyu
-----END PGP SIGNATURE-----

--ANn4P8tMvc1B4Y18--
