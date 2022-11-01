Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA16143C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 04:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKADpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKADpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 23:45:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D3165A5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 20:45:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e129so12376011pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E3FHYeGo52iVnwUtScLYFWpT6ZF0ZMzfviBS7yQTX4=;
        b=qj5uYvFkmI87fGFMEQZZcZnDcHOFXAPtbhaxpU1KrDL4U/TIWOjwn5KlstqDarvDDC
         hu4uQvN8bTEMm19Pph53SA1gKoFkrkDhvS7pJkhkr9m4gliboshwe8UfBmM0OfAowhue
         C85e+0LXBUmGJkcTXVtEFKG1m8qPQnE3mnppSulsjv/BesYJ1zusgxFeJKDIClvt4Tu5
         hvLuycVTA+fYfBL+d57dsRYZChqj/Ah8q7v8stZ+EL7clPMgVpsQcfPQBm4pV9kPtqIR
         bRIZkBm+U1NfVf1+/xFaqoRoP/tVvgXn7IfR6SD+bl0mklb717Eb4s92XN4pBwktUh4q
         A7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4E3FHYeGo52iVnwUtScLYFWpT6ZF0ZMzfviBS7yQTX4=;
        b=wQDEbeQqS3JyNrgu9lGWMcrAyyxJS3uygnJ28hBXSvjITTk2tDJ35tdjiXt4EO2zu2
         UTqpjBxRRKt+pnS5z98E13elUDUn6iqRBHzphxTTmv+V1qpT5UAYX+K+XIfaxuVIUbBS
         Kqyhe3oqafKBPPVmoM98MsqzN/et11Net5K5R51MgOOlCvh3DR95eq14c9M1dvOp0eGC
         IGY0FIwqPBvaYifWq1FErHz7/mBO971gWGeGCb6oYzqkUN6qZya2RtVZ1gy7Ow0dIQOO
         1FCi5Ym9BdUIUdPQx4eAOOctD/tUNKx0JUoSPjJA0ZVZX7dvSBRyHp5cTgzr4qtZzRwT
         NKPQ==
X-Gm-Message-State: ACrzQf1oVN8I9EdFJLynw5WuRIjrr8sQZGy4+nkn3+KKf3grTEMpb8fm
        ExeMwbCD+IkdzdpOPgzCFEUz2Q==
X-Google-Smtp-Source: AMsMyM6PCBEkU+SpAtSfZDe0/PnnSzfWq3RQK1D6dDQB4b+oLQrhptc+tpyq7kFz2S9xL8Y/1kWhZA==
X-Received: by 2002:a05:6a00:8cb:b0:52c:6962:2782 with SMTP id s11-20020a056a0008cb00b0052c69622782mr17430813pfu.81.1667274322290;
        Mon, 31 Oct 2022 20:45:22 -0700 (PDT)
Received: from [10.85.117.81] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id b24-20020a63e718000000b0046fefb18a09sm193289pgi.91.2022.10.31.20.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 20:45:21 -0700 (PDT)
Message-ID: <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com>
Date:   Tue, 1 Nov 2022 11:45:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Josh Don <joshdon@google.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
 <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
 <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TRACKER_ID autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/1 06:44, Josh Don 写道:
> On Mon, Oct 31, 2022 at 1:39 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>>>> 在 2022/10/28 07:34, Josh Don 写道:
>>> The reason for limiting the control of weight for idle cgroups is to
>>> match the semantics of the per-task SCHED_IDLE api, which gives
>>> SCHED_IDLE threads minimum weight. The idea behind SCHED_IDLE is that
>>> these entities are intended to soak "unused" cpu cycles, and should
>>> give minimal interference to any non-idle thread. However, we don't
>>> have strict priority between idle and non-idle, due to the potential
>>> for starvation issues.
>>>
>>> Perhaps you could clarify your use case a bit further. Why do you want
>>> to change the weight? Is it to adjust the competition between two idle
>>> groups, or something else?
>>>
>> Suppose we have two cgroups（idle & non-idle）in /sys/fs/cgroup/cpu.
>> Idle cgroup contains some offline service, such as beg data processing;
>> non-idle cgroup contains some online service which have
>> higher priority to users and are sensitive to latency. We set
>> quota/period for idle cgroup which indicates it's *cpu limit*.
>> In general, we consider that the idle cgroup's cpu usage
>> closer to the limit, the better. However, when the system is busy,
>> the idle cgroups can only get little cpu resources with minimum weight.
>> To cope with the above situation, we changed the default weight.
> 
> I see. So you want the part of SCHED_IDLE that makes the entity highly
> preemptible (and avoids preemption of non idle entities), but want to
> adjust weight to reach a target cpu split? That seems a bit
> counterintuitive to me, since by giving the idle entities higher
> weight, you'll end up pushing out the round-robin latency for the
> non-idle entities.
> 
> Worth noting that SCHED_IDLE is a bit of a CFS hack, but the intended
> semantics of it are that these threads soak only "remaining cycles".
> This comes with many implications beyond just weight. For example, a
> cpu running only SCHED_IDLE entities is considered as "idle" from the
> perspective of non-idle entities. If we give these idle entities
> meaningful weight, we start to break assumptions there, for example
> see sched_idle_cpu() and load balancing.
> 
> I wonder if maybe dusting off SCHED_BATCH is a better answer here, for
> this type of use case (some amount of throughput "guarantee", but with
> preemption properties similar to SCHED_IDLE). Peter, thoughts?
> 
>> One more question is, why you think this patch can strave idle entity?
>>
>>          /*
>>           * Ensure that a task that missed wakeup preemption by a
>>           * narrow margin doesn't have to wait for a full slice.
>>           * This also mitigates buddy induced latencies under load.
>>           */
>>          se = __pick_first_entity(cfs_rq);
>>          delta = curr->vruntime - se->vruntime;
>>
>>          if (delta < 0)
>>                  return;
>>
>>          if (delta > ideal_runtime)
>>                  resched_curr(rq_of(cfs_rq));
>>
>> se can preempt curr only when
>>          curr->vruntime > se->vruntime &&
>>                  curr->vruntime - se->vruntime > ideal_runtime
>> is true. I think the original purpose is that se doesn't have to wait
>> for a full slice, reduce response time if se is latency sensitive.
>> This patch just let curr exhaust it's idleal_runtime when se is idle and
>> curr is non-idle. Normally se will be choosed by pick_next_entity().
>>
>> Maybe I missed something ?
>> Thanks
> 
> No that was my mistake, I accidentally thought this delta was being
> applied to the 'if (delta_exec > ideal_runtime) {' above in
> check_preempt_tick().
> 
> Some weirdness about this change though, is that if there is a
> non-idle current entity, and the two next entities on the cfs_rq are
> idle and non-idle respectively, we'll now take longer to preempt the
> on-cpu non-idle entity, because the non-idle entity on the cfs_rq is
> 'hidden' by the idle 'first' entity. Wakeup preemption is different
> because we're always directly comparing the current entity with the
> newly woken entity.
> 
You are right, this can happen with high probability.
This patch just compared the curr with the first entity in
the tick, and it seems hard to consider all the other entity
in cfs_rq.

So, what specific negative effects this situation would cause?
For example, the "hidden" non-idle entity's latency will be worse
than before?

Thanks for your patient reply and guidance!

BenchMark
=======================================================
All the benchmark are done in /sys/fs/cgroup/cpu/online,
which is a a normal cpu cgroup. In /sys/fs/cgroup/cpu/
offline, 'perf bench sched messaging -g 1 -l 1000000000'
is ran continuously. Besides, we set offline cgroup as idle.


schbench
                      baseline patched
Lat 50.0th-qrtle-1	6	6
Lat 75.0th-qrtle-1	6	7
Lat 90.0th-qrtle-1	7	7
Lat 95.0th-qrtle-1	7	7
Lat 99.0th-qrtle-1	10	10
Lat 99.5th-qrtle-1	11	11
Lat 99.9th-qrtle-1	12	12
Lat 50.0th-qrtle-2	6	7
Lat 75.0th-qrtle-2	7	8
Lat 90.0th-qrtle-2	8	9
Lat 95.0th-qrtle-2	9	10
Lat 99.0th-qrtle-2	11	12
Lat 99.5th-qrtle-2	12	13
Lat 99.9th-qrtle-2	19	18
Lat 50.0th-qrtle-4	8	9
Lat 75.0th-qrtle-4	10	11
Lat 90.0th-qrtle-4	11	13
Lat 95.0th-qrtle-4	12	14
Lat 99.0th-qrtle-4	15	16
Lat 99.5th-qrtle-4	17	18
Lat 99.9th-qrtle-4	25	23
Lat 50.0th-qrtle-8	11	13
Lat 75.0th-qrtle-8	15	17
Lat 90.0th-qrtle-8	18	20
Lat 95.0th-qrtle-8	19	22
Lat 99.0th-qrtle-8	23	26
Lat 99.5th-qrtle-8	25	28
Lat 99.9th-qrtle-8	41	48
Lat 50.0th-qrtle-16	20	21
Lat 75.0th-qrtle-16	27	28
Lat 90.0th-qrtle-16	32	33
Lat 95.0th-qrtle-16	35	36
Lat 99.0th-qrtle-16	44	43
Lat 99.5th-qrtle-16	53	47
Lat 99.9th-qrtle-16	1310	247
Lat 50.0th-qrtle-23	28	28
Lat 75.0th-qrtle-23	39	39
Lat 90.0th-qrtle-23	46	46
Lat 95.0th-qrtle-23	50	50
Lat 99.0th-qrtle-23	62	58
Lat 99.5th-qrtle-23	449	67
Lat 99.9th-qrtle-23	5516	906

