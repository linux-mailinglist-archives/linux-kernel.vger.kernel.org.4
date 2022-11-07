Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E861FA3F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiKGQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiKGQpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:45:08 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080231EC7E;
        Mon,  7 Nov 2022 08:45:07 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so6863297otb.8;
        Mon, 07 Nov 2022 08:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt8tiUAWjXi4DITfFZYqbuOzAaqRudx+z+tIQbSjD/4=;
        b=tu/6Hx9MbgQIQ2Bb0w4doaBSEqraGfbIJkIWHDjEM4xEqGntkbA41oHV9MrAXVcFKl
         8VWtWud6hqyGc95Poffs16yfCwyhymIoi7EiK75HM3jOP2WYD/Cs3jPwPo7TfKQr5tX4
         GkgWlP4NrmJzzx1xQLAHTZSr+fe9ZIVe8Qmy8Gxhp7YOuUu2+2SJxNk995I7p4pZ5b2C
         0Okvw2zU77gfyuSMqZ3c+L6sf5Vudw86PagUtBFzOE6pIXFedlCXoA7hE1Jy9X0xdOvv
         Uh+Vrh3sb1bFmV/IhCcZW8svWvLB4ApGKp82eDkrxOCKKkjOcXRZQBsmfV3ju7Qf+Hwj
         hzAg==
X-Gm-Message-State: ACrzQf2s6n+oV29Gyg7BCrAXG7y5Z0GEHmBTndfHE2T1cONPSqf1JdZC
        A9HTlpGVMhO545VeZyvN3EgUlResiw==
X-Google-Smtp-Source: AMsMyM54j/nnTfupz+f1XulhidRu6SZFcVuYI8Rdv/ao02iw5ftg/v4G/oeECi2Su7wvn2w9329DOQ==
X-Received: by 2002:a05:6830:1605:b0:66c:55c2:8780 with SMTP id g5-20020a056830160500b0066c55c28780mr21067891otr.378.1667839505998;
        Mon, 07 Nov 2022 08:45:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x12-20020a05683000cc00b0065c2c46077dsm3075025oto.67.2022.11.07.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:45:05 -0800 (PST)
Received: (nullmailer pid 1222129 invoked by uid 1000);
        Mon, 07 Nov 2022 16:45:07 -0000
Date:   Mon, 7 Nov 2022 10:45:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
Message-ID: <20221107164507.GA1217628-robh@kernel.org>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
 <20221103094436.2136698-2-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103094436.2136698-2-demonsingur@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:44:35AM +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> The AD74115H is a single-channel, software-configurable, input and
> output device for industrial control applications. The AD74115H
> provides a wide range of use cases, integrated on a single chip.
> 
> These use cases include analog output, analog input, digital output,
> digital input, resistance temperature detector (RTD), and thermocouple
> measurement capability. The AD74115H also has an integrated HART modem.
> 
> A serial peripheral interface (SPI) is used to handle all communications
> to the device, including communications with the HART modem. The digital
> input and digital outputs can be accessed via the SPI or the
> general-purpose input and output (GPIO) pins to support higher
> speed data rates.
> 
> The device features a 16-bit, sigma-delta analog-to-digital converter
> (ADC) and a 14-bit digital-to-analog converter (DAC).
> The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> be used as the DAC and ADC reference.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/addac/adi,ad74115.yaml       | 370 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 377 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> new file mode 100644
> index 000000000000..621f11d5c1f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> @@ -0,0 +1,370 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/addac/adi,ad74115.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD74115H device
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +
> +description: |
> +  The AD74115H is a single-channel software configurable input/output
> +  device for industrial control applications. It contains functionality for
> +  analog output, analog input, digital output, digital input, resistance
> +  temperature detector, and thermocouple measurements integrated into a single
> +  chip solution with an SPI interface. The device features a 16-bit ADC and a
> +  14-bit DAC.
> +
> +    https://www.analog.com/en/products/ad74115h.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad74115h
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 24000000
> +
> +  spi-cpol: true
> +
> +  reset-gpios: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  avdd-supply: true
> +  avcc-supply: true
> +  dvcc-supply: true
> +  aldo1v8-supply: true
> +  dovdd-supply: true
> +  refin-supply: true
> +
> +  adi,ch-func:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Channel function.
> +      0 - High impedance
> +      1 - Voltage output
> +      2 - Current output
> +      3 - Voltage input
> +      4 - Current input, externally-powered
> +      5 - Current input, loop-powered
> +      6 - Resistance input
> +      7 - RTD measure
> +      8 - Digital input logic
> +      9 - Digital input, loop-powered
> +      10 - Current output with HART
> +      11 - Current input, externally-powered, with HART
> +      12 - Current input, loop-powered, with HART
> +    minimum: 0
> +    maximum: 12
> +    default: 0
> +
> +  adi,conv2-mux:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Input node for ADC conversion 2.
> +      0 - SENSE_EXT1 to AGND_SENSE
> +      1 - SENSE_EXT2 to AGND_SENSE
> +      2 - SENSE_EXT2 to SENSE_EXT1
> +      3 - AGND to AGND
> +    minimum: 0
> +    maximum: 3
> +    default: 0
> +
> +  adi,conv2-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Conversion range for ADC conversion 2.
> +      0 - 0V to 12V
> +      1 - -12V to +12V
> +      2 - -2.5V to +2.5V
> +      3 - -2.5V to 0V
> +      4 - 0V to 2.5V
> +      5 - 0V to 0.625V
> +      6 - -104mV to +104mV
> +      7 - 0V to 12V
> +    minimum: 0
> +    maximum: 7
> +    default: 0
> +
> +  adi,sense-agnd-buffer-lp:
> +    type: boolean
> +    description: |

