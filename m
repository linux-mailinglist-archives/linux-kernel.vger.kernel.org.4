Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF673BCE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjFWQpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFWQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C81A1;
        Fri, 23 Jun 2023 09:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 367F561AC0;
        Fri, 23 Jun 2023 16:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD6C433C0;
        Fri, 23 Jun 2023 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687538695;
        bh=Amvsfe/559uEztT+E7JaJVCDluFASv8Wnk4KeVuoYOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBA/J4aaiuH7MRAynpfBa/oShtjtfhURH/q8bGelfGo588EUJj5VcLsyGpnR7+IxP
         6h/8yO2Ooz+ee+lc6yOVlTHBBICc2YeSebY6PPWsHi2+re3JAFM0JcTgwkFfAwHlZJ
         Wa25F6R3O1kRz36gGhgvNDKQzeRIfeCB1l+4xyVF3Ye+24I4nCD36EdpLcDgdUMl/C
         UMzqxqI/X2DrnyMFGLIgwKuGvEAxjLnhJoa6KGXL0AHSqj4YaMSeBrV1BoNOwmrpmZ
         Walos4Z8e9Yr6iv6ND4SFQeSKwYy9lB2/8mg+UTbyD5Xl8weAOcXaPoo511CoGPhBN
         IWXKO5012+syA==
Date:   Fri, 23 Jun 2023 17:44:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad74413r: add binding for digital
 input threshold
Message-ID: <20230623-casket-outer-2c9d2a0c4795@spud>
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
 <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HMChvs1GfdUbVjeL"
Content-Disposition: inline
In-Reply-To: <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HMChvs1GfdUbVjeL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 01:33:25PM +0200, Rasmus Villemoes wrote:
> Allow specifying the threshold for which the channels configured as
> digital input change state.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>=20
> Running dt_binding_check on this with a too small or large value in
> the example does give me an error, but the multipleOf does not seem to
> be enforced; the value 1234567 is not flagged. I don't know if that's
> expected (maybe I have too old versions of something).

That's one for Rob. I checked a few others and behaviour was the same
there.

>  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml    | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yam=
l b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> index 590ea7936ad7..1f90ce3c7932 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> @@ -51,6 +51,14 @@ properties:
>        Shunt (sense) resistor value in micro-Ohms.
>      default: 100000000
> =20
> +  digital-input-threshold-microvolt:

Should this not have an adi vendor prefix, similar to
"adi,digital-input-threshold-mode-fixed"?

Cheers,
Conor.

> +    description:
> +      Comparator threshold used by the channels configured to use the
> +      digital input function.
> +    minimum: 500000
> +    maximum: 16000000
> +    multipleOf: 500000
> +
>    reset-gpios:
>      maxItems: 1
> =20
> @@ -143,6 +151,8 @@ examples:
>          refin-supply =3D <&ad74413r_refin>;
>          reset-gpios =3D <&gpio2 6 GPIO_ACTIVE_LOW>;
> =20
> +        digital-input-threshold-microvolt =3D <4000000>;
> +
>          channel@0 {
>            reg =3D <0>;
> =20
> --=20
> 2.37.2
>=20

--HMChvs1GfdUbVjeL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJXMAgAKCRB4tDGHoIJi
0qOJAP9/cR+G2TQ18Npzna+cyS0FcsBgUR81lujLjJW/rkSOVAD+Ng5ctMFycHPe
dh+goo7uc2QV6wrMyd1/3QAPz1VTOQo=
=hAHv
-----END PGP SIGNATURE-----

--HMChvs1GfdUbVjeL--
