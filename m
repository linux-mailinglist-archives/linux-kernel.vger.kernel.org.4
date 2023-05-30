Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A32716107
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjE3NEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjE3NEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:04:48 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8D92;
        Tue, 30 May 2023 06:04:45 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685451884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmPQhv9rk2FY0Dj1q8NkqcUp7Unf/9KG3fhiEiMO6vs=;
        b=TQUO+3sxL5DCRhX3BMmVIfaL9RungZMmhclyISx+IfTQHiG1ZWJVXEF3cC9oYsxOy4vTBP
        CKr/02mY8n7nj3EPBfR9ezADtA3dtxctkTVQzG4H/KDoBNOjnmDFyjBYIgOGMcIxmWaAgf
        ZyWrjh85YCg9uV+xfDH4MxMKVVhnFIOA3X6dHDyF2WS3DukwL+mu2uyYQCr7bVRajF2843
        1bl9N8VySxpyDPHNrgToEwiRL5U1Q3mWnanODYT/hvspO07Oiqr471atD0S4MBmzi0hO2m
        fllPUI1bOuZIwmdW8djbSTQl4UFoV5yiit1gpch4li9vcZ99hrhtDFAkuxGkVg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09C0DE0008;
        Tue, 30 May 2023 13:04:40 +0000 (UTC)
Date:   Tue, 30 May 2023 15:04:39 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, vadym.kochan@plvision.eu,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        enachman@marvell.com
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20230530150439.7f287b7a@xps-13>
In-Reply-To: <a1b2caed-b314-59db-ee00-92fc983150f6@linaro.org>
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
        <20230530005337.3687938-2-chris.packham@alliedtelesis.co.nz>
        <a1b2caed-b314-59db-ee00-92fc983150f6@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Tue, 30 May 2023 14:24:22 +0200:

> On 30/05/2023 02:53, Chris Packham wrote:
> > From: Vadym Kochan <vadym.kochan@plvision.eu>
> >=20
> > Switch the DT binding to a YAML schema to enable the DT validation.
> >=20
> > Dropped deprecated compatibles and properties described in txt file.
> >=20
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >=20
> > Notes:
> >     Changes in v6:
> >     - remove properties covered by nand-controller.yaml
> >     - add example using armada-8k compatible
> >    =20
> >     earlier changes:
> >    =20
> >     v5:
> >        1) Get back "label" and "partitions" properties but without =20
>=20
> Where are they? Did you drop them in v6?

label and partitions are defined in partitions/partition.yaml,
referenced by partitions.yaml, referenced by mtd.yaml, referenced by
nand-chip.yaml, referenced by nand-controller.yaml, itself referenced
in this file :-)

So I believe there is nothing else to add in the controller's binding
for these two properties? They are very generic, it would not be
optimal if we had to take care about them.

> >           ref to the "partition.yaml" which was wrongly used. =20
>=20
>=20
> >    =20
> >        2) Add "additionalProperties: false" for nand@ because all possi=
ble
> >           properties are described. =20
>=20
> Where? This cannot be silently dropped!
>=20
> >    =20
> >     v4:
> >        1) Remove "label" and "partitions" properties
> >    =20
> >        2) Use 2 clocks for A7K/8K platform which is a requirement
> >    =20
> >     v3:
> >       1) Remove txt version from the MAINTAINERS list
> >    =20
> >       2) Use enum for some of compatible strings
> >    =20
> >       3) Drop:
> >             #address-cells
> >             #size-cells:
> >    =20
> >          as they are inherited from the nand-controller.yaml
> >    =20
> >       4) Add restriction to use 2 clocks for A8K SoC
> >    =20
> >       5) Dropped description for clock-names and extend it with
> >          minItems: 1
> >    =20
> >       6) Drop description for "dmas"
> >    =20
> >       7) Use "unevalautedProperties: false"
> >    =20
> >       8) Drop quites from yaml refs.
> >    =20
> >       9) Use 4-space indentation for the example section
> >    =20
> >     v2:
> >       1) Fixed warning by yamllint with incorrect indentation for compa=
tible list
> >=20
> >  .../bindings/mtd/marvell,nand-controller.yaml | 190 ++++++++++++++++++
> >  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ------------
> >  MAINTAINERS                                   |   1 -
> >  3 files changed, 190 insertions(+), 127 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-=
controller.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.=
txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-control=
ler.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.ya=
ml
> > new file mode 100644
> > index 000000000000..c4b003f5fa9f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > @@ -0,0 +1,190 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell NAND Flash Controller (NFC)
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Is it correct person for Marvell NAND? This should be not a subsystem
> maintainer, but a device maintainer.

