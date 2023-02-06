Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E66768B9A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBFKOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjBFKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:14:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E5CA17
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:13:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso10347784wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWnzWhG42mXoUZjE/sw1tC0Ie/sX1djVHyC4XNC0yK0=;
        b=nsEaGbsIKyGbUtHtGy1mNGeocL5YZgeXdim9zyX8/uLfP70KSMUPB0ypo6B8I7lQS2
         o0iVXcHr3am+JTH0ctMaM+Q4JiAPfOutZ7ehC3n3us3CouKcL3fZzExKjU89IAAb7H+L
         0aNq+Eiz3h4ja5O7ilQg49alwmqO4bp2kFpQ5zrBWqZ/HZAZxRfReERq2ngyzrUfuqH5
         4zPCqXjwHyOZ2TnFlOr25z8/LZhotOddkt3CU9+mZ53M1PQf/VGKLyDy8Fmjbqwxtewv
         cwJk79fIGFT0tgonsFdwjx/IHm5ySrE0L7pwetypLiF5Gn5GAyNYZgzeTryqlHldsLaz
         LHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWnzWhG42mXoUZjE/sw1tC0Ie/sX1djVHyC4XNC0yK0=;
        b=7oyGJdOoONWojKRhjM7pX608QlhAT8FeJuxnsxiLU7XS6T+zhvT+uKdZRC1qqK7gSb
         7kBprkV+io4A19sqCsOoz3dMIVK4wq2PmlJpa6Tyg6TFfwC+FocwIqMDGAOJLyaSV77Z
         KA/YgQDZW/T67wcrU3Ml37ToBgllHrWf/ABb1D0afeEO7WVdMx3nctxxfhYVU7GpDub/
         Wkb2Ow0KOYei4IlgAUTHlloTqZKBu1amfvUEt+Vs0QOT+jM9cV30Vsal6QkSnmkDV+vC
         wbfa3mhUbq/nrkjR4ZRJHrhazc2MrnGVWpnBtViWGO/tDynqKqLbD3u5r9f4PrnP19B1
         gksA==
X-Gm-Message-State: AO0yUKU9AABCwG1FAzkWgd1AgTl4ZrvtK3tvUkGqEi0aPpODxGi0DUk7
        XS4mrEIj33ZM2UorqkKgutCo0g==
X-Google-Smtp-Source: AK7set/PxB+K4iF0WC0uGYoZtVntowM3777PYzd2bhIi94e214DiQHm8b27QEmpC49irJR4kQ51h4w==
X-Received: by 2002:a1c:f209:0:b0:3df:dc29:d69 with SMTP id s9-20020a1cf209000000b003dfdc290d69mr14228591wmc.36.1675678385525;
        Mon, 06 Feb 2023 02:13:05 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm11494484wmc.4.2023.02.06.02.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 02:13:04 -0800 (PST)
Message-ID: <3c599fc9-44b9-42dd-0b89-029e45b701c3@linaro.org>
Date:   Mon, 6 Feb 2023 10:13:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/37] nvmem: patches for 6.3
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
 <Y9UmhI3hRVjLVWFp@kroah.com>
 <93530be7-b957-4481-629f-dc3bdf56972d@linaro.org>
 <Y9exOmknnNHypwsR@kroah.com>
 <75891466-48f7-f86a-d9e5-e4bb4c0e9912@linaro.org>
 <Y+CwGU0bvwIf2S3H@kroah.com> <Y+CwUax45KgxPBYE@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y+CwUax45KgxPBYE@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2023 07:46, Greg KH wrote:
> On Mon, Feb 06, 2023 at 08:45:29AM +0100, Greg KH wrote:
>> On Mon, Jan 30, 2023 at 03:54:58PM +0000, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 30/01/2023 11:59, Greg KH wrote:
>>>> On Mon, Jan 30, 2023 at 11:27:06AM +0000, Srinivas Kandagatla wrote:
>>>>>
>>>>>
>>>>> On 28/01/2023 13:43, Greg KH wrote:
>>>>>> On Fri, Jan 27, 2023 at 11:15:28AM +0000, Srinivas Kandagatla wrote:
>>>>>>> Hi Greg,
>>>>>>>
>>>>>>> Here are some nvmem patches bit more than usual for 6.3 which includes
>>>>>>>
>>>>>>> - Adding support for nvmem layouts, thanks to Michael and Miquel for
>>>>>>>      driving this effort.
>>>>>>> - Add support to stm32 STM32MP15x OPTEE based nvmem provider
>>>>>>> - Updated to qfprom bindings to include various Qualcomm SoCs.
>>>>>>> - adding sl28vpd provider layout
>>>>>>> - move imx provider to use new layout apis
>>>>>>> - add ONIE provider layout.
>>>>>>> - new helper eth_addr_add().
>>>>>>> - few minor enhancements to core and providersdrivers.
>>>>>>>
>>>>>>> Can you please queue them up for 6.3.
>>>>>>
>>>>>> This series does NOT apply to my char-misc-next branch, which is based
>>>>>> on 6.2-rc5.  What did you generate it against?
>>>>>>
>>>>> These were on top of nvmem-fixes based on 6.2-rc1.
>>>>
>>>> Ah, always say that please.
>>> My bad, I assumed that fixes will be applied and then these patches. But I
>>> should have mentioned this clearly.
>>>
>>>>
>>>>>> Can you rebase it and resend?
>>>>>
>>>>> char-misc-next does not have nvmem-fixes yet, which branch should I rebase
>>>>> these on?
>>>>
>>>> char-misc-next please.  If there are going to be merge conflicts when
>>>> the char-misc-linus branch gets merged into that with these changes, > please let me know.
>>>
>>> Yes, for sure this is going to conflict. some of the patches in this set are
>>> on top of fixes.
>>
>> Ok, now that the char-misc-linus branch is merged into my -next branch,
>> I've applied these.
> 
> Nope, lots of errors:
> 
> Commit: b4fee523c0d7 ("nvmem: stm32: fix OPTEE dependency")
> 	Fixes tag: Fixes: ae46fd89cc0cc ("nvmem: stm32: add OP-TEE support for STM32MP13x")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> Commit: b6dc9d9a156a ("of: property: fix #nvmem-cell-cells parsing")
> 	Fixes tag: Fixes: 6a80b3e6fb41 ("of: property: make #.*-cells optional for simple props")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> Commit: 57a71161cecb ("nvmem: core: fix nvmem_layout_get_match_data()")
> 	Fixes tag: Fixes: f61a093b4a0e ("nvmem: core: introduce NVMEM layouts")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> Commit: 8e1cd6f05f71 ("nvmem: core: return -ENOENT if nvmem cell is not found")
> 	Fixes tag: Fixes: e894d5ad177c ("nvmem: core: add an index parameter to the cell")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> 
> 
> Can you please fix this up and resend?
> 
thanks Greg for trying out.
Sure, will rebase on top of char-misc-next

--srini
> thanks,
> 
> greg k-h
