Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2D666325
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjAKSzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjAKSyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:54:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC7C35939;
        Wed, 11 Jan 2023 10:53:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w1so16012478wrt.8;
        Wed, 11 Jan 2023 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2wGCn22BNT1FcUUhpV8F0QZAx3bQbEi/myfeGSwfEk=;
        b=qGij+UVGJvN/BHbOG8QOS2A1oJdJVErfAPLeM7dOgKYn6OuhNTxRQVmaDsXALfQf/3
         0cjihx7rlw0BfJfCyq6qNuPeNzzbBnxJwMgp+oDFIfSWiH62vJc/XS4HICdBlNkxgMLx
         medVPBFEH0zSclt4o/fBsLOXa+ReZul0qKTvOJaSL5//jfVAQjoOzSz+uP91+0P+AYZM
         FnXfBLKqBxgclUCg5tCFMHXity2LAohO3nz5iTUhiDCg3kHlhjjzfbaMvdKbRsi21AOM
         XHAIHzj5zkwMgkCnA27GAuDElnssyjbyQnAmRUfXB4CToZLz/aPX/Uoe8fEk/8/zCZdo
         xUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2wGCn22BNT1FcUUhpV8F0QZAx3bQbEi/myfeGSwfEk=;
        b=Q6sdmg5qv9tBVOXIYA6+gOvceyTAVYxKI47ZIj6S2bdDkOD2tUET7MpaYZlVeAZTUU
         B/q899FN9EqOHvNVKxWBxu4wst86R/KGB+ye86/PDUIH5oCo2lb15jJkZ15iuQz/ehGq
         3Il8MafkGSyeSVkoRm6HJQREVvFvBh1Q1MizEbg4ki7LoLGoh4PFe0r9/3sUfgEHhLCt
         XOwsk7/SJbq9/La3uTxEJYgLpyaxZ8Oz4y9Yh4/qGRBrnQaFbVnJ5R0lALsLGa3h7hy2
         1yEWySOQMFierT9pI+Bi/JxYgkoISqW7FlrqFzXEUfFaXDRpqAyT8saD0BR38BwdTweN
         eu9A==
X-Gm-Message-State: AFqh2kqaRnF2Bx16KHCALjLZIxroqmRqOrF+6TZH5+DMzNF0Y+LeuPSg
        s4Shfy761X2nRi459JWz+W4Pa1Dw9hU/H50GnIY=
X-Google-Smtp-Source: AMrXdXtc27pHabXdesfiWyb9XBOl1+264khORJQ3qRO2u6rypYaAFJK+/cU/TsTS+wSrKpbeZR4c3wf8+HEhm8uD/XE=
X-Received: by 2002:adf:dc09:0:b0:242:fce:543b with SMTP id
 t9-20020adfdc09000000b002420fce543bmr2900918wri.244.1673463219604; Wed, 11
 Jan 2023 10:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20221212045558.69602-1-gch981213@gmail.com> <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org> <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
 <9d2c05f6-af5a-2d79-02ea-85c49e244957@linaro.org> <Y7xGUiWBKIAm9YFA@google.com>
 <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org> <Y708DfB41c/ZivRw@google.com>
In-Reply-To: <Y708DfB41c/ZivRw@google.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 12 Jan 2023 02:53:27 +0800
Message-ID: <CAJsYDVJC15cePQ65BR=dxKY8ADoRepbiiFqXTNQzh_6RTAeMYA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
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

