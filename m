Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1E7228C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjFEO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFEO1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:27:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9A9E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:27:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b04706c85fso45298745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685975242; x=1688567242;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shyRAkFHSl3nzVFhW7KMsifc/iY67ydnpjq/S8SR6sA=;
        b=UT1c6vnlywnQk3wnFWyoHbWnh7UFxR5bYubKXmcAXnu/d0OI2m7Wh0KI0Zp7gxZTMR
         fDdmyiXRxXfYRWja1yY1sUtqRS6LSsoeJjJFdUP/f0nXY17hyYaiJe6i0/oj1xubQlpJ
         o1CXa11IZZ2LPy8LtHusyzLy3DRSNoRCipaMymTdMGE0Je2HVjwIN0KYCYeUTtoCDgMS
         kdk/f2ix7MTIHWd0pgcA3LmOUUVRRBpBVCms1rZDeeKxJzX1DaWM2w4ksBoNcbnXTGUw
         7kfdZ4d8CcVDYtJbR8f0B04nji+WhIe5R0iSnAPnamgwy19spytE6toz07SOPj/mVtJk
         9xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975242; x=1688567242;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shyRAkFHSl3nzVFhW7KMsifc/iY67ydnpjq/S8SR6sA=;
        b=KZdXZKb79bStzfU5n9JDgmozysjhxcFMu4OhgeMBHK+rhETfssjRbVFqIyxcuzU2yv
         M+s/MYB9bua7LR3bxrq6cXvYXKSlk+6UPVJc/Ki23zMtYx/Q2ViCFO264KkQarRzTdjY
         ai6licNEmvyfXxm6RHr8qUM2aDd7mKEFhUsVtzvxmwOmCnXmyQl2Y1PEZ3gzsujuBynV
         gzJAC8WaoQDnmv3HO/XvMndh12zai20RnxTwxF2aHHjzw9ajwEdYTP95AXX7b76cHJKa
         bTRwG2vp6NbWVS/ilMv3APlBEVs65lF3VNRBMMvpDErPL9+CITePwUvDIth3Gnm3im0U
         z4Vg==
X-Gm-Message-State: AC+VfDxkh8x2Gu6geN16aCHuaT/Lh+kjKkyAMOHkXgmSxkNKrxYaQD7q
        BFp8B8jxSzpFjclpuk6ZuJ0g8A==
X-Google-Smtp-Source: ACHHUZ5q+9/hpDpNbEmPfexN/w3sozUseCO7rivhq2qNv2iFF/63a4CBNm+XPPyg0HQv5kneUTEA8Q==
X-Received: by 2002:a17:902:d506:b0:1ad:eb62:f617 with SMTP id b6-20020a170902d50600b001adeb62f617mr9378720plg.45.1685975242621;
        Mon, 05 Jun 2023 07:27:22 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001b00dae8771sm6663218plh.201.2023.06.05.07.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 07:27:22 -0700 (PDT)
Message-ID: <8f9ed046-529f-073f-5c1a-4c69328b2519@bytedance.com>
Date:   Mon, 5 Jun 2023 22:27:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
 <20230605140344.66pwpdg5zgb6rfa7@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230605140344.66pwpdg5zgb6rfa7@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/5 22:03, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230605 03:59]:
