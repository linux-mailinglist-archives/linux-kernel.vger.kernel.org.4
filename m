Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6934673CE45
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFYD2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFYD2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:28:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B082E7B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:28:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1806951a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687663691; x=1690255691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXRtEpdmgfttImvo4Tlut0TWnE+Ckr8vokO7ZMeuBLM=;
        b=RL4mR2J/CzoGZKeE5gS1E48Mle26Ex9HrMTY30RKImfVczJiSZ9qABlLaqZwxcZCr6
         d/+IRXua66++r90KhY9PzQf9AEoBuMes9k2qNIpIMYF38C8/V9HmvKUvWkxuguz86JIg
         HCotmGZq8Ks6cV54D+erhoM1XnheNsFZzpsqbs/bTd2B927jR7wnEuWW/reKzAuEqEyT
         51SIKJ/qTxy+JO4Y+5tYztXZrBhyBWI+F8EwepH+MyB5zRuhs7DXiZrRux3dLpmMGk7p
         Y5GnLuNmIhHNVULvkfhBy3mcLZeBIxKQ8CnBJxaoHdNX2aohN9MZcKhYBe3Y6R9NSOnE
         /SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687663691; x=1690255691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vXRtEpdmgfttImvo4Tlut0TWnE+Ckr8vokO7ZMeuBLM=;
        b=YRU9j9O/ZX9k2BsLXVSi54p0DbBP8ykUrZLFixa2DsOF28N1+DmzgFDwul+1/gATwD
         yQ0OXinAOeZ+bydwxHmWFJA6LsKgvR/rXhbpkKjZOpRBpK1bOfcf+2EYgDN82b4HV2qL
         vJl2R68KBJOLGh1jvKzpCvlRau2tWMvGJjnQySl96H5v6kdh2HByI6Jbr+mDvmoHMRjs
         /fZM0alZHKkK/36nt4XSHXkMwo422JhY1TOolBkMKBWVSYXAaytcdBOa0rf9d8/TONjC
         OIq8XdwEpsQHzQRpIn/Sz6ttsUtCI/fVnTBk8HemHG7lYtPLkw7ybzugCRlTIKcvxVPr
         6KsQ==
X-Gm-Message-State: AC+VfDwMWe6qwogUZMsqDEHgPUorFfRgaLfYIiEQwi+oBMdDnmkYfk2B
        bTbRjWA6UPuZ1dwnwsntWO0=
X-Google-Smtp-Source: ACHHUZ5ZuhVDIpm1fi1amylnvldyYN8z0ivw9cfv9vm/U4wGZ63/8kdhzR6H7eYNJ1ys7s1tVWWk2w==
X-Received: by 2002:a05:6a20:6a23:b0:117:1ffb:a14 with SMTP id p35-20020a056a206a2300b001171ffb0a14mr33978752pzk.13.1687663690919;
        Sat, 24 Jun 2023 20:28:10 -0700 (PDT)
Received: from [10.255.209.141] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x16-20020a62fb10000000b0066875f17266sm1633091pfm.135.2023.06.24.20.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 20:28:10 -0700 (PDT)
Message-ID: <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
Date:   Sun, 25 Jun 2023 11:28:04 +0800
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
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/23 00:41, Danilo Krummrich 写道:
> On 6/12/23 22:39, Liam R. Howlett wrote:
>> Calculate the number of nodes based on the pending write action instead
>> of assuming the worst case.
> 
> Liam already gave me a heads-up on this patch, which I already replied 
> to [1].
> 
> However, I think it might make sense to also reply to this patch directly.
> 
> For a mas_preallocate() calculating the actual required nodes to be 
> allocated instead of assuming the worst to work, it is required to 
> ensure that the tree does not change between calling mas_preallocate() 
> and mas_store_prealloc() if my understanding is correct.
> 
> In DRM however, more specifically the DRM GPUVA Manager [2], we do have 
> the case that we are not able to ensure this:
> 
> Jobs to create GPU mappings can be submitted by userspace, are queued up 
> by the kernel and are processed asynchronously in dma-fence signalling 
> critical paths, e.g. by using the drm_gpu_scheduler. Hence, we must be 
> able to allocate the worst case amount of node, since at the time a job 
> is submitted we can't predict the state the maple tree keeping track of 
> mappings has once a mapping is inserted in the (asynchronous) dma-fence 
> signalling critical path.
> 
> A more detailed explanation can be found in [1].
> 
> Could we keep a separate function for allocating the worst case amount 
> of nodes additionally to this optimization? E.g. something like 
> mas_preallocate_worst_case() or mas_preallocate_unlocked() (since I 
> guess the new one requires the maple tree to be kept locked in order not 
> to change)?
Hi Danilo,

