Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8CF663A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjAJIFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjAJIE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:04:59 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501B3C736;
        Tue, 10 Jan 2023 00:04:54 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B0355240002;
        Tue, 10 Jan 2023 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673337893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ld//437bDkASopb9h7+9poDloE57liYuwe18eXbKN8w=;
        b=ov0pvxlHlJUeYGpbOxfh3TlbG/6hyno/7b2AXf0AjpdSSuzkiap+N5k0H2PaOicUlgstfi
        PnIyO5WTKv+yhKA0Bc9xlkuKHckPcDQ+Df02Yqae7X8QO3DgiDahUe1TRLKHUCAGzqmaPR
        7Q4MxMrdYq1UoDOvZOywXHjr8g/Iw+sZZd4VjUTATlRBX6IQScWT87sydVl3axe3BtXyfK
        704goO65ZlkADey+Oe9wu+yQEBuJlJz5iGPO41bFpshj2KrTjwcblrZJMDVYLTrpEHu/6T
        sh218R49M4FEe4qLow6/+PHeb+00midD9UpiXNTK7VLMHZ2q6Ql01BrNjHsolg==
Date:   Tue, 10 Jan 2023 09:04:45 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Message-ID: <20230110090445.2dc61b51@bootlin.com>
In-Reply-To: <427e0775-c576-e293-f590-b9840b936884@linaro.org>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
 <20230106163746.439717-2-herve.codina@bootlin.com>
 <427e0775-c576-e293-f590-b9840b936884@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, 8 Jan 2023 16:10:38 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

[...]

> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^tdm@[0-1]$": =20
>=20
> Use consistent quotes - either ' or "

Ok, I will change on v3.
I will also change them on the other bindings present in the
series.

>=20
> > +    description:
> > +      The TDM managed by this controller
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 1
> > +        description:
> > +          The TDM number for this TDM, 0 for TDMa and 1 for TDMb
> > +
> > +      fsl,common-rxtx-pins:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Use common pins for both transmit and receive =20
>=20
> What are the "common" pins? Without this property device is using
> uncommon pins? This does not make sense...

Common in the "shared" sense.
The hardware can use dedicated pins for Tx clock, Tx sync,
Rx clock and Rx sync or use only 2 pins, Tx/Rx clock and
Rx/Rx sync.

Without the property, we use the 4 pins and with the property,
we use 2 pins.

>=20
> > +
> > +      clocks: true
> > +      clock-names: true =20
>=20
> Both need constraints.

The constraints are present later in the file as the number
of clocks depends on the 'fsl,common-rxtx-pins' property.

I will remove these two lines in the v3 series as they are
not needed. 'clocks' and 'clock-names' are handled in the
conditional part.

>=20
[...]
> > +
> > +      fsl,rx-frame-sync-delay:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2, 3]
> > +        default: 0
> > +        description: |
> > +          Receive frame sync delay. =20
>=20
> Delay in what units?

The unit is a number of bits.
I will rename to fsl,rx-frame-sync-delay-bits and change the description
to 'Receive frame sync delay in number of bits'

I will do also the same for fsl,tx-frame-sync-delay property.

>=20
> > +          Indicates the delay between the Rx sync and the first bit of=
 the
> > +          Rx frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits d=
elay.
> > +
> > +      fsl,tx-frame-sync-delay:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2, 3]
> > +        default: 0
> > +        description: |
> > +          Transmit frame sync delay.
> > +          Indicates the delay between the Tx sync and the first bit of=
 the
> > +          Tx frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits d=
elay.
> > +
> > +      fsl,clock-falling-edge:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description: |
> > +          Data is sent on falling edge of the clock (and received on t=
he
> > +          rising edge).
> > +          If 'clock-falling-edge' is not present, data is sent on the
> > +          rising edge (and received on the falling edge).
> > +
> > +      fsl,fsync-rising-edge:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Frame sync pulses are sampled with the rising edge of the ch=
annel
> > +          clock. If 'fsync-rising-edge' is not present, pulses are sam=
ple
> > +          with e falling edge.
> > +
> > +      fsl,double-speed-clock:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          The channel clock is twice the data rate.
> > +
> > +      fsl,grant-mode:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Grant mode enabled. =20
>=20
> This we know from property name. You need to describe what it is and
> what it does.

