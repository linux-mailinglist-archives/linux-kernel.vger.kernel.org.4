Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C815679687
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjAXLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjAXLX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:23:57 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059D876BE;
        Tue, 24 Jan 2023 03:23:54 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EE1DD40003;
        Tue, 24 Jan 2023 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674559433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbYmdWFivLJBG8Pv5/K9k19ry1rzbKQLylHycCbuWNc=;
        b=NFHmt5S1U+BUZUExL6OMxo6ILWp1xOjzqVQBYDfj00xs/vj7VrSA8WyLsXUrWWzJO2vFgu
        Cr4mewN/SKd25Vlr4LPbG1RmnyBuql6OvuSKtX7LqGUjOADGdWXtZdqbCqf70llzXc2MgM
        gh7eqki/cly8NSZheKh/cOaif3gaUwL36fTc/c7tf4VoPbtXcjIlhqFna9u4NYhgiD0nyM
        LKuhuQx6iBHekcH7quPoCnFbpsrz+VRm0gvzpATBvB8UcNvf1iZ+MMTzHi66V2FDXR1GzD
        ztM2qnsi+eVF9dkpyWhxPae2i9kmMcC+2PjSxhskT8Ew9B5OqlBkOiUlJlpz/w==
Date:   Tue, 24 Jan 2023 12:23:47 +0100
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
Message-ID: <20230124122347.1a531d0f@bootlin.com>
In-Reply-To: <37a95380-ee68-5c3a-3b96-48cc8b525f19@linaro.org>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
        <20230113103759.327698-6-herve.codina@bootlin.com>
        <316ddb81-8d13-71dd-3396-412e31cfb880@linaro.org>
        <20230124104232.183cc9ff@bootlin.com>
        <37a95380-ee68-5c3a-3b96-48cc8b525f19@linaro.org>
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

On Tue, 24 Jan 2023 11:02:52 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 24/01/2023 10:42, Herve Codina wrote:
> > Hi Krzysztof,
> >=20
> > On Tue, 17 Jan 2023 12:31:09 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> On 13/01/2023 11:37, Herve Codina wrote: =20
> >>> Add support for the QMC (QUICC Multichannel Controller)
> >>> available in some PowerQUICC SoC such as MPC885 or MPC866.
> >>>
> >>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>> ---
> >>>  .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      | 164 ++++++++++++++++=
++
> >>>  1 file changed, 164 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/=
fsl,qmc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc=
.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> >>> new file mode 100644
> >>> index 000000000000..3ec52f1635c8
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> >>> @@ -0,0 +1,164 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qmc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: PowerQUICC CPM QUICC Multichannel Controller (QMC)
> >>> +
> >>> +maintainers:
> >>> +  - Herve Codina <herve.codina@bootlin.com>
> >>> +
> >>> +description: |
> >>> +  The QMC (QUICC Multichannel Controller) emulates up to 64 channels=
 within
> >>> +  one serial controller using the same TDM physical interface routed=
 from
> >>> +  TSA.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - fsl,mpc885-scc-qmc
> >>> +          - fsl,mpc866-scc-qmc
> >>> +      - const: fsl,cpm1-scc-qmc
> >>> +
> >>> +  reg:
> >>> +    items:
> >>> +      - description: SCC (Serial communication controller) register =
base
> >>> +      - description: SCC parameter ram base
> >>> +      - description: Dual port ram base
> >>> +
> >>> +  reg-names:
> >>> +    items:
> >>> +      - const: scc_regs
> >>> +      - const: scc_pram
> >>> +      - const: dpram
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +    description: SCC interrupt line in the CPM interrupt controller
> >>> +
> >>> +  fsl,tsa:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: phandle to the TSA
> >>> +
> >>> +  fsl,tsa-cell-id:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    enum: [1, 2, 3]
> >>> +    description: |
> >>> +      TSA cell ID (dt-bindings/soc/fsl,tsa.h defines these values)
> >>> +       - 1: SCC2
> >>> +       - 2: SCC3
> >>> +       - 3: SCC4   =20
> >>
> >> Is this used as argument to tsa? If so, this should be part of fsl,tsa
> >> property, just like we do for all syscon-like phandles. =20
> >=20
> > Yes, indeed.
> > I will move 'fsl,tsa' to 'fsl,tsa-cell' with 'fsl,tsa-cell' a phandle/n=
umber
> > pair (the phandle to TSA node and the TSA cell id to use) =20
>=20
> Move to fsl,tsa, not from.

Well, I plan to remove both fsl,tsa and fsl,tsa-cell-id and use this:
  fsl,tsa-cell:
    $ref: /schemas/types.yaml#/definitions/phandle-array
    items:
      - items:
          - description: phandle to TSA node
          - enum: [1, 2, 3]
            description: |
              TSA cell ID (dt-bindings/soc/fsl,tsa.h defines these values)
               - 1: SCC2
               - 2: SCC3
               - 3: SCC4
    description:
      Should be a phandle/number pair. The phandle to TSA node and the TSA
      cell ID to use.

Is that what you were thinking about ?

Best regards,
Herv=C3=A9


--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
