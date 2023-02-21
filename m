Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE369E2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjBUOt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBUOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:49:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AFA1C301
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:49:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g1so17952219edz.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2m6GeHfYXzVaSr3VckfJrn4hduzvo0x539FyIhmfDs=;
        b=laWx5JPNYJgCQqBAnvYC1Dvh7aTIuYigy7pErJqHZIOfE62XB7z+DQr5zVO7mXAaS5
         JlMXuxoCPfolaT1mShJr0Kzy9o7x0bArn/wen1mDDbis7ObqpVlBJOuumRJVQkVYtknD
         gprvL2XG4pVFH/jkGcpF0tdDt1/UqbjDT6+SdZoFJ2O3jmlbhKaNkgbSrfgLjHSowK0G
         LuQrb5se2rRdqICHQlUt5SLOCp5TtmTvih9eQcUNe2gZKs9t0eeLxQJUSGgvoZnvBkG0
         WRw5uUH471m1FT4NmudtR8TOd6X4ndbWZyE1LziqnzpHzn+SiWAmVBmOVVe0U6OFUa0V
         l06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2m6GeHfYXzVaSr3VckfJrn4hduzvo0x539FyIhmfDs=;
        b=Jp1ksf7XmOS7yfJGt9K2jc66soOuajOCpGca/7MU7aXZOxcTtbts54SbC3mTCJ0upR
         eMjgHlEKfWR056fCct/YsDBqBgmzvJnpXwDXejAA0GPHR77hwyao+Ujo9B5+xiQGwTOQ
         C9bHBXO0nqWVIyJn7ivKdWZgGf7Wzc4ym9OEXEBB7ay6beORY5aNRlnhedzfbSVaVpjV
         0FyGonDvK4j4gYOLDO3OnCozfu88ICdmNrsVCX+i828VceRymUalRqoLl2YLb8AMGHUF
         8X3aK4gfotqAykZJh8JFbC2eCgtKn8gU7stZ9WeJeLlk2H3olCuwTAUS07udHUZrHSmv
         q4XQ==
X-Gm-Message-State: AO0yUKVjQk8dvyQG7wGhXy/cbJE1KMjemL4b4VW640HmFK8gQsL228Rm
        iaft8gSnI+cGjTEhfI3pujE5GA==
X-Google-Smtp-Source: AK7set83TDYqLloq+McepeVv6RvAXS8Xv4zUfUNaIcna2HGfOzuukEfezRsolIELB/r/xPDeDPFdzQ==
X-Received: by 2002:a05:6402:3cb:b0:4ac:d2b4:5e37 with SMTP id t11-20020a05640203cb00b004acd2b45e37mr5640091edw.39.1676990959083;
        Tue, 21 Feb 2023 06:49:19 -0800 (PST)
Received: from [192.168.1.70] (125.62.71.86.rev.sfr.net. [86.71.62.125])
        by smtp.gmail.com with ESMTPSA id y21-20020a056402359500b004ab33d52d03sm3133400edc.22.2023.02.21.06.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 06:49:18 -0800 (PST)
Message-ID: <85183c04-40e3-fd97-c4ca-06795fe99e40@baylibre.com>
Date:   Tue, 21 Feb 2023 15:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/4] dt-bindings: mfd: Add DT bindings for TI TPS6594
 PMIC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net
Cc:     hdegoede@redhat.com, eric.auger@redhat.com, jgg@ziepe.ca,
        razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
