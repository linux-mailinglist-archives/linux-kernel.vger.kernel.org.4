Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B61632255
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKUMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKUMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:36:48 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C012FC15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:36:46 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 28D5B32007F9;
        Mon, 21 Nov 2022 07:36:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Nov 2022 07:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669034203; x=1669120603; bh=qE
        lVVyVGBcNBBakC+Z6BuAwD1KU3PdBT/gP1ojHY2qM=; b=DPw5104AHXPQ9TIAQL
        b4kELz2h9XHviOeZEsUP7tryw5VPpVcSO4DCS7OPa2skectZs28x2SzF7HIfzl6s
        yNKjgEx0y8ngBz3is0/0L34i+pjNvZUEayJNIRMhXLzPkJw131iE5nf5/w9G3mdX
        K5kMdSFVvYr8F3bkXLeXkMmuCAcX6dULq5HM7wwk6nCw+PUov3yIhx2lML7tIcPy
        Atr28ipyGlSkjapaW0EMgZ+op4BaPF1Y+Reu+Te2cJa6t06tsFKfXuUQtDnCfdKU
        jW7dSxndsxVUbUljiiusGfBrtSWATOY383Nd+uKw5bGjMpIPjwB4wVHQAPiWZ0Dw
        h6Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669034203; x=1669120603; bh=qElVVyVGBcNBBakC+Z6BuAwD1KU3
        PdBT/gP1ojHY2qM=; b=gEj4+KSSbVTIx9++mONw2exmxJ+LOVz/L8S4BPZX9wzP
        Lxo5hHMmgHJL/EG4/qmkbO/agRBMk+YOU2dQpgTwlpg2Q8I7w/m5TIq7eD/7VZCr
        bf3hqEE0ot4tM0Yx1BfYUqocvvb9zYhwnBtWgBM7n+ks0oWtO62BQp0KZBuA5ZLO
        F36MmhCeD3Rb4/dBaQiRRKoxE+LTobahpL9d5wIn0rO7/mn7nkWdt3CGKhNsPgSx
        VNXNHsd/Mra4aMjtBbS0gXKWEcWfjfMsiNybbOrVB3iH50NDMaJo5B1eqW28QGhT
        /0A23C8fmNdX833KzzAYOQ605Fx29/FbqhxllbmlKQ==
X-ME-Sender: <xms:2nB7Y3jH3QpB2BczFYQIXS6GsevKifbB8DaIL8Q_CF2WFi_ezJAatA>
    <xme:2nB7Y0DaORxcfjC3ut1JOMqR09hFOaBL7Dy_aZPTVxfD8X6lvIwTMxOFO5lNd3Paw
    Ry8UaRG8JUjPeoT8WY>
X-ME-Received: <xmr:2nB7Y3HFF6njVOSv02dnt0D8k-cIWAduLV6EmTIo-jwjOhH98aNshlumqijzfAT1lXfPvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:2nB7Y0QDkqF1AmybFtVIt15ZWetNR-VpZgzn0l6yhhicdNrKpzvd5Q>
    <xmx:2nB7Y0xADjGAg0kmdW_Ysb-xHXViXqjhLe1u-Bvm0pnp61ku3ikiQQ>
    <xmx:2nB7Y65EzF8lLkKlMNI1ZvLOpP0kPAuyZN28Y5pypBpI8yXJmHCGFg>
    <xmx:23B7Y1rIrul6JQpeWv0gcbqaz6l2E6BK1mEVCv-JZLyvI_Qk4WZF1A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 07:36:42 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7690F109A30; Mon, 21 Nov 2022 15:36:38 +0300 (+03)
