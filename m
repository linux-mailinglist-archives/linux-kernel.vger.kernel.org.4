Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1BD735F62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjFSVxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSVxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:53:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEA6E2;
        Mon, 19 Jun 2023 14:53:28 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 656696606F13;
        Mon, 19 Jun 2023 22:53:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687211607;
        bh=5z8n2eraxnXQHN5g+zkp8eImcsGHHw1vCEuKhUGVzVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2Tx1iHxXwrp5tqXQdr6WGPVOo5p0HRgXZ/w9qPNtDk+NDLoy+TFaG8gf/ILplL3w
         JDC3sRZWwtJaQVugcQSIqlg+QpZdYakNWUg0DYATNk3FXjYE10vuHQZ1g5LXEHQaUc
         O9qa0LVeSkPBplcYcKKlO65LWAbgIrecvZ9PgzEw3Xz7A4Omwu3MnzHzGgZqnIzUE9
         YV6g/SNqzgfi+Y1J55WIVx8tRWZhwjU5NV1ZFRpMN6fsnB7Tb1oQUAau3tqYwEGikt
         TNvCNczQCd8ONe+8/jzflxS+zTBw0yB5ALizf0/2eFHlFlNwFErPHcjS6QcH/N4MQ4
         UUa7mRmiKP/Ow==
Received: by mercury (Postfix, from userid 1000)
        id 2FD321060A6A; Mon, 19 Jun 2023 23:53:25 +0200 (CEST)
Date:   Mon, 19 Jun 2023 23:53:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: power: reset:
 atmel,at91sam9260-shdwc: convert to yaml
Message-ID: <20230619215325.5wbjnbvq4aw2nquj@mercury.elektranox.org>
References: <20230616101646.879480-1-claudiu.beznea@microchip.com>
 <20230616101646.879480-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3dmf6ievniy44dey"
Content-Disposition: inline
In-Reply-To: <20230616101646.879480-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3dmf6ievniy44dey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 16, 2023 at 01:16:44PM +0300, Claudiu Beznea wrote:
> Convert Microchip AT91 shutdown controller to YAML.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>  .../devicetree/bindings/arm/atmel-sysregs.txt | 31 -------
>  .../power/reset/atmel,at91sam9260-shdwc.yaml  | 82 +++++++++++++++++++
>  2 files changed, 82 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,a=
t91sam9260-shdwc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Do=
cumentation/devicetree/bindings/arm/atmel-sysregs.txt
> index ab1b352344ae..e6b2fb291b45 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -52,37 +52,6 @@ Example:
>  		reg =3D <0xe3804000 0x1000>;
>  };
> =20
> -SHDWC Shutdown Controller
> -
> -required properties:
> -- compatible: Should be "atmel,<chip>-shdwc".
> -  <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".
> -- reg: Should contain registers location and length
> -- clocks: phandle to input clock.
> -
> -optional properties:
> -- atmel,wakeup-mode: String, operation mode of the wakeup mode.
> -  Supported values are: "none", "high", "low", "any".
> -- atmel,wakeup-counter: Counter on Wake-up 0 (between 0x0 and 0xf).
> -
> -optional at91sam9260 properties:
> -- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
> -
> -optional at91sam9rl properties:
> -- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
> -- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
> -
> -optional at91sam9x5 properties:
> -- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
> -
> -Example:
> -
> -	shdwc@fffffd10 {
> -		compatible =3D "atmel,at91sam9260-shdwc";
> -		reg =3D <0xfffffd10 0x10>;
> -		clocks =3D <&clk32k>;
> -	};
> -
>  SHDWC SAMA5D2-Compatible Shutdown Controller
> =20
>  1) shdwc node
> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,at91sam9=
260-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,at91sa=
m9260-shdwc.yaml
> new file mode 100644
> index 000000000000..f559a2cfd82e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shd=
wc.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/atmel,at91sam9260-shdwc.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91 SHDWC Shutdown Controller
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
> +    enum:
> +      - atmel,at91sam9260-shdwc
> +      - atmel,at91sam9rl-shdwc
> +      - atmel,at91sam9x5-shdwc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  atmel,wakeup-mode:
> +    description: operation mode of the wakeup mode
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ none, high, low, any ]
> +
> +  atmel,wakeup-counter:
> +    description: counter on wake-up 0
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +
> +  atmel,wakeup-rtt-timer:
> +    description: enable real-time timer wake-up
> +    type: boolean
> +
> +  atmel,wakeup-rtc-timer:
> +    description: enable real-time clock wake-up
> +    type: boolean
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
> +            const: atmel,at91sam9x5-shdwc
> +    then:
> +      properties:
> +        atmel,wakeup-rtt-timer: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: atmel,at91sam9260-shdwc
> +    then:
> +      properties:
> +        atmel,wakeup-rtc-timer: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    shdwc: poweroff@fffffd10 {
> +        compatible =3D "atmel,at91sam9260-shdwc";
> +        reg =3D <0xfffffd10 0x10>;
> +        clocks =3D <&clk32k>;
> +    };
> +
> +...
> --=20
> 2.34.1
>=20

--3dmf6ievniy44dey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSQzlQACgkQ2O7X88g7
+ppBrA//a8TlYAedWE0i0wDFTehPupN5AfUv0rbxynlHMdv8ShWk9aFamLoNXrb5
R8aWb3evB/KMY0A2R2DIBEOBlbyerjjKsm2ysbDMpesmda9UzxcmGCB2pqqciuvc
pWL3Ze8QSAsgn6JnJ++wx56axC7zYmKBRn8VWeVEjCcWEoIMjJxQI0NDx9q00N9W
MJtSODPsFYneL6rqUu68uSx2yy43VNfI+7PNEA4/RoS2Yr4S6x9LCMFi+N/1YV4n
wAfHt2PM2ioED0SVxmSL+SFtOOVo6foeV86qR4HqmK7TJprkLXOGVhH9T9IA0IxF
J5CNho/aEeP8R2gk/ZhYNpplYowKXvcqlZCx4t3l/gSMneNVcXWt9m/ov4xXFpZC
lU6SQ4NmvQoB0dEdJDe7pqttNoxOyQrBech+DswfE3Lwz+gxLmK4ex1Xief3utFt
d3T4s4+a8jDTbdJsYIZzH7tzVi7ufShI+0fDIpGGryXCJSW6n0uMf2g++j5BZcXE
dxldodB81lkYEye+GcnIzFdVP12OuncxFSXJ6ZERIk2v3funlKed70F+U7Xt/lur
jp6EAo9wXZn35YmbJCz1ojuNnartGZXJhd3WtIkxeeYvxGvkyvpxPmb6tyYrpTh4
HT2mp43gKlBC3dOLEaK/ijXmq4ZWvzVWKOy+xV+vtxldfoMSujQ=
=EFtf
-----END PGP SIGNATURE-----

--3dmf6ievniy44dey--