References: <20230216114410.183489-1-jpanis@baylibre.com>
 <20230216114410.183489-2-jpanis@baylibre.com>
 <c50503f0-dce1-a3b0-2973-8a22b5ef8bc2@linaro.org>
 <4e64838c-b727-923b-b6d5-413a0681977c@baylibre.com>
 <8de5a3bb-a0b1-8d69-cf61-0c33f42c56f6@linaro.org>
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <8de5a3bb-a0b1-8d69-cf61-0c33f42c56f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/23 12:17, Krzysztof Kozlowski wrote:
> On 17/02/2023 13:10, Julien Panis wrote:
>> On 2/17/23 10:06, Krzysztof Kozlowski wrote:
>>> On 16/02/2023 12:44, Julien Panis wrote:
>>>> TPS6594 is a Power Management IC which provides regulators and others
>>> Subject: drop second/last, redundant "DT bindings for". The
>>> "dt-bindings" prefix is already stating that these are bindings.
>>>
>>>
>>>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>>>> device.
>>>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>>
>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>> ---
>>>>    .../devicetree/bindings/mfd/ti,tps6594.yaml   | 164 ++++++++++++++++++
>>>>    1 file changed, 164 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>> new file mode 100644
>>>> index 000000000000..37968d6c0420
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>> @@ -0,0 +1,164 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/mfd/ti,tps6594.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: TI TPS6594 Power Management Integrated Circuit
>>>> +
>>>> +maintainers:
>>>> +  - Julien Panis <jpanis@baylibre.com>
>>>> +
>>>> +description: |
>>>> +  TPS6594 is a Power Management IC which provides regulators and others
>>>> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
>>>> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,tps6594
>>>> +      - ti,tps6593
>>>> +      - ti,lp8764x
>>> Any particular choice of ordering (different than alphabetical)?
>> Thank you for the review.
>>
>> I chose this ordering because it emphasizes the fact that tps6593 and
>> lp8764x
>> are derivatives of tps6594 : tps6593 is nearly the same (a minor feature
>> is not
>> supported), and lp8764x has less resources (less bucks/LDO, and no RTC).
>>
>> Besides, a multi-PMIC synchronization scheme is implemented in the PMIC
>> device
>> to synchronize the power state changes with other PMIC devices. This is done
>> through a SPMI bus : the master PMIC is the controller device on the
>> SPMI bus,
>> and the slave PMICs are the target devices on the SPMI bus. For the 5 boards
>> we work on (for which device trees will be sent in another patch series):
>> - tps6594 is used on 3 boards and is always master (multi-PMIC config)
>> - tps6593 is used on 1 board and is master (single-PMIC config)
>> - lp8764x is used on 2 boards and is always slave (multi-PMIC config)
>> There might not be situations in which lp8764x would be master and tps6594
>> or tps6593 would be slave.
>>
>> That's why I preferred this ordering.
>>
>> Do you think that alphabetical order would be better ?
> It's simpler (requires no knowledge about chips) and reduces the future
> conflicts. It's fine to keep it also ordered like you said, although I
> wonder how other people adding new compatibles here will figure it out...

I will reorder it alphabetically in v2.

>
>>>> +
>>>> +  reg:
>>>> +    description: I2C slave address or SPI chip select number.
>>>> +    maxItems: 1
>>>> +
>>>> +  ti,use-crc:
>>>> +    type: boolean
>>>> +    description: If true, use CRC for I2C and SPI interface protocols.
>>> Hm, why different boards would like to enable or disable it? Why this
>>> suits DT?
>> You're right. Reading your comment, it appears to me that CRC feature is
>> not fully
>> related to HW description and should not be set in DT.
>>
>> CRC is not 'fully' related to HW, but...
>> For CRC feature as well, PMICs are synchronized (for boards with
>> multi-PMIC config).
>> To use CRC mode, this feature must be requested explicitly on the master
>> PMIC
>> through I2C or SPI driver, then it is enabled for the slave PMICs
>> through SPMI bus: that
>> sync is performed 'automatically', without intervention from the I2C or
>> SPI driver to
>> enable CRC on slave PMICs.
>> As a consequence, CRC feature is enabled for all PMICs at I2C/SPI driver
>> probe,
>> or it is let disabled for all PMICs. But it can't be enabled for one
>> PMIC and disabled
>> for another one.
>>
>> This will probably rediscussed for I2C/SPI drivers, but do you think
>> that a 'use_crc'
>> driver parameter would be an acceptable solution ? If so, the master
>> PMIC would have
>> to be identified, so that the driver can explicitly enable CRC mode for
>> this one if
>> 'use_crc' is true. With this solution, some 'ti,is-master;' bool
>> property would be necessary.
> It looks the property should be only in the drivers, not in the DT.

