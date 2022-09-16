Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3705BA9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiIPJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiIPJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:56:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFE46744C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:56:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so624265wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BIH+Ua2ctNDqD+U7VTgao+s7qmIoiZgxzg9e85W4kXg=;
        b=Kv5F+chWVHc4jO3ej5aBUFOzXTLjAvP9hVcBIkcBUyr/Qo1XS7X+JFJGof/jRQ6kU/
         7CxxhssLPA2jUwsVk9vLqiw69tDKYzTZvzlbOThO0G42yqb5krL4ICqM8o6oY9fqfN2Y
         ppShERCKTOGnTmNSpvyFHRru1MfFBnu8EtTph+SeNMYN7iFNOHReK0mG3mzMQPAybeEV
         Z0r1ZWDxbJgAfAK6oCKD7thRrhkwHdub9+oGWL3fue5/wsh+tbi4VphqEdatPsIPF+1B
         hDtWOKgnjr7UGhkMjX2uDRVRmBwJ5Il78g3gibyGOQEDTB+e6nDaEFmjTdbiXGcAGDs9
         YSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BIH+Ua2ctNDqD+U7VTgao+s7qmIoiZgxzg9e85W4kXg=;
        b=BgHLisdK2PuOsUvjpEWOk3MJKwKrCE/WFBBijt/IQLA9cBPrAILV4+7ySnetA/TRro
         Wm7Np7NPSoEVWZcvJUTvUAcYrukwC8h/WlSAIrFcQTYwWlAAUW8G74u391DQ9YDnD0Bs
         v0OO6qZX7w4R5vpaKMEmNyOYsf+qvQpITxVtRkIolQmV8oBS0CB1M9Jr3uQXf0hzAe/F
         meaq/SS5+4nmX1OykH/4HD7oMzmhFjgBh8lUTka/c4TeZLdRz7hYgkobgCcdJ8InMLgE
         4NjhhK51bIdaJD2qmukMnuSLPT0HQeFqPNRkbODJ0MVgozMeNuhEZ6d4uifAMhKIQ3IC
         kuiw==
X-Gm-Message-State: ACgBeo1udwrtbggT50JoNTIfkBJmI43/7T9Ay0NFzp0+9bMByawZDNhm
        kO125cJrxtICaV1Fv0Cd5ZQl4jHGRdexE1Oo
X-Google-Smtp-Source: AA6agR7I8maX9O3jTdWbResolXJBvKUAvzJblkF15cLMYKrHvP4pgPOZdox7gyyB8B2iknFJJQIlog==
X-Received: by 2002:a1c:4b15:0:b0:3b4:9a81:5f7b with SMTP id y21-20020a1c4b15000000b003b49a815f7bmr9179916wma.95.1663322166554;
        Fri, 16 Sep 2022 02:56:06 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b003a5c244fc13sm1861213wmq.2.2022.09.16.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:56:06 -0700 (PDT)
Message-ID: <9e006307-f7c7-c68a-e5c3-d0d0b2807d87@linaro.org>
Date:   Fri, 16 Sep 2022 10:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
 <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
 <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
 <b064ed4c-d5a7-614f-008e-61ff2ac27f88@amd.com>
 <0852ffa5-9996-0f42-c5a8-d1fe9d39887e@linaro.org>
 <9a98d026-7f70-a69b-64de-c77419888e42@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9a98d026-7f70-a69b-64de-c77419888e42@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 22:57, Larson, Bradley wrote:
