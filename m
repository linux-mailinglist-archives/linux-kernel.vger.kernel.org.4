Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D326A19BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBXKO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXKO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:14:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C138B212B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:14:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bo30so12804471wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbUl19QaI2MTwdUrhdIuA9jlAlPxj68Zbo9QqpZ6MZs=;
        b=AHvv78M2GFssy8AjEHgNmKwbkJVMRO0qlBi8RAeO1eXmGJncwZk1L4vMZBb14vojVG
         dlKRQCOFuGgQX6ge88fuqAJivb5ulqXnu+ZZOARJxze1wuV3DrdNKZEWeWosozp6i5/T
         OIxykXWK5DJ3qEJDlXbVtkc3Xg48+M3M7T/x9JnmFs/nadkAmy0teA0KxR+F8GiQTezW
         txGXJ3gk5qGxWlzT9vkRLvU86mIhfq8I3GcY17ao29znqkZPYWBmeHBwaM/0H7xk9qlb
         FTQNzltsIOtZkCOa5QfC+LnI9SxB5qTd5Y/4O2bNLeoIH5g3oRC59wKiT+dLhtrU42+4
         K8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbUl19QaI2MTwdUrhdIuA9jlAlPxj68Zbo9QqpZ6MZs=;
        b=QbfkdFUJn7r9GgMHFvxytoleMprO2Z6cnCpDCAZGap5yI+6WI7bBx7OnHZ5DQsygP4
         OzxFcBAnR1zoKu22R0gjiAqK1NItKuJ3tjmE8oReYsiC1VnZJSrZJm1ymuMRkmnWi9FV
         1E5qw0vy7kAtEWFFG/nP+z8Wgj70RTB9UI+OyWEcJTsILmtNvV/8pSmClYHGb6u+Qhai
         EvpvYZsuzIZxjymUBBjTHTNgBMiqcyBihB4/4I40hF89rZAUUilFBOuCGEFlND3HQykr
         D+TxInk49KjoJ1V6FLKUQsdmHiJmwFxX47ppbVLxrsuBq/Hxi2esGglWs+F14p72qq+U
         x1mw==
X-Gm-Message-State: AO0yUKWx1QnCiWp12OLcQ0Y+TMN23wG3kEoQjMAgDfTkgWpP/P6ExEW/
        8UlxWSM9JkTRmx9V0+wesYlgQA==
X-Google-Smtp-Source: AK7set8+PqfcO3Mjd7r2mdL81iBap0HGy13b0o4pGpIqGzfvhhb5z/dTRb5CNVMum7bDbU1X9OCmsA==
X-Received: by 2002:adf:e445:0:b0:2c5:48ed:d258 with SMTP id t5-20020adfe445000000b002c548edd258mr12843518wrm.35.1677233661185;
        Fri, 24 Feb 2023 02:14:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z3-20020adff1c3000000b002c559def236sm10605070wro.57.2023.02.24.02.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:14:20 -0800 (PST)
Message-ID: <ee0910b0-e2dd-3746-82c7-e377ff0ed3cf@linaro.org>
Date:   Fri, 24 Feb 2023 11:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: MFD: Convert STMPE to YAML schema
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Marek Vasut <marex@denx.de>,
        Philippe Schenker <philippe.schenker@toradex.com>
