Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722AC69AD29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBQNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBQNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:51:08 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9F692A9;
        Fri, 17 Feb 2023 05:50:29 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 47F6B60003;
        Fri, 17 Feb 2023 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676641825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXtty5j4EPkHzMourS16qE5SNRSNmBZzzykreudpYyw=;
        b=RoBsXKNPDSFIw+waIM9X3bayblvPaLqhufkZQmycFa7Xnrs3aTpCAWzjhfnGtitb8+V2N1
        7lvs3fA9mB2xffWdKYEEfQNqEKifHKxSneXjI8wUgFitrhpYd/n+2eAtt+u9wdBpmfiF99
        3+IsOBT6U1N4DOFMFnmQspVrm+xBGluGmi55YzwE/u8kJufXbbl+0bmekuU9Xl8KhAW5EU
        AVXU7Vb/pZ14cC+S+t5i+AZPWyZoqSPusgF7ggwvHd6IDqZnmrk8/AarNmkNGQDl6tIZJP
        kmwG5k2P/GWE4TNLz5ynqio6byKJqgjXOVaFfHowgpEcNTsKLnSWj+XNN8tEKQ==
Date:   Fri, 17 Feb 2023 14:50:19 +0100
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
Subject: Re: [PATCH v5 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Message-ID: <20230217145019.0def6f9a@bootlin.com>
In-Reply-To: <6ae9af19-1d52-c31f-79be-a36f06caaf80@linaro.org>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
        <20230216134226.1692107-2-herve.codina@bootlin.com>
        <6ae9af19-1d52-c31f-79be-a36f06caaf80@linaro.org>
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

On Fri, 17 Feb 2023 10:14:48 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/02/2023 14:42, Herve Codina wrote:
> > Add support for the time slot assigner (TSA)
> > available in some PowerQUICC SoC such as MPC885
> > or MPC866.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml | 234 ++++++++++++++++++
> >  include/dt-bindings/soc/fsl,tsa.h             |  13 +
> >  2 files changed, 247 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fs=
l,cpm1-tsa.yaml
> >  create mode 100644 include/dt-bindings/soc/fsl,tsa.h

[...]
> > +
> > +patternProperties:
> > +  '^tdm@[0-1]$':
> > +    description:
> > +      The TDM managed by this controller
> > +    type: object
> > +
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 1
> > +        description:
> > +          The TDM number for this TDM, 0 for TDMa and 1 for TDMb
[...]
> > +
> > +      fsl,rx-frame-sync-delay-bits:
> > +        enum: [0, 1, 2, 3] =20
>=20
> maxItems: 1

The property is an enum
Why this maxItems value ?

If I add the maxItems value, I've got some dt_binding_check errors:
  /xxxx/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml:
  patternProperties:^tdm@[0-1]$:properties:fsl,rx-frame-sync-delay-bits:
  'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMax=
imum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

>=20
> > +        default: 0
> > +        description: |
> > +          Receive frame sync delay in number of bits.
> > +          Indicates the delay between the Rx sync and the first bit of=
 the Rx
> > +          frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits dela=
y.
> > +
> > +      fsl,tx-frame-sync-delay-bits:
> > +        enum: [0, 1, 2, 3] =20
>=20
> maxItems: 1

Same question here.


Thanks for the review,

Herv=C3=A9
--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