I will remove 'ti,use-crc;' property from the DT. This will be only in
the driver.
Do you also consider that a property such as 'ti,is-secondary-pmic;'
would not be acceptable either ? From driver point of view, this
primary/secondary role on SPMI bus is a 'built-in' property of the
PMIC (CRC must be enabled only via primary PMIC but using the
primary PMIC does not imply that CRC is necessarily used).

>>>> +
>>>> +  system-power-controller: true
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  ti,multi-phase-id:
>>>> +    description: |
>>>> +      Describes buck multi-phase configuration, if any. For instance, XY id means
>>>> +      that outputs of buck converters X and Y are combined in multi-phase mode.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [12, 34, 123, 1234]
>>>> +
>>>> +patternProperties:
>>>> +  "^buck([1-5]|12|34|123|1234)-supply$":
>>>> +    description: Input supply phandle for each buck.
>>>> +
>>>> +  "^ldo[1-4]-supply$":
>>>> +    description: Input supply phandle for each ldo.
>>>> +
>>>> +  regulators:
>>> This should go to properties, not patternProperties.
>>>
>>>> +    type: object
>>>> +    description: List of regulators provided by this controller.
>>>> +
>>>> +    patternProperties:
>>>> +      "^buck([1-5]|12|34|123|1234)$":
>>>> +        type: object
>>>> +        $ref: /schemas/regulator/regulator.yaml#
>>>> +
>>>> +        unevaluatedProperties: false
>>>> +
>>>> +      "^ldo[1-4]$":
>>>> +        type: object
>>>> +        $ref: /schemas/regulator/regulator.yaml#
>>>> +
>>>> +        unevaluatedProperties: false
>>>> +
>>> You could add here - on this level - of indentation allOf:if for
>>> excluding setups
>>>
>>> if:
>>>     required:
>>>       - buck12
>>> then:
>>>     properties:
>>>       buck123: false
>>>       buck1234: false
>>>
>>> Or, if you want to require regulator then:
>>> oneOf:
>>>     - required:
>>>         - buck12
>>>     - required:
>>>         - buck123
>>>     - required:
>>>         - buck1234
>>>
>>> and anyway exclude buck34 with two above.
>> I am not sure that we have the same understanding of the multi-phase setup.
>> Maybe the description I wrote is not clear enough (?) Or I just don't
>> understand
>> what you mean exactly.
>>
>> How would you combine outputs of bucks 3 and 4 ?
> No one discusses here changing this...
>
>> We use 'buck34' property to mean that:
>>    - buck1 output is mono-phase,
>>    - buck2 output is mono-phase,
>>    - buck3 and buck4 outputs are combined (i.e. multi-phases).
>> This weird configuration is supported by these PMICs.
>>
>> Using a PMIC without using the provided regulators does not seem very
>> interesting
>> indeed.
>> But strictly speaking, these regulators are not required. One could use
>> some others
>> resources provided by the PMIC (the Error Signal Monitor device for
>> instance).
> Then the first method.

OK. Regarding buck34, it might be unnecessary and could finally be
removed in v2. If we keep it, my understanding of your suggestion is:
allOf:
   - if:
        required:
         - buck12
     then:
       properties:
         buck123: false
         buck1234: false
   - if:
       required:
         - buck123
     then:
       properties:
         buck34: false
   - if:
       required:
         - buck1234
      then:
         properties:
           buck34: false

>
>> Besides, multi-phase mode depends on the chosen design and is not
>> required for
>> all situations.
> Sorry, I don't think it is related to the topic I proposed.
>
>
> Best regards,
> Krzysztof
>

Julien