Instead of describing it, I will simply remove the property (I should
have done already).
I cannot test the 'grant mode' enabled with my hardware and so
I prefer keeping it disabled.
This property, if needed, could be add later setting it optional
with default to 'disabled'.

>=20
> > +
> > +      tx_ts_routes: =20
>=20
> No underscores, missing vendor prefix.

Indeed, will be change to fsl,tx-ts-routes (idem for rx_ts_routes).

>=20
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +        description: |
> > +          A list of tupple that indicates the Tx time-slots routes.
> > +            tx_ts_routes =3D
> > +               < 2 0 0>, /* The first 2 time slots are not used */
> > +               < 3 1 0>, /* The next 3 ones are route to SCC2 */
> > +               < 4 0 0>, /* The next 4 ones are not used */
> > +               < 2 2 0>; /* The nest 2 ones are route to SCC3 */
> > +        items:
> > +          items:
> > +            - description:
> > +                The number of time-slots
> > +              minimum: 1
> > +              maximum: 64
> > +            - description: |
> > +                The source serial interface (dt-bindings/soc/fsl-tsa.h
> > +                defines these values)
> > +                 - 0: No destination
> > +                 - 1: SCC2
> > +                 - 2: SCC3
> > +                 - 3: SCC4
> > +                 - 4: SMC1
> > +                 - 5: SMC2
> > +              enum: [0, 1, 2, 3, 4, 5]
> > +            - description:
> > +                The route flags (reserved) =20
>=20
> Why part of binding is reserved?

The 'reserved' part will be removed in v3.
Same for the rx route table.

>=20
> > +              const: 0
> > +        minItems: 1
> > +        maxItems: 64
> > +
> > +      rx_ts_routes:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +        description: |
> > +          A list of tupple that indicates the Rx time-slots routes.
> > +            tx_ts_routes =3D
> > +               < 2 0 0>, /* The first 2 time slots are not used */
> > +               < 3 1 0>, /* The next 3 ones are route from SCC2 */
> > +               < 4 0 0>, /* The next 4 ones are not used */
> > +               < 2 2 0>; /* The nest 2 ones are route from SCC3 */
> > +        items:
> > +          items:
> > +            - description:
> > +                The number of time-slots
> > +              minimum: 1
> > +              maximum: 64
> > +            - description: |
> > +                The destination serial interface (dt-bindings/soc/fsl-=
tsa.h
> > +                defines these values)
> > +                 - 0: No destination
> > +                 - 1: SCC2
> > +                 - 2: SCC3
> > +                 - 3: SCC4
> > +                 - 4: SMC1
> > +                 - 5: SMC2
> > +              enum: [0, 1, 2, 3, 4, 5]
> > +            - description:
> > +                The route flags (reserved)
> > +              const: 0
> > +        minItems: 1
> > +        maxItems: 64
> > +
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            fsl,common-rxtx-pins:
> > +              type: 'null' =20
>=20
> What is this exactly? If check for property present, it's wrong. Should
> be test if it is in required.

Yes, it was a check for the property presence.

If we not use the 'fsl,common-rxtx-pins', we need 4 clocks.
If we use the 'fsl,common-rxtx-pins', we need 2 clocks (Rx part and Tx
part use the same CLK and SYNC clocks).

How can I describe this ?
Is the check for the property presence incorrect ?

Should I always describe 4 clocks even if only 2 are used ?

