Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C43B6A15C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBXERE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBXERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:17:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA03570B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:16:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so1513595pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677212194;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0AKwR5mqxsrvlagPHmXtlEufeGgOH+YmDlsDpN2VBxc=;
        b=cVay3KVnoML1OdCm7wPJopWbu1AUHi55YoN/MOF+35JayCxTCfn8hirZ9qDc60CkH0
         aawGYZhRy+ddSkaw/eD861ziKMbHW71xlDaz/HsZqS7vaX6P89EBqpJ2lclvGReT2g8x
         Ia3+LBN1RZDeu5npTmmbSylS2gYMc9tOPewFW0ih7zxGsismSUlTHmozLCr5CVuUyxDg
         FtiNrfaSorubO5vUM+mB0YrpRY/Apme2ux1DzE5OHPV/Lb1Tm0IN0fX34EOxKV4QPvVU
         qyEBiw7hqGht0TbTtig3nN5Wswy/9imauOXV5Z13uQyyKjkPveD4NhLeLez3sho6y1Uf
         o1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677212194;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AKwR5mqxsrvlagPHmXtlEufeGgOH+YmDlsDpN2VBxc=;
        b=ezK7hOIVXQ/nowotp97zGxPFcjOOP72XM0lct4kRFUHH2Bj4xF95QF+XDuXV0TrId+
         UsO7XIq1TCcpyAv0e9H1RhqaC12F03WWTnPBQhBo603X49qLbEKsbo7U33mabIDQtXhQ
         IrgSvzmRHEi7YAS7zmCoP1wRDtFAEot/WQz8/inf1ZL2DJP1b6eDq5KNsaqLyh3ANhlY
         onuA/phR90x3KWwWS+1Aidzkca5KYEaOtw8Ikc0R9LRlxGS4j8+lhSTXNDiwz/f0kZEC
         WGj7WZ6D+SYuGW9earQ41UGScANJUn7g6zh3aa1dQQ6ITB0+0B0BOU4lMU/XPkN+GJKk
         +R6A==
X-Gm-Message-State: AO0yUKUmwVYYZ7BiDBKGY3rQO1zXUx9zDDjQLoKS+cC/8U7T37zoJNZE
        XselVWApqviIwffN29u92RgeOw==
X-Google-Smtp-Source: AK7set8D7O6WtJCkcqkTUSxRg7xCsDosJwIgciP3mH3dHeZlxLbwATist2ZRRFxoK0Qg+rUsaQl/xQ==
X-Received: by 2002:a17:902:ab57:b0:19a:839d:b67a with SMTP id ij23-20020a170902ab5700b0019a839db67amr14959487plb.5.1677212194305;
        Thu, 23 Feb 2023 20:16:34 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902b58700b0019abd4ddbf2sm5928115pls.179.2023.02.23.20.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 20:16:33 -0800 (PST)
Message-ID: <00a212ee-1433-937f-1f15-f82e3137778c@bytedance.com>
Date:   Fri, 24 Feb 2023 12:16:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>, paulmck@kernel.org
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        dave@stgolabs.net, penguin-kernel@i-love.sakura.ne.jp,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/evb+PBeaahx9Os@sultan-box.localdomain>
 <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
