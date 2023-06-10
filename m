Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFB072AC63
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjFJOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjFJOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FA630F5;
        Sat, 10 Jun 2023 07:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B251260BC9;
        Sat, 10 Jun 2023 14:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F6BC433D2;
        Sat, 10 Jun 2023 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686408776;
        bh=OzWir0L/faofH0wFxhfFc9Ju6SnxPtP2Z/T/v66ar6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbjqcWOfsPHzuDV2DHbosqFH7qWOxIu3pfd+g/fa9y1dXEEz984da0S1n/PNw14Tu
         oZs4LUq+AF+KGNO/NVO7nAeZuDumg9Hclgu/oIXsV3cBIvw4DvE6YNnIMXyz7bbusd
         cQ2YmxnmumNFfzA0l+MzlRXs0PhBPxXiOGFApjPOJqPLvUtP01J8v6bJpxOTkUm4Of
         vkbYqht8Y00StTqCQWAjM2JEG8nrMjX9gtGe1GQhg7UG9P2aq8auv49G3FXNdyxqg6
         eMX5W2w2d3XV6F7vOx4Qd3D9Qaf7Ub74NOIqanhx+eUmpVqfkTODBNzSMLLq0leGII
         XJ7FsnHM0cAvg==
Date:   Sat, 10 Jun 2023 15:52:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 3/3] dt-bindings: thermal: sun8i: Add binding for
 D1/T113s THS controller
Message-ID: <20230610-rehire-amid-2517f43504c0@spud>
References: <20230610141739.999268-1-bigunclemax@gmail.com>
 <20230610141739.999268-4-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H0Cwx1inMVbzJjEQ"
Content-Disposition: inline
In-Reply-To: <20230610141739.999268-4-bigunclemax@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H0Cwx1inMVbzJjEQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 05:17:34PM +0300, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
>=20
> Add a binding for D1/T113s thermal sensor controller.
>=20
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Why do you have 2 sign-offs that are both you w/ different spellings?
Content looks fine to me, other than one commit below.

> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a8=
3t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83=
t-ths.yaml
> index fbd4212285e2..001faa37fc27 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
> @@ -16,6 +16,7 @@ properties:
>        - allwinner,sun8i-a83t-ths
>        - allwinner,sun8i-h3-ths
>        - allwinner,sun8i-r40-ths
> +      - allwinner,sun20i-d1-ths
>        - allwinner,sun50i-a64-ths
>        - allwinner,sun50i-a100-ths
>        - allwinner,sun50i-h5-ths
> @@ -61,6 +62,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - allwinner,sun20i-d1-ths
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h6-ths
> =20
> @@ -84,7 +86,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: allwinner,sun8i-h3-ths
> +            enum:
> +              - allwinner,sun8i-h3-ths
> +              - allwinner,sun20i-d1-ths
> =20
>      then:
>        properties:
> @@ -103,6 +107,7 @@ allOf:
>              enum:
>                - allwinner,sun8i-h3-ths
>                - allwinner,sun8i-r40-ths
> +              - allwinner,sun20i-d1-ths
>                - allwinner,sun50i-a64-ths
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h5-ths
> @@ -159,4 +164,17 @@ examples:
>           #thermal-sensor-cells =3D <1>;
>      };
> =20
> +  - |
> +    thermal-sensor@2009400 {
> +          compatible =3D "allwinner,sun20i-d1-ths";
> +          reg =3D <0x02009400 0x400>;
> +          interrupts =3D <0 90 0>;
> +          clocks =3D <&ccu 0>;
> +          clock-names =3D "bus";
> +          resets =3D <&ccu 2>;
> +          nvmem-cells =3D <&ths_calibration>;
> +          nvmem-cell-names =3D "calibration";
> +          #thermal-sensor-cells =3D <0>;

Is this calibration required, or optional, for the d1?

Cheers,
Conor.

> +    };
> +
>  ...
> --=20
> 2.39.2
>=20

--H0Cwx1inMVbzJjEQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZISOLgAKCRB4tDGHoIJi
0oiQAQD0e1/NNmNVXU79UTT9xgswzUE0nkSKgBA12mUl1HHeRQEAz+80y9RHNKcb
U9PFIasihnSHDbwri3kPol5LaFM7Tg4=
=eh+H
-----END PGP SIGNATURE-----

--H0Cwx1inMVbzJjEQ--
