Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1939601D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJQXc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJQXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:32:20 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F1C6D869
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:32:17 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o67so8338503qvo.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLtsIxiPqpmlufHEr3FL/+eDmHdi/HXtrgOVQNh7x5s=;
        b=O1LFATwRW+qysYzWw55T0+v3ZXbAocRpFEyR9njT/088eCFdg4uc+q8irwcTUTPgrs
         45Zx82cICbWGjCgKf3cFCBHXalWRP4X8rPMX85JJ+U7ADI6fikXOAz53p6my+9qKQGed
         UqubaA35gCyAn2nD2hFQvmyfIuELXyhGazekU0GHVN3ClHdx+d7uu0DQVh6qegHUCHEs
         uz7JuIDpD8njhZiGFoFUEdjV/jCQNvbs/vtMJePakHl3An4dHhZVk/KWSxz49yOu+wLi
         pZZ2sanqLS6oclHn1Fi8mKHqDqLDNmj8aQDR5njPlHMBYYpDjdyUNaXyoUj5KkaigHmu
         hHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLtsIxiPqpmlufHEr3FL/+eDmHdi/HXtrgOVQNh7x5s=;
        b=Nhb9GQb3kZ4nM6D8opSqjSW7Mfwh9qOWJ/Tm9JMnnHjlC3KOO5N5vWg5drgpuusqvG
         e+ND1v2xAAYE2H2mI0plGzbBxg6e3nsv1Po7EM8W124WNMpg2h5iS/ZY801S+L/nTrKj
         esJcru1ZgJ+/rrc/SEnNjCPGHu4n1b9WS80T7kQoA1+nGUN3QpuAqXI4Zy5T8x/th52I
         KWlc3W1mtu7bHtf+FD9TZxHQ/AyK3Mb7zKTFpGcitY/86zEl54zAng1uLZmDXiqS7HQe
         ntzkzoW/39qTFZv7enLNbG6wbpe437pT8t1LB1MKlASIMd7xIX4Yw/E2prEjTOsJDaIR
         YyKA==
X-Gm-Message-State: ACrzQf2eMsB+znU6qgFAll49XcKmjKRoUiPtWA5bD0cmA/hiAlXxAdZC
        YDz8+/9HfEarA4VrDl913s5NgA==
X-Google-Smtp-Source: AMsMyM6Or4Kcvm4JcW7lopZeNHeHCxmCfd0V69+B1r5Ien71pZyJM5WyITILk4t7bf+HSswCUUsPUQ==
X-Received: by 2002:a05:6214:5006:b0:4b4:9a51:f811 with SMTP id jo6-20020a056214500600b004b49a51f811mr1316qvb.44.1666049537022;
        Mon, 17 Oct 2022 16:32:17 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id h24-20020ac85158000000b00304fe5247bfsm757014qtn.36.2022.10.17.16.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 16:32:16 -0700 (PDT)
Message-ID: <7cea27d8-c3c6-4bc2-0072-1168c9c6a2f0@linaro.org>
Date:   Mon, 17 Oct 2022 19:32:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support more
 parts
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>
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
 <f003f3ffa86fbeae6898c23638a4b0e1228a8657.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f003f3ffa86fbeae6898c23638a4b0e1228a8657.camel@gmail.com>
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

On 17/10/2022 05:38, Nuno Sá wrote:
> Hi Krzysztof,
> 

(...)

>>> @@ -353,6 +361,41 @@ patternProperties:
>>>          description: Boolean property which set's the adc as
>>> single-ended.
>>>          type: boolean
>>>  
>>> +  "^temp@":
>>
>> There is already a property for thermocouple. Isn't a thermocouple a
>> temperature sensor? IOW, why new property is needed?
>>
> 
> Well, most of the patternProps in this bindings are temperature
> sensors... It's just that the device(s) support different types of
> them. 'adi,sensor-type' is used to identify each sensor (as this
> translates in different configurations being written in the device
> channels).

Sure.

> 
>>> +    type: object
>>> +    description:
>>> +      Represents a channel which is being used as an active analog
>>> temperature
>>> +      sensor.
>>> +
>>> +    properties:
>>> +      adi,sensor-type:
>>> +        description:
>>> +          Identifies the sensor as an active analog temperature
>>> sensor.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        const: 31
>>> +
>>> +      adi,single-ended:
>>> +        description: Boolean property which sets the sensor as
>>> single-ended.
>>
>> Drop "Boolean property which sets" - it's obvious from the type.
>>
>>
>>
>>> +        type: boolean
>>> +
>>> +      adi,custom-temp:
>>> +        description:
>>> +          This is a table, where each entry should be a pair of
>>
>> "This is a table" - obvious from the type.
>>
>>> +          voltage(mv)-temperature(K). The entries must be given in
>>> nv and uK
>>
>> mv-K or nv-uK? Confusing...
> 
> Yeah, a bit. In Cosmin defense, I think he's just keeping the same
> "style" as the rest of the properties...

That's not the best approach for two reasons:
1. The unit used by hardware matters less here, because bindings are
used to write DTS. In many, many other cases there will be some
translation (just take random voltage regulator bindings).

2. What the driver is doing matters even less.

So just describe here what is expected in DTS.

> 
>>
>>> +          so that, the original values must be multiplied by
>>> 1000000. For
>>> +          more details look at table 71 and 72.
>>
>> There is no table 71 in the bindings... It seems you pasted it from
>> somewhere.
> 
> I'm fairly sure this refers to the datasheet. I see now that this can
> be confusing (again this kind of references are being (ab)used in the
> rest of the file).

Yep, but there are now multiple datasheets, aren't there?

> 
>>
>>> +          Note should be signed, but dtc doesn't currently
>>> maintain the
>>> +          sign.
>>
>> What do you mean? "Maintain" as allow or keep when building FDT? 
>> What's
>> the problem of using negative numbers here and why it should be part
>> of
>> bindings?
>>
>>> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
>>> +        minItems: 3
>>> +        maxItems: 64
>>> +        items:
>>> +          minItems: 2
>>> +          maxItems: 2
>>
>> Instead describe the items with "description" (and maybe constraints)
>> like here:
>>
>> https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml#L278
>>
> 
> Neat... My only comment (which probably applies to my previous ones) is
> that the rest of the properties are already in this "style". So maybe,
> follow up patches with small clean-ups would be more appropriate?

Of course. It would be great if the file was improved before or after
this one.


Best regards,
Krzysztof

