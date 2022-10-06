Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2515F697F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJFOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJFOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:22:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA5C1901B;
        Thu,  6 Oct 2022 07:22:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h13so749065pfr.7;
        Thu, 06 Oct 2022 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmueKib6Yvg9lEscOYsyc+BDqrMCWCE9HfmE95cBqF0=;
        b=CNF6Je3Dm62b/vJZmXcZ0fo7cZ53FsYSy8NK2G3y/3w/8mEvivBcACubUbrfONjxDo
         fTwi+Nm5WKPvFoh6E4yLUsfsYy0YxU7cmFvLfO7MBPGaTZc3dayy4nQh+o7huPdMS9zD
         atuSlLVqGZa/r+57SVCR4Kcuh5CwrB0OwsH9hu38iMiN9JaiUeZLLZ2hwXKeKNSo41Ky
         r1CLaHeWdur1nZUKhOqh3cmi5p7flUdCF01CzIKuF2sK4kf0cfOc3nsVcI8UAX7qe1e9
         ZeNRxhcYRta/M/QTuXFqN6o2JJGn/vw9WgP6UJYDcgeuexppd6Z/mos+Syf9tnEQC/Po
         CgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmueKib6Yvg9lEscOYsyc+BDqrMCWCE9HfmE95cBqF0=;
        b=lgWuHgAgiK36lKiKF5ZlpXXzC5ajWdHZ92MbmOJMNPcKt6sPCvEmvrYFIhdKp4igKH
         TgTxFnY1VEV+MCTFhYZ4+Vn323+Q+dMMo71/O+ECvCSkZwqdfoamn474tRZiV2/DOklV
         0IyotyMfeJoUL5UdEb+GHjUeblwYOoIc0QEJTtE1vplb06ATYUVHNIQwGiCaAYgN/SJC
         ghL5qvVju8imcCP4Y6G6pKiOBHmQB1NlW8YGc+wTqMg6QFruMXrRMdjatMwygh9vYQo2
         jem8/3d5NlYPIwE6OkTpAMBlkGWT0Qi1cr9GBlvicgxnjbOJppbI9/YeqDW4/Lk9K7IB
         eF+g==
X-Gm-Message-State: ACrzQf1+sPhLY4fw/tDqdXY1DwxUe+egPg7JKm074kXO7E0YGU7H0T5A
        RArC81WdUrX2eY6MLFaehJQ=
X-Google-Smtp-Source: AMsMyM5INbjubqAiKSF1MSGZWQd/cFN/3HvLmHUcKtmIuzRBlgDU/IpNPwZ8xHGSP7xbzTcCvO/1hg==
X-Received: by 2002:a63:f349:0:b0:43a:b82b:1173 with SMTP id t9-20020a63f349000000b0043ab82b1173mr148057pgj.534.1665066127524;
        Thu, 06 Oct 2022 07:22:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a24-20020a656418000000b00451bcda6e86sm1882565pgv.19.2022.10.06.07.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 07:22:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9cdb6849-9dbb-7b5d-7710-55846284fc43@roeck-us.net>
Date:   Thu, 6 Oct 2022 07:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20220922050718.1079651-1-Naresh.Solanki@9elements.com>
 <20220922050718.1079651-2-Naresh.Solanki@9elements.com>
 <3003378d-4283-6c05-50bf-29178c97ef8e@linaro.org>
 <a55d973b-4504-a104-a889-f9b7e264c1e9@roeck-us.net>
 <CABqG17hprsbHkDnvuXkQaaJdbuNgkuZD_G8L7M9HX=w5bYo8rQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
In-Reply-To: <CABqG17hprsbHkDnvuXkQaaJdbuNgkuZD_G8L7M9HX=w5bYo8rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 23:30, Naresh Solanki wrote:
> Thanks Guenter, to summarize below properties that can be configured
> based on input from
> fan datasheet:
> pwm controlled fan:
> 1.  max-rpm : Defines maximum rpm the fan supports
> 2.  tach-pulse/pulse-per-revolution( also referred as prescale) :
> Determines the number of
>   pulses received from the sensor/tach pin of fan per revolution.

There are two different parameters: pulse-per-revolution is the number
of pulses per revolution from the fan. Then there is a chip internal
divider, used to ensure that the chip fan counter does not exceed
its limits. Both are needed and orthogonal.

 From the max6650 description:

- maxim,fan-prescale  : Pre-scaling value, as per datasheet [1]. Lower values
                         allow more fine-grained control of slower fans.
                         Valid: 1, 2, 4, 8, 16.

