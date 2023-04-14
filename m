Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9806E2CC6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDNXVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDNXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:21:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597435AA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:21:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id op30so8380647qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681514468; x=1684106468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNvJHKwh0D+LPXWkG2wfqhqz3XTNOZdj+I9UmzX0srw=;
        b=R9xyQtVG78IWIhyHiFP1ZmoUUw8k0qGviTahlAQ+3KNuUamzQ6PpNRrrt6roZpZ8u6
         nfuOD/3aUSw/7kjXEYnZqJ3D/ep2PBs/JFU9piDDgPs2Em72VDiYcwPOx4WjB1sZe3qD
         12IEmEpY+7BXlukSPxoyVfT4HuoSLNgvkEt54SlUR+P+LHwYAd9sDU8PjvjURKeiEFl1
         5CJK9zyV5ISkrYK4hvUfsgkuajXYWQ83Zeq4a8L+tExFfhgpPiW9zhwUUZAWdNuYsRca
         tDtDEoKsI+UUsw0YeixCQ225l9vpM1qyIMyhMmHyQda+YFmpjrEtB3yUXXYeQKUdKHKf
         a9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681514468; x=1684106468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNvJHKwh0D+LPXWkG2wfqhqz3XTNOZdj+I9UmzX0srw=;
        b=ApcxilIGnUBhkWuPNAioyBTT3MvVz/L0aYsrxodvh5aeC0uqySw/6baYJl4BVwfSaV
         eq8FTiqjJq5zRkoT4Agr62w2PqcIxbvDc6O535QFppfa+4mqcUcWIw8P4wQsnwd65g5q
         MaK+rxJLXe364PKNUlRYywGtVbbcxqrsBQ3j/sgaarz+nNMmXoRNrr1ras0/gptj/7BP
         Oov7G9NLb/t1ZOKVJmjd4Wl/xHQ7bhBs+4vxMydSQ5yiWjdgcbkiNp/dWM/Otd6Y+CNH
         nytnitE+FMXgsDbdMC7+I4hs4bsHSFmGjZcjXeLLJJ+aCX2uEQaMJDYeSZsFlL6ZFQ8S
         eTgg==
X-Gm-Message-State: AAQBX9cUxKNZ+O0t2Uuz1s8cUp4HiStgXtnM+giXLzH6QlQxVWItAx6A
        5CUBjuz0ASXLSLkze2q0yUk=
X-Google-Smtp-Source: AKy350beqHbeqLPA9mnK3+1nIFndOzsJcH3chcnBIpFlorLKok9MS0B/CtxqwVu7LFiS86bl4MsQcA==
X-Received: by 2002:a05:6214:5084:b0:5ef:6101:3282 with SMTP id kk4-20020a056214508400b005ef61013282mr1205360qvb.0.1681514468585;
        Fri, 14 Apr 2023 16:21:08 -0700 (PDT)
