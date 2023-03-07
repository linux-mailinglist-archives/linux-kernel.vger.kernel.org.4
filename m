Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6806AE469
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCGPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjCGPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:19:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83CE7B9AF;
        Tue,  7 Mar 2023 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678202229; x=1709738229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1UFQoVc1KhmUlZmmX46JsVapFdQK4AzDjQXMSFxCc8=;
  b=KHcxtFuZDEL5+cEtcm4ewyg7+rsWFiod8iWRX4WnVALvHv5tL1xWolgT
   Q3hJA7uGLQCyX3jR6kseke+oyF59KZ33HCA5dCaVvZ7RV8XdDol9WchcI
   a0+ZajJV960SQ3RSecCTOM+7K9efwiPHfjD3OnhN4pS1iLPMUy6mrkgx3
   ElsCaVbb5cwcq3lpFpfzUDCTYaMin1ijFrEE2hBCFZQWoOtyRj7sg97B5
   OlM1TZQM1idqhSLR9VxyaDMfXkyiCzcBo09p5i0HI/+lKFuQk/dSzVbOH
   Sjl1OCCGUFqqruB3MuXEKAKxRg9yr6HFsyJBR3A4JJCEpRSJ9HmfGgZFe
   g==;
X-IronPort-AV: E=Sophos;i="5.98,241,1673938800"; 
   d="asc'?scan'208";a="140750219"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2023 08:16:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Mar 2023 08:16:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Mar 2023 08:16:46 -0700
Date:   Tue, 7 Mar 2023 15:16:17 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 07/14] riscv: dts: microchip: add mpfs specific macb
 reset support
Message-ID: <a1be181e-d09f-4640-97a4-a209527f71fc@spud>
References: <20220909123123.2699583-1-conor.dooley@microchip.com>
 <20220909123123.2699583-8-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5b/Zg8OxUkflppoM"
Content-Disposition: inline
In-Reply-To: <20220909123123.2699583-8-conor.dooley@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5b/Zg8OxUkflppoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2022 at 01:31:16PM +0100, Conor Dooley wrote:
> The macb on PolarFire SoC has reset support which the generic compatible
> does not use. Add the newly introduced MPFS specific compatible as the
> primary compatible to avail of this support & wire up the reset to the
> clock controllers devicetree entry.
>=20
> Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Somehow I lost my own patch between the cracks..
I've gone and applied it now as v6.4 content:
https://git.kernel.org/conor/c/0e9b70c1e3623fa110fb6be553e644524228ef60

Cheers,
Conor.

> ---
>  arch/riscv/boot/dts/microchip/mpfs.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dt=
s/microchip/mpfs.dtsi
> index 499c2e63ad35..ae5839534d9c 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> @@ -234,6 +234,7 @@ clkcfg: clkcfg@20002000 {
>  			reg =3D <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
>  			clocks =3D <&refclk>;
>  			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
>  		};
> =20
>  		mmuart0: serial@20000000 {
> @@ -383,7 +384,7 @@ can1: can@2010d000 {
>  		};
> =20
>  		mac0: ethernet@20110000 {
> -			compatible =3D "cdns,macb";
> +			compatible =3D "microchip,mpfs-macb", "cdns,macb";
>  			reg =3D <0x0 0x20110000 0x0 0x2000>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> @@ -392,11 +393,12 @@ mac0: ethernet@20110000 {
>  			local-mac-address =3D [00 00 00 00 00 00];
>  			clocks =3D <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
>  			clock-names =3D "pclk", "hclk";
> +			resets =3D <&clkcfg CLK_MAC0>;
>  			status =3D "disabled";
>  		};
> =20
>  		mac1: ethernet@20112000 {
> -			compatible =3D "cdns,macb";
> +			compatible =3D "microchip,mpfs-macb", "cdns,macb";
>  			reg =3D <0x0 0x20112000 0x0 0x2000>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> @@ -405,6 +407,7 @@ mac1: ethernet@20112000 {
>  			local-mac-address =3D [00 00 00 00 00 00];
>  			clocks =3D <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
>  			clock-names =3D "pclk", "hclk";
> +			resets =3D <&clkcfg CLK_MAC1>;
>  			status =3D "disabled";
>  		};
> =20
> --=20
> 2.36.1
>=20
>=20

--5b/Zg8OxUkflppoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAdVQQAKCRB4tDGHoIJi
0g+qAP4qmdNBwd5h4ZXDqYoJdC/kw8z42IjJJaq/SKhaeExK+wEAzOK3Q5ORxwwE
P5myq6oC1hbQBpIoExbGIu7lnEqJVwM=
=ImiC
-----END PGP SIGNATURE-----

--5b/Zg8OxUkflppoM--
