Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8829D6CBCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjC1Kpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjC1Kpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:45:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F525B8C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:45:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m2so11675336wrh.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680000339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB8LC4qEB95pwFQui6j6nlxqb05JqYlk/cHETNjE4Y4=;
        b=JhTJ0vDMuw2rd42vUFpmUXn8hDXp5hSotSRlNah2fEyx35CWbldnyMX6SSCvesUVey
         vcGKfLzY+yxgToF7yFFAhWHnDrvkgY/WBT2oJUcxCQeLH+bWNI/hQZddBVtl/BqkDP1I
         SyU6K1LGa9gFOibRaEGwc/mPKAOyT6dF59WuvSDDPVc1QNgSP5hQDQCJsnVg2AIcyhrZ
         Su5oE2lE9wNhc09Q+SUXLE6QIO3S/26/5SyvwYEiz1ixf9Jt1yXeo2gv8MoGDO/gh0A1
         1PITKqGM5cuOLBBP+F/ueauiYHCx15zUjUwjWxA1+9gki3IiylTBhIp5vMT5llJJOlds
         g+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680000339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB8LC4qEB95pwFQui6j6nlxqb05JqYlk/cHETNjE4Y4=;
        b=amCVdPymLkO8uGqvhBqI8nxPwrroORM/9ouG+q/WOqtDmoHudPxBJE58vvYIqS6kIC
         3liGFUFPJDEwFGH+D8kvBd+8UTKzZHFYnIP0kS3Dl11/741alT8ioqE0JgQ/wOUGlgc4
         8GrOtOG8PlEA4EMc9gIeV2C0PZ4EMwPKbpUYJTvdklxKMFK6AbcVuHDyWyE3II4NbORg
         1ZoDDhyYJa4lSjamPz33+x3oD2VvSAyRJjGjU8SzYU5Mwz4BOJsa+XYz3z4vz9G3UcW0
         utjzPkApdLUszkmoSRhi1fPfBm0i/Buag7fEm1zIGY8PuGxvSdqB+WVxfLh+oGr8jDiG
         xcUQ==
X-Gm-Message-State: AAQBX9fDMSQDqMtgEyCFCqF3FdPM5nRNU7nCOWpHPRjTe3sKuuwIH/qG
        J9huCz9l6qqZr/9LOxc8Nw3UCw==
X-Google-Smtp-Source: AKy350aoHagIFnFuoQb7rS9usWMBf5Q/g4JjMtWZQkOgiY2lwDc2VB87Y6NqQTQXAxrYPRNqEEAtVA==
X-Received: by 2002:adf:e98d:0:b0:2cf:f0c3:79c1 with SMTP id h13-20020adfe98d000000b002cff0c379c1mr11660155wrm.67.1680000338983;
        Tue, 28 Mar 2023 03:45:38 -0700 (PDT)
