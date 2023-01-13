Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503E6669B62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjAMPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjAMPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:05:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313DD8B527;
        Fri, 13 Jan 2023 06:57:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E12BCE20E1;
        Fri, 13 Jan 2023 14:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27201C433D2;
        Fri, 13 Jan 2023 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673621818;
        bh=2w1ZnX3BjJMXLuKVlD5KgZNiwlFbFvoj93igc66pi3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tru5ErmKZdHg05GwSrsIYkF6DAbHWRmj1fhPbjT9dvCo401eB4eLtnKhsXZZxLbrb
         WoSqOWh7yizbW3lRApNXURPcA+4Pluw6hUxb+W8uHQAFh5D6g1xlv4bV9paenruouW
         3pEhv2AVzAuL/XoGGoWwpCd2G8HlrD8eB2N3ESNPAw8JVDF7u2c309nR4v7dL5iA2I
         7WDd3rga2gFiyy6tINj9ey3TiiE4pW7UdqgXSfFv4N+wCLFdghpafQ1K2/cD2za+yx
         5j0OFSlqaAhld/9WFBRiLMuN3iWbU8ulwNv530hIj7lUJGXWld1GDxnUOvKJymxbBY
         NWxP4B/WX4K7w==
Date:   Fri, 13 Jan 2023 14:56:51 +0000
From:   Lee Jones <lee@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
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
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
Message-ID: <Y8FxM/qW3IL2y4YY@google.com>
References: <20221212045558.69602-1-gch981213@gmail.com>
 <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
 <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
 <9d2c05f6-af5a-2d79-02ea-85c49e244957@linaro.org>
 <Y7xGUiWBKIAm9YFA@google.com>
 <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org>
 <Y708DfB41c/ZivRw@google.com>
 <CAJsYDVJC15cePQ65BR=dxKY8ADoRepbiiFqXTNQzh_6RTAeMYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJsYDVJC15cePQ65BR=dxKY8ADoRepbiiFqXTNQzh_6RTAeMYA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023, Chuanhong Guo wrote:

> Hi!
> 
> On Tue, Jan 10, 2023 at 6:21 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 10 Jan 2023, Krzysztof Kozlowski wrote:
> >
> > > On 09/01/2023 17:52, Lee Jones wrote:
> > > > On Sat, 24 Dec 2022, Krzysztof Kozlowski wrote:
> > > >
> > > >> On 23/12/2022 18:19, Pavel Machek wrote:
> > > >>> Hi!
> > > >>>
> > > >>>>> Add dt binding schema for WorldSemi WS2812B driven using SPI
> > > >>>>> bus.
> > > >>>>>
> > > >>>>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > > >>>>> ---
> > > >>>>> Changes since v1:
> > > >>>>> remove linux driver reference from description
> > > >>>>> remove some obvious descriptions
> > > >>>>> fix unit address regex in multi-led property
> > > >>>>> drop various minItems
> > > >>>>> add maxItems = 1 to reg
> > > >>>>> fix node names and property orders in binding example
> > > >>>>> drop -spi from compatible string
> > > >>>>> add default-brightness
> > > >>>>>
> > > >>>>> Change since v2:
> > > >>>>> drop "this patch" from commit message
> > > >>>>> rename leds to led-controller
> > > >>>>> drop default-brightness and default-intensity
> > > >>>>>
> > > >>>>> Change since v3:
> > > >>>>> reword commit title
> > > >>>>>
> > > >>>>>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
> > > >>>>>  1 file changed, 116 insertions(+)
> > > >>>>>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > > >>>>>
> > > >>>>> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > > >>>>> new file mode 100644
> > > >>>>> index 000000000000..548c05ac3d31
> > > >>>>> --- /dev/null
> > > >>>>> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > > >>>>> @@ -0,0 +1,116 @@
> > > >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > >>>>> +%YAML 1.2
> > > >>>>> +---
> > > >>>>> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
> > > >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >>>>> +
> > > >>>>> +title: WS2812B LEDs driven using SPI
> > > >>>>> +
> > > >>>>> +maintainers:
> > > >>>>> +  - Chuanhong Guo <gch981213@gmail.com>
> > > >>>>> +
> > > >>>>> +description: |
> > > >>>>> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
> > > >>>>> +  together and controlled individually using a single wire.
> > > >>>>> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
> > > >>>>> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
> > > >>>>> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
> > > >>>>> +  for the data pin.
> > > >>>>> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
> > > >>>>> +  and the controller needs to send all the bytes continuously.
> > > >>>>> +
> > > >>>>> +allOf:
> > > >>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > >>>>> +
> > > >>>>> +properties:
> > > >>>>> +  compatible:
> > > >>>>> +    const: worldsemi,ws2812b
> > > >>>>> +
> > > >>>>> +  reg:
> > > >>>>> +    maxItems: 1
> > > >>>>> +
> > > >>>>> +  spi-max-frequency:
> > > >>>>> +    minimum: 2105000
> > > >>>>> +    maximum: 2850000
> > > >>>>> +
> > > >>>>> +  "#address-cells":
> > > >>>>> +    const: 1
> > > >>>>> +
> > > >>>>> +  "#size-cells":
> > > >>>>> +    const: 0
> > > >>>>> +
> > > >>>>> +patternProperties:
> > > >>>>> +  "^multi-led@[0-9a-f]+$":
> > > >>>>> +    type: object
> > > >>>>> +    $ref: leds-class-multicolor.yaml#
> > > >>>>> +    unevaluatedProperties: false
> > > >>>>> +
> > > >>>>> +    properties:
> > > >>>>> +      color-index:
> > > >
> > > > Why "index"?
> > > >
> > > > Isn't it just an array of colours rather than an index into something?
> > >
> > > Yeah.
> 
> The corresponding sysfs interface is called 'multi_index' so I called
> it this way.

