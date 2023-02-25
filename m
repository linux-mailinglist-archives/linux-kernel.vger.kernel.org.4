Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD86A2ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBYQhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBYQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:37:44 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19415196BB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:37:43 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id d6so1304701pgu.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677343062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzpzj1OFLrPZbdT7QYCED3LLStTs3Nt8QXR1qBvuP0A=;
        b=hApu+kth/nF+LS9HhImzRgTUIGuex6hLvU+OpogAlAKNgPOSou40kFnBUGI52fyalk
         70AyqOWUz4FJ1YlAn9Upl6LVbss7MVU4VgKC9hicccadfRyebPZ1Xmb1Tt46NZVcO9eP
         pFj2+Rtp2tqStNLq5IHMfI24jBYU9lbgO4swx0p1Kz8TsbC5pv74Uzeiyq16d4BOVHKI
         Jh+G266UFCwgLpyKpe7dei+x9RsiHXoWtbcnyhLi4WIsqa7qmQRsKfBwzzh/l20RKyRU
         60vHu2tMIHRvTSpz4V31cqb9m+cpKMww1Y08Z049wmLmKkEI6B2eOZJinPmrkpffBaea
         yRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677343062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzpzj1OFLrPZbdT7QYCED3LLStTs3Nt8QXR1qBvuP0A=;
        b=EJH+/bRIRAsE9OtJ0M+0zJQZrGkZb7sIpO8jypmZShj/1Sumpv2uBWU/5w07oEur2G
         9X2QE0JCv3kTBj9xLdNyCoD3temeU6Qt3SiWPfN5nxUJA1L2N71VlUvigVxJWR96EZfp
         NZVSNjl1Ak7WV3lbGYuJRm5mIJ4fnPGoqsCKQmhXkJ20Ni1LxfwjqRpAfHajyc2J4TdK
         EGcuAOoQyB7bukh69QhaRLPH3dX1zLM56VzKLknlfPxsVrXp/cxazf81iiRr8oM/ymRT
         D/gb3Vnr9s+hBpM3aTHbIYNBL26FHH0CEjbQjKs6XjD0YZYDoyLV6xW7wG7sYmZh5tXA
         Zl5Q==
X-Gm-Message-State: AO0yUKV4P6wr3tnM8/Z16LHD75Wwld0YB4epPTBbizvAIXojVXRH14Sz
        5RaCPYwC0gqNbePVJ/PnaThYqA==
X-Google-Smtp-Source: AK7set8ZbLsQ4gqQIq6h16wFivIWULElxqeJ146f1MlKsy29ocmp528ePQLJEl+Zn1G1BYsZJ18nlQ==
X-Received: by 2002:a62:e713:0:b0:5a9:cebd:7b79 with SMTP id s19-20020a62e713000000b005a9cebd7b79mr19382829pfh.0.1677343062465;
        Sat, 25 Feb 2023 08:37:42 -0800 (PST)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7918d000000b005afda1496c6sm1422592pfa.31.2023.02.25.08.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 08:37:42 -0800 (PST)
Message-ID: <2ba86f45-f0a5-3a85-4aa6-f8beb50491b3@bytedance.com>
Date:   Sun, 26 Feb 2023 00:37:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>, Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/evb+PBeaahx9Os@sultan-box.localdomain>
 <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
 <b9593d94-057d-43d3-97e2-07cf83896041@ya.ru>
 <ed9c844b-c431-df69-21ff-1b6dc6557b20@ya.ru>
 <f20c6ae7-0dfe-1d4a-9589-05e378961f08@bytedance.com>
 <1aa70926-af39-0ce1-ae23-d86deb74d1c6@ya.ru>
 <74c4cf95-9506-98b3-9fc0-0814f63d5d7f@bytedance.com>
 <5663b349-8f6f-874a-eb9b-63d3179dcab7@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <5663b349-8f6f-874a-eb9b-63d3179dcab7@ya.ru>
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



