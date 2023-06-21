Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA89737D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjFUIK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFUIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:10:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05610F1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:10:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-988883b0d8fso529584266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687335052; x=1689927052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bALinTqbF/qOXgwdMyTFwrJC13kjvO/KOdsOe67RJS8=;
        b=HvemXir9m0Vmr9h4OBYoksSM7VKxai/edGasJTbOJ7/sO+PBuAydA2ohrP9V7/ypLF
         D6AvAbW9XbDUk0QdCUWjo2dDR/MN9r4K5ZpVdCH7DEoM2Zl3JW6sP6PLUb/Ms+FEnlXm
         rE2ayCc01rk9rdYDVHofbosWCgr9nhiwIWy7vF+6C/78ZNe/OdlmdXFXf0oHXmO4DKcr
         pkFSsEGrJj1NuNWML9lkNGQ2rWAtb42GVbmFatGwz4SGstSJadpFHv96DHuHof1rnhal
         tDPxfWIOWxLTisQ4NBapL8vqP0G31R+jYV/koiz6bsVCXJZQumjnShW7cImMOhBfqM9r
         bVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687335052; x=1689927052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bALinTqbF/qOXgwdMyTFwrJC13kjvO/KOdsOe67RJS8=;
        b=RqhOXpadJKYe6ifVHIIY7kEsDrZPFyihVnM2X21hT6GbxD8a5b1nzceB+JN892VyfS
         /OvwjOegmlc3zztAcCkKgxWEyaEnot21j8T86m2zRTbI4A5e9sdQqu/mq247Seun6V82
         QFUh2vUebtkPDb49uAMmy/HrOa9xqa3sohubQ4qb+alJHQIGb1wzXOX3NcdvLEkKywFB
         IgsD/mBLRwLtKjaFxtVkBB8LzH8RAi8OC3sUkAifbjNUIfK3VuQwh3bbsSrvaZC+h4sM
         c+g1lXVX9lwqTrsjkbKVytuY+a1Mj2KGdEf4LwGUm3ZGqBtm+LHClxnZqeNjtb7RY3H5
         ugTQ==
X-Gm-Message-State: AC+VfDwlM1LQ4FSJxJ3SHhNe0ohiLxG6uaER2NkZPyVc29EV9iXyKVTc
        KVSPefM9w2liBzwJt3PSs/MSoQ==
X-Google-Smtp-Source: ACHHUZ7wPyUWkTtvUQZCVeRO6eUm0VUxn3oehvqnzgwJIhLbSMEEEEDcfYDRdNFuKMIdlGMw1Tcd5g==
X-Received: by 2002:a17:907:a41e:b0:989:2368:20d9 with SMTP id sg30-20020a170907a41e00b00989236820d9mr4221444ejc.75.1687335051832;
        Wed, 21 Jun 2023 01:10:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ox4-20020a170907100400b00987316d1585sm2738614ejb.145.2023.06.21.01.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:10:51 -0700 (PDT)
Message-ID: <adc4d83e-5bec-b925-b55e-43ad441ad8ee@linaro.org>
Date:   Wed, 21 Jun 2023 10:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230619083517.415597-1-william.qiu@starfivetech.com>
 <20230619083517.415597-2-william.qiu@starfivetech.com>
 <4937f9c4-a0e0-fd37-d71b-e7488b2a1062@linaro.org>
 <fb608232-f44d-21cf-7e0e-28829196e677@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fb608232-f44d-21cf-7e0e-28829196e677@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 08:45, William Qiu wrote:
> 
> 
> On 2023/6/19 20:17, Krzysztof Kozlowski wrote:
>> On 19/06/2023 10:35, William Qiu wrote:
>>> The QSPI controller needs three clock items to work properly on StarFive
>>> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
>>> platforms do not have this constraint.
>>>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>  .../bindings/spi/cdns,qspi-nor.yaml           | 20 ++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>> index b310069762dd..1b83cbb9a086 100644
>>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>> @@ -26,6 +26,15 @@ allOf:
>>>              const: starfive,jh7110-qspi
>>>      then:
>>>        properties:
>>> +        clocks:
>>> +          maxItems: 3
>>> +
>>> +        clock-names:
>>> +          items:
>>> +            - const: ref
>>> +            - const: ahb
>>> +            - const: apb
>>
>> You are duplicating top-level property. Define the items only in one
>> place. If this list is applicable to everything, then in top-level property.
>>
> Only in JH7110 SoC need there clocks, other platforms do not have this constraint.
> So I need to duplicating top-level property.

You don't need, why? Why writing something twice is an answer to "JH7110
needs 3 clocks"? It's not related.

What is the clock for all other variants?

>>> +
>>>          resets:
>>>            minItems: 2
>>>            maxItems: 3
>>> @@ -38,6 +47,9 @@ allOf:
>>>  
>>>      else:
>>>        properties:
>>> +        clocks:
>>> +          maxItems: 1
>>
>> clock-names is missing. They must be in sync with clocks. What is the
>> first clock?
>>
> But there are no clock-names before, should I add it?

Then let's just disallow it. Either you define it or you not allow it.

>>> +
>>>          resets:
>>>            maxItems: 2
>>>  
>>> @@ -70,7 +82,13 @@ properties:
>>>      maxItems: 1
>>>  
>>>    clocks:
>>> -    maxItems: 1
>>> +    maxItems: 3
>>
>>
>> You did not test it before sending. minItems is missing.
>>
> I will add it.
> As for other platforms, should I use enum to constraint the clocks?

What is the clock on other platforms?

Best regards,
Krzysztof

