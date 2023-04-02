Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18516D381E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDBNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:37:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F96DBB9A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 06:37:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-62810466cccso1487176b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680442619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViAGGHazEfKTbj7wQQXXZXJrHaZfKLnWPNnZQrD+NW8=;
        b=b9ICgWg0Hsb7zbdqXKNMRMSL3n8Fo/ffHpwWAKhqV9NN+SpmU+7PNQf0ZTVPygxzYb
         13cyxX/PY6vMxMYZb90WHSGMrVomsJeeUNfFMutPzCKBcK3z7zekTNI3NPHlOO9bp+3W
         5Ebvlg/sMPWguXCuJfBmkVQWWqlWmIVrn1O7SysHXtEN7HXwE2D5zOlemIU56zVNkJfE
         rJh3BWCwp3Payh6cixnnRYOujFqkLuJHjSb6FECh8jKq3xvGYT+7oAcodgr06vzIGvKl
         8O+73QxyAIeljOw4tbbATbnQ4JIx+XDgnNn8rl9CuoqSGnAumV2VRcQCJVNvAgzLspEI
         mpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680442619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViAGGHazEfKTbj7wQQXXZXJrHaZfKLnWPNnZQrD+NW8=;
        b=zL5iiYUvZjTJllL8Tpt7UOMPlqchQDz3EkuAxSpnHdOD5N4pB3H4GYiBfCZoDGfsA2
         HHlh9Gux9Wv2KAXTokaFKIvQiPZ2j2J2LOhxcJdx36vlhx6bTcs/f4ojWvvM70ntNAGH
         IoMgK7mbhqnfLA2cgWMCynjkWkWqrUUy9HuUURNOOCAN+sAB8u9LAfLC8t1BFYgoLpoA
         aIZnOxF/8W7yQUZC1WxSbjUK3d2N1dgdmY5g+vaim8IxwJOOxGPnHU0HfjnzHHiQM0y9
         yXleBesMUqAvyj7aL3QINBXTtTZfRz4HoVG39KhkJKkxXpQDyBaHo2fnFKPA/bLhN+UP
         mVQg==
X-Gm-Message-State: AAQBX9cEQ6MWX1P0YGNcrd28uylOhBiogj6Fj3boof/ACnfdOfk6EZV4
        PIWhUk/c8dsiqSKgh14OukPHOg==
X-Google-Smtp-Source: AKy350bi6bpU6bw1qBKGFkvnb1QX/0FDCD1BDFcHg5UYXr1LHxDfk6wd8gho3vRtQwxIP7bZyu5ZlQ==
X-Received: by 2002:a17:90a:bc83:b0:23f:6872:e37c with SMTP id x3-20020a17090abc8300b0023f6872e37cmr10973754pjr.0.1680442619599;
        Sun, 02 Apr 2023 06:36:59 -0700 (PDT)
Received: from [10.200.9.195] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a300b00b00233e860f69esm7993719pjb.56.2023.04.02.06.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 06:36:59 -0700 (PDT)
Message-ID: <3bd45269-557d-db5a-2224-3d960ba3159d@bytedance.com>
Date:   Sun, 2 Apr 2023 21:36:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] mm: swap: use folio_batch_reinit() in
 folio_batch_move_lru()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230331095858.51810-1-zhengqi.arch@bytedance.com>
 <20230331150430.546de954b0a7918f042c562e@linux-foundation.org>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230331150430.546de954b0a7918f042c562e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2023/4/1 06:04, Andrew Morton wrote:
> On Fri, 31 Mar 2023 17:58:57 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> In folio_batch_move_lru(), the folio_batch is not freshly
>> initialised, so it should call folio_batch_reinit() as
>> pagevec_lru_move_fn() did before.
>>
>> ...
>>
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -222,7 +222,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
>>   	if (lruvec)
>>   		unlock_page_lruvec_irqrestore(lruvec, flags);
>>   	folios_put(fbatch->folios, folio_batch_count(fbatch));
>> -	folio_batch_init(fbatch);
>> +	folio_batch_reinit(fbatch);
>>   }
>>   
>>   static void folio_batch_add_and_move(struct folio_batch *fbatch,
> 
> Well...  why?  This could leave the kernel falsely thinking that the
> folio's pages have been drained from the per-cpu LRU addition
> magazines.
> 
> Maybe that's desirable, maybe not, but I think this change needs much
> much more explanation describing why it is beneficial.
> 
> 
> folio_batch_reinit() seems to be a custom thing for the mlock code -
> perhaps it just shouldn't exist, and its operation should instead be
> open-coded in mlock_folio_batch().

The folio_batch_reinit() corresponds to pagevec_reinit(),
the pagevec_reinit() was originally used in pagevec_lru_move_fn()
and mlock_pagevec(), not a custom thing for the mlock code.


The commit c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
introduces folio_batch_move_lru() to replace pagevec_lru_move_fn(),
but calls folio_batch_init() (corresponding to pagevec_init()) instead
of folio_batch_reinit() (corresponding to pagevec_reinit()). This
change was not explained in the commit message and seems like an
oversight.

> 
> 
> The dynamics and rules around ->percpu_pvec_drained are a bit
> mysterious.  A code comment which explains all of this would be
> useful.

The commit d9ed0d08b6c6 ("mm: only drain per-cpu pagevecs once per
pagevec usage") originally introduced the ->drained (which was later
renamed to ->percpu_pvec_drained by commit 7f0b5fb953e7), which is
intended to drain per-cpu pagevecs only once per pagevec usage.

Maybe it would be better to add the following code comment:

diff --git a/mm/swap.c b/mm/swap.c
index 423199ee8478..107c4a13e476 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1055,6 +1055,7 @@ EXPORT_SYMBOL(release_pages);
   */
  void __pagevec_release(struct pagevec *pvec)
  {
+       /* Only drain per-cpu pagevecs once per pagevec usage */
         if (!pvec->percpu_pvec_drained) {
                 lru_add_drain();
                 pvec->percpu_pvec_drained = true;

Please let me know if I missed something.

Thanks,
Qi

> 

