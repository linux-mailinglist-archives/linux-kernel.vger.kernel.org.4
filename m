Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBDB600730
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJQHBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQHBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:01:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002C4C03C;
        Mon, 17 Oct 2022 00:01:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l22so14652670edj.5;
        Mon, 17 Oct 2022 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SbuCK4+TUS44p61m6NGSZsifm+r2eCwfet5xfYBVG0=;
        b=SI8ZTlozLpKskyFQ/rOxbCKIFdqZ56laUR7fW0cpJjJN526bZEtq3V0FWxh31qVdaA
         1hiRvgeqwjmD8Iyn+acZTwPgT/uPUadoGQuLUhFdSrvNVUNEDBeZ4dpfv7FAxum2T70e
         AbueX2+sw3mVSXPJIfvQG/4aPzWnnjEgjp/r0VdqlTSy+b6diGXIYDuHUbDbeJGD4EYd
         prxNEVnkJTjQSfxA8R3yZ1tNlhgaagitpX/acZkR3pC6OoqWfnLV1qgtu4+prlSfFYM2
         29uMcg5Yjd6wnf8zMc36RJExmh55d4xs/ZAIILpBzXXEtTDL5m4DlZM8/hAyT7/7xTYI
         ROkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SbuCK4+TUS44p61m6NGSZsifm+r2eCwfet5xfYBVG0=;
        b=xViafjs9B7sDnthshVBZmqoPE5CxPaLPze3CS/bTBzmiLAQodIbPAqNJg7vn9quGFy
         bNBU9IJ/QqCMk2Hz/aUhVU/c7fpDreF/YVbHUcPbn5N4c3VTK+So5cX7CtvvqjNYInag
         MI/Qx9s2+NbCG5UTP4v1Ptiivz9RV9KMBtyO7QwAi/apBeIs3Dsg0F8qxTvDGMiLIf+O
         L/AK2w4/iGJReQzSV3EwXdFLFhwpOnVSuan4h4ix3Ehj0qJXN6+Db5VkhD+Q6QGS7wio
         R/BnrwuJ+KGZt+rE84ofWszSzyk932JhVc50lWEIepG+J5lNz7w9VgJg5w5MluGH86D3
         8L0w==
X-Gm-Message-State: ACrzQf0bVOI4/qh3gFgF+uz7VMai/oBtQckKCgBd17ft4KbAL7t6at/0
        Bevb5+lBWLR+4mpzS33/Bwkj4/MEXSI=
X-Google-Smtp-Source: AMsMyM5mDSHQxF+qmAL3Kc+ry6flEBORYD3VyQl2Lc3ddj5CFuzfYFbQvvqNXWotaGMpybI2tP939Q==
X-Received: by 2002:a05:6402:1e88:b0:45d:88f:4b99 with SMTP id f8-20020a0564021e8800b0045d088f4b99mr9196072edf.236.1665990061562;
        Mon, 17 Oct 2022 00:01:01 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.15.51])
        by smtp.gmail.com with ESMTPSA id i24-20020a056402055800b004588ef795easm6818750edx.34.2022.10.17.00.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:01:01 -0700 (PDT)
Message-ID: <8d8c6138-7c8b-d3cb-d741-dc20eb489f45@gmail.com>
Date:   Mon, 17 Oct 2022 10:01:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support more
 parts
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
 <20221014163718.00000042@huawei.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20221014163718.00000042@huawei.com>
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



On 10/14/22 18:37, Jonathan Cameron wrote:
> On Fri, 14 Oct 2022 15:37:23 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
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
> 
> If they 'work' but with fewer features, perhaps a fallback
> compatible?
> 

10 channels vs 20 channels. Using ltc2983 compatible as fallback
would allow you to have 10 non-functional channels specified in the
dts.

>> The LTM2985 is software-compatible with the LTC2986.
> 
> Fallback compatible?
> 
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
> 
> Definitely a lesson here in avoiding device names in the descriptions!
> 
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
> 
> Ah. This is a bit odd as it's fixed for the channel type.  However there
> is precedence in this binding so fair enough.
> 

I think it

>> +
>> +      adi,single-ended:
>> +        description: Boolean property which sets the sensor as single-ended.
>> +        type: boolean
>> +
>> +      adi,custom-temp:
>> +        description:
>> +          This is a table, where each entry should be a pair of
>> +          voltage(mv)-temperature(K). The entries must be given in nv and uK
>> +          so that, the original values must be multiplied by 1000000. For
>> +          more details look at table 71 and 72.
>> +          Note should be signed, but dtc doesn't currently maintain the
>> +          sign.
>> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
>> +        minItems: 3
>> +        maxItems: 64
>> +        items:
>> +          minItems: 2
>> +          maxItems: 2
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