Your understanding seems incorrect. Even with previously unoptimized
mas_preallocate(), the maple tree cannot be modified between calls to
mas_preallocate() and mas_store_prealloc(). The calculation of the
number of pre-allocated nodes depends on the structure of the maple
tree. In the unoptimized mas_preallocate(), it depends on the height of
the tree. If the maple tree is modified before mas_store_prealloc() and
the height of the tree changes, the number of pre-allocated nodes is
inaccurate.

Regards,
Peng

> 
> [1] 
> https://lore.kernel.org/nouveau/68cd25de-e767-725e-2e7b-703217230bb0@redhat.com/T/#ma326e200b1de1e3c9df4e9fcb3bf243061fee8b5
> 
> [2] 
> https://lore.kernel.org/linux-mm/20230620004217.4700-8-dakr@redhat.com/T/#m47ab82310f87793d0f0cc1825a316eb30ad5b653
> 
> - Danilo
> 
>>
>> This addresses a performance regression introduced in platforms that
>> have longer allocation timing.
>>
>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> ---
>>   lib/maple_tree.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 048d6413a114..7ac5b5457603 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5541,9 +5541,55 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>>    */
>>   int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>   {
>> +    MA_WR_STATE(wr_mas, mas, entry);
>> +    unsigned char node_size;
>> +    int request = 1;
>>       int ret;
>> -    mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
>> +
>> +    if (unlikely(!mas->index && mas->last == ULONG_MAX))
>> +        goto ask_now;
>> +
>> +    mas_wr_store_setup(&wr_mas);
>> +    wr_mas.content = mas_start(mas);
>> +    /* Root expand */
>> +    if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
>> +        goto ask_now;
>> +
>> +    if (unlikely(!mas_wr_walk(&wr_mas))) {
>> +        /* Spanning store, use worst case for now */
>> +        request = 1 + mas_mt_height(mas) * 3;
>> +        goto ask_now;
>> +    }
>> +
>> +    /* At this point, we are at the leaf node that needs to be 
>> altered. */
>> +    /* Exact fit, no nodes needed. */
>> +    if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
>> +        return 0;
>> +
>> +    mas_wr_end_piv(&wr_mas);
>> +    node_size = mas_wr_new_end(&wr_mas);
>> +    /* Slot store can avoid using any nodes */
>> +    if (node_size == wr_mas.node_end && wr_mas.offset_end - 
>> mas->offset == 1)
>> +        return 0;
>> +
>> +    if (node_size >= mt_slots[wr_mas.type]) {
>> +        /* Split, worst case for now. */
>> +        request = 1 + mas_mt_height(mas) * 2;
>> +        goto ask_now;
>> +    }
>> +
>> +    /* Appending does not need any nodes */
>> +    if (node_size == wr_mas.node_end + 1 && mas->offset == 
>> wr_mas.node_end)
>> +        return 0;
>> +
>> +    /* Potential spanning rebalance collapsing a node, use worst-case */
>> +    if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>> +        request = mas_mt_height(mas) * 2 - 1;
>> +
>> +    /* node store needs one node */
>> +ask_now:
>> +    mas_node_count_gfp(mas, request, gfp);
>>       mas->mas_flags |= MA_STATE_PREALLOC;
>>       if (likely(!mas_is_err(mas)))
>>           return 0;
> 
> 
