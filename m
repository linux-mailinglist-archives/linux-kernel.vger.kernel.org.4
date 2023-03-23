Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A786C60BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCWH2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCWH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:28:31 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B9E35BC;
        Thu, 23 Mar 2023 00:28:04 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 973C0240003;
        Thu, 23 Mar 2023 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679556482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZCDzRnLqysWpssOJFzBPP+Ah8SGkrKkmxkaX60oGac=;
        b=oNU9PrUnB5kWjgXEat4iAei6Hhs7l5YApzPKFrCVHYbMsCgknox/p5alDoKe8GpDSCPeY9
        QmXMkQbTx6T/wl2Y/618U/WhtERx3X25qKs0hpsHNnJL9Ij/lhylM3AGrPbZyVSzpjikZS
        uq/50PrtdkwzA7Np5OwztD7s6wQrkbASkn2PlWmSwixrkQPQqr9uC2JzkgEacLMWgI8Ks5
        Lg9lV9RYqFXSswWYgg/oaR40vNqfMFwAVSZdt+q8att55/qeiuLfsLJMYTFfsLVo/FkNnR
        48rLE+1X06BTBhdAcupsrdrrYyiQs1vv5aHDY01rX8eAfuNhd/G7nkGmntFJeQ==
Date:   Thu, 23 Mar 2023 08:27:58 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: sound: Add support for the Lantiq
 PEF2256 codec
Message-ID: <20230323082758.5e4385ff@bootlin.com>
In-Reply-To: <cf87e7c0-b769-d1fc-0718-c5c2986993b8@linaro.org>
References: <20230322134654.219957-1-herve.codina@bootlin.com>
        <20230322134654.219957-5-herve.codina@bootlin.com>
        <cf87e7c0-b769-d1fc-0718-c5c2986993b8@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Wed, 22 Mar 2023 22:59:37 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 22/03/2023 14:46, Herve Codina wrote:
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.
> > 
> > The codec support allows to use some of the PCM system highway
> > time-slots as audio channels to transport audio data over the E1/T1/J1
> > lines.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/sound/lantiq,pef2256-codec.yaml  | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> > new file mode 100644
> > index 000000000000..da35b70cda99
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lantiq PEF2256 codec
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |
> > +  Codec support for PEF2256.
> > +
> > +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
> > +  line interface component designed to fulfill all required interfacing between
> > +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
> > +
> > +  The codec support allows to use some of the PCM system highway time-slots as
> > +  audio channels to transport audio data over the E1/T1/J1 lines.
> > +
> > +  The time-slots used by the codec must be set and so, the properties
> > +  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
> > +  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
> > +  sub-nodes that involve the codec. The codec uses 8bit time-slots.
> > +  'dai-tdm-tdm-slot-with' must be set to 8.
> > +  The tx and rx masks define the PEF2256 time-slots assigned to the codec.
> > +
> > +  The PEF2256 codec node should be a child of a PEF2256 node.
> > +  Refer to the bindings described in
> > +  Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
> > +
> > +allOf:
> > +  - $ref: dai-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: lantiq,pef2256-codec
> > +
> > +  '#sound-dai-cells':
> > +    const: 0  
> 
> You do not have here any resources, so the entire binding can be dropped
> and merged into the parent.
> 
> Best regards,
> Krzysztof
> 

Ok,
Do you expect all these properties (except compatible) merged at the parent
level or may I keep a child node with these properties including the
compatible property (ie. yaml file merge).

Regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
