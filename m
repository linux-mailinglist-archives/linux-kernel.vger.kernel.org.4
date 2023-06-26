Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459EB73E194
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFZOIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjFZOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:08:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F7E7A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:08:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8054180acso8358285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687788490; x=1690380490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBN8blGYXvnxlXBIVOSTpTlppcCRsXOaHTKDN6AwyzQ=;
        b=dzGKLkbvt/18pINM4BAdCzeMA7heFFExgGSN5O/dVJ4hZpl6Neb9d3mM1ZWu3kJCz9
         6lALUwhHQy62gBR9gPNCQ2PcLVBDAIwE6Z7CSAtAoLIo/k8Ls5lbe8/Rg+60+Yb5jYpn
         Ija4O7Ne1kh4yJltZD7Wjoj3FNQhA6PlnP5k1FtN9pSTf0aIiw7Jh4htjbWDeBLklCvf
         Rp2UdeOuNq3QdtyfbEi0LJledSlFv18XIncFskMRyjm/ymT1T/zSFXUfQ5H9b0/qwbX5
         IEsNWN5iGQvGS331KgkQCwUJgWU91bjwqo+Gr7yLxRgBCMTn00H2hk4pTAoxgke8hmNA
         vNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788490; x=1690380490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBN8blGYXvnxlXBIVOSTpTlppcCRsXOaHTKDN6AwyzQ=;
        b=j6c0wpLQHPPPdAmg4Amo+cOhfCkYCZZlQy276yJctg5mld4JM3k3z5SDAYfSR4J2oi
         EJoAtDwAKfdZF8N1/lCXFO6Z7gw9O+/suqbv78sa70rTP+bkup3OPM8Ds3i8epIuqYQo
         4NWD5Akf81yAJuOHL3S5mPD50SAyZzi1CAls+DRpVwg1BKV3EJLoEVZLFMycewwwVoPn
         FrxKHlnrPn3FHdXiXxXXTq4l567XKJdvOP4jaP8LhcYZO1ZwfMr+tor1xf/D+Y489Jf9
         /R3B8Topsixe4m95l3+vYMU1ZgkELe4uaewWtdrmlTMzLvwH/USsAl4FL3uejdn5AN/T
         2kQA==
X-Gm-Message-State: AC+VfDxb35ThK0TH9L+/Ayl6t1NgO26Bpv8vSb+9Np+8XEhINjyxawk1
        7Ikmq2bBevhF2PeaS66Kv5hgEw==
X-Google-Smtp-Source: ACHHUZ6EWq0b7ssc5mx6VHgRCMYEBCOBoTqqG2cF8Q1iJSu7eIvWnLrwfscQt8+XTTuNf0iaVeF22A==
X-Received: by 2002:a17:902:c10c:b0:1b5:4709:fa0e with SMTP id 12-20020a170902c10c00b001b54709fa0emr7199079pli.10.1687788489653;
        Mon, 26 Jun 2023 07:08:09 -0700 (PDT)
Received: from [10.255.209.141] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b682336f83sm4259302plh.42.2023.06.26.07.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:08:09 -0700 (PDT)
Message-ID: <e3af3f2f-ec87-e8e8-c72b-dfce20b32193@bytedance.com>
Date:   Mon, 26 Jun 2023 22:08:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
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



在 2023/6/26 08:38, Danilo Krummrich 写道:
> Hi Peng,
> 
> On 6/25/23 05:28, Peng Zhang wrote:
>>
>>
>> 在 2023/6/23 00:41, Danilo Krummrich 写道:
>>> On 6/12/23 22:39, Liam R. Howlett wrote:
>>>> Calculate the number of nodes based on the pending write action instead
>>>> of assuming the worst case.
>>>
>>> Liam already gave me a heads-up on this patch, which I already 
>>> replied to [1].
>>>
>>> However, I think it might make sense to also reply to this patch 
>>> directly.
>>>
>>> For a mas_preallocate() calculating the actual required nodes to be 
>>> allocated instead of assuming the worst to work, it is required to 
>>> ensure that the tree does not change between calling 
>>> mas_preallocate() and mas_store_prealloc() if my understanding is 
>>> correct.
>>>
>>> In DRM however, more specifically the DRM GPUVA Manager [2], we do 
>>> have the case that we are not able to ensure this:
>>>
>>> Jobs to create GPU mappings can be submitted by userspace, are queued 
>>> up by the kernel and are processed asynchronously in dma-fence 
>>> signalling critical paths, e.g. by using the drm_gpu_scheduler. 
>>> Hence, we must be able to allocate the worst case amount of node, 
>>> since at the time a job is submitted we can't predict the state the 
>>> maple tree keeping track of mappings has once a mapping is inserted 
>>> in the (asynchronous) dma-fence signalling critical path.
>>>
>>> A more detailed explanation can be found in [1].
>>>
>>> Could we keep a separate function for allocating the worst case 
>>> amount of nodes additionally to this optimization? E.g. something 
>>> like mas_preallocate_worst_case() or mas_preallocate_unlocked() 
>>> (since I guess the new one requires the maple tree to be kept locked 
>>> in order not to change)?
>> Hi Danilo,
>>
>> Your understanding seems incorrect. Even with previously unoptimized
>> mas_preallocate(), the maple tree cannot be modified between calls to
>> mas_preallocate() and mas_store_prealloc(). The calculation of the
>> number of pre-allocated nodes depends on the structure of the maple
>> tree. In the unoptimized mas_preallocate(), it depends on the height of
>> the tree. If the maple tree is modified before mas_store_prealloc() and
>> the height of the tree changes, the number of pre-allocated nodes is
>> inaccurate.
> 
> Thanks for pointing this out!
> 
> First of all, it's probably fair to say "naive me", it totally makes 
> sense the tree height is needed - it's a b-tree.
> 
> On the other hand, unless I miss something (and if so, please let me 
> know), something is bogus with the API then.
> 
> While the documentation of the Advanced API of the maple tree explicitly 
> claims that the user of the API is responsible for locking, this should 
> be limited to the bounds set by the maple tree implementation. Which 
> means, the user must decide for either the internal (spin-) lock or an 
> external lock (which possibly goes away in the future) and acquire and 
> release it according to the rules maple tree enforces through lockdep 
> checks.
> 
> Let's say one picks the internal lock. How is one supposed to ensure the 
> tree isn't modified using the internal lock with mas_preallocate()?
> 
> Besides that, I think the documentation should definitely mention this 
> limitation and give some guidance for the locking.
Yes, the documentation of maple tree is not detailed and complete.
> 
> Currently, from an API perspective, I can't see how anyone not familiar 
> with the implementation details would be able to recognize this limitation.
> 
> In terms of the GPUVA manager, unfortunately, it seems like I need to 
> drop the maple tree and go back to using a rb-tree, since it seems there 
> is no sane way doing a worst-case pre-allocation that does not suffer 
> from this limitation.
I also think preallocation may not be necessary, and I agree with what
Matthew said. Preallocation should be used in some cases where
preallocation has to be used. If preallocation is used, but the number
of preallocated nodes is insufficient because the tree is modified
midway, GFP_NOWAIT will be used for memory allocation during the tree
modification process, and the user may not notice that more nodes are
not from preallocation.

