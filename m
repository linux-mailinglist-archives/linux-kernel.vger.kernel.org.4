Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C26497D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiLLCD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiLLCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:03:24 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693DB5F6D;
        Sun, 11 Dec 2022 18:03:23 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so6438066otp.9;
        Sun, 11 Dec 2022 18:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3rKZy7knIre59rDn95jpx/diIMmgY2qf/hPmfPVQfg=;
        b=MtvEX0MLhOl3lgLjdO4WCbSYuXU2lRejclt8S5FVftF+3RHNYM1sDvss4mR1XRVDMN
         8+49gnHJsqFjnnyfsIB1o7mJiM3nlMY/z9/fk3eOKx1jss4eQ46KkGMZqYnqervFZU+P
         2+epH7pCzkLYg4suXtZ1dFQNoFh6JGds8DBBj0cSnW1iT0s5Wica5iayzNsZpMQ8xoj+
         plybaKMoBrQ9gLglzn1kiAsHrH0BNQu7RepURdkRUoQXvKb0povs8ggkYMbfxOEpLxnY
         39GNRYQFzpP++gUgU6fQ71p4tAV6TP6hSIXLAPHd6UB7mosKHDUTwseqMfy+9PIWr2x5
         UfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3rKZy7knIre59rDn95jpx/diIMmgY2qf/hPmfPVQfg=;
        b=JqpO1nJlV1AWqtOPHS/S5zGYeem/n+oDGLqYQ2rxXJL30uZztkZtjPHYSX0WQ2kW7Z
         lNvsUBacBZDPtEwCuNskFf0UHzLgRGjgY0lcur4kfS6qdiZcfuZF6Mb5gtygmXzOve1p
         S9DwlxQlUmpE1+yF/BSiHdXgjT3h8SUH6y9FXCczsVY5AtW/oFDsYGdxt/hGkq6byqRl
         YYxbZA2kxFJVKxkNuhTmcriWC1wDFG/5JXJhqjI53cdCosEdceJX/3pTpFt6inxbjTNm
         hq88ecZa2YoeTff7qp6Bfg5FfyU5v37HuaMcy9XKKxD8ckIs3VnHxDOAwCt21ldmL2ak
         Cm4Q==
X-Gm-Message-State: ANoB5pmrZpcpfVFk9d8z2lbwQInAN83gqljKDSi0hh3RzdxqTQPvKomn
        jWkWblQCt7PfMbOOETCDWvkl662EGFh9wbx5pihXUUaB
X-Google-Smtp-Source: AA0mqf7Gk0YnBEsh+97aXLYKTsvWsgV77dkdZ74N3EMA9AiXwPw0bflciPXN9PRyDOvWldvhUJrh0Bmn6ThIPpVJfUc=
X-Received: by 2002:a05:6830:699b:b0:66e:7ba6:5e0f with SMTP id
 cy27-20020a056830699b00b0066e7ba65e0fmr15750720otb.312.1670810602679; Sun, 11
 Dec 2022 18:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20221207040904.582585-1-gch981213@gmail.com> <20221207040904.582585-3-gch981213@gmail.com>
 <dc0254dc-ef1b-d5fb-163e-281c725a3dcd@linaro.org>
In-Reply-To: <dc0254dc-ef1b-d5fb-163e-281c725a3dcd@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 12 Dec 2022 10:03:11 +0800
Message-ID: <CAJsYDVLEFtVeCJBVo5Km4+Msdt=A1H4LZnRnqueqgqgnUhLs+A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b
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

On Thu, Dec 8, 2022 at 3:52 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/12/2022 05:09, Chuanhong Guo wrote:
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
>
> Hmm, maybe we should add more colors the "color" property, like
> LED_COLOR_ID_GRB, LED_COLOR_ID_BRG, LED_COLOR_ID_BGR?

Considering the existence of RGBW LEDs, this approach means adding
30 more COLOR_IDs. I think that's too many entries and is inconvenient
to parse in code.

> Rest look ok for me. If there is going to be resend, drop redundant "dt
> schema for" from the subject.

OK.

-- 
Regards,
Chuanhong Guo
