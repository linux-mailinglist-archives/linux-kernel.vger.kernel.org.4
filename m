Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7590E7083C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjEROP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjEROPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:15:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4B1735
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:15:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso373486066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684419315; x=1687011315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IhwvEpf+iZJb/gE6b3fJNEZ3XPbuQc9an/fybW+UgQ=;
        b=xfOYp4aPqsOpItJx8cdc4w/ThTwXyWqgq/P4jGylRK8GV3Ieqp/dMUbYtUsygArWT4
         aQ/brrc+usF19M6n8GhD+gN6bCEyUK/sUGAqHg02a3RhtMIqC6x+LXERj0T8ztPnVyAX
         wGQdN6Ub0ScfWSq+x2HH3s7CSGLlumZrZ086SN0163jRkXj2wlx6efwWMGCwjmb6jGCh
         KExaWToJrsw7h0P3hsrr0vUbDoOz5z+/rTP7GopljvFM4Fu/jzMwWGWET9MRwJ90cNKE
         x4JhbcNtLgLc62l2GZNyu7P04Ie2ZLWDN2WDOULtI73q5OEIHazLgL2m+q4A7WBVHewu
         oVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684419315; x=1687011315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IhwvEpf+iZJb/gE6b3fJNEZ3XPbuQc9an/fybW+UgQ=;
        b=JWGyceUv+J7KuRHk1AHsU1nSbu36SttextBBA3cQlcHwozQt+XKfat1caPszBYP+sa
         RHjvhtKXeasXVGFASgGj3VdySE4oFEkH+GpqSgghNlcKTuv59G7rSJpJvzHqSFCE84aF
         igXa0QzqZWyAGOGNlZhMQy9MAkAQ0+R4ENh514sYJ4VE4yH4MRibNZUcxKeziMrNHhUd
         KaCh/sTxvwu4P5wdc6slW6Q9ZEehol/7WoubkKZgHjq5QQ/YRegrjucuaCuHheXI6PV0
         tS/5epsqNyWBad42vhaibpkC3sn/Q4D9LMU3oRqj315lvyXT1qGu65p3lXglEuxo3v/j
         pXgw==
X-Gm-Message-State: AC+VfDyFMFUZjftaArppADUlXl/q5sSEyjVAaNkKf5D6MQclQ21uGBh6
        nuBWfoW7Chyt9OTLVPmJeD2q0Q==
X-Google-Smtp-Source: ACHHUZ5wOOK+/4Zdzkn8mKF6Qord3DGh5wFhoqa1tc+QlxDQBLIOmHdccwSwVCSJ9tggUv/ST2PGNw==
X-Received: by 2002:a17:906:58d5:b0:969:9fd0:7cee with SMTP id e21-20020a17090658d500b009699fd07ceemr34329664ejs.10.1684419314959;
        Thu, 18 May 2023 07:15:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e24:6d1b:6bf:4249? ([2a02:810d:15c0:828:7e24:6d1b:6bf:4249])
        by smtp.gmail.com with ESMTPSA id ju4-20020a17090798a400b0094f698073e0sm1012419ejc.123.2023.05.18.07.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 07:15:14 -0700 (PDT)
Message-ID: <3f81816a-b7a8-cc3a-0052-a2177bfb58c4@linaro.org>
Date:   Thu, 18 May 2023 16:15:12 +0200
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
 <1bbabe6d-b013-9837-8986-205a2b04de14@linaro.org>
 <b4bc7385-3706-8aa3-0117-d106fd47a45e@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b4bc7385-3706-8aa3-0117-d106fd47a45e@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 14:15, zhuyinbo wrote:
