Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC334737CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjFUIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFUIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:06:40 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BEC19A2;
        Wed, 21 Jun 2023 01:06:25 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687334783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYtqxR//h5o3fcMngi/YGGEQl12cFL95TkWLUIHTxSw=;
        b=SgudXOqmAUvHeu4Jo3eLRfZ1fN2zhpb2s2JmooflnVq4jwsIFIoXRIaxuN23vxaILTt3Do
        CGki7lB5WuwItvsGgzokEFaiwHTF1MFaHNEbJ5Rj2SCmtGrW41IBSmy8EL8EOKI4fUsu64
        JUzZxmEFw6a5mediCQXKrRThbcQExL5Qgj+Wu5YzVbkZ/9e9W9zMG5trHILycqU8NZvOc3
        Ig14PDS7aCqu6HKYRJ7HkLg4q1vsGAFTmKKbNN1x3wwO5toJi72p8psxqHtpAb0tpReRlZ
        bnLJA0nAyGADD0pCG5WmgyNReUWUcMCVwat4VJ99IenkWCevR6MhQTnStmjGyQ==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9ED9D6000A;
        Wed, 21 Jun 2023 08:06:21 +0000 (UTC)
Date:   Wed, 21 Jun 2023 10:06:20 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 02/13] ASoC: dt-bindings: simple-card: Add
 additional-devs subnode
Message-ID: <20230621100620.0666ae29@bootlin.com>
In-Reply-To: <20230620164521.GA3789188-robh@kernel.org>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-3-herve.codina@bootlin.com>
        <20230620164521.GA3789188-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 20 Jun 2023 10:45:21 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, Jun 15, 2023 at 05:26:20PM +0200, Herve Codina wrote:
> > The additional-devs subnode allows to declared some virtual devices
> > as sound card children.
> > These virtual devices can then be used by the sound card and so be
> > present in the audio path.
> > 
> > The first virtual device supported is the audio IIO auxiliary device
> > in order to support an IIO device as an audio auxiliary device.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/sound/simple-card.yaml           | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> > index b05e05c81cc4..59ac2d1d1ccf 100644
> > --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> > +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> > @@ -148,6 +148,15 @@ definitions:
> >      required:
> >        - sound-dai
> >  
> > +  additional-devs:
> > +    type: object
> > +    description:
> > +      Additional devices used by the simple audio card.
> > +    patternProperties:
> > +      '^iio-aux(-.+)?$':
> > +        type: object
> > +        $ref: audio-iio-aux.yaml#
> > +
> >  properties:
> >    compatible:
> >      contains:
> > @@ -187,6 +196,8 @@ properties:
> >      $ref: "#/definitions/mclk-fs"
> >    simple-audio-card,aux-devs:
> >      $ref: "#/definitions/aux-devs"
> > +  simple-audio-card,additional-devs:
> > +    $ref: "#/definitions/additional-devs"  
> 
> Why do you need this under the card node? Can't you just use the 
> existing aux-devs?

aux-devs is a phandle array referencing auxiliary devices.
I cannot define a node with just aux-devs, just reference.

I need device auxiliary devices that are not defined somewhere else in
the DT.

A SPI amplifier is defined as a subnode of a SPI controler.
But my IIO/ASoC virtual devices are not defined under some hardware bus.
I need to define them here, as a simple-audio-card subnode.

Several subnodes are already defined for a simple-audio-card subnode for
other purpose.

Instead of having virtual device nodes directly as chidren mixed with the
other purpose nodes of the simple-audio-card, I group them under the
additional-devs node in order to ease evolution and maintenance.

Best regards,
Hervé

> 
> >    simple-audio-card,convert-rate:
> >      $ref: "#/definitions/convert-rate"
> >    simple-audio-card,convert-channels:
> > @@ -359,6 +370,48 @@ examples:
> >          };
> >      };
> >  
> > +# --------------------
> > +# route audio to/from a codec through an amplifier
> > +# designed with a potentiometer driven by IIO:
> > +# --------------------
> > +  - |
> > +    sound {
> > +        compatible = "simple-audio-card";
> > +
> > +        simple-audio-card,aux-devs = <&amp_in>, <&amp_out>;
> > +        simple-audio-card,routing =
> > +            "CODEC LEFTIN", "AMP_IN LEFT OUT",
> > +            "CODEC RIGHTIN", "AMP_IN RIGHT OUT",
> > +            "AMP_OUT LEFT IN", "CODEC LEFTOUT",
> > +            "AMP_OUT RIGHT IN", "CODEC RIGHTOUT";
> > +
> > +        simple-audio-card,additional-devs {
> > +            amp_out: iio-aux-out {
> > +                compatible = "audio-iio-aux";
> > +                io-channels = <&pot_out 0>, <&pot_out 1>;
> > +                io-channel-names = "LEFT", "RIGHT";
> > +                snd-control-invert-range = <1 1>;
> > +                sound-name-prefix = "AMP_OUT";
> > +            };
> > +
> > +            amp_in: iio_aux-in {
> > +                compatible = "audio-iio-aux";
> > +                io-channels = <&pot_in 0>, <&pot_in 1>;
> > +                io-channel-names = "LEFT", "RIGHT";
> > +                sound-name-prefix = "AMP_IN";
> > +            };
> > +        };
> > +
> > +        simple-audio-card,cpu {
> > +            sound-dai = <&cpu>;
> > +        };
> > +
> > +        simple-audio-card,codec {
> > +            sound-dai = <&codec>;
> > +            clocks = <&clocks>;
> > +        };
> > +    };
> > +
> >  # --------------------
> >  # Sampling Rate Conversion
> >  # --------------------
> > -- 
> > 2.40.1
> >   



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
