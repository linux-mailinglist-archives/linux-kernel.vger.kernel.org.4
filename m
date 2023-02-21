Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613B369DE98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjBULSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjBULR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:17:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DDB4688
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:17:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ee7so599894edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJ1x6C2VKBSV6s1tMpyf73V5z12vCyZrSVBl0x7vsmo=;
        b=voVLDUTO3rrUUGgazbeipG5F5BaOlR4var55S79FhPRMRVOYRicNRXxL0jxKebEYBX
         x2oMswxoitxwWm1+ssikjDjtPDKv2xzWA7Jqq8Seh+vuWZ2k3iX5Uq8Ne+/iwgW0X7nO
         3sxo1aMYGG6Kp47eDRrt8QiNl/rt2BIhF8ltxY+NtiniKDSUAUuh49BtJRCNvdFPv6lW
         QK+C3iXbS5uoUP9iHMvMSygMqkKIclYmtRUZYwa6f9iCQQ2v4gmdIJorPjRSca71Eeau
         CkV3NijPr+Zbd4QJhc3JqRikxnuAQxJGdCkfiwFFqvyGXtbbDMhfwDKSrke6vHt3AnOL
         QE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ1x6C2VKBSV6s1tMpyf73V5z12vCyZrSVBl0x7vsmo=;
        b=66CImQt38O7PQXiyEh/Us2Q7xze4iaamF91jUv8RaAYcfxiS1uV90Bim6XTdfa4cPG
         4MKjN8hrF9BLvORvFVBjqbLLJg6ikHZB0HTM6kLdTduMnfFrBVvxGN51gVaQFnYPOxMt
         rETapLNxFFqCh3cEI15ZYc28ROmAk2WGJuOPLHHRdwt8gFahC1scpQnWrsXzB9oGC5nb
         e7w6zszHlUEUtdB1rfm0m3MTp7T+hyIQtHIOjK1rP/0MW880IenwJH2skye4BYD0DR3n
         Gu0FWUtaD1SCQtqQoLrqaySoD2cHudBcO4w6V4sfPpywc6QiIDQLYqwvAbTLzkOqADKm
         eZ6g==
X-Gm-Message-State: AO0yUKXR40fyQ/EzvarKZ330oL+YtdwmEXDwwVMbYlu5RLWlntB8grb3
        tYHbUdedI/pG/re8KicoGOyyvg==
X-Google-Smtp-Source: AK7set9Jn1by8l5Y+Jgkzg/fWri+q/h674IHz2NgKw1ovTQUhbYLqJEP79ZNNiV7pTPM+TxQaR23UQ==
X-Received: by 2002:aa7:c2c7:0:b0:4ac:d30d:c3a3 with SMTP id m7-20020aa7c2c7000000b004acd30dc3a3mr3050836edp.32.1676978273192;
        Tue, 21 Feb 2023 03:17:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g10-20020a50d5ca000000b004a21263bbaasm1329057edj.49.2023.02.21.03.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:17:52 -0800 (PST)
Message-ID: <8de5a3bb-a0b1-8d69-cf61-0c33f42c56f6@linaro.org>
Date:   Tue, 21 Feb 2023 12:17:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: mfd: Add DT bindings for TI TPS6594
 PMIC
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4e64838c-b727-923b-b6d5-413a0681977c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 13:10, Julien Panis wrote:
> 
> On 2/17/23 10:06, Krzysztof Kozlowski wrote:
>> On 16/02/2023 12:44, Julien Panis wrote:
>>> TPS6594 is a Power Management IC which provides regulators and others
>> Subject: drop second/last, redundant "DT bindings for". The
>> "dt-bindings" prefix is already stating that these are bindings.
>>
>>
>>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>>> device.
>>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>> ---
>>>   .../devicetree/bindings/mfd/ti,tps6594.yaml   | 164 ++++++++++++++++++
>>>   1 file changed, 164 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>> new file mode 100644
>>> index 000000000000..37968d6c0420
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>> @@ -0,0 +1,164 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/ti,tps6594.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI TPS6594 Power Management Integrated Circuit
>>> +
>>> +maintainers:
>>> +  - Julien Panis <jpanis@baylibre.com>
>>> +
>>> +description: |
>>> +  TPS6594 is a Power Management IC which provides regulators and others
>>> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
>>> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,tps6594
>>> +      - ti,tps6593
>>> +      - ti,lp8764x
>> Any particular choice of ordering (different than alphabetical)?
> 
> Thank you for the review.
> 
> I chose this ordering because it emphasizes the fact that tps6593 and 
> lp8764x
> are derivatives of tps6594 : tps6593 is nearly the same (a minor feature 
> is not
> supported), and lp8764x has less resources (less bucks/LDO, and no RTC).
> 
> Besides, a multi-PMIC synchronization scheme is implemented in the PMIC 
> device
> to synchronize the power state changes with other PMIC devices. This is done
> through a SPMI bus : the master PMIC is the controller device on the 
> SPMI bus,
> and the slave PMICs are the target devices on the SPMI bus. For the 5 boards
> we work on (for which device trees will be sent in another patch series):
> - tps6594 is used on 3 boards and is always master (multi-PMIC config)
> - tps6593 is used on 1 board and is master (single-PMIC config)
> - lp8764x is used on 2 boards and is always slave (multi-PMIC config)
> There might not be situations in which lp8764x would be master and tps6594
> or tps6593 would be slave.
> 
> That's why I preferred this ordering.
> 
> Do you think that alphabetical order would be better ?

