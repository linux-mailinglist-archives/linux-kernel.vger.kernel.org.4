Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD0B71121F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbjEYR1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEYR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F45C9B;
        Thu, 25 May 2023 10:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFFA16479A;
        Thu, 25 May 2023 17:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5204DC433D2;
        Thu, 25 May 2023 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685035650;
        bh=L/5ijg9X6rfQYWbp2usWVFYp1c4M0OzDqqTtlX0HblA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jp8R1OQbwIhbllDp0SCvtn6ySgj9wFDcWHKwggmQvMtE+wzGJ+J9+DnurkDcBbAqw
         25NczZ7HY+uiSbRaICNvjk6oKU+l3AypZKiIZw8b2y7/xXfivcwQZfvOgkJ5YS/Ksn
         ds0S79rvIUo+sib3nm+5SOIreYsILO6ACqDdoG3RoyTlaMW6eiD5yWMjwhAr4gZ/0D
         cP5m6THu79EfW0qn8HKK4s1sm8In/fAsUbVZffz3j/GXUzCgtYwcbGRZaIa68UZ4R7
         wcEqUARr4Sy/k38vkxEgiYBJm3HgaRYqjVFdKnV9dtn8Z3466BSGKLaTDAvm6cN4WL
         8lvOK/aAH4+9g==
Date:   Thu, 25 May 2023 18:27:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        sebastian.reichel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: timer: atmel,at91rm9200-st: convert to
 yaml
Message-ID: <20230525-suffocate-ditto-25578737a8ec@spud>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-6-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvOwCibK1/4PsILp"
Content-Disposition: inline
In-Reply-To: <20230525125602.640855-6-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvOwCibK1/4PsILp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 03:56:02PM +0300, Claudiu Beznea wrote:
> Convert Atmel system timer to YAML.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  9 ---
>  .../bindings/timer/atmel,at91rm9200-st.yaml   | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91rm9=
200-st.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Do=
cumentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 54d3f586403e..68c0eacb01ac 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -4,15 +4,6 @@ Chipid required properties:
>  - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chi=
pid"
>  - reg : Should contain registers location and length
> =20
> -System Timer (ST) required properties:
> -- compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain interrupt for the ST which is the IRQ line
> -  shared across all System Controller members.
> -- clocks: phandle to input clock.
> -Its subnodes can be:
> -- watchdog: compatible should be "atmel,at91rm9200-wdt"
> -
>  RAMC SDRAM/DDR Controller required properties:
>  - compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
>  			"atmel,at91sam9260-sdramc",
> diff --git a/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.=
yaml b/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
> new file mode 100644
> index 000000000000..08ee459d9fa3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/atmel,at91rm9200-st.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel System Timer (ST)
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@microchip.com>
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Atmel system timer integrates a period interval timer, a watchdog time=
r and a
> +  real-time timer.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91rm9200-st
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Contain interrupt for the ST which is the IRQ line shared across a=
ll
> +      system controller members.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  watchdog:
> +    $ref: ../watchdog/atmel,at91rm9200-wdt.yaml
> +    description:
> +      Child node describing watchdog.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +
> +    st: timer@fffffd00 {
> +        compatible =3D "atmel,at91rm9200-st", "syscon", "simple-mfd";
> +        reg =3D <0xfffffd00 0x100>;
> +        interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;

This one is broken for the same reason too. Please test the bindings :(

Cheers,
Conor.

> +        clocks =3D <&slow_xtal>;
> +
> +        watchdog {
> +            compatible =3D "atmel,at91rm9200-wdt";
> +        };
> +    };
> +
> +...
> --=20
> 2.34.1
>=20

--mvOwCibK1/4PsILp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+afAAKCRB4tDGHoIJi
0p5iAQDDGRFM2dLYj1a5MQyitfEYsAqsL+n97flIO1HRuvn6dgD9FTFfDHfZ0noz
tmPJO3axqGxR9eYrrh99RdxIF0KqHgo=
=L9Sj
-----END PGP SIGNATURE-----

--mvOwCibK1/4PsILp--
