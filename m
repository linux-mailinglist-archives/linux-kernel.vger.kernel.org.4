Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427D65F2EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJCKpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJCKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:45:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE3B50727
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:45:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b2so5040569lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=grwyGVt1jXUiIz81zjrt0To3ezivqkVsPTw5zaROvOI=;
        b=uVH5vmO4WNiaAr1ENy3XNw4/5yUafg0wmDz3A9uL7lYcHNZq6RAmyE1f1FrahnCVnq
         EJqrxDWqlpSKzrjMaxJ6+CXDPSnKM1WK8UY+D6jp9OLJSnjgAJEZnhR8JKuo2rgPgfqr
         xTQtr7axdIo5awRFjvHtuUWuzDYhN/GQwRDN5uujMGPEY8bBKmdZCLMAjsHO2n30aebQ
         SWjb0xkcRer2pMMDuCkvVafFBtYppHUdtLSzGoLWMwgIUWwM+H1qlwS3ahVCMUzIXeSa
         QFkuf2f1CjPsqB1MQUOwYSi312unCKWYK5o8SDBTg00umu402QeOyTWrpnC2fb0XaMbV
         JkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=grwyGVt1jXUiIz81zjrt0To3ezivqkVsPTw5zaROvOI=;
        b=cH7uUkSeAyKXcAU9UGcbzOIi3JYsoZiFrh8ojm4W17nyO0Bv4RhZmWveICuY4L1p8H
         +j3JLmj6KUBgKXrfsvn1NleJ9EjDOG+Y3fO7b/fdunIqzufyFpKZvqPHJiXVSbofuKqY
         +YoVAFTVYRkcfprbXPiuWZVYc46Xg7IJx9o/2fnjEPEmixotV0aRu3XqtONHJqh42BnS
         QOYaAe6FrGj1ZFyTk9hBpW5ys4nx1ARA0dAH9txCvBBMI+LvZwMta1PqAuwncvmq3sFA
         woGBYP7QOvK8YtMitoLfwcaL/GUisPKS9g82hN6AfJOicmXFicpOO5UaIAPvWYU7ocpT
         sFpg==
X-Gm-Message-State: ACrzQf0NSTtL/Q9SU6mgBg+TB3YVbgjpLsZhTjaFdMdF4H0rtS5dIaXp
        PJwVa1qTIx++Z86q78Hx1ho8+Q==
X-Google-Smtp-Source: AMsMyM7nuh8DqO4T+6s+Jk3VTvbYUJko3FUs9NG7tnw5ysMzjWJriiijqk3shy2jX5BEFkwSS1PiMg==
X-Received: by 2002:a05:6512:3ba3:b0:497:ad1e:e9ab with SMTP id g35-20020a0565123ba300b00497ad1ee9abmr7846085lfv.619.1664793932637;
        Mon, 03 Oct 2022 03:45:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b37-20020a05651c0b2500b0026dcac60624sm656625ljr.108.2022.10.03.03.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 03:45:32 -0700 (PDT)
Message-ID: <7ef3a31a-fa6a-1a54-6e60-ff0c5df28301@linaro.org>
Date:   Mon, 3 Oct 2022 12:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: addac: add AD74115
Content-Language: en-US
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221003103016.195805-1-demonsingur@gmail.com>
 <20221003103016.195805-2-demonsingur@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221003103016.195805-2-demonsingur@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 12:30, Cosmin Tanislav wrote:
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

I got only this patch. Where is the cover letter?


> ---
>  .../bindings/iio/addac/adi,ad74115.yaml       | 491 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 498 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> new file mode 100644
> index 000000000000..1f894d80b259
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml

Filename matching compatible, so adi,ad74115h.yaml

> @@ -0,0 +1,491 @@
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

Missing allOf-ref to spi properties.

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

node or mode?

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
> +  adi,diag0-func:
> +    $ref: /schemas/types.yaml#/definitions/uint32

This nicely matches a string enum.

> +    description: |
> +      Diagnostic channel 0 function.
> +      0 - Disabled
> +      1 - Temperature sensor
> +      2 - DVCC
> +      3 - AVCC
> +      4 - ALDO1V8
> +      5 - DLDO1V8
> +      6 - REFOUT
> +      7 - AVDD
> +      8 - AVSS
> +      9 - LVIN
> +      10 - SENSEL
> +      11 - SENSE_EXT1
> +      12 - SENSE_EXT2
> +      13 - DO_VDD
> +      14 - AGND
> +      15 - Sinking current from external digital output
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  adi,diag1-func:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |

Ditto

> +      Diagnostic channel 1 function.
> +      0 - Disabled
> +      1 - Temperature sensor
> +      2 - DVCC
> +      3 - AVCC
> +      4 - ALDO1V8
> +      5 - DLDO1V8
> +      6 - REFOUT
> +      7 - AVDD
> +      8 - AVSS
> +      9 - LVIN
> +      10 - SENSEL
> +      11 - SENSE_EXT1
> +      12 - SENSE_EXT2
> +      13 - DO_VDD
> +      14 - AGND
> +      15 - Sourcing current from external digital output
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  adi,diag2-func:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Ditto

