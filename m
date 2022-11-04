Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93111618F43
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKDDt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDDtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:49:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C03313D70
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:49:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l2so3755471pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 20:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZqxs8uWTrDmvN9Rm1lovMWAjs6urKSRKz66z+vX3Rw=;
        b=unUc3cqJWTXub7I+v9DHFWtR6nhT+zSg5+P2NO4GvTt2JYZq2JGa/lHVJXSZ14vVIp
         cAIWUs15SacaAxImNi2uo62sSJxki7IVlRZl8gzSCtMdRlyBp08gzJS8FXL2X9qus6bz
         7E8Khh819KRAF13seVLz/2J5rg5P1z69k9LKDr8nHkdsBErZ3os0qhLV0WrRLLm3kYWa
         h872WlRhoj74XB/XHfF9bHHT8WE3l5LdbB278SuVustM+QOI6gGFBJNJ9KLMY8+q0PCb
         5dyefLs3W/eyhwcd8s9DgdEuxKSXUTagodftAqzR+HhVRXMA7CC37lO9mo06kzDiJ0y4
         PmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZqxs8uWTrDmvN9Rm1lovMWAjs6urKSRKz66z+vX3Rw=;
        b=GmOfkI3bCHhf62DevNItGQRaANFSTB4Pvzrz0UZIPAnIBOH5r9pqNtwK0qeKmRzePW
         fx8OiweTtipvibDRhlc+2JPcEE3e1SJsVCrWDijv4Yk1PsCkIu2WC/HpBHziAgGFBaqS
         MufdDOksAdTxA0LvzwmvheQ4kZh2JICZvr01/Mq523pUQIAtHX392i+Jg4eSBstW/Su0
         vEad0Gk6Q+h1IlPoBSqXeeXK6zexNGdiXhH7wA6z1iygD5FGfAS57VbcULlhBCwjt7J2
         7a5UVeMlzWYDpMkoMBezwtxQlV9uCKBQ/jnDqwUHZdoTwx37s7rbK40qTPI3SLrxVvf/
         RplQ==
X-Gm-Message-State: ACrzQf1W7XDk/rn7dpzYemRES0tlq63Sj2cwiBq3MXUdC7ShuWKu0mLD
        i3t7qmfLuWlx61Ix4hxgU2hqgQ==
X-Google-Smtp-Source: AMsMyM5nR7nn6WMCxAdaydFQtOv8U+T5QPyc28QQadOK4/joHidWiwagE79RDgpn/HzANIjHFyPcTw==
X-Received: by 2002:a17:903:11c3:b0:178:aec1:189c with SMTP id q3-20020a17090311c300b00178aec1189cmr32918108plh.136.1667533763484;
        Thu, 03 Nov 2022 20:49:23 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z15-20020aa79e4f000000b0056bb99db338sm1541705pfq.175.2022.11.03.20.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 20:49:22 -0700 (PDT)
Message-ID: <eae73b1a-cd28-e87a-e487-bd0d95b5655e@bytedance.com>
Date:   Fri, 4 Nov 2022 11:49:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [External] Re: [PATCH] sched/fair: favor non-idle group in tick
 preemption
To:     Josh Don <joshdon@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
 <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
 <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
 <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com>
 <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
From:   Hao Jia <jiahao.os@bytedance.com>
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



On 2022/11/2 Josh Don wrote:
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
> 
> By the way, I'm curious if you modified any of the sched_idle_cpu()
> and related load balancing around idle entities given that you've made
> it so that idle entities can have arbitrary weight (since, as I
> described in my prior email, this can otherwise cause issues there).

If we want to make it easier for non-idle tasks to preempt idle tasks in 
tick, maybe we can consider lowering sysctl_sched_idle_min_granularity. 
Of course this may not ensure that non-idle tasks successfully preempt 
idle tasks every time, but it seems to be more beneficial for non-idle 
tasks.

IMHO, even if it is allowed to increase the weight of non-idle, it seems 
that we can make it easier for non-idle tasks to preempt idle tasks by 
lowering sysctl_sched_idle_min_granularity.

Thanks,
Hao
