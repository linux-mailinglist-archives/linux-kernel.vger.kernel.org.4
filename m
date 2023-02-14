Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E76960AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBNK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjBNK0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:26:13 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43083234CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:26:11 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so15017434pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrtjRJWPsvcEE897mqbWJq2gxj22xWbuNgdFjdErDs0=;
        b=Pr/+cvP/oYmkXMDVR3bKAdmGYuEf1X9kYn5lyzdLtVOcLXKG8E+hPXlHWIqLzLRKg9
         xWWjp4DFTMxhwOQGAwAoXtw/BFiKMV5qoUsUopTyEQDMvxhakx9oH4JnKm09vteQtVN5
         kUS0CK2OX2Ev9B0tuC6w0k4S4RJ6+EbUFfbTPoV0N449nXmFS+BlKvGB7PeyiRYAQb3f
         cfflgDm49zrmrN68SCuMklhhsTUE6TZVkrgPJBEEoCp87F4I0Sz4JCwgw98iw7l+H71M
         dEEe/+P++ap17pQe2ZJTKV0xNlBA2vOukTEd0l/KGeQ9HJZgnCAU/Ig3oeCyZ2Y6g+hm
         1PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrtjRJWPsvcEE897mqbWJq2gxj22xWbuNgdFjdErDs0=;
        b=3p9NjPnjBWHkXc2N9N/i+wdnk465oKdfT7lwtCvEQ+1cyi16z4bwqKw+LninhmaVs6
         /tqapK6BvAX7CORdz78p/WLchRQj2Yxj1vHs485C2NuCNPf0sLIYlPqDXDFda2DfCai7
         YZD/Isa/rVzDBBUlBPIf1cZYvp6VpmgEj/8kTHR7Xs0nVM0eR9lZEAbqL/ovs95+sDGM
         WiPMa8ajpuAZK8gRtdBkEgzmrm15J9vm1VqKy0Nd+13GuqwMdWgE5C650EAH0SlG0Frw
         Fbtd19ejCjn7eD5rEl7pAJrQ68tYQ3UNtFg7RCnek6YXwh9XRsZAChKikYceL0g5HWCr
         YfMw==
X-Gm-Message-State: AO0yUKUq4HHhOBI3C9EgiUtNMmTcmyybInM0WyyTT2xyu98Qi8KUGDE7
        d3e9GBL+/jTCTdAPHdG9Xq8yPUEBT4dT6A==
X-Google-Smtp-Source: AK7set8+8ALoUybkPSMxusjcdGW3dih3ShXlZk1aC1VNLjWXbNfNBzlvnKAXW4spmCS1F5TabqJ1vA==
X-Received: by 2002:a17:903:234a:b0:19a:ab73:2168 with SMTP id c10-20020a170903234a00b0019aab732168mr2583394plh.1.1676370370585;
        Tue, 14 Feb 2023 02:26:10 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b0019a73faf773sm7723835pld.71.2023.02.14.02.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:26:10 -0800 (PST)
