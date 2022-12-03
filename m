Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3A2641692
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 13:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLCML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 07:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLCMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 07:11:23 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587245EC1;
        Sat,  3 Dec 2022 04:11:22 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso4481735otq.11;
        Sat, 03 Dec 2022 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0edhihdfvOG7GSghtxT+LhbhV0OXh1bVTVRGZ1/Gd/Q=;
        b=NtIqbUHB9s0JExCbH3hcdSLI4mJPgYlS1tpz9JJBGBL3VI3SGB5M5W6ogy9f3P3qXS
         CWUaK9ZWEAbvVkDm7XaZiFjGlsHylCEQk+uOYIQb3zXXfRdAKvC5uBsdp4JZxYb1loXv
         AF4kOhbjZevXykpYw2OB3IrD3gJ6NgfCHZt1MXQTfnFadoWcA1C4ehVnprXIF1CGWuka
         2r5RglbQYaEdoQlehDK++8Hol1a0oT7mfBGhrDVle55vMh4WBadg3OaTITnVYmCnwfH7
         P+y8nOKM/+gI4t0N7RAvjixMAIAgPw4fq7Ue8Lq69fo+A4Nfn1JdLOOfG9kmFpYIFLrg
         2KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0edhihdfvOG7GSghtxT+LhbhV0OXh1bVTVRGZ1/Gd/Q=;
        b=jiXRP9MF2gD77GD7GLy48A3rgAjjJ5HVz6/o+GXTHjcSVZKMDfkbSjqDKl4QMyLqUG
         Q81Zh+Vo05sxTWuXfV0CJVRVfgU4ByRatt+OmlyjCyaCDXzMWSdd8gxy5omI180ET8ef
         jzNZFvdx5j06mHI7170W0j5WXQxiD26AgninwEQeHmw+/ZIVBKEHSbGz7+7oU+hO2hlE
         rmeVNoDoS3s/f1u3b2uRT7v4duZeepfg51D5Wc30F4xMFsmDlNQvK0RNcFYPfpvcHvQ0
         otwyS2FD7meHRjrzpXZgEe9GOlP/6KRRLMnRI9P/Z0dTOB6yNW50XiFe8alPU2lOT+Iv
         k8ug==
X-Gm-Message-State: ANoB5pm0d9Gk+yn38D2yv4z/SUrptQD5GNoHHnTDgQjdftPXKB2MM0h8
        DVVk2A3y6Lzt39+GM10f1rbEjn6neiUf8YBmpyw=
X-Google-Smtp-Source: AA0mqf5BT/ikEpWtI0KOKprcNPIe7cE6MLRo9+hTCopidi/QEYkiNbQMX4qGccGD1EGu0jbGsouRViA+H+EMqJPCaNU=
X-Received: by 2002:a05:6830:699b:b0:66e:7ba6:5e0f with SMTP id
 cy27-20020a056830699b00b0066e7ba65e0fmr5004392otb.312.1670069481425; Sat, 03
 Dec 2022 04:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20221202034240.455831-1-gch981213@gmail.com> <20221202034240.455831-3-gch981213@gmail.com>
 <df8a683a-0df9-c32a-4272-19e7313ef7d7@linaro.org> <CAJsYDVLwyCG2xnWXDo72H-T4Tk7Edxmv_GSfJFvvWKrXZgBtCA@mail.gmail.com>
 <783fd2ff-cf7a-d820-6be7-9863e1786349@linaro.org>
In-Reply-To: <783fd2ff-cf7a-d820-6be7-9863e1786349@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 3 Dec 2022 20:11:10 +0800
Message-ID: <CAJsYDVLuXG9UiOixxs997QdfeQVitFhhRDRbJ-uQ4Agz7LuMAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
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

On Sat, Dec 3, 2022 at 6:52 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/12/2022 13:55, Chuanhong Guo wrote:
> >>> +
> >>> +      default-brightness:
> >>> +        description:
> >>> +          The default brightness that should be applied to the LED by the operating
> >>> +          system on start-up. The brightness should not exceed the brightness the
> >>> +          LED can provide.
> >>> +        $ref: /schemas/types.yaml#/definitions/uint32
> >>> +        minimum: 0
> >>> +        maximum: 255
> >>> +        default: 0
> >>> +
> >>> +      default-intensity:
> >>> +        description: |
> >>> +          An array of 3 integer specifying the default intensity of each color
> >>> +          components in this LED. <255 255 255> if unspecified.
> >>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> >>
> >> I am still not convinced these two properties are correct. Why this LED
> >> is special and defines default brightness and intensity and other LEDs
> >> do not? You explained you are doing it for user-space which is usually
> >> not a valid reason for changes specific to one binding. Either all
> >> bindings should support it or none.
> >
> > There's already a default-state for simple LEDs without brightness
> > control so I think it makes sense to add default-brightness for LEDs
> > with brightness control and default-intensity for colored LEDs.
> > The default-state seems to be implemented in various LED drivers,
> > so I implemented these two properties in my LED driver.
> > There's nothing device-specific about these two properties.
>
> default-state has a bit different purpose - to prevent any
> glitches/changes when probing driver.

OK. I didn't know that property is used in this way.
I can live without them. I'll drop it in the next version.

>
> >>
> >>> +        maxItems: 3
> >>> +        items:
> >>> +          minimum: 0
> >>> +          maximum: 255
> >>> +
> >>> +      reg:
> >>> +        description: |
> >>> +          Which LED this node represents. The reg of the first LED on the chain
> >>> +          is 0.
> >>> +        maxItems: 1
> >>> +
> >>> +    required:
> >>> +      - reg
> >>> +      - color
> >>> +      - function
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/leds/common.h>
> >>> +    spi {
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +
> >>> +        leds@0 {
> >>
> >> git grep leds@ -- Documentation/devicetree/ | wc -l
> >> 1
> >> git grep led@ -- Documentation/devicetree/ | wc -l
> >> 165
> >>
> >> so rather not the first one ("leds").
> >
> > As you can see, this node describes a chain of LEDs, not
> > a single LED, so the plural form is more appropriate than
> > the singular form.
> >
> >>
> >> There is also:
> >> git grep led-controller@ -- Documentation/devicetree/ | wc -l
> >> 30
> >
> > This also isn't appropriate. WS2812B is a single LED package
> > of 3 diodes and a microcontroller. If we treat every package
> > as a LED, the SPI MOSI is connected directly to the LED
> > packages themselves with no controller in between.
> > If we treat the microcontroller as a led-controller, every
> > LED contains its own controller, instead of one controller
> > controlling all LEDs, and the parent node still shouldn't
> > be called a led-controller.
> >
> > Here's a picture of the WS2812B LED package:
> > https://cdn-shop.adafruit.com/970x728/1655-00.jpg
> > and a chain of them:
> > https://cdn-shop.adafruit.com/970x728/1463-00.jpg
>
> Then your bindings and DTS do not represent the hardware.

How should this hardware be represented, then?

The connection can be:

SPI-MOSI---LED1---LED2---LED3---...---LEDN

or

SPI-MOSI---Tri-state signal gate---LED1---LED2---LED3---...---LEDN
SPI-CS-----|

-- 
Regards,
Chuanhong Guo
