Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D02663A79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjAJIHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjAJIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:06:58 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE6843E56;
        Tue, 10 Jan 2023 00:06:57 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3D5F824000B;
        Tue, 10 Jan 2023 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673338015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tanCnt41dmd3a1gqbCEA0TYYO9/oTjI6yAv4OQDOAo=;
        b=O1Opaji665s44TE1LAeK3X1D4fYZJDuZSpYGeI1q8gABik0Z1kaEh03swno0937SJj0yue
        74GZCclMht4rcz4psoZvlBrAchwISnRoslZZufPnjF5IrvTUhHz2LldITerMDLfGFUgTms
        vHXaY1Ki1l23UicholMhpxt39CFMdnggwaNe0ljcsOiKVXKdvXP2KpthwiBLx9AG+xADXI
        wI6theO2IKhw2keeah0YYzKanAJEVpCPQbhCl2DFoZDmnrFIHdKhbfqupQ7yd24kqen1xf
        RUnZhIVGv4EnLnguFl4GNBxmLEakSSnAOCuv1ahzmgXZYkitFZFF9fqzE/f3GA==
Date:   Tue, 10 Jan 2023 09:06:50 +0100
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
Subject: Re: [PATCH v2 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC
 controller
Message-ID: <20230110090650.2138edf0@bootlin.com>
In-Reply-To: <76077f5f-fbda-800b-b8d8-6a3f6600f4d1@linaro.org>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
 <20230106163746.439717-6-herve.codina@bootlin.com>
 <76077f5f-fbda-800b-b8d8-6a3f6600f4d1@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

Hi Krzysztof,

On Sun, 8 Jan 2023 16:14:47 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

[...]
> > +
> > +  interrupts:
> > +    description: SCC interrupt line in the CPM interrupt controller =20
>=20
> Missing constraints.

'maxItems: 1' will be added in v3

>=20
> > +
> > +  fsl,cpm-command:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Cf. soc/fsl/cpm_qe/cpm.txt =20
>=20
> Missing description.

'fsl,cpm-command' will be removed in v3.
The value needed is determined based on other information.
This is not needed in the DT.

>=20
> > +
> > +  tsa:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the TSA =20
>=20
> Missing vendor prefix. Does not look like a generic property.

Will be be changed to 'fsl,tsa'
and also 'tsa-cell-id' will be changed to 'fsl,tsa-cell-id'

>=20
[...]
> > +
> > +patternProperties:
> > +  "^channel@([0-9]|[1-5][0-9]|6[0-3])$":
> > +    description:
> > +      A channel managed by this controller
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 63
> > +        description:
> > +          The channel number
> > +
> > +      fsl,mode:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        enum: [transparent, hdlc]
> > +        default: transparent
> > +        description: Operational mode =20
>=20
> And what do they mean?

I will change with
  description: |
    The channel operational mode
     - hdlc: The channel handles HDLC frames
     - transparent: The channel handles raw data without any processing

>=20
> > +
> > +      fsl,reverse-data:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          The bit order as seen on the channels is reversed,
> > +          transmitting/receiving the MSB of each octet first.
> > +          This flag is used only in 'transparent' mode.
> > +
> > +      tx-ts-mask: =20
>=20
> Missing vendor prefix.

Will be added, also on rx-ts-mask.

>=20
> > +        $ref: /schemas/types.yaml#/definitions/uint64
> > +        description:
> > +          Channel assigned Tx time-slots within the Tx time-slots rout=
ed
> > +          by the TSA to this cell.
> > +
> > +      rx-ts-mask:
> > +        $ref: /schemas/types.yaml#/definitions/uint64
> > +        description:
> > +          Channel assigned Rx time-slots within the Rx time-slots rout=
ed
> > +          by the TSA to this cell.
> > +
> > +    required:
> > +      - reg
> > +      - tx-ts-mask
> > +      - rx-ts-mask
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - tsa
> > +  - tsa-cell-id
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - '#chan-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/soc/fsl-tsa.h>
> > +
> > +    scc_qmc@a60 { =20
>=20
> No underscores in node names.
>=20
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation

Will be changed to qmc@a60

>=20
> > +        compatible =3D "fsl,mpc885-scc-qmc", "fsl,cpm1-scc-qmc";
> > +        reg =3D <0xa60 0x20>,
> > +              <0x3f00 0xc0>,
> > +              <0x2000 0x1000>;
> > +        reg-names =3D "scc_regs", "scc_pram", "dpram";
> > +        interrupts =3D <27>;
> > +        interrupt-parent =3D <&CPM_PIC>;
> > +        fsl,cpm-command =3D <0xc0>;
> > +
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +        #chan-cells =3D <1>;
> > +
> > +        tsa =3D <&tsa>;
> > +        tsa-cell-id =3D <FSL_CPM_TSA_SCC4>;
> > +
> > +        channel@16 {
> > +            /* Ch16 : First 4 even TS from all routed from TSA */
> > +            reg =3D <16>;
> > +            fsl,mode =3D "transparent";
> > +            fsl,reverse-data;
> > +            tx-ts-mask =3D <0x00000000 0x000000AA>;
> > +            rx-ts-mask =3D <0x00000000 0x000000AA>; =20
>=20
> Keep case consistent. lower-case hex.

Will be fixed

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
