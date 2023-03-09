Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53B6B1B92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCIGdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIGdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:33:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88257D05
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:33:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id n5so823059pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 22:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678343596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q13ZbouwReABTVa/cSNy0nNmlilHUsscgoHC7srPRSo=;
        b=gBhJhCvk6PaW7jLd0fmAr0RreqwIWaoR0zRwstwKhF+wrMq9v44S+QhNmrWz17tC0+
         osZockJfgDTsK6tQNszvNkvngYBE56/qDKDQhvuY+BgVlNECmZw1PCZgWohWDBFoA35H
         b7s7L9g5izYZEUodWQwyqA7OJOP/Tm4wgzpbPKCFtYBNY0ghKgjmrMrETK7vmUwu1A9H
         ncGL68tpE5kMFJO0rG6UxNOCO5fLXZjCTQ6Az+76rwn2ngqghjfbSFluLMQWFTzk4fhu
         KWHDAhq+X60gd+6WxbwKeSx0C/Y1mN5QlDjcL/ae4ULpjsiGpx3gCRZZTw4jOgn4XPee
         munQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678343596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q13ZbouwReABTVa/cSNy0nNmlilHUsscgoHC7srPRSo=;
        b=Ad7iGRosv96gA912Gnot2KShfI/26jNfkkk+Bc6hrDOEyQ6WzB6Rl9vhni1+vmEIEy
         BGlI2k3zVeMUttMyiKm0YRWGqI870XQtcRREySyiNax/F0A3CCuOaij4QiTayaqvy2HF
         QAURsEh8SaJdGWDZQFuDEXkx4MlgfH280HtdkvnhODlJ93CLMR9HIAjR/4yc2lyEfr4W
         L+c79kJpQLFAJj8nvPEvC+ImTgbXCAwfw0AmX423LeN6ZY0y7rIdNqu+zIWLmj2aZKOV
         3ixmInn379c/XdAixD2OPxd13FabrsuRH/UQqOvqtc0D/dEsVgBJAIhfIvvN9Yml8NEs
         sdUw==
X-Gm-Message-State: AO0yUKVTJYZ5pyeAHRsKgQOkyP5Z3YbRHzq0XwVOMuq2DlJz37yhOaZS
        Hrbdw4JEZKHJWVdHrj9FYwKR0Q==
X-Google-Smtp-Source: AK7set9qspIIwKEnK9zoUR54vGfCi6UFwqmCqdNpAdEkjVibB68R9OwlwH9SXiJ7BTyvBlyrC4ut8Q==
X-Received: by 2002:a05:6a00:2d29:b0:5e4:f141:568b with SMTP id fa41-20020a056a002d2900b005e4f141568bmr20273526pfb.3.1678343596166;
        Wed, 08 Mar 2023 22:33:16 -0800 (PST)
Received: from ?IPV6:fdbd:ff1:ce00:1c25:884:3ed:e1db:b610? ([2404:9dc0:cd01::14])
        by smtp.gmail.com with ESMTPSA id f6-20020aa782c6000000b005d6dff9bbecsm10442070pfn.62.2023.03.08.22.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 22:33:14 -0800 (PST)
Message-ID: <b9721532-e7d7-7586-a0da-79ffe519d5f0@bytedance.com>
Date:   Thu, 9 Mar 2023 14:33:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/8] mm: vmscan: add a map_nr_max field to
 shrinker_info
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-2-zhengqi.arch@bytedance.com>
 <eab519de-1222-b097-9eb4-28a444458c28@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <eab519de-1222-b097-9eb4-28a444458c28@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/9 06:13, Kirill Tkhai wrote:
