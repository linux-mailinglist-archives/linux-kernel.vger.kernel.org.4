Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A071497A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjE2MZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjE2MZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:25:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD2AB;
        Mon, 29 May 2023 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685363103; x=1716899103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g1XI8dwInjLQREirvGIHQu2rAR63mNwJCB4uTNd8Jxw=;
  b=WMR3UYJPNQRMy1cwWZzrBsfHmjiDSIIVijWD7OusiKkhR6DcGr3orSBo
   2xMtof53Hb9cbF8FA53caEfF0beriITSAEyZ/0HACY1eTmIzgDlc9NRwr
   3eUVaDz18Dwf25+tQQSieuw0BLFqHS28fe4eR889woe7N+GOSqwTticWW
   4Vag8OO0/ryMITbVy40H8WT0vBvB26g7/V1VYYTlEysAzWIjLgrKjd3Oe
   KgJBWP0B8b5l5ep6WB9tmBLJnFC/XwGvL/Gf6d/kvbcKV62sLdAoaP1B1
   nD4fl1nr7SnIQGatbidt9dP3b1LAYUnIhLV1SQwLeS1bwEbsf6S0Y6cHO
   g==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="215301156"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:25:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:25:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:25:00 -0700
Date:   Mon, 29 May 2023 13:24:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: timer: atmel,at91rm9200-st: convert
 to yaml
Message-ID: <20230529-frivolous-refinery-43d91975fff9@wendy>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
 <20230529062604.1498052-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="57Jgg4Kb+/tidqBv"
Content-Disposition: inline
In-Reply-To: <20230529062604.1498052-5-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--57Jgg4Kb+/tidqBv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

On Mon, May 29, 2023 at 09:26:04AM +0300, Claudiu Beznea wrote:
> Convert Microchip AT91 system timer to YAML.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  9 ---
>  .../bindings/timer/atmel,at91rm9200-st.yaml   | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 9 deletions(-)
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
> index 000000000000..a75644e1a2fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/atmel,at91rm9200-st.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91 System Timer (ST)
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@microchip.com>

Is that a valid email address?

> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Microchip AT91 system timer integrates a period interval timer, a watc=
hdog
> +  timer and a real-time timer.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: atmel,at91rm9200-st
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Contain interrupt for the ST which is the IRQ line shared across a=
ll
> +      system controller members.

I don't think there's really much point having a description when there
is only one interrupt, but it cannot do any harm I suppose!

Other than the email address question,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

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
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    st: timer@fffffd00 {
> +        compatible =3D "atmel,at91rm9200-st", "syscon", "simple-mfd";
> +        reg =3D <0xfffffd00 0x100>;
> +        interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;
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

--57Jgg4Kb+/tidqBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSZhQAKCRB4tDGHoIJi
0u0uAQCqYD8k+lUIAvY39DHyYkYA6s0n1YpJnOBI1ROSuTdjAAD/a16itLO6NWbT
xje716xh348zl36jUNdGjv+oi4sxiww=
=3Rmu
-----END PGP SIGNATURE-----

--57Jgg4Kb+/tidqBv--
