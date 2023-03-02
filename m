Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724E26A784F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCBAQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCBAQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:16:09 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF004AFD5;
        Wed,  1 Mar 2023 16:16:05 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id u6so9462721ilk.12;
        Wed, 01 Mar 2023 16:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677716164;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxwe+KTQPI2+8OTrjVQjLbEsSRAVf0AZSMKHO2KLldA=;
        b=MaQb9ZDljyUPQiKLVJF86dyLmH/ZLLLXAZxfPz7IRY5VcDHJzc0jTMAggrQ1quJ32H
         muZQBulCqZvVfRIxamudedO2DzNOJvi3YWXI+oKkULQAOoKQneZPOMwp1rm8XAgZH/4D
         0hS7ZHkjPUOsjYZ10eYQ76eMK6yW605LeZdZ1OM7b68XxgZ6NDSPRjBkFswf/U6L9fJM
         lZ1ONbpZ2mi+oABY5ZTXk0YrdugwO8XrzITBADSOyh2S7Ogbzy86ve+FPycXzwU2vZgI
         +C8rDuhzOcWpBuCDKYmyZ7TWUtFJQvxJ65csmUy/cdipl48j22X6qXYv6jwV1CXq91Wb
         8csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677716164;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxwe+KTQPI2+8OTrjVQjLbEsSRAVf0AZSMKHO2KLldA=;
        b=v/NVIpOrNW7U48C7UxerJuyphGrNhB2WoDxUAL+jUaoR2xjWZ0OvZQIbAy9WCGBoy+
         M6jYqXqpicBtNcqMeCEcSARb7wct4+EBiEMemsTH8b0X28BPoTCx8Q4Y6pG+eUhutavv
         t/HWLuVt6wZNG7sXNB1GQOEx2rxZEMszyC4Ge4tIXcF7R6vTkbWj61GTUpC2sFLqxwBi
         1yAgMACVsvXrYbCA5Xiuudx2LbVccHDBqrr6qj4aSY5zmHVM9EtU9Yo4kpQ7apFbGuiv
         z0xmcBlTO5SwE+gGAPaG7Fzgl2+zbfplmFC4GI276ootqYwuT8AznUAUVpG28isT7TP6
         9bsw==
X-Gm-Message-State: AO0yUKVZa0mW9kWA1rTqKYpZwhrLaNk5TAcaZ3auUVtCoVKIOIRDBIFk
        MPew7DP//llNAmbgpg8AJegSavsJck8=
X-Google-Smtp-Source: AK7set9G7v9elUlBdyc6g5M46el7/PMhIcr7vNUu3bCYbGKfLXjrFjbZgfg94ter1QiVyXhtDkxPKA==
X-Received: by 2002:a05:6e02:1687:b0:317:9b4d:62c7 with SMTP id f7-20020a056e02168700b003179b4d62c7mr2293463ila.30.1677716164567;
        Wed, 01 Mar 2023 16:16:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10-20020a02b38a000000b003c4f96913c1sm4332648jan.105.2023.03.01.16.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 16:16:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <94616252-31b2-3c9f-29e2-f5ccf165d787@roeck-us.net>
Date:   Wed, 1 Mar 2023 16:16:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Jakob Koschel <jkl820.git@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20230301-watchdog-avoid-iter-after-loop-v1-1-851f583be9f7@gmail.com>
 <1570650d-ea9d-c3b5-801a-60e246947242@roeck-us.net>
 <20230301224211.qz4tu7ayq5iwio4q@jm1p>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: avoid usage of iterator after loop
In-Reply-To: <20230301224211.qz4tu7ayq5iwio4q@jm1p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/1/23 14:42, Jakob Koschel wrote:
> On 23/03/01 10:31AM, Guenter Roeck wrote:
>> On 3/1/23 09:17, Jakob Koschel wrote:
>>> If potentially no valid element is found, 'p' would contain an invalid
>>> pointer past the iterator loop. To ensure 'p' is valid under any
>>> circumstances, the kfree() should be within the loop body.
>>>
>>> Additionally, Linus proposed to avoid any use of the list iterator
>>> variable after the loop, in the attempt to move the list iterator
>>> variable declaration into the marcro to avoid any potential misuse after
>>
>> macro
>>
>>> the loop [1].
>>>
>>> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
>>> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
>>> ---
>>>    drivers/watchdog/watchdog_pretimeout.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
>>> index 376a495ab80c..d8c78696eaf5 100644
>>> --- a/drivers/watchdog/watchdog_pretimeout.c
>>> +++ b/drivers/watchdog/watchdog_pretimeout.c
>>> @@ -207,10 +207,10 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
>>>    	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
>>>    		if (p->wdd == wdd) {
>>>    			list_del(&p->entry);
>>> -			break;
>>> +			spin_unlock_irq(&pretimeout_lock);
>>> +			kfree(p);
>>> +			return;
>>
>> Please just make it
>> 			kfree(p);
>> 			break;
>>
>> There is no need to drop the spinlock here and/or to return
>> directly.
> 
> Ok great, I'll fix that in v2. I wasn't sure if something breaks if 'p' is released if the spinlock is still hold.
> 

Ah, interesting question. Looking into it, I don't think that is a problem.
Just to be sure, I wrote a little coccinelle script to find calls to kfree()
under spinlock_irq() and found several instances.

Guenter