Received: from [10.69.67.31] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a22d600b007486052d731sm1568299qki.10.2023.04.14.16.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 16:21:08 -0700 (PDT)
Message-ID: <085983ed-b32a-3ec6-ff4a-a340776c410b@gmail.com>
Date:   Fri, 14 Apr 2023 16:20:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mm: page_alloc: Skip regions with hugetlbfs pages when
 allocating 1G pages
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/2023 7:14 AM, Mel Gorman wrote:
> A bug was reported by Yuanxi Liu where allocating 1G pages at runtime is
> taking an excessive amount of time for large amounts of memory. Further
> testing allocating huge pages that the cost is linear i.e. if allocating
> 1G pages in batches of 10 then the time to allocate nr_hugepages from
> 10->20->30->etc increases linearly even though 10 pages are allocated at
> each step. Profiles indicated that much of the time is spent checking the
> validity within already existing huge pages and then attempting a migration
> that fails after isolating the range, draining pages and a whole lot of
> other useless work.
> 
> Commit eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
> pfn_range_valid_contig") removed two checks, one which ignored huge pages
> for contiguous allocations as huge pages can sometimes migrate. While
> there may be value on migrating a 2M page to satisfy a 1G allocation, it's
> potentially expensive if the 1G allocation fails and it's pointless to
> try moving a 1G page for a new 1G allocation or scan the tail pages for
> valid PFNs.
> 
> Reintroduce the PageHuge check and assume any contiguous region with
> hugetlbfs pages is unsuitable for a new 1G allocation.
> 
> The hpagealloc test allocates huge pages in batches and reports the
> average latency per page over time. This test happens just after boot when
> fragmentation is not an issue. Units are in milliseconds.
> 
> hpagealloc
>                                 6.3.0-rc6              6.3.0-rc6              6.3.0-rc6
>                                   vanilla   hugeallocrevert-v1r1   hugeallocsimple-v1r2
> Min       Latency       26.42 (   0.00%)        5.07 (  80.82%)       18.94 (  28.30%)
> 1st-qrtle Latency      356.61 (   0.00%)        5.34 (  98.50%)       19.85 (  94.43%)
> 2nd-qrtle Latency      697.26 (   0.00%)        5.47 (  99.22%)       20.44 (  97.07%)
> 3rd-qrtle Latency      972.94 (   0.00%)        5.50 (  99.43%)       20.81 (  97.86%)
> Max-1     Latency       26.42 (   0.00%)        5.07 (  80.82%)       18.94 (  28.30%)
> Max-5     Latency       82.14 (   0.00%)        5.11 (  93.78%)       19.31 (  76.49%)
> Max-10    Latency      150.54 (   0.00%)        5.20 (  96.55%)       19.43 (  87.09%)
> Max-90    Latency     1164.45 (   0.00%)        5.53 (  99.52%)       20.97 (  98.20%)
> Max-95    Latency     1223.06 (   0.00%)        5.55 (  99.55%)       21.06 (  98.28%)
> Max-99    Latency     1278.67 (   0.00%)        5.57 (  99.56%)       22.56 (  98.24%)
> Max       Latency     1310.90 (   0.00%)        8.06 (  99.39%)       26.62 (  97.97%)
> Amean     Latency      678.36 (   0.00%)        5.44 *  99.20%*       20.44 *  96.99%*
> 
>                     6.3.0-rc6   6.3.0-rc6   6.3.0-rc6
>                       vanilla   revert-v1   hugeallocfix-v2
> Duration User           0.28        0.27        0.30
> Duration System       808.66       17.77       35.99
> Duration Elapsed      830.87       18.08       36.33
> 
> The vanilla kernel is poor, taking up to 1.3 second to allocate a huge page
> and almost 10 minutes in total to run the test. Reverting the problematic
> commit reduces it to 8ms at worst and the patch takes 26ms. This patch
> fixes the main issue with skipping huge pages but leaves the page_count()
> out because a page with an elevated count potentially can migrate.
> 
A while ago I submitted this patch set that should significantly improve
the chances of a 2MB Huge Page being successfully migrated:
https://lore.kernel.org/linux-mm/20220921223639.1152392-1-opendmb@gmail.com/

Unfortunately, it is collecting dust and needs to be updated to support 
Folios, but I would be curious how it affects the performance of this test.

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=217022
> Fixes: eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from pfn_range_valid_contig")
> Reported-by: Yuanxi Liu <y.liu@naruida.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>   mm/page_alloc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7136c36c5d01..b47f520c3051 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9450,6 +9450,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>   
>   		if (PageReserved(page))
>   			return false;
> +
> +		if (PageHuge(page))
> +			return false;
>   	}
>   	return true;
>   }
> 

I am OK with this patch too, but I could resubmit my patch with Mike's 
suggested variant and Folio support if anyone wants to try it instead of 
this approach.

Regards,
     Doug
