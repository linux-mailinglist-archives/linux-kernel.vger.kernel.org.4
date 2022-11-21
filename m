Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B663232C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKUNJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKUNJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:09:08 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3DC750
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:09:07 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3E5423200951;
        Mon, 21 Nov 2022 08:09:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Nov 2022 08:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669036144; x=1669122544; bh=8C
        K6mbAzL7BYMc/3HTWRDcsL2sQNk4XQ1DpZK1qbm10=; b=Du0EV12Ng71IqMrcyd
        2yBGVwUTWckAcMO3cIeC2ThmXY8E0u2plGMo6Bq9r0IMi8Ae0+f2Drj0TaFsLtai
        +0xdkyd9T5Pxl+YeMYYYJ6zYMmo43eSnG49Q/dCpoEmT/O07k7Pdk6I4riKLYF4f
        B1PqX6jbDMAphxWICBSb/Aeqf82SVjnxyVOYpDNl2X02hchvwRojxzvk2RH6oDw+
        4TtCyZAIWrxZ3gCj6t39TuKyzJQy+llLSocevMjVulLDXhSQk6X8fpw3OpZ7D/fv
        QhV4CvBAov9F4QriDrgd6YrgxnpjZhwSE2UtlOd1IM8978eJ0HcJ1zDjcVLHYzt0
        wO8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669036144; x=1669122544; bh=8CK6mbAzL7BYMc/3HTWRDcsL2sQN
        k4XQ1DpZK1qbm10=; b=fjIrWzQjn32lVDd0TOGUCm7jDW0rzrk7wfBK7KDT7+2F
        kqr2uJW6s6R8SgrJMnqNyJubqQnEX+VQ/24EB8rIgsESDFpwuVEpNumyIdiDI4FJ
        LzRp+faXc6/zDWbd+GA+SV/VefdNX6fMZtkySgDxxVAwpyz8m+a/cSaP0pkM1neA
        D1lNp+FS00PhdQUaBXEIQFx6p7bQPrc1zhhCwmLN7radk6okT3inIIPUVrcgXmT6
        Q+UmdfrH5ERkvH17IXnL2LIFucczHRLkGdVJtV7dt2oDEmcRSS2wlRPSG/HBIxD2
        fJt+lv0VBem4in9PBzTWGQppoj5tGRy0SE+c9tiIdA==
X-ME-Sender: <xms:b3h7Y4wlw_3tdLApXJOPUvdxiLEGeXW6iRsknfyIeDQ9HFBDDdvbKA>
    <xme:b3h7Y8Tg2KyNDVf-sq1nbeOQHGEzN80BmBADWbV0GGSZcjeXNxpicy5xPTbqdmlCP
    aZP2eHWngb--_yPeMY>
X-ME-Received: <xmr:b3h7Y6UjWJZw0cDWEhaEmatzEITR0ScXWonYBJ75k5nHv1KS1mtkeSEWrj6i-LIgYG4I5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:b3h7Y2jXjGoMmd49xEVw0aUjyMTFqW-C3E7cAY83wUzLclWCTzNuJw>
    <xmx:b3h7Y6DroufbaNVWfUjnOzN8RsvUmB2VlnsTfQUKVXHpvCV-jDLUEw>
    <xmx:b3h7Y3Kvdng0n4XlKLbhUvd8ba8ykpfTXU-FL2uNmadrMmtsfz9OdQ>
    <xmx:cHh7Yy4nyiicclpwd1MMVL4NHLN1W3FfOhO9g1WyFayAeAS5tFyuVQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 08:09:02 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6DCEF109A30; Mon, 21 Nov 2022 16:09:00 +0300 (+03)
Date:   Mon, 21 Nov 2022 16:09:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if
 PMD-mapped
