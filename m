Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1E95EF22E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiI2JgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI2Jfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:35:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5231F60A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:35:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z4so1397358lft.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fJuqrfz5mzYVxaOc20le9ccOGtIx9cxJ+e/xrVrnghk=;
        b=QU3oXXNHLp67EZMCaBVntLfM6KG5CasC9xD1KWN0t3jL905bHXLgvYofKAUZAPo4uS
         blG37GfqqzVr1cjU2e2zkC+8DUzqOZMWB7ddkEIPoXCCvVRVIJjw93xpDYr6kh91UYIZ
         UUSnZN7fOrF40MbIgo7G4yk1UdcDrT87OlsnqjVskWr22KavY28PSbHQAZP6zKqNbIa7
         y4HyZ0zqWTZR2ECwsWLzZc5Ju0sqNoncoMZMl2JvlPEmxgD0LxsLt8J/eT/w5eVmEnbl
         cPzE7JEvhk04TkBKrx0VtlFLBS+OQVt3ZWDyABuUJDupe7AeqvFXUGqNUjeBYVNEcpxC
         GjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fJuqrfz5mzYVxaOc20le9ccOGtIx9cxJ+e/xrVrnghk=;
        b=0HudgoRbbwUZhohOfS9G0Rx9h+7I/jd4zsEn7Ps5WlPsfVopFfrgN3GCbu7BeJvnxW
         /28/vcTHxn75t7pBRiQHxXVQPupqBZkJcvPR4HWdcALHi5s5UDHk2sIapo1XI0m1o4gm
         Nje/8YblIfSBgxCzA+YglPgROsXFjWwhFR/V0EjcHXR55qFkBKQHTGJnS/ECMsErlhjt
         FdOpMho2Yo5WVvgSPhjUjDxhF+k573OyA/SrKp/enrbyjYXVEBE9Lsg+Tvs/n1M7cewi
         vFB57mG66yBe4W+ah4T4aAc/TcOq7p2f5t6qZyeqZsOOg074FhLdlUShuMAmHVs5PelN
         /BwA==
X-Gm-Message-State: ACrzQf2xe0BhmomCCc9FcfwkYyUrgj0ySaXdRCLnUkvXzjh9JZAkVwg4
        Uq2yUyVRdeTP+ZPKs2cvno+apL8eDCU0vQ==
X-Google-Smtp-Source: AMsMyM6pPAF9V4nE4eca/ttFss9kdzr7QWOdhhPUec0uMOITfWPGrkyzSyOnwaV+RzjsBGhzcSRaeA==
X-Received: by 2002:a05:6512:a8c:b0:49e:359f:5563 with SMTP id m12-20020a0565120a8c00b0049e359f5563mr930836lfu.563.1664444111446;
        Thu, 29 Sep 2022 02:35:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e11-20020a19690b000000b0048b0099f40fsm728045lfc.216.2022.09.29.02.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:35:10 -0700 (PDT)
Message-ID: <a382fdee-3672-50b8-cd58-85563b9d9079@linaro.org>
Date:   Thu, 29 Sep 2022 11:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Nuno.Sa@analog.com,
        Nurettin.Bolucu@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927141851.279-1-Ibrahim.Tilki@analog.com>
 <20220927141851.279-3-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927141851.279-3-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 16:18, Ibrahim Tilki wrote:
> Adding devicetree binding documentation for max11410 adc.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> ---
>  .../bindings/iio/adc/adi,max11410.yaml        | 176 ++++++++++++++++
>  .../devicetree/bindings/rtc/adi,max313xx.yaml | 195 ++++++++++++++++++
>  2 files changed, 371 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
>  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> 

So it is a v6 and it is the first version you send to proper maintainers
using get_maintainers.pl... sigh...

> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> new file mode 100644
> index 0000000000..46a37303da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,max11410.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX11410 ADC device driver
> +
> +maintainers:
> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can be
> +  found here:
> +    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max11410
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description: Name of the gpio pin of max11410 used for IRQ
> +    items:
> +      - enum:
> +          - gpio0
> +          - gpio1

This is wrong. You said in interrupts you can have two items, but here
you list only one. I don't know what do you want to achieve here.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  avdd-supply:
> +    description: Optional avdd supply. Used as reference when no explicit reference supplied.
> +
> +  vref0p-supply:
> +    description: vref0p supply can be used as reference for conversion.
> +
> +  vref1p-supply:
> +    description: vref1p supply can be used as reference for conversion.
> +
> +  vref2p-supply:
> +    description: vref2p supply can be used as reference for conversion.
> +
> +  vref0n-supply:
> +    description: vref0n supply can be used as reference for conversion.
> +
> +  vref1n-supply:
> +    description: vref1n supply can be used as reference for conversion.
> +
> +  vref2n-supply:
> +    description: vref2n supply can be used as reference for conversion.
> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:

This goes before required block

