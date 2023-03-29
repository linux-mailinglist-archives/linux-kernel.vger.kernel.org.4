Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6176CF284
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjC2Sxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjC2Sx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:53:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B065A4;
        Wed, 29 Mar 2023 11:53:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so67279528edd.5;
        Wed, 29 Mar 2023 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680116001; x=1682708001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dV6zayjgZMuIPrwem1Ziq3l3A+7tMStcvlAeBVJqLAQ=;
        b=EZs+gNu1TJYockxfTUjTJEf18qWEfIP4gTkb7ZSOBePNhP7JTHXm/5YPjfINIBcekw
         aFaTgZFEQZRf39YUGZlwODA6Frk+FGZ7rXC3nf/qnzVgKmdr0wIH3vALzh1IesI8DfTm
         1i89L/8qL8bb1sLZ/ewg8CurozpRptwoAsn1ZdRBPsJEZ+B6nKoIvn35/LiHhYUZ9h0e
         fd8K4Srbumbz+BtoeskbFUXTOHu4wUNro+rFLCD4can421iy39B9TCoSAbdIS6C+oA1r
         THPg8nMH9Ej5XSs5eMFqLLJS4Kdxt2UBamSlryPuZDfOqU/1Y0CHhFFb7XH8/s3rslSO
         /D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116001; x=1682708001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dV6zayjgZMuIPrwem1Ziq3l3A+7tMStcvlAeBVJqLAQ=;
        b=QilTdjnIYWO+WI8CYXmhPCmT0UtXkail2ZPX4c3NrEEgf7d8RLUzI5bsgN2ZHGRx68
         Irhu+cqtw4QUbYuWn6fWaAP74UsGsHLd9rJ4E6PeGS035I2nLqM0o7LWArGGVLIGysYS
         JlrrKKFKdLWnmwKGtWYOaOAppOJIEhRtxgsGtyeYDIvRU0Vr1L7Eu3CpPy3FGnEQsZQx
         4rPbDzvEm01HBNyEPLdzNOfzEP5F47xRgiKYjQUQxC1jwVeVKyjgRQ2bKRFQiLjULBkg
         sHTHaBwYX3WcoSPeCwnBYeBdfqnWt8tUVgtyFnZtybR/xwqPnPY+firWNvRj5xe0mdkF
         6HCA==
X-Gm-Message-State: AAQBX9cmmTYL0nzMyn13j45hAuXNZkJxYvyTE+bXBQ4E5OlmbUcM4c6p
        6Hm90sRfoHi1E2z4nL4YCQA=
X-Google-Smtp-Source: AKy350b/+7lvXXfGZ70KsGE8/RUfOhf0AQ14l7zUKsc7jig9CVuMUu9mlqifZ5mKKVWq42wnH6Bg8Q==
X-Received: by 2002:a05:6402:42c2:b0:502:ffd:74a1 with SMTP id i2-20020a05640242c200b005020ffd74a1mr21089909edc.2.1680116001431;
        Wed, 29 Mar 2023 11:53:21 -0700 (PDT)
Received: from [10.0.7.20] (ip-084-119-241-109.um24.pools.vodafone-ip.de. [84.119.241.109])
        by smtp.gmail.com with ESMTPSA id m27-20020a170906259b00b0093a3a663ebdsm11529380ejb.154.2023.03.29.11.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 11:53:20 -0700 (PDT)
Message-ID: <881c4859-db85-b36c-de11-1552ba7e6ff4@gmail.com>
Date:   Wed, 29 Mar 2023 20:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/4] coretemp: Fix spamming of ring buffer
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CA+3fRbFzq38sQomFM7xJt-UoeLv_ZZbQ2uaHZ+8J_5ntweJ7TA@mail.gmail.com>
 <7e821f80b7700fcf1fb26f40bde8397f0e5e6d7e.camel@intel.com>
 <aeed703c-5dbb-4a6f-a4d7-3c6a55d99e9e@roeck-us.net>
 <51b2d540c174690a8e460ecba53b0195c4b01294.camel@intel.com>
