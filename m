Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56D46A5649
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjB1KFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjB1KFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:05:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D392BF22
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:05:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso7964174pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8tBohZg9MnxJCstc6cADUdFd79WkTqpbYudcuHPVfM=;
        b=UdrmKdvtJSSc8ocyzAgL/sJNVr9d4p3GW11ZINBSa+kJvSPEh9S5c1V1Pp1Hnk8KHc
         Da8KYjeGoihCiHvOK28YRS1BLOYoKWvv2ol9vp5Z9O65PQf7f3BENjOEwQH+sHUcZBDB
         Uy8RD6zQQzLipW2o9Bv1Soj2A1ffx2pTyaFJzZM3lcTBRICx0W0h8Fk5WaeaTOSACg0D
         /kpJyQ4Ca43u5JffS2brphSP4FmU0hcx9Z/diSp2T17uD8fGuipBaF+GFipNzfd2IqZU
         XRqJ8ng+aHF1Lg2azf6Y786lDhRcAeswhIU5LmK/pYgP6Rt3rKSnEI6oty8kETcuoZ7y
         0NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8tBohZg9MnxJCstc6cADUdFd79WkTqpbYudcuHPVfM=;
        b=EuNF/2tdDcWWEQeJhyUfd41OgJEn6kXher45J8ogSPzJKS5q7SRIxEHeXAKdPqGSQ/
         cQ1ICzIcJTx74rzsftSztfgn3BKboItf39D83f8bwOwccSxAVi3irC5z5m40yxPqRB85
         d1lODgAxveZPH/xopWueX+GVCI/DTXnn7kelhuXa7PYZuraAx0+y0W0glTAtMGQzzlN4
         gtLETzKG9pzXfhelRV7OCXeoKR4SBJKxi9TbdWdWqNVfsPM1tWDe7SHleH23hHGszp1I
         tm0uYYk/auhoKRJAo9HrJ6iqOTjeUkVWGXk5o5o7gp6wZz0ICZOvNkQ37uXdz5GnDdI3
         B15A==
X-Gm-Message-State: AO0yUKX51Cq681HhotJhs5E3TF8Tp7aasPIJQSEgmD1cdZnj1uh21Cxl
        lD01NJ+MzP2zdDCvJsA7k/0bbw==
X-Google-Smtp-Source: AK7set9psX5vxXwoVV8nogv6bidJejoWVdBThkhpxPsjL61a4DJtxSemKR4i91D+gMtsFdD2S+wtEw==
X-Received: by 2002:a17:902:e74b:b0:19a:7217:32af with SMTP id p11-20020a170902e74b00b0019a721732afmr2354000plf.5.1677578705519;
        Tue, 28 Feb 2023 02:05:05 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902704500b0019a7c890c5asm6105763plt.263.2023.02.28.02.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:05:05 -0800 (PST)
Message-ID: <63a16f0e-d6e9-29a1-069e-dc76bfd82319@bytedance.com>
Date:   Tue, 28 Feb 2023 18:04:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, sultan@kerneltoast.com,
        dave@stgolabs.net, penguin-kernel@i-love.sakura.ne.jp,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
 <Y/zHbhxnQ2YsP+wX@kernel.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y/zHbhxnQ2YsP+wX@kernel.org>
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