References: <20230221102605.2007396-1-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221102605.2007396-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 11:26, Linus Walleij wrote:
> This converts the STMPE MFD device tree bindings to the YAML
> schema.
> 
> Reference the existing schema for the ADC, just define the
> other subnode schemas directly in the MFD schema.
> 
> Add two examples so we have examples covering both the simple
> GPIO expander and the more complex with ADC and touchscreen.
> 
> Some in-tree users do not follow the naming conventions for nodes
> so these DTS files need to be augmented to use proper node names
> like "adc", "pwm", "gpio", "keyboard-controller" etc before the
> bindings take effect on them.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Philippe Schenker <philippe.schenker@toradex.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I chose to keep the IIO ADC separate YAML file, and contain the
> rest in the MFD YAML file.
> 
> I can pull the IIO ADC it into the MFD YAML file, I can push out
> sub-YAML files per compatible, happy to do it any way you folks
> like, just tell me what to do.
> ---
>  .../bindings/input/stmpe-keypad.txt           |  41 ---
>  .../bindings/input/touchscreen/stmpe.txt      | 108 ------
>  .../devicetree/bindings/mfd/st,stmpe.yaml     | 344 ++++++++++++++++++
>  .../devicetree/bindings/mfd/stmpe.txt         |  42 ---
>  4 files changed, 344 insertions(+), 191 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/stmpe-keypad.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stmpe.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stmpe.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/stmpe-keypad.txt b/Documentation/devicetree/bindings/input/stmpe-keypad.txt
> deleted file mode 100644
> index 12bb771d66d4..000000000000
> --- a/Documentation/devicetree/bindings/input/stmpe-keypad.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -* STMPE Keypad
> -
> -Required properties:
> - - compatible               : "st,stmpe-keypad"
> - - linux,keymap             : See ./matrix-keymap.txt
> -
> -Optional properties:
> - - debounce-interval        : Debouncing interval time in milliseconds
> - - st,scan-count            : Scanning cycles elapsed before key data is updated
> - - st,no-autorepeat         : If specified device will not autorepeat
> - - keypad,num-rows          : See ./matrix-keymap.txt
> - - keypad,num-columns       : See ./matrix-keymap.txt
> -
> -Example:
> -
> -	stmpe_keypad {
> -		compatible = "st,stmpe-keypad";
> -
> -		debounce-interval = <64>;
> -		st,scan-count = <8>;
> -		st,no-autorepeat;
> -
> -		linux,keymap = <0x205006b
> -				0x4010074
> -				0x3050072
> -				0x1030004
> -				0x502006a
> -				0x500000a
> -				0x5008b
> -				0x706001c
> -				0x405000b
> -				0x6070003
> -				0x3040067
> -				0x303006c
> -				0x60400e7
> -				0x602009e
> -				0x4020073
> -				0x5050002
> -				0x4030069
> -				0x3020008>;
> -	};
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> deleted file mode 100644
> index 238b51555c04..000000000000
> --- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> +++ /dev/null
> @@ -1,108 +0,0 @@
> -STMPE Touchscreen
> -----------------
> -
> -Required properties:
> - - compatible: "st,stmpe-ts"
> -
> -Optional properties:
> -- st,ave-ctrl		: Sample average control
> -				0 -> 1 sample
> -				1 -> 2 samples
> -				2 -> 4 samples
> -				3 -> 8 samples
> -- st,touch-det-delay	: Touch detect interrupt delay (recommended is 3)
> -				0 -> 10 us
> -				1 -> 50 us
> -				2 -> 100 us
> -				3 -> 500 us
> -				4 -> 1 ms
> -				5 -> 5 ms
> -				6 -> 10 ms
> -				7 -> 50 ms
> -- st,settling		: Panel driver settling time (recommended is 2)
> -				0 -> 10 us
> -				1 -> 100 us
> -				2 -> 500 us
> -				3 -> 1 ms
> -				4 -> 5 ms
> -				5 -> 10 ms
> -				6 -> 50 ms
> -				7 -> 100 ms
> -- st,fraction-z		: Length of the fractional part in z (recommended is 7)
> -			  (fraction-z ([0..7]) = Count of the fractional part)
> -- st,i-drive		: current limit value of the touchscreen drivers
> -				0 -> 20 mA (typical 35mA max)
> -				1 -> 50 mA (typical 80 mA max)
> -
> -Optional properties common with MFD (deprecated):
> - - st,sample-time	: ADC conversion time in number of clock.
> -				0 -> 36 clocks
> -				1 -> 44 clocks
> -				2 -> 56 clocks
> -				3 -> 64 clocks
> -				4 -> 80 clocks (recommended)
> -				5 -> 96 clocks
> -				6 -> 124 clocks
> - - st,mod-12b		: ADC Bit mode
> -				0 -> 10bit ADC
> -				1 -> 12bit ADC
> - - st,ref-sel		: ADC reference source
> -				0 -> internal
> -				1 -> external
> - - st,adc-freq		: ADC Clock speed
> -				0 -> 1.625 MHz
> -				1 -> 3.25 MHz
> -				2 || 3 -> 6.5 MHz
> -
> -Node should be child node of stmpe node to which it belongs.
> -
> -Note that common ADC settings of stmpe_touchscreen (child) will take precedence
> -over the settings done in MFD.
> -
> -Example:
> -
> -stmpe811@41 {
> -	compatible = "st,stmpe811";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_touch_int>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	reg = <0x41>;
> -	interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> -	interrupt-parent = <&gpio4>;
> -	interrupt-controller;
> -	id = <0>;
> -	blocks = <0x5>;
> -	irq-trigger = <0x1>;
> -	/* Common ADC settings */
> -	/* 3.25 MHz ADC clock speed */
> -	st,adc-freq = <1>;
> -	/* 12-bit ADC */
> -	st,mod-12b = <1>;
> -	/* internal ADC reference */
> -	st,ref-sel = <0>;
> -	/* ADC converstion time: 80 clocks */
> -	st,sample-time = <4>;
> -
> -	stmpe_touchscreen {
> -		compatible = "st,stmpe-ts";
> -		reg = <0>;
> -		/* 8 sample average control */
> -		st,ave-ctrl = <3>;
> -		/* 5 ms touch detect interrupt delay */
> -		st,touch-det-delay = <5>;
> -		/* 1 ms panel driver settling time */
> -		st,settling = <3>;
> -		/* 7 length fractional part in z */
> -		st,fraction-z = <7>;
> -		/*
> -		 * 50 mA typical 80 mA max touchscreen drivers
> -		 * current limit value
> -		 */
> -		st,i-drive = <1>;
> -	};
> -	stmpe_adc {
> -		compatible = "st,stmpe-adc";
> -		st,norequest-mask = <0x0F>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/st,stmpe.yaml b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
> new file mode 100644
> index 000000000000..57ae1882c829
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
> @@ -0,0 +1,344 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectonics Port Expander (STMPE)
> +
> +description: STMicroelectronics Port Expander (STMPE) is a series of slow

New line after description:

> +  bus controllers for various expanded peripherals such as GPIO, keypad,
> +  touchscreen, ADC, PWM or rotator. It can contain one or several different
> +  peripherals connected to SPI or I2C.
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: '^stmpe[0-9]+@[0-9a-f]+$'

We do not enforce naming in particular bindings, but only in common
ones. stmpe isn't a generic name either, thus drop nodename and pattern.

> +
> +  compatible:
> +    enum:
> +      - st,stmpe601
> +      - st,stmpe801
> +      - st,stmpe811
> +      - st,stmpe1600
> +      - st,stmpe1601
> +      - st,stmpe2401
> +      - st,stmpe2403
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vcc-supply: true
> +
> +  vio-supply: true
> +
> +  reset-gpios: true

You need maxItems

> +
> +  wakeup-source:
> +    description: If present, interrupts from the expander can wake up the system

"wakeup-source: true" is enough, it's a generic property


> +
> +  st,autosleep-timeout:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 4, 16, 32, 64, 128, 256, 512, 1024 ]
> +    description: Time idle before going to automatic sleep to save power
> +
> +  st,sample-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3, 4, 5, 6 ]
> +    description: |
> +      Sample time per iteration
> +      0 = 36 clock ticks
> +      1 = 44 clock ticks
> +      2 = 56 clock ticks
> +      3 = 64 clock ticks
> +      4 = 80 clock ticks - recommended
> +      5 = 96 clock ticks
> +      6 = 124 clock ticks
> +
> +  st,mod-12b:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description: ADC bit mode 0 = 10bit ADC, 1 = 12bit ADC
> +
> +  st,ref-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description: ADC reference source 0 = internal, 1 = external
> +
> +  st,adc-freq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3 ]
> +    description: |
> +      ADC clock speed
> +      0 = 1.625 MHz
> +      1 = 3.25 MHz
> +      2, 3 = 6.5 MHz
> +
> +  adc:
> +    type: object
> +    $ref: /schemas/iio/adc/st,stmpe-adc.yaml#
> +
> +  gpio:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: st,stmpe-gpio

