Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BE568F3A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjBHQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBHQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:44:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE002D60;
        Wed,  8 Feb 2023 08:44:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22F27B81ED3;
        Wed,  8 Feb 2023 16:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5950C433D2;
        Wed,  8 Feb 2023 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874591;
        bh=9JnV3h9dVys98lzdeX7nLKiew6Xl3wZrBHZ3W+YcEV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVf7PoPR0hfFREHoNOntlFKcTWcwIEawIPfSU4oA0o+namPfcpnELDHhsKGZ7+fCO
         /908A6h77w8wfHs97Oh5qBsYnqOBSm1OTlIB+DyYkZTZd1eztbXcnAix+5cEFonI8M
         9MblElIhNvZdsIly571mIkuVeE0AdDTVO5uKP1e4uo/gE0pmBD9ePYLYDD72QS8syD
         6npy2WkXvy8MhU3l230C3zju6IJDPusKOF1qWRnw4zOfFlHsl1j7VW9A6SjjGUPoN2
         GOpwrcRCY2Ctg6FNmo9x6h5U4Bh5EzCDiD+U7jzpuGEYQZmT2DL/hMF6/1JRBC2nFb
         q6E3jf+uuWwuA==
Date:   Wed, 8 Feb 2023 16:43:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] riscv: dts: nezha-d1: add gpio-line-names
Message-ID: <Y+PRGjn8a26pe5Dy@spud>
References: <20230208014504.18899-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S4azWlTkoRx3v2FI"
Content-Disposition: inline
In-Reply-To: <20230208014504.18899-1-twoerner@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S4azWlTkoRx3v2FI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Trevor,

On Tue, Feb 07, 2023 at 08:45:03PM -0500, Trevor Woerner wrote:
> Add descriptive names so users can associate specific lines with their
> respective pins on the 40-pin header according to the schematics found at:
>=20
> 	http://dl.linux-sunxi.org/D1/D1_Nezha_development_board_schematic_diagra=
m_20210224.pdf

Dunno about the sunxi folk, but ideally that'd be a Link: tag IMO.

>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/ris=
cv/boot/dts/allwinner/sun20i-d1-nezha.dts
> index a0769185be97..33489c7619cb 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> @@ -90,6 +90,15 @@ pcf8574a: gpio@38 {
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
>  		#interrupt-cells =3D <2>;
> +		gpio-line-names =3D
> +			"pin13 [PP0,gpio8] ",
> +			"pin16 [PP1,gpio10]",
> +			"pin18 [PP2,gpio11]",
> +			"pin26 [PP3,gpio17]",
> +			"pin22 [PP4,gpio14]",
> +			"pin28 [PP5,gpio19]",
> +			"pin37 [PP6,gpio23]",
> +			"pin11 [PP7,gpio6] ";

dtbs_check does not like this:
arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb: gpio@38: 'gpio-line-name=
s' does not match any of the regexes: '^(.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9=
]+'
        From schema: Documentation/devicetree/bindings/gpio/nxp,pcf8575.yaml

>  	};
>  };
> =20
> @@ -164,3 +173,47 @@ &usbphy {
>  	usb1_vbus-supply =3D <&reg_vcc>;
>  	status =3D "okay";
>  };
> +
> +&pio {
> +	gpio-line-names =3D
> +		/* Port A */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* Port B */
> +		"pin5  [PB0, gpio2/twi2-sck]",
> +		"pin3  [PB1, gpio1/twi2-sda]",
> +		"",
> +		"pin38 [PB3, gpio24/i2s2-din]",
> +		"pin40 [PB4, gpio25/i2s2-dout]",
> +		"pin12 [PB5, gpio7/i2s-clk]",
> +		"pin35 [PB6, gpio22/i2s2-lrck]",
> +		"",
> +		"pin8  [PB8, gpio4/uart0-txd]",
> +		"pin10 [PB9, gpio5/uart0-rxd]",
> +		"",
> +		"",
> +		"pin15 [PB12,gpio9]",

Why not pick a consistent styling w.r.t. the space between PB#, & gpio?

Cheers,
Conor.

> +		"", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* Port C */
> +		"",
> +		"pin31 [PC1, gpio21]",
> +		"", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* Port D */
> +		"", "", "", "", "", "", "", "",
> +		"", "",
> +		"pin24 [PD10,gpio16/spi1-ce0]",
> +		"pin23 [PD11,gpio15/spi1-clk]",
> +		"pin19 [PD12,gpio12/spi1-mosi]",
> +		"pin21 [PD13,gpio13/spi1-miso]",
> +		"pin27 [PD14,gpio18/spi1-hold]",
> +		"pin29 [PD15,gpio20/spi1-wp]",
> +		"", "", "", "", "", "",
> +		"pin7  [PD22,gpio3/pwm]";
> +};
> --=20
> 2.36.0.rc2.17.g4027e30c53
>=20

--S4azWlTkoRx3v2FI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+PRGgAKCRB4tDGHoIJi
0iRiAP4vgkyStKLRofn1o81fjP/aeDkslORttfK0szBbB8AwZgD7B96WjbtVAZkn
oXsPbP3B0H5zboAMRKCEfxhs0feWaQY=
=E3Jw
-----END PGP SIGNATURE-----

--S4azWlTkoRx3v2FI--
