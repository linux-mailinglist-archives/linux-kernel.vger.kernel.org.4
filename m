Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514EC6A5659
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjB1KIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjB1KI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:08:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532793F1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:08:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id oj5so5265275pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677578907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMrMIaYlecKaagZSncM5nFsXU/ttF2/4dxLRTxFoUnE=;
        b=DHV9k4RY/SMPIJgI3llD499H4oNMap6lSJ+mpnFUC/L852rVVuqz27glvDAISSSNAJ
         CDhAYvWh0eI+gNhcKnz2vNbwLxnB3WNG85bTEyt0n9zqD3ifZyaqkxUQKenCLyrGmE4B
         E8zQKNcZ95GeWGueROdzJ2v7+R+DCThmJgYqj8E1R9Ok+GsYtHW9lwU8oWUjcSYC1bsy
         CcgYMyzDgCiuFFEgXe8iCISWHgVtEjjyYGbbKZeWzBXY9Zr6AmXN2V4RLNSy9jbhp+SP
         JImMK/bLsLXyxq5Kb/Btu2I2UaYH/zFt+MSMUsiew5dkS/B6lb4ybphOTgx6aBwYklFH
         CJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677578907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMrMIaYlecKaagZSncM5nFsXU/ttF2/4dxLRTxFoUnE=;
        b=J1gZZnOlhH70CbTHnaOHhDfpW4e600+VHGvcWPrPIpLjm01Ijbhohoglu1rEm8IwTk
         r9f+3uHJ+v5sxBJ2XvJ75MKK/jQhQ9tdSVjUY9fzlxyXiL+h+3IaeguEsgBhjgyTFgDl
         eAlsFmUzZTn0MLVyGqtXOtptlGdyO4vZxuIGJluCV9gCqpjQ/zeH0o0qAHnUjmw80nig
         ISY6lAdCLkNNOoHqKXHm9O9YWU++t2drrFyMmLIUuju69NUUsU2RmLLC2tzR/ykqatGj
         EvLrGhXBfmYdmPPRJ2UL/kmkw5LYHq9ZqWxWbFXV2dr25sGSDtpl1hiGPn6+MOcrAxDm
         9kTA==
X-Gm-Message-State: AO0yUKVFRPjaHKvHy56IzRvkUGUuxa+LcNxJe8V9Ko7PkxWX2/0D4iO0
        0aDry/bChz65UpPwbGjPSc7tKQ==
X-Google-Smtp-Source: AK7set9HFBjFSB2TgvbJTbWe0AX4OJ7JJU8j0+WYLowJEKgBRDhC2KUnPZFIdGX28TyBAfm4XU3eBQ==
X-Received: by 2002:a17:90a:2e8b:b0:234:117e:b122 with SMTP id r11-20020a17090a2e8b00b00234117eb122mr2677546pjd.0.1677578907668;
        Tue, 28 Feb 2023 02:08:27 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090aca0700b0023317104415sm7659621pjt.17.2023.02.28.02.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:08:27 -0800 (PST)
Message-ID: <25c644e2-70a0-9544-47db-46dd88b993d3@bytedance.com>
Date:   Tue, 28 Feb 2023 18:08:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>, Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
 <Y/zHbhxnQ2YsP+wX@kernel.org> <dcf1d336-cfe1-964e-efe7-4aa40d4a3520@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <dcf1d336-cfe1-964e-efe7-4aa40d4a3520@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/28 03:20, Kirill Tkhai wrote:
