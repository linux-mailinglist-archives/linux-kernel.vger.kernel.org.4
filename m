Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED3D6F9BEF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjEGV1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEGV1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FEA30C7;
        Sun,  7 May 2023 14:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 765E561D23;
        Sun,  7 May 2023 21:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A472C433D2;
        Sun,  7 May 2023 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683494836;
        bh=TdiB9qq4NKwSAWAk561rIMN33nbPQBYWdvZc4tGL7o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Whs5HRMRpIZg1LqDq/3Cn/M5Xz0P1VsyMK4Rr9vuheEMXt/lvcn0SqUb81ef+QcXa
         +JOLPEuoBEPQlL5bvwqmgMV3c8EbrljPixPnBQutAtfUKxmxccZPzf8RFIGjHZ1tXO
         vKMWIyNKcbHHgqtGxn8PG8W+KKAFyHT0SsNo0f4+hnAmOtwQ1FuN3KI1K6kgGVpoPz
         ST7PTgadGfSS9hEwRczZo8Ao5OWV0l+AgsGl5s8TXDQLyLDHBY02WO2QpayWhywgDW
         8ci2eEFWZi751AxVVc9t0Wm0vHn74Qh+aekItB5Q+96m+/kqWMkmui5yQUiT90kK7/
         id9IarPpw7AZw==
Date:   Sun, 7 May 2023 22:27:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 4/5] riscv: dts: thead: add sipeed Lichee Pi 4A board
 device tree
Message-ID: <20230507-splashed-pulverize-3f0e6f4dce09@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hEbItDNiZnP7w/mU"
Content-Disposition: inline
In-Reply-To: <20230507182304.2934-5-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hEbItDNiZnP7w/mU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Mon, May 08, 2023 at 02:23:03AM +0800, Jisheng Zhang wrote:
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's light(a.k.a TH1520) SoC. Add
> minimal device tree files for the core module and the development
> board.
>=20
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.

There are quite a lot of dtbs_check warnings etc produced by this patch.
RISC-V is *almost* W=3D1 clean for dtbs_check & I'd like to get that to
clean once the non-coherent DMA situation for Renesas is sorted out.
That said, I think some of the issues I noticed will crop up at the
default warning level too.

Please fix all of the W=3D1 complaints from dtbs_check, which will require
the creation of some additional dt-bindings.

>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/thead/Makefile            |  2 +
>  .../dts/thead/light-lichee-module-4a.dtsi     | 38 +++++++++++++++++++
>  .../boot/dts/thead/light-lichee-pi-4a.dts     | 32 ++++++++++++++++
>  4 files changed, 73 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/thead/Makefile
>  create mode 100644 arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi

As I mentioned in one of the earlier patches, I don't think using
"light" here is all that great. I would much rather see "th1520" used
instead.

Thanks,
Conor.

>  create mode 100644 arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts
>=20
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index f0d9f89054f8..1e884868ccba 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -2,6 +2,7 @@
>  subdir-y +=3D allwinner
>  subdir-y +=3D sifive
>  subdir-y +=3D starfive
> +subdir-y +=3D thead
>  subdir-y +=3D canaan
>  subdir-y +=3D microchip
>  subdir-y +=3D renesas
> diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/the=
ad/Makefile
> new file mode 100644
> index 000000000000..9e00acc714cc
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_THEAD) +=3D light-lichee-pi-4a.dtb
> diff --git a/arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi b/arch=
/riscv/boot/dts/thead/light-lichee-module-4a.dtsi
> new file mode 100644
> index 000000000000..24c9971e0fb5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "light.dtsi"
> +
> +/ {
> +	model =3D "Sipeed Lichee Module 4A";
> +	compatible =3D "sipeed,lichee-module-4a", "thead,light";
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x00000000 0x2 0x00000000>;
> +	};
> +};
> +
> +&osc {
> +	clock-frequency =3D <24000000>;
> +};
> +
> +&osc_32k {
> +	clock-frequency =3D <32768>;
> +};
> +
> +&apb_clk {
> +	clock-frequency =3D <62500000>;
> +};
> +
> +&uart_sclk {
> +	clock-frequency =3D <100000000>;
> +};
> +
> +&dmac0 {
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts b/arch/risc=
v/boot/dts/thead/light-lichee-pi-4a.dts
> new file mode 100644
> index 000000000000..4f0ba2149d2d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include "light-lichee-module-4a.dtsi"
> +
> +/ {
> +	model =3D "Sipeed Lichee Pi 4A";
> +	compatible =3D "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", "thead=
,light";
> +
> +	aliases {
> +		gpio0 =3D &gpio0;
> +		gpio1 =3D &gpio1;
> +		gpio2 =3D &gpio2;
> +		gpio3 =3D &gpio3;
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart1;
> +		serial2 =3D &uart2;
> +		serial3 =3D &uart3;
> +		serial4 =3D &uart4;
> +		serial5 =3D &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> --=20
> 2.40.0
>=20

--hEbItDNiZnP7w/mU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFgXrwAKCRB4tDGHoIJi
0oa9AQDiwUgCT1AKpn8T2OoNS/mDSGlA+akXB2lE6u0XR3jD1wD/bDxIuIFiLXPx
ZeKuZotqXSv3MT1GuGKgw6wX6JRfvw0=
=TftX
-----END PGP SIGNATURE-----

--hEbItDNiZnP7w/mU--
