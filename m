Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633E73CA27
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjFXJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjFXJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F8F10FD;
        Sat, 24 Jun 2023 02:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B27F260C4A;
        Sat, 24 Jun 2023 09:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C97C433C0;
        Sat, 24 Jun 2023 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687598907;
        bh=LxXDcbLJc1zSmgzEDzBM0Y/eWiAZ7Drimq7fAAeDJRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cd3laRtKsLBk8T2MjxZCLJ93vWD0QNIiyHG64tT0CTReINsyZ2yiZ0cyXYbelvEXR
         Yy7Wpddh5JYC2AcPazLR/XX/ExQesued1zaY7AOUkmMSLvpaJTAzdkQ2Lqcs3w/4e3
         HaPfRgnOpUlF54OSu7jJxPCMKd6CnClu0L1F4CnA5Jvr1R56GC7TL6w0JWlYy5dLVC
         vXTWGn82lO2qhMBb6gg4EAhrMRVBR0CfkDrhpRL4cz8Man1yc0t9ZGlhedLmkfYqoT
         VJhLCOSNrcl0nQZiiA7Ed0xLm+rN6XespLxso0ZuIg7pFH8Z4OmtNDGKMsu3uYbchj
         13NTqEEAkPG9A==
Date:   Sat, 24 Jun 2023 10:28:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Varshini Rajendran <varshini.rajendran@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: atmel,at91rm9200-spi: fix broken
 sam9x7 compatible
Message-ID: <20230624-embassy-scuff-9fdc0f150d1a@spud>
References: <20230624082054.37697-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bwrTTO9opmPzEFoX"
Content-Disposition: inline
In-Reply-To: <20230624082054.37697-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bwrTTO9opmPzEFoX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 24, 2023 at 10:20:54AM +0200, Krzysztof Kozlowski wrote:
> Commit a3eb95484f27 ("spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7
> compatible") adding sam9x7 compatible did not make any sense as it added
> new compatible into middle of existing compatible list.  The intention
> was probably to add new set of compatibles with sam9x7 as first one.
>=20
> Fixes: a3eb95484f27 ("spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7 =
compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

@Varshini, this is the template to follow for the rest of the series. I
know there's a lot of complaints while running dtbs_check for the entire
directory, but you can isolate things to a singular binding and check
the dts against it using:
make dtbs_check DT_SCHEMA_FILES=3Datmel,at91rm9200-spi.yaml
That should make it easier to see that you don't break existing dts by
modifying the binding.

Cheers,
Conor.

> ---
>  .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.y=
aml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> index bdc42eeacba4..58367587bfbc 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> @@ -19,7 +19,10 @@ properties:
>        - const: atmel,at91rm9200-spi
>        - items:
>            - const: microchip,sam9x60-spi
> +          - const: atmel,at91rm9200-spi
> +      - items:
>            - const: microchip,sam9x7-spi
> +          - const: microchip,sam9x60-spi
>            - const: atmel,at91rm9200-spi
> =20
>    reg:
> --=20
> 2.34.1
>=20

--bwrTTO9opmPzEFoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJa3NQAKCRB4tDGHoIJi
0g0eAP9R9uhyfBlfuOXjh+drak8V4k0CqR/F+9JXOOjXjGIDXAD9FaRriN4gGH6z
ykN2QwJ/0oMeGcfsAPeXfFu5o0gzDQw=
=tkPS
-----END PGP SIGNATURE-----

--bwrTTO9opmPzEFoX--