This compatible and entire gpio is missing in old bindings. I propose to
split this and gpio-related example to a separate patch.

> +
> +      "#gpio-cells":
> +        const: 2
> +
> +      "#interrupt-cells":
> +        const: 2
> +
> +      gpio-controller: true
> +
> +      interrupt-controller: true
> +
> +      st,norequest-mask:
> +        description: A bitmask of GPIO lines that cannot be requested because for
> +          for example not being connected to anything on the system
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    patternProperties:
> +      "^.+-hog(-[0-9]+)?$":
> +        type: object
> +
> +        properties:
> +          gpio-hog: true
> +          gpios: true
> +          input: true
> +          output-high: true
> +          output-low: true
> +          line-name: true
> +
> +        required:
> +          - gpio-hog
> +          - gpios
> +
> +    additionalProperties: false

It's more readable if in such code the additionalProperties:" is next to
type/ref before properties.

> +
> +    required:
> +      - compatible
> +      - "#gpio-cells"
> +      - "#interrupt-cells"
> +      - gpio-controller
> +      - interrupt-controller
> +
> +  keyboard-controller:
> +    type: object
> +    $ref: /schemas/input/matrix-keymap.yaml#
> +
> +    properties:
> +      compatible:
> +        const: st,stmpe-keypad
> +
> +      debounce-interval:
> +        description: Debouncing interval in milliseconds
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      st,no-autorepeat:
> +        description: If present, the keys will not autorepeat when pressed
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      st,scan-count:
> +        description: Scanning cycles elapsed before key data is updated
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    unevaluatedProperties: false

