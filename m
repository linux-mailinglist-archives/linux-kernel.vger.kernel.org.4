Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E16FECA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjEKHVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbjEKHU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:20:56 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764B93E3;
        Thu, 11 May 2023 00:20:02 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 12BE34000C;
        Thu, 11 May 2023 07:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683789550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyHerlYHFamkJnQqL//Z3uWo0RLDtOmR22dPgo2ut2A=;
        b=EV2PDAfzCs+eKt3zCjs+7X23c3yyFyjOHpCoyvuZs4X2JMo5r8O/5mQlblbTHepa+lbF7+
        vJrcJzFR3lP2e/ZGRYMgqGZ121jtkG5YFFOprbRqkLMeUEms8DV1s6rxchCVYhYHkYk9M7
        U0E2X/uofrc+FdIkpYHV9AMn9uFP3WmIPgw37MArWxuS45ZdpTlXiO2T+hQ47qXSZlahO9
        ISKvoT/CyZbC5qvA8bO4pd08yK46bysM4peeRD0/Ceo81tzIBlZPHqVDsBHDSeneX4RdPY
        nI6GfYOLp1C/ZGv9aV8Arf5mJO+m6AaOkTWVJLsZRYxuWxhxC7tXhiD68RqAaQ==
Date:   Thu, 11 May 2023 09:19:07 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Message-ID: <20230511091907.6794457b@bootlin.com>
In-Reply-To: <ZFMzC7OBrcL9l5AH@finisterre.sirena.org.uk>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
        <20230421124122.324820-2-herve.codina@bootlin.com>
        <20230425173029.GA1967523-robh@kernel.org>
        <20230426093621.3834e703@bootlin.com>
        <5bcb2741-9212-f1aa-335b-6bc4b6fad448@linaro.org>
        <ZFMzC7OBrcL9l5AH@finisterre.sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Krzysztof, Mark,

On Thu, 4 May 2023 13:22:35 +0900
Mark Brown <broonie@kernel.org> wrote:

> On Tue, May 02, 2023 at 09:26:32AM +0200, Krzysztof Kozlowski wrote:
> > On 26/04/2023 09:36, Herve Codina wrote:  
> > > Rob Herring <robh@kernel.org> wrote:  
> > >> On Fri, Apr 21, 2023 at 02:41:19PM +0200, Herve Codina wrote:  
> 
> > >>> simple-iio-aux allows to consider these Industrial I/O devices as
> > >>> auxliary audio devices.    
> 
> > >> What makes it simple? Any binding called simple or generic is a trigger 
> > >> for me. Best to avoid those terms. :)  
> 
> > > I choose simple-iio-aux because some simple-* already exists.
> > > For instance simple-audio-amplifier or simple-audio-mux.  
> 
> > > Do you prefer audio-iio-aux ?
> > > Let me know if I should change.  
> 
> > It means that often what people call "simple" and "generic" works only
> > for their specific case, because it is not really simple and generic.
> > After some time the "simple" and "generic" becomes "complicated" and
> > "huge". Conclusion: sometimes simple and generic bindings are bad idea
> > and you should have something specific.  
> 
> > Your description in the binding also does not help to match it to
> > specific, real device. Provide the examples, as Rob asked.  
> 
> I don't understand what you are looking for here.  IIO is a subsystem
> which represents generic DACs and ADCs (along with other I/O things).
> Audio devices also have DACs and ADCs, somewhat specialised for use in
> audio but more limited by specs and interfaces than by anything
> fundamental.  The goal here is to map DACs and ADCs described as IIO for
> use in an audio context.
> 
> ADCs are devices that convert analog signals into digital values, DACs
> are devices that convert digital values into analog signals.
> 
> > >> How do support multiple instances? Say you have 2 sound cards (or 1 
> > >> sound card with multiple audio paths) each with different sets of IIO 
> > >> channels associated with it. You'd need a link to each 'aux' node. Why 
> > >> not just add io-channels to the sound card nodes directly? That's 
> > >> already just a virtual, top-level container node grouping all the 
> > >> components. I don't see why we need another virtual node grouping a 
> > >> subset of them.  
> 
> > > I don't see what you mean.
> > > I use a simple-audio-card and here is a full example using several
> > > instances:  
> 
> > Just like Rob said: "You'd need a link to each 'aux' node"  
> 
> > and you did it...  
> 
> > So now the rest of Rob's answer:  
> 
> > "Why not just add io-channels to the sound card nodes directly? That's
> > already just a virtual, top-level container node grouping all the
> > components. I don't see why we need another virtual node grouping a
> > subset of them."  
> 
> > Why do you need another node if it is not really representing a real,
> > separate device?  
> 
> If nothing else I would expect it to be useful from a comprehensibility
> point of view to bundle multiple IIO devices into a single multi-channel
> audio stream, an individual IIO device is likely to only present a
> single channel of data but it is common to group multiple channels of
> audio data.

I cannot simply add io-channels to the sound card directly. I need a node
to set at least the sound-name-prefix property. Further more having a node
and a related compatible string can be easier to maintain and add future
evolution related to these "virtual" devices.

As some subnodes are already defined for a sound card node, I propose to
group these "virtual" audio devices node in a specific bundle node.
This lead to the following example:
---- 8< ----
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
            "AMP_OUT CH1 IN", "CODEC OUT1";

        simple-audio-card,dai-link@0 {
            ...
        };

        ...

        /* A bundle for the additional devices */
        simple-audio-card,additional-devs { 
            amp_out: aux-out {
                compatible = "audio-iio-aux";    /* Instead of "simple-iio-aux */
                io-channels = <&pot_out 0>, <&pot_out 1>,
                io-channel-names = "CH0", "CH1";
                snd-control-invert-range = <1 1>;  /* Old 'invert' renamed */
                sound-name-prefix = "AMP_OUT";
            };

            amp_in: aux-in {
	       compatible = "audio-iio-aux";
               io-channels = <&pot_in 0>, <&pot_in 1>;
	       io-channel-names = "CH0", "CH1";
	       sound-name-prefix = "AMP_IN";
            };
	};
    };
---- 8< ----

What do you think about this new binding ?

Best regards,
Hervé
