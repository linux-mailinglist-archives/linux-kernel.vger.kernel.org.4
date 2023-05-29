Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9474A714942
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjE2MRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjE2MRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:17:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE49DC2;
        Mon, 29 May 2023 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685362660; x=1716898660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHiUGMjxRQ6M/GUGwXf1RDiZRcVrGdxl0s2yVo9wSVQ=;
  b=qoeuTHSNte5PF76ImmbU8u6Aly64zJuxerVP1A4zblu7Tu/N/VYfEYmB
   8Ef98wuBcrJ26S18PqxoHrNNo9UxPCPVKCdCtnjUZuLjI5/tZduT0ZF0/
   GfF/avkqwEB5ab5JDJs/bfoT1NDq/ORL9+bwtrFmxqIcf76sK2JGws7XA
   /lLU7u8p9t2CGSoqebvh86B2TaqfnjsIUS3E00gsOr1l0Y+6wXp2GsX3s
   jB2cWwhlS9LuosOqOousUONd2F9ms2qdFzr51zCL5dWvQ2CFDm1isjy7S
   GNWI0NntGn0sLkAA11PQuJ2LpwTMToOxCQr4BILTWTCmfpMBhl6OFlEN+
   A==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="213543328"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:17:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:17:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:17:37 -0700
Date:   Mon, 29 May 2023 13:17:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: timer: atmel,at91sam9260-pit:
 convert to yaml
Message-ID: <20230529-chuck-turbofan-a8aabbdd9341@wendy>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
 <20230529062604.1498052-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MDW8BcZEu6MUYNEl"
Content-Disposition: inline
In-Reply-To: <20230529062604.1498052-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MDW8BcZEu6MUYNEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

On Mon, May 29, 2023 at 09:26:02AM +0300, Claudiu Beznea wrote:
> Convert Microchip AT91 PIT bindings to YAML. Along with it clocks and
> clock-names bindings were added as the drivers needs it to ensure proper
> hardware functionality.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt | 12 ---
>  .../bindings/timer/atmel,at91sam9260-pit.yaml | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam=
9260-pit.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Do=
cumentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 67a66bf74895..54d3f586403e 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -4,18 +4,6 @@ Chipid required properties:
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
> -PIT64B Timer required properties:
> -- compatible: Should be "microchip,sam9x60-pit64b"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain interrupt for PIT64B timer
> -- clocks: Should contain the available clock sources for PIT64B timer.
> -
>  System Timer (ST) required properties:
>  - compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
>  - reg: Should contain registers location and length
> diff --git a/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pi=
t.yaml b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> new file mode 100644
> index 000000000000..1cc7b7494e4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/atmel,at91sam9260-pit.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91 Periodic Interval Timer (PIT)
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Microchip AT91 periodic interval timer provides the operating system s=
cheduler
> +  interrupt. It is designed to offer maximum accuracy and efficient mana=
gement,
> +  even for systems with long response time.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9260-pit
> +      - microchip,sam9x60-pit64b

The missing compatible should probably be added here, rather than
removed from the devicetree.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: atmel,at91sam9260-pit
> +    then:
> +      properties:

> +        interrupts:
> +          description:
> +            Contain interrupt for the PIT which is the IRQ line shared a=
cross all
> +            System Controller members.

I think you should drop this & the corresponding section below, since
both PIT and PIT64 have a single interrupt.

Thanks,
Conor.

> +        clocks:
> +          maxItems: 1
> +
> +    else:
> +      properties:
> +        interrupts:
> +          description:
> +            PIT64B peripheral interrupt identifier.
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: gclk
> +      required:
> +        - clock-names


--MDW8BcZEu6MUYNEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSXygAKCRB4tDGHoIJi
0lloAP90iVLfmKixUT2X7Jvpsdvgj+TPj5hIYGyTIPBn44lzYgEAyNQOMUvamzjZ
WsLACZkOX75RoA9nLwB208Nkk8RUww8=
=W65y
-----END PGP SIGNATURE-----

--MDW8BcZEu6MUYNEl--
