Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B3655330
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiLWRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiLWRT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:19:28 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1DD18E1E;
        Fri, 23 Dec 2022 09:19:27 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 486351C09F5; Fri, 23 Dec 2022 18:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1671815965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0UrgH0jqhMRGfRbM1wFe/1v9kgVhQ5r3uRgXLy6wIE=;
        b=Xfr5fbK9bQ1mAK91/UIOhuteRcvSftS7VVmyX4yfGwGkoaC4faxx23iMnDS1Dw2Bz0RMmO
        x4Za0PQ8y89VP9N1jKpergXHnAzxg9IqlWF0oedpmkWEuTTEf+tQWdW+mbvNWWrGIBBE86
        4dUg/miaVgJSWXybeOGMGuuryN8l8vY=
Date:   Fri, 23 Dec 2022 18:19:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
Message-ID: <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
References: <20221212045558.69602-1-gch981213@gmail.com>
 <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SCGWCqnR6E4g+gaj"
Content-Disposition: inline
In-Reply-To: <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SCGWCqnR6E4g+gaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Add dt binding schema for WorldSemi WS2812B driven using SPI
> > bus.
> >=20
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > ---
> > Changes since v1:
> > remove linux driver reference from description
> > remove some obvious descriptions
> > fix unit address regex in multi-led property
> > drop various minItems
> > add maxItems =3D 1 to reg
> > fix node names and property orders in binding example
> > drop -spi from compatible string
> > add default-brightness
> >=20
> > Change since v2:
> > drop "this patch" from commit message
> > rename leds to led-controller
> > drop default-brightness and default-intensity
> >=20
> > Change since v3:
> > reword commit title
> >=20
> >  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws=
2812b.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.y=
aml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > new file mode 100644
> > index 000000000000..548c05ac3d31
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: WS2812B LEDs driven using SPI
> > +
> > +maintainers:
> > +  - Chuanhong Guo <gch981213@gmail.com>
> > +
> > +description: |
> > +  WorldSemi WS2812B is a individually addressable LED chip that can be=
 chained
> > +  together and controlled individually using a single wire.
> > +  This binding describes a chain of WS2812B LEDs connected to the SPI =
MOSI pin.
> > +  Typical setups includes connecting the data pin of the LED chain to =
MOSI as
> > +  the only device or using CS and MOSI with a tri-state voltage-level =
shifter
> > +  for the data pin.
> > +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be =
correct
> > +  and the controller needs to send all the bytes continuously.
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: worldsemi,ws2812b
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    minimum: 2105000
> > +    maximum: 2850000
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^multi-led@[0-9a-f]+$":
> > +    type: object
> > +    $ref: leds-class-multicolor.yaml#
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      color-index:
> > +        description: |
> > +          A 3-item array specifying color of each components in this L=
ED. It
> > +          should be one of the LED_COLOR_ID_* prefixed definitions fro=
m the
> > +          header include/dt-bindings/leds/common.h. Defaults to
> > +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
> > +          if unspecified.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        maxItems: 3
>=20
> In general I am fine with it, although there is still question for
> adding more multi-color defines in binding headers to replace this
> property - GRB/RBG/GBR and even more for RGBW.
>=20
> Pavel, Lee, any thoughts from your side?

This really needs to mention the name this hardware is known as -- I
believe it is NeoPixel.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--SCGWCqnR6E4g+gaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY6XjHAAKCRAw5/Bqldv6
8gn+AJ0b+738lBlAYPSkvgIHfBMIWAWRCQCeOxXAYeDwNQi2NW+1vd6cfdGQO3E=
=zmmk
-----END PGP SIGNATURE-----

--SCGWCqnR6E4g+gaj--
