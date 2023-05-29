Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3D714F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE2STh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE2STf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F990;
        Mon, 29 May 2023 11:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5012E61D52;
        Mon, 29 May 2023 18:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DB9C433EF;
        Mon, 29 May 2023 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685384372;
        bh=d96MVXdaQIQspJCuju4cldfvgSVoFLjDckwEmO2adaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+RxkvCt0656mUcXWeUlj0WhCwZ2vnap5Wy0ux7mp0HDHW+p5qEV/wfbD7fskLLbp
         oCsXe5g4l5DIm0k/HqypfeWWAwKPbbjILoBilvJ0CbHr7Vz2J06WoT3xVWKHFv+7g7
         +BiQyX3Nq1un8CBosGOeYElaeVSpKH9791Hy3U6lYxPulIgjOZKTtOA+PcMvDSHg6x
         7F2EkhlZ+1VLJGhYDjwKzMCl8MT1TWdteXchFcaJJXTxsgmUsSvyd3wHFaLUuGfdpT
         EbIFkCnFM764ykld9+K8HWKFMeI0As6oQVpyefsOU1Pc/n322yzCrpXl4/gxdeOE9W
         QMLTDBhoXAh+Q==
Date:   Mon, 29 May 2023 19:19:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 6/9] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Message-ID: <20230529-verify-sympathy-4a486a6cb2c9@spud>
References: <20230529140711.896830-1-hugo@hugovil.com>
 <20230529140711.896830-7-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HWnfav14a9y5BMK9"
Content-Disposition: inline
In-Reply-To: <20230529140711.896830-7-hugo@hugovil.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HWnfav14a9y5BMK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Some variants in this series of UART controllers have GPIO pins that
> are shared between GPIO and modem control lines.
>=20
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
>=20
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b=
/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index 0fa8e3e43bf8..74dfbbf7b2cb 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -23,6 +23,9 @@ Optional properties:
>      1 =3D active low.
>  - irda-mode-ports: An array that lists the indices of the port that
>  		   should operate in IrDA mode.
> +- nxp,modem-control-line-ports: An array that lists the indices of the p=
ort that
> +				should have shared GPIO lines configured as
> +				modem control lines.
> =20
>  Example:
>          sc16is750: sc16is750@51 {
> @@ -35,6 +38,26 @@ Example:
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
> +	sc16is752: sc16is752@54 {
> +		compatible =3D "nxp,sc16is752";
> +		reg =3D <0x54>;

If this were not a txt binding, dt_binding_check would likely complain
that you have two nodes with the same node address & 3 below.
If you end up re-submitting, could you change that please?
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--HWnfav14a9y5BMK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHTsrwAKCRB4tDGHoIJi
0u0qAQD+oyebwmnbLHw3fMF7xo44CXBt5Kuzc6FqTzYKLleiuwD+PX2NjngRUx6Y
M1+frhXmkvQeJRAlldSerTUPDb3OVwY=
=A0bN
-----END PGP SIGNATURE-----

--HWnfav14a9y5BMK9--
