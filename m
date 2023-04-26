Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC86EF460
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbjDZMea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbjDZMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:34:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE5510E6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:34:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1a682eee3baso53664175ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682512467; x=1685104467;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ALvtuzTMvRcQlGW1O2H52hcT8b1w+PATV75u0eY4wA=;
        b=VhUKhHZvLOgvuwE8CSo5rpJoixi7PR3arRBCWvbmLH5fx+9lKmITqKHhf0bnc4tVdQ
         8I0FmFd5D3zE8s91pd0/UHWJAsemslXBuYS8k+3i9XLkdTKKX5PBTLPB/VEtHf5wrGxG
         Icr6s6qSh9SE5vYH+d03kREqKsFxbRVPKTlj585yvzDxJEV5ktAsDZjILwxel+EyR5hw
         plxoBfIxlqpkM8iVxzcNpGRYBTKxof83rBETMi8+/NykD/RGbrBM/tG8cbCIMt7BO2np
         HDKyA6ah5w3eDVkYWN8iqzib3apKebQXMzlFr+K+uD99r4y2jQmQTY5S14eqPloC1xna
         H/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682512467; x=1685104467;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ALvtuzTMvRcQlGW1O2H52hcT8b1w+PATV75u0eY4wA=;
        b=YUuplt7lol5HQPKXlfDo4pCgTEf39iMzzg0bkIaV5HoFSaiS/7Oyy1+ywKG50oQPfv
         TW25fVMZjctOgaDkgndolv2tTOybDeqGB2iZ5rMbKC80mH+7JYkrXbulLB/YGor4U1co
         4VhxglEhwvP8f2l7rbjY4J5KaW3ejFHRu8AlcQyfZB+Ui6iSK53F7yrV9eLHeylc82Dm
         7oMKqugl7xaICpvaTmgEYdA3rpy3dokTb7GFD7JtRCTS2qUkS6tGhDwiV9j4tv9sZhVC
         6Y4VUszq+KxQe8cN+s61HHs9K8LNkiqZAgEs37qYn4VyK/T8vQ+Z1AFx7XHVCFSPbPYp
         KjLw==
X-Gm-Message-State: AAQBX9f+SGLIyxkfxR2oRFZcU4AerfqkAyeEXhc4M3QphrE0kh6qNaoX
        nOGbttIpIxvLpsdNvMV0N5/WADvnba2r8F/P
X-Google-Smtp-Source: AKy350YB/alFLA2cd6TSzZb0pOHGtmFXQkW0yWtdHt7ixnN9Y7NKrKiohHDH4TZg73F0zQmFJsU/Hw==
X-Received: by 2002:a17:902:eb84:b0:19e:839e:49d8 with SMTP id q4-20020a170902eb8400b0019e839e49d8mr20630845plg.59.1682512467237;
        Wed, 26 Apr 2023 05:34:27 -0700 (PDT)
Received: from [10.200.11.252] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id az11-20020a170902a58b00b001a1ed2fce9asm8399390plb.235.2023.04.26.05.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 05:34:26 -0700 (PDT)
Message-ID: <1ee0cfa0-c442-1e31-24a8-90dd8b7ab2a6@gmail.com>
Date:   Wed, 26 Apr 2023 20:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 3/9] maple_tree: Modify the allocation method of
 mtree_alloc_range/rrange()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-4-zhangpeng.00@bytedance.com>
 <20230425160815.mionpme7bmdequzb@revolver>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230425160815.mionpme7bmdequzb@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/26 00:08, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:
>> Let mtree_alloc_range() and mtree_alloc_rrange() use mas_empty_area()
>> and mas_empty_area_rev() respectively for allocation to reduce code
>> redundancy. And after doing this, we don't need to maintain two logically
>> identical codes to improve maintainability.
>>
>> In fact, mtree_alloc_range/rrange() has some bugs. For example, when
>> dealing with min equals to max (mas_empty_area/area_rev() has been fixed),
>> the allocation will fail.
>> There are still some other bugs in it, I saw it with my naked eyes, but
>> I didn't test it, for example:
>> When mtree_alloc_range()->mas_alloc()->mas_awalk(), we set mas.index = min,
>> mas.last = max - size. However, mas_awalk() requires mas.index = min,
>> mas.last = max, which may lead to allocation failures.
> 
> Please don't re-state code in your commit messages.
> 
> Try to focus on what you did, and not why.
> 
> ie: Aligned mtree_alloc_range() to use the same internal function as
> mas_empty_area().
> 
>>
>> Right now no users are using these two functions so the bug won't trigger,
>> but this might trigger in the future.
>>
>> Also use mas_store_gfp() instead of mas_fill_gap() as I don't see any
>> difference between them.
> 
> Yeah, evolution of the code converged on the same design.  Thanks for
> seeing this.
> 
>>
>> After doing this, we no longer need the three functions
>> mas_fill_gap(), mas_alloc(), and mas_rev_alloc().
> 
> Let's just drop mtree_alloc_range() and mtree_alloc_rrange() and
> whatever else you found here.  They were planned to simplify the mmap
> code allocations, but since there would need to be arch involvement
> (coloring, etc) and alignment, etc; it is better to leave this job to
> the mm code itself.
Ok, I will remove some useless functions here.
But mtree_alloc_range() and mtree_alloc_rrange() really don't need to be 
reserved? Because I don't know if there will be users using it in other 
scenarios in the future.

Thank you for all your suggestions on this patch set, I will update them.
> 
>>
>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 45 ++++++++++++---------------------------------
>>   1 file changed, 12 insertions(+), 33 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index aa55c914818a0..294d4c8668323 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -6362,32 +6362,20 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>>   {
>>   	int ret = 0;
>>   
>> -	MA_STATE(mas, mt, min, max - size);
>> +	MA_STATE(mas, mt, 0, 0);
>>   	if (!mt_is_alloc(mt))
>>   		return -EINVAL;
>>   
>>   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>>   		return -EINVAL;
>>   
>> -	if (min > max)
>> -		return -EINVAL;
>> -
>> -	if (max < size)
>> -		return -EINVAL;
>> -
>> -	if (!size)
>> -		return -EINVAL;
>> -
>>   	mtree_lock(mt);
>> -retry:
>> -	mas.offset = 0;
>> -	mas.index = min;
>> -	mas.last = max - size;
>> -	ret = mas_alloc(&mas, entry, size, startp);
>> -	if (mas_nomem(&mas, gfp))
>> -		goto retry;
>> -
>> +	ret = mas_empty_area(&mas, min, max, size);
>> +	if (!ret)
>> +		ret = mas_store_gfp(&mas, entry, gfp);
>>   	mtree_unlock(mt);
>> +	if (!ret)
>> +		*startp = mas.index;
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(mtree_alloc_range);
>> @@ -6398,29 +6386,20 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>>   {
>>   	int ret = 0;
>>   
>> -	MA_STATE(mas, mt, min, max - size);
>> +	MA_STATE(mas, mt, 0, 0);
>>   	if (!mt_is_alloc(mt))
>>   		return -EINVAL;
>>   
>>   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>>   		return -EINVAL;
>>   
>> -	if (min >= max)
>> -		return -EINVAL;
>> -
>> -	if (max < size - 1)
>> -		return -EINVAL;
>> -
>> -	if (!size)
>> -		return -EINVAL;
>> -
>>   	mtree_lock(mt);
>> -retry:
>> -	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
>> -	if (mas_nomem(&mas, gfp))
>> -		goto retry;
>> -
>> +	ret = mas_empty_area_rev(&mas, min, max, size);
>> +	if (!ret)
>> +		ret = mas_store_gfp(&mas, entry, gfp);
>>   	mtree_unlock(mt);
>> +	if (!ret)
>> +		*startp = mas.index;
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(mtree_alloc_rrange);
>> -- 
>> 2.20.1
>>
