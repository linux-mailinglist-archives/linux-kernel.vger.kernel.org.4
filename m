Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998606C1F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCTSZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCTSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:24:24 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306F117CC2;
        Mon, 20 Mar 2023 11:17:30 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D6CDFF806;
        Mon, 20 Mar 2023 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679336224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VE9iFwvJbQJycN1cPQjjeYOTfZMxlt7ktbeI3hjJv3I=;
        b=kDEgygYGf8SV8e3tktz1z2mhccSlvObV3fCD3DrW5M9t918MS6QTjTiAjvXiTl2BtbmIsm
        ypWfutueHQJNM7ICR3KerrnkG83/CHZrLE1twQUP54YXYWuqw8Du0smDHY0p+Zzig4ssUy
        Ehzbm6JZz4A52ajdBtOAIgNdTZEVNyjY5FeY4ZXDXpEWVsryqpiEm3cBTA1z6XNYYtFv0+
        keqOPc3+aS2CJq1Kq9AQynr00z8AUTEPiJyprIRXuNv9bDdEqXh+YDjcamfJEYTBive77P
        y0AeyEcxd1aZPGcZ2oZy3AxuTAqcsqfjX12Ua3+p/1iBwid8dabF51X1S+XpBA==
Date:   Mon, 20 Mar 2023 19:17:00 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: sound: Add support for the Lantiq
 PEF2256 codec
Message-ID: <20230320191700.3d48e264@bootlin.com>
In-Reply-To: <2d4dae57-e46d-7e81-9b56-2148074c8406@linaro.org>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
        <20230316122741.577663-6-herve.codina@bootlin.com>
        <2d4dae57-e46d-7e81-9b56-2148074c8406@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Fri, 17 Mar 2023 09:57:11 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/03/2023 13:27, Herve Codina wrote:
> > The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a
> > framer and line interface component designed to fulfill all required
> > interfacing between an analog E1/T1/J1 line and the digital PCM system
> > highway/H.100 bus.
> >=20
> > The codec support allows to use some of the PCM system highway
> > time-slots as audio channels to transport audio data over the E1/T1/J1
> > lines.
> >  =20
>=20
> Your other file should also have specific compatible, unless this codec
> is actually part of the framer. Did not look like this in the binding -
> not $ref.

No sure to understand what you mean.

Anyway, I plan to use a MFD device for pef2256 and reference this yaml
from the lantiq,pef2256.yaml in the node related to the codec.

One question related to bindings and related checks:
Is there a way to check the compatible property of the parent node.
I mean, here is the binding of a child node of a MFD node.
=46rom this binding, I would like to be sure that the parent is really a
pef2256 MFD node.

May be something like:
  parent-properties:
    allOf:
      compatible:
        contains:
          const: lantiq,pef2256

The idea is to have dtbs_check raise an error if the parent's compatible
property is not 'lantiq,pef2256'.

=46rom parent, the link is checked using:
  properties:
    codec:
      $ref: /schemas/sound/lantiq,pef2256-codec.yaml

but nothing prevent to use this 'lantiq,pef2256-codec' binding from a node
that has nothing to do with pef2256.

>=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/sound/lantiq,pef2256-codec.yaml  | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2=
256-codec.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-cod=
ec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> > new file mode 100644
> > index 000000000000..acba3a0ccd1b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lantiq PEF2256 codec device =20
>=20
> Drop "device". Everything is "device".

Will be dropped in v3 series.

>=20
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |
> > +  Codec support for PEF2256.
> > +
> > +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a =
framer and
> > +  line interface component designed to fulfill all required interfacin=
g between
> > +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
> > +
> > +  The codec support allows to use some of the PCM system highway time-=
slots as
> > +  audio channels to transport audio data over the E1/T1/J1 lines.
> > +
> > +  The time-slots used by the codec must be set and so, the properties
> > +  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
> > +  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node f=
or
> > +  sub-nodes that involve the codec. The codec uses 8bit time-slots.
> > +  'dai-tdm-tdm-slot-with' must be set to 8.
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

Oups,
This device is not on a SPI bus -> will be dropped in v3 series.

> > +  - $ref: dai-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: lantiq,pef2256-codec
> > +
> > +  lantiq,pef2256:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle to the PEF2256 =20
>=20
> Why not its child? Why this is in parallel ?

Indeed,
I will move to MFD, remove this phandle and use the lantiq,pef2256-codec
node as a child node of lantiq,pef2256.

>=20
> > +
> > +  '#sound-dai-cells':
> > +    const: 0
> > + =20
>=20
>=20
> Best regards,
> Krzysztof
>=20

Thanks for the review,

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
