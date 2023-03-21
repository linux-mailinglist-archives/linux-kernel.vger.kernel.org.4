Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D26C2FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCULNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCULNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:13:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB041497E7;
        Tue, 21 Mar 2023 04:12:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32LBCQFB054151;
        Tue, 21 Mar 2023 06:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679397146;
        bh=rXuLtU1pZ40qZvDNdt+V9zhkGzYkX+ffaLxrbzmMbcw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JBc6OUA8GPUC4NAWb5ROZvYb16YRpGoParwH0y2S/hT57PgIzWQSXC3IJSlG0xvGB
         3L6udntf5X+qnc99kd/f2K5INM7c2E2vVJcwrCK6Nq9yG/ZN2OUL8NSIvuMlCO32IE
         TrF0QW0IQIaT0XDfq6ib583wjKz1Okn4FAq52KNI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32LBCQnT004313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Mar 2023 06:12:26 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Mar 2023 06:12:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Mar 2023 06:12:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32LBCPDd093286;
        Tue, 21 Mar 2023 06:12:26 -0500
Date:   Tue, 21 Mar 2023 16:42:28 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v3 1/4] arm64: dts: ti: k3-j721e: Add MCSPI nodes
Message-ID: <20230321111228.v4nml7vztoomsiu6@uda0497096>
References: <20230321082827.14274-1-vaishnav.a@ti.com>
 <20230321082827.14274-2-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pjobgbjytsuuhyuz"
Content-Disposition: inline
In-Reply-To: <20230321082827.14274-2-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pjobgbjytsuuhyuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vaishnav,

Thanks for the series.

On Mar 21, 2023 at 13:58:24 +0530, Vaishnav Achath wrote:
> J721E has 8 MCSPI instances in the main domain and 3 instances
> in the MCU domain. Add the DT nodes for all the 11 instances and
> keep them disabled. MAIN_MCSPI4 is connected as a slave to MCU_MCSPI2
> by default at power-up, MAIN_MCSPI4 and MCU_MCSPI2 are not pinned out
> externally.
>=20
> Co-developed-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V2->V3:
>  * Update commit message to mention internal MCSPI loopback.
>=20
> V1->V2:=20
>   * Combine main, mcu domain, MCSPI node addition changes
>   to single commit.
>=20
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 88 +++++++++++++++++++
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 33 +++++++
>  2 files changed, 121 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-j721e-main.dtsi
> index bfa296dce3a3..a90f076776ce 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -2328,4 +2328,92 @@
>  		bosch,mram-cfg =3D <0x0 128 64 64 64 64 32 32>;
>  		status =3D "disabled";
>  	};
> +
> +	main_spi0: spi@2100000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02100000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 266 1>;
> +		status =3D "disabled";
> +	};
> +
> +	main_spi1: spi@2110000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02110000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 267 1>;
> +		status =3D "disabled";
> +	};
> +
> +	main_spi2: spi@2120000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02120000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 268 1>;
> +		status =3D "disabled";
> +	};
> +
> +	main_spi3: spi@2130000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02130000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 269 1>;
> +		status =3D "disabled";
> +	};
> +
> +	main_spi4: spi@2140000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02140000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 270 1>;
> +		status =3D "disabled";
> +	};
> +
> +	main_spi5: spi@2150000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02150000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 271 1>;
> +		status =3D "disabled";
> +	};
> +
> +	main_spi6: spi@2160000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02160000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 272 1>;
> +		status =3D "disabled";
> +	};
> +
> +	main_spi7: spi@2170000 {
> +		compatible =3D "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg =3D <0x00 0x02170000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 273 1>;
> +		status =3D "disabled";
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64=
/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 8ac78034d5d6..24e8125db8c4 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -425,4 +425,37 @@
>  		bosch,mram-cfg =3D <0x0 128 64 64 64 64 32 32>;
>  		status =3D "disabled";
>  	};
> +
> +	mcu_spi0: spi@40300000 {
> +		compatible =3D "ti,am654-mcspi", "ti,omap4-mcspi";
> +		reg =3D <0x00 0x040300000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 274 0>;
> +		status =3D "disabled";
> +	};
> +
> +	mcu_spi1: spi@40310000 {
> +		compatible =3D "ti,am654-mcspi", "ti,omap4-mcspi";
> +		reg =3D <0x00 0x040310000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 275 0>;
> +		status =3D "disabled";
> +	};
> +
> +	mcu_spi2: spi@40320000 {
> +		compatible =3D "ti,am654-mcspi", "ti,omap4-mcspi";
> +		reg =3D <0x00 0x040320000 0x00 0x400>;
> +		interrupts =3D <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-domains =3D <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
> +		clocks =3D <&k3_clks 276 0>;
> +		status =3D "disabled";
> +	};
>  };
> --=20
> 2.17.1
>=20
>=20

--pjobgbjytsuuhyuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmQZkRkACgkQQ96R+SSa
cUWjEg//WIGa1mA56J8rs77IYCZHZG3uMg4WtTVkWl/rqWZlHWqOpbJPl6AjoXgI
ANt+6Bs+PiooKCa4mNHCVyP8vLiVeHpZAqzDzPbxmQ4sf6JDqR5h06CA5RACRlfH
ppL5o5snX4doUaStwR8BuHSoiuV5b7KAPlIs/+H1IVqWlcpWJgU7w/XtTinUdm0v
bxcP2QAb0IhHN3ZZdCPJ6YGtfrtclPmH4e8GVFfIaqz3iFgRqS0kfwxGilKOwcCj
jrCv1FvUcqYjQkf9f0nl3iX3IZtRwW9lM0qL1AyxWBLFoEQr6O2WEFljTnRf5Aol
NTgwsfuY2U0iYtHBNOJQu4cBPV9v8766IprcrSwyu1ObMzEcFzHfrU61wv1xTBR/
GkfT7VHgSniM4bWmEbNZ2nBMF2s6HKqhKgClqdG9DKh6sU+uqH5UuwGChwxyIG0k
Av7KblvM4dGIG09LK68dTQN7fsjzaEBFqAXIwbGqxx2f1zwMJz2t6MEnFc27st/y
kBq2F53r+2vtqOaqxBBeywwUSunLuYbNQfTsea5KHrRGE+I9v5e6MuSXjDUXgXID
gFnRJy2Nv+5RMVmfLM0wH49Pnl9KnAHSduJ9Q7yRGOMSuZ5qRsSJMZHFUHWNTx57
5AeNFa01hmYgW2+d+hC1z+viW+8omwFxyjOwbjOMeqbTkhJ4/hc=
=wxRq
-----END PGP SIGNATURE-----

--pjobgbjytsuuhyuz--
