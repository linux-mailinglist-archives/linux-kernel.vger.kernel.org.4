Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27BF6A19B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBXKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBXKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:13:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125144FA91
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:12:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id bh1so16194578plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IvV+bH+C+VeI7S9uQHFqjbaSa0dBmu9Y/yAg4Kj/4o=;
        b=aFguvAoAID1KylifBI4GB0jBM3I9fZNzm//O0CXEbV/B+MUGhsczQECOWoFsBAIhpG
         akkTXYiqVOSrBXAeNN4/BmxrqB9nwO4WzdDS/yatJAfOrxPSXDHyjCpUT8toKPMqe9bh
         cD7MlMS3BBV3ki01OZDCI3AdV1XELZNnL+6lg3nMwF5UX5CIuoq1tkhj79aPSD+4u/Qf
         v6We3wWkmICmXC5qlDT7/fVakyZ3yGI+7oRarpXK3AQBm39Wfr/1WXnEDnFJpPD1vlDo
         WFgGLyfWzW0Gx+UX8BsXRSyfOSxYZGU4PJvmw7hIcYt9edn7GQEG9qI62RrdhCjSqOa7
         73KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IvV+bH+C+VeI7S9uQHFqjbaSa0dBmu9Y/yAg4Kj/4o=;
        b=33bZlyrh5+wIAsbxxefopxEi/rzw4ruNt6lJnsQXAPFdzYda0fqSk7z41NTbsmkDNL
         cH35g+MB/Zfncu3pgRFrqX08kn8Jilkuqe8jfjTYzGaW5N4RBcgBWbIE6U/17Qil/KFF
         3kmrbO3w87JNEsABxOFpwxnosCPAZZLvr3ixeq5WEJdVONBkbN2eE7eIDQ16QFNB5+ux
         EvWYy3aoaF+Tqbzo3Q/LIomqKNy5v4obJvvdAyTAUmEPnjCDQA8c92WLxRRTr4liNx/d
         OHciQ6QouXAEG4NrmIFcPt3fC2BTHgljENubgobvcKEZbQSueUCdChJSvC3UsvKXsXOG
         I72Q==
X-Gm-Message-State: AO0yUKVYNmD7IFIeyjqk15lNS2dd3GAxz8vKFeS0bm8z50U8SIW9nj5y
        5zWvX15X4Csp+ENquDJf3/mvyQ==
X-Google-Smtp-Source: AK7set88TinS01xc14vhp6vQ4QdTEryb0sekST3hLdYHjRa2gtieICleQ2cjpnWJD7UK3K9ys1sshg==
X-Received: by 2002:a17:90a:29a3:b0:233:dd4d:6b1a with SMTP id h32-20020a17090a29a300b00233dd4d6b1amr13548742pjd.3.1677233561078;
        Fri, 24 Feb 2023 02:12:41 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1179920pjb.21.2023.02.24.02.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:12:40 -0800 (PST)
Message-ID: <c293ff0c-9635-649d-984d-e382ef519759@bytedance.com>
Date:   Fri, 24 Feb 2023 18:12:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        dave@stgolabs.net, penguin-kernel@i-love.sakura.ne.jp,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/evb+PBeaahx9Os@sultan-box.localdomain>
 <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
 <Y/hzPP0G5AFhOmsY@sultan-box.localdomain>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y/hzPP0G5AFhOmsY@sultan-box.localdomain>
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



