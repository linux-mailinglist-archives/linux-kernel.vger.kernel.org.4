Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5812069F014
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBVIWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBVIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:21:58 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFFBE3BB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:21:51 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id f11so4068657pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFfJ4LwDeZzBsSCNAabPQ6w/Mk6+0Bt83HvR3c6bzMs=;
        b=U5bNfD9iU3TXZHCm6TeReqUB/bgmC68kUWsb5zp/SZaD1sZAc5wD/WszOedfAKDJPZ
         evpMx9rfuunTSeTeto9IDFJZwpawbUwV4B9FEzZKDalqIv0KdJ2r0plwqSh6d2+ysSFB
         3WHvodBQksjjyP66ZEln+FkA5gz6LR+nhkRMdlbz2n/JuM6YinR6MBKGo9kUvL0lqNk2
         Vse6s9a87TqbCTS/2O5lLN0x0MdRgKWMp6+sSye923x9NCiTqigW9XOXrnV74Uuvuebu
         yKX4nJWz1USYLNQ0Vwuhe8WZ9NTYDQzWb2k+MU6YmSkMr2pe1Ze2PZ4mYAUCCRaPSI8L
         zVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFfJ4LwDeZzBsSCNAabPQ6w/Mk6+0Bt83HvR3c6bzMs=;
        b=QZxqMS0js3XjXBN4DFJJ+5F66fBuMvxZ1NtJcqvy8bcAU0W6yOceRGxF5nv5Ppq9Wq
         Jhp6qOFnifk10JWwsRtrXUuN+Ere3FG0CxOgnDt0dMWYgt314c1G982WGw3/UpytkXDA
         ihf82S4C0mkn4x7PWiTCAH/KB95S0tuyZz5OjJLinshRNkiJYCNRtR+hs+9jzlmF9Bkv
         MOXH6yj/NTcDJKWO1dCJrf3urtrMEQgH2Ly4hA8/2/9Z5q1SNrsoUMpAswEV95PZTslZ
         QPizz81j6pXX++S4M0WlSNYxZaVOVnP1RzM4xTMOccomlBtc1pP762baS5dyIk54LO2t
         P16w==
X-Gm-Message-State: AO0yUKXH/YVc5W0d4YXoKPzG5H0A42apQseM9ltQkq2YIPr8NunaH8U7
        bt/2vAnZdcQ46RA7NuSj39b5yA==
X-Google-Smtp-Source: AK7set+UyCQeMve8qCoyb6VIz4fi6ac3eAiO+/pikjvLEQkASIURRxN5AspUOR0bkz5GksVzBfwRjg==
X-Received: by 2002:a05:6a00:21cf:b0:5a8:a0f3:6135 with SMTP id t15-20020a056a0021cf00b005a8a0f36135mr8344938pfj.3.1677054111070;
        Wed, 22 Feb 2023 00:21:51 -0800 (PST)
Received: from [10.200.11.31] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id p20-20020aa78614000000b005b0853a1a3esm4894293pfn.159.2023.02.22.00.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:21:50 -0800 (PST)
Message-ID: <b9d344d0-9d27-034d-d59e-9e880318906b@bytedance.com>
Date:   Wed, 22 Feb 2023 16:21:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] mm: vmscan: make memcg slab shrink lockless
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
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
In-Reply-To: <39cf7fa7-5dd6-0424-23de-1c33e948a201@bytedance.com>
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



