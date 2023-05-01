Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0096F2EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 08:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjEAGiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 02:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjEAGhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 02:37:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC93710DF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 23:37:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-95f4c5cb755so441673566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682923071; x=1685515071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0tnHyWx7960QJnZozvewSeefkrZoIVIzM8iblfnxVU=;
        b=OqtaB/87o/5p83MMd4Ef5B7t7qZGygubqd+oyFgZnzhrzZZvXWDb3KWKGDqHhohuit
         Ol6HSYVcP1qD3bLye4BbrFqbB9g6fmbIxzEx0RNEZlcZZ/9JtyDsQ6kRyEoy9Oc7l/4t
         pnxZR4UN45VcVxFxRQz/0cJfNF6NplzxlX8VLp8rT8GGGKu/CDp3L92tY6zxKacz3dPd
         FiRyj2QucYv/1wr++g/qgGcW6/tqnFdbheORmT8aqZPtmvR1LV6bb2Z196515W/SPztL
         /EFe9HPySgp4cTuwOgWi5MivDnZPkCyR2z+loMIbMQx2VlalpTGw0bozEGb6cudwoVIh
         sNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682923071; x=1685515071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0tnHyWx7960QJnZozvewSeefkrZoIVIzM8iblfnxVU=;
        b=UU7dfqdk0aO276yeQNxFlxQgClAdNxtfBkRIp9Qd2likoeKyB/1ZIhxwdXm4W0Vox9
         QGAXTzRJmIH/kmYsUaNkUZRSMOsvJ64aVzM/JfQ5x6VDF1eIivLCFA8MCxuFl9rDcgzz
         3GWj8plsiGLmsKCrFYkmS8TnR60oh82ZN2AV2iVKU0i7Fm7IjXTQMewxSezjb+fTES23
         HHOM7Tgwsbf00MHEwnsqBJJFZ92Xgz2CgXeNJgFLFzseVjWLaz1EYYjTAq7zN9mFzlTF
         1M/v/pkwdjbd6BVBzLtzZ2sJCamNHr4gJ9e9QQU02xXWYj9hokd/A7pvH/drMtVO1zyO
         jlGQ==
X-Gm-Message-State: AC+VfDxbLsEwHFhiitfgnyMScrUcrcHiAlnALcEC+zduJgHoeIq3pG+h
        Y/uhiNFBXbh7GH64lg4ivNkssg==
X-Google-Smtp-Source: ACHHUZ4Mg//ku7gwQj4nd/xTDpAeTadFoCbSLS0RkSPjG23pGCr+Wtt/mTHkIW02DIxQTGAeLaRUnQ==
X-Received: by 2002:a17:907:9623:b0:958:4c72:8fdb with SMTP id gb35-20020a170907962300b009584c728fdbmr12530007ejc.64.1682923071376;
        Sun, 30 Apr 2023 23:37:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id s1-20020a1709060c0100b0094f66176208sm14589520ejf.95.2023.04.30.23.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 23:37:50 -0700 (PDT)
Message-ID: <403412d0-18b8-8d2f-e044-0e27b06a2d12@linaro.org>
Date:   Mon, 1 May 2023 08:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Fwd: [PATCH 1/2] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
Content-Language: en-US
To:     8a790966-d985-c0fc-498e-c17e69a6622e@linaro.org
Cc:     devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        jiriv@axis.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <d7f77779-5d28-b78a-da4e-cc237b2a04b9@axis.com>
 <1511d33b-dab3-cddb-cbf2-7db016678362@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1511d33b-dab3-cddb-cbf2-7db016678362@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 19:09, Jiri Valek - 2N wrote:
