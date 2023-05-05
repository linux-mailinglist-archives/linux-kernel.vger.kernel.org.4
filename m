Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F466F7CF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEEGfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjEEGe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:34:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8D15698
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:34:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9659e9bbff5so238973466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683268496; x=1685860496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAkyvWyF4krXoVnHjLYv3tN48g1RzcAs8aMEEzXY2gY=;
        b=X45nVQF3OseaTmUfj7pBJRMMAzEWz7c0rrlHEeg+BrFiIdv1eUOV32gLBarmBiwzn0
         84jEgvVTlFFnMepHZlN1g0PIAb7dchn6FVSkf++Cl7dbt7heXfaoOX1nqsnNR5wlo25E
         vh9M5x770KVfSsYFckMSC4Q6zquP5dMn/zUB8PwfA4ocNWqbYRBuAzhHnLfd5vvzkw7e
         43nSs24A3gL9+owhW8f9uvd+0qI6+RuntPGRGZ7aXm/KZ1MPEgyPkwhet1DZ8jZ7/Ug5
         07kdPEvZEP5N3rSqm1qSRuDBJS0GrzG0Hx5s4LsyOYx3PxXqnpibMukZN5CHCgfLa3D5
         PHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268496; x=1685860496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAkyvWyF4krXoVnHjLYv3tN48g1RzcAs8aMEEzXY2gY=;
        b=FRX8ibNtZv8tQosYLaGwBgpg2q0faWn1OSfGS6Yqk5ev6XZehUFNn4DRODJkMjDOhH
         S+eYYJJo0Maia6D7elRxQY/tvocEyt5R5s+GJRERTNaL2UBkY4MtXaKoMaZrbgQ/KBH7
         EiBomla6hsV9rCV7lT+hzhwFORcxHsbWd/e6MC5N3/P9ehYn+KXOWK9vMdOMOiLpeXJt
         fmxIjD3FLqD0Q3by4JutsDssWyabU3iiRSN/3uUYZi2XA2of1pCHHxvzVUwJJ/1huemX
         dk78KCTZMqEGpg6gR0N++OETDfiQp+u6Y6lfzVzoMF5iVWqTE+N8o2eJQUr/UFu8QuSv
         wHoQ==
X-Gm-Message-State: AC+VfDwpM1LhU80EbsvczyuvJfy4IZlxhF3qWwfFJtpbhyG5RmqqI11T
        7VOmVOjH39ye/6RSj/0RUAqSfA==
X-Google-Smtp-Source: ACHHUZ5SjE3d8BPOgqSEk5hRH8FoxOL9eafK6pUEacEaW4npLAvE4VoedJACFncGXR7rz8xeqACDjQ==
X-Received: by 2002:a17:907:9405:b0:93b:5f2:36c with SMTP id dk5-20020a170907940500b0093b05f2036cmr216973ejc.61.1683268495972;
        Thu, 04 May 2023 23:34:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id kz25-20020a17090777d900b00958434d4ecesm534423ejc.13.2023.05.04.23.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 23:34:55 -0700 (PDT)
Message-ID: <d2ca44b1-71ab-093f-0dee-fa66e4aa378a@linaro.org>
Date:   Fri, 5 May 2023 08:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V2] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
 <36e7a445-7d19-911a-1a94-ffc30172e1a3@linaro.org>
 <e3083eab-ba85-3e9b-b3f2-f50816163f9f@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e3083eab-ba85-3e9b-b3f2-f50816163f9f@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 04:37, xianwei.zhao wrote:
> Hi Krzysztof,
>       Thank you for your reply.
> 
> On 2023/5/1 17:58, Krzysztof Kozlowski wrote:
>> [你通常不会收到来自 krzysztof.kozlowski@linaro.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>
>> [ EXTERNAL EMAIL ]
>>
>> On 27/04/2023 10:58, Xianwei Zhao wrote:
>>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>>> applications.
>>>
>>> Add basic support for the C3 based Amlogic AW409 board, which describes
>>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>>> booting up into the serial console.
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>
>>> ---
>>> V1 -> V2: Remove new arch, and use ARCH_MESON;
>>>            Modify node name, and delete superfluous blank lines.
>>> ---
>>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>>   .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 29 +++++++
>>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>>>   3 files changed, 116 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index cd1c5b04890a..bcec872c2444 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
>>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409-256m.dtb
>>
>> Looks wrongly ordered. 'a' is before 'm'.
> Will do.
>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>> new file mode 100644
>>> index 000000000000..edce8850b338
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>> @@ -0,0 +1,29 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "amlogic-c3.dtsi"
>>> +
>>> +/ {
>>> +     model = "Amlogic C302 aw409 Development Board";
>>> +     compatible = "amlogic,aw409", "amlogic,c3";
>>
>> Missing bindings.
>>
>> Please run scripts/checkpatch.pl and fix reported warnings.
>>
> The bindings committed by Neil, it is applied to 
> https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git 
> (v6.5/arm64-dt),
> bindings: 
> https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com/

It's not in the next, so please always link them. We expect them always
together, so if you decide to do otherwise, it's your job now to keep us
informed. Otherwise how can we know that you sent bindings or you didn't?

Best regards,
Krzysztof