Date:   Mon, 21 Nov 2022 15:36:38 +0300
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
Subject: Re: [PATCH 1/3] mm,thp,rmap: subpages_mapcount of PTE-mapped subpages
Message-ID: <20221121123638.4mp22wjmxz4gzhfz@box.shutemov.name>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <78fa518-85b5-32c0-ee92-537fa46131f6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fa518-85b5-32c0-ee92-537fa46131f6@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:12:03AM -0800, Hugh Dickins wrote:
> Following suggestion from Linus, instead of counting every PTE map of a
> compound page in subpages_mapcount, just count how many of its subpages
> are PTE-mapped: this yields the exact number needed for NR_ANON_MAPPED
> and NR_FILE_MAPPED stats, without any need for a locked scan of subpages;
> and requires updating the count less often.
> 
> This does then revert total_mapcount() and folio_mapcount() to needing a
> scan of subpages; but they are inherently racy, and need no locking, so
> Linus is right that the scans are much better done there.  Plus (unlike
> in 6.1 and previous) subpages_mapcount lets us avoid the scan in the
> common case of no PTE maps.  And page_mapped() and folio_mapped() remain
> scanless and just as efficient with the new meaning of subpages_mapcount:
> those are the functions which I most wanted to remove the scan from.
> 
> The updated page_dup_compound_rmap() is no longer suitable for use by
> anon THP's __split_huge_pmd_locked(); but page_add_anon_rmap() can be
> used for that, so long as its VM_BUG_ON_PAGE(!PageLocked) is deleted.
> 
> Evidence is that this way goes slightly faster than the previous
> implementation for most cases; but significantly faster in the (now
> scanless) pmds after ptes case, which started out at 870ms and was
> brought down to 495ms by the previous series, now takes around 105ms.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Few minor nitpicks below.