>=20
> > +        then:
> > +          properties:
> > +            clocks:
> > +              items:
> > +                - description: External clock connected to L1RSYNC pin
> > +                - description: External clock connected to L1RCLK pin
> > +                - description: External clock connected to L1TSYNC pin
> > +                - description: External clock connected to L1TCLK pin
> > +            clock-names:
> > +              items:
> > +                - const: l1rsync
> > +                - const: l1rclk
> > +                - const: l1tsync
> > +                - const: l1tclk
> > +        else:
> > +          properties:
> > +            clocks:
> > +              items:
> > +                - description: External clock connected to L1RSYNC pin
> > +                - description: External clock connected to L1RCLK pin
> > +            clock-names:
> > +              items:
> > +                - const: l1rsync
> > +                - const: l1rclk
> > +
> > +    required:
> > +      - reg
> > +      - clocks
> > +      - clock-names
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/soc/fsl-tsa.h>
> > +
> > +    tsa@ae0 {
> > +        compatible =3D "fsl,mpc885-tsa", "fsl,cpm1-tsa";
> > +        reg =3D <0xae0 0x10>,
> > +              <0xc00 0x200>;
> > +        reg-names =3D "si_regs", "si_ram";
> > +
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        tdm@0 {
> > +            /* TDMa */
> > +            reg =3D <0>;
> > +
> > +            clocks =3D <&clk_l1rsynca>, <&clk_l1rclka>;
> > +            clock-names =3D "l1rsync", "l1rclk";
> > +
> > +            fsl,common-rxtx-pins;
> > +            fsl,fsync-rising-edge;
> > +
> > +            tx_ts_routes =3D < 2 0 0>,                 /* TS 0..1 */
> > +                           < 24 FSL_CPM_TSA_SCC4 0>, /* TS 2..25 */
> > +                           < 1 0 0>,                 /* TS 26 */
> > +                           < 5 FSL_CPM_TSA_SCC3 0>;  /* TS 27..31 */
> > +
> > +            rx_ts_routes =3D < 2 0 0>,                 /* TS 0..1 */
> > +                           < 24 FSL_CPM_TSA_SCC4 0>, /* 2..25 */
> > +                           < 1 0 0>,                 /* TS 26 */
> > +                           < 5 FSL_CPM_TSA_SCC3 0>;  /* TS 27..31 */
> > +        };
> > +    };
> > diff --git a/include/dt-bindings/soc/fsl-tsa.h b/include/dt-bindings/so=
c/fsl-tsa.h
> > new file mode 100644
> > index 000000000000..9d09468694a2
> > --- /dev/null
> > +++ b/include/dt-bindings/soc/fsl-tsa.h =20
>=20
> Filename should match binding filename.

Right, I will rename to fsl,tsa.h

>=20
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later OR MIT */ =20
>=20
> A bit weird license... cannot be the same as binding?

Yes, will be change to GPL-2.0-only OR BSD-2-Clause

>=20
> > +
> > +#ifndef __DT_BINDINGS_SOC_FSL_TSA_H
> > +#define __DT_BINDINGS_SOC_FSL_TSA_H
> > +
> > +#define FSL_CPM_TSA_NU		0	/* Pseuso Cell Id for not used item */ =20
>=20
> Why defining unused IDs in binding header? These are IDs, not some
> hardware/register values.

It is the binding value for 'No destination' in the tx and rx route table.
This binding value means 'not used' or 'discard' the time-slot.
The data related to an item in the routing table with this value
will be discarded and not used.

>=20
> > +#define FSL_CPM_TSA_SCC2	1
> > +#define FSL_CPM_TSA_SCC3	2
> > +#define FSL_CPM_TSA_SCC4	3
> > +#define FSL_CPM_TSA_SMC1	4
> > +#define FSL_CPM_TSA_SMC2	5
> > +
> > +#define FSL_CPM_TSA_NBCELL	6 =20
>=20
> Drop.

Ok, will be removed in v3.

>=20
> > +
> > +#endif =20
>=20
> Best regards,
> Krzysztof
>=20

Thanks for your review.

Best regards,
Herv=C3=A9


--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