> +  "^channel(@[0-9])?$":
> +    $ref: "adc.yaml"
> +    type: object
> +    description: Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 9
> +
> +      adi,reference:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          0: VREF0P/VREF0N
> +          1: VREF1P/VREF1N
> +          2: VREF2P/VREF2N
> +          3: AVDD/AGND
> +          4: VREF0P/AGND
> +          5: VREF1P/AGND
> +          6: VREF2P/AGND
> +          If this field is left empty, AVDD/AGND is selected.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3, 4, 5, 6]
> +        default: 3
> +
> +      adi,input-mode:
> +        description: |
> +          Select signal path of input channels. Valid values are:
> +          0: Buffered, low-power, unity-gain path (default)
> +          1: Bypass path
> +          2: PGA path
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      diff-channels: true
> +
> +      bipolar: true
> +
> +      settling-time-us: true
> +
> +      adi,buffered-vrefp:
> +        description: Enable buffered mode for positive reference.
> +        type: boolean
> +
> +      adi,buffered-vrefn:
> +        description: Enable buffered mode for negative reference.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            reg = <0>;
> +            compatible = "adi,max11410";
> +            spi-max-frequency = <8000000>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 2>;
> +            interrupt-names = "gpio1";
> +
> +            avdd-supply = <&adc_avdd>;
> +
> +            vref1p-supply = <&adc_vref1p>;
> +            vref1n-supply = <&adc_vref1n>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                diff-channels = <2 3>;
> +                adi,reference = <1>;
> +                bipolar;
> +                settling-time-us = <100000>;
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +                diff-channels = <7 9>;
> +                adi,reference = <5>;
> +                adi,input-mode = <2>;
> +                settling-time-us = <50000>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> new file mode 100644
> index 0000000000..43576ec066
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX313XX series I2C RTC driver
> +
> +maintainers:
> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: Bindings for the Analog Devices MAX313XX series RTCs.
> +
> +properties:
> +  compatible:
> +    oneOf:

No need for oneOf

> +      - enum:
> +          - adi,max31328
> +          - adi,max31329
> +          - adi,max31331
> +          - adi,max31334
> +          - adi,max31341
> +          - adi,max31342
> +          - adi,max31343
> +
> +  reg:
> +    description: I2C address of the RTC
> +    items:
> +      enum: [0x68, 0x69]

One item, so:
items:
  - enum: ......

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description: |
> +      Name of the interrupt pin of the RTC used for IRQ. Not required for
> +      RTCs that only have single interrupt pin available. Some of the RTCs
> +      share interrupt pins with clock input/output pins.
> +    minItems: 1
> +    items:
> +      - enum:
> +          - INTA
> +          - INTB
> +      - enum:
> +          - INTA
> +          - INTB

Why this is so flexible? Any device allows any interrupt to be present
or not?

> +
> +  "#clock-cells":
> +    description: |
> +      RTC can be used as a clock source through its clock output pin when
> +      supplied.
> +    const: 0
> +
> +  clocks:
> +    description: |
> +      RTC uses this clock for clock input when supplied. Clock has to provide
> +      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
> +    maxItems: 1
> +
> +  trickle-diode-disable: true
> +
> +  trickle-resistor-ohms:
> +    description: Enables trickle charger with specified resistor value.
> +    items:
> +      enum: [3000, 6000, 11000]

This is not a list. Just enums, no items.

> +
> +  wakeup-source: true
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: "rtc.yaml#"

Skip quotes


> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max31328
> +              - adi,max31342
> +
> +    then:
> +      properties:
> +        trickle-diode-disable: false
> +        trickle-resistor-ohms: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max31328
> +              - adi,max31331
> +              - adi,max31334
> +              - adi,max31343
> +
> +    then:
> +      properties:
> +        clocks: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max31341
> +              - adi,max31342
> +
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x69
> +
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x68
> +
> +required:
> +  - compatible
> +  - reg
> +
> +

One blank line

> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@68 {
> +            reg = <0x68>;
> +            compatible = "adi,max31328";

Skip the example, it's part of all others.

> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@68 {
> +            reg = <0x68>;
> +            compatible = "adi,max31329";
> +            clocks = <&clkin>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <26 2>;

Aren't you using interrupt flags? If so, use defines.

> +            interrupt-names = "INTB";
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@68 {
> +            reg = <0x68>;
> +            compatible = "adi,max31331";
> +            #clock-cells = <0>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 2>, <26 2>;
> +            interrupt-names = "INTA", "INTB";
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@69 {
> +            reg = <0x69>;
> +            compatible = "adi,max31341";
> +            #clock-cells = <0>;
> +            clocks = <&clkin>;
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;

Skip this example, it's the same.

> +
> +        max31341: rtc@69 {
> +            reg = <0x69>;
> +            compatible = "adi,max31341";
> +            #clock-cells = <0>;
> +        };
> +
> +        rtc@68 {
> +            reg = <0x68>;
> +            compatible = "adi,max31329";
> +            clocks = <&max31341>;
> +        };
> +    };

Best regards,
Krzysztof