> ---
>  Documentation/mm/transhuge.rst |   3 +-
>  include/linux/mm.h             |  52 ++++++-----
>  include/linux/rmap.h           |   8 +-
>  mm/huge_memory.c               |   2 +-
>  mm/rmap.c                      | 155 ++++++++++++++-------------------
>  5 files changed, 103 insertions(+), 117 deletions(-)
> 
> diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
> index 1e2a637cc607..af4c9d70321d 100644
> --- a/Documentation/mm/transhuge.rst
> +++ b/Documentation/mm/transhuge.rst
> @@ -122,7 +122,8 @@ pages:
>  
>    - map/unmap of sub-pages with PTE entry increment/decrement ->_mapcount
>      on relevant sub-page of the compound page, and also increment/decrement
> -    ->subpages_mapcount, stored in first tail page of the compound page.
> +    ->subpages_mapcount, stored in first tail page of the compound page, when
> +    _mapcount goes from -1 to 0 or 0 to -1: counting sub-pages mapped by PTE.
>      In order to have race-free accounting of sub-pages mapped, changes to
>      sub-page ->_mapcount, ->subpages_mapcount and ->compound_mapcount are
>      are all locked by bit_spin_lock of PG_locked in the first tail ->flags.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8fe6276d8cc2..c9e46d4d46f2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -828,7 +828,7 @@ static inline int head_compound_mapcount(struct page *head)
>  }
>  
>  /*
> - * Sum of mapcounts of sub-pages, does not include compound mapcount.
> + * Number of sub-pages mapped by PTE, does not include compound mapcount.
>   * Must be called only on head of compound page.
>   */
>  static inline int head_subpages_mapcount(struct page *head)
> @@ -864,23 +864,7 @@ static inline int page_mapcount(struct page *page)
>  	return head_compound_mapcount(page) + mapcount;
>  }
>  
> -static inline int total_mapcount(struct page *page)
> -{
> -	if (likely(!PageCompound(page)))
> -		return atomic_read(&page->_mapcount) + 1;
> -	page = compound_head(page);
> -	return head_compound_mapcount(page) + head_subpages_mapcount(page);
> -}
> -
> -/*
> - * Return true if this page is mapped into pagetables.
> - * For compound page it returns true if any subpage of compound page is mapped,
> - * even if this particular subpage is not itself mapped by any PTE or PMD.
> - */
> -static inline bool page_mapped(struct page *page)
> -{
> -	return total_mapcount(page) > 0;
> -}
> +int total_compound_mapcount(struct page *head);
>  
>  /**
>   * folio_mapcount() - Calculate the number of mappings of this folio.
> @@ -897,8 +881,20 @@ static inline int folio_mapcount(struct folio *folio)
>  {
>  	if (likely(!folio_test_large(folio)))
>  		return atomic_read(&folio->_mapcount) + 1;
> -	return atomic_read(folio_mapcount_ptr(folio)) + 1 +
> -		atomic_read(folio_subpages_mapcount_ptr(folio));
> +	return total_compound_mapcount(&folio->page);
> +}
> +
> +static inline int total_mapcount(struct page *page)
> +{
> +	if (likely(!PageCompound(page)))
> +		return atomic_read(&page->_mapcount) + 1;
> +	return total_compound_mapcount(compound_head(page));
> +}
> +
> +static inline bool folio_large_is_mapped(struct folio *folio)
> +{
> +	return atomic_read(folio_mapcount_ptr(folio)) +
> +		atomic_read(folio_subpages_mapcount_ptr(folio)) >= 0;
>  }
>  
>  /**
> @@ -909,7 +905,21 @@ static inline int folio_mapcount(struct folio *folio)
>   */
>  static inline bool folio_mapped(struct folio *folio)
>  {
> -	return folio_mapcount(folio) > 0;
> +	if (likely(!folio_test_large(folio)))
> +		return atomic_read(&folio->_mapcount) >= 0;
> +	return folio_large_is_mapped(folio);
> +}
> +
> +/*
> + * Return true if this page is mapped into pagetables.
> + * For compound page it returns true if any sub-page of compound page is mapped,
> + * even if this particular sub-page is not itself mapped by any PTE or PMD.
> + */
> +static inline bool page_mapped(struct page *page)
> +{
> +	if (likely(!PageCompound(page)))
> +		return atomic_read(&page->_mapcount) >= 0;
> +	return folio_large_is_mapped(page_folio(page));
>  }
>  
>  static inline struct page *virt_to_head_page(const void *x)
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 011a7530dc76..860f558126ac 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -204,14 +204,14 @@ void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>  void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address);
>  
> -void page_dup_compound_rmap(struct page *page, bool compound);
> +void page_dup_compound_rmap(struct page *page);
>  
>  static inline void page_dup_file_rmap(struct page *page, bool compound)
>  {
> -	if (PageCompound(page))
> -		page_dup_compound_rmap(page, compound);
> -	else
> +	if (likely(!compound /* page is mapped by PTE */))

I'm not a fan of this kind of comments.

Maybe move above the line (here and below)?

>  		atomic_inc(&page->_mapcount);
> +	else
> +		page_dup_compound_rmap(page);
>  }
>  
>  /**
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 30056efc79ad..3dee8665c585 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2215,7 +2215,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		BUG_ON(!pte_none(*pte));
>  		set_pte_at(mm, addr, pte, entry);
>  		if (!pmd_migration)
> -			page_dup_compound_rmap(page + i, false);
> +			page_add_anon_rmap(page + i, vma, addr, false);
>  		pte_unmap(pte);
>  	}
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4833d28c5e1a..66be8cae640f 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1117,55 +1117,36 @@ static void unlock_compound_mapcounts(struct page *head,
>  	bit_spin_unlock(PG_locked, &head[1].flags);
>  }
>  
> -/*
> - * When acting on a compound page under lock_compound_mapcounts(), avoid the
> - * unnecessary overhead of an actual atomic operation on its subpage mapcount.
> - * Return true if this is the first increment or the last decrement
> - * (remembering that page->_mapcount -1 represents logical mapcount 0).
> - */
> -static bool subpage_mapcount_inc(struct page *page)
> -{
> -	int orig_mapcount = atomic_read(&page->_mapcount);
> -
> -	atomic_set(&page->_mapcount, orig_mapcount + 1);
> -	return orig_mapcount < 0;
> -}
> -
> -static bool subpage_mapcount_dec(struct page *page)
> -{
> -	int orig_mapcount = atomic_read(&page->_mapcount);
> -
> -	atomic_set(&page->_mapcount, orig_mapcount - 1);
> -	return orig_mapcount == 0;
> -}
> -
> -/*
> - * When mapping a THP's first pmd, or unmapping its last pmd, if that THP
> - * also has pte mappings, then those must be discounted: in order to maintain
> - * NR_ANON_MAPPED and NR_FILE_MAPPED statistics exactly, without any drift,
> - * and to decide when an anon THP should be put on the deferred split queue.
> - * This function must be called between lock_ and unlock_compound_mapcounts().
> - */
> -static int nr_subpages_unmapped(struct page *head, int nr_subpages)
> +int total_compound_mapcount(struct page *head)
>  {
> -	int nr = nr_subpages;
> +	int mapcount = head_compound_mapcount(head);
> +	int nr_subpages;
>  	int i;
>  
> -	/* Discount those subpages mapped by pte */
> +	/* In the common case, avoid the loop when no subpages mapped by PTE */
> +	if (head_subpages_mapcount(head) == 0)
> +		return mapcount;
> +	/*
> +	 * Add all the PTE mappings of those subpages mapped by PTE.
> +	 * Limit the loop, knowing that only subpages_mapcount are mapped?
> +	 * Perhaps: given all the raciness, that may be a good or a bad idea.
> +	 */
> +	nr_subpages = thp_nr_pages(head);
>  	for (i = 0; i < nr_subpages; i++)
> -		if (atomic_read(&head[i]._mapcount) >= 0)
> -			nr--;
> -	return nr;
> +		mapcount += atomic_read(&head[i]._mapcount);
> +
> +	/* But each of those _mapcounts was based on -1 */
> +	mapcount += nr_subpages;
> +	return mapcount;
>  }
>  
>  /*
> - * page_dup_compound_rmap(), used when copying mm, or when splitting pmd,
> + * page_dup_compound_rmap(), used when copying mm,
>   * provides a simple example of using lock_ and unlock_compound_mapcounts().
>   */
> -void page_dup_compound_rmap(struct page *page, bool compound)
> +void page_dup_compound_rmap(struct page *head)
>  {
>  	struct compound_mapcounts mapcounts;
> -	struct page *head;
>  
>  	/*
>  	 * Hugetlb pages could use lock_compound_mapcounts(), like THPs do;
> @@ -1176,20 +1157,16 @@ void page_dup_compound_rmap(struct page *page, bool compound)
>  	 * Note that hugetlb does not call page_add_file_rmap():
>  	 * here is where hugetlb shared page mapcount is raised.
>  	 */
> -	if (PageHuge(page)) {
> -		atomic_inc(compound_mapcount_ptr(page));
> -		return;
> -	}
> +	if (PageHuge(head)) {
> +		atomic_inc(compound_mapcount_ptr(head));
>  

Remove the newline?

> -	head = compound_head(page);
> -	lock_compound_mapcounts(head, &mapcounts);
> -	if (compound) {
> +	} else if (PageTransHuge(head)) {
> +		/* That test is redundant: it's for safety or to optimize out */
> +
> +		lock_compound_mapcounts(head, &mapcounts);
>  		mapcounts.compound_mapcount++;
> -	} else {
> -		mapcounts.subpages_mapcount++;
> -		subpage_mapcount_inc(page);
> +		unlock_compound_mapcounts(head, &mapcounts);
>  	}
> -	unlock_compound_mapcounts(head, &mapcounts);
>  }
>  
>  /**
> @@ -1308,31 +1285,29 @@ void page_add_anon_rmap(struct page *page,
>  
>  	if (unlikely(PageKsm(page)))
>  		lock_page_memcg(page);
> -	else
> -		VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
> -	if (likely(!PageCompound(page))) {
> +	if (likely(!compound /* page is mapped by PTE */)) {
>  		first = atomic_inc_and_test(&page->_mapcount);
>  		nr = first;
> +		if (first && PageCompound(page)) {
> +			struct page *head = compound_head(page);
> +
> +			lock_compound_mapcounts(head, &mapcounts);
> +			mapcounts.subpages_mapcount++;
> +			nr = !mapcounts.compound_mapcount;
> +			unlock_compound_mapcounts(head, &mapcounts);
> +		}
> +	} else if (PageTransHuge(page)) {
> +		/* That test is redundant: it's for safety or to optimize out */
>  
> -	} else if (compound && PageTransHuge(page)) {
>  		lock_compound_mapcounts(page, &mapcounts);
>  		first = !mapcounts.compound_mapcount;
>  		mapcounts.compound_mapcount++;
>  		if (first) {
> -			nr = nr_pmdmapped = thp_nr_pages(page);
> -			if (mapcounts.subpages_mapcount)
> -				nr = nr_subpages_unmapped(page, nr_pmdmapped);
> +			nr_pmdmapped = thp_nr_pages(page);
> +			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
>  		}
>  		unlock_compound_mapcounts(page, &mapcounts);
> -	} else {
> -		struct page *head = compound_head(page);
> -
> -		lock_compound_mapcounts(head, &mapcounts);
> -		mapcounts.subpages_mapcount++;
> -		first = subpage_mapcount_inc(page);
> -		nr = first && !mapcounts.compound_mapcount;
> -		unlock_compound_mapcounts(head, &mapcounts);
>  	}
>  
>  	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> @@ -1411,28 +1386,28 @@ void page_add_file_rmap(struct page *page,
>  	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
>  	lock_page_memcg(page);
>  
> -	if (likely(!PageCompound(page))) {
> +	if (likely(!compound /* page is mapped by PTE */)) {
>  		first = atomic_inc_and_test(&page->_mapcount);
>  		nr = first;
> +		if (first && PageCompound(page)) {
> +			struct page *head = compound_head(page);
> +
> +			lock_compound_mapcounts(head, &mapcounts);
> +			mapcounts.subpages_mapcount++;
> +			nr = !mapcounts.compound_mapcount;
> +			unlock_compound_mapcounts(head, &mapcounts);
> +		}
> +	} else if (PageTransHuge(page)) {
> +		/* That test is redundant: it's for safety or to optimize out */
>  
> -	} else if (compound && PageTransHuge(page)) {
>  		lock_compound_mapcounts(page, &mapcounts);
>  		first = !mapcounts.compound_mapcount;
>  		mapcounts.compound_mapcount++;
>  		if (first) {
> -			nr = nr_pmdmapped = thp_nr_pages(page);
> -			if (mapcounts.subpages_mapcount)
> -				nr = nr_subpages_unmapped(page, nr_pmdmapped);
> +			nr_pmdmapped = thp_nr_pages(page);
> +			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
>  		}
>  		unlock_compound_mapcounts(page, &mapcounts);
> -	} else {
> -		struct page *head = compound_head(page);
> -
> -		lock_compound_mapcounts(head, &mapcounts);
> -		mapcounts.subpages_mapcount++;
> -		first = subpage_mapcount_inc(page);
> -		nr = first && !mapcounts.compound_mapcount;
> -		unlock_compound_mapcounts(head, &mapcounts);
>  	}
>  
>  	if (nr_pmdmapped)
> @@ -1472,28 +1447,28 @@ void page_remove_rmap(struct page *page,
>  	lock_page_memcg(page);
>  
>  	/* page still mapped by someone else? */
> -	if (likely(!PageCompound(page))) {
> +	if (likely(!compound /* page is mapped by PTE */)) {
>  		last = atomic_add_negative(-1, &page->_mapcount);
>  		nr = last;
> +		if (last && PageCompound(page)) {
> +			struct page *head = compound_head(page);
> +
> +			lock_compound_mapcounts(head, &mapcounts);
> +			mapcounts.subpages_mapcount--;
> +			nr = !mapcounts.compound_mapcount;
> +			unlock_compound_mapcounts(head, &mapcounts);
> +		}
> +	} else if (PageTransHuge(page)) {
> +		/* That test is redundant: it's for safety or to optimize out */
>  
> -	} else if (compound && PageTransHuge(page)) {
>  		lock_compound_mapcounts(page, &mapcounts);
>  		mapcounts.compound_mapcount--;
>  		last = !mapcounts.compound_mapcount;
>  		if (last) {
> -			nr = nr_pmdmapped = thp_nr_pages(page);
> -			if (mapcounts.subpages_mapcount)
> -				nr = nr_subpages_unmapped(page, nr_pmdmapped);
> +			nr_pmdmapped = thp_nr_pages(page);
> +			nr = nr_pmdmapped - mapcounts.subpages_mapcount;
>  		}
>  		unlock_compound_mapcounts(page, &mapcounts);
> -	} else {
> -		struct page *head = compound_head(page);
> -
> -		lock_compound_mapcounts(head, &mapcounts);
> -		mapcounts.subpages_mapcount--;
> -		last = subpage_mapcount_dec(page);
> -		nr = last && !mapcounts.compound_mapcount;
> -		unlock_compound_mapcounts(head, &mapcounts);
>  	}
>  
>  	if (nr_pmdmapped) {
> -- 
> 2.35.3
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