Received: from [10.3.3.14] (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b002dfca33ba36sm5836353wru.8.2023.03.28.03.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:45:38 -0700 (PDT)
Message-ID: <75f0a18d-aed9-8610-2925-4e604b4b0241@baylibre.com>
Date:   Tue, 28 Mar 2023 12:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230327154101.211732-1-jpanis@baylibre.com>
 <20230327154101.211732-2-jpanis@baylibre.com>
 <a0c18c3a-4f9e-f491-582f-8d3ca56ec26f@linaro.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <a0c18c3a-4f9e-f491-582f-8d3ca56ec26f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 08:51, Krzysztof Kozlowski wrote:
> On 27/03/2023 17:40, Julien Panis wrote:
>> TPS6594 is a Power Management IC which provides regulators and others
>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>> device.
>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---
>>   .../devicetree/bindings/mfd/ti,tps6594.yaml   | 231 ++++++++++++++++++
>>   1 file changed, 231 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>> new file mode 100644
>> index 000000000000..4498e6361b34
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>> @@ -0,0 +1,231 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/ti,tps6594.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI TPS6594 Power Management Integrated Circuit
>> +
>> +maintainers:
>> +  - Julien Panis <jpanis@baylibre.com>
>> +
>> +description:
>> +  TPS6594 is a Power Management IC which provides regulators and others
>> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
>> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
> LP8764X? Compatible says LP8764.
>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,lp8764
> It's confusing. If x was wildcard, didn't you remove part of model name?

OK, I will remove 'X' from model name in v5.

>
>
>> +      - ti,tps6593
>> +      - ti,tps6594
>> +
>> +  reg:
>> +    description: I2C slave address or SPI chip select number.
>> +    maxItems: 1
>> +
>> +  ti,primary-pmic:
>> +    type: boolean
>> +    description: |
>> +      Identify the primary PMIC on SPMI bus.
>> +      A multi-PMIC synchronization scheme is implemented in the PMIC device
>> +      to synchronize the power state changes with other PMIC devices. This is
>> +      accomplished through a SPMI bus: the primary PMIC is the controller
>> +      device on the SPMI bus, and the secondary PMICs are the target devices
>> +      on the SPMI bus.
>> +
>> +  system-power-controller: true
>> +
>> +  gpio-controller: true
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +    description: |
>> +      The first cell is the pin number, the second cell is used to specify flags.
>> +      See ../gpio/gpio.txt for more information.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  ti,multi-phase-id:
>> +    description: |
>> +      Describes buck multi-phase configuration, if any. For instance, XY id means
>> +      that outputs of buck converters X and Y are combined in multi-phase mode.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    oneOf:
>> +      - items:
>> +          - const: 12
>> +      - items:
>> +          - const: 34
>> +      - items:
>> +          - const: 12
>> +          - const: 34
>> +      - items:
>> +          - const: 123
>> +      - items:
>> +          - const: 1234
>> +
>> +  regulators:
>> +    type: object
>> +    description: List of regulators provided by this controller.
>> +
>> +    patternProperties:
>> +      "^buck([1-5]|12|34|123|1234)$":
> Why do you need ti,multi-phase-id property at all? Having buck123
> implies ti,multi-phase-id=123.

I will speak about that with Jerome Neanne (cc of this mail) who uses
this multiphase property for the regulator driver.
We will consider removing the property, which looks redundant indeed.

>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +
>> +        unevaluatedProperties: false
>> +
>> +      "^ldo[1-4]$":
>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +
>> +        unevaluatedProperties: false
>> +
>> +    allOf:
>> +      - if:
>> +          required:
>> +            - buck12
>> +        then:
>> +          properties:
>> +            buck123: false
>> +            buck1234: false
>> +      - if:
>> +          required:
>> +            - buck123
>> +        then:
>> +          properties:
>> +            buck34: false
>> +      - if:
>> +          required:
>> +            - buck1234
>> +        then:
>> +          properties:
>> +            buck34: false
>> +
>> +    additionalProperties: false
>> +
>> +  rtc:
>> +    type: object
>> +    description: RTC provided by this controller.
>> +    $ref: /schemas/rtc/rtc.yaml#
> I doubt that you can have here any RTC and any watchdog (below). This
> should be specific binding instead. Or list of compatibles if you have 3
> or more possible bindings.
>
> Additionally, judging by your DTS you do not have any resources in rtc
> and watchdog, so these should not be nodes by themself in such case.

It seems that I can't figure out what you and Rob mean by saying that
"binding must be complete" and that "RTC and watchdog may or may not
need binding changes".
What does "specific binding" mean ? Should we add some specific property
for RTC/WDG provided by the PMIC ? Should we write another yaml for both
of them ? Why shouldn't they use the generic rtc/watchdog yaml ? I don't
understand why they would need some "binding changes". Any example
I could refer to ? (I might have not looked at the relevant ones for my case
before sending this v4)

>
>> +
>> +  watchdog:
>> +    type: object
>> +    description: Watchdog provided by this controller.
>> +    $ref: /schemas/watchdog/watchdog.yaml#
>> +
>> +patternProperties:
>> +  "^buck([1-5]|12|34|123|1234)-supply$":
>> +    description: Input supply phandle for each buck.
>> +
>> +  "^ldo[1-4]-supply$":
>> +    description: Input supply phandle for each ldo.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        tps6593: pmic@48 {
>> +            compatible = "ti,tps6593";
>> +            reg = <0x48>;
>> +            ti,primary-pmic;
>> +            system-power-controller;
>> +
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pmic_irq_pins_default>;
>> +            interrupt-parent = <&mcu_gpio0>;
>> +            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +            ti,multi-phase-id = <123>;
>> +
>> +            buck123-supply = <&vcc_3v3_sys>;
>> +            buck4-supply = <&vcc_3v3_sys>;
>> +            buck5-supply = <&vcc_3v3_sys>;
>> +            ldo1-supply = <&vcc_3v3_sys>;
>> +            ldo2-supply = <&vcc_3v3_sys>;
>> +            ldo3-supply = <&buck5>;
>> +            ldo4-supply = <&vcc_3v3_sys>;
>> +
>> +            regulators {
>> +                buck123: buck123 {
>> +                    regulator-name = "vcc_core";
>> +                    regulator-min-microvolt = <750000>;
>> +                    regulator-max-microvolt = <850000>;
>> +                    regulator-boot-on;
>> +                    regulator-always-on;
>> +                };
>> +
>> +                buck4: buck4 {
>> +                    regulator-name = "vcc_1v1";
>> +                    regulator-min-microvolt = <1100000>;
>> +                    regulator-max-microvolt = <1100000>;
>> +                    regulator-boot-on;
>> +                    regulator-always-on;
>> +                };
>> +
>> +                buck5: buck5 {
>> +                    regulator-name = "vcc_1v8_sys";
>> +                    regulator-min-microvolt = <1800000>;
>> +                    regulator-max-microvolt = <1800000>;
>> +                    regulator-boot-on;
>> +                    regulator-always-on;
>> +                };
>> +
>> +                ldo1: ldo1 {
>> +                    regulator-name = "vddshv5_sdio";
>> +                    regulator-min-microvolt = <3300000>;
>> +                    regulator-max-microvolt = <3300000>;
>> +                    regulator-boot-on;
>> +                    regulator-always-on;
>> +                };
>> +
>> +                ldo2: ldo2 {
>> +                    regulator-name = "vpp_1v8";
>> +                    regulator-min-microvolt = <1800000>;
>> +                    regulator-max-microvolt = <1800000>;
>> +                    regulator-boot-on;
>> +                    regulator-always-on;
>> +                };
>> +
>> +                ldo3: ldo3 {
>> +                    regulator-name = "vcc_0v85";
>> +                    regulator-min-microvolt = <850000>;
>> +                    regulator-max-microvolt = <850000>;
>> +                    regulator-boot-on;
>> +                    regulator-always-on;
>> +                };
>> +
>> +                ldo4: ldo4 {
>> +                    regulator-name = "vdda_1v8";
>> +                    regulator-min-microvolt = <1800000>;
>> +                    regulator-max-microvolt = <1800000>;
>> +                    regulator-boot-on;
>> +                    regulator-always-on;
>> +                };
>> +            };
>> +
>> +            rtc: rtc {
>> +                wakeup-source;
> No. We do not create nodes for single property.
>
>
>> +            };
>> +
>> +            watchdog: watchdog {
>> +                timeout-sec = <10>;
> Same problem.
>
>
>
> Best regards,
> Krzysztof
>