hackbench-process-pipes

                   baseline                patched
Amean     1        0.6540 (   0.00%)      0.6480 (   0.92%)
Amean     4        0.8023 (   0.00%)      0.7860 (   2.04%)
Amean     7        1.3543 (   0.00%)      1.3780 (  -1.75%)
Amean     12       2.2653 (   0.00%)      2.2853 (  -0.88%)
Amean     21       4.7187 (   0.00%)      5.7217 * -21.26%*
Amean     30       7.3217 (   0.00%)      7.5797 (  -3.52%)
Amean     48       7.8410 (   0.00%)      7.7687 (   0.92%)
Amean     79      10.6037 (   0.00%)     10.9147 (  -2.93%)
Amean     110     11.7623 (   0.00%)     12.2150 *  -3.85%*
Amean     141     11.9980 (   0.00%)     13.0153 (  -8.48%)
Amean     172     13.6023 (   0.00%)     13.3613 (   1.77%)
Amean     203     15.2607 (   0.00%)     15.5010 (  -1.57%)
Amean     234     17.1007 (   0.00%)     17.2960 (  -1.14%)
Amean     265     18.1547 (   0.00%)     18.2500 (  -0.53%)

hackbench-process-sockets

                   baseline                patched
Amean     1        0.8340 (   0.00%)      0.8290 (   0.60%)
Amean     4        1.7260 (   0.00%)      1.7340 (  -0.46%)
Amean     7        2.8583 (   0.00%)      2.8520 (   0.22%)
Amean     12       4.6833 (   0.00%)      4.7387 *  -1.18%*
Amean     21       7.9787 (   0.00%)      7.9723 (   0.08%)
Amean     30      11.1853 (   0.00%)     11.2573 *  -0.64%*
Amean     48      17.7430 (   0.00%)     17.7410 (   0.01%)
Amean     79      29.4067 (   0.00%)     29.4900 (  -0.28%)
Amean     110     41.4427 (   0.00%)     41.6630 *  -0.53%*
Amean     141     53.0730 (   0.00%)     53.4000 *  -0.62%*
Amean     172     64.6120 (   0.00%)     65.0123 *  -0.62%*
Amean     203     76.3320 (   0.00%)     76.6423 (  -0.41%)
Amean     234     87.9563 (   0.00%)     88.4263 *  -0.53%*
Amean     265     99.5607 (   0.00%)    100.3303 *  -0.77%*
Amean     296    111.0987 (   0.00%)    112.1843 *  -0.98%*

hackbench-thread-pipes

                   baseline                patched
Amean     1        0.7007 (   0.00%)      0.7087 (  -1.14%)
Amean     4        0.8553 (   0.00%)      0.8197 (   4.17%)
Amean     7        1.4327 (   0.00%)      1.4503 (  -1.23%)
Amean     12       2.3497 (   0.00%)      2.3653 (  -0.67%)
Amean     21       5.7677 (   0.00%)      5.7340 (   0.58%)
Amean     30       7.4670 (   0.00%)      7.4693 (  -0.03%)
Amean     48       8.2720 (   0.00%)      8.2417 (   0.37%)
Amean     79      11.3247 (   0.00%)     11.1930 (   1.16%)
Amean     110     13.2153 (   0.00%)     13.1750 (   0.31%)
Amean     141     14.3250 (   0.00%)     14.9840 (  -4.60%)
Amean     172     16.7150 (   0.00%)     15.8843 (   4.97%)
Amean     203     17.7397 (   0.00%)     17.4787 (   1.47%)
Amean     234     19.4990 (   0.00%)     21.0840 *  -8.13%*
Amean     265     21.6867 (   0.00%)     22.1387 (  -2.08%)
Amean     296     24.5460 (   0.00%)     25.0093 (  -1.89%)

hackbench-thread-sockets

                   baseline                patched