>>
>>
>> 在 2023/6/5 14:18, Yin, Fengwei 写道:
>>>
>>>
>>> On 6/5/2023 12:41 PM, Yin Fengwei wrote:
>>>> Hi Peng,
>>>>
>>>> On 6/5/23 11:28, Peng Zhang wrote:
>>>>>
>>>>>
>>>>> 在 2023/6/2 16:10, Yin, Fengwei 写道:
>>>>>> Hi Liam,
>>>>>>
>>>>>> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
>>>>>>> Initial work on preallocations showed no regression in performance
>>>>>>> during testing, but recently some users (both on [1] and off [android]
>>>>>>> list) have reported that preallocating the worst-case number of nodes
>>>>>>> has caused some slow down.  This patch set addresses the number of
>>>>>>> allocations in a few ways.
>>>>>>>
>>>>>>> During munmap() most munmap() operations will remove a single VMA, so
>>>>>>> leverage the fact that the maple tree can place a single pointer at
>>>>>>> range 0 - 0 without allocating.  This is done by changing the index in
>>>>>>> the 'sidetree'.
>>>>>>>
>>>>>>> Re-introduce the entry argument to mas_preallocate() so that a more
>>>>>>> intelligent guess of the node count can be made.
>>>>>>>
>>>>>>> Patches are in the following order:
>>>>>>> 0001-0002: Testing framework for benchmarking some operations
>>>>>>> 0003-0004: Reduction of maple node allocation in sidetree
>>>>>>> 0005:      Small cleanup of do_vmi_align_munmap()
>>>>>>> 0006-0013: mas_preallocate() calculation change
>>>>>>> 0014:      Change the vma iterator order
>>>>>> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
>>>>>> this patchset.
>>>>>>
>>>>>> The result has a little bit improvement:
>>>>>> Base (next-20230602):
>>>>>>      503880
>>>>>> Base with this patchset:
>>>>>>      519501
>>>>>>
>>>>>> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>>>>>>      718080
>>>>>>
>>>>>>
>>>>>> Some other information I collected:
>>>>>> With Base, the mas_alloc_nodes are always hit with request: 7.
>>>>>> With this patchset, the request are 1 or 5.
>>>>>>
>>>>>> I suppose this is the reason for improvement from 503880 to 519501.
>>>>>>
>>>>>> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
>>>>>> mas_alloc_nodes() call. Thanks.
>>>>> Hi Fengwei,
>>>>>
>>>>> I think it may be related to the inaccurate number of nodes allocated
>>>>> in the pre-allocation. I slightly modified the pre-allocation in this
>>>>> patchset, but I don't know if it works. It would be great if you could
>>>>> help test it, and help pinpoint the cause. Below is the diff, which can
>>>>> be applied based on this pachset.
>>>> I tried the patch, it could eliminate the call of mas_alloc_nodes() during
>>>> the test. But the result of benchmark got a little bit improvement:
>>>>     529040
>>>>
>>>> But it's still much less than none-regression result. I will also double
>>>> confirm the none-regression result.
>>> Just noticed that the commit f5715584af95 make validate_mm() two implementation
>>> based on CONFIG_DEBUG_VM instead of CONFIG_DEBUG_VM_MAPPLE_TREE). I have
>>> CONFIG_DEBUG_VM but not CONFIG_DEBUG_VM_MAPPLE_TREE defined. So it's not an
>>> apple to apple.
> 
> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
> have it as a different commit id in my branch.
> 
> I 'restored' some of the checking because I was able to work around not
> having the mt_dump() definition with the vma iterator.  I'm now
> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
> have added these extra checks.
> 
>>>
>>>
>>> I disable CONFIG_DEBUG_VM and re-run the test and got:
>>> Before preallocation change (7be1c1a3c7b1):
>>>       770100
>>> After preallocation change (28c5609fb236):
>>>       680000
>>> With liam's fix:
>>>       702100
>>> plus Peng's fix:
>>>       725900
>> Thank you for your test, now it seems that the performance
>> regression is not so much.
> 
> We are also too strict on the reset during mas_store_prealloc() checking
> for a spanning write.  I have a fix for this for v2 of the patch set,
> although I suspect it will not make a huge difference.
> 
>>>
>>>
>>> Regards
>>> Yin, Fengwei
>>>
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>> Thanks,
>>>>> Peng
>>>>>
>>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>>> index 5ea211c3f186..e67bf2744384 100644
>>>>> --- a/lib/maple_tree.c
>>>>> +++ b/lib/maple_tree.c
>>>>> @@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>>>            goto ask_now;
>>>>>        }
>>>>>
>>>>> -    /* New root needs a singe node */
>>>>> -    if (unlikely(mte_is_root(mas->node)))
>>>>> -        goto ask_now;
> 
> Why did you drop this?  If we are creating a new root we will only need
> one node.
The code below handles the root case perfectly,
we don't need additional checks.
	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
		request = mas_mt_height(mas) * 2 - 1;
> 
>>>>> +    if ((node_size == wr_mas.node_end + 1 &&
>>>>> +         mas->offset == wr_mas.node_end) ||
>>>>> +        (node_size == wr_mas.node_end &&
>>>>> +         wr_mas.offset_end - mas->offset == 1))
>>>>> +        return 0;
> 
> I will add this to v2 as well, or something similar.
> 
>>>>>
>>>>>        /* Potential spanning rebalance collapsing a node, use worst-case */
>>>>>        if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>>>>> @@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>>>        if (likely(!mas_is_err(mas)))
>>>>>            return 0;
>>>>>
>>>>> -    mas_set_alloc_req(mas, 0);
> 
> Why did you drop this?  It seems like a worth while cleanup on failure.
Because we will clear it in mas_node_count_gfp()->mas_alloc_nodes().
> 
>>>>>        ret = xa_err(mas->node);
>>>>>        mas_reset(mas);
>>>>>        mas_destroy(mas);
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Yin, Fengwei
>>>>>>
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
>>>>>>>
>>>>>>> Liam R. Howlett (14):
>>>>>>>      maple_tree: Add benchmarking for mas_for_each
>>>>>>>      maple_tree: Add benchmarking for mas_prev()
>>>>>>>      mm: Move unmap_vmas() declaration to internal header
>>>>>>>      mm: Change do_vmi_align_munmap() side tree index
>>>>>>>      mm: Remove prev check from do_vmi_align_munmap()
>>>>>>>      maple_tree: Introduce __mas_set_range()
>>>>>>>      mm: Remove re-walk from mmap_region()
>>>>>>>      maple_tree: Re-introduce entry to mas_preallocate() arguments
>>>>>>>      mm: Use vma_iter_clear_gfp() in nommu
>>>>>>>      mm: Set up vma iterator for vma_iter_prealloc() calls
>>>>>>>      maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>>>>>>>      maple_tree: Update mas_preallocate() testing
>>>>>>>      maple_tree: Refine mas_preallocate() node calculations
>>>>>>>      mm/mmap: Change vma iteration order in do_vmi_align_munmap()
>>>>>>>
>>>>>>>     fs/exec.c                        |   1 +
>>>>>>>     include/linux/maple_tree.h       |  23 ++++-
>>>>>>>     include/linux/mm.h               |   4 -
>>>>>>>     lib/maple_tree.c                 |  78 ++++++++++----
>>>>>>>     lib/test_maple_tree.c            |  74 +++++++++++++
>>>>>>>     mm/internal.h                    |  40 ++++++--
>>>>>>>     mm/memory.c                      |  16 ++-
>>>>>>>     mm/mmap.c                        | 171 ++++++++++++++++---------------
>>>>>>>     mm/nommu.c                       |  45 ++++----
>>>>>>>     tools/testing/radix-tree/maple.c |  59 ++++++-----
>>>>>>>     10 files changed, 331 insertions(+), 180 deletions(-)
>>>>>>>
