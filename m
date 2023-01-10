Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067A3663A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjAJIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjAJIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:07:39 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E3140B6;
        Tue, 10 Jan 2023 00:07:37 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E6D8C100002;
        Tue, 10 Jan 2023 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673338056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZgsA3blZRkDhqGMnNA0R6u5EyqOGZtYvAT+Wv5NomZg=;
        b=Ys6OT1+2bp2JYHo9mPYmhymzvJZTYOD3fMVHRIhU3ImPlylTaTP7MZa3uFgOrz/CvgzjQ/
        1770lhQoUVCHCn6xm1iLySNLgGab8ZMbMBPrT0Tf7XEAWvlCyjIs7qirDks6ATZh0a9YW+
        SnMEN1s7lQrmNRTdKOhgPXLHBVDJRmy/u5Ckqs0h+snkD02n7c/E/4kW86C7QvebMmpVRJ
        flMpdVvpFa9DDU074ocMpMNQ8oL1KzCJCLr9FgSCoSe0oflZ0zwZ7U+NvwaPZnxhccaYnd
        my4L007gwd/5XXRVFJlvE483mkgyDZofuuUDwZGPggBYVPuPUXQ7PzpEhXpK8w==
Date:   Tue, 10 Jan 2023 09:07:28 +0100
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
Subject: Re: [PATCH v2 08/10] dt-bindings: sound: Add support for QMC audio
Message-ID: <20230110090728.2024b5eb@bootlin.com>
In-Reply-To: <c393e532-d466-366b-a390-65de47c58b6a@linaro.org>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
 <20230106163746.439717-9-herve.codina@bootlin.com>
 <c393e532-d466-366b-a390-65de47c58b6a@linaro.org>
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

Hi Krzysztof,

On Sun, 8 Jan 2023 16:16:24 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/01/2023 17:37, Herve Codina wrote:
> > The QMC (QUICC mutichannel controller) is a controller
> > present in some PowerQUICC SoC such as MPC885.
> > The QMC audio is an ASoC component that uses the QMC
> > controller to transfer the audio data.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/sound/fsl,qmc-audio.yaml         | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,qmc-aud=
io.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml=
 b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
> > new file mode 100644
> > index 000000000000..b3774be36c19
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,qmc-audio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QMC audio
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |
> > +  The QMC audio is an ASoC component which uses QMC (QUICC Multichannel
> > +  Controller) channels to transfer the audio data.
> > +  It provides as many DAI as the number of QMC channel used.
> > +
> > +properties:
> > +  compatible:
> > +    items: =20
>=20
> Drop items.

Will be dropped.

>=20
> > +      - const: fsl,qmc-audio
> > +
> > +  '#address-cells':
> > +    const: 1
> > +  '#size-cells':
> > +    const: 0
> > +  '#sound-dai-cells':
> > +    const: 1
> > +
> > +patternProperties:
> > +  "^dai@([0-9]|[1-5][0-9]|6[0-3])$":
> > +    description:
> > +      A DAI managed by this controller
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 63
> > +        description:
> > +          The DAI number
> > +
> > +      qmc-chan: =20
>=20
> Missing vendor prefix.

Will be changed to 'fsl,qmc-chan'

>=20
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array =20
>=20
> Why this is not a phandle?

I have try '$ref: /schemas/types.yaml#/definitions/phandle'

I have an error from make dt_binding_check:=20
  dai@16:fsl,qmc-chan:0: [4294967295, 16] is too long

I need a phandle with an argument ie <&qmc 16>.
Is there an alternative to phandle-array to handle this case ?

>=20
> > +        description: phandle to the QMC channel> +        maxItems: 1
> > +
> > +    required:
> > +      - reg
> > +      - qmc-chan
> > +
> > +required:
> > +  - compatible
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - '#sound-dai-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    qmc_audio: qmc_audio { =20
>=20
> Same problem as in previous patch.

Changed to 'audio-controller'.

>=20
> > +        compatible =3D "fsl,qmc-audio";
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +        #sound-dai-cells =3D <1>;
> > +        dai@16 {
> > +            reg =3D <16>;
> > +            qmc-chan =3D <&scc_qmc 16>;
> > +        };
> > +        dai@17 {
> > +            reg =3D <17>;
> > +            qmc-chan =3D <&scc_qmc 17>;
> > +        };
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
