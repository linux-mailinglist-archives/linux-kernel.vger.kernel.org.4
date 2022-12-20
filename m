Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D1A6529AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLTXOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLTXOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:14:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911821F2D5;
        Tue, 20 Dec 2022 15:14:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3704D6160B;
        Tue, 20 Dec 2022 23:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E418C433EF;
        Tue, 20 Dec 2022 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671578084;
        bh=1qveDXbwTyZ9N1/g+135Ft0QqSPob+h8v7iVN3aBATg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9cOOtng6EqNe5Mi1O9jX+BxuA1ZhQzp4Vy0mkLQzrWMMgs0OoP3OrhihIWguyUjG
         zgYhKNiITUyuTxkQzcV5kxy426iM51Om3ARwP1dYwDHCa2XYE9+tebHZHnKxxh0NmO
         0F58k1XBCS2DMcFuz3hfVZiuHw0d8LmFiGkwGIzv7anNIpwWlTXcMqzivbhxDICV1U
         x3bIYMMYJkujGz459ooFeMY1ZwAMXVwp0WtHKKT+ZflSG6so6QomLOaRkgcuneOcG8
         5OUETTXGSJyLCU0UYxz55DtvrjO0vUjRWkA8dsHocoGtOfNKSQCQE/gttRimMXFtK6
         7tVyWoxQv0Lyw==
Date:   Tue, 20 Dec 2022 23:14:39 +0000
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
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <Y6JB37Pd5TZoGMy4@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5z5zKcEbEyZyLNXj"
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-8-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5z5zKcEbEyZyLNXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 08:50:50AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add bindings for the system clock and reset generator (SYSCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-syscrg.yaml         |  80 +++++++
>  MAINTAINERS                                   |   8 +-
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 207 ++++++++++++++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
>  4 files changed, 434 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh71=
10-syscrg.yaml
>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-sysc=
rg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.ya=
ml
> new file mode 100644
> index 000000000000..ec81504dcb27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-syscrg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 System Clock and Reset Generator
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-syscrg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator (24 MHz)
> +      - description: GMAC1 RMII reference
> +      - description: GMAC1 RGMII RX
> +      - description: External I2S TX bit clock
> +      - description: External I2S TX left/right channel clock
> +      - description: External I2S RX bit clock
> +      - description: External I2S RX left/right channel clock
> +      - description: External TDM clock
> +      - description: External audio master clock

So, from peeking at the clock driver & the dt - it looks like a bunch of
these are not actually required?
I'd have ploughed through this, but having read Krzysztof's comments on
the DTS I'm not sure that this binding is correct.
https://lore.kernel.org/linux-riscv/20221220011247.35560-1-hal.feng@starfiv=
etech.com/T/#mdf67621a2344dce801aa8015d4963593a2c28bcc

I *think* the DT is correct - the fixed clocks are all inputs from clock
sources on the board and as such they are empty in soc.dtsi and are
populated in board.dts?

However, are they all actually required? In the driver I see:
	JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
		    JH7110_SYSCLK_GMAC1_RGMII_RXIN,
		    JH7110_SYSCLK_GMAC1_RMII_RTX),
That macro is:
#define JH71X0__MUX(_idx, _name, _nparents, ...) [_idx] =3D {			\
	.name =3D _name,								\
	.flags =3D 0,								\
	.max =3D ((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT,			\
	.parents =3D { __VA_ARGS__ },						\
}

AFAICT, RMII reference feeds RMII_RTX & RGMII RX *is* RGMII_RXIN?
Does that mean you need to populate only one of GMAC1 RMII reference
and GMAC1 RMGII RX and the other is optional?

What have I missed?

> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: gmac1_rmii_refin
> +      - const: gmac1_rgmii_rxin
> +      - const: i2stx_bclk_ext
> +      - const: i2stx_lrck_ext
> +      - const: i2srx_bclk_ext
> +      - const: i2srx_lrck_ext
> +      - const: tdm_ext
> +      - const: mclk_ext

If all clocks are in fact required though, isn't this kinda pointless to
have since we already know that the order is fixed from the "clocks"
property?
Krzk/Rob?

> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
> +
> +  '#reset-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@13020000 {
> +        compatible =3D "starfive,jh7110-syscrg";
> +        reg =3D <0x13020000 0x10000>;
> +        clocks =3D <&osc>, <&gmac1_rmii_refin>,
> +                 <&gmac1_rgmii_rxin>,
> +                 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> +                 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> +                 <&tdm_ext>, <&mclk_ext>;
> +        clock-names =3D "osc", "gmac1_rmii_refin",
> +                      "gmac1_rgmii_rxin",
> +                      "i2stx_bclk_ext", "i2stx_lrck_ext",
> +                      "i2srx_bclk_ext", "i2srx_lrck_ext",
> +                      "tdm_ext", "mclk_ext";
> +        #clock-cells =3D <1>;
> +        #reset-cells =3D <1>;
> +    };

Also, whatever happened to GMAC0? It has fixed-clocks defined in the DTS
but doesn't appear in the binding or driver?

Thanks,
Conor.


--5z5zKcEbEyZyLNXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6JB3wAKCRB4tDGHoIJi
0iDdAP97AduwIcoTKoPNnBB0gAM3K5QzthQrp2V3dnOQWEadiAEA7ILIoHeqrA45
dIeJz/PtVaBTaAIHfCuDn/tpoSgf/gw=
=Kng0
-----END PGP SIGNATURE-----

--5z5zKcEbEyZyLNXj--