> 
> - Danilo
> 
>>
>> Regards,
>> Peng
>>
>>>
>>> [1] 
>>> https://lore.kernel.org/nouveau/68cd25de-e767-725e-2e7b-703217230bb0@redhat.com/T/#ma326e200b1de1e3c9df4e9fcb3bf243061fee8b5
>>>
>>> [2] 
>>> https://lore.kernel.org/linux-mm/20230620004217.4700-8-dakr@redhat.com/T/#m47ab82310f87793d0f0cc1825a316eb30ad5b653
>>>
>>> - Danilo
>>>
>>>>
>>>> This addresses a performance regression introduced in platforms that
>>>> have longer allocation timing.
>>>>
>>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>>> ---
>>>>   lib/maple_tree.c | 48 
>>>> +++++++++++++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 47 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>> index 048d6413a114..7ac5b5457603 100644
>>>> --- a/lib/maple_tree.c
>>>> +++ b/lib/maple_tree.c
>>>> @@ -5541,9 +5541,55 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>>>>    */
>>>>   int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>>   {
>>>> +    MA_WR_STATE(wr_mas, mas, entry);
>>>> +    unsigned char node_size;
>>>> +    int request = 1;
>>>>       int ret;
>>>> -    mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
>>>> +
>>>> +    if (unlikely(!mas->index && mas->last == ULONG_MAX))
>>>> +        goto ask_now;
>>>> +
>>>> +    mas_wr_store_setup(&wr_mas);
>>>> +    wr_mas.content = mas_start(mas);
>>>> +    /* Root expand */
>>>> +    if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
>>>> +        goto ask_now;
>>>> +
>>>> +    if (unlikely(!mas_wr_walk(&wr_mas))) {
>>>> +        /* Spanning store, use worst case for now */
>>>> +        request = 1 + mas_mt_height(mas) * 3;
>>>> +        goto ask_now;
>>>> +    }
>>>> +
>>>> +    /* At this point, we are at the leaf node that needs to be 
>>>> altered. */
>>>> +    /* Exact fit, no nodes needed. */
>>>> +    if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
>>>> +        return 0;
>>>> +
>>>> +    mas_wr_end_piv(&wr_mas);
>>>> +    node_size = mas_wr_new_end(&wr_mas);
>>>> +    /* Slot store can avoid using any nodes */
>>>> +    if (node_size == wr_mas.node_end && wr_mas.offset_end - 
>>>> mas->offset == 1)
>>>> +        return 0;
>>>> +
>>>> +    if (node_size >= mt_slots[wr_mas.type]) {
>>>> +        /* Split, worst case for now. */
>>>> +        request = 1 + mas_mt_height(mas) * 2;
>>>> +        goto ask_now;
>>>> +    }
>>>> +
>>>> +    /* Appending does not need any nodes */
>>>> +    if (node_size == wr_mas.node_end + 1 && mas->offset == 
>>>> wr_mas.node_end)
>>>> +        return 0;
>>>> +
>>>> +    /* Potential spanning rebalance collapsing a node, use 
>>>> worst-case */
>>>> +    if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>>>> +        request = mas_mt_height(mas) * 2 - 1;
>>>> +
>>>> +    /* node store needs one node */
>>>> +ask_now:
>>>> +    mas_node_count_gfp(mas, request, gfp);
>>>>       mas->mas_flags |= MA_STATE_PREALLOC;
>>>>       if (likely(!mas_is_err(mas)))
>>>>           return 0;
>>>
>>>
>>
> 
