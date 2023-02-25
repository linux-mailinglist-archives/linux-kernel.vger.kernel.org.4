Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB82C6A27E0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBYISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:18:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C910A82
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 00:18:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x34so1402621pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677313102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsL47J7DzrSRjS/g3c5jkzLcMkIvj6gluZDiMTud1Ck=;
        b=dkWq/lRIS6rF3yoxHvLbrsc7h7kNCFDAxZeSKhqpr44UZVR7WDMLX1PA5ZGwxEcwHc
         qD7knbmKLg0KDwIpHblMgaN7J3WibVarj7LHLM+TMrephoEh/XwzKGN0OJo7Zi3htey6
         pNxGmuzPiVRVbA2P8IRp0lWGKtGWdr8ABlpMF4oQesQUMESKkRqd1tUwea4E8PS/qWHO
         X5xFSXx4bm4K0N2u4hDV/6yEJ9PKUsyJEqsnrhkrAklYtOD88bE5m4QPul+viV1mNfQF
         rUlT8WPf8C4I6HMKtrzPwFXBN1R8nzPlteSxJ+gf0E2QnHjzuagiw38OJEM4kVTFFaUo
         /evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677313102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsL47J7DzrSRjS/g3c5jkzLcMkIvj6gluZDiMTud1Ck=;
        b=1BsckHYVBnilY5E0asUsZ7YyO5Hzr+z/UDlvi3oOZRVTFsYxUyHcwd96qcBdwHnzY6
         xZAGSX2fTaqQVR6mzw9a0pvyn0+cNhyebi+nzmzbLR2gL5jifZ3etjG3ytE5PJZQTr3b
         KORn5z34E1+Iw2rkUMLzRapK3ghRwh0eAtnhTPBA/fcCvZzV8WYu3rNH4Fd56vaL2Om0
         h5QPBVtwfemQDYAOUOct0cu9sLTYZ4BE9r8l/lPlF7u/0ko5448r2TU2Vdc7kqsOBfMI
         vFN1NrntYK1PnNNpQBw+jJICTf4Ns8OYHhcUARNgNWB4qhZlJFcCJUEuGaYkAAeN8t8H
         ws8g==
X-Gm-Message-State: AO0yUKUV2CbsemoniJEdfliehqafyIq1rYrJjA43w0V6lehPhKYAz0qi
        HWg9UEPHe8x4jv+X0gd4N5IkPg==
X-Google-Smtp-Source: AK7set+6C8v4zlUBW6YX8TWQM59wHZsXC1+GAytwBOWDwTRxNjpB1aCiXdpz+VaxC/DOf9WWZJg2vw==
X-Received: by 2002:a05:6a20:3d24:b0:cb:692e:6314 with SMTP id y36-20020a056a203d2400b000cb692e6314mr17184556pzi.6.1677313101621;
        Sat, 25 Feb 2023 00:18:21 -0800 (PST)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id v26-20020a62a51a000000b005a9131b6668sm735663pfm.2.2023.02.25.00.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 00:18:21 -0800 (PST)
Message-ID: <6f8f01b5-d802-db64-7725-8481c67c13a2@bytedance.com>
Date:   Sat, 25 Feb 2023 16:18:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/7] mm: vmscan: add a map_nr_max field to
 shrinker_info
Content-Language: en-US
To:     tkhai@ya.ru
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230223132725.11685-2-zhengqi.arch@bytedance.com>
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



On 2023/2/23 21:27, Qi Zheng wrote:
> To prepare for the subsequent lockless memcg slab shrink,
> add a map_nr_max field to struct shrinker_info to records
> its own real shrinker_nr_max.
> 
> No functional changes.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

I missed Suggested-by here, hi Kirill, can I add it?

Suggested-by: Kirill Tkhai <tkhai@ya.ru>

