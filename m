Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387796A0211
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjBWEh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjBWEhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:37:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3929298CA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:37:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c1so11672040plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1677127047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgEUJI1FbPYHDyZTL+1aW43M1EL7Z5ld07eE1dMmj9I=;
        b=jzTvOXJ6rPYIaMB7arzhn/vdCZ3Nirr0e9iwyS8dc50XLFgECg0anfkCbeFhYAWm5Q
         SzSA55KxTB7pSx5sHwJMsU2XkmwPM6W0nu9igVyVH+D8UxroXEhD4gupD+bp7cIO3daA
         ZfL2wAnEq2MEb0ww4KVv08NUR+KH0SDiCcs5epaTkv/0SeyYZhtHOKb5jPH6GzD9+CXf
         aBWMOKq9ruA/poVC0KNQrNCb/R0hzk/xC7tN5LkY/g0GhHvkDWV6PeSGvh/EoQhlZMep
         KJiw2u+1/SBr4urHhFgEPccJBy4hkcJSrYaOoYJIjdQ693nPcCH60yMof6iRaZzvJHIv
         jjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677127047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgEUJI1FbPYHDyZTL+1aW43M1EL7Z5ld07eE1dMmj9I=;
        b=Gh11HsaWyciJoWEAQMXDgc1PYtesxzWytHQ2waKYUm6WhoffP4bkQK5zopFm/jCz09
         o8/kKwWEFtvu599nRYddOfqZ3f8vL96+FpLTxumnnHcU3iu4KbQr+EFZ3cKIKdrAeAnw
         vdwJtVlD1w1KAhzl+91U9nKg6zvfkhI3b+yJmYbtgBk8UZS7++MnQOwUxB0ZYl3uWjV5
         pkVtQCtjxaoMWP9ul0IsrErutj5JJgnGksgTDoP8IrXGEGwabMZUKgz+pBtjZAjeIef5
         eRq9qYEKwex8GVdkJ6JZtt+mvgriVIYh9HrNE4ajZdt11XM73ifNIl/peg9aJ9j8FgsL
         He9w==
X-Gm-Message-State: AO0yUKWP5rKbJ/FqOJ8ks02nGQJXii8qECqe5mOLVfnnW0brflhFGWgY
        dyNKsFFeh4W2ua49R4HA8C26Ow==
X-Google-Smtp-Source: AK7set+ENtMToE9BflcUsG3cSpXaHfuxXF93DgKsQa7jBdodIEfy25+u20zZPnr4l1O1SdzOgIBdcw==
X-Received: by 2002:a17:902:d48d:b0:19a:a815:2853 with SMTP id c13-20020a170902d48d00b0019aa8152853mr11741156plg.1.1677127047388;
        Wed, 22 Feb 2023 20:37:27 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b0019c2d664869sm859813plz.298.2023.02.22.20.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 20:37:27 -0800 (PST)
Message-ID: <ee7852cc-e37e-5602-7729-5bb1500a1f2a@bytedance.com>
Date:   Thu, 23 Feb 2023 12:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] mm: vmscan: make memcg slab shrink lockless
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
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
 <20230220091637.64865-3-zhengqi.arch@bytedance.com>
 <dc279728-4cd4-0453-1a28-fe076f254641@ya.ru>
 <39cf7fa7-5dd6-0424-23de-1c33e948a201@bytedance.com>
 <b9d344d0-9d27-034d-d59e-9e880318906b@bytedance.com>
 <23fde2e7-e9e2-2b0d-dfd8-1a654bc5503c@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <23fde2e7-e9e2-2b0d-dfd8-1a654bc5503c@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/23 04:05, Kirill Tkhai wrote:
> On 22.02.2023 11:21, Qi Zheng wrote:
>>
>>
>> On 2023/2/22 16:16, Qi Zheng wrote:
>>> Hi Kirill,
>>>
>>> On 2023/2/22 05:43, Kirill Tkhai wrote:
>>>> On 20.02.2023 12:16, Qi Zheng wrote:
>>>>> Like global slab shrink, since commit 1cd0bd06093c<...>
>>>>>    static bool cgroup_reclaim(struct scan_control *sc)
>>>>> @@ -891,15 +905,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>>    {
>>>>>        struct shrinker_info *info;
>>>>>        unsigned long ret, freed = 0;
>>>>> +    int srcu_idx;
>>>>>        int i;
>>>>>        if (!mem_cgroup_online(memcg))
>>>>>            return 0;
>>>>> -    if (!down_read_trylock(&shrinker_rwsem))
>>>>> -        return 0;
>>>>> -
>>>>> -    info = shrinker_info_protected(memcg, nid);
>>>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>> +    info = shrinker_info_srcu(memcg, nid);
>>>>>        if (unlikely(!info))
>>>>>            goto unlock;
>>>>
>>>> There is shrinker_nr_max dereference under this hunk. It's not in the patch:
>>>>
>>>>           for_each_set_bit(i, info->map, shrinker_nr_max) {
>>>>
>>>> Since shrinker_nr_max may grow in parallel, this leads to access beyond allocated memory :(
>>>
>>> Oh, indeed.
>>>
>>>>
>>>> It looks like we should save size of info->map as a new member of struct shrinker_info.
>>>
>>> Agree, then we only traverse info->map_size each time. Like below:
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index b6eda2ab205d..f1b5d2803007 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -97,6 +97,7 @@ struct shrinker_info {
>>>           struct rcu_head rcu;
>>>           atomic_long_t *nr_deferred;
>>>           unsigned long *map;
>>> +       int map_size;
> 
> Sure, like this. The only thing (after rethinking) I want to say is that despite "size" was
> may suggestion, now it makes me think that name "size" is about size in bytes.
> 
> Possible, something like map_nr_max would be better here.

Agree. Will change to it.

> 
>>>    };
>>>
>>>    struct lruvec_stats_percpu {
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index f94bfe540675..dd07eb107915 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -239,14 +239,20 @@ static void free_shrinker_info_rcu(struct rcu_head *head)
>>>           kvfree(container_of(head, struct shrinker_info, rcu));
>>>    }
>>>
>>> -static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>> -                                   int map_size, int defer_size,
>>> -                                   int old_map_size, int old_defer_size)
>>> +static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_nr_max,
>>> +                                   int old_nr_max)
>>>    {
>>> +       int map_size, defer_size, old_map_size, old_defer_size;
>>>           struct shrinker_info *new, *old;
>>>           struct mem_cgroup_per_node *pn;
>>>           int nid;
>>> -       int size = map_size + defer_size;
>>> +       int size;
>>> +
>>> +       map_size = shrinker_map_size(new_nr_max);
>>> +       defer_size = shrinker_defer_size(new_nr_max);
>>> +       old_map_size = shrinker_map_size(shrinker_nr_max);
>>> +       old_defer_size = shrinker_defer_size(shrinker_nr_max);
>>
>> Perhaps these should still be calculated outside the loop as before.
> 
> Yeah, for me it's also better.
>   
>>> +       size = map_size + defer_size;
>>>
>>>           for_each_node(nid) {
>>>                   pn = memcg->nodeinfo[nid];
>>> @@ -261,6 +267,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>>
>>>                   new->nr_deferred = (atomic_long_t *)(new + 1);
>>>                   new->map = (void *)new->nr_deferred + defer_size;
>>> +               new->map_size = new_nr_max;
>>>
>>>                   /* map: set all old bits, clear all new bits */
>>>                   memset(new->map, (int)0xff, old_map_size);
>>> @@ -310,6 +317,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>                   }
>>>                   info->nr_deferred = (atomic_long_t *)(info + 1);
>>>                   info->map = (void *)info->nr_deferred + defer_size;
>>> +               info->map_size = shrinker_nr_max;
>>>                   rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>           }
>>>           mutex_unlock(&shrinker_mutex);
>>> @@ -327,8 +335,6 @@ static int expand_shrinker_info(int new_id)
>>>    {
>>>           int ret = 0;
>>>           int new_nr_max = new_id + 1;
>>> -       int map_size, defer_size = 0;
>>> -       int old_map_size, old_defer_size = 0;
>>>           struct mem_cgroup *memcg;
>>>
>>>           if (!need_expand(new_nr_max))
>>> @@ -339,15 +345,9 @@ static int expand_shrinker_info(int new_id)
>>>
>>>           lockdep_assert_held(&shrinker_mutex);
>>>
>>> -       map_size = shrinker_map_size(new_nr_max);
>>> -       defer_size = shrinker_defer_size(new_nr_max);
>>> -       old_map_size = shrinker_map_size(shrinker_nr_max);
>>> -       old_defer_size = shrinker_defer_size(shrinker_nr_max);
>>> -
>>>           memcg = mem_cgroup_iter(NULL, NULL, NULL);
>>>           do {
>>> -               ret = expand_one_shrinker_info(memcg, map_size, defer_size,
>>> -                                              old_map_size, old_defer_size);
>>> +               ret = expand_one_shrinker_info(memcg, new_nr_max, shrinker_nr_max);
>>>                   if (ret) {
>>>                           mem_cgroup_iter_break(NULL, memcg);
>>>                           goto out;
>>> @@ -912,7 +912,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>           if (unlikely(!info))
>>>                   goto unlock;
>>>
>>> -       for_each_set_bit(i, info->map, shrinker_nr_max) {
>>> +       for_each_set_bit(i, info->map, info->map_size) {
>>>                   struct shrink_control sc = {
>>>                           .gfp_mask = gfp_mask,
>>>                           .nid = nid,
>>>
>>> I will send the v2.
>>>
>>> Thanks,
>>> Qi
>>>
>>>>
>>>>> @@ -949,14 +962,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>>                    set_shrinker_bit(memcg, nid, i);
>>>>>            }
>>>>>            freed += ret;
>>>>> -
>>>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>>>> -            freed = freed ? : 1;
>>>>> -            break;
>>>>> -        }
>>>>>        }
>>>>>    unlock:
>>>>> -    up_read(&shrinker_rwsem);
>>>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>>        return freed;
>>>>>    }
>>>>>    #else /* CONFIG_MEMCG */
>>>>
>>>
>>
> 

-- 
Thanks,
Qi