DT nomenclature should not be affected by Linuxisums.

Please err towards data-sheet and H/W nomenclature.

> > > >>>>> +        description: |
> > > >>>>> +          A 3-item array specifying color of each components in this LED. It
> > > >
> > > > Why are you forcing this to 3?
> > > >
> > > > Surely there are multi-colour LEDs containing more or less colours?
> > >
> > > For this device, because it has only tuples of three.
> 
> WS2812B has 3 colors per chip. There are chips using a similar protocol
> with 4 colors but my current driver is hard-coded to support exactly 3 colors.

So the description is for 'this device' rather than any re-use.

And the handling of this property is only contained in your driver?

In which case, my understanding is that you should use a prefix.

> > This doesn't looks like a device specific property to me.
> >
> > If this is not going to be used by any other device, shouldn't it
> > contain a prefix?
> >
> > > >>>>> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
> > > >>>>> +          header include/dt-bindings/leds/common.h. Defaults to
> > > >
> > > > Isn't "include" a Linuxisum?
> > >
> > > No, better to have full paths, so automated tools can validate them. If
> > > we ever decide to drop it, we can also make a easier search&replace for
> > > the pattern starting with include/.
> >
> > Very well.  It's your train set. :)
> >
> > > >>>>> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
> > > >>>>> +          if unspecified.
> > > >>>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > > >>>>> +        maxItems: 3
> > > >>>>
> > > >>>> In general I am fine with it, although there is still question for
> > > >>>> adding more multi-color defines in binding headers to replace this
> > > >>>> property - GRB/RBG/GBR and even more for RGBW.
> > > >>>>
> > > >>>> Pavel, Lee, any thoughts from your side?
> > > >>>
> > > >>> This really needs to mention the name this hardware is known as -- I
> > > >>> believe it is NeoPixel.
> > > >>
> > > >> We wait here for feedback on colors... The binding is re-implementing
> > > >> color, just because of combinations GRB/RBG/GBR, which could be achieved
> > > >> with new color defines.
> > > >
> > > > Sure, but where does that end?
> > > >
> > > > How many permutations are there likely to be?
> > >
> > > For light emitting devices, RGB seems to be used for so long, that I
> > > don't expect more permutations (e.g. CMY). On the other hand, someone
> > > might create LED strip with whatever colors, so maybe indeed better to
> > > allow any variations as in array.
> >
> > Even you suggested variation: "even more for RGBW".
> >
> > Caveat: as you are well aware, "I'm new here", so my input is no more
> > informed or valuable as yours at this point.  I'm just calling it as I
> > see it.  If you have strong opinions and they differ wildly from mine,
> > we may have to take intervention from Pavel.  As it stands, the
> > property, although slightly restricted IMHO, appears fine.
> >
> > > > An unlimited array has more of a chance of standing the test of time.
> 
> I have another idea that avoids this whole conversation: Abandon
> color-index completely and determine colors with compatible string
> and platform data.
> My original idea of this property is to support WS2812B and its clones
> with different colors under the same compatible string. Technically
> genuine WS2812Bs only come with GRB colors and the clones
> should have their own chip names (e.g. xiaomi,hm0807a for an RGB
> clone and <unknown vendor>,sk6812 for an RGBW one.). It's
> reasonable to have one compatible string per chip for colors, a
> chip-specific property. Also, adding more compatible devices to a
> driver is less invasive than adding more definitions to leds/common.h
> What do you think?

Yes it's reasonable to have a compatible string per device and yes, you
can do matching (in C) based on compatible string, so this sounds
reasonable to me.  It also sounds reasonable to describe the H/W (inc.
colours along with any ordering, if that's important) inside the DT.

Your call I guess.

-- 
Lee Jones [李琼斯]
