Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAE6A2FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBZNzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZNzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:55:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D566C656
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:55:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso2628941pjs.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMQH7QpmFXfL2DMGoCc67olwH4ap4UyfN/nCTBorIpE=;
        b=aCCeIkDGGc6j7gUD9lbHWkszQSZj6VcRvdOaGZ3M0/yYGcdbvTrMxOH898PuI+Tghx
         kcrPN6G+ioJWPOLjSas9BLbLSB/q6MCV1EF+yF6xHzkS6CUrfBQnxZ32FUYPVkS0v3Wj
         TS1QSwOmuA67iDtJ7x7hg/rnDJvTN5Etlhd3JSUseF0PCjCwqhIomL7bi/vIJXofCCTq
         ANB7pWcNUmlvkwM76Gqg8ICVGzcg0Gh6QCRPRRJBta40v/YAxCixlmEKgVyNiasCVcFG
         EqsJY3zB+y4q4Fw5lZKPgl5yaKCRf6w6j4T9cHfewURW+1bc/ee+dfiE/wS7vBwghkK6
         mhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMQH7QpmFXfL2DMGoCc67olwH4ap4UyfN/nCTBorIpE=;
        b=IkTjK5kcK3S/+5i6q9NlGAWhfGgdWMUx5+y2ZMhldwKx2oqYMtlQLchxfKhbV/RxcU
         4/8nzLUotm5B4IzVpqJmaq08uY7+vTVSJZjMTvcFhvBnL3BDk73ot42NUqMbIXlZiExz
         bcz2CKalGOCA7XmcviLoronkvKI4vwfk8ELEKgu5VL9Ug/fJvvZZPeOFZIAmMU/RiM3r
         Hm5t5rL6iJTWFG3f1tU6Ogc36s2AIqH+uMgpLF4SLzafOAnKma3GcTLE3CoX7ikAfS5v
         xNoFzH8CQ27aUMi3vTl7BXA2Kvr4NSdrLnVJ3uYKncwge7Of09RQmIiRTUaelNZkZn+s
         GSDw==
X-Gm-Message-State: AO0yUKVRaFeDTtRR1nOIckV/Rvh3KZycbODDRmZuP7wWMVgMtBqxOV6T
        0qTK7LPIBDS96ZEI5+NDjKslhw==
X-Google-Smtp-Source: AK7set8VCBbSD4v0pINhwOWgFLfFvk3+V4C+tuP8X0BiSVd97oQSbaL9TxA5lu6qliVrhvmz/4caaQ==
X-Received: by 2002:a17:902:a3cd:b0:19a:f556:e386 with SMTP id q13-20020a170902a3cd00b0019af556e386mr21061123plb.0.1677419700694;
        Sun, 26 Feb 2023 05:55:00 -0800 (PST)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b0019a82ff8c38sm2706769plb.29.2023.02.26.05.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 05:55:00 -0800 (PST)
Message-ID: <d018f3b3-2f81-0a17-8e4d-fa5aad59e196@bytedance.com>
Date:   Sun, 26 Feb 2023 21:54:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/7] mm: vmscan: add a map_nr_max field to
 shrinker_info
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-2-zhengqi.arch@bytedance.com>
 <6f8f01b5-d802-db64-7725-8481c67c13a2@bytedance.com>
 <ea1c5d49-1efa-cce8-8750-e19c56187a7c@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ea1c5d49-1efa-cce8-8750-e19c56187a7c@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/25 23:14, Kirill Tkhai wrote:
> Hi Qi,
> 
> On 25.02.2023 11:18, Qi Zheng wrote:
>>
>>
>> On 2023/2/23 21:27, Qi Zheng wrote:
>>> To prepare for the subsequent lockless memcg slab shrink,
>>> add a map_nr_max field to struct shrinker_info to records
>>> its own real shrinker_nr_max.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> I missed Suggested-by here, hi Kirill, can I add it?
>>
>> Suggested-by: Kirill Tkhai <tkhai@ya.ru>
> 
> Yes, feel free to add this tag.
> 
> There is a comment below.
> 
>>> ---
>>>    include/linux/memcontrol.h |  1 +
>>>    mm/vmscan.c                | 29 ++++++++++++++++++-----------
>>>    2 files changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index b6eda2ab205d..aa69ea98e2d8 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -97,6 +97,7 @@ struct shrinker_info {
>>>        struct rcu_head rcu;
>>>        atomic_long_t *nr_deferred;
>>>        unsigned long *map;
>>> +    int map_nr_max;
>>>    };
>>>      struct lruvec_stats_percpu {
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 9c1c5e8b24b8..9f895ca6216c 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -224,9 +224,16 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>>>                         lockdep_is_held(&shrinker_rwsem));
>>>    }
>>>    +static inline bool need_expand(int new_nr_max, int old_nr_max)
>>> +{
>>> +    return round_up(new_nr_max, BITS_PER_LONG) >
>>> +           round_up(old_nr_max, BITS_PER_LONG);
>>> +}
>>> +
>>>    static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>>                        int map_size, int defer_size,
>>> -                    int old_map_size, int old_defer_size)
>>> +                    int old_map_size, int old_defer_size,
>>> +                    int new_nr_max)
>>>    {
>>>        struct shrinker_info *new, *old;
>>>        struct mem_cgroup_per_node *pn;
>>> @@ -240,12 +247,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>>            if (!old)
>>>                return 0;
>>>    +        if (!need_expand(new_nr_max, old->map_nr_max))
>>> +            return 0;
>>> +
>>>            new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>>>            if (!new)
>>>                return -ENOMEM;
>>>              new->nr_deferred = (atomic_long_t *)(new + 1);
>>>            new->map = (void *)new->nr_deferred + defer_size;
>>> +        new->map_nr_max = new_nr_max;
>>>              /* map: set all old bits, clear all new bits */
>>>            memset(new->map, (int)0xff, old_map_size);
>>> @@ -295,6 +306,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>            }
>>>            info->nr_deferred = (atomic_long_t *)(info + 1);
>>>            info->map = (void *)info->nr_deferred + defer_size;
>>> +        info->map_nr_max = shrinker_nr_max;
>>>            rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>        }
>>>        up_write(&shrinker_rwsem);
>>> @@ -302,12 +314,6 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>        return ret;
>>>    }
>>>    -static inline bool need_expand(int nr_max)
>>> -{
>>> -    return round_up(nr_max, BITS_PER_LONG) >
>>> -           round_up(shrinker_nr_max, BITS_PER_LONG);
>>> -}
>>> -
>>>    static int expand_shrinker_info(int new_id)
>>>    {
>>>        int ret = 0;
>>> @@ -316,7 +322,7 @@ static int expand_shrinker_info(int new_id)
>>>        int old_map_size, old_defer_size = 0;
>>>        struct mem_cgroup *memcg;
>>>    -    if (!need_expand(new_nr_max))
>>> +    if (!need_expand(new_nr_max, shrinker_nr_max))
>>>            goto out;
>>>          if (!root_mem_cgroup)
>>> @@ -332,7 +338,8 @@ static int expand_shrinker_info(int new_id)
>>>        memcg = mem_cgroup_iter(NULL, NULL, NULL);
>>>        do {
>>>            ret = expand_one_shrinker_info(memcg, map_size, defer_size,
>>> -                           old_map_size, old_defer_size);
>>> +                           old_map_size, old_defer_size,
>>> +                           new_nr_max);
>>>            if (ret) {
>>>                mem_cgroup_iter_break(NULL, memcg);
>>>                goto out;
>>> @@ -432,7 +439,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>>        for_each_node(nid) {
>>>            child_info = shrinker_info_protected(memcg, nid);
>>>            parent_info = shrinker_info_protected(parent, nid);
>>> -        for (i = 0; i < shrinker_nr_max; i++) {
>>> +        for (i = 0; i < child_info->map_nr_max; i++) {
>>>                nr = atomic_long_read(&child_info->nr_deferred[i]);
>>>                atomic_long_add(nr, &parent_info->nr_deferred[i]);
>>>            }
>>> @@ -899,7 +906,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>        if (unlikely(!info))
>>>            goto unlock;
>>>    -    for_each_set_bit(i, info->map, shrinker_nr_max) {
>>> +    for_each_set_bit(i, info->map, info->map_nr_max) {
>>>            struct shrink_control sc = {
>>>                .gfp_mask = gfp_mask,
>>>                .nid = nid,
> 
> The patch as whole thing won't work as expected. It won't ever call shrinker with ids from [round_down(shrinker_nr_max, sizeof(unsigned long)) + 1, shrinker_nr_max - 1]
> 
> Just replay the sequence we add new shrinkers:
> 
> 1)We add shrinker #0:
>     shrinker_nr_max = 0;
> 
>     prealloc_memcg_shrinker()
>        id = 0;
>        expand_shrinker_info(0)
>          new_nr_max = 1;
>          expand_one_shrinker_info(new_nr_max = 1)
>            new->map_nr_max = 1;
>          shrinker_nr_max = 1;
> 
> 2)We add shrinker #1:
>     prealloc_memcg_shrinker()
>       id = 1;
>       expand_shrinker_info(1)
>         new_nr_max = 2;
>         need_expand(2, 1) => false => ignore expand
>         shrinker_nr_max = 2;
> 
> 3)Then we call shrinker:
>    shrink_slab_memcg()
>      for_each_set_bit(i, info->map, 1/* info->map_nr_max */ ) {
>      } => ignore shrinker #1
> 
> I'd fixed this patch by something like the below:
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9f895ca6216c..bb617a3871f1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -224,12 +224,6 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>   					 lockdep_is_held(&shrinker_rwsem));
>   }
>   
> -static inline bool need_expand(int new_nr_max, int old_nr_max)
> -{
> -	return round_up(new_nr_max, BITS_PER_LONG) >
> -	       round_up(old_nr_max, BITS_PER_LONG);
> -}
> -
>   static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   				    int map_size, int defer_size,
>   				    int old_map_size, int old_defer_size,
> @@ -247,9 +241,6 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   		if (!old)
>   			return 0;
>   
> -		if (!need_expand(new_nr_max, old->map_nr_max))
> -			return 0;
> -

Maybe we can keep this. For example, when we failed to allocate memory 
by calling kvmalloc_node() last time, some shrinker_info may have been
expanded, and these shrinker_info do not need to be expanded again.

>   		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>   		if (!new)
>   			return -ENOMEM;
> @@ -317,14 +308,11 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   static int expand_shrinker_info(int new_id)
>   {
>   	int ret = 0;
> -	int new_nr_max = new_id + 1;
> +	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
>   	int map_size, defer_size = 0;
>   	int old_map_size, old_defer_size = 0;
>   	struct mem_cgroup *memcg;
>   
> -	if (!need_expand(new_nr_max, shrinker_nr_max))
> -		goto out;
> -
>   	if (!root_mem_cgroup)
>   		goto out;
>   
> @@ -359,9 +347,11 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>   
>   		rcu_read_lock();
>   		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> -		/* Pairs with smp mb in shrink_slab() */
> -		smp_mb__before_atomic();
> -		set_bit(shrinker_id, info->map);
> +		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
> +			/* Pairs with smp mb in shrink_slab() */
> +			smp_mb__before_atomic();
> +			set_bit(shrinker_id, info->map);
> +		}
>   		rcu_read_unlock();
>   	}
>   }
> 
> (I also added a new check into set_shrinker_bit() for safety).
> 
> Kirill

-- 
Thanks,
Qi