Don't need '|' if no formatting to preserve.

> +      Whether to enable low-power buffered mode for the AGND sense pin.
> +
> +  adi,lf-buffer-lp:
> +    type: boolean
> +    description: |
> +      Whether to enable low-power buffered mode for the low-side filtered
> +      sense pin.
> +
> +  adi,hf-buffer-lp:
> +    type: boolean
> +    description: |
> +      Whether to enable low-power buffered mode for the high-side filtered
> +      sense pin.
> +
> +  adi,ext2-buffer-lp:
> +    type: boolean
> +    description: Whether to enable low-power buffered mode for the EXT2 pin.
> +
> +  adi,ext1-buffer-lp:
> +    type: boolean
> +    description: Whether to enable low-power buffered mode for the EXT1 pin.
> +
> +  adi,comparator-invert:
> +    type: boolean
> +    description: Whether to invert the comparator output.
> +
> +  adi,digital-input-sink-range-high:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      When not present, the digital input range is from 0 to 3700uA in steps
> +      of 120uA, with a ~2k series resistance.
> +      When present, the digital input range is from 0 to 7400uA in steps
> +      of 240uA, with a ~1k series resistance.
> +
> +  adi,digital-input-sink-microamp:
> +    description: Sink current in digital input mode.
> +    minimum: 0
> +    maximum: 3700
> +    default: 0
> +
> +  adi,digital-input-debounce-mode-counter-reset:
> +    type: boolean
> +    description: |
> +      When not present, a counter increments when the signal is asserted
> +      and decrements when the signal is de-asserted.
> +      When present, a counter increments while the signal is asserted and
> +      resets when the signal de-asserts
> +
> +  adi,digital-input-unbuffered:
> +    type: boolean
> +    description: Whether to buffer digital input signals.
> +
> +  adi,digital-input-short-circuit-detection:
> +    type: boolean
> +    description: Whether to detect digital input short circuits.
> +
> +  adi,digital-input-open-circuit-detection:
> +    type: boolean
> +    description: Whether to detect digital input open circuits.
> +
> +  adi,digital-input-threshold-mode-fixed:
> +    type: boolean
> +    description: |
> +      When not present, the digital input threshold range is -0.96 * AVDD
> +      to AVDD.
> +      When present, the threshold range is fixed from -19V to 30V.
> +
> +  adi,dac-bipolar:
> +    type: boolean
> +    description: |
> +      When not present, the DAC operates in the 0V to 12V range.
> +      When present, the DAC operates in the -12V to 12V range.
> +
> +  adi,charge-pump:
> +    type: boolean
> +    description: Whether to enable the internal charge pump.
> +
> +  adi,dac-hart-slew:
> +    type: boolean
> +    description: Whether to use a HART-compatible slew rate.
> +
> +  adi,dac-current-limit-low:
> +    type: boolean
> +    description: |
> +      When not present, the DAC short-circuit current limit is 32mA in
> +      either source or sink for VOUT and 4mA sink for IOUT.
> +      When present, the limit is 16mA in either source or sink for VOUT,
> +      1mA sink for IOUT.
> +
> +  adi,4-wire-rtd:
> +    type: boolean
> +    description: |
> +      When not present, the ADC should be used for measuring 3-wire RTDs.
> +      When present, the ADC should be used for measuring 4-wire RTDs.
> +
> +  adi,3-wire-rtd-excitation-swap:
> +    type: boolean
> +    description: Whether to swap the excitation for 3-wire RTD.
> +
> +  adi,rtd-excitation-current-microamp:
> +    description: Excitation current to apply to RTD.
> +    enum: [250, 500, 750, 1000]
> +    default: 250
> +
> +  adi,ext1-burnout:
> +    type: boolean
> +    description: Whether to enable burnout current for EXT1.
> +
> +  adi,ext1-burnout-current-nanoamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Burnout current in nanoamps to be applied to EXT1.
> +    enum: [0, 50, 500, 1000, 10000]
> +    default: 0
> +
> +  adi,ext1-burnout-current-polarity-sourcing:
> +    type: boolean
> +    description: |
> +      When not present, the burnout current polarity for EXT1 is sinking.
> +      When present, the burnout current polarity for EXT1 is sourcing.
> +
> +  adi,ext2-burnout:
> +    type: boolean
> +    description: Whether to enable burnout current for EXT2.
> +
> +  adi,ext2-burnout-current-nanoamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Burnout current in nanoamps to be applied to EXT2.
> +    enum: [0, 50, 500, 1000, 10000]
> +    default: 0
> +
> +  adi,ext2-burnout-current-polarity-sourcing:
> +    type: boolean
> +    description: |
> +      When not present, the burnout current polarity for EXT2 is sinking.
> +      When present, the burnout current polarity for EXT2 is sourcing.
> +
> +  adi,viout-burnout:
> +    type: boolean
> +    description: Whether to enable burnout current for VIOUT.
> +
> +  adi,viout-burnout-current-nanoamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Burnout current in nanoamps to be applied to VIOUT.
> +    enum: [0, 1000, 10000]
> +    default: 0
> +
> +  adi,viout-burnout-current-polarity-sourcing:
> +    type: boolean
> +    description: |
> +      When not present, the burnout current polarity for VIOUT is sinking.
> +      When present, the burnout current polarity for VIOUT is sourcing.
> +
> +  adi,gpio0-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      GPIO functions.
> +      0 - Disabled
> +      1 - Logic I/O
> +      2 - Comparator output
> +      3 - Control HART CD
> +      4 - Monitor HART CD
> +      5 - Monitor HART EOM status
> +    minimum: 0
> +    maximum: 5
> +    default: 0
> +
> +  adi,gpio1-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      GPIO functions.
> +      0 - Disabled
> +      1 - Logic I/O
> +      2 - Drive external digital output FET
> +      3 - Control HART RXD
> +      4 - Monitor HART RXD
> +      5 - Monitor HART SOM status
> +    minimum: 0
> +    maximum: 5
> +    default: 0
> +
> +  adi,gpio2-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      GPIO functions.
> +      0 - Disabled
> +      1 - Logic I/O
> +      2 - Drive internal digital output FET
> +      3 - Control HART TXD
> +      4 - Monitor HART TXD
> +      5 - Monitor HART TX complete status
> +    minimum: 0
> +    maximum: 5
> +    default: 0
> +
> +  adi,gpio3-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      GPIO functions.
> +      0 - Disabled
> +      1 - Logic I/O
> +      2 - High impedance
> +      3 - Control HART RTS
> +      4 - Monitor HART RTS
> +      5 - Monitor HART CD complete status
> +    minimum: 0
> +    maximum: 5
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpol
> +  - avdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        adi,digital-input-sink-range-high: true