> Hi Krzysztof,
> and thanks for the review
> 
> On 4/15/23 11:10, Krzysztof Kozlowski wrote:
>> On 15/04/2023 01:38, Jiri Valek - 2N wrote:
>>> Add support for advanced sensitivity settings and signal guard feature.
>>>
>>> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
>>> ---
>>>   .../bindings/input/microchip,cap11xx.yaml     | 64 ++++++++++++++++++-
>>>   1 file changed, 61 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>>> index 5fa625b5c5fb..08e28226a164 100644
>>> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>>> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>>> @@ -45,13 +45,13 @@ properties:
>>>         Enables the Linux input system's autorepeat feature on the input device.
>>>   
>>>     linux,keycodes:
>>> -    minItems: 6
>>> -    maxItems: 6
>>> +    minItems: 3
>>> +    maxItems: 8
>>>       description: |
>>>         Specifies an array of numeric keycode values to
>>>         be used for the channels. If this property is
>>>         omitted, KEY_A, KEY_B, etc are used as defaults.
>>> -      The array must have exactly six entries.
>>> +      The number of entries must correspond to the number of channels.
>>>   
>>>     microchip,sensor-gain:
>>>       $ref: /schemas/types.yaml#/definitions/uint32
>>> @@ -70,6 +70,58 @@ properties:
>>>         open drain. This property allows using the active
>>>         high push-pull output.
>>>   
>>> +  microchip,sensitivity-delta-sense:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    default: 32
>>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>>> +    description: |
>>
>> Do not need '|' unless you need to preserve formatting.
> 
> OK. Will remove them.
> 
>>
>>> +      Optional parameter. Controls the sensitivity multiplier of a touch detection.
>>> +      At the more sensitive settings, touches are detected for a smaller delta
>>> +      capacitance corresponding to a “lighter” touch.
>>> +
>>> +  microchip,sensitivity-base-shift:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    default: 256
>>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256]
>>> +    description: |
>>> +      Optional parameter. Controls data scaling factor.
>>> +      The higher the value of these bits, the larger the range and the lower
>>> +      the resolution of the data presented. These settings will not affect
>>> +      touch detection or sensitivity.
>>> +
>>> +  microchip,signal-guard:
>>> +    minItems: 3
>>> +    maxItems: 8
>>> +    enum: [0, 1]
>>> +    default: 0
>>
>> This was not really tested. Missing ref, mixing scalar and array
>> properties. You want items with enum. And drop default.
> 
> Ack. I will fix it.
> 
>>
>>
>>> +    description: |
>>> +      Optional parameter supported only for CAP129x.
>>
>> Then disallow it for others (allOf:if:then: ...
>> microchip,signal-guard:false)
> 
> Ack. I will fix it.
> 
>>> +      The signal guard isolates the signal from virtual grounds.
>>> +      If enabled then the behavior of the channel is changed to signal guard.
>>> +      The number of entries must correspond to the number of channels.
>>> +
>>> +  microchip,input-treshold:
>>> +    minItems: 3
>>> +    maxItems: 8
>>> +    minimum: 0
>>> +    maximum: 127
>>> +    default: 64
>>> +    description: |
>>> +      Optional parameter. Specifies the delta threshold that is used to
>>> +      determine if a touch has been detected.
>>> +      The number of entries must correspond to the number of channels.
>>> +
>>> +  microchip,calib-sensitivity:
>>> +    minItems: 3
>>> +    maxItems: 8
>>> +    enum: [1, 2, 4]
>>> +    default: 1
>>> +    description: |
>>> +      Optional parameter supported only for CAP129x. Specifies an array of
>>> +      numeric values that controls the gain used by the calibration routine to
>>> +      enable sensor inputs to be more sensitive for proximity detection.
>>> +      The number of entries must correspond to the number of channels.
>>
>> Most of these properties do not look like hardware properties. Policies
>> and runtime configuration should not be put into DT. Explain please why
>> these are board-specific thus suitable for DT.
> 
> All these parameters are intended to set HW properties of touch buttons. 

I know, but some HW properties are software policies. Consider the
simplest example - audio volume of a speaker. It's a hardware property,
but it is not for DT. Software should choose audio volume based on
user's decisions.

> Each button can have different PCB layout and when you start without 
> setting these parameters in DT, then touches won't be detected or you 
> will get false positive readings.
> E.g. 'signal-guard' change property of analog input from button to some 
> type of shield.
> I made all of them optional for backward compatibility.
> Maybe 'sensitivity-base-shift' is really not necessary to have in DT.
> I will remove it if you agree.

Keep only ones which are not policies but depend on physical/electrical
characteristic of boards.

Best regards,
Krzysztof

