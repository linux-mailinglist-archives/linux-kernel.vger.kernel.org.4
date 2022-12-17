Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D364FB69
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 18:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLQRuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 12:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLQRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 12:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A512DCE;
        Sat, 17 Dec 2022 09:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74F1AB803F3;
        Sat, 17 Dec 2022 17:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D07C433EF;
        Sat, 17 Dec 2022 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671299442;
        bh=V5/tPOA23XGLvHxP7Wp2/GHmPh9tPgDd/LiGvXHHJOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMp+CVa1qh3/ltOTFGssk2SFTaBO5+XqoeJfLnltEJzc4Y3lnuxIuzDfMjBbO0WPo
         nNncCVEE+vll5OUAADrhUOYf78L+/jE800U5ipsMjRjh5X+kUeuaBHeYBDxLacdPIH
         5K1fv8vLFGiSJXgBv6unixc4SZJGGfDUCVP6+s71nN+r9AXRVACgfY196ogbbjCEtX
         mMERdU62sp/TT88tuG51AyJKpOdm62+ht2Gr4csd6Uiar7ZF9ZBBbFGS8EPljZuDey
         C75mRvuZm2uY0kUmjW9GpxObYmqwCA++4kIXCylts+M/Csq9I03An6M5gh5s1ttWbO
         lecWk1rHgrIgg==
Date:   Sat, 17 Dec 2022 17:50:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: gpio-fan: convert to YAML
Message-ID: <Y54BbjoRm5z2Tlp8@spud>
References: <20220126200350.3633576-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J9cZgbLLDluj0yxy"
Content-Disposition: inline
In-Reply-To: <20220126200350.3633576-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J9cZgbLLDluj0yxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 26, 2022 at 08:03:50PM +0000, Corentin Labbe wrote:
> Converts hwmon/gpio-fan.txt to YAML
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>=20
> I didnt found any clear maintainer and since DT yaml mandates a
> maintainer section, I set devicetree@vger.kernel.org.

Hey Corentin,
Looks like there were only some minor comments from Rob on this patch,
but I do not see a v2 on lore. Just never get around to sending a v2, or
did it fall through the cracks?
Thanks,
Conor.

>=20
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 --------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Docum=
entation/devicetree/bindings/hwmon/gpio-fan.txt
> deleted file mode 100644
> index f4cfa350f6a1..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Bindings for fan connected to GPIO lines
> -
> -Required properties:
> -- compatible : "gpio-fan"
> -
> -Optional properties:
> -- gpios: Specifies the pins that map to bits in the control value,
> -  ordered MSB-->LSB.
> -- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
> -  control value that should be set to achieve them. This array
> -  must have the RPM values in ascending order.
> -- alarm-gpios: This pin going active indicates something is wrong with
> -  the fan, and a udev event will be fired.
> -- #cooling-cells: If used as a cooling device, must be <2>
> -  Also see:
> -  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> -  min and max states are derived from the speed-map of the fan.
> -
> -Note: At least one the "gpios" or "alarm-gpios" properties must be set.
> -
> -Examples:
> -
> -	gpio_fan {
> -		compatible =3D "gpio-fan";
> -		gpios =3D <&gpio1 14 1
> -			 &gpio1 13 1>;
> -		gpio-fan,speed-map =3D <0    0
> -				      3000 1
> -				      6000 2>;
> -		alarm-gpios =3D <&gpio1 15 1>;
> -	};
> -	gpio_fan_cool: gpio_fan {
> -		compatible =3D "gpio-fan";
> -		gpios =3D <&gpio2 14 1
> -			 &gpio2 13 1>;
> -		gpio-fan,speed-map =3D	<0    0>,
> -					<3000 1>,
> -					<6000 2>;
> -		alarm-gpios =3D <&gpio2 15 1>;
> -		#cooling-cells =3D <2>; /* min followed by max */
> -	};
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Docu=
mentation/devicetree/bindings/hwmon/gpio-fan.yaml
> new file mode 100644
> index 000000000000..15bb5efd3cb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/gpio-fan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for fan connected to GPIO lines
> +
> +maintainers:
> +  - OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.ke=
rnel.org>
> +
> +properties:
> +  compatible:
> +    const: gpio-fan
> +
> +  gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Specifies the pins that map to bits in the control valu=
e,
> +      ordered MSB-->LSB.
> +
> +  gpio-fan,speed-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: A mapping of possible fan RPM speeds and the
> +      control value that should be set to achieve them. This array
> +      must have the RPM values in ascending order.
> +
> +  alarm-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: This pin going active indicates something is wrong with
> +      the fan, and a udev event will be fired.
> +
> +  "#cooling-cells":
> +    const: 2
> +    description: If used as a cooling device, must be <2>
> +      Also see Documentation/devicetree/bindings/thermal/thermal-cooling=
-devices.yaml
> +      min and max states are derived from the speed-map of the fan.
> +
> +anyOf:
> +  - required:
> +      - gpios
> +  - required:
> +      - alarm-gpios
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    #include <dt-bindings/reset/cortina,gemini-reset.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    gpio1: gpio@4d000000 {
> +      compatible =3D "cortina,gemini-gpio", "faraday,ftgpio010";
> +      reg =3D <0x4d000000 0x100>;
> +      interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;
> +      resets =3D <&syscon GEMINI_RESET_GPIO0>;
> +      clocks =3D <&syscon GEMINI_CLK_APB>;
> +      gpio-controller;
> +      #gpio-cells =3D <2>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <2>;
> +    };
> +    gpio_fan {
> +      compatible =3D "gpio-fan";
> +        gpios =3D <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +        gpio-fan,speed-map =3D <0    0>,
> +                             <3000 1>,
> +                             <6000 2>;
> +        alarm-gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    #include <dt-bindings/reset/cortina,gemini-reset.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    gpio2: gpio@4d000000 {
> +      compatible =3D "cortina,gemini-gpio", "faraday,ftgpio010";
> +      reg =3D <0x4d000000 0x100>;
> +      interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;
> +      resets =3D <&syscon GEMINI_RESET_GPIO0>;
> +      clocks =3D <&syscon GEMINI_CLK_APB>;
> +      gpio-controller;
> +      #gpio-cells =3D <2>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <2>;
> +    };
> +    gpio_fan_cool: gpio_fan {
> +      compatible =3D "gpio-fan";
> +      gpios =3D <&gpio2 8 GPIO_ACTIVE_HIGH
> +               &gpio2 1 GPIO_ACTIVE_HIGH>;
> +      gpio-fan,speed-map =3D <0    0
> +                           3000 1
> +                           6000 2>;
> +      alarm-gpios =3D <&gpio2 15 GPIO_ACTIVE_HIGH>;
> +      #cooling-cells =3D <2>; /* min followed by max */
> +    };
> --=20
> 2.34.1
>=20
>=20

--J9cZgbLLDluj0yxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY54BbQAKCRB4tDGHoIJi
0o9tAP4uLHXmJOt9syq4cRw8WtmC3czmyza6bquTAwVjIyXCnwEApwfTn9+n6yzG
ZvvNOC+6QJbNKiyMjcs3kV9Q++41gwk=
=eGzC
-----END PGP SIGNATURE-----

--J9cZgbLLDluj0yxy--
