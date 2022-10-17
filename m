Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5CB601D91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJQX1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJQX1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:27:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DA75CD0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:26:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j21so7685146qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4W8JXVxkfTvJKUrbyhKtZjIBoib4NhTlgPSyqKyLEr8=;
        b=G+vsnlgbO5Pa03zpyP7hN0gD4R+Fexe6SltgkEhVExXDjsPDXhr7uCs1sT9C3d4ycS
         76gBD+JCpcWxbpn38i7o6FEmjrM6T5SC3hA1dHBvDyENasXZZ06JhUe2G6gCWPgMsnP7
         QC7HzgTvExFQs1Q+lpcyHm6L6XoBgcTL2KqQ5r4JT6K0QJsF6L4S4wnCJuXe3SuIcKE/
         jWpUX0GF7fOAU45VaJbohmL7r8ucrQC3GIkYuy6Vi348yhipMY2XcrTOJ2sTOY+iGzqc
         ht2Vcrv7PxVrpLHZ6Iq5arwH1RuQEO36Gf2Y7VpG/Rhrv3KpyK0hyDfgbUNLkb85j3kv
         Q/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4W8JXVxkfTvJKUrbyhKtZjIBoib4NhTlgPSyqKyLEr8=;
        b=YeY2/UTtPm+A3G8dXeWYGwGEwcwSLrumXBbcw93UCSzoCKL0yT5/cym+XA44QrKL0I
         0slDoHIeev6h+TfOT7GjhAK96CrWeGNnxMhS8hMWXMgYMKthZmoFzgzvQwUlv8qv+Ayi
         r+dmd7DiZoReC20hCk8ZtqC4cMlwo3gOsdoYfkr9/m0gRyAYHuLfVysChTGWhpgnRxEG
         7gipJK6HfM8Y0IZonPEhjEqkJ/voF4xZFgrVkrCD/aWNQWkBKsQR91H2MMwQPFL/uHaO
         QfxTR3a6tTrVdn6/+pFYrZynU+gQM0q3rqlv49kaRxTbbSqg3K01kTCTcbF8cTQkeU+q
         ig5Q==
X-Gm-Message-State: ACrzQf21BL4/EMp+KIUAd//J+hVkwEAV2Q68tWErtxpdGQJmRzxN2Ugd
        SVM8TFsU2mMf21a/ilLRkhEG2Q==
X-Google-Smtp-Source: AMsMyM4vOBjMwiJtKPS5R4xR7f2wRxpBaUMOkumfB03fAChrdM7d0lETEUVWtQIdGvSvtygV5f0tQA==
X-Received: by 2002:a05:620a:f12:b0:6cf:bf70:9ee4 with SMTP id v18-20020a05620a0f1200b006cfbf709ee4mr35523qkl.608.1666049216422;
        Mon, 17 Oct 2022 16:26:56 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a0e0200b006ee8874f5d8sm899100qkm.28.2022.10.17.16.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 16:26:55 -0700 (PDT)
Message-ID: <78d1d7df-a153-37f6-57c8-289c5ab4b981@linaro.org>
Date:   Mon, 17 Oct 2022 19:26:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support more
 parts
Content-Language: en-US
To:     Cosmin Tanislav <demonsingur@gmail.com>
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
 <df784d20-0464-ad08-178a-1639d313489b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df784d20-0464-ad08-178a-1639d313489b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 02:53, Cosmin Tanislav wrote:
> 
> 
> On 10/17/22 04:59, Krzysztof Kozlowski wrote:
>> On 14/10/2022 08:37, Cosmin Tanislav wrote:
>>> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>>
>>> Add support for the following parts:
>>>   * LTC2984
>>>   * LTC2986
>>>   * LTM2985
>>>
>>> The LTC2984 is a variant of the LTC2983 with EEPROM.
>>> The LTC2986 is a variant of the LTC2983 with only 10 channels,
>>> EEPROM and support for active analog temperature sensors.
>>> The LTM2985 is software-compatible with the LTC2986.
>>>
>>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>> ---
>>>   .../bindings/iio/temperature/adi,ltc2983.yaml | 63 +++++++++++++++++--
>>>   1 file changed, 59 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>>> index 722781aa4697..c33ab524fb64 100644
>>> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>>> @@ -4,19 +4,27 @@
>>>   $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
>>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>   
>>> -title: Analog Devices LTC2983 Multi-sensor Temperature system
>>> +title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
>>>   
>>>   maintainers:
>>>     - Nuno Sá <nuno.sa@analog.com>
>>>   
>>>   description: |
>>> -  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
>>> +  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
>>> +  Temperature Measurement Systems
>>> +
>>>     https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
>>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
>>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
>>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
>>>   
>>>   properties:
>>>     compatible:
>>>       enum:
>>>         - adi,ltc2983
>>> +      - adi,ltc2984
>>> +      - adi,ltc2986
>>> +      - adi,ltm2985
>>>   
>>>     reg:
>>>       maxItems: 1
>>> @@ -26,7 +34,7 @@ properties:
>>>   
>>>     adi,mux-delay-config-us:
>>>       description:
>>> -      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
>>> +      The device performs 2 or 3 internal conversion cycles per temperature
>>>         result. Each conversion cycle is performed with different excitation and
>>>         input multiplexer configurations. Prior to each conversion, these
>>>         excitation circuits and input switch configurations are changed and an
>>> @@ -145,7 +153,7 @@ patternProperties:
>>>         adi,three-conversion-cycles:
>>>           description:
>>>             Boolean property which set's three conversion cycles removing
>>> -          parasitic resistance effects between the LTC2983 and the diode.
>>> +          parasitic resistance effects between the device and the diode.
>>>           type: boolean
>>>   
>>>         adi,average-on:
>>> @@ -353,6 +361,41 @@ patternProperties:
>>>           description: Boolean property which set's the adc as single-ended.
>>>           type: boolean
>>>   
>>> +  "^temp@":
>>
>> There is already a property for thermocouple. Isn't a thermocouple a
>> temperature sensor? IOW, why new property is needed?
>>
> This node is needed for active analog temperature sensors.
> It has fewer options than the thermocouple, as it only supports
> a table to map from voltage to temperature and specifying whether
> the measurement is differential or single-ended.
> 
> If you did as much as glimpsed at the datasheet you would have
> understood.

We receive a lot of bindings to review. If I glimpse through every
datasheet, when would I work?

Instead of expecting reviewer to dive into datasheets for this one
particular sensor, make it explicit in commit msg.

> 
>>> +    type: object
>>> +    description:
>>> +      Represents a channel which is being used as an active analog temperature
>>> +      sensor.
>>> +
>>> +    properties:
>>> +      adi,sensor-type:
>>> +        description:
>>> +          Identifies the sensor as an active analog temperature sensor.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        const: 31
>>> +
>>> +      adi,single-ended:
>>> +        description: Boolean property which sets the sensor as single-ended.
>>
>> Drop "Boolean property which sets" - it's obvious from the type.
>>
> 
> That's how the rest of the file is written.

Not really an argument... You can correct the other pieces in separate
patch.

> 
>>
>>
>>> +        type: boolean
>>> +
>>> +      adi,custom-temp:
>>> +        description:
>>> +          This is a table, where each entry should be a pair of
>>
>> "This is a table" - obvious from the type.
>>
> 
> That's how the rest of the file is written.
> 
>>> +          voltage(mv)-temperature(K). The entries must be given in nv and uK
>>
>> mv-K or nv-uK? Confusing...
> 
> That's how the rest of the file is written.

The same.

> 
> The chip uses mv-K, but the binding specifies nv-uK, the driver
> translates it into the appropriate unit.

It does not matter here, what the driver is doing. Use only one unit
here, matching the DTS.

> 
>>
>>> +          so that, the original values must be multiplied by 1000000. For
>>> +          more details look at table 71 and 72.
>>
>> There is no table 71 in the bindings... It seems you pasted it from
>> somewhere.
>>
> 
> It's pretty obvious that "Table" in a binding refers to the datasheet.

There are multiple datasheets and how would I know to which one this refers?

> But if you meant datasheet, not binding, you're looking at the wrong
> datasheet then.
> Also, that's how the rest of the file is written.

Not really an argument... Poor examples like to spread, it's an effort
to drop them.

> 
>>> +          Note should be signed, but dtc doesn't currently maintain the
>>> +          sign.
>>
>> What do you mean? "Maintain" as allow or keep when building FDT?  What's
>> the problem of using negative numbers here and why it should be part of
>> bindings?
>>
> 
> You're really clueless, I'll let you figure it out on your own.

Yes, I am clueless and that's not the way how the review conversation
should look like.

NAK.

> Also, that's how the rest of the file is written.
> 
>>> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
>>> +        minItems: 3
>>> +        maxItems: 64
>>> +        items:
>>> +          minItems: 2
>>> +          maxItems: 2
>>
>> Instead describe the items with "description" (and maybe constraints)
>> like here:
>>
>> https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml#L278
>>
> 
> That's how the rest of the file is written.
> If you really want to use something different, you can submit a
> patch later and fix the whole binding however you want.

Nope. I expect the new pieces to be correct, not incorrect because
"there is already poor pattern, so I will do the same".

If inconsistency bothers you, anyone can fix it in following up patch.
Also you.

Best regards,
Krzysztof

