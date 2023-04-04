Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97816D5928
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjDDHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjDDHHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:07:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217702111
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:07:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q191so1724367pgq.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680592027;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twOPbfkYHULFT9ytXIMVRlWTWlhqUczKwRzl0UgT8FE=;
        b=VQwBgBskPIZsqNPq6QbEJQZIdmsWzqK8sOopOPe7FaLP+h0sxBo4nNSx6dHTzPuZHv
         fHz8ssbV+rRl7OmLUAXeXmFW2GKW7cuFsPu9bmrHmTKyzmaRn/GeTkD85RwTchhCMRKc
         ibmrfM20x4KzUQquHWHqG1sWs06dLlpldt0lb8rmo0S1O7l5OseeeO0dh4STd/PYbVZJ
         xczXHl3HVTycHtz/HdjJ+uQRiTdgTs/gtCgAxyw/4rPg7DhMm+zH+8ww/bGPeXQrf1HV
         uENkNM5ZoIaF1NTqM9ExALHIiqFENRxZ5U9iHEsaeL9ElyBrP92bjOoMkGoD4HBxG5G2
         Ohvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680592027;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twOPbfkYHULFT9ytXIMVRlWTWlhqUczKwRzl0UgT8FE=;
        b=dc1v9lUqBS+GB4DgaL2dTvobluUvbshU6VFFlTXykRJd1hEuKWDMOuCULF3k7sYxn0
         i6y6EmxPbJkF69UMODgWdBxha+KeI8FoTrUlmS5wjqm0AhjboGoDljBHvIjm6nFLFl+n
         47gX571yEbC22JlyCHqDMEugksWlJif9tf0gEgqvJDkLSz1tuCkM72+qN9saQW8jce+O
         tWWN0k5KIF7yFyJpC7TdnxKw4h379FJZHj9MawVyhnwqCRbgQlcjm/cVgjndleWR254s
         VZqHbeLXRUYSlVLAhh7+Xyp8cjVLviionPHuCQIucSk9wbxlGTFKBb4gO4BU213Pg3DY
         DGIA==
X-Gm-Message-State: AAQBX9ftNvUNzV1IAZpxF7EGQGxhqh1tbkwGO38qHHs9YqEUG1s0uOmH
        UafVBiABSnEYFkZ4oFIFOjDKWA==
X-Google-Smtp-Source: AKy350Z0Dfa0bt8qwppuCspk5hwN33zGD9tFwNW1XiTonZDE6XxLhPnZ2ERAiMnwF3LWvwNCVoU1gg==
X-Received: by 2002:a05:6a00:2294:b0:62d:dd14:bed1 with SMTP id f20-20020a056a00229400b0062ddd14bed1mr1579121pfe.1.1680592027328;
        Tue, 04 Apr 2023 00:07:07 -0700 (PDT)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78816000000b00627e55f383dsm8055551pfo.3.2023.04.04.00.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 00:07:06 -0700 (PDT)
Message-ID: <e6150352-f4eb-b35e-3ec8-5189e0ec0c2a@bytedance.com>
Date:   Tue, 4 Apr 2023 15:07:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] mm: swap: use folio_batch_reinit() in
 folio_batch_move_lru()
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     willy@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230331095858.51810-1-zhengqi.arch@bytedance.com>
 <20230331150430.546de954b0a7918f042c562e@linux-foundation.org>
 <3bd45269-557d-db5a-2224-3d960ba3159d@bytedance.com>
In-Reply-To: <3bd45269-557d-db5a-2224-3d960ba3159d@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/2 21:36, Qi Zheng wrote:
> Hi Andrew,
> 
> On 2023/4/1 06:04, Andrew Morton wrote:
>> On Fri, 31 Mar 2023 17:58:57 +0800 Qi Zheng 
>> <zhengqi.arch@bytedance.com> wrote:
>>
>>> In folio_batch_move_lru(), the folio_batch is not freshly
>>> initialised, so it should call folio_batch_reinit() as
>>> pagevec_lru_move_fn() did before.
>>>
>>> ...
>>>
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -222,7 +222,7 @@ static void folio_batch_move_lru(struct 
>>> folio_batch *fbatch, move_fn_t move_fn)
>>>       if (lruvec)
>>>           unlock_page_lruvec_irqrestore(lruvec, flags);
>>>       folios_put(fbatch->folios, folio_batch_count(fbatch));
>>> -    folio_batch_init(fbatch);
>>> +    folio_batch_reinit(fbatch);
>>>   }
>>>   static void folio_batch_add_and_move(struct folio_batch *fbatch,
>>
>> Well...  why?  This could leave the kernel falsely thinking that the
>> folio's pages have been drained from the per-cpu LRU addition
>> magazines.
>>
>> Maybe that's desirable, maybe not, but I think this change needs much
>> much more explanation describing why it is beneficial.
>>
>>
>> folio_batch_reinit() seems to be a custom thing for the mlock code -
>> perhaps it just shouldn't exist, and its operation should instead be
>> open-coded in mlock_folio_batch().
> 
> The folio_batch_reinit() corresponds to pagevec_reinit(),
> the pagevec_reinit() was originally used in pagevec_lru_move_fn()
> and mlock_pagevec(), not a custom thing for the mlock code.
> 
> 
> The commit c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
> introduces folio_batch_move_lru() to replace pagevec_lru_move_fn(),
> but calls folio_batch_init() (corresponding to pagevec_init()) instead
> of folio_batch_reinit() (corresponding to pagevec_reinit()). This
> change was not explained in the commit message and seems like an
> oversight.
> 
>>
>>
>> The dynamics and rules around ->percpu_pvec_drained are a bit
>> mysterious.  A code comment which explains all of this would be
>> useful.
> 
> The commit d9ed0d08b6c6 ("mm: only drain per-cpu pagevecs once per
> pagevec usage") originally introduced the ->drained (which was later
> renamed to ->percpu_pvec_drained by commit 7f0b5fb953e7), which is
> intended to drain per-cpu pagevecs only once per pagevec usage.
> 
> Maybe it would be better to add the following code comment:
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 423199ee8478..107c4a13e476 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1055,6 +1055,7 @@ EXPORT_SYMBOL(release_pages);
>    */
>   void __pagevec_release(struct pagevec *pvec)
>   {
> +       /* Only drain per-cpu pagevecs once per pagevec usage */
>          if (!pvec->percpu_pvec_drained) {
>                  lru_add_drain();
>                  pvec->percpu_pvec_drained = true;
> 
> Please let me know if I missed something.

Maybe the commit message can be modified as follows:

```
The ->percpu_pvec_drained was originally introduced by commit
d9ed0d08b6c6 ("mm: only drain per-cpu pagevecs once per pagevec usage")
to drain per-cpu pagevecs only once per pagevec usage. But after
commit c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()"), the
->percpu_pvec_drained will be reset to false by calling
folio_batch_init() in folio_batch_move_lru(), which may cause per-cpu
pagevecs to be drained multiple times per pagevec usage. This is not
what we expected, let's use folio_batch_reinit() in
folio_batch_move_lru() to fix it.
```

Also +CC Mel Gorman to confirm this. :)

Thanks,
Qi

> 
> Thanks,
> Qi
> 
>>
> 
> 

-- 
Thanks,
Qi
