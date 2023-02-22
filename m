Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7379B69F2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjBVKle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBVKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:41:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E693756E;
        Wed, 22 Feb 2023 02:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677062490; x=1708598490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=og8oc3RuSx7isHJHsUxe9wkqbVmwchIzWVG+7PVsMs0=;
  b=ot0euPjuqJzHLYsUGyy3nLXSphmj6hIdfqH0Ucz5UdDTevJyR/bYBF4M
   XR0ohvH2Xx3Of5svmVIB+ZS6HwB5hyPsm3FI962RR9Su44WmwOFOO3zdV
   3tGGr12vCncrvs8Tcci/wPG4LuKmKRNvayMueWgZCjPbPP1sPs0wUwWPN
   dXfenECVMLZy4yp3xx8+7v7a1/oNah6qIge2lUtWbqARSA/IvBBqOfZim
   JChrsP5/HqOnjxJ10eTs1lfzX5kY7PsNXNUzhGuu/bmqkYY04gjp6WHBo
   4ekAmHHni/avINgmMKqi2XnY6QEwQhbgX+cZ9dQErpCjJ9ghcfxh+cION
   g==;
X-IronPort-AV: E=Sophos;i="5.97,318,1669100400"; 
   d="asc'?scan'208";a="138452374"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2023 03:41:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 03:41:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 22 Feb 2023 03:41:25 -0700
Date:   Wed, 22 Feb 2023 10:40:59 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Hal Feng <hal.feng@starfivetech.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/19] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <Y/XxOw+T0WdYY7jP@wendy>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-10-hal.feng@starfivetech.com>
 <e4c2b711-7953-821b-4281-04e4b40154ea@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A5GMe6d9NPNRqkf9"
Content-Disposition: inline
In-Reply-To: <e4c2b711-7953-821b-4281-04e4b40154ea@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--A5GMe6d9NPNRqkf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 10:13:19AM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2023 03:46, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >=20
> > Add bindings for the system clock and reset generator (SYSCRG) on the
> > JH7110 RISC-V SoC by StarFive Ltd.
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>=20
> I don't know what is happening here as neither this nor other patchset
> explains anything. Please stop writing what you do in the patches, but
> explain why. What is easy to get.
>=20
> (...)
>=20
>=20
> > +
> > +#define JH7110_SYSCLK_PLL0_OUT			190
> > +#define JH7110_SYSCLK_PLL1_OUT			191
> > +#define JH7110_SYSCLK_PLL2_OUT			192
>=20
> NAK. Do not add incorrect bindings just to remove it THE SAME TIME.

For some context, the PLL driver series [1] does the following, which is
where this complaint stems from:
> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt=
-bindings/clock/starfive,jh7110-crg.h
> index 5e4f21ca0642..086a6ddcf380 100644
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
> @@ -6,6 +6,12 @@
>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> =20
> +/* PLL clocks */
> +#define JH7110_CLK_PLL0_OUT			0
> +#define JH7110_CLK_PLL1_OUT			1
> +#define JH7110_CLK_PLL2_OUT			2
> +#define JH7110_PLLCLK_END			3
> +
>  /* SYSCRG clocks */
>  #define JH7110_SYSCLK_CPU_ROOT			0
>  #define JH7110_SYSCLK_CPU_CORE			1
> @@ -198,11 +204,7 @@
>  #define JH7110_SYSCLK_TDM_TDM_INV		188
>  #define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
> =20
> -#define JH7110_SYSCLK_PLL0_OUT			190
> -#define JH7110_SYSCLK_PLL1_OUT			191
> -#define JH7110_SYSCLK_PLL2_OUT			192

I was talking to Emil, who pointed out that these defines aren't
actually ever used in the dts, so there's nothing really gained
by adding them here in the first place.
Seems like this series could simply move these defines into the driver
(as the PLL addition series also does) and then we would not have to
be worried about breaking the ABI in the future?

Thanks,
Conor.

1 - https://patchwork.kernel.org/project/linux-riscv/patch/20230221141147.3=
03642-3-xingyu.wu@starfivetech.com/


--A5GMe6d9NPNRqkf9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/XxOwAKCRB4tDGHoIJi
0ouHAQD1J4/fzbT7Ija75eE1nauMe2czMcMbWAzQIL1nwqgxdAD9GIT1Ap0dMr5V
1t1LqyevhjLJUO2GrLIxTX8k1p6Zqw8=
=KcGW
-----END PGP SIGNATURE-----

--A5GMe6d9NPNRqkf9--
