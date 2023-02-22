Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D369EF58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBVHcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBVHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:32:13 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE4232E59
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:32:10 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id y19so3792396pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kemf0QD+8lsn0hwumRthvkjGm0bh/0AXIwHYn7VagkA=;
        b=G2C8zQ3nGPpfw+M4PiofB7HfUpgBcaJIU/oGa5jeGS5Z+PySybUwfi7+fWfJqlXSay
         Ew5up/PSeEOQ8rfKKpaOqef9VqUWwKAP1ZAJxej6oP/h8Tx1kdMqUVVGeYprtxX9zf5N
         9854pY3CJk/ZhwQ0MWzh93nN/EExx+2/VB9TYmOdTvDiIFu6bJ6POnFuAWXcbiPMcUh7
         Cg/I+RQaDovPU4APGIFPCeb2kunS2YmxOHtpyHdl1ZMvWUSe0ijHa32hsafVSYz6pdvc
         2PNajUFKHI0m7CjCqN4uEjYfNCTlNGmCJdCEFxNr5etc51K7PqSYs50Yk5UIxD57XIxs
         MrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kemf0QD+8lsn0hwumRthvkjGm0bh/0AXIwHYn7VagkA=;
        b=nWXYsJoAU+yFVEsM0un/c7hnwvNEnaT9+p+o1j02BlaCA8oMa/K9k0lePUEQNhdPyk
         /lfQQCW86+aGrW2cutNGDUlv2Tu9venlXz3jNC5UyGzB3ecAxXxW9H4T/YdiuP4IdWsF
         MbdRpzTk263kRb3y4Ohzucig6xybWuzS9QwjS1faGYIMAlZovkGyc4RrziJFEoNUwtml
         R/vzhn2c5Ao1yjDEPYUxeGUahMM09VA2ZOifzdwfqMlGrjaEgaO/rfQ4QwKqhzJxx0Dz
         LZW31Vk9nzDNJj7Od7cqe/eRPkUjLFKQx29M7fjUmuS0SzSbJnoSsMT56DGZzKJtV7L3
         cDrA==
X-Gm-Message-State: AO0yUKVguXACnhA0rB05Luiicl7GV0CHNZT8fGKZVz/9OMPG6mbBe2F7
        PdLd073FrWMz7UtnStYgSWDW7w==
X-Google-Smtp-Source: AK7set+Xe759XIGpO7yYtJsvDg1dguWDFx32HBOC23n8FDmrWcvJw7KxuoYdzJ23DJh4oGywp4FonA==
X-Received: by 2002:aa7:8dc6:0:b0:5a9:c837:2457 with SMTP id j6-20020aa78dc6000000b005a9c8372457mr8306160pfr.1.1677051129721;
        Tue, 21 Feb 2023 23:32:09 -0800 (PST)
Received: from [10.200.11.31] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id k13-20020a636f0d000000b004fbb48e3e5csm4092110pgc.77.2023.02.21.23.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:32:09 -0800 (PST)
Message-ID: <2eb276f1-0d81-f207-4cf9-e6586c5e18c8@bytedance.com>
Date:   Wed, 22 Feb 2023 15:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] mm: vmscan: make memcg slab shrink lockless
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
 <8733cb3c-7a6a-33c4-b84e-4fb981dae765@ya.ru>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <8733cb3c-7a6a-33c4-b84e-4fb981dae765@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/22 05:28, Kirill Tkhai wrote:
> On 20.02.2023 12:16, Qi Zheng wrote:
<...>
>>   
>>   void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>   {
>> -	int i, nid;
>> +	int i, nid, srcu_idx;
>>   	long nr;
>>   	struct mem_cgroup *parent;
>>   	struct shrinker_info *child_info, *parent_info;
>> @@ -429,16 +443,16 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>   		parent = root_mem_cgroup;
>>   
>>   	/* Prevent from concurrent shrinker_info expand */
>> -	down_read(&shrinker_rwsem);
>> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
> 
> Don't we still have to be protected against parallel expand_one_shrinker_info()?
> 
> It looks like parent->nodeinfo[nid]->shrinker_info pointer may be changed in expand*
> right after we've dereferenced it here.

Hi Kirill,

Oh, indeed. We may wrongly reparent the child's nr_deferred to the old
parent's nr_deferred (it is about to be freed by call_srcu).

The reparent_shrinker_deferred() will only be called on the offline
path (not a hotspot path), so we may be able to use shrinker_mutex
introduced later for protection. What do you think?

Thanks,
Qi

> 
>>   	for_each_node(nid) {
>> -		child_info = shrinker_info_protected(memcg, nid);
>> -		parent_info = shrinker_info_protected(parent, nid);
>> +		child_info = shrinker_info_srcu(memcg, nid);
>> +		parent_info = shrinker_info_srcu(parent, nid);
>>   		for (i = 0; i < shrinker_nr_max; i++) {
>>   			nr = atomic_long_read(&child_info->nr_deferred[i]);
>>   			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>>   		}
>>   	}
>> -	up_read(&shrinker_rwsem);
>> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>   }
>>   
>>   static bool cgroup_reclaim(struct scan_control *sc)
>> @@ -891,15 +905,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>   {
>>   	struct shrinker_info *info;
>>   	unsigned long ret, freed = 0;
>> +	int srcu_idx;
>>   	int i;
>>   
>>   	if (!mem_cgroup_online(memcg))
>>   		return 0;
>>   
>> -	if (!down_read_trylock(&shrinker_rwsem))
>> -		return 0;
>> -
>> -	info = shrinker_info_protected(memcg, nid);
>> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
>> +	info = shrinker_info_srcu(memcg, nid);
>>   	if (unlikely(!info))
>>   		goto unlock;
>>   
>> @@ -949,14 +962,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>   				set_shrinker_bit(memcg, nid, i);
>>   		}
>>   		freed += ret;
>> -
>> -		if (rwsem_is_contended(&shrinker_rwsem)) {
>> -			freed = freed ? : 1;
>> -			break;
>> -		}
>>   	}
>>   unlock:
>> -	up_read(&shrinker_rwsem);
>> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>   	return freed;
>>   }
>>   #else /* CONFIG_MEMCG */
> 

-- 
Thanks,
Qi
