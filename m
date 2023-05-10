Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5356FD8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjEJH65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjEJH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:58:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57667F0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:58:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965f7bdab6bso1065320066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683705531; x=1686297531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MovaklLI6W+xrW2iiAzq7kIKbHJ++xEhFeXlkG0vHp8=;
        b=J2p3RTPy/6viCRfBGAUIk2VkrQl8INxIncGiD0RVJoTE0x9AVApJmofy/DJyq6Fbkx
         LKSU4ZI2zwdKgbFlxs3vNQ1mdXdfcom/Gkq+oxJNsHiZphKAOTzLzV58bs89t63lkOi/
         ucrH0BWY79ukCxXHEl3RlIOd7UVF/hyp2nDxAME/xgg1WxJvB6PPJZpJlw2BH81b3y8s
         Olvodu5huJU7O3C4LBAaZE0Bh2JOjA8PB6R8aVMOt9JxWNcK0Wk4pXKIPPtDW/mx8Re5
         3MosmIOEmOCRSN0UJE3qtgnF79EvqWWx5ZX10UpAJ5vctVcVG8DuvFQFdH5Po+dqVjMA
         IDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705531; x=1686297531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MovaklLI6W+xrW2iiAzq7kIKbHJ++xEhFeXlkG0vHp8=;
        b=bw+i8eBsKSTXXrJbkq4lnfG+0M13+C/5XKZ1vPd+YPA1O9K8QjEQVQ32EifMXmKyie
         fCJGdhNG7TwL+cpOtIifINF0QE3W1ypxGdKE6ZEMtGloj3jxWyOcT4L7dbffmiqDgW9b
         inUbacz0VjuZhUD6tVmmlKMGJtBUhzFBisFxKn9O+Sx+zoeTngeFumaqkTPsoOjGnBGu
         64XNOHn0YWZG8PMWEfrwURrfH1PG1VgOTvb6QZ2/p3aOl2jtiWGemvOPpFWn7so0oTFs
         Hh4J+z8P2CSkY6RZ2wrb05N8JRrlYQRfukTUCOC55oDlyLeIMtMVjy/ZwoisaKq+V0Zf
         Oobg==
X-Gm-Message-State: AC+VfDyKTqm1mbBse3gmW+aKbpyHtxxlFoEsO4QZVz7YPMfnV6C/xOtq
        jeBZeQdpEfTZhrF/e6D2yGv3JAGEA2wYOLa7ud8=
X-Google-Smtp-Source: ACHHUZ4MGszQ7NCz9iagPu2gO48np4OkpzCfXOqnkcQg3RnJVnHCYuH6Ipq/PBN1Va5sr7vU+pi13w==
X-Received: by 2002:a17:907:6d8f:b0:94f:928a:af0f with SMTP id sb15-20020a1709076d8f00b0094f928aaf0fmr15935756ejc.47.1683705530760;
        Wed, 10 May 2023 00:58:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id ze11-20020a170906ef8b00b00965b0eb7b0csm2316921ejb.103.2023.05.10.00.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:58:50 -0700 (PDT)
Message-ID: <1c2aa022-348a-8ac2-1a26-eedf57aadb77@linaro.org>
Date:   Wed, 10 May 2023 09:58:48 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a4d934c6-ec28-50d0-b9bb-9b11fee7ebb6@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 09:14, Claudiu.Beznea@microchip.com wrote:
> On 10.05.2023 10:06, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 10/05/2023 09:00, Claudiu.Beznea@microchip.com wrote:
>>> On 09.05.2023 09:25, Krzysztof Kozlowski wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On 09/05/2023 07:27, Claudiu Beznea wrote:
>>>>> Convert Atmel PMC documentation to yaml. Along with it clock names
>>>>> were adapted according to the current available device trees as
>>>>> different controller versions accept different clocks (some of them
>>>>> have 3 clocks as input, some has 2 clocks as inputs and some with 2
>>>>> input clocks uses different clock names).
>>>>>
>>>>
>>>> Thank you for your patch. There is something to discuss/improve.
>>>>
>>>>> +title: Atmel Power Management Controller (PMC)
>>>>> +
>>>>> +maintainers:
>>>>> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
>>>>> +
>>>>> +description:
>>>>> +  The power management controller optimizes power consumption by controlling all
>>>>> +  system and user peripheral clocks. The PMC enables/disables the clock inputs
>>>>> +  to many of the peripherals and to the processor.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - atmel,at91sam9g15-pmc
>>>>> +              - atmel,at91sam9g20-pmc
>>>>> +              - atmel,at91sam9g25-pmc
>>>>> +              - atmel,at91sam9g35-pmc
>>>>> +              - atmel,at91sam9x25-pmc
>>>>> +              - atmel,at91sam9x35-pmc
>>>>> +          - enum:
>>>>> +              - atmel,at91sam9260-pmc
>>>>> +              - atmel,at91sam9x5-pmc
>>>>
>>>> I missed it last time - why you have two enums? We never talked about
>>>> this. It's usually wrong... are you sure this is real hardware:
>>>> atmel,at91sam9g20-pmc, atmel,at91sam9260-pmc
>>>> ?
>>>
>>> I have 2 enums because there are some hardware covered by:
>>> "vendor-name,hardware-v1-pmc", "syscon" and some covered by:
>>> "vendor-name,hardware-v2-pmc", "vendor-name,hardware-v1-pmc", "syscon".
>>
>> The enum does not say this. At all.
>>
>> So again, answer, do not ignore:
>> is this valid setup:
>> atmel,at91sam9g20-pmc, atmel,at91sam9260-pmc
>> ?
> 
> Not w/o syscon. This is valid:

Syscon is not important here, but indeed I missed it.

> 
> compatible = "atmel,at91sam9g20-pmc", "atmel,at91sam9260-pmc", "syscon";
> 
> available in arch/arm/boot/dts/at91sam9g20.dtsi +45

Nice, so my random choice was actually correct. Ok, so another:

atmel,at91sam9g15-pmc, atmel,at91sam9260-pmc, syscon

Is it valid hardware?

Best regards,
Krzysztof