Message-ID: <20221121130900.xb224cesbzfptldo@box.shutemov.name>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <25a09a7a-81a9-e9c2-7567-c94ce18ac2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a09a7a-81a9-e9c2-7567-c94ce18ac2@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:14:17AM -0800, Hugh Dickins wrote:
> Can the lock_compound_mapcount() bit_spin_lock apparatus be removed now?
> Yes.  Not by atomic64_t or cmpxchg games, those get difficult on 32-bit;
> but if we slightly abuse subpages_mapcount by additionally demanding that
> one bit be set there when the compound page is PMD-mapped, then a cascade
> of two atomic ops is able to maintain the stats without bit_spin_lock.

Yay! New home for PageDoubleMap()! :P

> This is harder to reason about than when bit_spin_locked, but I believe
> safe; and no drift in stats detected when testing.  When there are racing
> removes and adds, of course the sequence of operations is less well-
> defined; but each operation on subpages_mapcount is atomically good.
> What might be disastrous, is if subpages_mapcount could ever fleetingly
> appear negative: but the pte lock (or pmd lock) these rmap functions are
> called under, ensures that a last remove cannot race ahead of a first add.
> 
> Continue to make an exception for hugetlb (PageHuge) pages, though that
> exception can be easily removed by a further commit if necessary: leave
> subpages_mapcount 0, don't bother with COMPOUND_MAPPED in its case, just
> carry on checking compound_mapcount too in folio_mapped(), page_mapped().
> 
> Evidence is that this way goes slightly faster than the previous
> implementation in all cases (pmds after ptes now taking around 103ms);
> and relieves us of worrying about contention on the bit_spin_lock.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Jokes aside, looks neat.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

As always few minor nits below.