In-Reply-To: <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/24 12:00, Qi Zheng wrote:
> 
> 
> On 2023/2/24 02:24, Sultan Alsawaf wrote:
>> On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
>>> The shrinker_rwsem is a global lock in shrinkers subsystem,
>>> it is easy to cause blocking in the following cases:
>>>
>>> a. the write lock of shrinker_rwsem was held for too long.
>>>     For example, there are many memcgs in the system, which
>>>     causes some paths to hold locks and traverse it for too
>>>     long. (e.g. expand_shrinker_info())
>>> b. the read lock of shrinker_rwsem was held for too long,
>>>     and a writer came at this time. Then this writer will be
>>>     forced to wait and block all subsequent readers.
>>>     For example:
>>>     - be scheduled when the read lock of shrinker_rwsem is
>>>       held in do_shrink_slab()
>>>     - some shrinker are blocked for too long. Like the case
>>>       mentioned in the patchset[1].
>>>
>>> Therefore, many times in history ([2],[3],[4],[5]), some
>>> people wanted to replace shrinker_rwsem reader with SRCU,
>>> but they all gave up because SRCU was not unconditionally
>>> enabled.
>>>
>>> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
>>> the SRCU is unconditionally enabled. So it's time to use
>>> SRCU to protect readers who previously held shrinker_rwsem.
>>>
>>> [1]. 
>>> https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
>>> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
>>> [3]. 
>>> https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>>> [4]. 
>>> https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
>>> [5]. 
>>> https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>   mm/vmscan.c | 27 +++++++++++----------------
>>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 9f895ca6216c..02987a6f95d1 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct 
>>> task_struct *task,
>>>   LIST_HEAD(shrinker_list);
>>>   DECLARE_RWSEM(shrinker_rwsem);
>>> +DEFINE_SRCU(shrinker_srcu);
>>>   #ifdef CONFIG_MEMCG
>>>   static int shrinker_nr_max;
>>> @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker 
>>> *shrinker)
>>>   void register_shrinker_prepared(struct shrinker *shrinker)
>>>   {
>>>       down_write(&shrinker_rwsem);
>>> -    list_add_tail(&shrinker->list, &shrinker_list);
>>> +    list_add_tail_rcu(&shrinker->list, &shrinker_list);
>>>       shrinker->flags |= SHRINKER_REGISTERED;
>>>       shrinker_debugfs_add(shrinker);
>>>       up_write(&shrinker_rwsem);
>>> @@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker 
>>> *shrinker)
>>>           return;
>>>       down_write(&shrinker_rwsem);
>>> -    list_del(&shrinker->list);
>>> +    list_del_rcu(&shrinker->list);
>>>       shrinker->flags &= ~SHRINKER_REGISTERED;
>>>       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>           unregister_memcg_shrinker(shrinker);
>>>       debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>       up_write(&shrinker_rwsem);
>>> +    synchronize_srcu(&shrinker_srcu);
>>> +
>>>       debugfs_remove_recursive(debugfs_entry);
>>>       kfree(shrinker->nr_deferred);
>>> @@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
>>>   {
>>>       down_write(&shrinker_rwsem);
>>>       up_write(&shrinker_rwsem);
>>> +    synchronize_srcu(&shrinker_srcu);
>>>   }
>>>   EXPORT_SYMBOL(synchronize_shrinkers);
>>> @@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, 
>>> int nid,
>>>   {
>>>       unsigned long ret, freed = 0;
>>>       struct shrinker *shrinker;
>>> +    int srcu_idx;
>>>       /*
>>>        * The root memcg might be allocated even though memcg is disabled
>>> @@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t 
>>> gfp_mask, int nid,
>>>       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>           return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>> -    if (!down_read_trylock(&shrinker_rwsem))
>>> -        goto out;
>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>> -    list_for_each_entry(shrinker, &shrinker_list, list) {
>>> +    list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>> +                 srcu_read_lock_held(&shrinker_srcu)) {
>>>           struct shrink_control sc = {
>>>               .gfp_mask = gfp_mask,
>>>               .nid = nid,
>>> @@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t 
>>> gfp_mask, int nid,
>>>           if (ret == SHRINK_EMPTY)
>>>               ret = 0;
>>>           freed += ret;
>>> -        /*
>>> -         * Bail out if someone want to register a new shrinker to
>>> -         * prevent the registration from being stalled for long periods
>>> -         * by parallel ongoing shrinking.
>>> -         */
>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>> -            freed = freed ? : 1;
>>> -            break;
>>> -        }
>>>       }
>>> -    up_read(&shrinker_rwsem);
>>> -out:
>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>       cond_resched();
>>>       return freed;
>>>   }
>>> -- 
>>> 2.20.1
>>>
>>>
>>
>> Hi Qi,
>>
>> A different problem I realized after my old attempt to use SRCU was 
>> that the
>> unregister_shrinker() path became quite slow due to the heavy 
>> synchronize_srcu()
>> call. Both register_shrinker() *and* unregister_shrinker() are called 
>> frequently
>> these days, and SRCU is too unfair to the unregister path IMO.
> 
> Hi Sultan,
> 
> IIUC, for unregister_shrinker(), the wait time is hardly longer with
> SRCU than with shrinker_rwsem before.
> 
> And I just did a simple test. After using the script in cover letter to
> increase the shrink_slab hotspot, I did umount 1k times at the same
> time, and then I used bpftrace to measure the time consumption of
> unregister_shrinker() as follows:
> 
> bpftrace -e 'kprobe:unregister_shrinker { @start[tid] = nsecs; } 
> kretprobe:unregister_shrinker /@start[tid]/ { @ns[comm] = hist(nsecs - 
> @start[tid]); delete(@start[tid]); }'
> 
> @ns[umount]:
> [16K, 32K)             3 |      |
> [32K, 64K)            66 |@@@@@@@@@@      |
> [64K, 128K)           32 |@@@@@      |
> [128K, 256K)          22 |@@@      |
> [256K, 512K)          48 |@@@@@@@      |
> [512K, 1M)            19 |@@@      |
> [1M, 2M)             131 |@@@@@@@@@@@@@@@@@@@@@      |
> [2M, 4M)             313 
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4M, 8M)             302 
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  |
> [8M, 16M)             55 |@@@@@@@@@
> 
> I see that the highest time-consuming of unregister_shrinker() is 
> between 8ms and 16ms, which feels tolerable?

And when I use the synchronize_srcu_expedited() mentioned by Paul,
the measured time consumption has a more obvious decrease:

@ns[umount]:
[16K, 32K)           105 |@@@@@@@@@@ 
      |
[32K, 64K)           521 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[64K, 128K)          119 |@@@@@@@@@@@ 
      |
[128K, 256K)          32 |@@@ 
      |
[256K, 512K)          70 |@@@@@@ 
      |
[512K, 1M)            49 |@@@@ 
      |
[1M, 2M)              34 |@@@ 
      |
[2M, 4M)              18 |@ 
      |
[4M, 8M)               4 |

> 
> Thanks,
> Qi
> 
>>
>> Although I never got around to submitting it, I made a non-SRCU 
>> solution [1]
>> that uses fine-grained locking instead, which is fair to both the 
>> register path
>> and unregister path. (The patch I've linked is a version of this 
>> adapted to an
>> older 4.14 kernel FYI, but it can be reworked for the current kernel.)
>>
>> What do you think about the fine-grained locking approach?
>>
>> Thanks,
>> Sultan
>>
>> [1] 
>> https://github.com/kerneltoast/android_kernel_google_floral/commit/012378f3173a82d2333d3ae7326691544301e76a
>>
> 

-- 
Thanks,
Qi