On 2023/2/24 16:20, Sultan Alsawaf wrote:
> On Fri, Feb 24, 2023 at 12:00:21PM +0800, Qi Zheng wrote:
>>
>>
>> On 2023/2/24 02:24, Sultan Alsawaf wrote:
>>> On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
>>>> The shrinker_rwsem is a global lock in shrinkers subsystem,
>>>> it is easy to cause blocking in the following cases:
>>>>
>>>> a. the write lock of shrinker_rwsem was held for too long.
>>>>      For example, there are many memcgs in the system, which
>>>>      causes some paths to hold locks and traverse it for too
>>>>      long. (e.g. expand_shrinker_info())
>>>> b. the read lock of shrinker_rwsem was held for too long,
>>>>      and a writer came at this time. Then this writer will be
>>>>      forced to wait and block all subsequent readers.
>>>>      For example:
>>>>      - be scheduled when the read lock of shrinker_rwsem is
>>>>        held in do_shrink_slab()
>>>>      - some shrinker are blocked for too long. Like the case
>>>>        mentioned in the patchset[1].
>>>>
>>>> Therefore, many times in history ([2],[3],[4],[5]), some
>>>> people wanted to replace shrinker_rwsem reader with SRCU,
>>>> but they all gave up because SRCU was not unconditionally
>>>> enabled.
>>>>
>>>> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
>>>> the SRCU is unconditionally enabled. So it's time to use
>>>> SRCU to protect readers who previously held shrinker_rwsem.
>>>>
>>>> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
>>>> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
>>>> [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>>>> [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
>>>> [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    mm/vmscan.c | 27 +++++++++++----------------
>>>>    1 file changed, 11 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 9f895ca6216c..02987a6f95d1 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>>    LIST_HEAD(shrinker_list);
>>>>    DECLARE_RWSEM(shrinker_rwsem);
>>>> +DEFINE_SRCU(shrinker_srcu);
>>>>    #ifdef CONFIG_MEMCG
>>>>    static int shrinker_nr_max;
>>>> @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>>>>    void register_shrinker_prepared(struct shrinker *shrinker)
>>>>    {
>>>>    	down_write(&shrinker_rwsem);
>>>> -	list_add_tail(&shrinker->list, &shrinker_list);
>>>> +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
>>>>    	shrinker->flags |= SHRINKER_REGISTERED;
>>>>    	shrinker_debugfs_add(shrinker);
>>>>    	up_write(&shrinker_rwsem);
>>>> @@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
>>>>    		return;
>>>>    	down_write(&shrinker_rwsem);
>>>> -	list_del(&shrinker->list);
>>>> +	list_del_rcu(&shrinker->list);
>>>>    	shrinker->flags &= ~SHRINKER_REGISTERED;
>>>>    	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>>    		unregister_memcg_shrinker(shrinker);
>>>>    	debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>>    	up_write(&shrinker_rwsem);
>>>> +	synchronize_srcu(&shrinker_srcu);
>>>> +
>>>>    	debugfs_remove_recursive(debugfs_entry);
>>>>    	kfree(shrinker->nr_deferred);
>>>> @@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
>>>>    {
>>>>    	down_write(&shrinker_rwsem);
>>>>    	up_write(&shrinker_rwsem);
>>>> +	synchronize_srcu(&shrinker_srcu);
>>>>    }
>>>>    EXPORT_SYMBOL(synchronize_shrinkers);
>>>> @@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>    {
>>>>    	unsigned long ret, freed = 0;
>>>>    	struct shrinker *shrinker;
>>>> +	int srcu_idx;
>>>>    	/*
>>>>    	 * The root memcg might be allocated even though memcg is disabled
>>>> @@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>    	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>>    		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>> -	if (!down_read_trylock(&shrinker_rwsem))
>>>> -		goto out;
>>>> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>> -	list_for_each_entry(shrinker, &shrinker_list, list) {
>>>> +	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>> +				 srcu_read_lock_held(&shrinker_srcu)) {
>>>>    		struct shrink_control sc = {
>>>>    			.gfp_mask = gfp_mask,
>>>>    			.nid = nid,
>>>> @@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>    		if (ret == SHRINK_EMPTY)
>>>>    			ret = 0;
>>>>    		freed += ret;
>>>> -		/*
>>>> -		 * Bail out if someone want to register a new shrinker to
>>>> -		 * prevent the registration from being stalled for long periods
>>>> -		 * by parallel ongoing shrinking.
>>>> -		 */
>>>> -		if (rwsem_is_contended(&shrinker_rwsem)) {
>>>> -			freed = freed ? : 1;
>>>> -			break;
>>>> -		}
>>>>    	}
>>>> -	up_read(&shrinker_rwsem);
>>>> -out:
>>>> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>    	cond_resched();
>>>>    	return freed;
>>>>    }
>>>> -- 
>>>> 2.20.1
>>>>
>>>>
>>>
>>> Hi Qi,
>>>
>>> A different problem I realized after my old attempt to use SRCU was that the
>>> unregister_shrinker() path became quite slow due to the heavy synchronize_srcu()
>>> call. Both register_shrinker() *and* unregister_shrinker() are called frequently
>>> these days, and SRCU is too unfair to the unregister path IMO.
>>
>> Hi Sultan,
>>
>> IIUC, for unregister_shrinker(), the wait time is hardly longer with
>> SRCU than with shrinker_rwsem before.
> 
> The wait time can be quite different because with shrinker_rwsem, the
> rwsem_is_contended() bailout would cause unregister_shrinker() to wait for only
> one random shrinker to finish at worst rather than waiting for *all* shrinkers
> to finish.

Yes, to be exact, unregister_shrinker() needs to wait for all the
shrinkers who entered grace period before it. But the benefit in
exchange is that the slab shrink is completely lock-free, I think this 
is more worthwhile than letting unregister_shrinker() wait a little
longer.

> 
>> And I just did a simple test. After using the script in cover letter to
>> increase the shrink_slab hotspot, I did umount 1k times at the same
>> time, and then I used bpftrace to measure the time consumption of
>> unregister_shrinker() as follows:
>>
>> bpftrace -e 'kprobe:unregister_shrinker { @start[tid] = nsecs; }
>> kretprobe:unregister_shrinker /@start[tid]/ { @ns[comm] = hist(nsecs -
>> @start[tid]); delete(@start[tid]); }'
>>
>> @ns[umount]:
>> [16K, 32K)             3 |      |
>> [32K, 64K)            66 |@@@@@@@@@@      |
>> [64K, 128K)           32 |@@@@@      |
>> [128K, 256K)          22 |@@@      |
>> [256K, 512K)          48 |@@@@@@@      |
>> [512K, 1M)            19 |@@@      |
>> [1M, 2M)             131 |@@@@@@@@@@@@@@@@@@@@@      |
>> [2M, 4M)             313
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [4M, 8M)             302 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>> |
>> [8M, 16M)             55 |@@@@@@@@@
>>
>> I see that the highest time-consuming of unregister_shrinker() is between
>> 8ms and 16ms, which feels tolerable?
> 
> If you've got a fast x86 machine then I'd say that's a bit slow. :)

Nope, I tested it on a qemu virtual machine.

And I just tested it on a physical machine (Intel(R) Xeon(R) Platinum
8260 CPU @ 2.40GHz) and the results are as follows:

1) use synchronize_srcu():

@ns[umount]:
[8K, 16K)             83 |@@@@@@@ 
      |
[16K, 32K)           578 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)            78 |@@@@@@@ 
      |
[64K, 128K)            6 | 
      |
[128K, 256K)           7 | 
      |
[256K, 512K)          29 |@@ 
      |
[512K, 1M)            51 |@@@@ 
      |
[1M, 2M)              90 |@@@@@@@@ 
      |
[2M, 4M)              70 |@@@@@@ 
      |
[4M, 8M)               8 | 
      |

2) use synchronize_srcu_expedited():