This has nothing to do with pulse-per-revolution (there are no fans
with 16 pulses per revolution). The range for pulse-per-revolution
is typically 1..4.

Also see /sys/class/hwmon/hwmonX/fanY_pulses and /sys/class/hwmon/hwmonX/fanY_div
in Documentation/ABI/testing/sysfs-class-hwmon                                                                                                                                                            <216,37>-46 24%.

> 3.  rpm-init (also ref. as fan-target-rpm): Determines the fan rpm
> driver needs to configure
> during probe.

This has nothing to do with an "init" value. It is the fan target rpm.
Also see /sys/class/hwmon/hwmonX/fanY_target.

> 4. pwm-input-polarity(normal or inverse) : Specifies fan pwm input
> polarity as specified in
>   fan datasheet. a fan controller driver can use this data to configure
> pwm output polarity

This has nothing to do with fan requirements. It is the output polarity
from the chip, period. There can be an inverter between pwm output and the
fan input, which is the most likely reason why the output has to be inverted.

> accordingly during driver probe.
> 
> For a DC output controlled fan, voltage across fan is controlled to control rpm.
> Below is what I can think of:
> 5. voltage-range : Specifies valid voltage range for rpm control
> example for 3V to 5V range:
>       voltage-range=<3000 5000>;

I never heard about that option. Usually fan controllers convert the provided
or calculated pwm value into a voltage if DC mode is configured. What may be
needed is the fan supply voltage, which can be provided by a regulator.

What is also needed is a means to switch the fan controller between
DC mode and PWM mode (matching /sys/class/hwmon/hwmonX/pwmY_mode).

I would also expect the ability to set the pwm frequency (matching
/sys/class/hwmon/hwmonX/pwmY_freq).

Thanks,
Guenter

> 
> Above mentioned properties are within the scope of fan.
> Fan controllers like max6639/max6650 etc can have additional
> properties specific to the
> feather supported by the chip.
> 
> Let me know if I can go ahead with this.
> 
> Thanks,
> Naresh Solanki
> 
> Regards,
> Naresh Solanki
> 
> 
> 
> 9elements GmbH, Kortumstraße 19-21, 44787 Bochum, Germany
> Email:  naresh.solanki@9elements.com
> Mobile:  +91 9538631477
> 
> Sitz der Gesellschaft: Bochum
> Handelsregister: Amtsgericht Bochum, HRB 17519
> Geschäftsführung: Sebastian Deutsch, Eray Basar
> 
> Datenschutzhinweise nach Art. 13 DSGVO
> 
> 
> On Thu, 6 Oct 2022 at 00:10, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 9/21/22 23:34, Krzysztof Kozlowski wrote:
>>> On 22/09/2022 07:07, Naresh Solanki wrote:
>>>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>>>
>>>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>>>> monitor with PWM fan-speed controller.
>>>>
>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>>    .../bindings/hwmon/maxim,max6639.yaml         | 112 ++++++++++++++++++
>>>>    1 file changed, 112 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> new file mode 100644
>>>> index 000000000000..c845fb989af2
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> @@ -0,0 +1,112 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +
>>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Maxim max6639
>>>> +
>>>> +maintainers:
>>>> +  - Roland Stigge <stigge@antcom.de>
>>>
>>> Ack from Roland is needed here.
>>>
>>>> +
>>>> +description: |
>>>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>>>> +  fan-speed controller.  It monitors its own temperature and one external
>>>> +  diode-connected transistor or the temperatures of two external diode-connected
>>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>>> +
>>>> +  Datasheets:
>>>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - maxim,max6639
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  '#address-cells':
>>>> +    const: 1
>>>> +
>>>> +  '#size-cells':
>>>> +    const: 0
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - "fan@0"
>>>> +  - "fan@1"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +patternProperties:
>>>
>>> This goes after properties.
>>>
>>>> +  "^fan@[0-1]$":
>>>> +    type: object
>>>> +    description: |
>>>> +      Represents the two fans and their specific configuration.
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        description: |
>>>> +          The fan number.
>>>> +        items:
>>>
>>> Skip items.
>>>
>>>> +          minimum: 0
>>>> +          maximum: 1
>>>> +
>>>> +      pwm-polarity:
>>>
>>> Why is this property of fan, not of PWM source?
>>>
>>
>> The chip provides pwm output to the fan. That typical for fan
>> controller chips. Typically they also have options to configure
>> the pwm frequency and either pwm or DC output (max6639 does not
>> have the latter option).
>>
>> Guenter

