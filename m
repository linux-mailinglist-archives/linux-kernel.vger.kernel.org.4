Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362DC73BC59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjFWQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFWQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2DCE42;
        Fri, 23 Jun 2023 09:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE0C061A9F;
        Fri, 23 Jun 2023 16:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D333C433C8;
        Fri, 23 Jun 2023 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687536422;
        bh=PzZ3EmR9MICcwpoqTQk53g/RvLGwPzf3GIaDJYYrG/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=od/tS904+6jb8khi59PK5j771y6tflzReQ2ngFWZxeUWfzcSsPpGaHiBYmOKseW5/
         r1fPB7hhaMzGXqsSyZ6bOvJMXsaN55xEKfFHyoVHNGAsBcfiBF+mTMFB8cNKo3KAd9
         c+DD8xSIHYJglw9pqz8RKIp8+ZseIVKgBgZZruAJ5MwovkURFZYKPiW9g/c1G6Q4qX
         fBEiS3tASRhmRQbHh3iP7lbIAuXh7JZyFvWlmkOMzQPwfviNMPSFvL6oYWu0aQByW3
         moRZPAksI43uzoHzHBIkChKDE/gHqkbK2WVOAjN8eCj4e6eAHgwd3aXaDxh7xNr0Nb
         47Xx5yvq3jamg==
Date:   Fri, 23 Jun 2023 17:06:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: allwinner: d1: Add pwm node
Message-ID: <20230623-budget-helpless-32f82537ab40@spud>
References: <20230623150012.1201552-1-privatesub2@gmail.com>
 <20230623150012.1201552-4-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ac7UQ6ZCF2/3CB3I"
Content-Disposition: inline
In-Reply-To: <20230623150012.1201552-4-privatesub2@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ac7UQ6ZCF2/3CB3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 06:00:01PM +0300, Aleksandr Shubin wrote:
> D1 and T113s contain a pwm controller with 8 channels.
> This controller is supported by the sun20i-pwm driver.
>=20
> Add a device tree node for it.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index 922e8e0e2c09..50f0f761527b 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -127,6 +127,18 @@ uart3_pb_pins: uart3-pb-pins {
>  			};
>  		};
> =20
> +		pwm: pwm@2000c00 {
> +			compatible =3D "allwinner,sun20i-d1-pwm";
> +			reg =3D <0x02000c00 0x400>;
> +			clocks =3D <&dcxo>,
> +				 <&ccu CLK_BUS_PWM>;
> +			clock-names =3D "hosc", "bus";
> +			resets =3D <&ccu RST_BUS_PWM>;

> +			allwinner,pwm-channels =3D <8>;

This fails dtbs_check. Please test the dts against the bindings.

Cheers,
Conor.

> +			status =3D "disabled";
> +			#pwm-cells =3D <0x3>;
> +		};
> +
>  		ccu: clock-controller@2001000 {
>  			compatible =3D "allwinner,sun20i-d1-ccu";
>  			reg =3D <0x2001000 0x1000>;
> --=20
> 2.25.1
>=20

--Ac7UQ6ZCF2/3CB3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJXDIAAKCRB4tDGHoIJi
0ujpAQC9S1Qf2IoZ2/nZ+UM8pJ738bDHZNGyp2kiplAXDx5RkQEApyOUmbmCe+3t
jKF64KxbfxaQqYDdmqlocslEhgq9XQo=
=PG6i
-----END PGP SIGNATURE-----

--Ac7UQ6ZCF2/3CB3I--
