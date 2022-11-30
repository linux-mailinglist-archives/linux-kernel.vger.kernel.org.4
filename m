Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5974563D0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiK3IhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiK3Igj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:36:39 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16474F75;
        Wed, 30 Nov 2022 00:36:38 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13bd19c3b68so20143589fac.7;
        Wed, 30 Nov 2022 00:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C8cqmGzfVCjxCPHfgIL2xOfMEXlcwATS1T5/zK1+jbw=;
        b=EYP+xYeqqZV43Hrcy1u1vdcjPdZAda0tkb1dbQgNTKv39FaYQuSuP7cms+SSiOHdym
         pahu7SiBHnXNc7T0l3+mERK5AkatUP9Uay8VaJOnssP3tNb47jPO2QM6sX2zJ6dlpJst
         vsTdPlAhyOUF3OJdqol0JdXD6ocpqXtw6nYlvKxHHb80q9bUhPBVyQLorp1jk3dg8f3o
         PkB64P+k/f6APGEjzikXQFoKagVFQ3fB9+eYMlKn3FiPAOP/yze14+R8fPpfFvz+FneS
         kciPIivW2C3naKDvWrSykNUJD3hultU5i7broL2WHsXxG7M9uOSskzKA51WyMxwuvRJX
         rC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8cqmGzfVCjxCPHfgIL2xOfMEXlcwATS1T5/zK1+jbw=;
        b=nDc7BDez2MikOcMNzVAx4jHy622fdW9GavukFbTOvtCLcX7s2/EaEDssNq/Ugi7C87
         Ay/rqyETurL2XkBOTGIanJkVrg2FiXhMpWLIQLG7D3oLRDUE/LdxsZreTpW9FCRklgd5
         Sg4pFmB1nobsdLMe28Z0Xl2tUt0m1sgrRIp88/1v3NsVij9sgspFtuOTPoN0JG26qePr
         6h7nEr70jWatD6ceelWhq6WnuZU1KwJrTY2u8h9WYEm6ZdvFoII+r5sQImnK483K34vV
         qEuZgKPw1tdjSfuWWhCjlEcNyP6Y4okMvHeIdBThoGYEstay4fmh6aWLvsrFjbtj4g6U
         U1bQ==
X-Gm-Message-State: ANoB5pmE3NjDLTzmdWK6i/LOQ1UynjRN+u33GiSxV8jyNogrbVgMnlrI
        6EL7vFu8XTxxqba6bFvKRBIR/XYPNBKvXMGezvE=
X-Google-Smtp-Source: AA0mqf4LrL4qMWi9+zmjHRnmpWUEVNwAPF1yGUgE4xfVwRsDc9zZoq/qbovaZLLi+W+5OG1uVOq/e+ePL2+k50n0hlc=
X-Received: by 2002:a05:6870:ab86:b0:13c:5763:9411 with SMTP id
 gs6-20020a056870ab8600b0013c57639411mr32666222oab.288.1669797397394; Wed, 30
 Nov 2022 00:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20221129140955.137361-1-gch981213@gmail.com> <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
In-Reply-To: <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 30 Nov 2022 16:36:26 +0800
Message-ID: <CAJsYDVJknDWKMW1tH0M=85tJOPG-HngxhhMzvJpk5qn_Q9mzAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 30, 2022 at 12:54 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> > +description: |
> > +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
> > +  together and controlled individually using a single wire.
> > +  This driver simulates the protocol used by this LED chip with SPI bus.
>
> Drop references to Linux driver, unless important for the binding.

I think the SPI part is important. (I'll explain it below.) What about:

This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.

instead?

> > +  Typical setups includes connecting the data pin of the LED chain to MOSI as
> > +  the only device or using CS and MOSI with a tri-state voltage-level shifter
> > +  for the data pin.
> > +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
> > +  and the controller needs to send all the bytes continuously.
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: worldsemi,ws2812b-spi
>
> Drop "-spi". Compatibles are not supposed to include bus information.
> The same for file name.

WS2812B isn't a SPI chip. It's controlled with only a single wire and
can be driven
using anything that can produce a long and a short pulse meeting its timing
requirement.
This driver uses a SPI bus to send the pulses, but it can also be
controlled with
I2S and the PIO pins on a Raspberry Pi Pico.
This spi suffix is to distinguish it from other possible
implementations if someone
else submits a support with a different peripheral.

>
> > +
> > +  reg:
> > +    description: The chip-select line on the SPI bus
>
> Drop description, it's obvious.

OK.

>
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Maximum SPI clocking speed of the device in Hz.
>
> No need for ref and description. It comes from spi-peripheral-props.

OK.

>
> > +    minimum: 2105000
> > +    maximum: 2850000
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^multi-led(@[0-9a-f])?$":
>
> Why unit address is optional?

It isn't. I copy-pasted it from led-class-multicolor.yaml and
didn't check the exact regex.
I'll fix it in the next version.

>
> > +    type: object
> > +    $ref: leds-class-multicolor.yaml#
>
>     unevaluatedProperties: false

OK.

> > +
> > +    properties:
> > +      color-index:
> > +        description: |
> > +          A 3-item array specifying color of each components in this LED. It
> > +          should be one of the LED_COLOR_ID_* prefixed definitions from the
> > +          header include/dt-bindings/leds/common.h. Defaults to
> > +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
> > +          if unspecified.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        minItems: 3
>
> Drop minItems.... but see comment below:
>
> > +        maxItems: 3
>
> Why this is different than other multi-color LEDs? I would expect here
> children with common.yaml.

WS2812B is a single LED package with 3 diodes and a microcontroller.
Each LED package has 3 colors. The original chip comes with GRB
color while there are some clones with RGB arrangement instead.
The LED chain can be really long so I'd like to simplify the binding
by using a single property to override the only variable, color, here.

>
> > +
> > +      default-intensity:
> > +        description: |
> > +          An array of 3 integer specifying the default intensity of each color
> > +          components in this LED. <255 255 255> if unspecified.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        minItems: 3
>
> Drop minItems.... but:
>
> > +        maxItems: 3
> > +        items:
> > +          minimum: 0
> > +          maximum: 255
>
> default: 255
>
> What controls the intensity? Don't you have PWM there?

The LED takes 3-byte brightness value of each color. This property is used to
specify the default multi_intensity field for the multi-color LED. The final
brightness value is calculated with led_mc_calc_color_components like this:

mcled_cdev->subled_info[i].brightness = brightness *
mcled_cdev->subled_info[i].intensity / led_cdev->max_brightness;

The LED chip takes exactly 8 bits for the brightness (max_brightness = 255
which can't be changed.), so according to the formula above the maximum
intensity should be 255.

>
> > +
> > +      reg:
> > +        description: |
> > +          Which LED this node represents. The reg of the first LED on the chain
> > +          is 0.
>
> maxItems: 1

OK.

>
> > +
> > +    required:
> > +      - reg
> > +      - color
> > +      - function
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/common.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ws2812b@0 {
>
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

OK. I'll use leds instead.

>
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            compatible = "worldsemi,ws2812b-spi";
> > +            reg = <0>;
>
> compatible is first property, reg is second.

Got it.

--
Regards,
Chuanhong Guo