I did not bother converting this file yet but I actually rewrote the
corresponding Linux driver (5 years ago) entirely so I don't mind.

>=20
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: marvell,armada-8k-nand-controller
> > +          - const: marvell,armada370-nand-controller

I don't think we ever wanted having these two compatibles to describe a
single hardware block?

> > +      - enum:
> > +          - marvell,armada370-nand-controller
> > +          - marvell,pxa3xx-nand-controller =20
>=20
> You miss here deprecated compatibles, which are BTW still used. Don't
> drop properties and compatibles during conversion.
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Shall reference the NAND controller clocks, the second one is
> > +      is only needed for the Armada 7K/8K SoCs
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names: =20
>=20
> Missing minItems: 1
>=20
> > +    items:
> > +      - const: core
> > +      - const: reg
> > +
> > +  dmas:
> > +    maxItems: 1
> > +
> > +  dma-names:
> > +    items:
> > +      - const: rxtx
> > +
> > +  marvell,system-controller:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Syscon node that handles NAND controller related regi=
sters
> > +
> > +patternProperties:
> > +  "^nand@[0-3]$":
> > +    type: object =20
>=20
> Missing unevaluatedProperties: false on this level.
>
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 3

Same as below, it is an array as well IIRC.

> > +
> > +      nand-rb:
> > +        minimum: 0
> > +        maximum: 1 =20
>=20
> It's an array, so this does not sound right. You might want to put it
> under items:.  Then you also miss min/maxItems.

That's true, you can have either one or two members with the value
[0-1], so you need both.

> > +
> > +      nand-ecc-step-size:
> > +        const: 512
> > +
> > +      nand-ecc-strength:
> > +        enum: [1, 4, 8]

The controller (and the driver) actually supports 1, 4, 8, 12, 16.

> > +
> > +      marvell,nand-keep-config:
> > +        description: |
> > +          Orders the driver not to take the timings from the core and
> > +          leaving them completely untouched. Bootloader timings will t=
hen
> > +          be used.
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +
> > +      marvell,nand-enable-arbiter:
> > +        description: |
> > +          To enable the arbiter, all boards blindly used it,
> > +          this bit was set by the bootloader for many boards and even =
if
> > +          it is marked reserved in several datasheets, it might be nee=
ded to set
> > +          it (otherwise it is harmless) so whether or not this propert=
y is set,
> > +          the bit is selected by the driver.

Maybe we should slightly rephrase this to avoid driver related
information.

> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        deprecated: true
> > +
> > +    required:
> > +      - reg
> > +      - nand-rb
> > +
> > +allOf:
> > +  - $ref: nand-controller.yaml
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: marvell,pxa3xx-nand-controller
> > +    then:
> > +      required:
> > +        - dmas
> > +        - dma-names
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: marvell,armada-8k-nand-controller
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 2
> > +          maxItems: 2 =20
>=20
> Drop maxItems. You don't have it in clock-names.
>=20
> > +
> > +        clock-names:
> > +          minItems: 2
> > +
> > +      required:
> > +        - marvell,system-controller
> > +    else:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +
> > +        clock-names:
> > +          maxItems: 1 =20
>=20
> I doubt that you tested it in above variant...
>=20
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    nand_controller: nand-controller@d0000 {
> > +        compatible =3D "marvell,armada370-nand-controller";
> > +        reg =3D <0xd0000 0x54>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>; =20
>=20
>=20
> Best regards,
> Krzysztof
>=20

Thanks for doing this!

Miqu=C3=A8l
