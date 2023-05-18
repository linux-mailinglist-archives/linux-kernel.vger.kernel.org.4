Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218A770884F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjERTYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FAAE51;
        Thu, 18 May 2023 12:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01533650EA;
        Thu, 18 May 2023 19:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C3FC433EF;
        Thu, 18 May 2023 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684437868;
        bh=9y5z0Zh9SKhRJ32I+c6VHljZLGX++RZUWFETdlqq5/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enQ75GL1FCW38vWayzQ/Op9Ry1yLQtGXwICdKzhVl7iHy5v02MBr6CJo0DTDNkmAJ
         3pr81/lnc/Cm+nkpOyTVV3bbkdoc6W9hfSNN9XlNNbbPeNrb6k1KOSKbrIa3UwGJso
         1OC6xBtPel3MbuFGfdWwdoK5YnkRnoPDb8xQObBxOMYmavgPAiGmTe3pVcQjsDHBsQ
         G3V1GZt8/7ej+Xrs75fPfGDi6xgtzr2T4Vid33VzgByM9k+T5PnPqZk0Pp4c+WGn+A
         E4v+33Fy1UxY8QsTvTBkGHDCV62U01u6w7FSxnTgyKmCyznqSq/VLPMEZrV33P9ebZ
         y3wY6AqaCxIzg==
Date:   Thu, 18 May 2023 20:24:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: sc16is7xx: Add property to
 change GPIO function
Message-ID: <20230518-paralegal-stalemate-837e59310526@spud>
References: <20230518132905.4182265-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QUo98p4l0BRHVwjm"
Content-Disposition: inline
In-Reply-To: <20230518132905.4182265-1-hugo@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QUo98p4l0BRHVwjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 09:29:06AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Some variants in this series of uart controllers have GPIO pins that
> are shared between GPIO and modem control lines.
>=20
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
>=20
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

On the basis of similarity to existing properties due to my lack of
understanding of the hardware it'll have to be an Ack. Hopefully Greg &
Co. have more specific insight.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> v1 -> v2: Add nxp vendor prefix
>           Add git base-commit
>=20
>  .../bindings/serial/nxp,sc16is7xx.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b=
/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index 0fa8e3e43bf8..23a81c83f012 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -23,6 +23,9 @@ Optional properties:
>      1 =3D active low.
>  - irda-mode-ports: An array that lists the indices of the port that
>  		   should operate in IrDA mode.
> +- nxp,modem-control-line-ports: An array that lists the indices of the p=
ort that
> +				should have shared GPIO lines configured as modem
> +				control lines.
> =20
>  Example:
>          sc16is750: sc16is750@51 {
> @@ -35,6 +38,17 @@ Example:
>                  #gpio-cells =3D <2>;
>          };
> =20
> +	sc16is752: sc16is752@54 {
> +		compatible =3D "nxp,sc16is752";
> +		reg =3D <0x54>;
> +		clocks =3D <&clk20m>;
> +		interrupt-parent =3D <&gpio3>;
> +		interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +		nxp,modem-control-line-ports =3D <1>; /* Port 1 as modem control lines=
 */
> +		gpio-controller; /* Port 0 as GPIOs */
> +		#gpio-cells =3D <2>;
> +	};
> +
>  * spi as bus
> =20
>  Required properties:
> @@ -59,6 +73,9 @@ Optional properties:
>      1 =3D active low.
>  - irda-mode-ports: An array that lists the indices of the port that
>  		   should operate in IrDA mode.
> +- nxp,modem-control-line-ports: An array that lists the indices of the p=
ort that
> +				should have shared GPIO lines configured as modem
> +				control lines.
> =20
>  Example:
>  	sc16is750: sc16is750@0 {
> @@ -70,3 +87,14 @@ Example:
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
>  	};
> +
> +	sc16is752: sc16is752@0 {
> +		compatible =3D "nxp,sc16is752";
> +		reg =3D <0>;
> +		clocks =3D <&clk20m>;
> +		interrupt-parent =3D <&gpio3>;
> +		interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +		nxp,modem-control-line-ports =3D <1>; /* Port 1 as modem control lines=
 */
> +		gpio-controller; /* Port 0 as GPIOs */
> +		#gpio-cells =3D <2>;
> +	};
>=20
> base-commit: 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff
> --=20
> 2.30.2
>=20

--QUo98p4l0BRHVwjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZ7ZwAKCRB4tDGHoIJi
0uYTAP4tDKRMsIUu27At7Dk9yy1NuplvDrXUPMlw3rnjrRmOmwEAmuKoF33s1VNw
warqgbiHQMVfMdj05TKNmJkIWuInbAI=
=xMCv
-----END PGP SIGNATURE-----

--QUo98p4l0BRHVwjm--
