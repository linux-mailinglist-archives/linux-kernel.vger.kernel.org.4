Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70316B677B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCLPTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCLPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:19:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1C32E67
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:19:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd5so5296903edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678634380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVue5v1bjIYpSWd7Xr5GiMxJOUCv46TrvHF2pUWpaNM=;
        b=SPMSjKFbw78R5hFIzLA21d+55ItXHdOoI0ydoP6CFZj4XfjY2hKE9eF825ot1TqTqK
         sua+dlSVE+2hgk1s1iby2zs2JRcgBdMaufz3Q3RRJ1W0+vhdWQ4EkR5U8KJg3fqSKa6J
         inKFbRy2Nde5qO4vkz3EEoPXx+TGKf53qOLg21cCD5CXRU9lqx5xf4JgjUY2pyD4t4sg
         +cN4LEkaJ9IlLoqQvvVWVbKBiBq5ktKvTdLRu2BmuKG3pWimO/nFdG0f4YsmcgJHmcoR
         8gX64xah+XEsmVBWCycDJP/iA0H0/Xe9jnOJFI1hKeEiLVKEnP34zYtbGxxV+LnnKuSR
         99jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678634380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVue5v1bjIYpSWd7Xr5GiMxJOUCv46TrvHF2pUWpaNM=;
        b=emewWoWhVxbKOf4NWfihvU1hHMFKhQlFU85RnqphZn7niW25d51LsYJde7Y56JtuAV
         i+uZf842aK595yeDF6PyJr8poHstgY9uiQA0iV3SoFupGHOS8r5sbZ24E+2BWNKW35q2
         J2mhTIF/AD91Cch7F7DWy7fkOUMuEHNKfAgubfJyQxqH23urggcYzNbW1Olbv6GHHAFV
         4Mb9jTWw6LuVNhO8VUH0dZ81tX/JhV667+bRD2pvvF0iNXdVH1Gg0Te+i54XCHKCLtP1
         XmuLTq5aCa28yV2OiFqY6kH69xBvm8SmTWZjbWGbLT/jrdytF7XC9wfFR66Zz8k9dLt/
         dFBA==
X-Gm-Message-State: AO0yUKWolE+b9Hq2DHFydu6880R6UYMdY6xKt1Uw8Y62odRapcxtfqFm
        xrLmC1KGcsxENRd3DBcigNNV2g==
X-Google-Smtp-Source: AK7set83jYWggd0C8gdw0aivv176gRlj4pod8YXwDdaCcYZYR77PbnA35xCqj7GautJq4loiXTkhjw==
X-Received: by 2002:a17:907:c60c:b0:7c0:e30a:d3e5 with SMTP id ud12-20020a170907c60c00b007c0e30ad3e5mr38141519ejc.18.1678634380356;
        Sun, 12 Mar 2023 08:19:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709062da200b008cf377e8795sm2303259eji.199.2023.03.12.08.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 08:19:39 -0700 (PDT)
Message-ID: <4935158b-84fc-ffc0-348a-2044d3de5ec6@linaro.org>
Date:   Sun, 12 Mar 2023 16:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] iio: proximity: sx9500: Mark ACPI and OF related data
 as maybe unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
 <20230311122833.03b5a3d7@jic23-huawei>
 <c66c3f92-fa33-5af1-6f19-79b6d3530862@linaro.org>
 <20230311184440.22a1ff0f@jic23-huawei>
 <e3deb29a-9468-a937-b95f-ace165aa8085@linaro.org>
 <20230312141413.49a130bc@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312141413.49a130bc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 15:14, Jonathan Cameron wrote:
> On Sun, 12 Mar 2023 11:17:05 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 11/03/2023 19:44, Jonathan Cameron wrote:
>>> On Sat, 11 Mar 2023 13:30:01 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> On 11/03/2023 13:28, Jonathan Cameron wrote:  
>>>>> On Sat, 11 Mar 2023 12:14:57 +0100
>>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>     
>>>>>> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
>>>>>> certain data unused:
>>>>>>
>>>>>>   drivers/iio/proximity/sx9500.c:1039:34: error: ‘sx9500_of_match’ defined but not used [-Werror=unused-const-variable=]
>>>>>>
>>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>    
>>>>>
>>>>> Hi Krysztof
>>>>>
>>>>> Thanks for looking at these warnings. 
>>>>>
>>>>> Drop the protection macros instead.  The tables are trivial in size and
>>>>> the of_match_ptr() breaks some ways this driver can be used.
>>>>> ACPI_PTR() isn't as bad, but is pretty much pointless given this size of
>>>>> the array. 
>>>>>     
>>>>
>>>> For ACPI platform, ACPI table is used, so nothing for PRP0001. For OF
>>>> platform, OF table is used.  
>>>
>>> So you would think, but nope.. That's not how it works (I was surprised
>>> when I came across this the first time too)
>>>  
>>> PRP0001 is magic and requires no specific support in an individual
>>> driver beyond not using that of_match_ptr() macro!  
>>
>> I know, we talk about ACPI table.
> 
> I'm not sure I follow.   I thought by ACPI table you meant the acpi_device_id
> table pointed to by acpi_match_table in struct device_driver.
> 
> That one is not needed for PRP0001.  It is irrelevant if there is one or not.
> 
> Maybe the confusion is that you think the presence of an acpi_match table means
> we don't also check PRP0001?  As you can see here
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L886
> it is checked in all cases.
> 
> If you meant the DSDT table being provide by the firmware I don't see the relevance
> to this discussion.
> 
>>
>>>
>>> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L754
>>> Docs here
>>> https://elixir.bootlin.com/linux/latest/source/Documentation/firmware-guide/acpi/enumeration.rst#L450  
>>
>> The code is compile when CONFIG_ACPI is defined, right? Then you have
>> ACPI table, so what for ACPI platform is missing? ACPI platform has ACPI
>> table.
> 
> I don't follow.  A given ACPI platform may provide in DSDT one of two choices
> to bind to this driver.

OK, I understand your point. I assumed we do not care at all about
PRP0001 if ACPI is enabled, because then we simply use ACPI table. But
indeed they might for example be not in sync...

> 
> Either it provides an entry from the acpi_device_id table, or it must
> use PRP0001 and a compatible entry from the of_device_id table.  That only works
> if of_match_ptr() is not used.
> 
> As a side note, both the IDs in the ACPI match table are not valid IDs for use
> in DSDT.  We are supporting them only because they have been used on shipping devices.
> Semtech does have a PNP ID of STH but that's not the one used.
> 
> Anyhow, to be clear. For IIO drivers, don't use of_match_ptr()
> or ACPI_PTR(). There are some legacy cases that we haven't cleaned up
> yet, but I'm not taking patches that add any new ones without a very very
> strong argument in favour and so far no one has successfully made one.


Best regards,
Krzysztof