On 2023/2/22 16:16, Qi Zheng wrote:
> Hi Kirill,
> 
> On 2023/2/22 05:43, Kirill Tkhai wrote:
>> On 20.02.2023 12:16, Qi Zheng wrote:
>>> Like global slab shrink, since commit 1cd0bd06093c<...>
>>>   static bool cgroup_reclaim(struct scan_control *sc)
>>> @@ -891,15 +905,14 @@ static unsigned long shrink_slab_memcg(gfp_t 
>>> gfp_mask, int nid,
>>>   {
>>>       struct shrinker_info *info;
>>>       unsigned long ret, freed = 0;
>>> +    int srcu_idx;
>>>       int i;
>>>       if (!mem_cgroup_online(memcg))
>>>           return 0;
>>> -    if (!down_read_trylock(&shrinker_rwsem))
>>> -        return 0;
>>> -
>>> -    info = shrinker_info_protected(memcg, nid);
>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>> +    info = shrinker_info_srcu(memcg, nid);
>>>       if (unlikely(!info))
>>>           goto unlock;
>>
>> There is shrinker_nr_max dereference under this hunk. It's not in the 
>> patch:
>>
>>          for_each_set_bit(i, info->map, shrinker_nr_max) {
>>
>> Since shrinker_nr_max may grow in parallel, this leads to access 
>> beyond allocated memory :(
> 
> Oh, indeed.
> 
>>
>> It looks like we should save size of info->map as a new member of 
>> struct shrinker_info.
> 
> Agree, then we only traverse info->map_size each time. Like below:
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6eda2ab205d..f1b5d2803007 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -97,6 +97,7 @@ struct shrinker_info {
>          struct rcu_head rcu;
>          atomic_long_t *nr_deferred;
>          unsigned long *map;
> +       int map_size;
>   };
> 
>   struct lruvec_stats_percpu {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f94bfe540675..dd07eb107915 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -239,14 +239,20 @@ static void free_shrinker_info_rcu(struct rcu_head 
> *head)
>          kvfree(container_of(head, struct shrinker_info, rcu));
>   }
> 
> -static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> -                                   int map_size, int defer_size,
> -                                   int old_map_size, int old_defer_size)
> +static int expand_one_shrinker_info(struct mem_cgroup *memcg, int 
> new_nr_max,
> +                                   int old_nr_max)
>   {
> +       int map_size, defer_size, old_map_size, old_defer_size;
>          struct shrinker_info *new, *old;
>          struct mem_cgroup_per_node *pn;
>          int nid;
> -       int size = map_size + defer_size;
> +       int size;
> +
> +       map_size = shrinker_map_size(new_nr_max);
> +       defer_size = shrinker_defer_size(new_nr_max);
> +       old_map_size = shrinker_map_size(shrinker_nr_max);
> +       old_defer_size = shrinker_defer_size(shrinker_nr_max);

Perhaps these should still be calculated outside the loop as before.

> +       size = map_size + defer_size;
> 
>          for_each_node(nid) {
>                  pn = memcg->nodeinfo[nid];
> @@ -261,6 +267,7 @@ static int expand_one_shrinker_info(struct 
> mem_cgroup *memcg,
> 
>                  new->nr_deferred = (atomic_long_t *)(new + 1);
>                  new->map = (void *)new->nr_deferred + defer_size;
> +               new->map_size = new_nr_max;
> 
>                  /* map: set all old bits, clear all new bits */
>                  memset(new->map, (int)0xff, old_map_size);
> @@ -310,6 +317,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>                  }
>                  info->nr_deferred = (atomic_long_t *)(info + 1);
>                  info->map = (void *)info->nr_deferred + defer_size;
> +               info->map_size = shrinker_nr_max;
>                  rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, 
> info);
>          }
>          mutex_unlock(&shrinker_mutex);
> @@ -327,8 +335,6 @@ static int expand_shrinker_info(int new_id)
>   {
>          int ret = 0;
>          int new_nr_max = new_id + 1;
> -       int map_size, defer_size = 0;
> -       int old_map_size, old_defer_size = 0;
>          struct mem_cgroup *memcg;
> 
>          if (!need_expand(new_nr_max))
> @@ -339,15 +345,9 @@ static int expand_shrinker_info(int new_id)
> 
>          lockdep_assert_held(&shrinker_mutex);
> 
> -       map_size = shrinker_map_size(new_nr_max);
> -       defer_size = shrinker_defer_size(new_nr_max);
> -       old_map_size = shrinker_map_size(shrinker_nr_max);
> -       old_defer_size = shrinker_defer_size(shrinker_nr_max);
> -
>          memcg = mem_cgroup_iter(NULL, NULL, NULL);
>          do {
> -               ret = expand_one_shrinker_info(memcg, map_size, defer_size,
> -                                              old_map_size, 
> old_defer_size);
> +               ret = expand_one_shrinker_info(memcg, new_nr_max, 
> shrinker_nr_max);
>                  if (ret) {
>                          mem_cgroup_iter_break(NULL, memcg);
>                          goto out;
> @@ -912,7 +912,7 @@ static unsigned long shrink_slab_memcg(gfp_t 
> gfp_mask, int nid,
>          if (unlikely(!info))
>                  goto unlock;
> 
> -       for_each_set_bit(i, info->map, shrinker_nr_max) {
> +       for_each_set_bit(i, info->map, info->map_size) {
>                  struct shrink_control sc = {
>                          .gfp_mask = gfp_mask,
>                          .nid = nid,
> 
> I will send the v2.
> 
> Thanks,
> Qi
> 
>>
>>> @@ -949,14 +962,9 @@ static unsigned long shrink_slab_memcg(gfp_t 
>>> gfp_mask, int nid,
>>>                   set_shrinker_bit(memcg, nid, i);
>>>           }
>>>           freed += ret;
>>> -
>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>> -            freed = freed ? : 1;
>>> -            break;
>>> -        }
>>>       }
>>>   unlock:
>>> -    up_read(&shrinker_rwsem);
>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>       return freed;
>>>   }
>>>   #else /* CONFIG_MEMCG */
>>
> 

-- 
Thanks,
Qi