It's more readable if in such code the unevaluatedProperties:" is next
to type/ref before properties.

> +
> +    required:
> +      - compatible
> +      - linux,keymap
> +
> +  pwm:
> +    type: object
> +    $ref: /schemas/pwm/pwm.yaml#
> +
> +    properties:
> +      compatible:
> +        const: st,stmpe-pwm
> +
> +    unevaluatedProperties: false

Same here and in other places with indentation (so not the top level
additional/unevaluatedProp)

> +
> +    required:
> +      - compatible
> +      - "#pwm-cells"
> +
> +  touchscreen:
> +    type: object
> +    $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +    properties:
> +      compatible:
> +        const: st,stmpe-ts
> +
> +      st,ave-ctrl:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1, 2, 3 ]
> +        description: |
> +          Sample average control
> +          0 = 1 sample
> +          1 = 2 samples
> +          2 = 4 samples
> +          3 = 8 samples
> +
> +      st,touch-det-delay:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> +        description: |
> +          Touch detection delay
> +          0 = 10 us
> +          1 = 50 us
> +          2 = 100 us
> +          3 = 500 us - recommended
> +          4 = 1 ms
> +          5 = 5 ms
> +          6 = 10 ms
> +          7 = 50 ms
> +
> +      st,settling:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> +        description: |
> +          Panel driver settling time
> +          0 = 10 us
> +          1 = 100 us
> +          2 = 500 us - recommended
> +          3 = 1 ms
> +          4 = 5 ms
> +          5 = 10 ms
> +          6 = 50 ms
> +          7 = 100 ms
> +
> +      st,fraction-z:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> +        description: Length of the fractional part in z, recommended is 7
> +          (fraction-z ([0..7]) = Count of the fractional part)
> +
> +      st,i-drive:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [ 0, 1 ]
> +        description: |
> +          current limit value of the touchscreen drivers
> +          0 = 20 mA (typical 35 mA max)
> +          1 = 50 mA (typical 80 mA max)
> +
> +    unevaluatedProperties: false
> +
> +    required:
> +      - compatible
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

Aren't children also required? I mean, logically, not according to old
bindings.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/input.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      stmpe2401@43 {

Node name should be generic... which I don't know which one could it be
(port-expander?), so at least let's drop model number at least - stmpe@.

> +        compatible = "st,stmpe2401";
> +        reg = <0x43>;
> +        reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
> +        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> +        interrupt-parent = <&gpio>;
> +        vcc-supply = <&db8500_vsmps2_reg>;
> +        vio-supply = <&db8500_vsmps2_reg>;
> +        wakeup-source;
> +        st,autosleep-timeout = <1024>;
> +
> +        gpio {
> +          compatible = "st,stmpe-gpio";
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          interrupt-controller;
> +          #interrupt-cells = <2>;
> +          st,norequest-mask = <0xf0f002>;
> +        };
> +
> +        keyboard-controller {
> +          compatible = "st,stmpe-keypad";
> +          debounce-interval = <64>;
> +          st,scan-count = <8>;
> +          st,no-autorepeat;
> +          keypad,num-rows = <8>;
> +          keypad,num-columns = <8>;
> +          linux,keymap = <
> +              MATRIX_KEY(0x00, 0x00, KEY_1)
> +              MATRIX_KEY(0x00, 0x01, KEY_2)
> +              MATRIX_KEY(0x00, 0x02, KEY_3)
> +              MATRIX_KEY(0x00, 0x03, KEY_4)
> +              MATRIX_KEY(0x00, 0x04, KEY_5)
> +              MATRIX_KEY(0x00, 0x05, KEY_6)
> +              MATRIX_KEY(0x00, 0x06, KEY_7)
> +              MATRIX_KEY(0x00, 0x07, KEY_8)
> +              MATRIX_KEY(0x00, 0x08, KEY_9)
> +              MATRIX_KEY(0x00, 0x09, KEY_0)
> +          >;
> +        };
> +
> +        pwm {
> +          compatible = "st,stmpe-pwm";
> +          #pwm-cells = <2>;
> +        };
> +      };
> +
> +      stmpe811@41 {

Here as well

> +        compatible = "st,stmpe811";
> +        reg = <0x41>;
> +        interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-parent = <&gpio>;
> +        st,adc-freq = <1>;
> +        st,mod-12b = <1>;
> +        st,ref-sel = <0>;
> +        st,sample-time = <4>;
> +
> +        adc {
> +          compatible = "st,stmpe-adc";
> +          st,norequest-mask = <0x0F>;

lowercase hex, so 0x0f



Best regards,
Krzysztof

