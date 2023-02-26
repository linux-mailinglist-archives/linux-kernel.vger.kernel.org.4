Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E326A2FDF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBZN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBZN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:56:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874B113F2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:56:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u5so736655plq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677419777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOnShjfH2x5AjxcIBSzXwGcoae/sENzxXQ+eVDUaBfg=;
        b=W5Zsg23cyyz/ukKm755XIXZnUcc3AmSiYrxx24Ym6vJFvKuXgfAbnAopR6fyL47oYc
         093xMO9YH0+7ZjHaiOcySVn7qk7ZosWvLzkeSzxIa01j0/LoLdQCJWDfMUCXdGIDGtV6
         VThi1RvnELfGe3UOTJ+IDExU8pGiLpPISiixP7j8SY4++IeozWuj128nz4jLX+vBa6mM
         EwjpvV+2xPTKfQsiKplrF22yGRlhP1sIrojKpdSFMH7RyjN/JK6hvWqk8kVcwrmTyVE1
         aiZykrOOMcFIkE3Q2jAh+OLlKQpurTvehZUPJQCdNQPQogVQD0oqVGCfOUt4tlCDWW54
         EfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677419777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOnShjfH2x5AjxcIBSzXwGcoae/sENzxXQ+eVDUaBfg=;
        b=HOuBN1s4dYuLSW8/v0pxF6TTECRPqyir7Ls6RYiI5FfxXLGHK8WAkqUAoS4QEuGfa2
         Phr4MijgGGMtsg4XIh5P3RlYVW3RIuk/YVfEfCqQGsDNpfKLI1vNuFfLHUN4QpJkg0qg
         Hdfm+Vdp9QMVt4G+sCTiResTBMgscU2TX1hC8L+kIxUMpYPbUytw+8/FwOQEPTmxAxJX
         QNkBlTUyfosY8B5QPBYzCaMZZZmWPqFEj+k8HYFN0Iahn3pkHlmwdfR16ARnjSfH4lFE
         hrt242YK+WDz4mLovLrMfFllqCZ/q31re5QoH6dT7hbY1ntLaxYYpZ54K+hcDaWVQzu4
         S7ew==
X-Gm-Message-State: AO0yUKWvaNrMTfkFx9hs7TRFsP12UHNOsmVr2Eq08DQg55wxejDaH7l2
        f/SCHzf4jyILOhHKw9B7X0DUew==
X-Google-Smtp-Source: AK7set9v2zw+Bq/rC0nWfgoDDyrDQ5VhJTPqyyegdcN1NfESp1bq0eGnaPhNL2a/n440TKmrCFUsjQ==
X-Received: by 2002:a17:902:e741:b0:19c:f005:92d5 with SMTP id p1-20020a170902e74100b0019cf00592d5mr4909438plf.5.1677419777195;
        Sun, 26 Feb 2023 05:56:17 -0800 (PST)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id iy21-20020a170903131500b00198fb25d09bsm2701220plb.237.2023.02.26.05.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 05:56:16 -0800 (PST)
Message-ID: <b8206ddf-45af-3825-1254-24040e6a877f@bytedance.com>
Date:   Sun, 26 Feb 2023 21:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
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
 <2ba86f45-f0a5-3a85-4aa6-f8beb50491b3@bytedance.com>
 <8dab3b27-7282-f8bc-7d04-ca63c9b872cf@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <8dab3b27-7282-f8bc-7d04-ca63c9b872cf@ya.ru>
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



