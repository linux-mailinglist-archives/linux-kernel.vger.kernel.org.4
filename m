Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52993735E79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjFSU1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFSU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6DBE64;
        Mon, 19 Jun 2023 13:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D89D060EFB;
        Mon, 19 Jun 2023 20:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F16AC433C8;
        Mon, 19 Jun 2023 20:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687206458;
        bh=ikHFPDr06oSLXBFI/OiW6d9A5DSqxtEooadoVDaEX/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSGaWnpLWakQJdHaFna5b4aJDT3EAdt38o+f9na6gzoY71JSTET+bGpFDlbVyfpIc
         gjqp1gNeJ7SNiuSxGQ9ZhULN8ErTAP1aJ52fscTJBkWOuNAhnAmoo8Y+VNd4iKwmr5
         lM7EzdiYw0A4wWq+1md3PaN97a4FkhgtrJ4C+ufS9+0/B/PrYLQS7EhI0kB4nR/w/s
         SC0KSf6wv0nGdphy4NKZQ8OdBSwVfgSKAnDMvG4g68M6OSMNNPa01wMa3db+3JkivF
         fvGXTIs3JksYZ2AUJwQmQtMpHVJfRkBQoCQpk+aXftg847kwECX5LGPS1H2/2xuBRy
         Q3P6JitcbRfAA==
Date:   Mon, 19 Jun 2023 21:27:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: crypto: ti,sa2ul: make power-domains
 conditional
Message-ID: <20230619-trailside-shaft-72b2d6bcf978@spud>
References: <20230614-sa3ul-v3-0-2eeb810327a1@ti.com>
 <20230614-sa3ul-v3-1-2eeb810327a1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Oun5Qk13m+H67PfU"
Content-Disposition: inline
In-Reply-To: <20230614-sa3ul-v3-1-2eeb810327a1@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oun5Qk13m+H67PfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 06:58:47PM +0530, Kamlesh Gurudasani wrote:
> Devices specific to compatible ti,am62-sa3ul don't have control over
> power of SA3UL from main domain.
>=20
> "power-domains" property in crypto node tries to access
> the SA3UL power, for which it gets NACK and hence, driver doesn't
> probe properly for those particular devices.
>=20
> Make "power-domains" property as false for devices with
> compatible ti,am62-sa3ul.
>=20
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 14 ++++++++++++=
+-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Doc=
umentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> index 77ec8bc70bf7..88c8ee8821d4 100644
> --- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> +++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> @@ -66,10 +66,22 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> -  - power-domains
>    - dmas
>    - dma-names
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          items:

The usual pattern here is s/items/contains/. With that,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +            const: ti,am62-sa3ul
> +    then:
> +      properties:
> +        power-domains: false
> +    else:
> +      required:
> +        - power-domains
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.34.1
>=20

--Oun5Qk13m+H67PfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJC6NQAKCRB4tDGHoIJi
0iEYAQD+WDPPfLmPj3pgUhjB/6auvhq2AQ81Cdlt3SKWpv1BxAD+P2XRB9x4Pt8N
VMchyEEGi/oeMAYxt2ySl3ft6xKh5Aw=
=VLLt
-----END PGP SIGNATURE-----

--Oun5Qk13m+H67PfU--