On Tue, Jan 10, 2023 at 6:21 PM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 10 Jan 2023, Krzysztof Kozlowski wrote:
>
> > On 09/01/2023 17:52, Lee Jones wrote:
> > > On Sat, 24 Dec 2022, Krzysztof Kozlowski wrote:
> > >
> > >> On 23/12/2022 18:19, Pavel Machek wrote:
> > >>> Hi!
> > >>>
> > >>>>> Add dt binding schema for WorldSemi WS2812B driven using SPI
> > >>>>> bus.
> > >>>>>
> > >>>>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > >>>>> ---
> > >>>>> Changes since v1:
> > >>>>> remove linux driver reference from description
> > >>>>> remove some obvious descriptions
> > >>>>> fix unit address regex in multi-led property
> > >>>>> drop various minItems
> > >>>>> add maxItems = 1 to reg
> > >>>>> fix node names and property orders in binding example
> > >>>>> drop -spi from compatible string
> > >>>>> add default-brightness
> > >>>>>
> > >>>>> Change since v2:
> > >>>>> drop "this patch" from commit message
> > >>>>> rename leds to led-controller
> > >>>>> drop default-brightness and default-intensity
> > >>>>>
> > >>>>> Change since v3:
> > >>>>> reword commit title
> > >>>>>
> > >>>>>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
> > >>>>>  1 file changed, 116 insertions(+)
> > >>>>>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > >>>>>
> > >>>>> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > >>>>> new file mode 100644
> > >>>>> index 000000000000..548c05ac3d31
> > >>>>> --- /dev/null
> > >>>>> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > >>>>> @@ -0,0 +1,116 @@
> > >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >>>>> +%YAML 1.2
> > >>>>> +---
> > >>>>> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
> > >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>>> +
> > >>>>> +title: WS2812B LEDs driven using SPI
> > >>>>> +
> > >>>>> +maintainers:
> > >>>>> +  - Chuanhong Guo <gch981213@gmail.com>
> > >>>>> +
> > >>>>> +description: |
> > >>>>> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
> > >>>>> +  together and controlled individually using a single wire.
> > >>>>> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
> > >>>>> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
> > >>>>> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
> > >>>>> +  for the data pin.
> > >>>>> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
> > >>>>> +  and the controller needs to send all the bytes continuously.
> > >>>>> +
> > >>>>> +allOf:
> > >>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > >>>>> +
> > >>>>> +properties:
> > >>>>> +  compatible:
> > >>>>> +    const: worldsemi,ws2812b
> > >>>>> +
> > >>>>> +  reg:
> > >>>>> +    maxItems: 1
> > >>>>> +
> > >>>>> +  spi-max-frequency:
> > >>>>> +    minimum: 2105000
> > >>>>> +    maximum: 2850000
> > >>>>> +
> > >>>>> +  "#address-cells":
> > >>>>> +    const: 1
> > >>>>> +
> > >>>>> +  "#size-cells":
> > >>>>> +    const: 0
> > >>>>> +
> > >>>>> +patternProperties:
> > >>>>> +  "^multi-led@[0-9a-f]+$":
> > >>>>> +    type: object
> > >>>>> +    $ref: leds-class-multicolor.yaml#
> > >>>>> +    unevaluatedProperties: false
> > >>>>> +
> > >>>>> +    properties:
> > >>>>> +      color-index:
> > >
> > > Why "index"?
> > >
> > > Isn't it just an array of colours rather than an index into something?
> >
> > Yeah.

The corresponding sysfs interface is called 'multi_index' so I called
it this way.

> >
> > >
> > >>>>> +        description: |
> > >>>>> +          A 3-item array specifying color of each components in this LED. It
> > >
> > > Why are you forcing this to 3?
> > >
> > > Surely there are multi-colour LEDs containing more or less colours?
> >
> > For this device, because it has only tuples of three.

WS2812B has 3 colors per chip. There are chips using a similar protocol
with 4 colors but my current driver is hard-coded to support exactly 3 colors.

> This doesn't looks like a device specific property to me.
>
> If this is not going to be used by any other device, shouldn't it
> contain a prefix?
>
> > >>>>> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
> > >>>>> +          header include/dt-bindings/leds/common.h. Defaults to
> > >
> > > Isn't "include" a Linuxisum?
> >
> > No, better to have full paths, so automated tools can validate them. If
> > we ever decide to drop it, we can also make a easier search&replace for
> > the pattern starting with include/.
>
> Very well.  It's your train set. :)
>
> > >>>>> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
> > >>>>> +          if unspecified.
> > >>>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > >>>>> +        maxItems: 3
> > >>>>
> > >>>> In general I am fine with it, although there is still question for
> > >>>> adding more multi-color defines in binding headers to replace this
> > >>>> property - GRB/RBG/GBR and even more for RGBW.
> > >>>>
> > >>>> Pavel, Lee, any thoughts from your side?
> > >>>
> > >>> This really needs to mention the name this hardware is known as -- I
> > >>> believe it is NeoPixel.
> > >>
> > >> We wait here for feedback on colors... The binding is re-implementing
> > >> color, just because of combinations GRB/RBG/GBR, which could be achieved
> > >> with new color defines.
> > >
> > > Sure, but where does that end?
> > >
> > > How many permutations are there likely to be?
> >
> > For light emitting devices, RGB seems to be used for so long, that I
> > don't expect more permutations (e.g. CMY). On the other hand, someone
> > might create LED strip with whatever colors, so maybe indeed better to
> > allow any variations as in array.
>
> Even you suggested variation: "even more for RGBW".
>
> Caveat: as you are well aware, "I'm new here", so my input is no more
> informed or valuable as yours at this point.  I'm just calling it as I
> see it.  If you have strong opinions and they differ wildly from mine,
> we may have to take intervention from Pavel.  As it stands, the
> property, although slightly restricted IMHO, appears fine.
>
> > > An unlimited array has more of a chance of standing the test of time.

I have another idea that avoids this whole conversation: Abandon
color-index completely and determine colors with compatible string
and platform data.
My original idea of this property is to support WS2812B and its clones
with different colors under the same compatible string. Technically
genuine WS2812Bs only come with GRB colors and the clones
should have their own chip names (e.g. xiaomi,hm0807a for an RGB
clone and <unknown vendor>,sk6812 for an RGBW one.). It's
reasonable to have one compatible string per chip for colors, a
chip-specific property. Also, adding more compatible devices to a
driver is less invasive than adding more definitions to leds/common.h
What do you think?

-- 
Regards,
Chuanhong Guo