> +    description: |
> +      Diagnostic channel 2 function.
> +      0 - Disabled
> +      1 - Temperature sensor
> +      2 - DVCC
> +      3 - AVCC
> +      4 - ALDO1V8
> +      5 - DLDO1V8
> +      6 - REFOUT
> +      7 - AVDD
> +      8 - AVSS
> +      9 - LVIN
> +      10 - SENSEL
> +      11 - SENSE_EXT1
> +      12 - SENSE_EXT2
> +      13 - DO_VDD
> +      14 - AGND
> +      15 - Sinking current from internal digital output
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  adi,diag3-func:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |

Ditto

> +      Diagnostic channel 3 function.
> +      0 - Disabled
> +      1 - Temperature sensor
> +      2 - DVCC
> +      3 - AVCC
> +      4 - ALDO1V8
> +      5 - DLDO1V8
> +      6 - REFOUT
> +      7 - AVDD
> +      8 - AVSS
> +      9 - LVIN
> +      10 - SENSEL
> +      11 - SENSE_EXT1
> +      12 - SENSE_EXT2
> +      13 - DO_VDD
> +      14 - AGND
> +      15 - Sourcing current from internal digital output
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  adi,sense-agnd-buffer-lp:
> +    type: boolean
> +    description: |
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
> +  adi,comparator-invert-en:

Drop "-en" suffix.

> +    type: boolean
> +    description: Whether to invert the comparator output.
> +
> +  adi,digital-input-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Digital input range.
> +      0 - Range 0.0 to 3.7mA in steps of 120uA, ~2k series resistance
> +      1 - Range 1.0 to 7.4mA in steps of 240uA, ~1k series resistance
> +    minimum: 0
> +    maximum: 1
> +    default: 0
> +
> +  adi,digital-input-sink:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Digital input sink.

You just copied the name of property into description. It's not useful.

> +    minimum: 0
> +    maximum: 31
> +    default: 0
> +
> +  adi,digital-input-debounce-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Digital input debounce mode.
> +      0 - Integrator method is used, a counter increments when the
> +          signal is asserted and decrements when the signal is de-asserted
> +      1 - A simple counter increments while a signal is asserted and
> +          resets when the signal de-asserts
> +    minimum: 0
> +    maximum: 1

This also looks like a string.

> +    default: 0
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
> +  adi,digital-input-threshold-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Digital input threshold mode.
> +      0 - The threshold range is from -0.96 * AVDD to AVDD
> +      1 - The threshold range is fixed from -19V to 30V
> +    minimum: 0
> +    maximum: 1
> +    default: 0
> +
> +  adi,dac-bipolar:
> +    type: boolean
> +    description: |
> +      When not present, the DAC operates in the 0V to 12V range.
> +      When present, the DAC operates in the -12V to 12V range.
> +
> +  adi,charge-pump-en:
> +    type: boolean
> +    description: Whether to enable the internal charge pump.
> +
> +  adi,dac-hart-slew:
> +    type: boolean
> +    description: Whether to use a HART-compatible slew rate.
> +
> +  adi,dac-current-limit:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Current limit.
> +      0 - 32mA source or sink for VOUT, 4mA sink for IOUT
> +      1 - 16mA source or sink for VOUT, 1mA sink for IOUT

Use common property units, so microamp:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    minimum: 0
> +    maximum: 1
> +    default: 0
> +
> +  adi,rtd-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      RTD mode.
> +      0 - 3-wire mode
> +      1 - 4-wire mode

Looks like a string.

> +    minimum: 0
> +    maximum: 1
> +    default: 0
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
> +  adi,ext1-burnout-en:

Drop "-en" suffix

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
> +  adi,ext1-burnout-current-polarity:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Burnout current polarity for EXT2.
> +      0 - Sinking
> +      1 - Sourcing
> +    minimum: 0
> +    maximum: 1
> +    default: 0
> +
> +  adi,ext2-burnout-en:

Drop "-en" suffix

> +    type: boolean
> +    description: Whether to enable burnout current for EXT2.
> +
> +  adi,ext2-burnout-current-nanoamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Burnout current in nanoamps to be applied to EXT2.
> +    enum: [0, 50, 500, 1000, 10000]
> +    default: 0
> +
> +  adi,ext2-burnout-current-polarity:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Burnout current polarity for EXT2.
> +      0 - Sinking
> +      1 - Sourcing

Looks like a string.

> +    minimum: 0
> +    maximum: 1
> +    default: 0
> +
> +  adi,viout-burnout-en:

Drop "-en" suffix

> +    type: boolean
> +    description: Whether to enable burnout current for VIOUT.
> +
> +  adi,viout-burnout-current-nanoamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Burnout current in nanoamps to be applied to VIOUT.
> +    enum: [0, 1000, 10000]
> +    default: 0
> +
> +  adi,viout-burnout-current-polarity:

Looks like a string

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Burnout current polarity for VIOUT.
> +      0 - Sinking
> +      1 - Sourcing
> +    minimum: 0
> +    maximum: 1
> +    default: 0
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

Looks like a string

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

Looks like a string


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

Looks like a string


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

Looks like a string

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
> +additionalProperties: false
> +

Best regards,
Krzysztof

