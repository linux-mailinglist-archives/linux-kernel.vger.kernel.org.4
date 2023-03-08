Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01B46B058A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCHLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCHLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:12:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF73B4F5B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:12:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o12so64147112edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678273950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fPU2tBHNpDiK+ESgZE1NTwFx8PfPKs+ZFdXAJHf1Us=;
        b=ek4n97I6m7J1I7V8osSw5E/BSUnz2l4DlNr7gyCms2kGkO8VyZDNtvDcxcpsJm0166
         DVdBRLbmkrcHfYYhPVPam/4UGIB1YXAucMriTobxa4gz230CO7EIM1mTQHwraZ/jEeyp
         8phE66PcghfaKEBrkaMzseEVZKJRjM3/67TslZ8vyGCoFCeIevd0AsH3n1j2IwgzsF1H
         pAafVOqSdRtmGMhXHWmtFgq0YpB/S3o3CodXv20J9+XosQd8NFVAP8+AQAlyeI5sS/YG
         xgUeycolP4MSqyHXF10erja1nHWQRHvpUGf79OlBRwKIGZHbP9QJB/Aqgzir674An66X
         GCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fPU2tBHNpDiK+ESgZE1NTwFx8PfPKs+ZFdXAJHf1Us=;
        b=aFIfS0XgmOYfVYpuKr1p/OMpGnMPh7EKRPdm0KSkTUHK21scSMXn4I4UP1KZTNEABp
         UIPNDb3ENnqy4kt3tvDWztxGZtnIN5GgF8ptr5X9/YT9cLMTI8nkH2nOoY7v8lsOEQQQ
         /dorsdbcTBlIZuDJ9YdMne141SgdUgI9kyrNPqb5EDW2HAeBiYvfTgSPe054vdvdQwlm
         VKiKSW8DVqP5EsbEoQdmqHTNe2xs2Mq2jXHBIWgi4AdZezJzIKk+GsAjuCafcU8IwHHe
         L1YFBpK2B26RWrbv9rC/sHHGxPg8s5POpKbOaSnca4Fn45eFRcr+ELSxtG6y5i+RMHOH
         brSA==
X-Gm-Message-State: AO0yUKXwaE4lAActxq2IY8GDx63zqLo8hGURS47uiPZGX1YUs3b8WNSw
        pBcyQ8P/K9slsUQ0Qa8DqR4Ylg==
X-Google-Smtp-Source: AK7set++rAeeM8NbXauRa/wWHNjpsGMjgc+w2yOa/uMVzR5gQlC86O3rLyVM0FHfN5jqs94GQLPt2A==
X-Received: by 2002:a17:906:6dd3:b0:878:8249:bef6 with SMTP id j19-20020a1709066dd300b008788249bef6mr17342106ejt.59.1678273949751;
        Wed, 08 Mar 2023 03:12:29 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id kt21-20020a170906aad500b008d398a4e687sm7313409ejb.158.2023.03.08.03.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:12:29 -0800 (PST)
Message-ID: <d3190ecb-76fb-2d57-c4a9-2d65bb0e8d33@linaro.org>
Date:   Wed, 8 Mar 2023 12:12:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: power: supply: maxim,max17040: update
 properties
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-2-clamor95@gmail.com>
 <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org>
 <CAPVz0n1QDFyHiGAa7UOuuwPiSH+ELiYNeO9-fxPWrOWkWqEuHg@mail.gmail.com>
 <bbc7c183-3f98-9ea4-d5e5-0d58dd65d416@linaro.org>
 <CAPVz0n3sKH_7x=aNVLaHVN0F1FWLVRW+MGoj9qBO9V=TDuv_jQ@mail.gmail.com>
 <d0d0617d-8a2e-7a71-f4fe-f69896f84ede@linaro.org>
 <CAPVz0n2XTJdSELoE9-P=r6ntAOT0PHEgoFTiyMz577z5wzF1QQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n2XTJdSELoE9-P=r6ntAOT0PHEgoFTiyMz577z5wzF1QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 12:06, Svyatoslav Ryhel wrote:
> ср, 8 бер. 2023 р. о 12:53 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 08/03/2023 11:51, Svyatoslav Ryhel wrote:
>>> ср, 8 бер. 2023 р. о 12:44 Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> пише:
>>>>
>>>> On 08/03/2023 10:15, Svyatoslav Ryhel wrote:
>>>>
>>>>>> max17040 does not have ADC temperature input... so is it system
>>>>>> configuration?
>>>>>>
>>>>>
>>>>> yes, I own a device (LG Optimus Vu P895) which uses max17043
>>>>> coupled with ADC thermal sensor
>>>>>
>>>>>>> +
>>>>>>> +  io-channel-names:
>>>>>>> +    items:
>>>>>>> +      - const: temp
>>>>>>
>>>>>> Drop the names property, not needed for one item.
>>>>>>
>>>>>
>>>>> Alright, but driver patch expects temp name. I will look if this
>>>>> is adjustable.
>>>>
>>>> I think I saw cases without names.
>>>>
>>>
>>> There is no io-channel without a name. And io-channels are mostly used
>>> by power supply devices.
>>>
>>>>>
>>>>>>> +
>>>>>>>    wakeup-source:
>>>>>>>      type: boolean
>>>>>>>      description: |
>>>>>>> @@ -95,3 +109,26 @@ examples:
>>>>>>>          wakeup-source;
>>>>>>>        };
>>>>>>>      };
>>>>>>> +  - |
>>>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>> +    i2c0 {
>>>>>>> +      #address-cells = <1>;
>>>>>>> +      #size-cells = <0>;
>>>>>>> +
>>>>>>> +      fuel-gauge@36 {
>>>>>>> +        compatible = "maxim,max17043";
>>>>>>> +        reg = <0x36>;
>>>>>>> +
>>>>>>> +        interrupt-parent = <&gpio>;
>>>>>>> +        interrupts = <144 IRQ_TYPE_EDGE_FALLING>;
>>>>>>> +
>>>>>>> +        monitored-battery = <&battery>;
>>>>>>> +        power-supplies = <&charger>;
>>>>>>
>>>>>> But here you suggests something else than VDD... The hardware does not
>>>>>> take charger as input. It takes power supply - vdd.
>>>>>>
>>>>>
>>>>> Power system allows passing properties from other power devices.
>>>>> In this case battery health and status are passed from charger.
>>>>
>>>> So this is not an input to device? Then it does not really look like
>>>> property of this hardware. Fuel gauge does not control the charger, also
>>>> from system configuration point of view.
>>>>
>>>
>>> It is not controlling charger, the charger provides the status and
>>> health of the battery to the fuel gauge. This option is also used in
>>> other fuel gauges.
>>
>> How regulator provides health and status of the battery? I don't understand.
>>
> 
> It is not a regulator, it is a charger! Dedicated chip responsible for
> controlling charging. And its configuration allows it to get battery
> health and status, because this fuel gauge does not have this
> function.


Ah, you are right. I confused with power-supply. It is fine.


Best regards,
Krzysztof

