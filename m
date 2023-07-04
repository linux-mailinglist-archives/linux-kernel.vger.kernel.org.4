Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3816747764
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGDRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFFBE5B;
        Tue,  4 Jul 2023 10:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9543261302;
        Tue,  4 Jul 2023 17:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659C3C433C7;
        Tue,  4 Jul 2023 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688490184;
        bh=y9AqRwh1On0/kat6LbvFNyQPBwODOA6fSWAazX4k2/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PksoyIFvpPZRdzl45MPP+VGF5sO9LknMMYjedKXz+n0nj1gpF9Tj0G2vE9CmjZP+Y
         U7vOaUpIxZ5vIvOyk0uB7U30iSXFx/wAFd8+S+ieMIPHZ36+gPVIuvk6A62o1juUP+
         uqrEMxDtAI3GbEa1MQAs89z67oLkaclTZVxAgYACSDdjVqHT3HVmWT6zQfG1f4eHql
         mijQ7OQ3soPWIYx4EeUTZ5KGQeKSNBFatIfevjlF090tbWxQkufUSOhdOQowIHLWHg
         yTP88J1xHEPm3nLDTqo5ODVS+LQmlm5s4lrMtOfLt0M3DSOPtowB41ezU7yoai6P25
         DhHx9XoYifFbA==
Date:   Tue, 4 Jul 2023 18:02:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, kelvin.zhang@amlogic.com,
        xianwei.zhao@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 5/5] arm64: dts: meson: a1: change uart compatible
 string
Message-ID: <20230704-cannabis-cannon-19397cd806bc@spud>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-6-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EumZIp4agBc2nn9+"
Content-Disposition: inline
In-Reply-To: <20230704135936.14697-6-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EumZIp4agBc2nn9+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 04:59:36PM +0300, Dmitry Rokosov wrote:
> In the current implementation, the meson-a1 configuration incorporates a
> unique compatibility tag "amlogic,meson-a1-uart' within the meson-uart
> driver due to its usage of the new console device name "ttyS".
> Consequently, the previous compatibility tag designated for the
> 'amlogic,meson-gx-uart' configuration has become obsolete and is no
> longer relevant to the current setup.

I don't really see why you would remove the gx-uart to be honest, and
not use it as a fallback. Neil's platform though, so his call :)

>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-a1.dtsi
> index c5567031ba12..6273b9c862b3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -344,7 +344,7 @@ mux {
>  			};
> =20
>  			uart_AO: serial@1c00 {
> -				compatible =3D "amlogic,meson-gx-uart",
> +				compatible =3D "amlogic,meson-a1-uart",
>  					     "amlogic,meson-ao-uart";
>  				reg =3D <0x0 0x1c00 0x0 0x18>;
>  				interrupts =3D <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> @@ -354,7 +354,7 @@ uart_AO: serial@1c00 {
>  			};
> =20
>  			uart_AO_B: serial@2000 {
> -				compatible =3D "amlogic,meson-gx-uart",
> +				compatible =3D "amlogic,meson-a1-uart",
>  					     "amlogic,meson-ao-uart";
>  				reg =3D <0x0 0x2000 0x0 0x18>;
>  				interrupts =3D <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> --=20
> 2.36.0
>=20

--EumZIp4agBc2nn9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKRQwQAKCRB4tDGHoIJi
0ni8AP9/Huiz85MEd1lWfxM1nHhevdkGu63rvkUGrwObPKXQFQEA+lioxbMrhHvJ
V5pJjDNClLTeb0b2t8nCYmO1W1jkzgA=
=H4B/
-----END PGP SIGNATURE-----

--EumZIp4agBc2nn9+--
