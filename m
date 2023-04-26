Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02446EEF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbjDZHgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZHga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:36:30 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB82D4E;
        Wed, 26 Apr 2023 00:36:26 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 96D464001B;
        Wed, 26 Apr 2023 07:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682494584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GR1E+pbhNEg6zfN0rOacaHcUiyS6/XYLZ7Q4bCGZDj8=;
        b=EUGQvUSlAnbZSP6ryVpH8/2rJsl/W56VfEzXMyqHIHIbfZuMmz1mQv2BNAjmrthj9ayJ1d
        DmnUMcyyGEWQtZ8vCEeTZx4Bozgby+nB0czAGSnfUffBco+kJuo7mlzn/4j0vtOrgaJ8sC
        DdWVOAkN0oqwTxLir/wLahQfcDuDoN2GjyMbVjonptvFS8ESULH8/YUEK8jGViAGX5juVk
        3NbkaTEELOefM1HrP4cnQIRiQgZPqrxLcPFSjR0ElI/ZqK+RBZda79K8fHYYkJTAHYpz3P
        3DmjDe2TcUa7MVg95Qnbx2TpMeUuehG7c3LR31Z9pbxIdepiUVRgV96MRcSbWw==
Date:   Wed, 26 Apr 2023 09:36:21 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: Add simple-iio-aux
Message-ID: <20230426093621.3834e703@bootlin.com>
In-Reply-To: <20230425173029.GA1967523-robh@kernel.org>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
        <20230421124122.324820-2-herve.codina@bootlin.com>
        <20230425173029.GA1967523-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 25 Apr 2023 12:30:29 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, Apr 21, 2023 at 02:41:19PM +0200, Herve Codina wrote:
> > Industrial I/O devices can be present in the audio path.
> > These devices needs to be viewed as audio components in order to be
> > fully integrated in the audio path.
> > 
> > simple-iio-aux allows to consider these Industrial I/O devices as
> > auxliary audio devices.  
> 
> What makes it simple? Any binding called simple or generic is a trigger 
> for me. Best to avoid those terms. :)

I choose simple-iio-aux because some simple-* already exists.
For instance simple-audio-amplifier or simple-audio-mux.

Do you prefer audio-iio-aux ?
Let me know if I should change.

> 
> Examples of devices would be useful here.
> 
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/sound/simple-iio-aux.yaml        | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml b/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
> > new file mode 100644
> > index 000000000000..fab128fce4fc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/simple-iio-aux.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Simple IIO auxiliary
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |  
> 
> Don't need '|'

Will be fixed.

> 
> > +  Auxiliary device based on Industrial I/O device channels
> > +
> > +allOf:
> > +  - $ref: /schemas/iio/iio-consumer.yaml  
> 
> You don't need to reference consumer schemas.

Right, will be removed.

> 
> > +  - $ref: dai-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: simple-iio-aux
> > +
> > +  io-channels:
> > +    description:
> > +      Industrial I/O device channels used
> > +
> > +  io-channel-names:
> > +    description:
> > +      Industrial I/O channel names related to io-channels.
> > +      These names are used to provides sound controls, widgets and routes names.
> > +
> > +  invert:  
> 
> Property names should globally only have 1 type definition. This is 
> generic enough I'd be concerned that's not the case.

What do you mean ?

> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      A list of 0/1 flags defining whether or not the related channel is
> > +      inverted
> > +    items:
> > +      enum: [0, 1]
> > +      default: 0
> > +      description: |
> > +        Invert the sound control value compared to the IIO channel raw value.
> > +          - 1: The related sound control value is inverted meaning that the
> > +               minimum sound control value correspond to the maximum IIO channel
> > +               raw value and the maximum sound control value correspond to the
> > +               minimum IIO channel raw value.
> > +          - 0: The related sound control value is not inverted meaning that the
> > +               minimum (resp maximum) sound control value correspond to the
> > +               minimum (resp maximum) IIO channel raw value.
> > +
> > +required:
> > +  - compatible
> > +  - io-channels
> > +  - io-channel-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    aux {
> > +        compatible = "simple-iio-aux";
> > +        io-channels = <&iio 0>, <&iio 1>, <&iio 2>, <&iio 3>;
> > +        io-channel-names = "CH0", "CH1", "CH2", "CH3";  
> 
> Not really useful names. Do you have a real example?

As Mark said, for IIO channel, using CHx makes sense.
See below, I provide a full example.

> 
> > +        /* Invert CH1 and CH2 */
> > +        invert = <0 1 1>;  
> 
> IMO, invert should be same length as io-channels.

I will update.

Related to this topic, when I wrote this binding, I wanted to add some
rules/constraints in order to:
- Have this property optional
- If present, force to have as many items in the invert array as the
  number of items present in the io-channels array.

I never succeed in writing the constraint for the invert property.
It should be possible (it is done for some 'foo' 'foo-names' pair such
as clocks).
Can you tell me if possible in my case and give me some pointers ?

> 
> > +    };  
> 
> How do support multiple instances? Say you have 2 sound cards (or 1 
> sound card with multiple audio paths) each with different sets of IIO 
> channels associated with it. You'd need a link to each 'aux' node. Why 
> not just add io-channels to the sound card nodes directly? That's 
> already just a virtual, top-level container node grouping all the 
> components. I don't see why we need another virtual node grouping a 
> subset of them.

I don't see what you mean.
I use a simple-audio-card and here is a full example using several
instances:

    spi {
        #address-cells = <1>;
        #size-cells = <0>;
	/* potentiometers present in an input amplifier design */
        pot_in: potentiometer@0 {
            compatible = "foo,xxx";
            reg = <0>;
            #io-channel-cells = <1>;
        };
	/* potentiometers present in an output amplifier design */
	pot_out: potentiometer@1 {
            compatible = "foo,xxx";
            reg = <1>;
            #io-channel-cells = <1>;
        };
	/* A codec */
        codec: codec@2 {
            compatible = "bar,yyy";
            reg = <2>;
            sound-name-prefix = "CODEC";
        };

    };

    amp_out: aux-out {
        compatible = "simple-iio-aux";
        io-channels = <&pot_out 0>, <&pot_out 1>,
        io-channel-names = "CH0", "CH1";
        invert = <1 1>;
        sound-name-prefix = "AMP_OUT";
    };

    amp_in: aux-in {
	compatible = "simple-iio-aux";
	io-channels = <&pot_in 0>, <&pot_in 1>;
	io-channel-names = "CH0", "CH1";
	sound-name-prefix = "AMP_IN";
    };

    sound {
        compatible = "simple-audio-card";
        #address-cells = <1>;
        #size-cells = <0>;
        simple-audio-card,name = "My Sound Card";

        simple-audio-card,aux-devs = <&amp_in>, <&amp_out>;
        simple-audio-card,routing =
            "CODEC IN0", "AMP_IN CH0 OUT",
            "CODEC IN1", "AMP_IN CH1 OUT",
            "AMP_OUT CH0 IN", "CODEC OUT0",
            "AMP_OUT CH1 IN", "CODEC OUT1",

        simple-audio-card,dai-link@0 {
            ...
        };
    };


Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
