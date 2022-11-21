Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751DA632931
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKUQQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKUQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:16:37 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC0D3394
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:16:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h12so15017867ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zX0z0xZYqqRaXiVDucDuDpWLYdXC6eN0nUqR4wA29rM=;
        b=B7QOfEkHhIDhNUT7+JHOCYwFzoEyEFks7Pi6+DrzMjOEXx0wTtHV5inu7kQABAf4Dx
         mJrMID0YgeElt9eDrQJs4TtEsFo7EvY6zJTGf3/HMS+cfuCrubMUivg/wz9TGSUCtd26
         ggCVD1FldQ9M+bFr67ZdorY/mhd2JbqhrDn+Eaxetc029hLLDhF9BJRSlZ8OwrXTrQCp
         l6LSxWxzl/0MIcFvxlskVkGyXyiIE0W52yCi+PuPqBGooGXy6T1lnRRQ9rfrIh6s+hMO
         IHhk9A4xM3XqyMxjG5eFXwzNP7W1EvMG664/MchEEJnWYDrw33wY7gfokNE6/K8QV+H0
         tXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX0z0xZYqqRaXiVDucDuDpWLYdXC6eN0nUqR4wA29rM=;
        b=41Gh9g2bv/2eeZRvIriHeTT4FROpEEY0njWDM6oRjLVnqF5cv4nWb5NCSrw0TMt+4z
         SEbvfTtT/eyq8i6V1//BIOqT94V9NC/EnmJI0hviRH08DuFtzZFjGfVli6+Irn7YcyD+
         EftpWgpIajXsmJXfwrzwUy1EzW+E6/lxv4d2HivLjc47NpJKeyohh+4mq4cfS9kY+LAX
         bD4c8aZBjhqmyOfH48ci8rAscjhSdR7jOE3sXo+R+fSyNQAsnj/MVZ683TjXzqIaYA1v
         exlGgL143YB2XoKTANZL+HOXSglkMdkhRfWn9HlzGnK9PqjSxoaDQrAesxwGDykhdsMK
         3gTA==
X-Gm-Message-State: ANoB5plxetEOABm+WBcrStpunGlppVCrbaUG2nxwILAj+edNRvQajF8S
        h99l9F7ehm8yWTY5si8Hx/JziFl9/5BCpHQu
X-Google-Smtp-Source: AA0mqf6yWMZ5eLH2Exqn+97mU62dnLPIk6cw/n3MIXqJBiZ3zoUIUGowy2bfSC+eTUiMsXRgLfLI6A==
X-Received: by 2002:a2e:a553:0:b0:277:665c:eb4c with SMTP id e19-20020a2ea553000000b00277665ceb4cmr81707ljn.287.1669047394496;
        Mon, 21 Nov 2022 08:16:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i189-20020a2e22c6000000b0026fdecfa6ebsm1522026lji.15.2022.11.21.08.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 08:16:33 -0800 (PST)
Message-ID: <3025c187-f493-9fcf-7831-1f5719d6bcfa@linaro.org>
Date:   Mon, 21 Nov 2022 17:16:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] dt-bindings: iio: adc: ad7923: adjust documentation
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221120153419.GA3094349-robh@kernel.org>
 <20221120170630.29354-1-edmund.berenson@emlix.com>
 <d83e9a3d-2482-4342-03c1-818a38bd4b7b@linaro.org>
 <20221121102600.uwmgivssgy7oakxf@emlix.com>
 <3a50ba73-aab7-f6db-5e42-beb7e193c5bf@linaro.org>
 <20221121104532.dibxead6kiv3xqzw@emlix.com>
 <20221121124518.00000da4@Huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121124518.00000da4@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 13:45, Jonathan Cameron wrote:
> On Mon, 21 Nov 2022 11:45:32 +0100
> Edmund Berenson <edmund.berenson@emlix.com> wrote:
> 
>> On Mon, Nov 21, 2022 at 11:31:33AM +0100, Krzysztof Kozlowski wrote:
>>> On 21/11/2022 11:26, Edmund Berenson wrote:  
>>>> On Mon, Nov 21, 2022 at 10:13:57AM +0100, Krzysztof Kozlowski wrote:  
>>>>> On 20/11/2022 18:06, Edmund Berenson wrote:  
>>>>>> - Add the ad7927 compatibility string, with fallback compatibility
>>>>>> to ad7928.
>>>>>> - ad7923 and ad7924 are treated the same in the driver, show
>>>>>> the relationship in the documentation.
>>>>>>
>>>>>> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
>>>>>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
>>>>>> ---
>>>>>>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------  
>>>>>
>>>>> Do not respond with new patch to some old thread. Each patchset starts a
>>>>> new thread.
>>>>>  
>>>> Sorry I didn't know this is the preferred way. I will send new patch
>>>> version as new thread in the future.  
>>>>>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
>>>>>> index 07f9d1c09c7d..e553853e25d5 100644
>>>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
>>>>>> @@ -11,7 +11,7 @@ maintainers:
>>>>>>  
>>>>>>  description: |
>>>>>>    Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
>>>>>> -   AD7918, AD7928 8 Channels ADCs.
>>>>>> +   AD7918, AD7927, AD7928 8 Channels ADCs.
>>>>>>  
>>>>>>    Specifications about the part can be found at:
>>>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
>>>>>> @@ -20,14 +20,22 @@ description: |
>>>>>>  
>>>>>>  properties:
>>>>>>    compatible:
>>>>>> -    enum:
>>>>>> -      - adi,ad7904
>>>>>> -      - adi,ad7914
>>>>>> -      - adi,ad7923
>>>>>> -      - adi,ad7924
>>>>>> -      - adi,ad7908
>>>>>> -      - adi,ad7918
>>>>>> -      - adi,ad7928
>>>>>> +    oneOf:
>>>>>> +      - enum:
>>>>>> +          - adi,ad7904
>>>>>> +          - adi,ad7914
>>>>>> +          - adi,ad7908  
>>>>>
>>>>> You already started shuffling the entries, so make them ordered. What's
>>>>> the point of changing the order from one non-sorted to another non-sorted?
>>>>>  
>>>>>> +          - adi,ad7918
>>>>>> +          - adi,ad7923
>>>>>> +          - adi,ad7924  
>>>>>
>>>>> Then deprecate this as alone compatible.
>>>>>  
>>>>>> +          - adi,ad7927> +          - adi,ad7928  
>>>>>
>>>>> Ditto
>>>>>  
>>>>>> +      - items:
>>>>>> +          - const: adi,ad7923
>>>>>> +          - const: adi,ad7924  
>>>>>
>>>>> I would expect lower number as fallback.  
>>>> If I remove alone compatibility of 7924 and 7927 in the documentation,  
>>>
>>> I don't understand. 7924 and 7927 are not compatible with each other -
>>> neither in old code nor in new - so what do you want to remove?
>>>   
>>>> I will have to remove explicit compatibility match on the driver side,
>>>> correct?
>>>> Just want to make sure I don't misunderstand you.  
>>>
>>> My comment to which you responded was about order of items. Usually
>>> lower number means older device and usually older device is the fallback.  
> 
> Oldest in which sense?  I think it should be oldest in order of having
> a binding defined, not in order of part releases (and ADI seem to scramble
> part numbers fairly randomly so definitely not generally the case that
> ordering of numbers has anything much to do with age of part).

Older in a meaning of design by ADI. Of course I have no clue whether
this matches incremental numbers...

Best regards,
Krzysztof

