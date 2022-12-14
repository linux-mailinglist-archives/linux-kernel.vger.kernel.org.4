Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F4A64C71C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiLNKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiLNKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:31:34 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DC20BD3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:31:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 142so1689792pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uit7BxpGmjJBou7yFTUcyh++20aNuomROBIdcZwwj9U=;
        b=RWASB5/TTBTTq7EtsReUHvyGpB1mD3fHT/vFBJYDZPDkKMKMi6Ro1kazad0h51yDX0
         BhfjVjQtROr7clV8tcLDGPvm40SmT4VihSG3Q/joVQO+Fhu8KchyugynozugDv6k21RN
         6JF/oKCtc/GKnjojAlXZ0ltpICQXGX61M6KRi3GiBrX+qcNhVqPoSIQxjwwftUqHaArr
         47r/YWUTam5Hi6xlveHi9/hd4cMnoJH9p74yFFbriBfLut2cwd0tAsTuBAQYZON/QlN3
         T0oMJfiKNY4tp+V7LkAdqLrz1sK2EVnUE2ACO79bw1jsRKtwUeH/bL1PoxTDhDa3RYec
         khaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uit7BxpGmjJBou7yFTUcyh++20aNuomROBIdcZwwj9U=;
        b=vZv9KMrrpynQEFeDvDrpLS9NjGqdFaBwre+gCpZSrPlTkfa+3X4aVKnVY4SCup49iK
         WUV0dRulU2H44I6XqjRwOLTdoLMPxBYctP+sswbEWqUqug9PKHNjcFyjTFHgBlMxCCEZ
         ZkWK2Y3Tp5PJHheS0VsoGGjhnPxF0meiEOYbbXkdkPkYBPq879kzN23d+AUjdhJKV+OE
         SL6G4LjfjWFpRmqgimWL27KqRDRLmEqwDZ/wfyadPU7Eb4ZppSY3Py81rjWVx9kf3SKy
         MnYW3AzlNCEhkcsgQdhmuw8xJ+XXq+s24PGD2oJ3fUAUn8Lq0i2kkom2fufs4DklYptv
         TdJQ==
X-Gm-Message-State: ANoB5pnIQ2oaGBfZ1ZMdt8gdHvGEgKjrAMgR4VaaLvncW95pqIMBEAtq
        90Xe+wsX4P4y8Ff4gQmCyBS21w==
X-Google-Smtp-Source: AA0mqf7kbv9Wg1ySmkT35gputD387N48RnrKhtFN1h8x0F3VuJPoy1jU+RHDgpcbCc3dfkKHhn8U/w==
X-Received: by 2002:a05:6a00:705:b0:566:900e:1023 with SMTP id 5-20020a056a00070500b00566900e1023mr22133648pfl.3.1671013892372;
        Wed, 14 Dec 2022 02:31:32 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79631000000b00576ee69c130sm9114893pfg.4.2022.12.14.02.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 02:31:31 -0800 (PST)
Message-ID: <50212c7a-6525-4a91-f9a3-c60024b5e91d@9elements.com>
Date:   Wed, 14 Dec 2022 16:01:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
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
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <Y5mbyICg22UVFASw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 14-12-2022 03:17 pm, Lee Jones wrote:
> On Wed, 14 Dec 2022, Naresh Solanki wrote:
> 
>> Hi Lee
>>
>> On 08-12-2022 05:53 pm, Lee Jones wrote:
>>> On Fri, 18 Nov 2022, Naresh Solanki wrote:
>>>
>>>>
>>>>
>>>> On 17-11-2022 03:45 pm, Lee Jones wrote:
>>>>> On Wed, 16 Nov 2022, Naresh Solanki wrote:
>>>>>
>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>
>>>>>> Implement a regulator driver with IRQ support for fault management.
>>>>>> Written against documentation [1] and [2] and tested on real hardware.
>>>>>>
>>>>>> Every channel has its own regulator supplies nammed 'vss1-supply' and
>>>>>> 'vss2-supply'. The regulator supply is used to determine the output
>>>>>> voltage, as the smart switch provides no output regulation.
>>>>>> The driver requires the 'shunt-resistor-micro-ohms' property to be
>>>>>> present in Device Tree to properly calculate current related
>>>>>> values.
>>>>>>
>>>>>> Datasheet links:
>>>>>> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>>>>>> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>>>>>>
>>>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>> Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>>>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>> ---
>>>>>>     drivers/mfd/Kconfig         |  12 +++++
>>>>>>     drivers/mfd/Makefile        |   1 +
>>>>>>     drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
>>>>>>     include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
>>>>>>     4 files changed, 207 insertions(+)
>>>>>>     create mode 100644 drivers/mfd/max597x.c
>>>>>>     create mode 100644 include/linux/mfd/max597x.h
>>>>>
>>>>> Ignoring my comments won't make them go away. :)
>>>>>
>>>>> Please tell me why you need a whole new driver, instead of adding
>>>>> support to simple-mfd-i2c?
>>>>>
>>>> I felt current implementation to be simpler, clearer & straight forward.
>>>
>>> If you can make it work with simple-mfd-i2c, please do so.
>> simple-mfd-i2c doesn't has mechanism to pass device type(max5978 vs
>> max5970).
> 
> `git grep silergy,sy7636a -- drivers/mfd`
I did check the driver but there is no mechanism to distinguish between 
chip variant i.e., 597x-regulator driver should be able to distinguish 
between max5978 vs max5970 chip type.
> 
>>> No need to submit an entirely new driver for these simple use-cases.
> 
