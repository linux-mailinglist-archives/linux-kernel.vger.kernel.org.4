Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB6701953
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjEMSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjEMSmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:42:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7EF26BB
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:42:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-953343581a4so1751572966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684003339; x=1686595339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+4YRB2fAb6S5ZQss3vm44TC9IZxgw87qep5+W+Me9o=;
        b=SyH0NzgPiy0IIvqbAedILCHmuD/6u9Wq/iN/NwQxsc6KmxNtiJZilMYP80CWi8o/dv
         e5CsqPIPy4Uyud4VlYujfC6SMtv6N5HX+LmeUoctoNUe4h7dzC8qDSQ5naT0/Z7M50n0
         KmUEJBe2VizyU2xyM3Pwcu76aLpGBB9ywCMT3Z1le/eEJ9Jm/rq6dLOitFItqiXP+FGw
         ig8kE8FMCCI72G+el8MVyLpx5aGKIMtraxvbk4RCM39tVH3tN4sVthWK5ent2JQ+oZS5
         mOq0ZPueDdyC2jtEUvI7ZbtXV6WEl9qjYjaBdAHgv+yUuC7o+nfZuArb1BdSWQMY+SXB
         zMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684003339; x=1686595339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+4YRB2fAb6S5ZQss3vm44TC9IZxgw87qep5+W+Me9o=;
        b=leJgyzwk/SGxypPv/Df2HxmBUciXugTQvQ0Uvqpu8x5K5cB2Om+RifzhbYH1i+bHCD
         4XxbEUcuXJ6WHDr6HmKp5OxBvL/zXy/X6o0MMD0GUtP+yGfZaO0Hgszr9UgOKGO13umS
         TeFfAZcocAW5ixUSB5OG+CI4w3P1jtF85rgTgrmCyAgrczItlicJK4ebTdbrBCRJrYxp
         qqG+Naq+sLQ3IqJuk2wtgp19FSQtd5qDUSSEOgsXZxDJT4VGg0+eqDYE/fy0r794Cc1W
         WpA2c57FrhAiyayBqBbexbq7Kt+nV8cW8SbYgajkrFBOfHhBCmqMg38ZFR9YJfkDL9Uz
         VRUw==
X-Gm-Message-State: AC+VfDxG+IwYRwuChiCHRLNCCsrDBJle0BfhpT0IdAqFH18ON15KACGZ
        o1og9K8Pg+sH8fBgiUdGexLacg==
X-Google-Smtp-Source: ACHHUZ77iaulugNkUAzkaRKxvRt4Umoyd3WapFnrN1bo4XgCe7thSF7VUawmgcobdnnDS8/p3XsuTg==
X-Received: by 2002:a17:907:9706:b0:965:eb5d:3b26 with SMTP id jg6-20020a170907970600b00965eb5d3b26mr30399521ejc.52.1684003339477;
        Sat, 13 May 2023 11:42:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id p1-20020a170906838100b009662b4230cesm7229864ejx.148.2023.05.13.11.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:42:18 -0700 (PDT)
Message-ID: <a6aa353c-3de0-9acb-9848-4f37fac0ab2e@linaro.org>
Date:   Sat, 13 May 2023 20:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: cdns,usb3: Add clock and reset
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230510132816.108820-1-minda.chen@starfivetech.com>
 <20230510132816.108820-2-minda.chen@starfivetech.com>
 <9cf5965a-8290-dfff-9f92-07ed2df66650@linaro.org>
 <05057f6d-cb38-8e4a-5d30-82863e0cda44@kernel.org>
 <028fb8ac-d6cc-6fee-f50b-b965e69e7d0c@linaro.org>
 <d4de3b1b-31b6-c257-29a5-f404ff0fbe99@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d4de3b1b-31b6-c257-29a5-f404ff0fbe99@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 12:22, Minda Chen wrote:
> 
> 
> On 2023/5/11 22:49, Krzysztof Kozlowski wrote:
>> On 11/05/2023 14:16, Roger Quadros wrote:
>>>
>>>
>>> On 11/05/2023 12:26, Krzysztof Kozlowski wrote:
>>>> On 10/05/2023 15:28, Minda Chen wrote:
>>>>> To support generic clock and reset init in Cadence USBSS
>>>>> controller, add clock and reset dts configuration.
>>>>>
>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>> ---
>>>>>  .../devicetree/bindings/usb/cdns,usb3.yaml         | 14 ++++++++++++++
>>>>>  1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>>> index cae46c4982ad..623c6b34dee3 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>>> @@ -42,6 +42,18 @@ properties:
>>>>>        - const: otg
>>>>>        - const: wakeup
>>>>>  
>>>>> +  clocks:
>>>>> +    minItems: 1
>>>>> +    maxItems: 8
>>>>> +    description:
>>>>> +      USB controller clocks.
>>>>
>>>> You need to list the items. And why is it variable? Your clock choice in
>>>> the example is poor, I doubt it is real.
>>>>
>>>>> +
>>>>> +  resets:
>>>>> +    minItems: 1
>>>>> +    maxItems: 8
>>>>> +    description:
>>>>> +      USB controller generic resets.
>>>>
>>>> Here as well.
>>>>
>>>> You had one clock last time, thus the review was - drop the names. Now
>>>> you changed it to 8 clocks... I don't understand.
>>>>
>>>
>>> Different platforms may have different number of clocks/resets or none.
>>> So I don't think minItems/maxItems should be specified.
>>
>> Yeah, but we want the clocks to be specific per platform. Not anything
>> anywhere.
>>
>> Best regards,
>> Krzysztof
>>
> 
> I can change like these. Are these changes can be approved?
> lpm , bus clock and "pwrup" reset can be specific cases. (The changes are from snps,dwc3.yaml.)
> 
>   clocks:
>     description:
>       In general the core supports two types of clocks. bus is a SoC Bus
>       Clock(AHB/AXI/APB). lpm is a link power management clock. But particular
>       cases may differ from that having less or more clock sources with
>       another names.
> 
>   clock-names:
>     contains:
>       anyOf:
>         - enum: [bus, lpm]
>         - true
> 

No because this does not solve my concern. You allow here anything,
which is not desired. The device bindings should specify what clocks
(and resets) you have here. Order is also fixed (with exceptions).

Now, if this is generic IP block used by different SoC vendors and it
has different clocks in different implementations, it means one
compatible for all of them is not enough anymore.

Best regards,
Krzysztof