On 2023/2/26 05:28, Kirill Tkhai wrote:
> On 25.02.2023 19:37, Qi Zheng wrote:
>>
>>
>> On 2023/2/26 00:17, Kirill Tkhai wrote:
>>> On 25.02.2023 18:57, Qi Zheng wrote:
>>>>
>> <...>
>>>> How about this?
>>>>>>
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index ffddbd204259..9d8c53075298 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -1012,7 +1012,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>                                     int priority)
>>>>>>     {
>>>>>>            unsigned long ret, freed = 0;
>>>>>> -       struct shrinker *shrinker;
>>>>>> +       struct shrinker *shrinker = NULL;
>>>>>>            int srcu_idx, generation;
>>>>>>
>>>>>>            /*
>>>>>> @@ -1025,11 +1025,15 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>            if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>>>>                    return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>>>>
>>>>>> +again:
>>>>>>            srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>>>
>>>>>>            generation = atomic_read(&shrinker_srcu_generation);
>>>>>> -       list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>>>> -                                srcu_read_lock_held(&shrinker_srcu)) {
>>>>>> +       if (!shrinker)
>>>>>> +               shrinker = list_entry_rcu(shrinker_list.next, struct shrinker, list);
>>>>>> +       else
>>>>>> +               shrinker = list_entry_rcu(shrinker->list.next, struct shrinker, list);
>>>>>> +       list_for_each_entry_from_rcu(shrinker, &shrinker_list, list) {
>>>>>>                    struct shrink_control sc = {
>>>>>>                            .gfp_mask = gfp_mask,
>>>>>>                            .nid = nid,
>>>>>> @@ -1042,8 +1046,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>                    freed += ret;
>>>>>>
>>>>>>                    if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>>>> -                       freed = freed ? : 1;
>>>>>> -                       break;
>>>>>> +                       srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>
>>> After SRCU in unlocked we can't believe @shrinker anymore. So, above list_entry_rcu(shrinker->list.next)
>>> dereferences some random memory.
>>
>> Indeed.
>>
>>>
>>>>>> +                       cond_resched();
>>>>>> +                       goto again;
>>>>>>                    }
>>>>>>            }
>>>>>>
>>>>>>>
>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>> index 27ef9946ae8a..0b197bba1257 100644
>>>>>>> --- a/mm/vmscan.c
>>>>>>> +++ b/mm/vmscan.c
>>>>>>> @@ -204,6 +204,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>>>>>      LIST_HEAD(shrinker_list);
>>>>>>>      DEFINE_MUTEX(shrinker_mutex);
>>>>>>>      DEFINE_SRCU(shrinker_srcu);
>>>>>>> +static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
>>>>>>>        #ifdef CONFIG_MEMCG
>>>>>>>      static int shrinker_nr_max;
>>>>>>> @@ -782,6 +783,7 @@ void unregister_shrinker(struct shrinker *shrinker)
>>>>>>>          debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>>>>>          mutex_unlock(&shrinker_mutex);
>>>>>>>      +    atomic_inc(&shrinker_srcu_generation);
>>>>>>>          synchronize_srcu(&shrinker_srcu);
>>>>>>>            debugfs_remove_recursive(debugfs_entry);
>>>>>>> @@ -799,6 +801,7 @@ EXPORT_SYMBOL(unregister_shrinker);
>>>>>>>       */
>>>>>>>      void synchronize_shrinkers(void)
>>>>>>>      {
>>>>>>> +    atomic_inc(&shrinker_srcu_generation);
>>>>>>>          synchronize_srcu(&shrinker_srcu);
>>>>>>>      }
>>>>>>>      EXPORT_SYMBOL(synchronize_shrinkers);
>>>>>>> @@ -908,18 +911,19 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>>>>      {
>>>>>>>          struct shrinker_info *info;
>>>>>>>          unsigned long ret, freed = 0;
>>>>>>> -    int srcu_idx;
>>>>>>> -    int i;
>>>>>>> +    int srcu_idx, generation;
>>>>>>> +    int i = 0;
>>>>>>>            if (!mem_cgroup_online(memcg))
>>>>>>>              return 0;
>>>>>>> -
>>>>>>> +again:
>>>>>>>          srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>>>>          info = shrinker_info_srcu(memcg, nid);
>>>>>>>          if (unlikely(!info))
>>>>>>>              goto unlock;
>>>>>>>      -    for_each_set_bit(i, info->map, info->map_nr_max) {
>>>>>>> +    generation = atomic_read(&shrinker_srcu_generation);
>>>>>>> +    for_each_set_bit_from(i, info->map, info->map_nr_max) {
>>>>>>>              struct shrink_control sc = {
>>>>>>>                  .gfp_mask = gfp_mask,
>>>>>>>                  .nid = nid,
>>>>>>> @@ -965,6 +969,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>>>>                      set_shrinker_bit(memcg, nid, i);
>>>>>>>              }
>>>>>>>              freed += ret;
>>>>>>> +
>>>>>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>>>>> +            srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>>>
>>>>>> Maybe we can add the following code here, so as to avoid repeating the
>>>>>> current id and avoid triggering softlockup:
>>>>>>
>>>>>>                i++;
>>>
>>> This is OK.
>>>
>>>>>>                cond_resched();
>>>
>>> Possible, existing cond_resched() in do_shrink_slab() is enough.
>>
>> Yeah.
>>
>> I will add this patch in the next version. May I mark you as the author
>> of this patch?
> 
> I think, yes

Thanks. :)

Qi

> 
>>>
>>>> And this. :)
>>>>
>>>> Thanks,
>>>> Qi
>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Qi
>>>>>>
>>>>>>> +            goto again;
>>>>>>> +        }
>>>>>>>          }
>>>>>>>      unlock:
>>>>>>>          srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>>>> @@ -1004,7 +1013,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>>      {
>>>>>>>          unsigned long ret, freed = 0;
>>>>>>>          struct shrinker *shrinker;
>>>>>>> -    int srcu_idx;
>>>>>>> +    int srcu_idx, generation;
>>>>>>>            /*
>>>>>>>           * The root memcg might be allocated even though memcg is disabled
>>>>>>> @@ -1017,6 +1026,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>>              return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>>>>>            srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>>>> +    generation = atomic_read(&shrinker_srcu_generation);
>>>>>>>            list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>>>>>                       srcu_read_lock_held(&shrinker_srcu)) {
>>>>>>> @@ -1030,6 +1040,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>>              if (ret == SHRINK_EMPTY)
>>>>>>>                  ret = 0;
>>>>>>>              freed += ret;
>>>>>>> +
>>>>>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>>>>> +            freed = freed ? : 1;
>>>>>>> +            break;
>>>>>>> +        }
>>>>>>>          }
>>>>>>>            srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

-- 
Thanks,
Qi