> ---
>  Documentation/mm/transhuge.rst |   7 +-
>  include/linux/mm.h             |  19 ++++-
>  include/linux/rmap.h           |  12 ++--
>  mm/debug.c                     |   2 +-
>  mm/rmap.c                      | 124 +++++++--------------------------
>  5 files changed, 52 insertions(+), 112 deletions(-)
> 
> diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
> index af4c9d70321d..ec3dc5b04226 100644
> --- a/Documentation/mm/transhuge.rst
> +++ b/Documentation/mm/transhuge.rst
> @@ -118,15 +118,14 @@ pages:
>      succeeds on tail pages.
>  
>    - map/unmap of PMD entry for the whole compound page increment/decrement
> -    ->compound_mapcount, stored in the first tail page of the compound page.
> +    ->compound_mapcount, stored in the first tail page of the compound page;
> +    and also increment/decrement ->subpages_mapcount (also in the first tail)
> +    by COMPOUND_MAPPED when compound_mapcount goes from -1 to 0 or 0 to -1.
>  
>    - map/unmap of sub-pages with PTE entry increment/decrement ->_mapcount
>      on relevant sub-page of the compound page, and also increment/decrement
>      ->subpages_mapcount, stored in first tail page of the compound page, when
>      _mapcount goes from -1 to 0 or 0 to -1: counting sub-pages mapped by PTE.
> -    In order to have race-free accounting of sub-pages mapped, changes to
> -    sub-page ->_mapcount, ->subpages_mapcount and ->compound_mapcount are
> -    are all locked by bit_spin_lock of PG_locked in the first tail ->flags.
>  
>  split_huge_page internally has to distribute the refcounts in the head
>  page to the tail pages before clearing all PG_head/tail bits from the page
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c9e46d4d46f2..a2bfb5e4be62 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -828,7 +828,16 @@ static inline int head_compound_mapcount(struct page *head)
>  }
>  
>  /*
> - * Number of sub-pages mapped by PTE, does not include compound mapcount.
> + * If a 16GB hugetlb page were mapped by PTEs of all of its 4kB sub-pages,
> + * its subpages_mapcount would be 0x400000: choose the COMPOUND_MAPPED bit
> + * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).  Hugetlb currently
> + * leaves subpages_mapcount at 0, but avoid surprise if it participates later.
> + */
> +#define COMPOUND_MAPPED	0x800000
> +#define SUBPAGES_MAPPED	(COMPOUND_MAPPED - 1)
> +
> +/*
> + * Number of sub-pages mapped by PTE, plus COMPOUND_MAPPED if compound mapped.
>   * Must be called only on head of compound page.
>   */
>  static inline int head_subpages_mapcount(struct page *head)
> @@ -893,8 +902,12 @@ static inline int total_mapcount(struct page *page)
>  
>  static inline bool folio_large_is_mapped(struct folio *folio)
>  {
> -	return atomic_read(folio_mapcount_ptr(folio)) +
> -		atomic_read(folio_subpages_mapcount_ptr(folio)) >= 0;
> +	/*
> +	 * Reading folio_mapcount_ptr() below could be omitted if hugetlb
> +	 * participated in incrementing subpages_mapcount when compound mapped.
> +	 */
> +	return atomic_read(folio_mapcount_ptr(folio)) >= 0 ||
> +		atomic_read(folio_subpages_mapcount_ptr(folio)) > 0;

Maybe check folio_subpages_mapcount_ptr() first? It would avoid
folio_mapcount_ptr() read for everything, but hugetlb.

>  }
>  
>  /**
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 860f558126ac..bd3504d11b15 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -204,14 +204,14 @@ void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>  void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address);
>  
> -void page_dup_compound_rmap(struct page *page);
> +static inline void __page_dup_rmap(struct page *page, bool compound)
> +{
> +	atomic_inc(compound ? compound_mapcount_ptr(page) : &page->_mapcount);
> +}
>  
>  static inline void page_dup_file_rmap(struct page *page, bool compound)
>  {
> -	if (likely(!compound /* page is mapped by PTE */))
> -		atomic_inc(&page->_mapcount);
> -	else
> -		page_dup_compound_rmap(page);
> +	__page_dup_rmap(page, compound);
>  }
>  
>  /**
> @@ -260,7 +260,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>  	 * the page R/O into both processes.
>  	 */
>  dup:
> -	page_dup_file_rmap(page, compound);
> +	__page_dup_rmap(page, compound);
>  	return 0;
>  }
>  
> diff --git a/mm/debug.c b/mm/debug.c
> index 7f8e5f744e42..1ef2ff6a05cb 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -97,7 +97,7 @@ static void __dump_page(struct page *page)
>  		pr_warn("head:%p order:%u compound_mapcount:%d subpages_mapcount:%d compound_pincount:%d\n",
>  				head, compound_order(head),
>  				head_compound_mapcount(head),
> -				head_subpages_mapcount(head),
> +				head_subpages_mapcount(head) & SUBPAGES_MAPPED,

Looks like applying the SUBPAGES_MAPPED mask belong to the
head_subpages_mapcount() helper, not to the caller.

>  				head_compound_pincount(head));
>  	}
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 66be8cae640f..5e4ce0a6d6f1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1085,38 +1085,6 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
>  	return page_vma_mkclean_one(&pvmw);
>  }
>  
> -struct compound_mapcounts {
> -	unsigned int compound_mapcount;
> -	unsigned int subpages_mapcount;
> -};
> -
> -/*
> - * lock_compound_mapcounts() first locks, then copies subpages_mapcount and
> - * compound_mapcount from head[1].compound_mapcount and subpages_mapcount,
> - * converting from struct page's internal representation to logical count
> - * (that is, adding 1 to compound_mapcount to hide its offset by -1).
> - */
> -static void lock_compound_mapcounts(struct page *head,
> -		struct compound_mapcounts *local)
> -{
> -	bit_spin_lock(PG_locked, &head[1].flags);
> -	local->compound_mapcount = atomic_read(compound_mapcount_ptr(head)) + 1;
> -	local->subpages_mapcount = atomic_read(subpages_mapcount_ptr(head));
> -}
> -
> -/*
> - * After caller has updated subpage._mapcount, local subpages_mapcount and
> - * local compound_mapcount, as necessary, unlock_compound_mapcounts() converts
> - * and copies them back to the compound head[1] fields, and then unlocks.
> - */
> -static void unlock_compound_mapcounts(struct page *head,
> -		struct compound_mapcounts *local)
> -{
> -	atomic_set(compound_mapcount_ptr(head), local->compound_mapcount - 1);
> -	atomic_set(subpages_mapcount_ptr(head), local->subpages_mapcount);
> -	bit_spin_unlock(PG_locked, &head[1].flags);
> -}
> -
>  int total_compound_mapcount(struct page *head)
>  {
>  	int mapcount = head_compound_mapcount(head);
> @@ -1124,7 +1092,7 @@ int total_compound_mapcount(struct page *head)
>  	int i;
>  
>  	/* In the common case, avoid the loop when no subpages mapped by PTE */
> -	if (head_subpages_mapcount(head) == 0)
> +	if ((head_subpages_mapcount(head) & SUBPAGES_MAPPED) == 0)
>  		return mapcount;
>  	/*
>  	 * Add all the PTE mappings of those subpages mapped by PTE.
> @@ -1140,35 +1108,6 @@ int total_compound_mapcount(struct page *head)
>  	return mapcount;
>  }
>  
> -/*
> - * page_dup_compound_rmap(), used when copying mm,
> - * provides a simple example of using lock_ and unlock_compound_mapcounts().
> - */
> -void page_dup_compound_rmap(struct page *head)
> -{
> -	struct compound_mapcounts mapcounts;
> -
> -	/*
> -	 * Hugetlb pages could use lock_compound_mapcounts(), like THPs do;
> -	 * but at present they are still being managed by atomic operations:
> -	 * which are likely to be somewhat faster, so don't rush to convert
> -	 * them over without evaluating the effect.
> -	 *
> -	 * Note that hugetlb does not call page_add_file_rmap():
> -	 * here is where hugetlb shared page mapcount is raised.
> -	 */
> -	if (PageHuge(head)) {
> -		atomic_inc(compound_mapcount_ptr(head));
> -
> -	} else if (PageTransHuge(head)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> -
> -		lock_compound_mapcounts(head, &mapcounts);
> -		mapcounts.compound_mapcount++;
> -		unlock_compound_mapcounts(head, &mapcounts);
> -	}
> -}
> -
>  /**
>   * page_move_anon_rmap - move a page to our anon_vma
>   * @page:	the page to move to our anon_vma
> @@ -1278,7 +1217,7 @@ static void __page_check_anon_rmap(struct page *page,
>  void page_add_anon_rmap(struct page *page,
>  	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
>  {
> -	struct compound_mapcounts mapcounts;
> +	atomic_t *mapped;
>  	int nr = 0, nr_pmdmapped = 0;
>  	bool compound = flags & RMAP_COMPOUND;
>  	bool first;
> @@ -1290,24 +1229,20 @@ void page_add_anon_rmap(struct page *page,
>  		first = atomic_inc_and_test(&page->_mapcount);
>  		nr = first;
>  		if (first && PageCompound(page)) {
> -			struct page *head = compound_head(page);
> -
> -			lock_compound_mapcounts(head, &mapcounts);
> -			mapcounts.subpages_mapcount++;
> -			nr = !mapcounts.compound_mapcount;
> -			unlock_compound_mapcounts(head, &mapcounts);
> +			mapped = subpages_mapcount_ptr(compound_head(page));
> +			nr = atomic_inc_return_relaxed(mapped);
> +			nr = !(nr & COMPOUND_MAPPED);
>  		}
>  	} else if (PageTransHuge(page)) {
>  		/* That test is redundant: it's for safety or to optimize out */
>  
> -		lock_compound_mapcounts(page, &mapcounts);
> -		first = !mapcounts.compound_mapcount;
> -		mapcounts.compound_mapcount++;
> +		first = atomic_inc_and_test(compound_mapcount_ptr(page));
>  		if (first) {
> +			mapped = subpages_mapcount_ptr(page);
> +			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
>  			nr_pmdmapped = thp_nr_pages(page);
> -			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
> +			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
>  		}
> -		unlock_compound_mapcounts(page, &mapcounts);
>  	}
>  
>  	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> @@ -1360,6 +1295,7 @@ void page_add_new_anon_rmap(struct page *page,
>  		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
>  		/* increment count (starts at -1) */
>  		atomic_set(compound_mapcount_ptr(page), 0);
> +		atomic_set(subpages_mapcount_ptr(page), COMPOUND_MAPPED);
>  		nr = thp_nr_pages(page);
>  		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
>  	}
> @@ -1379,7 +1315,7 @@ void page_add_new_anon_rmap(struct page *page,
>  void page_add_file_rmap(struct page *page,
>  	struct vm_area_struct *vma, bool compound)
>  {
> -	struct compound_mapcounts mapcounts;
> +	atomic_t *mapped;
>  	int nr = 0, nr_pmdmapped = 0;
>  	bool first;
>  
> @@ -1390,24 +1326,20 @@ void page_add_file_rmap(struct page *page,
>  		first = atomic_inc_and_test(&page->_mapcount);
>  		nr = first;
>  		if (first && PageCompound(page)) {
> -			struct page *head = compound_head(page);
> -
> -			lock_compound_mapcounts(head, &mapcounts);
> -			mapcounts.subpages_mapcount++;
> -			nr = !mapcounts.compound_mapcount;
> -			unlock_compound_mapcounts(head, &mapcounts);
> +			mapped = subpages_mapcount_ptr(compound_head(page));
> +			nr = atomic_inc_return_relaxed(mapped);
> +			nr = !(nr & COMPOUND_MAPPED);
>  		}
>  	} else if (PageTransHuge(page)) {
>  		/* That test is redundant: it's for safety or to optimize out */
>  
> -		lock_compound_mapcounts(page, &mapcounts);
> -		first = !mapcounts.compound_mapcount;
> -		mapcounts.compound_mapcount++;
> +		first = atomic_inc_and_test(compound_mapcount_ptr(page));
>  		if (first) {
> +			mapped = subpages_mapcount_ptr(page);
> +			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
>  			nr_pmdmapped = thp_nr_pages(page);
> -			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
> +			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
>  		}
> -		unlock_compound_mapcounts(page, &mapcounts);
>  	}
>  
>  	if (nr_pmdmapped)
> @@ -1431,7 +1363,7 @@ void page_add_file_rmap(struct page *page,
>  void page_remove_rmap(struct page *page,
>  	struct vm_area_struct *vma, bool compound)
>  {
> -	struct compound_mapcounts mapcounts;
> +	atomic_t *mapped;
>  	int nr = 0, nr_pmdmapped = 0;
>  	bool last;
>  
> @@ -1451,24 +1383,20 @@ void page_remove_rmap(struct page *page,
>  		last = atomic_add_negative(-1, &page->_mapcount);
>  		nr = last;
>  		if (last && PageCompound(page)) {
> -			struct page *head = compound_head(page);
> -
> -			lock_compound_mapcounts(head, &mapcounts);
> -			mapcounts.subpages_mapcount--;
> -			nr = !mapcounts.compound_mapcount;
> -			unlock_compound_mapcounts(head, &mapcounts);
> +			mapped = subpages_mapcount_ptr(compound_head(page));
> +			nr = atomic_dec_return_relaxed(mapped);
> +			nr = !(nr & COMPOUND_MAPPED);
>  		}
>  	} else if (PageTransHuge(page)) {
>  		/* That test is redundant: it's for safety or to optimize out */
>  
> -		lock_compound_mapcounts(page, &mapcounts);
> -		mapcounts.compound_mapcount--;
> -		last = !mapcounts.compound_mapcount;
> +		last = atomic_add_negative(-1, compound_mapcount_ptr(page));
>  		if (last) {
> +			mapped = subpages_mapcount_ptr(page);
> +			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
>  			nr_pmdmapped = thp_nr_pages(page);
> -			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
> +			nr = nr_pmdmapped - (nr & SUBPAGES_MAPPED);
>  		}
> -		unlock_compound_mapcounts(page, &mapcounts);
>  	}
>  
>  	if (nr_pmdmapped) {
> -- 
> 2.35.3
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
