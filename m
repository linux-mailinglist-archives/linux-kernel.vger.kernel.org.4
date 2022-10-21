Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967126078AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiJUNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiJUNkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:40:45 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF087139C24
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:40:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cr19so1663732qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QMp8FGpCYqy7C5D/DoAxUrW6V4QqPBDuAozCo1MMcE=;
        b=YRY1YySQT2HK+oLGZ9eUk0FtMU27bcgVFrQl+bADHHMv0T/Dz+X3JQ6C0tjrTkfE9p
         A1U+D5bq3mvVd+mbCelTwMLG9tAATiViVHeYpSqTXXspbbg2BI1ZNhmBwONxN7SAM7Ww
         P1w6Hdg0zvh9csKSlOM6s/jPD4PfbVf7JmUQekpgCldlE8gn7GzCJGapdooHEXETR7c6
         Tkwo99L6ns8NHqDtxFaNjs6UgIY3e1OQYxEFBvCKpOPZkxhZ8kFD+FoM/iyQAD8q+1aP
         CNVdLvWCGqGO7lRV7POS5oyDBm92zzVefONg7mMpkuD6qBVf91aEHKBg6US34KGo4AWW
         gnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QMp8FGpCYqy7C5D/DoAxUrW6V4QqPBDuAozCo1MMcE=;
        b=7BjsEuE7i8hex7x3ZyJl15iAdBKKKZT3EJ9qyhe+LuQyWED3n4NR+sTb8/FaCs0uJD
         jPvyz2nRTeqA/MrtGwQrSn503kQs/rVkGcA9FHC3beoNeg2UrACCLB7+MKLsv6wur+zT
         ywXSclye+TXA5XV9HbEhzdrvUr22vsDekPJJFE3q/Czj5EEOL3ipbQvo1vQ2vsh8Uy3c
         /b0rD9UXiC2GArluoe1IUkGVKtKtU+VSesJ/C5kwt4ZOLHZR5QVzLqkLQ85F9u8GgiEb
         awkdDWcxJ1+U3bOrzDEnx2VFfbMz2ba7MoTpHv/xBWEMMGkmmuzqh+hva0wCvYLc1gJO
         Y2Xg==
X-Gm-Message-State: ACrzQf3oCk4VgyU/O8pBptmgf7X7bDud7WIHxqbOYQ47PMI7t5q139/l
        Llk9krHPaaSNsIaCOlhF5/usCQ==
X-Google-Smtp-Source: AMsMyM7r4+4YgmjJL7JF3UZzz460BgvvSOBo/XR8/3L/LuJBL98u1q3HfEM/3ebADAsjAx7Bkbwpeg==
X-Received: by 2002:a05:622a:190b:b0:39c:f9a0:b31c with SMTP id w11-20020a05622a190b00b0039cf9a0b31cmr13959161qtc.445.1666359632647;
        Fri, 21 Oct 2022 06:40:32 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id bl9-20020a05620a1a8900b006cf38fd659asm9268770qkb.103.2022.10.21.06.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 06:40:31 -0700 (PDT)
Message-ID: <c573ae8d-f2ee-403f-e096-eec4b31c682f@linaro.org>
Date:   Fri, 21 Oct 2022 09:40:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Content-Language: en-US
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com> <Y1G6FIvS6WD57GXW@mail.local>
 <DM8PR03MB62477670C186E6CC5308B600962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
 <Y1KQvPAwh7NC0wbA@mail.local>
 <DM8PR03MB6247691C7AD890FA486A5955962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM8PR03MB6247691C7AD890FA486A5955962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 09:05, Tilki, Ibrahim wrote:
>> On 21/10/2022 11:44:12+0000, Tilki, Ibrahim wrote:
>>>>> +  interrupt-names:
>>>>> +    description: |
>>>>> +      Name of the interrupt pin of the RTC used for IRQ. Not required for
>>>>> +      RTCs that only have single interrupt pin available. Some of the RTCs
>>>>> +      share interrupt pins with clock input/output pins.
>>>>> +    minItems: 1
>>>>> +    items:
>>>>> +      - enum: [INTA, INTB]
>>>>> +      - enum: [INTA, INTB]
>>>>> +
>>>>
>>>> I don't think this is right, what this is doing is essentially pinmuxing
>>>> interrupts versus clocks. What happens if you want INTB but this goes
>>>> directly to a PMIC instead of the SoC?
>>>> It is not something you can express with your current bindings.
>>>>
>>>
>>> Why would a user want INTB when it is not connected to SoC?
>>> User can specify none, either one or both of the interrupt pins.
>>> I don't see what the problem here is.
>>>
>>
>> the interrupt pin may be connected to a PMIC that is able to start or
>> wake up the platform. In that case, the user would not have any
>> interrupt-names and your driver will fail to mux the interrupt on INTB.
>> Please fix.
> 
> Interrupt muxing depends on the clock configuration, not the interrupt-names property.
> Devices don't support muxing the alarm interrupt independently.
> 
> For example in the case of max31329, alarm interrupt is muxed into INTA by default.
> Alarm interrupt is muxed into INTB pin if and only if clkin is enabled.\

Just to be sure: are you now describing hardware or Linux driver behavior?

> 
> This means that if a user wants the alarm interrupt on INTB pin, they have to
> provide a clock input through "clocks" property. If that is the case, they can provide
> an interrupt for INTB pin, otherwise the alarm feature of the rtc gets disabled.
> 
> Side note: Some devices have 2 Alarms but Alarm2 does not have a register for
> matching "seconds" so only Alarm1 is used by the driver.

Best regards,
Krzysztof