Message-ID: <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
Date:   Tue, 14 Feb 2023 18:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
From:   Qi Zheng <arch0.zheng@gmail.com>
In-Reply-To: <Y+tXrK/g1Nrd/q1h@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/14 17:43, Mike Rapoport wrote:
> On Tue, Feb 14, 2023 at 10:17:03AM +0100, David Hildenbrand wrote:
>> On 14.02.23 09:42, Vlastimil Babka wrote:
>>> On 2/13/23 12:00, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2023/2/13 16:47, Vlastimil Babka wrote:
>>>>> On 2/12/23 12:03, Qi Zheng wrote:
>>>>>> In x86, numa_register_memblks() is only interested in
>>>>>> those nodes which have enough memory, so it skips over
>>>>>> all nodes with memory below NODE_MIN_SIZE (treated as
>>>>>> a memoryless node). Later on, we will initialize these
>>>>>> memoryless nodes (allocate pgdat in free_area_init()
>>>>>> and build zonelist etc), and will online these nodes
>>>>>> in init_cpu_to_node() and init_gi_nodes().
>>>>>>
>>>>>> After boot, these memoryless nodes are in N_ONLINE
>>>>>> state but not in N_MEMORY state. But we can still allocate
>>>>>> pages from these memoryless nodes.
>>>>>>
>>>>>> In SLUB, we only process nodes in the N_MEMORY state,
>>>>>> such as allocating their struct kmem_cache_node. So if
>>>>>> we allocate a page from the memoryless node above to
>>>>>> SLUB, the struct kmem_cache_node of the node corresponding
>>>>>> to this page is NULL, which will cause panic.
>>>>>>
>>>>>> For example, if we use qemu to start a two numa node kernel,
>>>>>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>>>>> and the other node has 2G, then we will encounter the
>>>>>> following panic:
>>>>>>
>>>>>> [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>>> [    0.150783] #PF: supervisor write access in kernel mode
>>>>>> [    0.151488] #PF: error_code(0x0002) - not-present page
>>>>>> <...>
>>>>>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>>>>> <...>
>>>>>> [    0.169781] Call Trace:
>>>>>> [    0.170159]  <TASK>
>>>>>> [    0.170448]  deactivate_slab+0x187/0x3c0
>>>>>> [    0.171031]  ? bootstrap+0x1b/0x10e
>>>>>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>>>>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>>>>> [    0.172735]  ? bootstrap+0x1b/0x10e
>>>>>> [    0.173236]  bootstrap+0x6b/0x10e
>>>>>> [    0.173720]  kmem_cache_init+0x10a/0x188
>>>>>> [    0.174240]  start_kernel+0x415/0x6ac
>>>>>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>>>>> [    0.175417]  </TASK>
>>>>>> [    0.175713] Modules linked in:
>>>>>> [    0.176117] CR2: 0000000000000000
>>>>>>
>>>>>> In addition, we can also encountered this panic in the actual
>>>>>> production environment. We set up a 2c2g container with two
>>>>>> numa nodes, and then reserved 128M for kdump, and then we
>>>>>> can encountered the above panic in the kdump kernel.
>>>>>>
>>>>>> To fix it, we can filter memoryless nodes when allocating
>>>>>> pages.
>>>>>>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
>>>>>
>>>>> Well AFAIK the key mechanism to only allocate from "good" nodes is the
>>>>> zonelist, we shouldn't need to start putting extra checks like this. So it
>>>>> seems to me that the code building the zonelists should take the
>>>>> NODE_MIN_SIZE constraint in mind.
>>>>
>>>> Indeed. How about the following patch:
>>>
>>> +Cc also David, forgot earlier.
>>>
>>> Looks good to me, at least.
>>>
>>>> @@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t
>>>> *used_node_mask)
>>>>            int min_val = INT_MAX;
>>>>            int best_node = NUMA_NO_NODE;
>>>>
>>>> -       /* Use the local node if we haven't already */
>>>> -       if (!node_isset(node, *used_node_mask)) {
>>>> +       /*
>>>> +        * Use the local node if we haven't already. But for memoryless
>>>> local
>>>> +        * node, we should skip it and fallback to other nodes.
>>>> +        */
>>>> +       if (!node_isset(node, *used_node_mask) && node_state(node,
>>>> N_MEMORY)) {
>>>>                    node_set(node, *used_node_mask);
>>>>                    return node;
>>>>            }
>>>>
>>>> For memoryless node, we skip it and fallback to other nodes when
>>>> build its zonelists.
>>>>
>>>> Say we have node0 and node1, and node0 is memoryless, then:
>>>>
>>>> [    0.102400] Fallback order for Node 0: 1
>>>> [    0.102931] Fallback order for Node 1: 1
>>>>
>>>> In this way, we will not allocate pages from memoryless node0.
>>>>
>>
>> In offline_pages(), we'll first build_all_zonelists() to then
>> node_states_clear_node()->node_clear_state(node, N_MEMORY);
>>
>> So at least on the offlining path, we wouldn't detect it properly yet I
>> assume, and build a zonelist that contains a now-memory-less node?
> 
> Another question is what happens if a new memory is plugged into a node
> that had < NODE_MIN_SIZE of memory and after hotplug it stops being
> "memoryless".

When going online and offline a memory will re-call 
build_all_zonelists() to re-establish the zonelists (the zonelist of
itself and other nodes). So it can stop being "memoryless"
automatically.

But in online_pages(), did not see the check of < NODE_MIN_SIZE.

> 
>> -- 
>> Thanks,
>>
>> David / dhildenb
>>
> 

-- 
Thanks,
Qi
