Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE776FDB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjEJKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:12:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521001BE7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:12:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1272179066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683713525; x=1686305525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8W9wj6II5GTrEem7luB1BRmjIURt5RdoLBLDnnuSaBY=;
        b=oUOYhwB4kUwcFIrS3FG81XCuZ/NcBiGJ+OUZEGUl7TCsABhBzAx8XiZDuiSpX00e33
         YH68zgczYjIS7C4nG9aDhS5tokGMTABPQE9BzD41s168vBrBjW8WKHI9Cn8m2FxPkpVs
         nUVE9wRIhFrpTaFF3mtKLj1Uc5Cpb3Y6+yqBHa6p693u4qYZq+dmwJJRrYZmMqs5uYhs
         kNElXVoaD4n/xDZIkiPv5K5UUWLv3+ACqsvADtfrJJn12d9TYoVfxyKwkAFGmfqNGKm5
         71ut/Ru25HT23ufPo0Lry7u9e4/X7nHxq8Nz7XzowsjXj+WqqXNicri1I6MFvLDZaagk
         xjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713525; x=1686305525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8W9wj6II5GTrEem7luB1BRmjIURt5RdoLBLDnnuSaBY=;
        b=EhiAdJBNcaeJDoOXlqk6HprGxvtv57SMvUUeJOoGkNVo+3++CeGD/T3f5YpWWkF7Z0
         C27fQd87+kOMFCDEWLEdEkWBdJ/zvthksIUdH15GjNv9IFqgVuMpFZIh7ftBJDQ+nmUK
         Jv2EalFqkNCo7aAhPdi3Rl70JG3sIif83UURx6zdMCJlG7Jhoya5g3/FdXuOqdjGFZu2
         Pi59yxENaHmqmmw5Ustsv/piuMkqCx34hG8om9sVxEOepE3E1fvZOZXUC8WQlqTFd9w8
         sioi+7+2xXXj6xxjCst4yDuDw0mi353ss11fQiCccIwWSIK/bJNftD2S94WhRAepkxel
         qSsQ==
X-Gm-Message-State: AC+VfDxv7l1HYr6aZw+uU+qo6yFCxPLgAgHjn7MIPin7Yc3wxFuW8SVK
        /Eiy4EN55aDuj9R7QGV3TeNhY3JZk7rZiSuxqFo=
X-Google-Smtp-Source: ACHHUZ7QAKmL0TacRIZKfIWUdEdjTRxMsMME+brBGTKG2TxMOHIiq7GsjlRzMgperJDfC2U8Whz63Q==
X-Received: by 2002:a17:907:3d92:b0:969:fc68:fa9a with SMTP id he18-20020a1709073d9200b00969fc68fa9amr4689159ejc.40.1683713524736;
        Wed, 10 May 2023 03:12:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id mh25-20020a170906eb9900b00882f9130eafsm2435335ejb.26.2023.05.10.03.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 03:12:04 -0700 (PDT)
Message-ID: <8f21f892-de54-9bc7-d4b9-f36aaa6b4a7c@linaro.org>
Date:   Wed, 10 May 2023 12:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
 <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
 <773d0d90-29c7-b1bd-bd16-898b435eafb6@microchip.com>
 <b3c7db03-6614-47d9-a9e0-a8e51c836d86@linaro.org>
 <a4d934c6-ec28-50d0-b9bb-9b11fee7ebb6@microchip.com>
 <1c2aa022-348a-8ac2-1a26-eedf57aadb77@linaro.org>
 <71a1e8de-932d-09a1-efeb-af459fee9423@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <71a1e8de-932d-09a1-efeb-af459fee9423@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 10:31, Claudiu.Beznea@microchip.com wrote:
> On 10.05.2023 10:58, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 10/05/2023 09:14, Claudiu.Beznea@microchip.com wrote:
>>> On 10.05.2023 10:06, Krzysztof Kozlowski wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On 10/05/2023 09:00, Claudiu.Beznea@microchip.com wrote:
>>>>> On 09.05.2023 09:25, Krzysztof Kozlowski wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>>
>>>>>> On 09/05/2023 07:27, Claudiu Beznea wrote:
>>>>>>> Convert Atmel PMC documentation to yaml. Along with it clock names
>>>>>>> were adapted according to the current available device trees as
>>>>>>> different controller versions accept different clocks (some of them
>>>>>>> have 3 clocks as input, some has 2 clocks as inputs and some with 2
>>>>>>> input clocks uses different clock names).
>>>>>>>
>>>>>>
>>>>>> Thank you for your patch. There is something to discuss/improve.
>>>>>>
>>>>>>> +title: Atmel Power Management Controller (PMC)
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
>>>>>>> +
>>>>>>> +description:
>>>>>>> +  The power management controller optimizes power consumption by controlling all
>>>>>>> +  system and user peripheral clocks. The PMC enables/disables the clock inputs
>>>>>>> +  to many of the peripherals and to the processor.
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    oneOf:
>>>>>>> +      - items:
>>>>>>> +          - enum:
>>>>>>> +              - atmel,at91sam9g15-pmc
>>>>>>> +              - atmel,at91sam9g20-pmc
>>>>>>> +              - atmel,at91sam9g25-pmc
>>>>>>> +              - atmel,at91sam9g35-pmc
>>>>>>> +              - atmel,at91sam9x25-pmc
>>>>>>> +              - atmel,at91sam9x35-pmc
>>>>>>> +          - enum:
>>>>>>> +              - atmel,at91sam9260-pmc
>>>>>>> +              - atmel,at91sam9x5-pmc
>>>>>>
>>>>>> I missed it last time - why you have two enums? We never talked about
>>>>>> this. It's usually wrong... are you sure this is real hardware:
>>>>>> atmel,at91sam9g20-pmc, atmel,at91sam9260-pmc
>>>>>> ?
>>>>>
>>>>> I have 2 enums because there are some hardware covered by:
>>>>> "vendor-name,hardware-v1-pmc", "syscon" and some covered by:
>>>>> "vendor-name,hardware-v2-pmc", "vendor-name,hardware-v1-pmc", "syscon".
>>>>
>>>> The enum does not say this. At all.
>>>>
>>>> So again, answer, do not ignore:
>>>> is this valid setup:
>>>> atmel,at91sam9g20-pmc, atmel,at91sam9260-pmc
>>>> ?
>>>
>>> Not w/o syscon. This is valid:
>>
>> Syscon is not important here, but indeed I missed it.
>>
>>>
>>> compatible = "atmel,at91sam9g20-pmc", "atmel,at91sam9260-pmc", "syscon";
>>>
>>> available in arch/arm/boot/dts/at91sam9g20.dtsi +45
>>
>> Nice, so my random choice was actually correct. Ok, so another:
>>
>> atmel,at91sam9g15-pmc, atmel,at91sam9260-pmc, syscon
>>
>> Is it valid hardware?
> 
> This one, no. So, I guess, the wrong here is that there could be
> combinations that are not for actual hardware and yet considered valid by
> changes in this patch?

I just don't understand why you have two enums. This is not a pattern
which is allowed anywhere. It might appear but only as exception or mistake.


Best regards,
Krzysztof

