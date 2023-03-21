Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4B6C3D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCUWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCUWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:10:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920715616C;
        Tue, 21 Mar 2023 15:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44318B81A45;
        Tue, 21 Mar 2023 22:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3110FC4339C;
        Tue, 21 Mar 2023 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679436644;
        bh=mfr9fG06tR438k4STzbE8QTvsfW2C1ylBqMRXPVQzNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckVoLi4r7wAJZqyh6+001a2rlhgVmtYyuKMX1L1Zw/rsSRwF9WyUZ+hOYHFc4TiyM
         Gl8zXAfAl8J9fCaDilvo5NaQ3KQUGIX9fMLRaP5CArQ7DoJzZn6Q07nNLLHeQTEGev
         2Ii+nyioMjsu+EYmfCnHTog7S2gsNOjwNfA723KcR/LyDb/RQODoSZr16XihsciINx
         V27lR/XlZjSzxPvFI7wCMd83S4TAwAEjKxw86HALJbAGa3mYOAjQhDgzehIPdCMxAG
         H/cKxaJ/9GeI5nVQ1YW+3tHU56X+yM/6I9r53Zp4v1St/fv7Rw2/cBoeYikge8/IXc
         //RnfHLeJzaZg==
Date:   Tue, 21 Mar 2023 22:10:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 06/10] riscv: dts: allwinner: d1: Switch dma-names
 order for snps,dw-apb-uart nodes
Message-ID: <f8a9f9e8-d0b0-4336-8d99-8dbe4792b0ff@spud>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-7-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KzlbqE6ZgU3zkHvJ"
Content-Disposition: inline
In-Reply-To: <20230321215624.78383-7-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KzlbqE6ZgU3zkHvJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 11:56:20PM +0200, Cristian Ciocaltea wrote:
> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> dma-names properties") documented dma-names property to handle Allwinner
> D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
> reverse of what a bunch of different boards expect.
>=20
> The initial proposed solution was to allow a flexible dma-names order in
> the binding, due to potential ABI breakage concerns after fixing the DTS
> files. But luckily the Allwinner boards are not affected, since they are
> using a shared DMA channel for rx and tx.
>=20
> Hence, the first step in fixing the inconsistency was to change
> dma-names order in the binding to tx->rx.
>=20
> Do the same for the snps,dw-apb-uart nodes in the DTS file.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index 951810d46307..922e8e0e2c09 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -211,7 +211,7 @@ uart0: serial@2500000 {
>  			clocks =3D <&ccu CLK_BUS_UART0>;
>  			resets =3D <&ccu RST_BUS_UART0>;
>  			dmas =3D <&dma 14>, <&dma 14>;
> -			dma-names =3D "rx", "tx";
> +			dma-names =3D "tx", "rx";
>  			status =3D "disabled";
>  		};
> =20
> @@ -224,7 +224,7 @@ uart1: serial@2500400 {
>  			clocks =3D <&ccu CLK_BUS_UART1>;
>  			resets =3D <&ccu RST_BUS_UART1>;
>  			dmas =3D <&dma 15>, <&dma 15>;
> -			dma-names =3D "rx", "tx";
> +			dma-names =3D "tx", "rx";
>  			status =3D "disabled";
>  		};
> =20
> @@ -237,7 +237,7 @@ uart2: serial@2500800 {
>  			clocks =3D <&ccu CLK_BUS_UART2>;
>  			resets =3D <&ccu RST_BUS_UART2>;
>  			dmas =3D <&dma 16>, <&dma 16>;
> -			dma-names =3D "rx", "tx";
> +			dma-names =3D "tx", "rx";
>  			status =3D "disabled";
>  		};
> =20
> @@ -250,7 +250,7 @@ uart3: serial@2500c00 {
>  			clocks =3D <&ccu CLK_BUS_UART3>;
>  			resets =3D <&ccu RST_BUS_UART3>;
>  			dmas =3D <&dma 17>, <&dma 17>;
> -			dma-names =3D "rx", "tx";
> +			dma-names =3D "tx", "rx";
>  			status =3D "disabled";
>  		};
> =20
> @@ -263,7 +263,7 @@ uart4: serial@2501000 {
>  			clocks =3D <&ccu CLK_BUS_UART4>;
>  			resets =3D <&ccu RST_BUS_UART4>;
>  			dmas =3D <&dma 18>, <&dma 18>;
> -			dma-names =3D "rx", "tx";
> +			dma-names =3D "tx", "rx";
>  			status =3D "disabled";
>  		};
> =20
> @@ -276,7 +276,7 @@ uart5: serial@2501400 {
>  			clocks =3D <&ccu CLK_BUS_UART5>;
>  			resets =3D <&ccu RST_BUS_UART5>;
>  			dmas =3D <&dma 19>, <&dma 19>;
> -			dma-names =3D "rx", "tx";
> +			dma-names =3D "tx", "rx";
>  			status =3D "disabled";
>  		};
> =20
> --=20
> 2.40.0
>=20

--KzlbqE6ZgU3zkHvJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBorXQAKCRB4tDGHoIJi
0p8hAPwNZN4px8bHQL5f0TgePXjswSwIfbsgjkqeQp9hZoyhkAEArAl9T2v+Z7D2
rsSBPirCRfx6Kq67c+Sbdcvr38dz4wc=
=mraI
-----END PGP SIGNATURE-----

--KzlbqE6ZgU3zkHvJ--
