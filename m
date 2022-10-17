Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4B600717
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJQGzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJQGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:54:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC7B57BDA;
        Sun, 16 Oct 2022 23:53:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so22619903ejb.13;
        Sun, 16 Oct 2022 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/3NpQ0ZBaztoeNYGAe7LJCUGfQy7VJMjzEiuh+gY7Y=;
        b=AFvWzomiXbhtKsc2x/SCtqIo9pducTqd1zpeipa9LSbfiereIvEf0kFdEG7/FLv5CK
         a842axV34hF4xYRS3Xkx9Ny8oD97MM5wTFuO0mVJzOHma61Mc8YT9kytjclZJTZujaF8
         2Siv7vOEmdgzde0GItzsukTINHDWI0VKdqrai/atoJFyoLhgajFlLMdUvqPc88Ir6p0z
         JbmdHehfpJRcLap4KbgYkfJeNIGkORe79s6ps7+pOy0BGEjloBK21Mhcj13d3TQ1Iq/G
         qVsziGhPM3oReoWeGBZiRX2umPqZuVPu65BFRS383jtOrsyrD8WXb5MW64Q+FOvLjOKn
         Uv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/3NpQ0ZBaztoeNYGAe7LJCUGfQy7VJMjzEiuh+gY7Y=;
        b=yWyPUikOaUbP8NABVFQgb9KyvUQ6y3TS1KWi/oQZTJuQmu2pXRdnZWcOhWdZ63Jt8k
         Z94pqlqPXrXF7B/3sYOJb1gFXJKGYZfMZ2IEM3sI7xILiHheHpR1mG/r8bTKojLi4Usw
         zOzubI6SY/HiLRudSCrKuhMy/ZaiyNynO65tXIhXDDNpnPlBVIcJjcVlA8DLH7Fgwljh
         f+ONMIGR1bHSThaPjn6crlguGi8hZsIVyOqO/ODoSFyXQFJmMnsPYJ5+Bu3b5/1RTZ/T
         vBomW6AF7r7Yx2ed2yB8NuGo64EPRLTbUvYVneGreO261Zvykdmqo5MoiJyXB5SqbQkr
         Ix3w==
X-Gm-Message-State: ACrzQf3xs3G3A1czOPeEWIUDVnd3ktjRWEM19pPqThex7ylFil9f3hNT
        D2zp0ISJHFvfmzZuGa+BsGEoWB04rA0=
X-Google-Smtp-Source: AMsMyM78jrxgWy5xtu7OsRJqLNpSMp4HH41AOhyrm47z0MCeiDrYMpzTAT18P9I+HKzwnyt6jeQnWw==
X-Received: by 2002:a17:907:96a3:b0:790:65a:3a0a with SMTP id hd35-20020a17090796a300b00790065a3a0amr6782183ejc.728.1665989618459;
        Sun, 16 Oct 2022 23:53:38 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.15.51])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b0077b2b0563f4sm5687132ejd.173.2022.10.16.23.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:53:38 -0700 (PDT)
Message-ID: <df784d20-0464-ad08-178a-1639d313489b@gmail.com>
Date:   Mon, 17 Oct 2022 09:53:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support more
 parts
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
 <20221014123724.1401011-3-demonsingur@gmail.com>
 <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
