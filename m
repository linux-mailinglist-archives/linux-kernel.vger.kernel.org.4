Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD9966610F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjAKQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbjAKQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:55:35 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC50175BF;
        Wed, 11 Jan 2023 08:55:32 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4B410240012;
        Wed, 11 Jan 2023 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673456131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K356X//TimxDBm/vu7Ro7u6rdfLfd6xkIrNtNicpCNE=;
        b=ByQ5wL3IeFj399NTShVg/IImGzxVLKZJd2olKqJ4si/vUBIRkaEjZt5iMoI2bVDkz5J3ii
        wMGNKfvWFqKk7QGF9T7TDEfzlYqwVvczMd1rR/1f1EBmLXn441l2E2Hi6jOZRPCx1CZU0T
        H9TWDN5pEhRlYU0szSNK3GJasOaTWxKresd1ApcFdFOhfHJ/8q//WhRgnw2DzOc2qwU1wq
        +0AS+mmLWgvjsH+D3v2j596N1glvMeDygDytD1ImTKiazYlx9BO1AXtEFeHpj5hj1sLhic
        ggo5y93r+vHVgSoJZ6wu6fIPU58pTl4NHcnQbvdiHRNW3eaMnsiDmuhSw2x+2g==
Date:   Wed, 11 Jan 2023 17:55:27 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: sound: Add Renesas IDT821034 codec
Message-ID: <20230111175527.10289d16@bootlin.com>
In-Reply-To: <c4497bde-c1e0-1efc-7a46-233495f7760b@linaro.org>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
        <20230111134905.248305-2-herve.codina@bootlin.com>
        <c4497bde-c1e0-1efc-7a46-233495f7760b@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 17:28:11 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/01/2023 14:49, Herve Codina wrote:
> > The Renesas IDT821034 codec is a quad PCM codec with
> > programmable gain.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/sound/renesas,idt821034.yaml     | 97 +++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/renesas,idt=
821034.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/renesas,idt821034.=
yaml b/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
> > new file mode 100644
> > index 000000000000..2c29b770e3f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/renesas,idt821034.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas IDT821034 codec device
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |
> > +  The IDT821034 codec is a four channel PCM codec with onchip filters =
and
> > +  programmable gain setting.
> > +
> > +  The time-slots used by the codec must be set and so, the properties
> > +  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
> > +  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node f=
or
> > +  sub-nodes that involve the codec. The codec uses one 8bit time-slot =
per
> > +  channel.
> > +  'dai-tdm-tdm-slot-with' must be set to 8.
> > +
> > +  The IDT821034 codec also supports 5 gpios (SLIC signals) per channel.
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - $ref: /schemas/gpio/gpio.yaml# =20
>=20
> This one is never needed. Drop.

Ok, I will drop it in v2.

>=20
> > +  - $ref: dai-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,idt821034
> > +
> > +  reg:
> > +    description:
> > +      SPI device address.
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 8192000
> > +
> > +  spi-cpha: true
> > +
> > +  '#sound-dai-cells':
> > +    const: 0
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cpha
> > +  - '#sound-dai-cells'
> > +  - gpio-controller
> > +  - '#gpio-cells'
> > +
> > +additionalProperties: false =20
>=20
> This should be rather unevaluatedProperties: false, so other properties
> from spi-props and dai-common will work.

Ok, I will change in v2.

>=20
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +        codec: idt821034@0 { =20
>=20
> Node names should be generic, so "audio-codec"
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>=20
> > +            compatible =3D "renesas,idt821034";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <8192000>;
> > +            spi-cpha;
> > +            #sound-dai-cells =3D <0>;
> > +            gpio-controller;
> > +            #gpio-cells =3D <2>;
> > +        };
> > +    };
> > +    sound {
> > +        compatible =3D "simple-audio-card"; =20
>=20
> Drop sound{} node. Not relevant to the case here and it's the same in
> every case of audio codec... unless something here is specific. But even
> the dai-tdm properties are sound card specific.

Indeed, I wanted to show the dai-tdm properties.
But ok, I will drop the node.

>=20
>=20
> Best regards,
> Krzysztof
>=20

Thanks for the review.

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
