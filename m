Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5B5F09DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiI3LTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiI3LSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:18:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C5F3C4F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:05:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s6so6323505lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9ll5pHMsJ8tKJURyddmBsK9L9XIPWok5Aa/Yo0y7G9o=;
        b=bWSc0euuBQjtQHfEF4jPJATO0b3m8bdoJPtyuaLITvQNYrBOZ5NJhsZr8P4xirJbzR
         TN45kqwU+vcHT7CgLYNLpz4mT8daLzDU8AQ2GpAO1zaa9NXyxSPa931+OPnd1cfYy9Vw
         BmLHyN3kPn6OIhIM86zLBpOgPbEJyFJ3qLYai2ZsZzMOCnOlWCHR484AQ+pgTvpJH05D
         ELaOgQJ8QxxYRrsWY+cpTVpBIgcxAEicZk2PQ/HMgjhRjBsMt6a6mMrlIHSfEyi4IipM
         QHLTCR6ZkX/Iy94ZhDinlwYGD3M6LuhjPqbgZbQjTMDeriU/I/QIafWxd2KOeraa5nMV
         MROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9ll5pHMsJ8tKJURyddmBsK9L9XIPWok5Aa/Yo0y7G9o=;
        b=pz0Ep9t/Mvl1yJCDZjEHk5cYPjFrHd2ELDBG84aT/NY9v4TfFunVu9xqyqmeuPc14H
         B00m6/4irflCFUvIqLA7+fEIGg/N5vI+glxhozx/aLvr+D9Sz5nDC0HLbPwnmYnMozM1
         L1gARPIR2v9++osG6iUDBSJt1QhPvUrcm+eHr8hgJScjoBVvmMtSuTXX9586s22QsiWp
         EghChQpgPbJ1dx+Do4spQK1S3hBn57qfuvZXDq14AAQWA2aicOqHcUuZ/tLrWpKwjGAO
         2Y5ePac2yW1wqVvQaoxT8X1FpJ6VsTyuDQQoSTxt3Km3uixAkZi9LIdmZTSBy955bbUq
         0WHg==
X-Gm-Message-State: ACrzQf3ZQIMrp+Tj1AZgXHkI5yVhbgSUn32up/k4iPPpUiWUlwmPynPS
        vJW9UuCaA4AgVC428nQj4/4q9Q==
X-Google-Smtp-Source: AMsMyM66/ug4raBgYwsrLYolZgwV4AEp/u01LM/1o4GIZ90ynzZ2dP3MTZ1CNDVV0N0X98yz4VO+gA==
X-Received: by 2002:a05:6512:239c:b0:497:938e:2c99 with SMTP id c28-20020a056512239c00b00497938e2c99mr3051661lfv.416.1664535947056;
        Fri, 30 Sep 2022 04:05:47 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a05651222d600b00485caa0f5dfsm264133lfu.44.2022.09.30.04.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 04:05:46 -0700 (PDT)
Message-ID: <69aba4f3-43d8-17ab-9784-86a8cc0087b2@linaro.org>
Date:   Fri, 30 Sep 2022 13:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 25/30] dt-bindings: pinctrl: Add StarFive JH7110
 pinctrl bindings
Content-Language: en-US
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930073845.6309-1-hal.feng@linux.starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930073845.6309-1-hal.feng@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 09:38, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-pinctrl.yaml      | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml
> new file mode 100644
> index 000000000000..482012ad8a14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-pinctrl.yaml
> @@ -0,0 +1,202 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Pin Controller Device Tree Bindings
> +
> +description: |
> +  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
> +
> +maintainers:
> +  - Jianlong Huang <jianlong.huang@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +    - starfive,jh7110-sys-pinctrl
> +    - starfive,jh7110-aon-pinctrl

Wrong indentation.

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +
> +  reg:
> +    minItems: 2

No need.

> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: control

This does not match reg at all. Again - not tested.


> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +    description: The GPIO parent interrupt.
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  ngpios:
> +    enum:
> +    - 64
> +    - 4

Wrong indentation. Increasing order.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - "#gpio-cells"
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +patternProperties:

This goes before required block

> +  '-[0-9]+$':

Too loose pattern. Need some more specific pattern. What do you exactly
match here?

Missing description.

> +    type: object
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        description: |
> +          A pinctrl node should contain at least one subnode representing the
> +          pinctrl groups available on the machine. Each subnode will list the
> +          pins it needs, and how they should be configured, with regard to
> +          muxer configuration, system signal configuration, pin groups for
> +          vin/vout module, pin voltage, mux functions for output, mux functions
> +          for output enable, mux functions for input.
> +
> +        properties:
> +          starfive,pins:

No, use generic pinctrl bindings.

