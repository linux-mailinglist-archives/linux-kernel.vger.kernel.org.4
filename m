Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB465BA96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjACGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACGEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:04:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45957B4A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:04:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl4so25311199plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 22:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkskwTewTRar/5MhnVSMB3WMBqWdUsoSQGdoWyN72Z8=;
        b=AhH0egL8PLryhUICWRdRzdgz9Sr/OIwmT3TLgYBttqymmpMP1yfNa7uF0SwhaiAucr
         /S4+T3gPS1VzMbK2fwFT1oNQRJ/ReERVj8oN8uER43SKV3GQYn4g5u3ajP/+QxYfdS7z
         UM+E0yWI9yrJl+n86QsHY3da8SHDjR6HVYlzjK9gG3DzccuYzBNnAOYFamEhEBxHajAn
         zRkq5sIs1/mmA+jHXWSqkMky1dsuweIa+xeujzlIO2L5j7UDZ6t8Mk+AcTjHw3ob6F4a
         WATpTtOltcLbD9FQ9EkFpaKFu/BqPwFO3rblxaR99PIeQYmjQixBIMH70So24WBcj19n
         O+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkskwTewTRar/5MhnVSMB3WMBqWdUsoSQGdoWyN72Z8=;
        b=49IgXWevaEE1syCmWqzjDxRgRsAU+fKxPIYCVW/CAzoyhsFtlrXrqboBo/MqZY7INX
         GZY0mtK5ioxAI8DO2l2Z5cvrfGOtehrsh+0JdSH5TOGPiK2kPvKx66zTw2vKJC77s1iX
         APZccpZbmz7t4I9YkcRm4yUVU7ZoddI6lceB+fz3arIbdk/8+tNIKo4Agdr9CMSNqtd5
         SSPfpY1KYC9yiPUnXY732fgS81pi0Cplv7ePnxUQmyiaPwV/5+c9e2awyUkzqJz6QyLx
         UmUhvFdM8AePo7p1um7JLFY1tFMn452ovLkIbiXkGpgMIVYlsc711SqEQG3lGQVlyNV/
         SD1g==
X-Gm-Message-State: AFqh2ko5JBZu8aCGMumqGvrn9qq+uaQbB+qLHAIMcCv+UnZHAvx8aaiM
        Isxe39d3zsou9FO6fyy4dwFjccHhhbxYPr7ZWI8=
X-Google-Smtp-Source: AMrXdXtUy3nOkYd2lTvRgPfZX+5Sor6GFocstx0z7XNRx3rjLRmHE6ZHPGxizp5neHfGx5zCpdw/Nw==
X-Received: by 2002:a17:903:2441:b0:192:748f:d5a7 with SMTP id l1-20020a170903244100b00192748fd5a7mr36728877pls.0.1672725873759;
        Mon, 02 Jan 2023 22:04:33 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902a51800b0018996404dd5sm13352793plq.109.2023.01.02.22.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 22:04:33 -0800 (PST)
Message-ID: <01d39bc6-338d-fd1f-1718-15e0594af0f1@9elements.com>
Date:   Tue, 3 Jan 2023 11:34:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
 <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
 <Y3YJ2EkYNW+gA+/R@google.com>
 <5d9e41b8-7b2a-d60b-3e92-641cea5a9f4a@9elements.com>
 <Y5HXWk4d5J9VgFBV@google.com>
 <921915e5-6b36-9d2d-ebd7-632403e3086a@9elements.com>
 <Y5mbyICg22UVFASw@google.com>
 <50212c7a-6525-4a91-f9a3-c60024b5e91d@9elements.com>
 <Y6WgtNZfeLMwPhCh@google.com>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <Y6WgtNZfeLMwPhCh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 23-12-2022 06:06 pm, Lee Jones wrote:
> On Wed, 14 Dec 2022, Naresh Solanki wrote:
> 
>> Hi Lee,
>>
>> On 14-12-2022 03:17 pm, Lee Jones wrote:
>>> On Wed, 14 Dec 2022, Naresh Solanki wrote:
>>>
>>>> Hi Lee
>>>>
>>>> On 08-12-2022 05:53 pm, Lee Jones wrote:
>>>>> On Fri, 18 Nov 2022, Naresh Solanki wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> On 17-11-2022 03:45 pm, Lee Jones wrote:
>>>>>>> On Wed, 16 Nov 2022, Naresh Solanki wrote:
>>>>>>>
>>>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>>>
>>>>>>>> Implement a regulator driver with IRQ support for fault management.
>>>>>>>> Written against documentation [1] and [2] and tested on real hardware.
>>>>>>>>
>>>>>>>> Every channel has its own regulator supplies nammed 'vss1-supply' and
>>>>>>>> 'vss2-supply'. The regulator supply is used to determine the output
>>>>>>>> voltage, as the smart switch provides no output regulation.
>>>>>>>> The driver requires the 'shunt-resistor-micro-ohms' property to be
>>>>>>>> present in Device Tree to properly calculate current related
>>>>>>>> values.
>>>>>>>>
>>>>>>>> Datasheet links:
>>>>>>>> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>>>>>>>> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>>>>>>>>
>>>>>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>>> Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>>>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>>>>>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>>>> ---
>>>>>>>>      drivers/mfd/Kconfig         |  12 +++++
>>>>>>>>      drivers/mfd/Makefile        |   1 +
>>>>>>>>      drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
>>>>>>>>      include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
>>>>>>>>      4 files changed, 207 insertions(+)
>>>>>>>>      create mode 100644 drivers/mfd/max597x.c
>>>>>>>>      create mode 100644 include/linux/mfd/max597x.h
>>>>>>>
>>>>>>> Ignoring my comments won't make them go away. :)
>>>>>>>
>>>>>>> Please tell me why you need a whole new driver, instead of adding
>>>>>>> support to simple-mfd-i2c?
>>>>>>>
>>>>>> I felt current implementation to be simpler, clearer & straight forward.
>>>>>
>>>>> If you can make it work with simple-mfd-i2c, please do so.
>>>> simple-mfd-i2c doesn't has mechanism to pass device type(max5978 vs
>>>> max5970).
>>>
>>> `git grep silergy,sy7636a -- drivers/mfd`
>> I did check the driver but there is no mechanism to distinguish between chip
>> variant i.e., 597x-regulator driver should be able to distinguish between
>> max5978 vs max5970 chip type.
> 
> How is it doing that presently?
Using i2c_device_id. driver_data hold chip variant info based on 
compatible match.
> 
> Why can't the Regulator driver read the DT or match on the parent's
> compatible for itself?
There are three drivers i.e., max597x regulator, led & iio driver.
I'm not sure if checking compatible in each driver is ok.
Recommendation ?
> 
> Providing a 100 line driver just to figure out a single value that is
> only going to be used in a single driver is a no-go.  Please find a
> better way to solve this.Yes but simple-mfd-i2c doesn't help in distinguishing chip variant & in 
situation like absence of device id register, mfd cell driver cant 
determine chip type to initialise accordingly.
Can you please recommend me an approach that can also handle this kind 
of scenario.
> 

Regards,
Naresh