Amean     1        0.8930 (   0.00%)      0.8937 (  -0.07%)
Amean     4        1.7803 (   0.00%)      1.7853 (  -0.28%)
Amean     7        2.9317 (   0.00%)      2.9563 (  -0.84%)
Amean     12       4.8313 (   0.00%)      4.8227 (   0.18%)
Amean     21       8.1783 (   0.00%)      8.1900 (  -0.14%)
Amean     30      11.5653 (   0.00%)     11.5180 (   0.41%)
Amean     48      18.3100 (   0.00%)     18.2730 (   0.20%)
Amean     79      30.2047 (   0.00%)     30.2960 (  -0.30%)
Amean     110     42.3330 (   0.00%)     42.3503 (  -0.04%)
Amean     141     54.1853 (   0.00%)     54.1483 (   0.07%)
Amean     172     66.0127 (   0.00%)     65.8043 *   0.32%*
Amean     203     77.9667 (   0.00%)     77.6113 (   0.46%)
Amean     234     89.6077 (   0.00%)     89.3893 *   0.24%*
Amean     265    101.2477 (   0.00%)    101.2773 (  -0.03%)
Amean     296    113.1667 (   0.00%)    113.2967 (  -0.11%)

perfpipe
                      baseline                patched
Min       Time        8.86 (   0.00%)        8.83 (   0.39%)
1st-qrtle Time        8.92 (   0.00%)        9.00 (  -0.94%)
2nd-qrtle Time        8.99 (   0.00%)        9.06 (  -0.76%)
3rd-qrtle Time        9.06 (   0.00%)        9.08 (  -0.17%)
Max-1     Time        8.86 (   0.00%)        8.83 (   0.39%)
Max-5     Time        8.86 (   0.00%)        8.83 (   0.39%)
Max-10    Time        8.88 (   0.00%)        8.94 (  -0.70%)
Max-90    Time        9.10 (   0.00%)        9.13 (  -0.40%)
Max-95    Time        9.13 (   0.00%)        9.20 (  -0.75%)
Max-99    Time        9.15 (   0.00%)        9.22 (  -0.84%)
Max       Time        9.16 (   0.00%)        9.28 (  -1.23%)
Amean     Time        9.00 (   0.00%)        9.06 *  -0.65%*
Stddev    Time        0.09 (   0.00%)        0.09 (  -3.71%)
CoeffVar  Time        0.95 (   0.00%)        0.98 (  -3.04%)
BAmean-99 Time        8.99 (   0.00%)        9.05 (  -0.63%)
BAmean-95 Time        8.99 (   0.00%)        9.04 (  -0.62%)
BAmean-90 Time        8.98 (   0.00%)        9.04 (  -0.62%)
BAmean-75 Time        8.96 (   0.00%)        9.02 (  -0.67%)
BAmean-50 Time        8.93 (   0.00%)        9.00 (  -0.75%)
BAmean-25 Time        8.89 (   0.00%)        8.95 (  -0.68%)

tbench4 Latency
                              baseline                patched
Amean     latency-1          0.73 (   0.00%)        0.24 *  66.90%*
Amean     latency-2          0.93 (   0.00%)        0.42 *  54.94%*
Amean     latency-4          0.99 (   0.00%)        0.41 *  58.49%*
Amean     latency-8          1.03 (   0.00%)        0.82 *  20.47%*
Amean     latency-16         1.36 (   0.00%)        1.07 *  21.12%*
Amean     latency-32         2.93 (   0.00%)        1.38 *  52.74%*
Amean     latency-64         4.21 (   0.00%)        5.53 * -31.25%*
Amean     latency-128        9.76 (   0.00%)       10.67 *  -9.28%*
Amean     latency-256       23.68 (   0.00%)       12.17 *  48.59%*
Amean     latency-384       61.68 (   0.00%)       57.65 (   6.54%)

tbench4 Throughput (misleading but traditional)
                    baseline                patched
Hmean     1        287.60 (   0.00%)      287.83 (   0.08%)
Hmean     2        567.87 (   0.00%)      582.14 *   2.51%*
Hmean     4       1126.12 (   0.00%)     1143.32 *   1.53%*
Hmean     8       2138.48 (   0.00%)     2212.82 *   3.48%*
Hmean     16      3955.46 (   0.00%)     4180.57 *   5.69%*
Hmean     32      6838.94 (   0.00%)     6879.27 *   0.59%*
Hmean     64      9462.36 (   0.00%)     9267.99 *  -2.05%*
Hmean     128    17156.42 (   0.00%)    17901.01 *   4.34%*
Hmean     256    15823.09 (   0.00%)    14647.72 *  -7.43%*
Hmean     384    15366.71 (   0.00%)    16592.95 *   7.98%*

> Best,
> Josh
