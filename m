Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC327111B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjEYRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjEYRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8A189;
        Thu, 25 May 2023 10:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 673AE61A69;
        Thu, 25 May 2023 17:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB867C4339C;
        Thu, 25 May 2023 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685034657;
        bh=N0vtnAz6F6YcQyZpPs+I4KoCQ9QRqYQtSgl59L0VnzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSqU6eeO1iBtLlaCg/vCQV7JM+Zv2snVylzwRFAXlqb50QlB4jgT0lhCmQU4WGYVn
         VqJbE2BVr4eWQod6HXe12zH9XZjyrhXiuzC+wC4EoPQFp/G5juekl5M7ouFkTukaWb
         CCF4HU35eHEOg24iaB5v1fDD3hGb0MmFF8edncJd+mMXJwYrD4BRLUD00bBMzErMRl
         cb3NAV46SKJrJv8E+H5fpn9xU/NAouSZtRVBusEovicbYuTVkkF+Fw3qsIZsw/j4cU
         FaxSpoHrEZyk7p21TBiHcC2BkORrYUzrnpHhoE/QDbgPVshGv7YUoVxvW/xgfNXa6N
         9Lexy2Md+IcmQ==
Date:   Thu, 25 May 2023 18:10:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        sebastian.reichel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Message-ID: <20230525-renewal-proposal-9620d5520437@spud>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9S6GJW2YFXC8WjPi"
Content-Disposition: inline
In-Reply-To: <20230525125602.640855-2-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9S6GJW2YFXC8WjPi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 03:55:58PM +0300, Claudiu Beznea wrote:
> Convert Atmel PIT to YAML. Along with it clock binding has been added as
> the driver enables it to ensure proper hardware functionality.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  6 ---
>  .../bindings/timer/atmel,at91sam9260-pit.yaml | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam=
9260-pit.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Do=
cumentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 67a66bf74895..7024839c5da2 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -4,12 +4,6 @@ Chipid required properties:
>  - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chi=
pid"
>  - reg : Should contain registers location and length
> =20
> -PIT Timer required properties:
> -- compatible: Should be "atmel,at91sam9260-pit"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain interrupt for the PIT which is the IRQ line
> -  shared across all System Controller members.
> -
>  PIT64B Timer required properties:
>  - compatible: Should be "microchip,sam9x60-pit64b"
>  - reg: Should contain registers location and length
> diff --git a/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pi=
t.yaml b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> new file mode 100644
> index 000000000000..f304cd68acd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/atmel,at91sam9260-pit.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Periodic Interval Timer (PIT)
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Atmel periodic interval timer provides the operating system=E2=80=99s =
scheduler
> +  interrupt. It is designed to offer maximum accuracy and efficient mana=
gement,
> +  even for systems with long response time.
> +
> +properties:
> +  compatible:
> +    const: atmel,at91sam9260-pit
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Contain interrupt for the PIT which is the IRQ line shared across =
all
> +      System Controller members.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
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
> +    pit: timer@fffffe40 {
> +        compatible =3D "atmel,at91sam9260-pit";
> +        reg =3D <0xfffffe40 0x10>;
> +        interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;

make dt_binding_check W=3D1 -j 30 DT_SCHEMA_FILES=3Datmel,at91sam9260-pit.y=
aml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.exa=
mple.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.exa=
mple.dtb
Error: Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.exampl=
e.dts:26.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/t=
imer/atmel,at91sam9260-pit.example.dtb] Error 1
make: *** [Makefile:1512: dt_binding_check] Error 2

Think you're missing the header for IRQ_TYPE_LEVEL_HIGH

> +        clocks =3D <&pmc PMC_TYPE_CORE PMC_MCK>;
> +    };
> +...
> --=20
> 2.34.1
>=20

--9S6GJW2YFXC8WjPi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+WnAAKCRB4tDGHoIJi
0v91AQCq1oOQFZhbws7xf6cV5p0dVuzAQzH3riZeIwpZe6XuYgD+PznsGUAs8MxN
Ox2GXxjcMw6IqbeiJleelk+SUekU0Qs=
=kogh
-----END PGP SIGNATURE-----

--9S6GJW2YFXC8WjPi--
