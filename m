Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB17A5E7037
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiIVX1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIVX1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:27:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA7610BB3D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:27:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s18so7425342qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/85pqBD6V1IDX7Z4khIsy5d7kZgs4wG5xtK0jD0vbnk=;
        b=SMnYmEZ8bKvLcyZXF4aCTXE+fTnaOXy7Y7KL/hT9H8MBRoJsh+2tWbTYtqpu9roM3W
         c/EJgnAOocWwXvjIceFEJKY09LczYh92xb52Y/3SFD2ZWZnNnbFQga5Ho5KceykS76Pb
         dYyqyz1izT2eK+nwAOAbbnmHztngYPszDJXLdqoK/eBYeoNot8IwQX/NolcXbzsqLIK6
         kZHcIlfSkDC469X/gUZ68y8znEnUGMwmjwE3BUskvP9cJnSxFPJoaghyTIFaAs3DE8jg
         /+0J1CQ/bC00nm4F4LA3qoDfxUnwXo/31dCz8ZF32l54u/ZfyjwF53FcUQod44xCA7JI
         hBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/85pqBD6V1IDX7Z4khIsy5d7kZgs4wG5xtK0jD0vbnk=;
        b=fqy32hqHlZSJKHOTNOAN+KvZYoQYrF1vPF+90uMYmuhGcpZVXjG3oXRMtQzv7ODmW2
         jzCKC4BPO51ndOy2jfjq3M8+v7f8//1/kmD7iPWdhqQaF6xLLtZWZQc9m6RJWO+bHQoK
         Op1KtZWSKTL5KcWM8qMXHL7mZYcq6WdeMKnn4bSZ74FGe3idrZLSmXeuUsPLRUN/iDOn
         MCqIaIHTWMry/NrrXwdhpR2maB/TLsbIYw130jzgnUCOCTuxzG5fQodOFBxtigcKKhFH
         70XYkGeohXhWeMRDw5ISjWQtFdVk7Jn5xJLSr9Q2gNhJWKwfc5BmVmLolnyOnJ1/jlZR
         qDRw==
X-Gm-Message-State: ACrzQf22xtFDnYUn912mOf2yTL9ANIdZ8vXaAM4qJceb2jOxzBMcmiMv
        DMQsZPZwOQzIqGkTL70yGAE=
X-Google-Smtp-Source: AMsMyM6EUNxlqgVpdg2aIxTEvH+EfRC4e3A02T6Wuh0uPFEYC6rKGxKEMyOsRUkB5le9W4JFyZV/CA==
X-Received: by 2002:a05:622a:315:b0:35c:f6b2:f740 with SMTP id q21-20020a05622a031500b0035cf6b2f740mr5018915qtw.521.1663889234427;
        Thu, 22 Sep 2022 16:27:14 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bx5-20020a05622a090500b0035bb152d414sm4139811qtb.94.2022.09.22.16.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 16:27:13 -0700 (PDT)
Message-ID: <829c3fe1-54a2-53ba-9448-d80196b5ebf0@gmail.com>
Date:   Thu, 22 Sep 2022 16:27:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] mm/hugetlb: hugepage migration enhancements
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220921223639.1152392-1-opendmb@gmail.com>
 <YyzEz4snl2x51iTY@monkey> <YyzkoGJsIXVFW6ZL@monkey>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <YyzkoGJsIXVFW6ZL@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2022 3:41 PM, Mike Kravetz wrote:
