Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF53A6C0DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCTJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCTJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:46:27 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25731ACD3;
        Mon, 20 Mar 2023 02:46:23 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 40453C0009;
        Mon, 20 Mar 2023 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679305582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ieu9Fv38se4lD4z/BVXUHLrVJL9Tx5iKWZgvO8X+VoY=;
        b=m4O7nLC1LPZDOI5eM/hmgqouxdkin2veA6CvJhT9kU9rGQALB3ya2fuybMfDvrkTqqBjEd
        j6DAxXMgOKgwuUfEsZsp3BFJpoii00hSaf0r2uIbnnGcUrDGVQqUQVEqv51O6VBqnrViQk
        PstlJM0lcE9R/AFASd5D/HQGoYYyRY+NKT7xt8g1Ax23Yk/tUG59LXku/skn/4faSLodnU
        vV2ng3VMUcoLuvSMJtdYY3hrXEWqUrW1ZogxAFHJNiKuyOELmqZGmNo4B4yAFOEcqqyano
        /f4m/7BtT7X1wwPvGu29gg+0aOFrGQq5kb4UNrMoriSQyKnxPRha8zL3J2Jckw==
Date:   Mon, 20 Mar 2023 10:46:19 +0100
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
Subject: Re: [PATCH v2 1/7] dt-bindings: misc: Add the Lantiq PEF2466
 E1/T1/J1 framer
Message-ID: <20230320104619.468a304b@bootlin.com>
In-Reply-To: <96b01241-d57d-a460-4a8b-9e83eaab24ae@linaro.org>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
        <20230316122741.577663-2-herve.codina@bootlin.com>
        <96b01241-d57d-a460-4a8b-9e83eaab24ae@linaro.org>
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

On Fri, 17 Mar 2023 09:54:07 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/03/2023 13:27, Herve Codina wrote:
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/misc/lantiq,pef2256.yaml         | 190 ++++++++++++++++++
> >  1 file changed, 190 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/lantiq,pef22=
56.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml=
 b/Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml
> > new file mode 100644
> > index 000000000000..1ba788d06a14
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml
> > @@ -0,0 +1,190 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/lantiq,pef2256.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lantiq PEF2256
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description:
> > +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a =
framer and
> > +  line interface component designed to fulfill all required interfacin=
g between
> > +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
> > +
> > +properties:
> > +  compatible:
> > +    const: lantiq,pef2256
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Master clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: mclk
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIO used to reset the device.
> > +    maxItems: 1
> > +
> > +  pinctrl:
> > +    allOf:
> > +      - $ref: "/schemas/pinctrl/pinctrl.yaml#" =20
>=20
> Drop quotes. Drop allOf, no need for it.
>=20
> additionalProperties: false

Will be dropped and added in v3

>=20
> > +
> > +    patternProperties:
> > +      '-pins$':
> > +        type: object
> > +        allOf:
> > +          - $ref: "/schemas/pinctrl/pincfg-node.yaml#" =20
>=20
> Drop quotes. Drop allOf, no need for it.
>=20
> additionalProperties: false
>=20

Will be dropped and added in v3

>=20
> > +
> > +        properties:
> > +          pins:
> > +            enum: [ RPA, RPB, RPC, RPD, XPA, XPB, XPC, XPD ]
> > +
> > +          function:
> > +            enum: [ SYPR, RFM, RFMB, RSIGM, RSIG, DLR, FREEZE, RFSP, L=
OS,
> > +                    SYPX, XFMS, XSIG, TCLK, XMFB, XSIGM, DLX, XCLK, XL=
T,
> > +                    GPI, GPOH, GPOL ]
> > +
> > +        required:
> > +          - pins
> > +          - function
> > +
> > +  lantiq,line-interface:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [e1, t1j1]
> > +    default: e1
> > +    description: |
> > +      The line interface type
> > +        - e1: E1 line
> > +        - t1j1: T1/J1 line
> > +
> > +  lantiq,sysclk-rate-hz:
> > +    enum: [2048000, 4096000, 8192000, 16384000]
> > +    default: 2048000
> > +    description:
> > +      Clock rate (Hz) on the system highway. =20
>=20
> I am pretty sure we have discussions on sysclk for other drivers. First,
> why you cannot use assigned-clock-rates? Or clk_get_rate() if this is
> about being consumer?
>=20
> Second, there is already system-clock-frequency property, so use it.

Indeed, I will added the related clocks in the 'clocks' property and use
clk_get_rate() in the driver.

>=20
> > +
> > +  lantiq,data-rate-bps:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [2048000, 4096000, 8192000, 16384000]
> > +    default: 2048000
> > +    description:
> > +      Data rate (bit per seconds) on the system highway. =20
>=20
> Why do you need it? How is it different from clock? Do you expect some
> DDR here?

This is needed to set the data position on the data line.
If the data line clock (sysclk-rate-hz) is greater than 'data-rate-bps',
the device interleaves some holes between data in the full frame.

The exact position of the data and the holes is defined by 'channel-phase'

