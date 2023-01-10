Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6E663E00
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjAJKWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjAJKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:22:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391213F76;
        Tue, 10 Jan 2023 02:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ADB261554;
        Tue, 10 Jan 2023 10:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEBBC433EF;
        Tue, 10 Jan 2023 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673346068;
        bh=bclZRUdBGO4I6bFo9H/N7NPvGRMYVYIKCFGHMQnVjy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8xiJRPsYvRZlFS4+NrSm2CbYHskd2VQwTx35y3YseZZB/pg2nANBRwGbatFnWQyT
         8amFc/oPAIqy9JhICLbODmJH93fBMapoijjpwciifb+l9oI5PxEF7ri74DkDjep71F
         Fj3di/H3Z3OVI6ROqqEkx6rJvjMgejPw1s4SFmuLl0vHAm8qoyx86AjlycPZjL8B3X
         jaZSWxJF1R2VR1UgYg0T8ya43e0EhV0shew5wCaMqfBPqIUPt1cGhz6dIHVWQ1yn7n
         O2kkHWLyGUg+VcNugaTnO44OAVi6XMa2cor9MebMGQD5+J89W0D9q7mepGluCwPLzC
         pRinPEvaAR2Qg==
Date:   Tue, 10 Jan 2023 10:21:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Chuanhong Guo <gch981213@gmail.com>,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <Y708DfB41c/ZivRw@google.com>
References: <20221212045558.69602-1-gch981213@gmail.com>
 <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
 <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
 <9d2c05f6-af5a-2d79-02ea-85c49e244957@linaro.org>
 <Y7xGUiWBKIAm9YFA@google.com>
 <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023, Krzysztof Kozlowski wrote:

> On 09/01/2023 17:52, Lee Jones wrote:
> > On Sat, 24 Dec 2022, Krzysztof Kozlowski wrote:
> > 
> >> On 23/12/2022 18:19, Pavel Machek wrote:
> >>> Hi!
> >>>
> >>>>> Add dt binding schema for WorldSemi WS2812B driven using SPI
> >>>>> bus.
> >>>>>
> >>>>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> >>>>> ---
> >>>>> Changes since v1:
> >>>>> remove linux driver reference from description
> >>>>> remove some obvious descriptions
> >>>>> fix unit address regex in multi-led property
> >>>>> drop various minItems
> >>>>> add maxItems = 1 to reg
> >>>>> fix node names and property orders in binding example
> >>>>> drop -spi from compatible string
> >>>>> add default-brightness
> >>>>>
> >>>>> Change since v2:
> >>>>> drop "this patch" from commit message
> >>>>> rename leds to led-controller
> >>>>> drop default-brightness and default-intensity
> >>>>>
> >>>>> Change since v3:
> >>>>> reword commit title
> >>>>>
> >>>>>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
> >>>>>  1 file changed, 116 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..548c05ac3d31
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> >>>>> @@ -0,0 +1,116 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: WS2812B LEDs driven using SPI
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Chuanhong Guo <gch981213@gmail.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
> >>>>> +  together and controlled individually using a single wire.
> >>>>> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
> >>>>> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
> >>>>> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
> >>>>> +  for the data pin.
> >>>>> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
> >>>>> +  and the controller needs to send all the bytes continuously.
> >>>>> +
> >>>>> +allOf:
> >>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    const: worldsemi,ws2812b
> >>>>> +
> >>>>> +  reg:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  spi-max-frequency:
> >>>>> +    minimum: 2105000
> >>>>> +    maximum: 2850000
> >>>>> +
> >>>>> +  "#address-cells":
> >>>>> +    const: 1
> >>>>> +
> >>>>> +  "#size-cells":
> >>>>> +    const: 0
> >>>>> +
> >>>>> +patternProperties:
> >>>>> +  "^multi-led@[0-9a-f]+$":
> >>>>> +    type: object
> >>>>> +    $ref: leds-class-multicolor.yaml#
> >>>>> +    unevaluatedProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      color-index:
> > 
> > Why "index"?
> > 
> > Isn't it just an array of colours rather than an index into something?
> 
> Yeah.
> 
> > 
> >>>>> +        description: |
> >>>>> +          A 3-item array specifying color of each components in this LED. It
> > 
> > Why are you forcing this to 3?
> > 
> > Surely there are multi-colour LEDs containing more or less colours?
> 
> For this device, because it has only tuples of three.

This doesn't looks like a device specific property to me.

If this is not going to be used by any other device, shouldn't it
contain a prefix?

> >>>>> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
> >>>>> +          header include/dt-bindings/leds/common.h. Defaults to
> > 
> > Isn't "include" a Linuxisum?
> 
> No, better to have full paths, so automated tools can validate them. If
> we ever decide to drop it, we can also make a easier search&replace for
> the pattern starting with include/.

Very well.  It's your train set. :)

> >>>>> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
> >>>>> +          if unspecified.
> >>>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>>> +        maxItems: 3
> >>>>
> >>>> In general I am fine with it, although there is still question for
> >>>> adding more multi-color defines in binding headers to replace this
> >>>> property - GRB/RBG/GBR and even more for RGBW.
> >>>>
> >>>> Pavel, Lee, any thoughts from your side?
> >>>
> >>> This really needs to mention the name this hardware is known as -- I
> >>> believe it is NeoPixel.
> >>
> >> We wait here for feedback on colors... The binding is re-implementing
> >> color, just because of combinations GRB/RBG/GBR, which could be achieved
> >> with new color defines.
> > 
> > Sure, but where does that end?
> > 
> > How many permutations are there likely to be?
> 
> For light emitting devices, RGB seems to be used for so long, that I
> don't expect more permutations (e.g. CMY). On the other hand, someone
> might create LED strip with whatever colors, so maybe indeed better to
> allow any variations as in array.

Even you suggested variation: "even more for RGBW".

Caveat: as you are well aware, "I'm new here", so my input is no more
informed or valuable as yours at this point.  I'm just calling it as I
see it.  If you have strong opinions and they differ wildly from mine,
we may have to take intervention from Pavel.  As it stands, the
property, although slightly restricted IMHO, appears fine.

> > An unlimited array has more of a chance of standing the test of time.

-- 
Lee Jones [李琼斯]
