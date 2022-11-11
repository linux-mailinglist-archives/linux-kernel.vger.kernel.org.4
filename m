Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DF6251EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiKKDvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiKKDu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:50:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A568282
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:50:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h14so3412300pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L22YnLXpIfCHSS91ZQkw2QKtdoSPCdKoRl3pTi8eYNw=;
        b=qAoshWpBm3OafL2uSZnaTCf9knN4RKw6Se11OSUbclBrg/NiE6hsypnKihyBdxkSj3
         +yIBQIhf7axThTuHCgMTyCxIru14vyaZSybqh9uWhe3iUb5mVvFGsmyOYCIm2hpz8Pup
         +g4jzzF0AwRz6OEQPlXiiv6BO1BQxPTb3xJ+KIJCTjOWM6b6ds6C+ZCZ472XQEy2TNhm
         FfJ6LDwJsKgJhw4QBHWMBWNH2mnYkdUsyW29FujQXLtPnVzP8YCfgfxCBYnR0YOuDtMK
         PXMayb9Krsi1KIurkFApxdAswvqF+lm+kA2vBY5Hj2dg43b/emJ/H8YU5vLb81eLI8YO
         375w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L22YnLXpIfCHSS91ZQkw2QKtdoSPCdKoRl3pTi8eYNw=;
        b=acVrEBV7uCMpekdaDrXn3r4b2UgH7wKFahdGHmxfO0s3hhdOTA0bIxrCzYHOhJ5iD/
         CKPsmGT8l9cBckAfMpd/Uw9kEtb2/IF1wTlLoWJd6c5bTm49gXrJlpeVBZrvwC/kWkZA
         Eou1DSZe46XcTXZwcjqwuNXQlRCMp7NZ+MQ9f0JYfkF4rT0Cl+VLYR5lQ0ouhyaSsbx7
         pJVx6S4nc/wY99zB7NK0FIFRo24vQnJyLG+QWzGiQyKKbj+mf2Mlhhc9GO1AkyYVLPQm
         +pdF7gajDrkkduBZChDP7ukRq+Sb+eGWSu9Qve7Gvpf1FqCRVhWwkLS1hxCoYaWZUY1f
         2+cQ==
X-Gm-Message-State: ANoB5pmywj1D9KpUbQCIIAMhfj3tBVpQvy2kAqeJwV5YEeafh3jaJG3B
        xp667xg4BhbTTayTbb0uQM/2+w==
X-Google-Smtp-Source: AA0mqf56cniFp4vpTrEzUKAZvDq3+BAWhIgF0Q7CVWg8vyUnN5Ejyr6L40NwcZqjYCacAONPiL3hoQ==
X-Received: by 2002:a17:902:d2c1:b0:186:7395:e36a with SMTP id n1-20020a170902d2c100b001867395e36amr693393plc.83.1668138648177;
        Thu, 10 Nov 2022 19:50:48 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id g2-20020aa796a2000000b0056b91044485sm441281pfk.133.2022.11.10.19.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 19:50:47 -0800 (PST)
Message-ID: <0796b344-4c4d-5163-d3f2-c6bbf875b129@bytedance.com>
Date:   Fri, 11 Nov 2022 11:50:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Josh Don <joshdon@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
 <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
 <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
 <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com>
 <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 7:39 AM, Josh Don wrote:
>>> Some weirdness about this change though, is that if there is a
>>> non-idle current entity, and the two next entities on the cfs_rq are
>>> idle and non-idle respectively, we'll now take longer to preempt the
>>> on-cpu non-idle entity, because the non-idle entity on the cfs_rq is
>>> 'hidden' by the idle 'first' entity. Wakeup preemption is different
>>> because we're always directly comparing the current entity with the
>>> newly woken entity.
>>>
>> You are right, this can happen with high probability.
>> This patch just compared the curr with the first entity in
>> the tick, and it seems hard to consider all the other entity
>> in cfs_rq.
>>
>> So, what specific negative effects this situation would cause?
>> For example, the "hidden" non-idle entity's latency will be worse
>> than before?
> 
> As Abel points out in his email, it can push out the time it'll take
> to switch to the other non-idle entity. The change might boost some
> benchmarks numbers, but I don't think it is conclusive enough to say
> it is a generically beneficial improvement that should be integrated.

Agree.

> 
> By the way, I'm curious if you modified any of the sched_idle_cpu()
> and related load balancing around idle entities given that you've made
> it so that idle entities can have arbitrary weight (since, as I
> described in my prior email, this can otherwise cause issues there).

Being able to change idle entities' weight can bring nothing but
convenience, because it can also be achieved by modifying all their
siblings' weight. Which seems not a strong reason to get merged.

And I'm also thinking that, although rare, a non-idle group can also
have a weight close or even equal to 3. I guess some users who made
this kind of setting might only want to benefit from the preemption
at wakeup? Nevertheless this setting is supported now :)

Best,
	Abel
