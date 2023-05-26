Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB6712CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbjEZTAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjEZTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBB135;
        Fri, 26 May 2023 12:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC44165298;
        Fri, 26 May 2023 19:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3023C433D2;
        Fri, 26 May 2023 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685127612;
        bh=RkwvzJ0I6kTJGMP25NGk1LAgsWO2YC303rMSAEU3yUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rt4ONT9rfEwI+/VW3IFngphHioqiGFUeP0nzpC1oIfLQKKFFwZ38RmJb71ctES2ll
         RXIZyfzkSnJmvpEgjjhZmuX8BEgqTu9TMBsuXtUOWVlF5STuOIWxVFdwS9lQGeX1ho
         x77jskuQKzN8r0Tbxg8WEKssFp78G+8eJqaWc033XaQ+n2XNzEdhIi9cpGz4KT7d/k
         uiIP+dWiFwPCMYRGJtsSOE8XjCJvCqwyxmtuERKVLTo5eNb0GiraJoXPHbGS6AXPco
         Y5veEEQRWRnz9B6Kwe01Taj4Wc61aKinY2j4FoItoxYOlY45+ay9AgS5QtOTB5Hpoq
         lfrTB+sLQNPEQ==
Date:   Fri, 26 May 2023 20:00:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <20230526-mural-expletive-76b9dd5db83b@spud>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-2-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O/CWvvC3u6tlMiiB"
Content-Disposition: inline
In-Reply-To: <20230526173955.797226-2-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O/CWvvC3u6tlMiiB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tommaso,

On Fri, May 26, 2023 at 07:39:43PM +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the ALVIUM
> Camera from Allied Vision Inc.
>=20
> References:
>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
>=20
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
> Changes since v1:
>  - Fixed build error as suggested by RHerring bot
>=20
>  .../media/i2c/alliedvision,alvium.yaml        | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvis=
ion,alvium.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alv=
ium.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.=
yaml
> new file mode 100644
> index 000000000000..81e9e560c99d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0

No dual license?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Alliedvision Alvium Camera
> +
> +maintainers:
> +  - Tommaso Merciai <tomm.merciai@gmail.com>
> +  - Martin Hecht <martin.hecht@avnet.eu>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: alliedvision,alvium
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: XCLK Input Clock

Description is a bit moot when you have the clock name and there's only
one. No harm done I suppose.

> +
> +  clock-names:
> +    const: xclk
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description: >

You don't have any newlines, so you don't need a >

> +      Reference to the GPIO connected to the powerdown pin, if any.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: >
> +      Reference to the GPIO connected to the reset pin, if any.
> +
> +  streamon-delay:
> +    maxItems: 1
> +    description: >
> +      Delay before camera start capturing frames in us.
> +
> +  rotation:
> +    enum:
> +      - 0
> +      - 180

Could style this as enum: [0, 180], but I don't mind which you do.

> +  port:
> +    description: Digital Output Port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          clock-lanes:
> +            const: 0
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 4
> +          link-frequencies: true
> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +      #include <dt-bindings/clock/imx8mp-clock.h>
> +
> +      i2c {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          camera: alvium@3c {

Label does not seem to be used & the generic node name should probably
be "camera", no?

> +              compatible =3D "alliedvision,alvium";
> +              pinctrl-names =3D "default";
> +              pinctrl-0 =3D <&pinctrl_csi0_pwn>, <&pinctrl_csi0_rst>, <&=
pinctrl_csi_mclk>;
> +              reg =3D <0x3c>;
> +              clocks =3D <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> +              clock-names =3D "xclk";
> +              assigned-clocks =3D <&clk IMX8MP_CLK_IPP_DO_CLKO2>;
> +              assigned-clock-parents =3D <&clk IMX8MP_CLK_24M>;
> +              assigned-clock-rates =3D <24000000>;
> +              streamon-delay =3D <20>;
> +              powerdown-gpios =3D <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +              reset-gpios =3D <&gpio1 6 GPIO_ACTIVE_LOW>;
> +              status =3D "okay";
> +
> +              port {
> +                  alvium_out: endpoint {

Ditto here, drop the unused label?

Otherwise, looks grand to me.

Cheers,
Conor.

> +                      remote-endpoint =3D <&mipi_csi_0_in>;
> +                      data-lanes =3D <1 2 3 4>;
> +                      link-frequencies =3D /bits/ 64 <681250000>;
> +                      clock-lanes =3D <0>;
> +                  };
> +              };
> +          };
> +      };
> +
> +...
> --=20
> 2.34.1
>=20

--O/CWvvC3u6tlMiiB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHEBtQAKCRB4tDGHoIJi
0p0aAQD8rDkDEpqAiwoTDiEV5PZe1qUVNRoUGUKnrRa2Jj7yCwD+LnwGBEJ6AD/P
UEZv+0h842TCtVATqCm4Cj9pPw/GtAg=
=0OYh
-----END PGP SIGNATURE-----

--O/CWvvC3u6tlMiiB--