> Hi,
> 
> On 07.03.2023 09:55, Qi Zheng wrote:
>> To prepare for the subsequent lockless memcg slab shrink,
>> add a map_nr_max field to struct shrinker_info to records
>> its own real shrinker_nr_max.
>>
>> Suggested-by: Kirill Tkhai <tkhai@ya.ru>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/memcontrol.h |  1 +
>>   mm/vmscan.c                | 41 ++++++++++++++++++++++----------------
>>   2 files changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index b6eda2ab205d..aa69ea98e2d8 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -97,6 +97,7 @@ struct shrinker_info {
>>   	struct rcu_head rcu;
>>   	atomic_long_t *nr_deferred;
>>   	unsigned long *map;
>> +	int map_nr_max;
>>   };
>>   
>>   struct lruvec_stats_percpu {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 9414226218f0..2dcc01682026 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -224,9 +224,16 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>>   					 lockdep_is_held(&shrinker_rwsem));
>>   }
>>   
>> +static inline bool need_expand(int new_nr_max, int old_nr_max)
>> +{
>> +	return round_up(new_nr_max, BITS_PER_LONG) >
>> +	       round_up(old_nr_max, BITS_PER_LONG);
>> +}
>> +
>>   static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>   				    int map_size, int defer_size,
>> -				    int old_map_size, int old_defer_size)
>> +				    int old_map_size, int old_defer_size,
>> +				    int new_nr_max)
>>   {
>>   	struct shrinker_info *new, *old;
>>   	struct mem_cgroup_per_node *pn;
>> @@ -240,12 +247,17 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>   		if (!old)
>>   			return 0;
>>   
>> +		/* Already expanded this shrinker_info */
>> +		if (!need_expand(new_nr_max, old->map_nr_max))
> 
> need_expand() looks confusing here. It's strange that we round_up(old->map_nr_max),
> despite old->map never may exceed old->map_nr_max.
> 
> Won't plain
> 
> 	if (new_nr_max <= old->map_nr_max)
> 
> look clearer here?

Yeah, will change to it.

> 
> The rest in patch looks OK for me.
> 
>> +			continue;
>> +
>>   		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>>   		if (!new)
>>   			return -ENOMEM;
>>   
>>   		new->nr_deferred = (atomic_long_t *)(new + 1);
>>   		new->map = (void *)new->nr_deferred + defer_size;
>> +		new->map_nr_max = new_nr_max;
>>   
>>   		/* map: set all old bits, clear all new bits */
>>   		memset(new->map, (int)0xff, old_map_size);
>> @@ -295,6 +307,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>   		}
>>   		info->nr_deferred = (atomic_long_t *)(info + 1);
>>   		info->map = (void *)info->nr_deferred + defer_size;
>> +		info->map_nr_max = shrinker_nr_max;
>>   		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>   	}
>>   	up_write(&shrinker_rwsem);
>> @@ -302,23 +315,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>   	return ret;
>>   }
>>   
>> -static inline bool need_expand(int nr_max)
>> -{
>> -	return round_up(nr_max, BITS_PER_LONG) >
>> -	       round_up(shrinker_nr_max, BITS_PER_LONG);
>> -}
>> -
>>   static int expand_shrinker_info(int new_id)
>>   {
>>   	int ret = 0;
>> -	int new_nr_max = new_id + 1;
>> +	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
>>   	int map_size, defer_size = 0;
>>   	int old_map_size, old_defer_size = 0;
>>   	struct mem_cgroup *memcg;
>>   
>> -	if (!need_expand(new_nr_max))
>> -		goto out;
>> -
>>   	if (!root_mem_cgroup)
>>   		goto out;
>>   
>> @@ -332,7 +336,8 @@ static int expand_shrinker_info(int new_id)
>>   	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>>   	do {
>>   		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
>> -					       old_map_size, old_defer_size);
>> +					       old_map_size, old_defer_size,
>> +					       new_nr_max);
>>   		if (ret) {
>>   			mem_cgroup_iter_break(NULL, memcg);
>>   			goto out;
>> @@ -352,9 +357,11 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>>   
>>   		rcu_read_lock();
>>   		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
>> -		/* Pairs with smp mb in shrink_slab() */
>> -		smp_mb__before_atomic();
>> -		set_bit(shrinker_id, info->map);
>> +		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
>> +			/* Pairs with smp mb in shrink_slab() */
>> +			smp_mb__before_atomic();
>> +			set_bit(shrinker_id, info->map);
>> +		}
>>   		rcu_read_unlock();
>>   	}
>>   }
>> @@ -432,7 +439,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>   	for_each_node(nid) {
>>   		child_info = shrinker_info_protected(memcg, nid);
>>   		parent_info = shrinker_info_protected(parent, nid);
>> -		for (i = 0; i < shrinker_nr_max; i++) {
>> +		for (i = 0; i < child_info->map_nr_max; i++) {
>>   			nr = atomic_long_read(&child_info->nr_deferred[i]);
>>   			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>>   		}
>> @@ -899,7 +906,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>   	if (unlikely(!info))
>>   		goto unlock;
>>   
>> -	for_each_set_bit(i, info->map, shrinker_nr_max) {
>> +	for_each_set_bit(i, info->map, info->map_nr_max) {
>>   		struct shrink_control sc = {
>>   			.gfp_mask = gfp_mask,
>>   			.nid = nid,
> 

-- 
Thanks,
Qi
