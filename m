Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591676F09A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbjD0QQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0QQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:16:37 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E280D3585;
        Thu, 27 Apr 2023 09:16:35 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6a5f7d10dd5so6420772a34.0;
        Thu, 27 Apr 2023 09:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682612195; x=1685204195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpGI/IPMzlJSZJEMXDYjGQoB78K5TigUGVeI8dSNGfE=;
        b=ZfIlHYs9z2GNmrYirEd3hiGEdE/TAHdz9q5gO5NGzMSLUeUg4f80rUwCXaGX6spVmQ
         zCKQtMu9VAE4ISDwjXhOZACFFTNVo+WbOCXwixm3Evoja5RZYOBN+bdkA5OLJnV+vVck
         WRpbyKTyclGBAt/A7CgPgPOcVGaoAqRq5fo7GqM28zwiik6fZu6ETbsJx3tidePIVGck
         gwqT+fr9VQ3n4reBoV6iAcuJNA1IpgYXnY67ZbasV/didXLhB+ByGYtsheo+PHoXzKz/
         4g3QPHO8VFJVT/dikNo0ZQMhx4YDGnDM1Z7xBqgRwxnrfe+uk9qpm9DSJNdSUDmcbuQd
         MOLg==
X-Gm-Message-State: AC+VfDxbdkj+EgG/VMzOVbu4ON7izCzZCmR+ffif28xA6KztSHVIeRwe
        SJvlXTIFqk2YetLy8FmFhw==
X-Google-Smtp-Source: ACHHUZ5p4dmgEhC6CibBNs/xrzmnRqO5GgJt8tdZzPzR40ZXII5zIwDeSsUyT/gDhpnKcDGNhHWiqg==
X-Received: by 2002:a05:6830:13d7:b0:68b:cdc3:78d7 with SMTP id e23-20020a05683013d700b0068bcdc378d7mr1034013otq.8.1682612194993;
        Thu, 27 Apr 2023 09:16:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y20-20020a0568301d9400b006a643a2eeb5sm6299001oti.15.2023.04.27.09.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:16:34 -0700 (PDT)
Received: (nullmailer pid 3118384 invoked by uid 1000);
        Thu, 27 Apr 2023 16:16:33 -0000
Date:   Thu, 27 Apr 2023 11:16:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: MFD: Convert STMPE to YAML schema
Message-ID: <20230427161633.GA3112472-robh@kernel.org>
References: <20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org>
 <20230426-stmpe-dt-bindings-v2-2-2f85a1fffcda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426-stmpe-dt-bindings-v2-2-2f85a1fffcda@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 01:21:39PM +0200, Linus Walleij wrote:
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
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Split off the GPIO bindings to their own schema, as the old
>   bindings didn't even have any GPIO bindings. Put the GPIO
>   schema before this schema so we can use GPIO in the examples.
> - Drop nodename and pattern as STMPE is not a generic name.
> - Add maxItems to the resets.
> - Make wakeup-source just :true, as it is a generic property.
> - Move unevaluatedProperties for subnodes right before properties
>   as requested.
> - Name devices "port-expander" in the examples.
> - Use lowercase hex in line init.
> ---
>  .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
>  .../bindings/input/touchscreen/stmpe.txt           | 108 --------
>  .../devicetree/bindings/mfd/st,stmpe.yaml          | 298 +++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
>  4 files changed, 298 insertions(+), 191 deletions(-)

> diff --git a/Documentation/devicetree/bindings/mfd/st,stmpe.yaml b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
> new file mode 100644
> index 000000000000..dd24ae2d5fb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
> @@ -0,0 +1,298 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectonics Port Expander (STMPE)
> +
> +description: STMicroelectronics Port Expander (STMPE) is a series of slow
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
> +  reset-gpios:
> +    maxItems: 1
> +
> +  wakeup-source: true
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
> +    $ref: /schemas/gpio/st,stmpe-gpio.yaml#
> +
> +  keyboard-controller:
> +    type: object
> +    $ref: /schemas/input/matrix-keymap.yaml#
> +
> +    unevaluatedProperties: false
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
> +    required:
> +      - compatible
> +      - linux,keymap
> +
> +  pwm:
> +    type: object
> +    $ref: /schemas/pwm/pwm.yaml#
> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      compatible:
> +        const: st,stmpe-pwm

You need to define what value #pwm-cells should be.

> +
> +    required:
> +      - compatible
> +      - "#pwm-cells"

pwm.yaml already requires this.

With those fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  touchscreen:
> +    type: object
> +    $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +    unevaluatedProperties: false
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
> +    required:
> +      - compatible
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
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
> +      port-expander@43 {
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
> +      port-expander@41 {
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
> +          st,norequest-mask = <0x0f>;
> +          #io-channel-cells = <1>;
> +        };
> +
> +        gpio {
> +          compatible = "st,stmpe-gpio";
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          interrupt-controller;
> +          #interrupt-cells = <2>;
> +        };
> +
> +        pwm {
> +          compatible = "st,stmpe-pwm";
> +          #pwm-cells = <2>;
> +        };
> +
> +        touchscreen {
> +          compatible = "st,stmpe-ts";
> +          st,ave-ctrl = <3>;
> +          st,touch-det-delay = <5>;
> +          st,settling = <3>;
> +          st,fraction-z = <7>;
> +          st,i-drive = <1>;
> +        };
> +      };
> +    };
> +...