It's simpler (requires no knowledge about chips) and reduces the future
conflicts. It's fine to keep it also ordered like you said, although I
wonder how other people adding new compatibles here will figure it out...

> 
>>
>>> +
>>> +  reg:
>>> +    description: I2C slave address or SPI chip select number.
>>> +    maxItems: 1
>>> +
>>> +  ti,use-crc:
>>> +    type: boolean
>>> +    description: If true, use CRC for I2C and SPI interface protocols.
>> Hm, why different boards would like to enable or disable it? Why this
>> suits DT?
> 
> You're right. Reading your comment, it appears to me that CRC feature is 
> not fully
> related to HW description and should not be set in DT.
> 
> CRC is not 'fully' related to HW, but...
> For CRC feature as well, PMICs are synchronized (for boards with 
> multi-PMIC config).
> To use CRC mode, this feature must be requested explicitly on the master 
> PMIC
> through I2C or SPI driver, then it is enabled for the slave PMICs 
> through SPMI bus: that
> sync is performed 'automatically', without intervention from the I2C or 
> SPI driver to
> enable CRC on slave PMICs.
> As a consequence, CRC feature is enabled for all PMICs at I2C/SPI driver 
> probe,
> or it is let disabled for all PMICs. But it can't be enabled for one 
> PMIC and disabled
> for another one.
> 
> This will probably rediscussed for I2C/SPI drivers, but do you think 
> that a 'use_crc'
> driver parameter would be an acceptable solution ? If so, the master 
> PMIC would have
> to be identified, so that the driver can explicitly enable CRC mode for 
> this one if
> 'use_crc' is true. With this solution, some 'ti,is-master;' bool 
> property would be necessary.

It looks the property should be only in the drivers, not in the DT.
> 
>>
>>> +
>>> +  system-power-controller: true
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  ti,multi-phase-id:
>>> +    description: |
>>> +      Describes buck multi-phase configuration, if any. For instance, XY id means
>>> +      that outputs of buck converters X and Y are combined in multi-phase mode.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [12, 34, 123, 1234]
>>> +
>>> +patternProperties:
>>> +  "^buck([1-5]|12|34|123|1234)-supply$":
>>> +    description: Input supply phandle for each buck.
>>> +
>>> +  "^ldo[1-4]-supply$":
>>> +    description: Input supply phandle for each ldo.
>>> +
>>> +  regulators:
>> This should go to properties, not patternProperties.
>>
>>> +    type: object
>>> +    description: List of regulators provided by this controller.
>>> +
>>> +    patternProperties:
>>> +      "^buck([1-5]|12|34|123|1234)$":
>>> +        type: object
>>> +        $ref: /schemas/regulator/regulator.yaml#
>>> +
>>> +        unevaluatedProperties: false
>>> +
>>> +      "^ldo[1-4]$":
>>> +        type: object
>>> +        $ref: /schemas/regulator/regulator.yaml#
>>> +
>>> +        unevaluatedProperties: false
>>> +
>> You could add here - on this level - of indentation allOf:if for
>> excluding setups
>>
>> if:
>>    required:
>>      - buck12
>> then:
>>    properties:
>>      buck123: false
>>      buck1234: false
>>
>> Or, if you want to require regulator then:
>> oneOf:
>>    - required:
>>        - buck12
>>    - required:
>>        - buck123
>>    - required:
>>        - buck1234
>>
>> and anyway exclude buck34 with two above.
> 
> I am not sure that we have the same understanding of the multi-phase setup.
> Maybe the description I wrote is not clear enough (?) Or I just don't 
> understand
> what you mean exactly.
> 
> How would you combine outputs of bucks 3 and 4 ?

No one discusses here changing this...

> We use 'buck34' property to mean that:
>   - buck1 output is mono-phase,
>   - buck2 output is mono-phase,
>   - buck3 and buck4 outputs are combined (i.e. multi-phases).
> This weird configuration is supported by these PMICs.
> 
> Using a PMIC without using the provided regulators does not seem very 
> interesting
> indeed.
> But strictly speaking, these regulators are not required. One could use 
> some others
> resources provided by the PMIC (the Error Signal Monitor device for 
> instance).

Then the first method.

> Besides, multi-phase mode depends on the chosen design and is not 
> required for
> all situations.

Sorry, I don't think it is related to the topic I proposed.


Best regards,
Krzysztof