The 'if' is true if adi,digital-input-sink-range-high is not present 
which is probably not what you want. Use 'required' instead.

> +    then:
> +      properties:
> +        adi,digital-input-sink-microamp:
> +          maximum: 7400
> +
> +additionalProperties: false

As pointed out, yes, this needs to be unevaluatedProperties.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      addac@0 {
> +        compatible = "adi,ad74115h";
> +        reg = <0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        spi-max-frequency = <12000000>;
> +        spi-cpol;
> +
> +        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +
> +        interrupt-parent = <&gpio>;
> +        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> +
> +        avdd-supply = <&ad74115_avdd>;
> +
> +        adi,ch-func = <1>;
> +        adi,conv2-mux = <2>;
> +        adi,conv2-range = <1>;
> +
> +        adi,gpio0-mode = <1>;
> +        adi,gpio1-mode = <1>;
> +        adi,gpio2-mode = <1>;
> +        adi,gpio3-mode = <1>;
> +
> +        adi,dac-bipolar;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a56c344ca67..5b5533f54f67 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1175,6 +1175,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>  F:	drivers/iio/adc/ad7780.c
>  
> +ANALOG DEVICES INC AD74115 DRIVER
> +M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> +
>  ANALOG DEVICES INC AD74413R DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
> -- 
> 2.38.1
> 
> 
