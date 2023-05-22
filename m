Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B970B406
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjEVEQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVEQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:16:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA207B0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:16:35 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0wyAqpTwcFJaX0wyAq9yG5; Mon, 22 May 2023 06:16:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684728993;
        bh=P49l5BkjjQMxxon2F2IdGyzURQFvPNi/viwwBHcNnGY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j2QIJXcrDch3JfYI5slltSOeYG9KO0D0aOCrviTl+V4SjxANeAOjIvfZ1J4inc2Vw
         ztcclEMJdbRdGetvzd5YEnKfCnbp5mb5pKp7oYpy9CKaGXiFIVHqR14Iv8fQLlK2AA
         2ZlPSgDiGx2jdww3TWCPLTXKvX4gkW96G+0WJ1yktLU/0Ax/5WS8foyGuBx3uhA1BX
         GPUmk1gWrimdCDNtEyFhdpRhqeiaZJKpCDWg8RGKBHaOXgeVHqkMgxuwE7FUTcur+M
         Xab1wnEAmafmbK/zIPkqEsrtc/3EQ7S+qRiXZ4VcreU4u5x4GsfZCz4L75p5XsTYIp
         hFT+ATmveuFxA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 May 2023 06:16:33 +0200
X-ME-IP: 86.243.2.178
Message-ID: <bf3a8c88-5b6c-6a8f-e5ba-6482655ecad0@wanadoo.fr>
Date:   Mon, 22 May 2023 06:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sched/headers: remove duplicate included header
To:     "Yan Yan(cailing)" <yanyan.yan@antgroup.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Cc:     =?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20230506153924.7641-1-yanyan.yan@antgroup.com>
 <f6a4ae36-9976-6727-f462-259517c8d0cb@antgroup.com>
 <512cf22a-1196-1191-cdbb-bda3a815999d@antgroup.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <512cf22a-1196-1191-cdbb-bda3a815999d@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/05/2023 à 04:26, Yan Yan(cailing) a écrit :
> Ping, any comments?
> 
> thanks,
> 
> -Yan Yan
> 
> 在 2023/5/16 00:00, Yan Yan 写道:
>> Ping.
>>
>> It seems that removing the two same included lines is ok. Because the 
>> following "sched.h" also includes psi.h.
>>
>> Any comments?

FWIW, yes, looks good.


If you want to ga that way, their are some other potential removal 
candidates in build_utility.c:

	linux/sched/mm.h

	linux/cpufreq.h
	linux/ctype.h
	linux/proc_fs.h
	linux/spinlock_api.h
	linux/wait_api.h
	linux/workqueue_api.h

CJ

>>
>> Thanks,
>>
>> -Yan Yan
>>
>> 在 2023/5/6 23:39, 晏艳(采苓) 写道:
>>> linux/psi.h is included more than once.
>>>
>>> Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
>>> ---
>>>   kernel/sched/build_utility.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
>>> index 99bdd96f454f..80a3df49ab47 100644
>>> --- a/kernel/sched/build_utility.c
>>> +++ b/kernel/sched/build_utility.c
>>> @@ -34,7 +34,6 @@
>>>   #include <linux/nospec.h>
>>>   #include <linux/proc_fs.h>
>>>   #include <linux/psi.h>
>>> -#include <linux/psi.h>
>>>   #include <linux/ptrace_api.h>
>>>   #include <linux/sched_clock.h>
>>>   #include <linux/security.h>
> 

