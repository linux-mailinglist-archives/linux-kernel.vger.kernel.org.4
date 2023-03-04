Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF16AAB10
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCDQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCDQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:17:03 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649A144B3;
        Sat,  4 Mar 2023 08:17:02 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g9so3772788ila.8;
        Sat, 04 Mar 2023 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677946621;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eL+JzT062skIms6dI3Im2RP8HO443dBwJahK7ZRJfqU=;
        b=j+dQCSHUKp45Xuu0DRFHJE+5pSSjXyztjR0ZMkWsO3JbKII7k6J+bJ2J+CWjtfIevZ
         bvWZ3NR52/yDr6oTEpj8aoroUo12Rx5zaOT3v1/rxb/Ht4K/8QmZhDODU3LZxrN6DYwg
         28aDjb4f8vJL6zvD58Dm6a71+0KX+izcjmMPpuN+I/RCV3sNJzrUEuj6NvssTv8lKqaG
         kVs2kz5o+PeDwhfbyqX/AHJVImJydlRFIVJpfCz+5g82GRY9ecDjj4R8H/aqWd7r2aa5
         yKgqgXi883zHW5ZDo7T/LT7R+REyZ/xaKYdrnpzW1pOWVZW3SDGrufbHilh39wLYB+Mr
         +zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677946621;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL+JzT062skIms6dI3Im2RP8HO443dBwJahK7ZRJfqU=;
        b=38z+1aznRL3XEALz9tUNTyyDGdICtH9wtpx4e1zcgDKt1HnbY4ed3LGUaAIolRqr//
         yOm9E7g6bGwOH92M9+XZybxPReG/2YCCmuHXDHy7mKd7FkfYi0fttZ4Ds3gzOuxfM/vS
         oBNpwQyXh4DmtWdYWSD6PMVW9NwDzc2YGh26VoyA0Ndm+6WN+xYjL6zoM1kwBCEICUy/
         H247P2Eyu+FPwNJNlz6xtVvPgjO6S9BF53BFwa9UfJpmLp4YvTQa/XeO9vTAZ/tM8aeX
         0PfiNklXY9B8fdMchycZi5nNr1StH8VZF8YTRxqjPuNLZ0aQ8iGSJLYzDXpAc5gCJxNy
         +sHQ==
X-Gm-Message-State: AO0yUKWIt2Lu+pTfRatGQ5ECcKBDURWQz/ENL46AKWOve7jIEHeIoLX0
        XAIgw/rRTbpG171E0oA3SNQrlAo5HOQ=
X-Google-Smtp-Source: AK7set9n/uOrpfVvY95KSjCv7KZ/Ix/BlgSCNDraxZ6CA5zMsQtwgKWBowpCN/F7Q9VRom6JwURmMg==
X-Received: by 2002:a05:6e02:1d05:b0:317:97ab:e5d1 with SMTP id i5-20020a056e021d0500b0031797abe5d1mr5480272ila.12.1677946621445;
        Sat, 04 Mar 2023 08:17:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z26-20020a056638001a00b003c2c5f13596sm1636063jao.59.2023.03.04.08.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 08:17:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <af0122a5-7f1a-7a8a-9a28-06092b12f2dd@roeck-us.net>
Date:   Sat, 4 Mar 2023 08:16:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] watchdog: sbsa: Test WDOG_HW_RUNNING bit in suspend
 and resume
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wang Wensheng <wangwensheng4@huawei.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xuqiang36@huawei.com
References: <20230301113702.76437-1-wangwensheng4@huawei.com>
 <8aff260c-7151-fe1c-91cd-1e107225a25f@roeck-us.net>
In-Reply-To: <8aff260c-7151-fe1c-91cd-1e107225a25f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/23 06:54, Guenter Roeck wrote:
> On 3/1/23 03:37, Wang Wensheng wrote:
>> If the sbsa_gwdt is enabled by BIOS, the kernel set WDOG_HW_RUNNING bit
>> and keep it alive before anyone else would open it. When system suspend,
>> the sbsa_gwdt would not be disabled because WDOG_ACTIVE is not set. Then
>> the sbsa_gwdt would reach timeout since no one touch it during system
>> suspend.
>>
>> To solve this, just test WDOG_HW_RUNNING bit in suspend and disable the
>> sbsa_gwdt if the bit is set, then reopen it accordingly in resume
>> process.
>>
>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>> ---
>>   drivers/watchdog/sbsa_gwdt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
>> index 9791c74aebd4..60875a710e43 100644
>> --- a/drivers/watchdog/sbsa_gwdt.c
>> +++ b/drivers/watchdog/sbsa_gwdt.c
>> @@ -360,7 +360,7 @@ static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
>>   {
>>       struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> -    if (watchdog_active(&gwdt->wdd))
>> +    if (watchdog_hw_running(&gwdt->wdd))
>>           sbsa_gwdt_stop(&gwdt->wdd);
> 
> That will not stop the watchdog if it is currently open (active)
> and if it wasn't running when the module was loaded.
> 

I just sent a patch which fixes the problem in the watchdog core.

Guenter

> Guenter
> 
>>       return 0;
>> @@ -371,7 +371,7 @@ static int __maybe_unused sbsa_gwdt_resume(struct device *dev)
>>   {
>>       struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> -    if (watchdog_active(&gwdt->wdd))
>> +    if (watchdog_hw_running(&gwdt->wdd))
>>           sbsa_gwdt_start(&gwdt->wdd);
>>       return 0;
> 

