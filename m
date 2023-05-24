Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77470FE68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjEXTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXTTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF9DA4;
        Wed, 24 May 2023 12:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF486402C;
        Wed, 24 May 2023 19:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE12C433EF;
        Wed, 24 May 2023 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684955952;
        bh=UrGuYtn1xPI8m/h89y7lPAigXIpFhTgc56VT/0n00Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSvvRmFT8sf4ysJEpWdOTFQzO5zkbZgEGg9DwPrl2WUntNM/dg5xnM2VEzqb02P+j
         c6iVycvwtfLZRdyYTPsD+Z6OScIfCb5kFn8JlDs1D03THeABrXy9ipWXmbc6AR5/Ts
         hLwBr907o8jGHEP50RfI8bGIyYEnMzDDYcFS7ZG+zT9F7ZowfYwqI6+bs7kMA7MaPS
         C0NaD+A36TyXhujq1L+/YIM8Jn2c70+Uu2bKbUekgzz59miuoBkBIfMw4dIZPKZVAl
         a2AxEL38VG1ALqm+vTY1kUpGFDrN88QxJ4AQV920UTva2reAsoyD02UJPM27wACrii
         qt0DuaNHwoZ9A==
Date:   Wed, 24 May 2023 20:19:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230524-blizzard-hunting-4da815e634e2@spud>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wk90yo5YHkHmxCdc"
Content-Disposition: inline
In-Reply-To: <20230524123528.439082-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wk90yo5YHkHmxCdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 03:35:27PM +0300, Claudiu Beznea wrote:
> Convert Atmel SAMA5D2 shutdown controller to YAML. SAMA7G5 SHDWC DT node
> (available in arch/arm/boot/dts/sama7g5.dtsi) has syscon along with its
> compatible. There is no usage of this syscon in the current code but it
> may be necessary in future as some registers of SHDWC are accessed in
> different drivers (at91-sama5d2_shdwc.c and arch/arm/mach-at91/pm.c).
> Thus update the YAML with it to make DT checkers happy.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Modulo the license thing that I mentioned on v1,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  63 ----------
>  .../power/reset/atmel,sama5d2-shdwc.yaml      | 115 ++++++++++++++++++
>  2 files changed, 115 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,s=
ama5d2-shdwc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Do=
cumentation/devicetree/bindings/arm/atmel-sysregs.txt
> index e6b2fb291b45..67a66bf74895 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -52,69 +52,6 @@ Example:
>  		reg =3D <0xe3804000 0x1000>;
>  };
> =20
> -SHDWC SAMA5D2-Compatible Shutdown Controller
> -
> -1) shdwc node
> -
> -required properties:
> -- compatible: should be "atmel,sama5d2-shdwc", "microchip,sam9x60-shdwc"=
 or
> -  "microchip,sama7g5-shdwc"
> -- reg: should contain registers location and length
> -- clocks: phandle to input clock.
> -- #address-cells: should be one. The cell is the wake-up input index.
> -- #size-cells: should be zero.
> -
> -optional properties:
> -
> -- debounce-delay-us: minimum wake-up inputs debouncer period in
> -  microseconds. It's usually a board-related property.
> -- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
> -
> -optional microchip,sam9x60-shdwc or microchip,sama7g5-shdwc properties:
> -- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
> -
> -The node contains child nodes for each wake-up input that the platform u=
ses.
> -
> -2) input nodes
> -
> -Wake-up input nodes are usually described in the "board" part of the Dev=
ice
> -Tree. Note also that input 0 is linked to the wake-up pin and is frequen=
tly
> -used.
> -
> -Required properties:
> -- reg: should contain the wake-up input index [0 - 15].
> -
> -Optional properties:
> -- atmel,wakeup-active-high: boolean, the corresponding wake-up input des=
cribed
> -  by the child, forces the wake-up of the core power supply on a high le=
vel.
> -  The default is to be active low.
> -
> -Example:
> -
> -On the SoC side:
> -	shdwc@f8048010 {
> -		compatible =3D "atmel,sama5d2-shdwc";
> -		reg =3D <0xf8048010 0x10>;
> -		clocks =3D <&clk32k>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		atmel,wakeup-rtc-timer;
> -	};
> -
> -On the board side:
> -	shdwc@f8048010 {
> -		debounce-delay-us =3D <976>;
> -
> -		input@0 {
> -			reg =3D <0>;
> -		};
> -
> -		input@1 {
> -			reg =3D <1>;
> -			atmel,wakeup-active-high;
> -		};
> -	};
> -
>  Special Function Registers (SFR)
> =20
>  Special Function Registers (SFR) manage specific aspects of the integrat=
ed
> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-=
shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-sh=
dwc.yaml
> new file mode 100644
> index 000000000000..31a16a354a3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.y=
aml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/atmel,sama5d2-shdwc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SAMA5D2 SHDWC Shutdown Controller
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Atmel SHDWC shutdown controller controls the power supplies VDDIO and =
VDDCORE
> +  and the wake-up detection on debounced input lines.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: microchip,sama7g5-shdwc
> +          - const: syscon
> +      - items:
> +          enum:
> +            - atmel,sama5d2-shdwc
> +            - microchip,sam9x60-shdwc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  debounce-delay-us:
> +    description:
> +      Minimum wake-up inputs debouncer period in microseconds. It is usu=
ally a
> +      board-related property.
> +
> +  atmel,wakeup-rtc-timer:
> +    description: enable real-time clock wake-up
> +    type: boolean
> +
> +patternProperties:
> +  "^input@[0-15]$":
> +    description:
> +      Wake-up input nodes. These are usually described in the "board" pa=
rt of
> +      the Device Tree. Note also that input 0 is linked to the wake-up p=
in and
> +      is frequently used.
> +    type: object
> +    properties:
> +      reg:
> +        description: contains the wake-up input index
> +        minimum: 0
> +        maximum: 15
> +
> +      atmel,wakeup-active-high:
> +        description:
> +          The corresponding wake-up input described by the child forces =
the
> +          wake-up of the core power supply on a high level. The default =
is to
> +          be active low.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,sam9x60-shdwc
> +              - microchip,sama7g5-shdwc
> +    then:
> +      properties:
> +        atmel,wakeup-rtt-timer:
> +          description: enable real-time timer wake-up
> +          type: boolean
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    shdwc: poweroff@f8048010 {
> +        compatible =3D "atmel,sama5d2-shdwc";
> +        reg =3D <0xf8048010 0x10>;
> +        clocks =3D <&clk32k>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        atmel,wakeup-rtc-timer;
> +        debounce-delay-us =3D <976>;
> +
> +        input@0 {
> +            reg =3D <0>;
> +        };
> +
> +        input@1 {
> +            reg =3D <1>;
> +            atmel,wakeup-active-high;
> +        };
> +    };
> +
> +...
> --=20
> 2.34.1
>=20

--wk90yo5YHkHmxCdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5jKwAKCRB4tDGHoIJi
0p9OAQDaa+pUPo20aynlsVZ+ZkT1qKrlrMyJEBUl4ZP+2YwgCgEArC5r7v2+ddus
dDpEvz6OUd7qIXJhVBt7zYHGf3oeuAc=
=WmUB
-----END PGP SIGNATURE-----

--wk90yo5YHkHmxCdc--