> 
> 
> 在 2023/5/18 下午3:15, Krzysztof Kozlowski 写道:
>> On 18/05/2023 05:23, zhuyinbo wrote:
>>>
>>>
>>> 在 2023/5/17 下午11:00, Krzysztof Kozlowski 写道:
>>>> On 17/05/2023 09:31, Yinbo Zhu wrote:
>>>>> Add the Loongson-2 SoC Power Management Controller binding with DT
>>>>> schema format using json-schema.
>>>>>
>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>
>>>> ...
>>>>
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - loongson,ls2k-pmc
>>>>> +      - const: syscon
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  suspend-address:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      This option indicate this PM suspend address.
>>>>
>>>> This tells me nothing. Drop "This option indicate this" and rephrase
>>>> everything to actually describe this property. Why would the address
>>>> differ on given, specific SoC? It looks like you just miss compatibles.
>>>> Anyway this needs much more explanation so we can judge whether it fits DT.
>>>
>>> Hi Krzysztof,
>>>
>>> I will add following description about "suspend-address", please review.
>>
>> Thanks.
>>
>>>
>>> The "suspend-address" is a ACPI S3 (Suspend To RAM) firmware entry
>>
>> Why do we add properties for ACPI? This does not seem right. 
> 
> 
> 1.  The suspend-address value was dependent on specific platform
>      firmware code and it tends to be confiurable. if it is a fixed value
>      that seems not friendly or the ACPI S3 will not work.

> 2. the PM driver need according to it to indicate that current SoC
>     whether support ACPI S3, because some Loongson-2 SoC doesn't support

For this you have dedicated compatibles. Which points to the fact that
you missed them here.

>     ACPI S3 but support other ACPI mode, so the PM driver need has a
>     check. if no this check and other ACPI mode will not work.

Sure, but it is not really relevant to the bindings... or rather: should
not be relevant. Bindings are for hardware or in this case also for
firmware, but not for driver.

> 
> Base on the above two points, this property was necessary.

I did not object in my last response...

> Using this property "suspend-address" can make the firmware entry
> address configurable, and then the kernel can also indicate whether
> the current SoC supports S3
> 
> In addition, from kernel code perspective, the property
> "suspend-address" was to initialize "loongarch_suspend_addr"

Again, how does it matter what kernel does?

> 
> S3 call flow:
> enter_state -> loongson_suspend_enter -> bios's loongarch_suspend_addr
> 
> SYM_FUNC_START(loongson_suspend_enter)
>          SETUP_SLEEP
>          bl              __flush_cache_all
> 
>          /* Pass RA and SP to BIOS */
>          addi.d          a1, sp, 0
>          la.pcrel        a0, loongson_wakeup_start
>          la.pcrel        t0, loongarch_suspend_addr
>          ld.d            t0, t0, 0
>          jirl            a0, t0, 0 /* Call BIOS's STR sleep routine */
> 
> 
> Please
>> reword to skip ACPI stuff, e.g. deep sleep states (Suspend to RAM).
> 
> 
> Sorry, I don't got your point.

You have DT platform, so why do you use it with ACPI in the first place?
If you have ACPI, then please drop all this and make your life easier.

If this is booted without ACPI, which would justify DT, drop the
references to ACPI. I gave you example what to use instead. If you don't
like it, no problem, reword in different way.

> 
>>
>>
>>> address which was jumped from kernel and it's value was dependent on
>>> specific platform firmware code.
>>
>> "entry address which was jumped" <- the address cannot jump. Please
>> explain who is jumping here - boot CPU? each suspended CPU? I guess the
>> first as CPUs are offlined, right?
> 
> The boot CPU was jumping to firmware and finish remaining process in
> firmware that was what ACPI S3 required and other CPUs (No-boot CPU)
> have been offline before entering firmware.

Then fix the description.

> 
>>
>>> In addition, the PM driver need
>>> according to it to indicate that current SoC whether support ACPI S3.
>>
>> Skip references to driver.
> 
> 
> Sorry, I don't got your point.  Could you elaborate on it?

If you change driver, you change bindings? No.

Bindings are for hardware, not for driver. Whatever your driver is doing
usually does not matter for the bindings and should not be included.

Best regards,
Krzysztof

