Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8D6DD641
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDKJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDKJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:08:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C83448B;
        Tue, 11 Apr 2023 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681204022; x=1712740022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vEZy6BehLxjne3ptGrDQ5tuFpZWO8/3pHXdX7Cm/X0w=;
  b=P9ktXEDzgCNa6OzamQ3C7TpP2wmTaCuL8tjqG3MnpW3xsJbqPD/87wYz
   O1EC/D0+GzCIcKLwphnEZ9zI+eObF+7oKzBDgj3f8g7xjPv7F6QbKAsnS
   mSsXbOin4aNYaWpm1nTVnz+J53dac6mNX3xWvFpezFCzk/xjhwYypHuyl
   vAYTuiI4YTItJqPgqv4nTU7YgF4YIpJ9HeWZlczJbp0WAsnT5haX4Scws
   3eOOHGlnEBX1E8VUAkyztOJwm3ucIOpoYjwRqruTZwg2mQ/6Sfyi7VmIC
   QOhCcA4hEvOiaQd7mwfQNIzCwm+Q6TruPtKeMGT/5gsLUv1erDDcuiMAS
   w==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="146439286"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 02:06:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 02:06:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 02:06:22 -0700
Date:   Tue, 11 Apr 2023 10:06:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mason Huo <mason.huo@starfivetech.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: Add cpu scaling for JH7110
 SoC
Message-ID: <20230411-darling-chump-faaf8dec29ef@wendy>
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
 <20230411083257.16155-4-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9RmMYoUwAG4qQ11d"
Content-Disposition: inline
In-Reply-To: <20230411083257.16155-4-mason.huo@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9RmMYoUwAG4qQ11d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Mason,

On Tue, Apr 11, 2023 at 04:32:57PM +0800, Mason Huo wrote:
> Add the operating-points-v2 to support cpu scaling
> on StarFive JH7110 SoC.

(btw, there's no need to wrap commit messages at 52 columns, you have
72 to work with)

> It supports up to 4 cpu frequency loads.
>=20
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 25 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 25 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index df582bddae4b..ae446b268e78 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -228,3 +228,28 @@ &uart0 {
>  	pinctrl-0 =3D <&uart0_pins>;
>  	status =3D "okay";
>  };
> +
> +&U74_1 {
> +	clocks =3D  <&syscrg JH7110_SYSCLK_CPU_CORE>;
> +	clock-names =3D "cpu";
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&U74_2 {
> +	clocks =3D  <&syscrg JH7110_SYSCLK_CPU_CORE>;
> +	clock-names =3D "cpu";
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&U74_3 {
> +	clocks =3D  <&syscrg JH7110_SYSCLK_CPU_CORE>;
> +	clock-names =3D "cpu";
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&U74_4 {
> +	clocks =3D  <&syscrg JH7110_SYSCLK_CPU_CORE>;
                ^^
There's a double space in each of these.

> +	clock-names =3D "cpu";
> +	cpu-supply =3D <&reg_dcdc2>;
> +};

How come these two clock properties are being added in <board>.dtsi?
Should they not be in <soc>.dtsi?

Thanks,
Conor.

--9RmMYoUwAG4qQ11d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDUi/gAKCRB4tDGHoIJi
0nEZAP9rj/CuBXvNfE91n2hagQY3313ZTlg0J0xHWjSonAhoBwD/cwrCXvzzmaqL
aVdM9JA8ul3lc3HBxlANw2iL7G3eWAI=
=Ix5Y
-----END PGP SIGNATURE-----

--9RmMYoUwAG4qQ11d--