So, two information are needed:
- The number of slots available (deduced from 'lantiq,data-rate-bps')
- The slot to use in the available slots ('lantiq,channel-phase" property

lantiq,data-rate-bps is not a clock but a property used to set the frame
physical setting. ie the correct data position in the frame.=20

>=20
> > +
> > +  lantiq,clock-falling-edge:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Data is sent on falling edge of the clock (and received on the r=
ising
> > +      edge). If 'clock-falling-edge' is not present, data is sent on t=
he
> > +      rising edge (and received on the falling edge).
> > +
> > +  lantiq,channel-phase:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +    default: 0
> > +    description:
> > +      The pef2256 delivers a full frame (32 8bit time-slots in E1 and =
24 8bit
> > +      time-slots 8 8bit signaling in E1/J1) every 125us. This lead to =
a data
> > +      rate of 2048000 bit/s. When lantiq,data-rate-bps is more than 20=
48000
> > +      bit/s, the data (all 32 8bit) present in the frame are interleav=
e with
> > +      unused time-slots. The lantiq,channel-phase property allows to s=
et the
> > +      correct alignment of the interleave mechanism.
> > +      For instance, suppose lantiq,data-rate-bps =3D 8192000 (ie 4*204=
8000), and
> > +      lantiq,channel-phase =3D 2, the interleave schema with unused ti=
me-slots
> > +      (nu) and used time-slots (XX) for TSi is
> > +        nu nu XX nu nu nu XX nu nu nu XX nu
> > +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> > +      With lantiq,data-rate-bps =3D 8192000, and lantiq,channel-phase =
=3D 1, the
> > +      interleave schema is
> > +        nu XX nu nu nu XX nu nu nu XX nu nu
> > +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> > +      With lantiq,data-rate-bps =3D 4096000 (ie 2*2048000), and
> > +      lantiq,channel-phase =3D 1, the interleave schema is
> > +        nu    XX    nu    XX    nu    XX
> > +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> > +
> > +  lantiq,subordinate:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      If present, the pef2256 works in subordinate mode. In this mode =
it
> > +      synchronizes on line interface clock signals. Otherwise, it sync=
hronizes
> > +      on internal clocks.
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        lantiq,line-interface:
> > +          contains:
> > +            const: e1
> > +    then:
> > +      properties:
> > +        lantiq,frame-format: =20
>=20
> Do not define properties in if:then, but in top-level. Disallow them or
> customize for the specific cases in if:then

Will be changed in v3.

>=20
> > +          $ref: /schemas/types.yaml#/definitions/string
> > +          enum: [doubleframe, crc4-multiframe, auto-multiframe]
> > +          default: doubleframe
> > +          description: |
> > +            The E1 line interface frame format
> > +              - doubleframe: Doubleframe format
> > +              - crc4-multiframe: CRC4 multiframe format
> > +              - auto-multiframe: CRC4 multiframe format with interwork=
ing
> > +                                 capabilities (ITU-T G.706 Annex B)
> > +
> > +    else:
> > +      # T1/J1 line
> > +      properties:
> > +        lantiq,frame-format: =20
>=20
> Same problem - definitions go to top level.

Will be changed in v3

>=20
> > +          $ref: /schemas/types.yaml#/definitions/string
> > +          enum: [4frame, 12frame, 24frame, 72frame]
> > +          default: 12frame
> > +          description: |
> > +            The T1/J1 line interface frame format
> > +              - 4frame: 4-frame multiframe format (F4)
> > +              - 12frame: 12-frame multiframe format (F12, D3/4)
> > +              - 24frame: 24-frame multiframe format (ESF)
> > +              - 72frame: 72-frame multiframe format (F72, remote switc=
h mode)
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    pef2256@2000000 { =20
>=20
> Figure out some generic node name.

What do you think about 'framer' ?

>=20
> > +      compatible =3D "lantiq,pef2256";
> > +      reg =3D <0x2000000 0xFF>; =20
>=20
> Lowercase hex

Will be changed in v3.

>=20
> > +      interrupts =3D <8 1>; =20
>=20
> if 1 is interrupt flag, use proper defines.

Will be replaced by 'interrupts =3D <8 IRQ_TYPE_LEVEL_LOW>'
I will also change the interrupt-parent to interrupt-parent =3D <&intc>
to avoid mentioning PIC and avoid any misunderstanding as the PIC we use
does not follow the standard IRQ_TYPE_* flags.

>=20
> > +      interrupt-parent =3D <&PIC>;
> > +      clocks =3D <&clk_mclk>;
> > +      clock-names =3D "mclk";
> > +      reset-gpios =3D <&gpio 11 GPIO_ACTIVE_LOW>;
> > +      lantiq,sysclk-rate-hz =3D <8192000>;
> > +      lantiq,data-rate-bps =3D <4096000>;
> > +
> > +      pinctrl {
> > +        pef2256_rpa_sypr: rpa-pins {
> > +          pins =3D "RPA";
> > +          function =3D "SYPR";
> > +        };
> > +        pef2256_xpa_sypx: xpa-pins {
> > +          pins =3D "XPA";
> > +          function =3D "SYPX";
> > +        };
> > +      };
> > +    }; =20
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