On 2023/2/27 23:08, Mike Rapoport wrote:
> Hi,
> 
> On Mon, Feb 27, 2023 at 09:31:51PM +0800, Qi Zheng wrote:
>>
>>
>> On 2023/2/27 03:51, Andrew Morton wrote:
>>> On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>>> Hi all,
>>>>
>>>> This patch series aims to make slab shrink lockless.
>>>
>>> What an awesome changelog.
>>>
>>>> 2. Survey
>>>> =========
>>>
>>> Especially this part.
>>>
>>> Looking through all the prior efforts and at this patchset I am not
>>> immediately seeing any statements about the overall effect upon
>>> real-world workloads.  For a good example, does this patchset
>>> measurably improve throughput or energy consumption on your servers?
>>
>> Hi Andrew,
>>
>> I re-tested with the following physical machines:
>>
>> Architecture:        x86_64
>> CPU(s):              96
>> On-line CPU(s) list: 0-95
>> Model name:          Intel(R) Xeon(R) Platinum 8260 CPU @ 2.40GHz
>>
>> I found that the reason for the hotspot I described in cover letter is
>> wrong. The reason for the down_read_trylock() hotspot is not because of
>> the failure to trylock, but simply because of the atomic operation
>> (cmpxchg). And this will lead to a significant reduction in IPC (insn
>> per cycle).
> 
> ...
>   
>> Then we can use the following perf command to view hotspots:
>>
>> perf top -U -F 999
>>
>> 1) Before applying this patchset:
>>
>>    32.31%  [kernel]           [k] down_read_trylock
>>    19.40%  [kernel]           [k] pv_native_safe_halt
>>    16.24%  [kernel]           [k] up_read
>>    15.70%  [kernel]           [k] shrink_slab
>>     4.69%  [kernel]           [k] _find_next_bit
>>     2.62%  [kernel]           [k] shrink_node
>>     1.78%  [kernel]           [k] shrink_lruvec
>>     0.76%  [kernel]           [k] do_shrink_slab
>>
>> 2) After applying this patchset:
>>
>>    27.83%  [kernel]           [k] _find_next_bit
>>    16.97%  [kernel]           [k] shrink_slab
>>    15.82%  [kernel]           [k] pv_native_safe_halt
>>     9.58%  [kernel]           [k] shrink_node
>>     8.31%  [kernel]           [k] shrink_lruvec
>>     5.64%  [kernel]           [k] do_shrink_slab
>>     3.88%  [kernel]           [k] mem_cgroup_iter
>>
>> 2. At the same time, we use the following perf command to capture IPC
>> information:
>>
>> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
>>
>> 1) Before applying this patchset:
>>
>>   Performance counter stats for 'system wide' (5 runs):
>>
>>        454187219766      cycles                    test                    (
>> +-  1.84% )
>>         78896433101      instructions              test #    0.17  insn per
>> cycle           ( +-  0.44% )
>>
>>          10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
>>
>> 2) After applying this patchset:
>>
>>   Performance counter stats for 'system wide' (5 runs):
>>
>>        841954709443      cycles                    test                    (
>> +- 15.80% )  (98.69%)
>>        527258677936      instructions              test #    0.63  insn per
>> cycle           ( +- 15.11% )  (98.68%)
>>
>>            10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
>>
>> We can see that IPC drops very seriously when calling
>> down_read_trylock() at high frequency. After using SRCU,
>> the IPC is at a normal level.
> 
> The results you present do show improvement in IPC for an artificial test
> script. But more interesting would be to see how a real world workloads
> benefit from your changes.

Hi Mike and Andrew,

I did encounter this problem under the real workload of our online
server. At the end of this email, I posted another call stack and
hot spot that I found before.

I scanned the hotspots of all our online servers yesterday and today, 
but unfortunately did not find the live environment.

Some of our servers have a large number of containers, and each
container will mount some file systems. This is likely to trigger
down_read_trylock() hotspots when the memory pressure of the whole
machine or the memory pressure of memcg is high.

So I just found a physical server with a similar configuration to the
online server yesterday for a simulation test. The call stack and the 
hot spot in the simulation test are almost exactly the same, so in
theory, when such a hot spot appears on the online server, we can also
enjoy the improvement of IPC. This will improve the performance of the
server in memory exhaustion scenarios (memcg or global level).

And the above scenario is only one aspect, and the other aspect is the
lock competition scenario mentioned by Kirill. After applying this patch 
set, slab shrink and register_shrinker() can be completely parallelized,
which can fix that problem.

These are the two main benefits for real workloads that I consider.

Thanks,
Qi

call stack
----------

@[
	down_read_trylock+1
	shrink_slab+128
	shrink_node+371
	do_try_to_free_pages+232
	try_to_free_pages+243
	_alloc_pages_slowpath+771
	_alloc_pages_nodemask+702
	pagecache_get_page+255
	filemap_fault+1361
	ext4_filemap_fault+44
	__do_fault+76
	handle_mm_fault+3543
	do_user_addr_fault+442
	do_page_fault+48
	page_fault+62
]: 1161690
@[
	down_read_trylock+1
	shrink_slab+128
	shrink_node+371
	balance_pgdat+690
	kswapd+389
	kthread+246
	ret_from_fork+31
]: 8424884
@[
	down_read_trylock+1
	shrink_slab+128
	shrink_node+371
	do_try_to_free_pages+232
	try_to_free_pages+243
	__alloc_pages_slowpath+771
	__alloc_pages_nodemask+702
	__do_page_cache_readahead+244
	filemap_fault+1674
	ext4_filemap_fault+44
	__do_fault+76
	handle_mm_fault+3543
	do_user_addr_fault+442
	do_page_fault+48
	page_fault+62
]: 20917631

hotspot
-------

52.22% [kernel]		[k] down_read_trylock
19.60% [kernel]		[k] up_read
  8.86% [kernel]		[k] shrink_slab
  2.44% [kernel]		[k] idr_find
  1.25% [kernel]		[k] count_shadow_nodes
  1.18% [kernel]		[k] shrink lruvec
  0.71% [kernel]		[k] mem_cgroup_iter
  0.71% [kernel]		[k] shrink_node
  0.55% [kernel]		[k] find_next_bit


>   
>> Thanks,
>> Qi
> 

-- 
Thanks,
Qi
