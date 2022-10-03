Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A225F3543
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJCSJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJCSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:09:22 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D71213E33;
        Mon,  3 Oct 2022 11:09:21 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id h1-20020a4aa741000000b004756c611188so7271494oom.4;
        Mon, 03 Oct 2022 11:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=c6UtuAiUV5JOOWs/rr0RvMoZMnfKaFLYR7xPgehi1PQ=;
        b=LFckwA5zfqHg1Vxj4nd25Urb2t7P3QkcEDfuAHtQJIWa6f/IRr3ZojEp1t16kfIm3k
         WiXY9eacVRuyfY18rOPt+lMNcuH5qeXvZbCX9W6DEmX67yXPlfSD1hdMgwb5erQKPsrm
         zzzUtUCQUT97gSY8NdT2LuXkA4Be8etdPb2sSuuA5XS7aUO+HoeUnW20uPecZwe7JPw8
         4DSOM3QZq+WQw3lvKBHOZnTOdLrzDOv51WR17POwGB/SMHj1h7bl7+Mj6YIVy0FyuSE1
         N76IFqhxNMaJDWBCMg35W2gEumrAPWdUAiRjCBy8LVuqWUoWljfN6BzF7qxDsIrBzkeh
         /A+A==
X-Gm-Message-State: ACrzQf2gGy3zOioh41cP+QjgzwK7gIkplqTWfj+4N4iiJyKS7+0nJkcI
        o6t5Frz1nUaklLD28dpg+w==
X-Google-Smtp-Source: AMsMyM4UDzhSqHm3NWn1HYmgeckk26V31KR8PLvGuhNb6jVHN7uatAlwJenydtNj7waoAh2vqnJXBQ==
X-Received: by 2002:a9d:347:0:b0:655:d0f9:ccea with SMTP id 65-20020a9d0347000000b00655d0f9cceamr8548212otv.16.1664820560515;
        Mon, 03 Oct 2022 11:09:20 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c130-20020aca3588000000b00344a22e71a9sm2599336oia.9.2022.10.03.11.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:09:20 -0700 (PDT)
Received: (nullmailer pid 2533014 invoked by uid 1000);
        Mon, 03 Oct 2022 18:09:19 -0000
Date:   Mon, 3 Oct 2022 13:09:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: addac: add AD74115
Message-ID: <20221003180919.GA2515957-robh@kernel.org>
References: <20221003103016.195805-1-demonsingur@gmail.com>
 <20221003103016.195805-2-demonsingur@gmail.com>
 <7ef3a31a-fa6a-1a54-6e60-ff0c5df28301@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef3a31a-fa6a-1a54-6e60-ff0c5df28301@linaro.org>
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

On Mon, Oct 03, 2022 at 12:45:31PM +0200, Krzysztof Kozlowski wrote:
> On 03/10/2022 12:30, Cosmin Tanislav wrote:
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > 
> > The AD74115H is a single-channel, software-configurable, input and
> > output device for industrial control applications. The AD74115H
> > provides a wide range of use cases, integrated on a single chip.
> > 
> > These use cases include analog output, analog input, digital output,
> > digital input, resistance temperature detector (RTD), and thermocouple
> > measurement capability. The AD74115H also has an integrated HART modem.
> > 
> > A serial peripheral interface (SPI) is used to handle all communications
> > to the device, including communications with the HART modem. The digital
> > input and digital outputs can be accessed via the SPI or the
> > general-purpose input and output (GPIO) pins to support higher
> > speed data rates.
> > 
> > The device features a 16-bit, sigma-delta analog-to-digital converter
> > (ADC) and a 14-bit digital-to-analog converter (DAC).
> > The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> > be used as the DAC and ADC reference.
> > 
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> I got only this patch. Where is the cover letter?
> 
> 
> > ---
> >  .../bindings/iio/addac/adi,ad74115.yaml       | 491 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 498 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > new file mode 100644
> > index 000000000000..1f894d80b259
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> 
> Filename matching compatible, so adi,ad74115h.yaml
> 
> > @@ -0,0 +1,491 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/addac/adi,ad74115.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD74115H device
> > +
> > +maintainers:
> > +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> > +
> > +description: |
> > +  The AD74115H is a single-channel software configurable input/output
> > +  device for industrial control applications. It contains functionality for
> > +  analog output, analog input, digital output, digital input, resistance
> > +  temperature detector, and thermocouple measurements integrated into a single
> > +  chip solution with an SPI interface. The device features a 16-bit ADC and a
> > +  14-bit DAC.
> > +
> > +    https://www.analog.com/en/products/ad74115h.html
> > +
> 
> Missing allOf-ref to spi properties.
> 
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad74115h
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  spi-max-frequency:
> > +    maximum: 24000000
> > +
> > +  spi-cpol: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  avdd-supply: true
> > +  avcc-supply: true
> > +  dvcc-supply: true
> > +  aldo1v8-supply: true
> > +  dovdd-supply: true
> > +  refin-supply: true
> > +
> > +  adi,ch-func:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Channel function.
> > +      0 - High impedance
> > +      1 - Voltage output
> > +      2 - Current output
> > +      3 - Voltage input
> > +      4 - Current input, externally-powered
> > +      5 - Current input, loop-powered
> > +      6 - Resistance input
> > +      7 - RTD measure
> > +      8 - Digital input logic
> > +      9 - Digital input, loop-powered
> > +      10 - Current output with HART
> > +      11 - Current input, externally-powered, with HART
> > +      12 - Current input, loop-powered, with HART
> > +    minimum: 0
> > +    maximum: 12
> > +    default: 0
> > +
> > +  adi,conv2-mux:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Input node for ADC conversion 2.
> 
> node or mode?
> 
> > +      0 - SENSE_EXT1 to AGND_SENSE
> > +      1 - SENSE_EXT2 to AGND_SENSE
> > +      2 - SENSE_EXT2 to SENSE_EXT1
> > +      3 - AGND to AGND
> > +    minimum: 0
> > +    maximum: 3
> > +    default: 0
> > +
> > +  adi,conv2-range:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Conversion range for ADC conversion 2.
> > +      0 - 0V to 12V
> > +      1 - -12V to +12V
> > +      2 - -2.5V to +2.5V
> > +      3 - -2.5V to 0V
> > +      4 - 0V to 2.5V
> > +      5 - 0V to 0.625V
> > +      6 - -104mV to +104mV
> > +      7 - 0V to 12V
> > +    minimum: 0
> > +    maximum: 7
> > +    default: 0
> > +
> > +  adi,diag0-func:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> This nicely matches a string enum.

Then the driver has to do a bunch of string comparisons to get back to a 
register setting. Worth it if something common, but for a device 
specific setting, I'd just stick with register field values.

If these are diagnostic/debug, why would you want it in DT to begin 
with? Wouldn't someone want to change this at run-time? Seems like a 
debugfs feature instead.

> 
> > +    description: |
> > +      Diagnostic channel 0 function.
> > +      0 - Disabled
> > +      1 - Temperature sensor
> > +      2 - DVCC
> > +      3 - AVCC
> > +      4 - ALDO1V8
> > +      5 - DLDO1V8
> > +      6 - REFOUT
> > +      7 - AVDD
> > +      8 - AVSS
> > +      9 - LVIN
> > +      10 - SENSEL
> > +      11 - SENSE_EXT1
> > +      12 - SENSE_EXT2
> > +      13 - DO_VDD
> > +      14 - AGND
> > +      15 - Sinking current from external digital output
> > +    minimum: 0
> > +    maximum: 15
> > +    default: 0
> > +
> > +  adi,diag1-func:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> 
> Ditto