> On 27.02.2023 18:08, Mike Rapoport wrote:
>> Hi,
>>
>> On Mon, Feb 27, 2023 at 09:31:51PM +0800, Qi Zheng wrote:
>>>
>>>
>>> On 2023/2/27 03:51, Andrew Morton wrote:
>>>> On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>>
>>>>> Hi all,
>>>>>
>>>>> This patch series aims to make slab shrink lockless.
>>>>
>>>> What an awesome changelog.
>>>>
>>>>> 2. Survey
>>>>> =========
>>>>
>>>> Especially this part.
>>>>
>>>> Looking through all the prior efforts and at this patchset I am not
>>>> immediately seeing any statements about the overall effect upon
>>>> real-world workloads.  For a good example, does this patchset
>>>> measurably improve throughput or energy consumption on your servers?
>>>
>>> Hi Andrew,
>>>
>>> I re-tested with the following physical machines:
>>>
>>> Architecture:        x86_64
>>> CPU(s):              96
>>> On-line CPU(s) list: 0-95
>>> Model name:          Intel(R) Xeon(R) Platinum 8260 CPU @ 2.40GHz
>>>
>>> I found that the reason for the hotspot I described in cover letter is
>>> wrong. The reason for the down_read_trylock() hotspot is not because of
>>> the failure to trylock, but simply because of the atomic operation
>>> (cmpxchg). And this will lead to a significant reduction in IPC (insn
>>> per cycle).
>>
>> ...
>>   
>>> Then we can use the following perf command to view hotspots:
>>>
>>> perf top -U -F 999
>>>
>>> 1) Before applying this patchset:
>>>
>>>    32.31%  [kernel]           [k] down_read_trylock
>>>    19.40%  [kernel]           [k] pv_native_safe_halt
>>>    16.24%  [kernel]           [k] up_read
>>>    15.70%  [kernel]           [k] shrink_slab
>>>     4.69%  [kernel]           [k] _find_next_bit
>>>     2.62%  [kernel]           [k] shrink_node
>>>     1.78%  [kernel]           [k] shrink_lruvec
>>>     0.76%  [kernel]           [k] do_shrink_slab
>>>
>>> 2) After applying this patchset:
>>>
>>>    27.83%  [kernel]           [k] _find_next_bit
>>>    16.97%  [kernel]           [k] shrink_slab
>>>    15.82%  [kernel]           [k] pv_native_safe_halt
>>>     9.58%  [kernel]           [k] shrink_node
>>>     8.31%  [kernel]           [k] shrink_lruvec
>>>     5.64%  [kernel]           [k] do_shrink_slab
>>>     3.88%  [kernel]           [k] mem_cgroup_iter
>>>
>>> 2. At the same time, we use the following perf command to capture IPC
>>> information:
>>>
>>> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
>>>
>>> 1) Before applying this patchset:
>>>
>>>   Performance counter stats for 'system wide' (5 runs):
>>>
>>>        454187219766      cycles                    test                    (
>>> +-  1.84% )
>>>         78896433101      instructions              test #    0.17  insn per
>>> cycle           ( +-  0.44% )
>>>
>>>          10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
>>>
>>> 2) After applying this patchset:
>>>
>>>   Performance counter stats for 'system wide' (5 runs):
>>>
>>>        841954709443      cycles                    test                    (
>>> +- 15.80% )  (98.69%)
>>>        527258677936      instructions              test #    0.63  insn per
>>> cycle           ( +- 15.11% )  (98.68%)
>>>
>>>            10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
>>>
>>> We can see that IPC drops very seriously when calling
>>> down_read_trylock() at high frequency. After using SRCU,
>>> the IPC is at a normal level.
>>
>> The results you present do show improvement in IPC for an artificial test
>> script. But more interesting would be to see how a real world workloads
>> benefit from your changes.
> 
> One of the real workloads from my experience is start of an overcommitted node
> containing many starting containers after node crash (or many resuming containers
> after reboot for kernel update). In these cases memory pressure is huge, and
> the node goes round in long reclaim.

Thanks a lot for providing this real workload! :)

> 
> This patch patchset makes prealloc_memcg_shrinker() independent of do_shrink_slab(),
> so prealloc_memcg_shrinker() won't have to wait till shrink_slab_memcg() completes its
> current bit iteration, sees rwsem_is_contended() and the iteration breaks.
> 
> Also, it's important to mention that currently we have the strange behavior:
> 
> prealloc_memcg_shrinker()
>    down_write(&shrinker_rwsem)
>    idr_alloc()
>      reclaim
>        for each child memcg
>          shrink_slab_memcg()
>            down_read_trylock(&shrinker_rwsem) -> fail
> 
> All the slab reclaim in this behavior is just a parasite work, and it just wastes
> our cpu time, which does not look a good design.
> 
> Kirill

-- 
Thanks,
Qi
