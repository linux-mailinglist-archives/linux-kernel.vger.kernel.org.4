Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA5683561
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjAaSd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjAaSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:33:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576635A821;
        Tue, 31 Jan 2023 10:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F4FAB81E54;
        Tue, 31 Jan 2023 18:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E55BC433A0;
        Tue, 31 Jan 2023 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675189926;
        bh=VHWZ/wBpzz25yASOrx7kkTEU4WZv4A8V9MHXNzW/axE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZ2CuIIB93ZQkatOQPR8FUia3GQiuqyEXEvLHdvtFYMhZDDoUJaztNrA5pwz5MonL
         VwlKy8wSLmIEy+MYgXsCJMv1gMUxe+h0uDF9UNsPnxu3D4PT0tkv8RxHH5QOjViiod
         CAzXrMRb87tGD9HaMbpmhwiNuQfngFOyV3Skqu6bKKRdXIRO4yNL8QFZQu5dZApr1w
         reY24xd7EYj+yGH/1bIPZ2MV/Vq4xWtGnJm1/ZIqGdWg2CNVGEHhVZqkv6kfPWvIne
         AJiMoq8Wji/HJw4USdNUKPsq9PUaPOIaUQLobHf+/9M/3czZdHGg4ojAbI2Lp8wE23
         l1qu8599Pd8DQ==
Date:   Tue, 31 Jan 2023 18:31:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, emil.renner.berthing@canonical.com,
        geert+renesas@glider.be, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Subject: Re: [PATCH v2 1/2] riscv: dts: sifive: unleashed/unmatched: Remove
 PWM controlled LED's active-low properties
Message-ID: <Y9len4GinXQ101xr@spud>
References: <20230130093229.27489-1-nylon.chen@sifive.com>
 <20230130093229.27489-2-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KT0CNMtZmPOxL+YU"
Content-Disposition: inline
In-Reply-To: <20230130093229.27489-2-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KT0CNMtZmPOxL+YU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nylon,

On Mon, Jan 30, 2023 at 05:32:28PM +0800, Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.
>=20
> The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schemat=
ics-v3.pdf[1].
>=20
> [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453=
f8698_hifive-unleashed-a00-schematics-1.pdf
> [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76=
f4192_hifive-unmatched-schematics-v3.pdf

Ideally these would be:
Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f=
8698_hifive-unleashed-a00-schematics-1.pdf [0]
so that they integrate nice with the git trailers mechanism.
If you resend, please update them to regular link tags.

I checked out the circuits last time around and agreed that they should
not be active-low.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I expect that both patches will go through the PWM tree together, so:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 4 ----
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
>  2 files changed, 8 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 900a50526d77..7a9f336a391c 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -50,7 +50,6 @@ led-controller {
> =20
>  		led-d1 {
>  			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d1";
> @@ -58,7 +57,6 @@ led-d1 {
> =20
>  		led-d2 {
>  			pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d2";
> @@ -66,7 +64,6 @@ led-d2 {
> =20
>  		led-d3 {
>  			pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d3";
> @@ -74,7 +71,6 @@ led-d3 {
> =20
>  		led-d4 {
>  			pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d4";
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 07387f9c135c..11f08a545ee6 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -52,7 +52,6 @@ led-controller-1 {
> =20
>  		led-d12 {
>  			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d12";
> @@ -69,19 +68,16 @@ multi-led {
> =20
>  			led-red {
>  				pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
>  				color =3D <LED_COLOR_ID_RED>;
>  			};
> =20
>  			led-green {
>  				pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
>  				color =3D <LED_COLOR_ID_GREEN>;
>  			};
> =20
>  			led-blue {
>  				pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
>  				color =3D <LED_COLOR_ID_BLUE>;
>  			};
>  		};
> --=20
> 2.36.1
>=20

--KT0CNMtZmPOxL+YU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9lenwAKCRB4tDGHoIJi
0kmZAPwOZKVv5DxRGwppcbbAEFp/BZQP4sLaAi21f8bM4+rpcwEA75OgmBTRVxhG
OIy96MY2XY88gRoHLNgYcBDB3nhfZQ0=
=Wddn
-----END PGP SIGNATURE-----

--KT0CNMtZmPOxL+YU--
