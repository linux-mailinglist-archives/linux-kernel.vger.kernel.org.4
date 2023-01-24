Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9203E679464
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjAXJmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjAXJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:42:47 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC601704;
        Tue, 24 Jan 2023 01:42:41 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 07FEDC0002;
        Tue, 24 Jan 2023 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674553359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ke8PpnBYtq0uoMPZ4KXBhGHV0aGLKGiBTbsb/9DcACw=;
        b=OBnDzO21zBEolJhYXCoBIAM/TsM6/WMHNuUfk+l6SvClCaKodQeGNH4vJ1Wwuq5Wrj55RA
        JzemmolOIv0lxhYOdsx4l+ullMmYCXFvO65tMJLAOH11hF5vgXHqADpMiWz08MxIQlf+/N
        pWsu2/YR1/OsTa2H62xvcTqcDxHDcdrZilgLLuHdPYBUtgS63rLZevV6B7J7JCdE2hzUkL
        ttPcYFWO7n0IjBDqwUjoHH7ql0gqvNaIWHmMsGWfGClvQhbeN//Y4pG37AK3nnJN5fsIVN
        eyMitol0Xvxb7ovHzPCRBkcS+RT0koUZbMnVvlggWAy5TkDXedcYHN1E8ebEng==
Date:   Tue, 24 Jan 2023 10:42:32 +0100
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
Subject: Re: [PATCH v3 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC
 controller
Message-ID: <20230124104232.183cc9ff@bootlin.com>
In-Reply-To: <316ddb81-8d13-71dd-3396-412e31cfb880@linaro.org>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
        <20230113103759.327698-6-herve.codina@bootlin.com>
        <316ddb81-8d13-71dd-3396-412e31cfb880@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
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

On Tue, 17 Jan 2023 12:31:09 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/01/2023 11:37, Herve Codina wrote:
> > Add support for the QMC (QUICC Multichannel Controller)
> > available in some PowerQUICC SoC such as MPC885 or MPC866.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      | 164 ++++++++++++++++++
> >  1 file changed, 164 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fs=
l,qmc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.y=
aml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> > new file mode 100644
> > index 000000000000..3ec52f1635c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> > @@ -0,0 +1,164 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qmc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PowerQUICC CPM QUICC Multichannel Controller (QMC)
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |
> > +  The QMC (QUICC Multichannel Controller) emulates up to 64 channels w=
ithin
> > +  one serial controller using the same TDM physical interface routed f=
rom
> > +  TSA.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - fsl,mpc885-scc-qmc
> > +          - fsl,mpc866-scc-qmc
> > +      - const: fsl,cpm1-scc-qmc
> > +
> > +  reg:
> > +    items:
> > +      - description: SCC (Serial communication controller) register ba=
se
> > +      - description: SCC parameter ram base
> > +      - description: Dual port ram base
> > +
> > +  reg-names:
> > +    items:
> > +      - const: scc_regs
> > +      - const: scc_pram
> > +      - const: dpram
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: SCC interrupt line in the CPM interrupt controller
> > +
> > +  fsl,tsa:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the TSA
> > +
> > +  fsl,tsa-cell-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 3]
> > +    description: |
> > +      TSA cell ID (dt-bindings/soc/fsl,tsa.h defines these values)
> > +       - 1: SCC2
> > +       - 2: SCC3
> > +       - 3: SCC4 =20
>=20
> Is this used as argument to tsa? If so, this should be part of fsl,tsa
> property, just like we do for all syscon-like phandles.

Yes, indeed.
I will move 'fsl,tsa' to 'fsl,tsa-cell' with 'fsl,tsa-cell' a phandle/number
pair (the phandle to TSA node and the TSA cell id to use)

>=20
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  '#chan-cells':
> > +    const: 1
> > +
> > +patternProperties:
> > +  '^channel@([0-9]|[1-5][0-9]|6[0-3])$':
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
> You still need to explain what do transparent and hdlc mean.

Oups, my bad (already mentioned in the previous version review).

Also, I will rename the property to 'fsl,operational-mode' to be
more precise than just 'fsl,mode'

>=20
> > + =20
>=20
>=20
> Best regards,
> Krzysztof
>=20

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
