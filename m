Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD3640736
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiLBMzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiLBMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:55:45 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C2D3A33;
        Fri,  2 Dec 2022 04:55:44 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id v82so5213627oib.4;
        Fri, 02 Dec 2022 04:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5HMulQtDEYr8StaCD+M2NKtZZtuACwzVH39fWb0WUyQ=;
        b=eEQQ6uvfOl76Ao5O0QbsLd3+0LQZ2O3gFdB2kh6fVLE3YJOs4VVYyiLKhQU9rUTcr1
         1olRnVzFXOjq40mdtJXb/44+tzDY9fL+8HjvDbf2xBDWkq15yq0MIh3g6J+orM3XGrfn
         pPQx/kge9o5aDiJnpS4POr6VBFDbCxDpARtIBpU4ptxhxaUnXvA3Egdt4VjAj0IEJLws
         A4AUuIBpYpfo4AEIvn+rQWazbii5/MQ4Bj35iT5dr/YHEBKOD3tmo/wtU/2vHYtliZxI
         QRbfucJ5HTEEABlxb6GF0lWzPgfkNWcRnptv5yDCK5JGeENRD+HdZ10XdwLXYlgwN3Zq
         yufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HMulQtDEYr8StaCD+M2NKtZZtuACwzVH39fWb0WUyQ=;
        b=UwfdifmDfse11UqoXwJTVElK3bu7R0f0BUreLMb2MhhWusJjTa3PeuMyOpvcisu2QE
         HL+oi5PboAJkI5ToEbo9rGt/JakJMpre5188ojwM+1eiqPWoAmPy5Xn9CuS+XUV30tSV
         XCJw0Mj+Os/7xKINMgzNnJw/juU/+hjzkxL96/XAO2TbRMnf8HaODEkV2muZ+kjRS337
         1NVXSjyFRLLzH3ynnDOr0Sjhs/Onbl7RAvH0TK2SfeRvkHT+TDK9n8qz/2dAzkb5jHMJ
         HZF+LP7Qmcvr9zqGqs11qOId22Mm8IzCuNPdvHvDNx2zhRRJzppA1K+EqMsOAelNCFJB
         N/wQ==
X-Gm-Message-State: ANoB5pkXYOB3llzYe8blfdlm3iP020KqXb1cFuE8uyra/zOXrrhHCeZD
        IJ+uaxJ7GZzB455WBbnR3hiDtgXC1p9zI+QFqA0=
X-Google-Smtp-Source: AA0mqf6aVBf+NKOWch0Jfc9fmrrRGCBM5i7QIhLaLUn3iF/LlY6ukN9sg76KFvOQTE8JRdrMBKkdiWRi+9drUADmgYI=
X-Received: by 2002:a05:6808:2ca:b0:359:ca42:419 with SMTP id
 a10-20020a05680802ca00b00359ca420419mr36163478oid.98.1669985743872; Fri, 02
 Dec 2022 04:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20221202034240.455831-1-gch981213@gmail.com> <20221202034240.455831-3-gch981213@gmail.com>
 <df8a683a-0df9-c32a-4272-19e7313ef7d7@linaro.org>
In-Reply-To: <df8a683a-0df9-c32a-4272-19e7313ef7d7@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 2 Dec 2022 20:55:32 +0800
Message-ID: <CAJsYDVLwyCG2xnWXDo72H-T4Tk7Edxmv_GSfJFvvWKrXZgBtCA@mail.gmail.com>
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

On Fri, Dec 2, 2022 at 7:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/12/2022 04:42, Chuanhong Guo wrote:
> > This patch adds dt binding schema for WorldSemi WS2812B driven using SPI
> > bus.
>
> Do not use "This commit/patch".
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

OK.

> [...]
> > +
> > +      default-brightness:
> > +        description:
> > +          The default brightness that should be applied to the LED by the operating
> > +          system on start-up. The brightness should not exceed the brightness the
> > +          LED can provide.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 0
> > +        maximum: 255
> > +        default: 0
> > +
> > +      default-intensity:
> > +        description: |
> > +          An array of 3 integer specifying the default intensity of each color
> > +          components in this LED. <255 255 255> if unspecified.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
>
> I am still not convinced these two properties are correct. Why this LED
> is special and defines default brightness and intensity and other LEDs
> do not? You explained you are doing it for user-space which is usually
> not a valid reason for changes specific to one binding. Either all
> bindings should support it or none.

There's already a default-state for simple LEDs without brightness
control so I think it makes sense to add default-brightness for LEDs
with brightness control and default-intensity for colored LEDs.
The default-state seems to be implemented in various LED drivers,
so I implemented these two properties in my LED driver.
There's nothing device-specific about these two properties.

>
> > +        maxItems: 3
> > +        items:
> > +          minimum: 0
> > +          maximum: 255
> > +
> > +      reg:
> > +        description: |
> > +          Which LED this node represents. The reg of the first LED on the chain
> > +          is 0.
> > +        maxItems: 1
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
> > +        leds@0 {
>
> git grep leds@ -- Documentation/devicetree/ | wc -l
> 1
> git grep led@ -- Documentation/devicetree/ | wc -l
> 165
>
> so rather not the first one ("leds").

As you can see, this node describes a chain of LEDs, not
a single LED, so the plural form is more appropriate than
the singular form.

>
> There is also:
> git grep led-controller@ -- Documentation/devicetree/ | wc -l
> 30

This also isn't appropriate. WS2812B is a single LED package
of 3 diodes and a microcontroller. If we treat every package
as a LED, the SPI MOSI is connected directly to the LED
packages themselves with no controller in between.
If we treat the microcontroller as a led-controller, every
LED contains its own controller, instead of one controller
controlling all LEDs, and the parent node still shouldn't
be called a led-controller.

Here's a picture of the WS2812B LED package:
https://cdn-shop.adafruit.com/970x728/1655-00.jpg
and a chain of them:
https://cdn-shop.adafruit.com/970x728/1463-00.jpg

--
Regards,
Chuanhong Guo
