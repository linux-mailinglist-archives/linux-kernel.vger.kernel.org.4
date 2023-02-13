Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A76943AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBMLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMLA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:00:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9916A71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:00:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so16555039pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676286057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrIAaGaAitwMT476KWNQKhWZUHVEhbCu1CwLZ7kJBOw=;
        b=dhZQqt8vl9rnMA35bg8V/l8CTOZz+w07zAKc0q5ff3h7879CxLSH/kjHlc8da7bVzE
         3IYIYx5927KVAtljdhJk20dP3RAm1CxZYzAmu5B9ViGNVQM6sjwAbQQT31Gy5OhNrDDM
         ks156MhEcMak3qqrD8XO5fxBtCDco0d0jkwH5AXAPTtIQcskQRxBmBufmaF3mjzHPGEQ
         YlNOpuXJmNCBsN2CMK5HiAK7mdKHat1EHWrhxuWYEnIoTnwmXcmV7AHt4dR6Q54lreas
         qy7Jlp+GCAoOJTm3X7dXyXZt05BmfUwLwjRyS7V3o0RR5ADhEc9FLQ5CDB6ceQ04+mN1
         YCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676286057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrIAaGaAitwMT476KWNQKhWZUHVEhbCu1CwLZ7kJBOw=;
        b=Em1eDDBLAG4pW5xEWeHZAK+KaAfJr1ld6WOpvh1bb+I+8KSUoevmdjbBPp0XgWmV5u
         YWXVAhKLscNOqj+eFowtII4B0v3bwn17M3ij+ZyouTfaimODiXKvYaY0kZdei4Zr8Oeb
         qRul2mtRWtXF26gHS0bH0Zx7h7309BoqTAL1UViM6fdTvoYi5JOjASueyaUd+qbrWSrW
         PwbP1NiCqluoVvZtBf2x2lCmTkI53PS6OKBSf8EiRj6Mo7GC2VEGIQCIGaZYetR0fkBt
         Aranl5GklhWQhMhLzvwJwVLHb1Nl9bGhY8RAx1naq9dhThHPRH4t3BSqWW9h0MlAe5KY
         VnIw==
X-Gm-Message-State: AO0yUKV3giz0fSAjG5/PEVKBOUa+LA+DOfs3n7YynUVB5VBYj3WWozMj
        WQuSCMRnvCRctO8PGdLq+TEukg==
X-Google-Smtp-Source: AK7set/p+/RRUEBBx99ozu0vGhaNuQXrUBwHLZ0XnxCN8hFhObsJ1w/BLB0FqVkeHWjaB/QyE1VdwQ==
X-Received: by 2002:a17:902:ce83:b0:196:82d5:1ec4 with SMTP id f3-20020a170902ce8300b0019682d51ec4mr25480212plg.0.1676286056893;
        Mon, 13 Feb 2023 03:00:56 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0019908d2c85dsm7890414plk.52.2023.02.13.03.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:00:56 -0800 (PST)
Message-ID: <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
Date:   Mon, 13 Feb 2023 19:00:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/13 16:47, Vlastimil Babka wrote:
> On 2/12/23 12:03, Qi Zheng wrote:
>> In x86, numa_register_memblks() is only interested in
>> those nodes which have enough memory, so it skips over
>> all nodes with memory below NODE_MIN_SIZE (treated as
>> a memoryless node). Later on, we will initialize these
>> memoryless nodes (allocate pgdat in free_area_init()
>> and build zonelist etc), and will online these nodes
>> in init_cpu_to_node() and init_gi_nodes().
>>
>> After boot, these memoryless nodes are in N_ONLINE
>> state but not in N_MEMORY state. But we can still allocate
>> pages from these memoryless nodes.
>>
>> In SLUB, we only process nodes in the N_MEMORY state,
>> such as allocating their struct kmem_cache_node. So if
>> we allocate a page from the memoryless node above to
>> SLUB, the struct kmem_cache_node of the node corresponding
>> to this page is NULL, which will cause panic.
>>
>> For example, if we use qemu to start a two numa node kernel,
>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>> and the other node has 2G, then we will encounter the
>> following panic:
>>
>> [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [    0.150783] #PF: supervisor write access in kernel mode
>> [    0.151488] #PF: error_code(0x0002) - not-present page
>> <...>
>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>> <...>
>> [    0.169781] Call Trace:
>> [    0.170159]  <TASK>
>> [    0.170448]  deactivate_slab+0x187/0x3c0
>> [    0.171031]  ? bootstrap+0x1b/0x10e
>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>> [    0.172735]  ? bootstrap+0x1b/0x10e
>> [    0.173236]  bootstrap+0x6b/0x10e
>> [    0.173720]  kmem_cache_init+0x10a/0x188
>> [    0.174240]  start_kernel+0x415/0x6ac
>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>> [    0.175417]  </TASK>
>> [    0.175713] Modules linked in:
>> [    0.176117] CR2: 0000000000000000
>>
>> In addition, we can also encountered this panic in the actual
>> production environment. We set up a 2c2g container with two
>> numa nodes, and then reserved 128M for kdump, and then we
>> can encountered the above panic in the kdump kernel.
>>
>> To fix it, we can filter memoryless nodes when allocating
>> pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
> 
> Well AFAIK the key mechanism to only allocate from "good" nodes is the
> zonelist, we shouldn't need to start putting extra checks like this. So it
> seems to me that the code building the zonelists should take the
> NODE_MIN_SIZE constraint in mind.

Indeed. How about the following patch:

@@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t 
*used_node_mask)
         int min_val = INT_MAX;
         int best_node = NUMA_NO_NODE;

-       /* Use the local node if we haven't already */
-       if (!node_isset(node, *used_node_mask)) {
+       /*
+        * Use the local node if we haven't already. But for memoryless 
local
+        * node, we should skip it and fallback to other nodes.
+        */
+       if (!node_isset(node, *used_node_mask) && node_state(node, 
N_MEMORY)) {
                 node_set(node, *used_node_mask);
                 return node;
         }

For memoryless node, we skip it and fallback to other nodes when
build its zonelists.

Say we have node0 and node1, and node0 is memoryless, then:

[    0.102400] Fallback order for Node 0: 1
[    0.102931] Fallback order for Node 1: 1

In this way, we will not allocate pages from memoryless node0.

> 
>> ---
>>   mm/page_alloc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 588555754601..b9cce56f4e21 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4188,6 +4188,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>   			(alloc_flags & ALLOC_CPUSET) &&
>>   			!__cpuset_zone_allowed(zone, gfp_mask))
>>   				continue;
>> +
>> +		/* Don't allocate page from memoryless nodes. */
>> +		if (!node_state((zone_to_nid(zone)), N_MEMORY))
>> +			continue;
>> +
>>   		/*
>>   		 * When allocating a page cache page for writing, we
>>   		 * want to get it from a node that is within its dirty
> 

-- 
Thanks,
Qi
