Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E6631E64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKUKbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKUKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:31:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3D1DF3B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:31:36 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id h12so13972377ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Slta85Trz78FGjwfDG8uy79pV5EloKWIZYoD0VMik0o=;
        b=KuF3mPrP6YdH3IJDZjmfUjTv0ru0fcg3jK9DMUmtHqyzzh5MCUUlUHcPn1cua+VaIh
         pOs+U6qfu/QKiATpFPX9AZQINHY3GTPMMtJIG1Yqtemd0rQdly+USJmwg6QGna7Oms/x
         IWlVWqVyPUsqmPFxS9GY22PklA8gLXPU6Kagiqe+HnXsTAUePEreHrSLSVGxPcVjjUj3
         fsdoMAaRgg2nig4LOnECS6CMIgyH62a9czxRi8IH8xQO7f9G0NLhiqSY3HCe2/wQ7yrZ
         2u8yBZ6Q/gpBqtP1I8tIaqvBwS+K4qvc+peuOgpAylUK2aAXiGKui+c4FZxtfqmc2E/g
         9KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Slta85Trz78FGjwfDG8uy79pV5EloKWIZYoD0VMik0o=;
        b=DCx+ro1XlpQ8Ye7FPWcPUwJUUQd1qSK/t3j85i1DvtOcCoNztWjTT1wwNXCWyRKSvs
         z46d3RDz+fViFbvO56YQRT+qvl6ouaqhIz9tNagFMZQH6jHJrx1+DaNueRTnJFvstLjb
         nZRDsSklqR4sS2hENF2DUk0cIf193ttuNfW3O+jU8RFALDsP99ctECN5cC9Rolo1FbAS
         vNZYSF62n+sdxlxVOn2TSottbSy7PRyPeD6EwDqZIaLqPrR1OynE3KfvR99jiI6S8Ujt
         spbQTm0ETdA1MQai1a5HQb3RMHadyyGJrx/XocdWPr2gJOJAkBu4Q42MP9xf+IrF0Rer
         /nPg==
X-Gm-Message-State: ANoB5pnHx2mWV5SiJmevuBS0DdfvQExRlruWbxCEOzpOYRu/Snvpsf6R
        K86/9GGNVjxLvlFRR81OjPYwVQ==
X-Google-Smtp-Source: AA0mqf6RMmIjGhBX3/kp2DTp7QpyuOxBd9xuRrCYvNmK5sbP+Pi7xf89GSnl0ysEgzeK0q+egGpGzA==
X-Received: by 2002:a05:651c:549:b0:277:5059:82c8 with SMTP id q9-20020a05651c054900b00277505982c8mr5669806ljp.315.1669026695211;
        Mon, 21 Nov 2022 02:31:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z17-20020a195e51000000b00499aefcf68esm1965873lfi.292.2022.11.21.02.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:31:34 -0800 (PST)
Message-ID: <3a50ba73-aab7-f6db-5e42-beb7e193c5bf@linaro.org>
Date:   Mon, 21 Nov 2022 11:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] dt-bindings: iio: adc: ad7923: adjust documentation
Content-Language: en-US
To:     Edmund Berenson <edmund.berenson@emlix.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121102600.uwmgivssgy7oakxf@emlix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 11:26, Edmund Berenson wrote:
> On Mon, Nov 21, 2022 at 10:13:57AM +0100, Krzysztof Kozlowski wrote:
>> On 20/11/2022 18:06, Edmund Berenson wrote:
>>> - Add the ad7927 compatibility string, with fallback compatibility
>>> to ad7928.
>>> - ad7923 and ad7924 are treated the same in the driver, show
>>> the relationship in the documentation.
>>>
>>> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
>>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
>>> ---
>>>  .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
>>
>> Do not respond with new patch to some old thread. Each patchset starts a
>> new thread.
>>
> Sorry I didn't know this is the preferred way. I will send new patch
> version as new thread in the future.
>>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
>>> index 07f9d1c09c7d..e553853e25d5 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
>>> @@ -11,7 +11,7 @@ maintainers:
>>>  
>>>  description: |
>>>    Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
>>> -   AD7918, AD7928 8 Channels ADCs.
>>> +   AD7918, AD7927, AD7928 8 Channels ADCs.
>>>  
>>>    Specifications about the part can be found at:
>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
>>> @@ -20,14 +20,22 @@ description: |
>>>  
>>>  properties:
>>>    compatible:
>>> -    enum:
>>> -      - adi,ad7904
>>> -      - adi,ad7914
>>> -      - adi,ad7923
>>> -      - adi,ad7924
>>> -      - adi,ad7908
>>> -      - adi,ad7918
>>> -      - adi,ad7928
>>> +    oneOf:
>>> +      - enum:
>>> +          - adi,ad7904
>>> +          - adi,ad7914
>>> +          - adi,ad7908
>>
>> You already started shuffling the entries, so make them ordered. What's
>> the point of changing the order from one non-sorted to another non-sorted?
>>
>>> +          - adi,ad7918
>>> +          - adi,ad7923
>>> +          - adi,ad7924
>>
>> Then deprecate this as alone compatible.
>>
>>> +          - adi,ad7927> +          - adi,ad7928
>>
>> Ditto
>>
>>> +      - items:
>>> +          - const: adi,ad7923
>>> +          - const: adi,ad7924
>>
>> I would expect lower number as fallback.
> If I remove alone compatibility of 7924 and 7927 in the documentation,

I don't understand. 7924 and 7927 are not compatible with each other -
neither in old code nor in new - so what do you want to remove?

> I will have to remove explicit compatibility match on the driver side,
> correct?
> Just want to make sure I don't misunderstand you.

My comment to which you responded was about order of items. Usually
lower number means older device and usually older device is the fallback.

Best regards,
Krzysztof