> On 9/8/22 4:27 AM, Krzysztof Kozlowski wrote:
>> On 01/09/2022 22:37, Larson, Bradley wrote:
>>> On 9/1/22 12:20 AM, Krzysztof Kozlowski wrote:
>>>> On 01/09/2022 02:01, Larson, Bradley wrote:
>>>>>>> +  is implemented by a sub-device reset-controller which accesses
>>>>>>> +  a CS0 control register.
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Brad Larson <blarson@amd.com>
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    items:
>>>>>>> +      - enum:
>>>>>>> +          - amd,pensando-elbasr
>>>>>>> +
>>>>>>> +  spi-max-frequency:
>>>>>>> +    description: Maximum SPI frequency of the device in Hz.
>>>>>> No need for generic descriptions of common properties.
>>>>> Changed to "spi-max-frequency: true" and moved to end of properties.
>>>> Then you should rather reference spi-peripheral-props just like other
>>>> SPI devices.
>>>
>>> Will look at this dependent on the result of below
>>>
>>>
>>>>>>> +
>>>>>>> +  reg:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  '#address-cells':
>>>>>>> +    const: 1
>>>>>>> +
>>>>>>> +  '#size-cells':
>>>>>>> +    const: 0
>>>>>>> +
>>>>>>> +  interrupts:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +required:
>>>>>>> +  - compatible
>>>>>>> +  - reg
>>>>>>> +  - spi-max-frequency
>>>>>>> +
>>>>>>> +patternProperties:
>>>>>>> +  '^reset-controller@[a-f0-9]+$':
>>>>>>> +    $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml
>>>>>>> +
>>>>>>> +additionalProperties: false
>>>>>>> +
>>>>>>> +examples:
>>>>>>> +  - |
>>>>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>>>> +
>>>>>>> +    spi {
>>>>>>> +        #address-cells = <1>;
>>>>>>> +        #size-cells = <0>;
>>>>>>> +        num-cs = <4>;
>>>>>>> +
>>>>>>> +        sysc: system-controller@0 {
>>>>>>> +            compatible = "amd,pensando-elbasr";
>>>>>>> +            reg = <0>;
>>>>>>> +            #address-cells = <1>;
>>>>>>> +            #size-cells = <0>;
>>>>>>> +            spi-max-frequency = <12000000>;
>>>>>>> +
>>>>>>> +            rstc: reset-controller@0 {
>>>>>>> +                compatible = "amd,pensando-elbasr-reset";
>>>>>>> +                reg = <0>;
>>>>>> What does 0 represent here? A register address within 'elbasr' device?
>>>>> Removed, I recall a check threw a warning or error without reg.
>>>>>
>>>>>> Why do you need a child node for this? Are there other sub-devices and
>>>>>> your binding is incomplete? Just put '#reset-cells' in the parent.
>>>>> Without a reset-controller node and booting the function
>>>>> __of_reset_control_get(...) fails to find a match in the list here
>>>> That's not actually the answer to the question. There was no concerns
>>>> whether you need or not reset controller. The question was why do you
>>>> need a child device instead of elbasr being the reset controller.
>>>>
>>>> Your answer does not cover this at all, so again - why do you need a
>>>> child for this?
>>>>
>>> If the parent becomes a reset-controller compatible with
>>> "amd,pensando-elbasr-reset" then the /dev node will not be created
>> Why /dev node will not be created? How bindings affect having or not
>> having something in /dev ?

I repeat - why?

>>
>>> as there is no match to "amd,pensando-elbasr" for cs0.  For cs0 internal
>>> to linux the reset-controller manages one register bit to hardware reset
>>> the mmc device.  A userspace application opens the device node to manage
>>> transceiver leds, system leds, reporting temps to host, other reset
>>> controls, etc.  Looking at future requirements there likely will be other
>>> child devices.
>> You mean "amd,pensando-elbasr" will instantiate some more devices? Why
>> you cannot add the binding for them now? This is actually important
>> because earlier we agreed you remove unit address from children.
>>
>>> Going down this path with one compatible should reset-elbasr.c just be
>>> deleted and fold it into the parent driver pensando-elbasr.c? Then I
>>> wonder if it even belongs in drivers/mfd and should just be modified
>>> and put in drivers/spi.
>> How is it related to bindings?
> The compatible "amd,pensando-elbasr" is matched in 
> drivers/mfd/pensando-elbasr.c

Does not matter really... We do not talk about driver, but about
hardware and bindings.

> which creates /dev/pensr0.<cs> for spi chip-selects defined in the 
> parent node as:

Wait, can we skip the driver entirely? I am not reviewing your driver
and what it creates under /dev.

> 
>          num-cs = <4>;
>          cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
>                     <&porta 7 GPIO_ACTIVE_LOW>;
> 
> The compatible "amd,pensando-elbasr-reset" is in 
> drivers/reset/reset-elbasr.c

Again, why does it matter for the bindings?

> which uses regmap to control one bit in the function at cs0 to hardware 
> reset the eMMC.
> This is the reason for the reset-controller child and the two driver 
> files.  

You did not provide reason. You described Linux driver implementation
which we do not talk about. We talk about bindings, which are not really
related to implementation (at least in most cases).

> The
> probe in drivers/mfd/pensando-elbasr.c is called 4 times, once per spi 
> chip-select
> and for cs0 mfd_add_devices() is called for the reset controller.
> 
> I'll change "rstc: reset-controller@0" to "rstc: reset-controller".
> 
> Maybe I've gotten off track following what looked like an appropriate model
> to follow ("altr,a10sr") that was initially added in 2017 and has the same
> device topology which is SoC <= spi => CPLD/FPGA where a10sr has a 3rd 
> driver
> file for a gpio controller resulting in two child nodes.
> 
> In our case its not one function its four in the device where the function
> at chip-select 0 is where the hardware team provided the bit to control
> eMMC hardware reset.  Is this a bad approach to follow and if so please
> recommend an acceptable approach.  Also, "amd,pensando-elbasr" will not
> instantiate more devices.
> 
> Snippets below for a10sr in linux-next: Device on other end of spi,
> one chip select, two child devices and 3 driver files in mfd, reset, and 
> gpio.
> 
> FILE: arch/arm/boot/dts/socfpga_arria10_socdk.dtsi:
> &spi1 {
>          status = "okay";
> 
>          resource-manager@0 {
>                  compatible = "altr,a10sr";
>                  reg = <0>;
>                  spi-max-frequency = <100000>;
>                  /* low-level active IRQ at GPIO1_5 */
>                  interrupt-parent = <&portb>;
>                  interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>                  interrupt-controller;
>                  #interrupt-cells = <2>;
> 
>                  a10sr_gpio: gpio-controller {
>                          compatible = "altr,a10sr-gpio";
>                          gpio-controller;
>                          #gpio-cells = <2>;
>                  };
> 
>                  a10sr_rst: reset-controller {
>                          compatible = "altr,a10sr-reset";
>                          #reset-cells = <1>;
>                  };
>          };
> };
> 
> FILE: drivers/mfd/altera-a10sr.c (parent)
> static const struct mfd_cell altr_a10sr_subdev_info[] = {
>          {
>                  .name = "altr_a10sr_gpio",
>                  .of_compatible = "altr,a10sr-gpio",
>          },
>          {
>                  .name = "altr_a10sr_reset",
>                  .of_compatible = "altr,a10sr-reset",
>          },

I know Linux drivers. No need to paste them here. They are unrelated to
this talk.

> };
> 
> static const struct of_device_id altr_a10sr_spi_of_match[] = {
>          { .compatible = "altr,a10sr" },
>          { },
> };
> 
> FILE: drivers/reset/reset-a10sr.c (reset driver)
> static const struct of_device_id a10sr_reset_of_match[] = {
>          { .compatible = "altr,a10sr-reset" },
>          { },
> };
> 
> FILE: ./drivers/gpio/gpio-altera-a10sr.c (gpio driver)
> static const struct of_device_id altr_a10sr_gpio_of_match[] = {
>          { .compatible = "altr,a10sr-gpio" },
>          { },
> };
> 
> In comparision, the pensando device is also on the other end of spi,
> four chip selects with /dev created for each for userspace control,
> and one child device on cs0 for hw reset emmc that the Linux block
> layer controls (single bit managed only by kernel).
> 
> Pensando:
> &spi0 {
>          num-cs = <4>;
>          cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
>                     <&porta 7 GPIO_ACTIVE_LOW>;
>          status = "okay";
>          system-controller@0 {
>                  compatible = "amd,pensando-elbasr";
>                  reg = <0>;
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  spi-max-frequency = <12000000>;
> 
>                  rstc: reset-controller {
>                          compatible = "amd,pensando-elbasr-reset";
>                          #reset-cells = <1>;
>                  };
>          };
> 
>          system-controller@1 {
>                  compatible = "amd,pensando-elbasr";
>                  reg = <1>;
>                  spi-max-frequency = <12000000>;
>          };
> 
>          system-controller@2 {
>                  compatible = "amd,pensando-elbasr";
>                  reg = <2>;
>                  spi-max-frequency = <12000000>;
>                  interrupt-parent = <&porta>;
>                  interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>          };
> 
>          system-controller@3 {
>                  compatible = "amd,pensando-elbasr";
>                  reg = <3>;
>                  spi-max-frequency = <12000000>;
>          };
> };

You replied with quite a response of which 90% is unrelated talk about
driver. Please be specific. We talk here only about hardware.

Your last DTS might be the answer, but you never explicitly wrote it...
So let's check if I understand it correctly. Only some of elbasr block
contain reset control?

This however does not answer my questions before.... You keep ignoring
them. So please answer yes or no:

"Are there other sub-devices?"
" and your binding is incomplete?"

and a new question:
"Is reset block (amd,pensando-elbasr-reset) re-usable so it will appear
in different device (not in amd,pensando-elbasr)?"

Because from what you wrote you should just put reset-cells in the parent...



Best regards,
Krzysztof
