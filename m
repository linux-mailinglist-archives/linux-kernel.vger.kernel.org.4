Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39199677AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjAWMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAWMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:32:47 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A649CDE3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:32:40 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 129so10534626ybb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R8T1jPM/gZgaNDOsqPWGTlzcSbw367FhJ0Qeor6Jjno=;
        b=yVgPrWbZdTWvkkk+B76/9df19Ieewi6zyL+iZgBgZSvan9oQGLlBPE9FnPQ9ai5Z/R
         H/1dUgOFgUnxQprS9Djlhi2E+tHUEqfUBfvjIVYBgx9A1Ls8DB63wvTT9mz6/n725Zvq
         xt9AWlJ3CEE+UfukrQ9LCKksXGmaHmgsLW5KlFgJa+IxqMYA1NzRzDETy5teQUn5EVRz
         660Bj7uoxW3gIUmOG0QJxyLFYL4/omn4OkZ7nnxxJRC1pJZoGczfAcFOxoQbQ7csxoml
         Tjhd5jxlY0HBLcgYGaU4gtB54I7JRKXsIRXW2rvD1q90vkHvZbLMfftEkvRucQfciCCG
         vtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8T1jPM/gZgaNDOsqPWGTlzcSbw367FhJ0Qeor6Jjno=;
        b=aqO9Zfk13VSv8NxcBvUGLZn/PIYpGOQLEuLV6EUDa45zTief05PBsQhoW5jSWiBqak
         kC0wl56/ws4DUByx4gPpOE3193yFYZm3NQ66JyP5mMPr4t1wWsXQnfzlADPUX9ucld17
         063O4D+umV9x6+GK/3awD1TgQXvP3wCZV6p5sMSuaL3A0/5D5I5EOqdg+QGfkK1raCH5
         KCJspyC+SeLDBIi9ObhAjhNNpvJmiWmVjNRF5G8I4SQQHM4jqKJ1l8BiMQG/B0eZxA7y
         aT/07l4w7VEK8zn5+mnQvAqFieliLkj0Cca7M1BkZ90fvET+nWoFdnPPJUfI6sHznTSH
         WZ6Q==
X-Gm-Message-State: AFqh2kogBJ2/CbNNHPF7QaTArt+weJLGB+nOFawjGIjrnf4DaJvSKXjh
        /oy5VtSOo+7vmO9u3jdJerSUwtzyn2klCXGYzFM+RA==
X-Google-Smtp-Source: AMrXdXvKOSR+H/FAHIcCG0YsxHg5bNdxrOz/H8AkNI5S4zmd20QWuQr0f258SIrUHPpWWzqLuQ/KvbQ15mRQPalYvHQ=
X-Received: by 2002:a25:9d88:0:b0:7c0:acd2:6300 with SMTP id
 v8-20020a259d88000000b007c0acd26300mr2278897ybp.520.1674477159739; Mon, 23
 Jan 2023 04:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20230123073305.149940-1-lchen@ambarella.com> <20230123073305.149940-14-lchen@ambarella.com>
In-Reply-To: <20230123073305.149940-14-lchen@ambarella.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Jan 2023 13:32:28 +0100
Message-ID: <CACRpkdYVGv=YM6cvtXVxNW42uM+dW_Zv-BkrDyMX+DB73w=2nA@mail.gmail.com>
Subject: Re: [PATCH 13/15] dt-bindings: pinctrl: add support for Ambarella
To:     Li Chen <lchen@ambarella.com>
Cc:     Li Chen <me@linux.beauty>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

thanks for your patch!

It's nice to see Ambarella working with the kernel community.

On Mon, Jan 23, 2023 at 8:41 AM Li Chen <lchen@ambarella.com> wrote:

> +properties:
> +  compatible:
> +    items:
> +      - const: ambarella,pinctrl

I bet there will be more instances of pin controllers from Ambarella, so I would
use this only as a fallback, so the for should likely be:

compatible = "ambarella,<soc-name>-pinctrl", "ambarella,pinctrl";

we need to establish this already otherwise "ambarella,pinctrl" just becomes
the "weird name of the first ambarella SoC supported by standard DT bindings".

> +  amb,pull-regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 1
> +
> +  amb,ds-regmap:
> +    items:
> +      maxItems: 1

Interesting that these registers are elsewhere, but I bet there is an
engineering
explanation for this :)

> +    properties:
> +      amb,pinmux-ids:
> +        description: |
> +          an integer array. Each integer in the array specifies a pin
> +          with given mux function, with pin id and mux packed as:
> +          mux << 12 | pin id
> +          Here mux means function of this pin, and pin id is identical to gpio id. For
> +          the SoC supporting IOMUX, like S2L, the maximal value of mux is 5. However,
> +          for the SoC not supporting IOMUX, like A5S, S2, the third or fourth function
> +          is selected by other "virtual pins" setting. Here the "virtual pins" means
> +          there is no real hardware pins mapping to the corresponding register address.
> +          So the registers for the "virtual pins" can be used for the selection of 3rd
> +          or 4th function for other real pins.

I think you can use the standard bindings for this if you insist on
using the "magic
numbers" scheme.

(I prefer function names and group names as strings, but I gave up on trying
to convince the world to use this because people have so strong opions about
it.)

From Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml:

  pinmux:
    description:
      The list of numeric pin ids and their mux settings that properties in the
      node apply to (either this, "pins" or "groups" have to be specified)
    $ref: /schemas/types.yaml#/definitions/uint32-array

> +      amb,pinconf-ids:
> +        description: |
> +          an integer array. Each integer in the array specifies a pin
> +          with given configuration, with pin id and config packed as:
> +            config << 16 | pin id
> +          Here config is used to configure pull up/down and drive strength of the pin,
> +          and it's orgnization is:
> +          bit1~0: 00: pull down, 01: pull up, 1x: clear pull up/down
> +          bit2:   reserved
> +          bit3:   0: leave pull up/down as default value, 1: config pull up/down
> +          bit5~4: drive strength value, 0: 2mA, 1: 4mA, 2: 8mA, 3: 12mA
> +          bit6:   reserved
> +          bit7:   0: leave drive strength as default value, 1: config drive strength

I would be very happy if I could convince you to use the standard (string)
bindings for this.
And from Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml

For each config node this means using strings such as
bias-high-impedance; etc in the device tree pin config node.

Following that scheme just makes life so much easier for maintainers and
reviewers: very few people reviewing or debugging the system will think
it is easy to read a magic number and then (in their head) mask out the
bits to see that "OK this is drive strength 8mA" and then have energy and
memory enough in their head to remember that "wait a minute, that is supposed
to be 12mA in this design", leading to long review and development
cycles.

By using:

drive-push-pull;
drive-strength = <8>;

you make the cognitive load on the people reading the device tree much
lower and easier to write, maintain and debug for humans.

The tendency to encode this info in terse bitfields appear to be done for either
of these reasons:

- Footprint / memory usage
- Adopt the users to the way the machine thinks instead of the other way around
- "We always did it this way"

Neither is a very good argument on a new 64bit platform.

Yours,
Linus Walleij
