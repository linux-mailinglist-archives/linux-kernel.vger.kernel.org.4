Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3542C7111C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjEYRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbjEYROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35282194;
        Thu, 25 May 2023 10:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7FBE60FDE;
        Thu, 25 May 2023 17:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A284C4339C;
        Thu, 25 May 2023 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685034893;
        bh=7XFxoozn1cUB7nbYl6jjyZms6i3wLKCvhjTs30+8SU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPphEleK2gdXVrBvvHuo365rFdjJxIfYGWa1fvTHrWXEhs79GZuFV8Ot4355Q3/HV
         Mu6Edrzl0vbcN8fvs5rpV5yoJyxxYqHd2RgWUPcF1uPhf/P/X+wZXxsc4QUxrOUZoL
         YmGG9tKKgwO8bTQcPuif7TbCJblcf2YiPlCc6mIOKKZ7eZ4xxyIyTHS0WSw3nUFpd9
         2jbDnt035FNUYCqx9uIMWwfHjERVod1192IBByAGMkmlRayhfQ7iQvex1p9BjX0Emo
         XK4mlkwJcaOVVBcNse+E9RzWrgPy8A1K9yzpWFPJpsi5DtG4r1nkJd9vtQRJSdCIlL
         O0V2Tsd5KEygg==
Date:   Thu, 25 May 2023 18:14:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        sebastian.reichel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b:
 convert to yaml
Message-ID: <20230525-straw-fidgeting-4c1099aa16fe@spud>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6+rOtc5dUp/Ewm0y"
Content-Disposition: inline
In-Reply-To: <20230525125602.640855-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6+rOtc5dUp/Ewm0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 03:56:00PM +0300, Claudiu Beznea wrote:
> Convert Microchip PIT64B to YAML. Along with it clock-names binding has
> been added as the driver needs it to get PIT64B clocks.

I don't think both of these PIT things need to have different binding
files. 90% of it is the same, just the clock-names/number - so you can
combine the two into one file with an
allOf:
  - if:
     property:
       compatible:
         contains:
	   const: foo
    then:

    else:

type of construct.
Gimmie a shout tomorrow if you need a hand w/ it.

Thanks,
Conor.

> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  6 --
>  .../timer/microchip,sam9x60-pit64b.yaml       | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/microchip,sam=
9x60-pit64b.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Do=
cumentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 7024839c5da2..54d3f586403e 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -4,12 +4,6 @@ Chipid required properties:
>  - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chi=
pid"
>  - reg : Should contain registers location and length
> =20
> -PIT64B Timer required properties:
> -- compatible: Should be "microchip,sam9x60-pit64b"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain interrupt for PIT64B timer
> -- clocks: Should contain the available clock sources for PIT64B timer.
> -
>  System Timer (ST) required properties:
>  - compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
>  - reg: Should contain registers location and length
> diff --git a/Documentation/devicetree/bindings/timer/microchip,sam9x60-pi=
t64b.yaml b/Documentation/devicetree/bindings/timer/microchip,sam9x60-pit64=
b.yaml
> new file mode 100644
> index 000000000000..9378eca38138
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/microchip,sam9x60-pit64b.ya=
ml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/microchip,sam9x60-pit64b.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip 64-bit Periodic Interval Timer (PIT64B)
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  The 64-bit periodic interval timer provides the operating system sched=
uler
> +  interrupt. It is designed to offer maximum accuracy and efficient mana=
gement,
> +  even for systems with long response times.
> +
> +properties:
> +  compatible:
> +    const: microchip,sam9x60-pit64b
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: gclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +
> +    pit64b: timer@f0028000 {
> +        compatible =3D "microchip,sam9x60-pit64b";
> +        reg =3D <0xf0028000 0x100>;
> +        interrupts =3D <37 IRQ_TYPE_LEVEL_HIGH 7>;
> +        clocks =3D <&pmc PMC_TYPE_PERIPHERAL 37>, <&pmc PMC_TYPE_GCK 37>;
> +        clock-names =3D "pclk", "gclk";
> +    };
> +
> +...
> --=20
> 2.34.1
>=20

--6+rOtc5dUp/Ewm0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+XhwAKCRB4tDGHoIJi
0ol9AP9Ji8eCUpcWSkg6naXZZRcLXw9DpC71sS5nj78Od6gzIgEA1HbvXzKo9VgK
Y9xjqUWvhZkKd+xm9bORgGAFysfkbAE=
=y9d8
-----END PGP SIGNATURE-----

--6+rOtc5dUp/Ewm0y--