On 2023/2/26 00:17, Kirill Tkhai wrote:
> On 25.02.2023 18:57, Qi Zheng wrote:
>>
<...>
>> How about this?
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index ffddbd204259..9d8c53075298 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1012,7 +1012,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>                                    int priority)
>>>>    {
>>>>           unsigned long ret, freed = 0;
>>>> -       struct shrinker *shrinker;
>>>> +       struct shrinker *shrinker = NULL;
>>>>           int srcu_idx, generation;
>>>>
>>>>           /*
>>>> @@ -1025,11 +1025,15 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>           if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>>                   return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>>
>>>> +again:
>>>>           srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>
>>>>           generation = atomic_read(&shrinker_srcu_generation);
>>>> -       list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>> -                                srcu_read_lock_held(&shrinker_srcu)) {
>>>> +       if (!shrinker)
>>>> +               shrinker = list_entry_rcu(shrinker_list.next, struct shrinker, list);
>>>> +       else
>>>> +               shrinker = list_entry_rcu(shrinker->list.next, struct shrinker, list);
>>>> +       list_for_each_entry_from_rcu(shrinker, &shrinker_list, list) {
>>>>                   struct shrink_control sc = {
>>>>                           .gfp_mask = gfp_mask,
>>>>                           .nid = nid,
>>>> @@ -1042,8 +1046,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>                   freed += ret;
>>>>
>>>>                   if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>> -                       freed = freed ? : 1;
>>>> -                       break;
>>>> +                       srcu_read_unlock(&shrinker_srcu, srcu_idx);
> 
> After SRCU in unlocked we can't believe @shrinker anymore. So, above list_entry_rcu(shrinker->list.next)
> dereferences some random memory.

Indeed.

> 
>>>> +                       cond_resched();
>>>> +                       goto again;
>>>>                   }
>>>>           }
>>>>
>>>>>
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> index 27ef9946ae8a..0b197bba1257 100644
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -204,6 +204,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>>>     LIST_HEAD(shrinker_list);
>>>>>     DEFINE_MUTEX(shrinker_mutex);
>>>>>     DEFINE_SRCU(shrinker_srcu);
>>>>> +static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
>>>>>       #ifdef CONFIG_MEMCG
>>>>>     static int shrinker_nr_max;
>>>>> @@ -782,6 +783,7 @@ void unregister_shrinker(struct shrinker *shrinker)
>>>>>         debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>>>         mutex_unlock(&shrinker_mutex);
>>>>>     +    atomic_inc(&shrinker_srcu_generation);
>>>>>         synchronize_srcu(&shrinker_srcu);
>>>>>           debugfs_remove_recursive(debugfs_entry);
>>>>> @@ -799,6 +801,7 @@ EXPORT_SYMBOL(unregister_shrinker);
>>>>>      */
>>>>>     void synchronize_shrinkers(void)
>>>>>     {
>>>>> +    atomic_inc(&shrinker_srcu_generation);
>>>>>         synchronize_srcu(&shrinker_srcu);
>>>>>     }
>>>>>     EXPORT_SYMBOL(synchronize_shrinkers);
>>>>> @@ -908,18 +911,19 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>>     {
>>>>>         struct shrinker_info *info;
>>>>>         unsigned long ret, freed = 0;
>>>>> -    int srcu_idx;
>>>>> -    int i;
>>>>> +    int srcu_idx, generation;
>>>>> +    int i = 0;
>>>>>           if (!mem_cgroup_online(memcg))
>>>>>             return 0;
>>>>> -
>>>>> +again:
>>>>>         srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>>         info = shrinker_info_srcu(memcg, nid);
>>>>>         if (unlikely(!info))
>>>>>             goto unlock;
>>>>>     -    for_each_set_bit(i, info->map, info->map_nr_max) {
>>>>> +    generation = atomic_read(&shrinker_srcu_generation);
>>>>> +    for_each_set_bit_from(i, info->map, info->map_nr_max) {
>>>>>             struct shrink_control sc = {
>>>>>                 .gfp_mask = gfp_mask,
>>>>>                 .nid = nid,
>>>>> @@ -965,6 +969,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>>                     set_shrinker_bit(memcg, nid, i);
>>>>>             }
>>>>>             freed += ret;
>>>>> +
>>>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>>> +            srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>
>>>> Maybe we can add the following code here, so as to avoid repeating the
>>>> current id and avoid triggering softlockup:
>>>>
>>>>               i++;
> 
> This is OK.
> 
>>>>               cond_resched();
> 
> Possible, existing cond_resched() in do_shrink_slab() is enough.

Yeah.

I will add this patch in the next version. May I mark you as the author
of this patch?

Thanks,
Qi

> 
>> And this. :)
>>
>> Thanks,
>> Qi
>>
>>>>
>>>> Thanks,
>>>> Qi
>>>>
>>>>> +            goto again;
>>>>> +        }
>>>>>         }
>>>>>     unlock:
>>>>>         srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>> @@ -1004,7 +1013,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>     {
>>>>>         unsigned long ret, freed = 0;
>>>>>         struct shrinker *shrinker;
>>>>> -    int srcu_idx;
>>>>> +    int srcu_idx, generation;
>>>>>           /*
>>>>>          * The root memcg might be allocated even though memcg is disabled
>>>>> @@ -1017,6 +1026,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>             return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>>>           srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>> +    generation = atomic_read(&shrinker_srcu_generation);
>>>>>           list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>>>                      srcu_read_lock_held(&shrinker_srcu)) {
>>>>> @@ -1030,6 +1040,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>             if (ret == SHRINK_EMPTY)
>>>>>                 ret = 0;
>>>>>             freed += ret;
>>>>> +
>>>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>>> +            freed = freed ? : 1;
>>>>> +            break;
>>>>> +        }
>>>>>         }
>>>>>           srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>>
>>>>>
>>>>
>>>
>>
> 

-- 
Thanks,
Qi
