Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68C735F65
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFSVxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSVxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:53:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA95E68;
        Mon, 19 Jun 2023 14:53:47 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60F106606F13;
        Mon, 19 Jun 2023 22:53:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687211626;
        bh=Q8AM5koYerMjWBag8suxT2IGujxWNDaLYMtvv5NxFV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPKDjmltpCRnF+4Yuc8047bc5sSMGRz59KUUM8DNy1Q5LtUouuKMFW1yDgsBiCFhL
         DmqhFJBNqJDFIMtlRRFjNlmVww/J1bmfdciWaVVuR3zYoG6Xd1nfv5mso0Q6+cJd8K
         0+LjEmsTRhNR6IEX/qfZL3qq5+LgtAeUiVn9zBTelC5TdI510yYgC0yf0KtVWGPawD
         0L1PAMj0Sl0QOp6wjRIFIkl+WhMCvsyeJOfE0AE3D+gH1caHMUixtkQ0JFYk/xzRxS
         o7T2HJ/RyFTnhRnbIGAZ9oTNu2PP9Ca3rLh8FWh45vDP+eI9yfiV5nMp5+iBAGEdH0
         /cbBVjuQRiDAg==
Received: by mercury (Postfix, from userid 1000)
        id EBA341060A6A; Mon, 19 Jun 2023 23:53:43 +0200 (CEST)
Date:   Mon, 19 Jun 2023 23:53:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230619215343.4225xxrk3zeod3ok@mercury.elektranox.org>
References: <20230616101646.879480-1-claudiu.beznea@microchip.com>
 <20230616101646.879480-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qe57i2nitkjrmwbp"
Content-Disposition: inline
In-Reply-To: <20230616101646.879480-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qe57i2nitkjrmwbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 16, 2023 at 01:16:45PM +0300, Claudiu Beznea wrote:
> Convert Microchip AT91 SAMA5D2 shutdown controller to YAML. SAMA7G5 SHDWC
> DT node (available in arch/arm/boot/dts/sama7g5.dtsi) has syscon along wi=
th
> its compatible. There is no usage of this syscon in the current code but =
it
> may be necessary in future as some registers of SHDWC are accessed in
> different drivers (at91-sama5d2_shdwc.c and arch/arm/mach-at91/pm.c).
> Thus update the YAML with it to make DT checkers happy.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>  .../devicetree/bindings/arm/atmel-sysregs.txt |  63 ----------
>  .../power/reset/atmel,sama5d2-shdwc.yaml      | 114 ++++++++++++++++++
>  2 files changed, 114 insertions(+), 63 deletions(-)
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
> index 000000000000..8c58e12cdb60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.y=
aml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/atmel,sama5d2-shdwc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91 SAMA5D2 SHDWC Shutdown Controller
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description: |
> +  Microchip AT91 SHDWC shutdown controller controls the power supplies V=
DDIO
> +  and VDDCORE and the wake-up detection on debounced input lines.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: microchip,sama7g5-shdwc
> +          - const: syscon
> +      - enum:
> +          - atmel,sama5d2-shdwc
> +          - microchip,sam9x60-shdwc
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
> +  atmel,wakeup-rtt-timer:
> +    description: enable real-time timer wake-up
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
> +            const: atmel,sama5d2-shdwc
> +    then:
> +      properties:
> +        atmel,wakeup-rtt-timer: false
> +
> +additionalProperties: false
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

--qe57i2nitkjrmwbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSQzmcACgkQ2O7X88g7
+poU6Q/9GLRLECrJhm9q05ZRm7fQxyz4JKOt3g3vpq5SKzsMJwjpkbb5WUDwTq1o
J2COr2fyixHYKVpGZWf+GMKN0x2ogksZCJrefqte9Ex4x4r5qUiBjgP+IOduo9aw
kNMKdifa2XNFOJeOVUyo4BfQF27VjDofbN1Hy/EW3HT7aozPpUFZgBcEvjU5Pxqt
N+5leT3lfGhIbSwE2x02Wzlkrbl8ljM69D8lRzDcq7CFua7CgBFiHEhvvD2i9Ha0
oo0ZOdXqGaXph5BKQorUaILrpF2Bq/YMKy0qGnOwkQmNX/n8pe/0EVWkfzyoN9JZ
2UaoVkUR6a2cmqHjPspHN1QkYUHd23v4jviNUcgMTY1clmv/T0FLmsLIz99iqII7
2yYU2Ns9LMsCc2bysTwC7pZsgXjhZMz3UpvPNA+G3UF6ivt2G9yj1PJmE0Q+n2f1
1o60Eu1nTtvktHIQlPT9jLn5d1yYM833AiElIkv282UDL7pMsQrmS14bYNDp/Mik
7yuAZrbFP7ypbqeFjnu37gzrpkNY6UyfY9NgZBVSsnWWLVfgZNjgoxkRTPBy6w8B
Tu9gerYvWbHlzfFrV3exGwqxluOf+nCULsHxWHcmQGuq0YISKsOOpAygN640JbuT
S4bR66Y8zuH7cIhCqKooo59DhKKqm1ExgclAAh/tXcHCayl7FLM=
=2hwG
-----END PGP SIGNATURE-----

--qe57i2nitkjrmwbp--
