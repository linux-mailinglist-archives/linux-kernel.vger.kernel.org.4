Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BEC5BBF4D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIRS3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 14:29:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD7D101EA;
        Sun, 18 Sep 2022 11:29:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so10240721lfu.0;
        Sun, 18 Sep 2022 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WA3909OkPlGQ2DqJkniN7gPfMblXDPfE9yZdpVr0YiU=;
        b=ole8W+krjxvE9MZCDv41ZKiVanU59Kf76tIKgueiSoEVqzSG9ue6OqZnFslBFG+qFj
         r0yW6jG+/RO6FjDNuixVeXWEtC6vJZPgt6UpdFvrlZGnw/W3cNduGBuR7XjS+vxUL747
         kH6t4c2rPE2NWmxLQfkyPCsVk2LVZhiTdKm7S3SmVbzSfhth5ePNhoHqa/CuBKc8AlUr
         duZ1dj3BNq0oSb7FL+PVc6KX6rpvskIBJq+ZK6whvlGJk+zDQB/sUzbSaU2iQ6rhUrMM
         uXEoOIMlDqv93Bz8cPjM+uuLmIWHNG8E3+nvlqQI9U6pvKxFM4rmo9OtP6S6wYplIGx6
         EoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WA3909OkPlGQ2DqJkniN7gPfMblXDPfE9yZdpVr0YiU=;
        b=lSIB7QOH/D7lt/FTIwWwsBFhxGjn/TrNUbl64u56CLqLJQd2n46ypa0aLclK00aava
         ieN1f7iClVHYF9A/Itv4/DQKafXzl5qeiHT5F3d79KOft9m7TtDAmNFtdiO0Gv5sgBmq
         d+xkXzcURBcSr27gvLua4DbDv2fp154co9OQz2vEJJKqnkB7grERU9EL/vfqamE/B2gg
         dKnJrt9d6ktdjhspEqp3t9ZA5q4Gw949GQh2AkubWWVq4NkarqYercz+5B8Wm4wrqgzM
         69KErcjCt5SndkOeFWwK8tFqnb4I3tPEOl+GT5dxcWJi527dd7227OndEfuxTBknN31o
         aFqg==
X-Gm-Message-State: ACrzQf2OfU2zgRCOsG6xsXLYEtzY5NSsH8Xv+9O6jR3Z3D73J8Q5um6S
        pfTtkv5USmthv2hTHLJVuuKKvzxMfLg4W4txK7o=
X-Google-Smtp-Source: AMsMyM5ZhObwU1v6wtX7DkaBvz8M9Gqw0K7XRrt7OcA3paEWSzLhcYG167feZG7HisdunSOAsJoDLRBbmqX3I68trH8=
X-Received: by 2002:a05:6512:eaa:b0:497:a1ed:6fa5 with SMTP id
 bi42-20020a0565120eaa00b00497a1ed6fa5mr4728843lfb.108.1663525749385; Sun, 18
 Sep 2022 11:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220714122322.63663-1-tmaimon77@gmail.com> <20220714122322.63663-2-tmaimon77@gmail.com>
 <20220718211046.GA3547663-robh@kernel.org>
In-Reply-To: <20220718211046.GA3547663-robh@kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 18 Sep 2022 21:28:57 +0300
Message-ID: <CAP6Zq1hQ5m2kkQOKaYsKhPQhCW+vdsdyPRxxb_yRGMB=gJCPdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

Hi Rob,

Thanks for your comment and sorry for the late reply.