> +            description: |
> +              The list of pin identifiers that properties in the node apply to.
> +              This should be set using the PAD_GPIOX macros.
> +              This has to be specified.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 63
> +
> +          starfive,pinmux:

No, use generic pinctrl bindings.


> +            description: |
> +              The list of GPIOs and their mux functions that properties in the
> +              node apply to. This should be set using the PAD_GPIOX_FUNC_SEL
> +              macro with its value.
> +              This is optional for some pins.
> +              The value of PAD_GPIOX_FUNC_SEL macro can selects:
> +                0: GPIOX mux function 0,
> +                1: GPIOX mux function 1,
> +                2: GPIOX mux function 2.
> +
> +          starfive,pin-ioconfig:
> +            description: |
> +              This is used to configure the core settings of system signals.
> +              The combination of GPIO_IE or GPIO_DS or GPIO_PU or GPIO_PD or
> +              GPIO_SLEW or GPIO_SMT or GPIO_POS.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          starfive,padmux:
> +            description: |
> +              The padmux is for vin/vout module to select pin groups.
> +              0: vout will be set at pins from PAD_GPIO7 to PAD_GPIO34,
> +                 when PAD_GPIOX_FUNC_SEL is set as 1.
> +                 vin will be set at pins from PAD_GPIO6 to PAD_GPIO20.
> +                 when PAD_GPIOX_FUNC_SEL is set as 2.
> +              1: vout will be set at pins from PAD_GPIO36 to PAD_GPIO63,
> +                 when PAD_GPIOX_FUNC_SEL is set as 1.
> +                 vin will be set at pins from PAD_GPIO21 to PAD_GPIO35.
> +                 when PAD_GPIOX_FUNC_SEL is set as 2.
> +              2: vin will be set at pins from PAD_GPIO36 to PAD_GPIO50,
> +                 when PAD_GPIOX_FUNC_SEL is set as 2
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2]
> +
> +          starfive,pin-syscon:
> +            description: |
> +              This is used to set pin voltage,
> +              0: 3.3V, 1: 2.5V, 2: 1.8V.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2]
> +
> +          starfive,pin-gpio-dout:

No, use generic pinctrl bindings.


> +            description: |
> +              This is used to set their mux functions for output.
> +              This should be set using the GPO_XXX macro,
> +              such as GPO_LOW, GPO_UART0_SOUT.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 107
> +
> +          starfive,pin-gpio-doen:

No, use generic pinctrl bindings.


> +            description: |
> +              This is used to set their mux functions for output enable.
> +              This should be set using the OEN_XXX macro,
> +              such as OEN_LOW, OEN_I2C0_IC_CLK_OE.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 49
> +
> +          starfive,pin-gpio-din:

No, use generic pinctrl bindings.

> +            description: |
> +              This is used to set their mux functions for input.
> +              This should be set using the GPI_XXX macro,
> +              such as GPI_CAN0_CTRL_RXD, GPI_I2C0_IC_CLK_IN_A.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 90
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +additionalProperties: false

Missing allof to generic pinctrl bindings.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7110-sys.h>
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +    #include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> +
> +    gpio: gpio@13040000 {
> +      compatible = "starfive,jh7110-sys-pinctrl";
> +      reg = <0x0 0x13040000 0x0 0x10000>;
> +      reg-names = "control";
> +      clocks = <&clkgen JH7110_SYS_IOMUX_PCLK>;
> +      resets = <&rstgen RSTN_U0_SYS_IOMUX_PRESETN>;
> +      interrupts = <86>;
> +      interrupt-controller;
> +      #gpio-cells = <2>;
> +      ngpios = <64>;
> +      status = "okay";
> +
> +      uart0_pins: uart0-pins {

Explain me please how it can possible match your pattern: '-[0-9]+$':

You really wrote something which was not tested and cannot work.
> +        uart0-pins-tx {
> +          starfive,pins = <PAD_GPIO5>;
> +          starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_DS(3))>;
> +          starfive,pin-gpio-dout = <GPO_UART0_SOUT>;
> +          starfive,pin-gpio-doen = <OEN_LOW>;
> +        };
> +
> +        uart0-pins-rx {
> +          starfive,pins = <PAD_GPIO6>;
> +          starfive,pinmux = <PAD_GPIO6_FUNC_SEL 0>;
> +          starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_PU(1))>;
> +          starfive,pin-gpio-doen = <OEN_HIGH>;
> +          starfive,pin-gpio-din =  <GPI_UART0_SIN>;
> +        };
> +      };
> +    };
> +
> +    &uart0 {
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&uart0_pins>;
> +      status = "okay";

Drop, obvious.

> +    };
> +
> +...

Best regards,
Krzysztof