Content-Language: en-US
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/22 04:59, Krzysztof Kozlowski wrote:
> On 14/10/2022 08:37, Cosmin Tanislav wrote:
>> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>
>> Add support for the following parts:
>>   * LTC2984
>>   * LTC2986
>>   * LTM2985
>>
>> The LTC2984 is a variant of the LTC2983 with EEPROM.
>> The LTC2986 is a variant of the LTC2983 with only 10 channels,
>> EEPROM and support for active analog temperature sensors.
>> The LTM2985 is software-compatible with the LTC2986.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   .../bindings/iio/temperature/adi,ltc2983.yaml | 63 +++++++++++++++++--
>>   1 file changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>> index 722781aa4697..c33ab524fb64 100644
>> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>> @@ -4,19 +4,27 @@
>>   $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Analog Devices LTC2983 Multi-sensor Temperature system
>> +title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
>>   
>>   maintainers:
>>     - Nuno Sá <nuno.sa@analog.com>
>>   
>>   description: |
>> -  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
>> +  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
>> +  Temperature Measurement Systems
>> +
>>     https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
>>   
>>   properties:
>>     compatible:
>>       enum:
>>         - adi,ltc2983
>> +      - adi,ltc2984
>> +      - adi,ltc2986
>> +      - adi,ltm2985
>>   
>>     reg:
>>       maxItems: 1
>> @@ -26,7 +34,7 @@ properties:
>>   
>>     adi,mux-delay-config-us:
>>       description:
>> -      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
>> +      The device performs 2 or 3 internal conversion cycles per temperature
>>         result. Each conversion cycle is performed with different excitation and
>>         input multiplexer configurations. Prior to each conversion, these
>>         excitation circuits and input switch configurations are changed and an
>> @@ -145,7 +153,7 @@ patternProperties:
>>         adi,three-conversion-cycles:
>>           description:
>>             Boolean property which set's three conversion cycles removing
>> -          parasitic resistance effects between the LTC2983 and the diode.
>> +          parasitic resistance effects between the device and the diode.
>>           type: boolean
>>   
>>         adi,average-on:
>> @@ -353,6 +361,41 @@ patternProperties:
>>           description: Boolean property which set's the adc as single-ended.
>>           type: boolean
>>   
>> +  "^temp@":
> 
> There is already a property for thermocouple. Isn't a thermocouple a
> temperature sensor? IOW, why new property is needed?
> 
This node is needed for active analog temperature sensors.
It has fewer options than the thermocouple, as it only supports
a table to map from voltage to temperature and specifying whether
the measurement is differential or single-ended.

If you did as much as glimpsed at the datasheet you would have
understood.

>> +    type: object
>> +    description:
>> +      Represents a channel which is being used as an active analog temperature
>> +      sensor.
>> +
>> +    properties:
>> +      adi,sensor-type:
>> +        description:
>> +          Identifies the sensor as an active analog temperature sensor.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        const: 31
>> +
>> +      adi,single-ended:
>> +        description: Boolean property which sets the sensor as single-ended.
> 
> Drop "Boolean property which sets" - it's obvious from the type.
> 

That's how the rest of the file is written.

> 
> 
>> +        type: boolean
>> +
>> +      adi,custom-temp:
>> +        description:
>> +          This is a table, where each entry should be a pair of
> 
> "This is a table" - obvious from the type.
> 

That's how the rest of the file is written.

>> +          voltage(mv)-temperature(K). The entries must be given in nv and uK
> 
> mv-K or nv-uK? Confusing...

That's how the rest of the file is written.

The chip uses mv-K, but the binding specifies nv-uK, the driver
translates it into the appropriate unit.

> 
>> +          so that, the original values must be multiplied by 1000000. For
>> +          more details look at table 71 and 72.
> 
> There is no table 71 in the bindings... It seems you pasted it from
> somewhere.
> 

It's pretty obvious that "Table" in a binding refers to the datasheet.
But if you meant datasheet, not binding, you're looking at the wrong
datasheet then.
Also, that's how the rest of the file is written.

>> +          Note should be signed, but dtc doesn't currently maintain the
>> +          sign.
> 
> What do you mean? "Maintain" as allow or keep when building FDT?  What's
> the problem of using negative numbers here and why it should be part of
> bindings?
> 

You're really clueless, I'll let you figure it out on your own.
Also, that's how the rest of the file is written.

>> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
>> +        minItems: 3
>> +        maxItems: 64
>> +        items:
>> +          minItems: 2
>> +          maxItems: 2
> 
> Instead describe the items with "description" (and maybe constraints)
> like here:
> 
> https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml#L278
> 

That's how the rest of the file is written.
If you really want to use something different, you can submit a
patch later and fix the whole binding however you want.

>> +
>> +    required:
>> +      - adi,custom-temp
>> +
>>     "^rsense@":
>>       type: object
>>       description:
>> @@ -382,6 +425,18 @@ required:
>>     - reg
>>     - interrupts
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ltc2983
>> +              - adi,ltc2984
>> +    then:
>> +      patternProperties:
>> +        "^temp@": false
>> +
>>   additionalProperties: false
>>   
>>   examples:
> 
> Best regards,
> Krzysztof
> 