From:   Peter Ganzhorn <peter.ganzhorn@gmail.com>
In-Reply-To: <51b2d540c174690a8e460ecba53b0195c4b01294.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 16:11, Zhang, Rui wrote:
> On Wed, 2023-03-29 at 05:47 -0700, Guenter Roeck wrote:
>> On Wed, Mar 29, 2023 at 03:43:58AM +0000, Zhang, Rui wrote:
>>> Hi, Peter,
>>>
>>> CC the list.
>>>
>>> On Tue, 2023-03-28 at 22:37 +0200, Peter Ganzhorn wrote:
>>>> Dear Mr. Rui,
>>>> Dear Mr. Roeck,
>>>>
>>>> please consider accepting the attached patches or
>>>> modifying the coretemp code to stop spamming my syslog.
>>>> I would appreciate it very much if you can accept the patches.
>>>>
>>>> coretemp: Improve dynamic changes of TjMax
>>>> After introduction of dynamic TjMax changes in commit
>>>> c0c67f8761cec1fe36c21d85b1a5400ea7ac30cd
>>>> my syslog gets spammed with "TjMax is ... degrees C"
>>>> messages.
>>>> If TjMax is subject to change at any time, it won't be
>>>> set in tdata anymore and re-read every time from MSR.
>>>> This causes quite a lot of dev_dbg() messages to be issued.
>>>>
>>>> The following patches change the code to read TjMax
>>>> from the MSRs into tdata->tjmax (again) but allow for a
>>>> dynamic update at any time as well. (Patches 1 and 2)
>>>> This way a message will only be issued after actual changes.
>>>> Also I replaced the dev_dbg() with dev_notice (Patch 3) and
>>>> added a additional dev_notice for the case where TjMax is
>>>> set based on assumptions. (Patch 4)
>>>>
>>>>
>>>> If you do not want to accept my patches, removing the
>>>> dev_dbg() in get_tjmax() would be the most simple
>>>> solution I guess.
>>>>
>>> Please check if below patch solves your problem or not.
>>>
>>>  From 9370ee5163a85f65230b5222f1f4dece59ce078a Mon Sep 17 00:00:00
>>> 2001
>>> From: Zhang Rui <rui.zhang@intel.com>
>>> Date: Wed, 29 Mar 2023 11:35:18 +0800
>>> Subject: [PATCH] hwmon: (coretemp) Avoid duplicate debug messages
>>>
>>> Avoid duplicate dev_dbg messages when tjmax value retrieved from
>>> MSR
>>> does not change.
>>>
>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>> ---
>>>   drivers/hwmon/coretemp.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
>>> index 30d77f451937..809456967b50 100644
>>> --- a/drivers/hwmon/coretemp.c
>>> +++ b/drivers/hwmon/coretemp.c
>>> @@ -267,6 +267,7 @@ static int get_tjmax(struct temp_data *tdata,
>>> struct device *dev)
>>>   	int err;
>>>   	u32 eax, edx;
>>>   	u32 val;
>>> +	static u32 tjmax;
>> That would apply to every instance of this driver, meaning to every
>> CPU core. Is that really appropriate ?
>>
>> Guenter
>>
> Good point.
>
> MSR_IA32_TEMPERATURE_TARGET is package scope, and the cached tjmax
> should also be package scope, or else this message is shown for each
> cpu when tjmax changes in one package.
>
> Previously, the message is printed only once during driver probing time
> thus I'm wondering how useful this is.
>
> Maybe we can just delete it?
>
> thanks,
> rui
The proposed patch from Rui Zhang does solve the issue of spamming the 
syslog.

I only get one message at boot:

[    1.370790] platform coretemp.0: TjMax is 96 degrees C

But if different packages have different tjmax values I guess the 
spamming issue may return.

Personally I'd prefer to get a message once if tjmax changes for any 
package.

Thank you both for the quick reaction.
Peter
