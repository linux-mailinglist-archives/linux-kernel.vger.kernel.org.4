Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8880E5FF980
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJOJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJOJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:43:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C23A15C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 02:43:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso10015227pja.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqNbaBtE8a7gRPkFr8ou/qz7F2daLCTWYmWk/2uidzg=;
        b=XzdLnmeX6+KJO3b7KGDLtPh1CHVUGAQPoyHWOJucixlALJqetHZYFm6cEnLi6MD97c
         skYYEg+vIQ/62HkXnXVAi0/lwKLG+gPk8K0xR3TPAuQORWlhCllrKdCOP9Ua0SOIVfrq
         E4cf4WUEihkeqmZlYLH7J2FYuwWwTQ4nX9S1ikvxE4gI4ioEYihLvDFhHbLCJetTDsWX
         IrrjMw/HkmAg9NACiwzjBxxL0hUb5zfPhHJ/XCTp6GNPIsxPSCmCIplbcCD8pg6FCCqm
         45XynuSbKdLCN9PbdJd+tiRXoxp9UTGXAT7zc9LKqUEV+UtlI8j4IX+0v+I0GYQ66Afl
         YQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqNbaBtE8a7gRPkFr8ou/qz7F2daLCTWYmWk/2uidzg=;
        b=qjj7nwa+G0F4mZdHLE+Ttg7mXRbny1licZh7e5PEAfU6unmbNc3/KywuUdjO74JZZY
         LAw8Tt3bUxQm0RdY0khLqMC4WOMeDfWW821uo7Al0GYUq07j2xed4fDS+tzFLLE1kN4L
         1gSsvlCZU6i5xgTlwbUBpwwR83RWlqm/FadCP220y24f2XN5IU9DRIJKGJmLRIPqCY9N
         Yqn47jdpstQWh9KkKA096DodKJHvi459rBcyqWoxcA+pMcOL2fOmlsmCIVOT9e7KMRzP
         kDq88DY4J1urUaEM+LPuXSeSxQ6wZIPc+RlKdlBeWcAm2gvapop0TwxTwfURMa0Gx1bp
         RD0Q==
X-Gm-Message-State: ACrzQf3EuwHvB/k7LE8/nG8DqhOSh9tq8jTkezLWG/NxyG5w68Irnl6a
        CwYrlz5HgkCt/PBBwcCMCO13gXTEdc/fFg==
X-Google-Smtp-Source: AMsMyM77gooRRBXYUgjvVXwiZdzKLCHRWucngZ/VbCvdGiONM6vvNvJ8Ayefz46qiYn3QMl5jCQsBA==
X-Received: by 2002:a17:90a:a088:b0:20d:67b7:546d with SMTP id r8-20020a17090aa08800b0020d67b7546dmr2666946pjp.6.1665827003056;
        Sat, 15 Oct 2022 02:43:23 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e66:58f0:9c96:d698:5af9:3b2? ([2409:8a28:e66:58f0:9c96:d698:5af9:3b2])
        by smtp.gmail.com with ESMTPSA id x12-20020a63170c000000b004388ba7e5a9sm2698802pgl.49.2022.10.15.02.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 02:43:22 -0700 (PDT)
Message-ID: <f7e4fe56-73b3-88e6-d6a6-6adab34f12db@bytedance.com>
Date:   Sat, 15 Oct 2022 17:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH v2] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Content-Language: en-US
To:     peterz@infradead.org, Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     quic_pkondeti@quicinc.com, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20221014110551.22695-1-zhouchengming@bytedance.com>
 <Y0lvuKbrb/pyWQDs@cmpxchg.org>
 <CAJuCfpEQPpVZ+0Nyb52y30y=5+XBqMqKkvQ93NZtOistrjAC1g@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJuCfpEQPpVZ+0Nyb52y30y=5+XBqMqKkvQ93NZtOistrjAC1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/15 00:41, Suren Baghdasaryan wrote:
> On Fri, Oct 14, 2022 at 7:18 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Fri, Oct 14, 2022 at 07:05:51PM +0800, Chengming Zhou wrote:
>>> Pavan reported a problem that PSI avgs_work idle shutoff is not
>>> working at all. Because PSI_NONIDLE condition would be observed in
>>> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
>>> only the kworker running avgs_work on the CPU.
>>>
>>> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
>>> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
>>> still will always re-arm the avgs_work, so shutoff is not working.
>>>
>>> This patch changes to use PSI_STATE_RESCHEDULE to flag whether to
>>> re-arm avgs_work in get_recent_times(). For the current CPU, we re-arm
>>> avgs_work only when (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0),
>>> for other CPUs we can just check PSI_NONIDLE delta. The new flag
>>> is only used in psi_avgs_work(), so we check in get_recent_times()
>>> that current_work() is avgs_work.
>>>
>>> One potential problem is that the brief period of non-idle time
>>> incurred between the aggregation run and the kworker's dequeue will
>>> be stranded in the per-cpu buckets until avgs_work run next time.
>>> The buckets can hold 4s worth of time, and future activity will wake
>>> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
>>> behind when shut off the avgs_work. If the kworker run other works after
>>> avgs_work shut off and doesn't have any scheduler activities for 2s,
>>> this maybe a problem.
>>>
>>> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Please make sure to test the final version. With that done,
> 
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks! Yes, I did test with this version on VM yesterday, so add:

Tested-by: Chengming Zhou <zhouchengming@bytedance.com>