> ---
>   include/linux/memcontrol.h |  1 +
>   mm/vmscan.c                | 29 ++++++++++++++++++-----------
>   2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6eda2ab205d..aa69ea98e2d8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -97,6 +97,7 @@ struct shrinker_info {
>   	struct rcu_head rcu;
>   	atomic_long_t *nr_deferred;
>   	unsigned long *map;
> +	int map_nr_max;
>   };
>   
>   struct lruvec_stats_percpu {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9c1c5e8b24b8..9f895ca6216c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -224,9 +224,16 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>   					 lockdep_is_held(&shrinker_rwsem));
>   }
>   
> +static inline bool need_expand(int new_nr_max, int old_nr_max)
> +{
> +	return round_up(new_nr_max, BITS_PER_LONG) >
> +	       round_up(old_nr_max, BITS_PER_LONG);
> +}
> +
>   static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   				    int map_size, int defer_size,
> -				    int old_map_size, int old_defer_size)
> +				    int old_map_size, int old_defer_size,
> +				    int new_nr_max)
>   {
>   	struct shrinker_info *new, *old;
>   	struct mem_cgroup_per_node *pn;
> @@ -240,12 +247,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   		if (!old)
>   			return 0;
>   
> +		if (!need_expand(new_nr_max, old->map_nr_max))
> +			return 0;
> +
>   		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>   		if (!new)
>   			return -ENOMEM;
>   
>   		new->nr_deferred = (atomic_long_t *)(new + 1);
>   		new->map = (void *)new->nr_deferred + defer_size;
> +		new->map_nr_max = new_nr_max;
>   
>   		/* map: set all old bits, clear all new bits */
>   		memset(new->map, (int)0xff, old_map_size);
> @@ -295,6 +306,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   		}
>   		info->nr_deferred = (atomic_long_t *)(info + 1);
>   		info->map = (void *)info->nr_deferred + defer_size;
> +		info->map_nr_max = shrinker_nr_max;
>   		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>   	}
>   	up_write(&shrinker_rwsem);
> @@ -302,12 +314,6 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   	return ret;
>   }
>   
> -static inline bool need_expand(int nr_max)
> -{
> -	return round_up(nr_max, BITS_PER_LONG) >
> -	       round_up(shrinker_nr_max, BITS_PER_LONG);
> -}
> -
>   static int expand_shrinker_info(int new_id)
>   {
>   	int ret = 0;
> @@ -316,7 +322,7 @@ static int expand_shrinker_info(int new_id)
>   	int old_map_size, old_defer_size = 0;
>   	struct mem_cgroup *memcg;
>   
> -	if (!need_expand(new_nr_max))
> +	if (!need_expand(new_nr_max, shrinker_nr_max))
>   		goto out;
>   
>   	if (!root_mem_cgroup)
> @@ -332,7 +338,8 @@ static int expand_shrinker_info(int new_id)
>   	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>   	do {
>   		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
> -					       old_map_size, old_defer_size);
> +					       old_map_size, old_defer_size,
> +					       new_nr_max);
>   		if (ret) {
>   			mem_cgroup_iter_break(NULL, memcg);
>   			goto out;
> @@ -432,7 +439,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>   	for_each_node(nid) {
>   		child_info = shrinker_info_protected(memcg, nid);
>   		parent_info = shrinker_info_protected(parent, nid);
> -		for (i = 0; i < shrinker_nr_max; i++) {
> +		for (i = 0; i < child_info->map_nr_max; i++) {
>   			nr = atomic_long_read(&child_info->nr_deferred[i]);
>   			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>   		}
> @@ -899,7 +906,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>   	if (unlikely(!info))
>   		goto unlock;
>   
> -	for_each_set_bit(i, info->map, shrinker_nr_max) {
> +	for_each_set_bit(i, info->map, info->map_nr_max) {
>   		struct shrink_control sc = {
>   			.gfp_mask = gfp_mask,
>   			.nid = nid,

-- 
Thanks,
Qi
