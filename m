Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9B707AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjERHPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjERHPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:15:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601072D63
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:15:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f24ceae142so1914276e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394135; x=1686986135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYKmQfTmh1bEYIv0MqpLWu88gw8N39vIF7/3HVXEtq0=;
        b=Rh/fojwkalbjq0+9uWj9+OQ35gHQboxXNNSGtTDD47GISpAFuCVvveHBk6pWBLoPeP
         E7Q/hBaWeJFc+hXKNVJdBKDjZ0lRHAK9LETBu4/q9s74wkiaXdGfl1EA45vbIiIRcRiR
         RXKrFJP5cbCvcEPF9fmJDxHbQl12icgOuA0YTQhpJrYumyWFtU16sHuxhYlEAZZUG0pU
         mV+Bn9EYzuGcJ37FyA4v6v+ivfE5iDuWFCJa2TuMAQsMSG9fbhnmJXR5QPHxgJIkNTgC
         HvWHTx+zXCmDCJOVIBkgnNroQBNKbKG7njOaBF13gvRkWxUYK2ViyMm6YcW/WswwfFy1
         Q7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394135; x=1686986135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYKmQfTmh1bEYIv0MqpLWu88gw8N39vIF7/3HVXEtq0=;
        b=aOZ/Vxs3S+01nyA998JDqkmiNjk+ako8eRGhyRqx/fKLQCDqj4Lnh8W8nyAzuaQSc9
         5rAQbKp7xMATxwgQ7c/esDJ0KVbXvPEbqkVzhZaDOPKPfsk52FPS/gHcte7sFyVloZ9M
         W1ZnhMxDb8ispcbIyNKc6GfJzaPHCrY4g0HpuFBPCDWTBnzXetdr7Uyngp6WZeDVHZpw
         Oqu7UNyE8hr9VUMUBkeZS0sUBl1OyBK6FkqLcxLW+2706XuPBk6ZeAcHcE2xQmfNC4UD
         VcWf8r58cZrlExUZOM+PrJpuR4SriHTOuFoKIstiFl7oY6CQ1ZiJy7GB/vRethVQcWEO
         HReQ==
X-Gm-Message-State: AC+VfDz/D2SORTpdrb0IVbKqX7bxPRRQt92YqhlXYBTzlQ8990KSjot0
        1FNsTN5EgopvbMU+IrLhFKkT8g==
X-Google-Smtp-Source: ACHHUZ5w/WS18KRlT6zZx4TvcGzjRToUbnX6tn8AELoPIH92+lXRt2kQzNO52ptf7vSazWqiSv7+tA==
X-Received: by 2002:ac2:4117:0:b0:4e9:cfd2:e2d with SMTP id b23-20020ac24117000000b004e9cfd20e2dmr819020lfi.65.1684394135207;
        Thu, 18 May 2023 00:15:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id i13-20020a056512006d00b004ece331c830sm146808lfo.206.2023.05.18.00.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 00:15:34 -0700 (PDT)
Message-ID: <1bbabe6d-b013-9837-8986-205a2b04de14@linaro.org>
Date:   Thu, 18 May 2023 09:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/3] dt-bindings: soc: add loongson-2 pm
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230517073149.31980-1-zhuyinbo@loongson.cn>
 <20230517073149.31980-3-zhuyinbo@loongson.cn>
 <d3791702-4d41-0208-1346-34738a2883b6@linaro.org>
 <4521c591-6fcd-c96a-e2f6-f41f5c191036@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4521c591-6fcd-c96a-e2f6-f41f5c191036@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 05:23, zhuyinbo wrote:
> 
> 
> 在 2023/5/17 下午11:00, Krzysztof Kozlowski 写道:
>> On 17/05/2023 09:31, Yinbo Zhu wrote:
>>> Add the Loongson-2 SoC Power Management Controller binding with DT
>>> schema format using json-schema.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>
>> ...
>>
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - loongson,ls2k-pmc
>>> +      - const: syscon
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  suspend-address:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      This option indicate this PM suspend address.
>>
>> This tells me nothing. Drop "This option indicate this" and rephrase
>> everything to actually describe this property. Why would the address
>> differ on given, specific SoC? It looks like you just miss compatibles.
>> Anyway this needs much more explanation so we can judge whether it fits DT.
> 
> Hi Krzysztof,
> 
> I will add following description about "suspend-address", please review.

Thanks.

> 
> The "suspend-address" is a ACPI S3 (Suspend To RAM) firmware entry

Why do we add properties for ACPI? This does not seem right. Please
reword to skip ACPI stuff, e.g. deep sleep states (Suspend to RAM).


> address which was jumped from kernel and it's value was dependent on 
> specific platform firmware code. 

"entry address which was jumped" <- the address cannot jump. Please
explain who is jumping here - boot CPU? each suspended CPU? I guess the
first as CPUs are offlined, right?

> In addition, the PM driver need 
> according to it to indicate that current SoC whether support ACPI S3.

Skip references to driver.

> 

Best regards,
Krzysztof