On Tue, 19 Jul 2022 at 00:10, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 03:23:21PM +0300, Tomer Maimon wrote:
> > Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> > pinmux and GPIO controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 213 ++++++++++++++++++
> >  1 file changed, 213 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..104766f7acc5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> > @@ -0,0 +1,213 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/nuvoton,npcm845-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM845 Pin Controller and GPIO
> > +
> > +maintainers:
> > +  - Tomer Maimon <tmaimon77@gmail.com>
> > +
> > +description:
> > +  The Nuvoton BMC NPCM8XX Pin Controller multi-function routed through
> > +  the multiplexing block, Each pin supports GPIO functionality (GPIOx)
> > +  and multiple functions that directly connect the pin to different
> > +  hardware blocks.
> > +
> > +properties:
> > +  compatible:
> > +    const: nuvoton,npcm845-pinctrl
> > +
> > +  ranges:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +  nuvoton,sysgcr:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: a phandle to access GCR registers.
> > +
> > +patternProperties:
> > +  "^gpio@":
> > +    type: object
> > +
> > +    description:
> > +      Eight GPIO banks that each contain between 32 GPIOs.
>
> 'each contain between 32'?
will be fixed net version.
>
> > +
> > +    properties:
> > +      gpio-controller: true
> > +
> > +      '#gpio-cells':
> > +        const: 2
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      gpio-ranges:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - gpio-controller
> > +      - '#gpio-cells'
> > +      - reg
> > +      - interrupts
> > +      - gpio-ranges
> > +
> > +  "-mux":
>
> '-mux$'? Something like 'foo-muxbar' is needed?
No.
>
> > +    $ref: pinmux-node.yaml#
> > +
> > +    properties:
> > +      groups:
> > +        description:
> > +          One or more groups of pins to mux to a certain function
> > +        items:
> > +          enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> > +                  smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
> > +                  smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> > +                  smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
> > +                  spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> > +                  bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
> > +                  rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
> > +                  fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
> > +                  fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
> > +                  r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
> > +                  rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
> > +                  smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
> > +                  smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
> > +                  pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
> > +                  serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
> > +                  spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
> > +                  smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
> > +                  smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
> > +                  hgpio4, hgpio5, hgpio6, hgpio7 ]
> > +
> > +      function:
> > +        description:
> > +          The function that a group of pins is muxed to
> > +        enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> > +                smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
> > +                smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> > +                smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
> > +                spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> > +                bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
> > +                rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
> > +                fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
> > +                fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
> > +                r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
> > +                rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
> > +                smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
> > +                smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
> > +                pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
> > +                serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
> > +                spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
> > +                smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
> > +                smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
> > +                hgpio4, hgpio5, hgpio6, hgpio7 ]
> > +
> > +    dependencies:
> > +      groups: [ function ]
> > +      function: [ groups ]
> > +
> > +    additionalProperties: false
> > +
> > +  "^pin":
> > +    $ref: pincfg-node.yaml#
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          A list of pins to configure in certain ways, such as enabling
> > +          debouncing
> > +
> > +      bias-disable: true
> > +
> > +      bias-pull-up: true
> > +
> > +      bias-pull-down: true
> > +
> > +      input-enable: true
> > +
> > +      output-low: true
> > +
> > +      output-high: true
> > +
> > +      drive-push-pull: true
> > +
> > +      drive-open-drain: true
> > +
> > +      input-debounce:
> > +        description:
> > +          Debouncing periods in microseconds, one period per interrupt
> > +          bank found in the controller
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        minItems: 1
> > +        maxItems: 4
> > +
> > +      slew-rate:
> > +        description: |
> > +          0: Low rate
> > +          1: High rate
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1]
> > +
> > +      drive-strength:
> > +        enum: [ 0, 1, 2, 4, 8, 12 ]
> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: "pinctrl.yaml#"
> > +
> > +required:
> > +  - compatible
> > +  - ranges
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - nuvoton,sysgcr
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pinctrl: pinctrl@f0800000 {
> > +        compatible = "nuvoton,npcm845-pinctrl";
> > +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        nuvoton,sysgcr = <&gcr>;
> > +
> > +        gpio0: gpio@f0010000 {
>
> gpio@0
>
> Is this really a child block of the pinctrl? Doesn't really look like it
> based on addressess. Where are the pinctrl registers? In the sysgcr? If
> so, then pinctrl should be a child of it. But that doesn't really work
> too well with gpio child nodes...
the pin controller mux is handled by sysgcr this is why the sysgcr in
the mother node,
and the pin configuration are handled by the GPIO registers.  each
GPIO bank (child) contains 32 GPIO.
this is why the GPIO is the child node.

>
> Rob

Best regards,

Tomer