@ns[umount]:
[8K, 16K)             31 |@@ 
      |
[16K, 32K)           803 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)           158 |@@@@@@@@@@ 
      |
[64K, 128K)            4 | 
      |
[128K, 256K)           2 | 
      |
[256K, 512K)           2 | 
      |

Thanks,
Qi

> 
> This depends a lot on which shrinkers are active on your system and how much
> work each one does upon running. If a driver's shrinker doesn't have much to do
> because there's nothing it can shrink further, then it'll run fast. Conversely,
> if a driver is stressed in a way that constantly creates a lot of potential work
> for its shrinker, then the shrinker will run longer.
> 
> Since shrinkers are allowed to sleep, the delays can really add up when waiting
> for all of them to finish running. In the past, I recall observing delays of
> 100ms+ in unregister_shrinker() on slower arm64 hardware when I stress tested
> the SRCU approach.
> 
> If your GPU driver has a shrinker (such as i915), I suggest testing again under
> heavy GPU load. The GPU shrinkers can be pretty heavy IIRC.
> 
> Thanks,
> Sultan
> 
>> Thanks,
>> Qi
>>
>>>
>>> Although I never got around to submitting it, I made a non-SRCU solution [1]
>>> that uses fine-grained locking instead, which is fair to both the register path
>>> and unregister path. (The patch I've linked is a version of this adapted to an
>>> older 4.14 kernel FYI, but it can be reworked for the current kernel.)
>>>
>>> What do you think about the fine-grained locking approach?
>>>
>>> Thanks,
>>> Sultan
>>>
>>> [1] https://github.com/kerneltoast/android_kernel_google_floral/commit/012378f3173a82d2333d3ae7326691544301e76a
>>>
>>
>> -- 
>> Thanks,
>> Qi

-- 
Thanks,
Qi