> On 09/22/22 13:25, Mike Kravetz wrote:
>> On 09/21/22 15:36, Doug Berger wrote:
>>
>> As noted above, for pages to be migrated we first try to use an existing
>> free huge page as the target.  Quite some time ago, Michal added code to
>> allocate a new page from buddy as the target if no free huge pages were
>> available.  This change also included a special flag to dissolve the
>> source huge page when it is freed.  It seems like this is the exact
>> behavior we want here?  I wonder if it might be easier just to use this
>> existing code?
> 
> Totally untested, but I believe the patch below would accomplish this.
> 
>  From aa8fc11bb67bc9e67e3b6b280fab339afce37759 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Thu, 22 Sep 2022 15:32:10 -0700
> Subject: [PATCH] hugetlb: force alloc_contig_range hugetlb migrations to
>   allocate new pages
> 
> When migrating hugetlb pages as the result of an alloc_contig_range
> operation, allocate a new page from buddy for the migration target.
> This guarantees that the number of hugetlb pages is not decreased by
> the operation.  In addition, this will result in the special HPageTemporary
> flag being set in the source page so that it will be dissolved when
> freed.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   include/linux/hugetlb.h |  5 +++--
>   mm/hugetlb.c            | 12 ++++++++++--
>   mm/internal.h           |  1 +
>   mm/migrate.c            |  3 ++-
>   mm/page_alloc.c         |  1 +
>   5 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cfe15b32e2d4..558831bf1087 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -702,7 +702,8 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
>   struct page *alloc_huge_page(struct vm_area_struct *vma,
>   				unsigned long addr, int avoid_reserve);
>   struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -				nodemask_t *nmask, gfp_t gfp_mask);
> +				nodemask_t *nmask, gfp_t gfp_mask,
> +				bool temporary);
>   struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>   				unsigned long address);
>   int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
> @@ -1003,7 +1004,7 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
>   
>   static inline struct page *
>   alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -			nodemask_t *nmask, gfp_t gfp_mask)
> +			nodemask_t *nmask, gfp_t gfp_mask, bool temporary)
>   {
>   	return NULL;
>   }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8bcaf66defc5..19de8ae79ec8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2308,8 +2308,11 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>   
>   /* page migration callback function */
>   struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -		nodemask_t *nmask, gfp_t gfp_mask)
> +		nodemask_t *nmask, gfp_t gfp_mask, bool temporary)
>   {
> +	if (temporary)
> +		goto temporary_alloc;
> +
>   	spin_lock_irq(&hugetlb_lock);
>   	if (h->free_huge_pages - h->resv_huge_pages > 0) {
>   		struct page *page;
> @@ -2322,6 +2325,11 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>   	}
>   	spin_unlock_irq(&hugetlb_lock);
>   
> +temporary_alloc:
> +	/*
> +	 * Try to allocate a fresh page that with special HPageTemporary
> +	 * characteristics
> +	 */
>   	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
>   }
>   
> @@ -2337,7 +2345,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>   
>   	gfp_mask = htlb_alloc_mask(h);
>   	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> -	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
> +	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask, false);
>   	mpol_cond_put(mpol);
>   
>   	return page;
> diff --git a/mm/internal.h b/mm/internal.h
> index b3002e03c28f..3ebf8885e24f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -800,6 +800,7 @@ struct migration_target_control {
>   	int nid;		/* preferred node id */
>   	nodemask_t *nmask;
>   	gfp_t gfp_mask;
> +	bool alloc_contig;	/* alloc_contig_range allocation */
>   };
>   
>   /*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c228afba0963..6505ba2070d7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1610,7 +1610,8 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>   		struct hstate *h = page_hstate(&folio->page);
>   
>   		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
> -		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
> +		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask,
> +						mtc->alloc_contig);
>   	}
>   
>   	if (folio_test_large(folio)) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d7b20bf09c1c..2b8a5a2b51cd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9166,6 +9166,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
>   	struct migration_target_control mtc = {
>   		.nid = zone_to_nid(cc->zone),
>   		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +		.alloc_contig = true,
>   	};
>   
>   	lru_cache_disable();
I believe I exposed alloc_migrate_huge_page() and conditionally invoked 
it from alloc_migration_target() when in alloc_contig, which is roughly 
equivalent. I didn't consider modifying the mtc to pass the information 
so my logic in alloc_migration_target() was a little kludgy.

Like I said, this can be made to work and I'm happy to accept an 
alternative if others agree. I think the isolation test of patch 3 is 
also still desirable.

Thanks again!
-Doug
