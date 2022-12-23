Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2389D655095
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLWMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLWMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:48:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E961D309;
        Fri, 23 Dec 2022 04:48:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7888960A6F;
        Fri, 23 Dec 2022 12:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A861C433D2;
        Fri, 23 Dec 2022 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671799689;
        bh=W7+OtaE26Rq0/9/+5FJNb9Z0lJvsOAo1uMNomxGwQJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJcXi3fucQHnXd3o2I2+N9Bs26xTYvCP7xNkNb1vZTDpUyn7247GyYGhN7LKbKGTo
         BoPp344HafMfcLwcuEXRTM4M3RkewjBouGm+sps/dyrLpq4a/dLrkY4bMhcp9nkBJg
         OQQp6rihXVpHKPLgAsG9JYJnXgR/ssZGZkTKrxDxJNdDthG4VmwedvYCJOpdorq/VZ
         7PNkFYNIMMZ973yd1g+kkUiZCzGkY3+18uPZtSHef50p5LQNQGAeqpQzuU+NLZu1wA
         pyBltWG3/f6Ud/MN/jz6GeuwTOmXljBt5Pt6BxJ2Wx41BX/FoSWVZHJ+lnizrL012K
         fG3osmZuvbdJg==
Date:   Fri, 23 Dec 2022 12:48:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <Y6Wjg3j6QLNFEbiY@google.com>
References: <20221212045558.69602-1-gch981213@gmail.com>
 <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022, Krzysztof Kozlowski wrote:

> On 12/12/2022 05:55, Chuanhong Guo wrote:
> > Add dt binding schema for WorldSemi WS2812B driven using SPI
> > bus.
> > 
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > ---
> > Changes since v1:
> > remove linux driver reference from description
> > remove some obvious descriptions
> > fix unit address regex in multi-led property
> > drop various minItems
> > add maxItems = 1 to reg
> > fix node names and property orders in binding example
> > drop -spi from compatible string
> > add default-brightness
> > 
> > Change since v2:
> > drop "this patch" from commit message
> > rename leds to led-controller
> > drop default-brightness and default-intensity
> > 
> > Change since v3:
> > reword commit title
> > 
> >  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > new file mode 100644
> > index 000000000000..548c05ac3d31
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: WS2812B LEDs driven using SPI
> > +
> > +maintainers:
> > +  - Chuanhong Guo <gch981213@gmail.com>
> > +
> > +description: |
> > +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
> > +  together and controlled individually using a single wire.
> > +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
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
> > +    const: worldsemi,ws2812b
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
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
> > +  "^multi-led@[0-9a-f]+$":
> > +    type: object
> > +    $ref: leds-class-multicolor.yaml#
> > +    unevaluatedProperties: false
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
> > +        maxItems: 3
> 
> In general I am fine with it, although there is still question for
> adding more multi-color defines in binding headers to replace this
> property - GRB/RBG/GBR and even more for RGBW.
> 
> Pavel, Lee, any thoughts from your side?

Nothing from me yet.

If Pavel doesn't respond soon, I'll get around to doing a full sweep
after the merge-window has closed.  Actually, most likely the new year
now.

-- 
Lee Jones [李琼斯]
