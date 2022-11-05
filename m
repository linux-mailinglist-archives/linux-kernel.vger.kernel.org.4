Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27261DDE7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKETvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKETvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:51:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A310571
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:51:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C42B5C00A6;
        Sat,  5 Nov 2022 15:51:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 05 Nov 2022 15:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667677879; x=1667764279; bh=Oo
        lEB8cwTU+D19Ary1jEoWj96aA/4SgZa+73Esw4OBQ=; b=BmH/hdycEoUmRs2MZv
        RwtQPWQL2UuAo5RkVP3z6EqzOqzx7t41JzmdrQ6phRcjbW7Dn7xMM52Vp3+gi4/s
        +CWKqDZ050zCPhlJadzZk2Vra6Tqbb9fHHkRs4MYoPfXHfnVm+qyoBxcbLj9AwhW
        hDQTjWLjZhQzcjNn1lnilLFeJLtUJlaIiP8ti0yMdadBkDFFlCDFyakbniTUDszk
        BBomiCv2hsy8SXyVgxcZ+POhDPrDFB8zzPq/j75RmKOq3mh/TYleCTgfwECD+rLP
        XDZXZZ7i/kEH28CwNI6j/asctdA4s3T2ESmvkOvpdlL4OOC+g9AuQKDQDs4fhW55
        5dbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667677879; x=1667764279; bh=OolEB8cwTU+D19Ary1jEoWj96aA/
        4SgZa+73Esw4OBQ=; b=Fr/8cZXDQtxEoK27SVk1O4QhMm7DPH9YnMRiB2IpJMEM
        DKHc62OPD++hYo74KtO6ngbv4ufXuj9/rdG9TRJ9Eebrwp+SsU6LFgy2R0eHUAf5
        BpiZBUm/8/lWvc4T4Y/VgLMkN4k1tpklyhbmzFFNh0K8IctkoZu+TkVMYe+5Qmyu
        UxQkGpaI+NkQCxicLD6ZS04hBQdeWQSagy4GF9IQF0JZCtkHKn32h0SWJ3QJ3pfz
        Q9dUXWX8MsRKU6G4p0zQ9cdhRp0zoc7f1ufvvjIQgHsTZ46aPmBqDapEry4k8TzG
        22nHjrve0VODY6U4rR+54JbX5LKGo3exddPrGQF5sg==
X-ME-Sender: <xms:tr5mY_oSmNFFtR1SDhUHNYVDE_cnRUzR3iwn4HUFlVDphj2yNmJa5Q>
    <xme:tr5mY5rMOnF4HitoFtiHn1BFTxnC6HR8DlKYtFxpyd9djOEFmYliCHr72ijK6h57M
    PTgaSZs4S67Ey3yWFM>
X-ME-Received: <xmr:tr5mY8PRMyu7b55KYL_FBtQJzlVn3IVnAcy1Rvdjcb4XP4vSG2mlz0GnPoAUFxWCHVHoFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepkedvvdejffehteegtddvgfeijeeivdegjeeiteej
    heeiheevffeukeefheffvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:tr5mYy7uLLLNNK3EE0b3AziRtHnga8F2l4JVYlq9d_zkeh-zw-2aFw>
    <xmx:tr5mY-6Byu3S0mFvXKRrlvW5eN0TGFZLqzu_saHl6Vobrs6isguN1w>
    <xmx:tr5mY6jCQ9xLCcUv9zvq-HCbYOawygMVkfN1PY2HQ1ytgVFFPfsMhA>
    <xmx:t75mY6oR4GP5KLiuASQnT3Eczlgr1BI6mDzTdLq2KKKKa3YTv4W5JQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 15:51:17 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E67B8104449; Sat,  5 Nov 2022 22:51:15 +0300 (+03)
Date:   Sat, 5 Nov 2022 22:51:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 2/3] mm,thp,rmap: simplify compound page mapcount handling
Message-ID: <20221105195115.2d5yvvepdjsqjmmv@box>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <47ad693-717-79c8-e1ba-46c3a6602e48@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ad693-717-79c8-e1ba-46c3a6602e48@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:51:38PM -0700, Hugh Dickins wrote:
> Compound page (folio) mapcount calculations have been different for
> anon and file (or shmem) THPs, and involved the obscure PageDoubleMap
> flag.  And each huge mapping and unmapping of a file (or shmem) THP
> involved atomically incrementing and decrementing the mapcount of every
> subpage of that huge page, dirtying many struct page cachelines.
> 
> Add subpages_mapcount field to the struct folio and first tail page,
> so that the total of subpage mapcounts is available in one place near
> the head: then page_mapcount() and total_mapcount() and page_mapped(),
> and their folio equivalents, are so quick that anon and file and hugetlb
> don't need to be optimized differently. Delete the unloved PageDoubleMap.
> 
> page_add and page_remove rmap functions must now maintain the
> subpages_mapcount as well as the subpage _mapcount, when dealing with
> pte mappings of huge pages; and correct maintenance of NR_ANON_MAPPED
> and NR_FILE_MAPPED statistics still needs reading through the subpages,
> using nr_subpages_unmapped() - but only when first or last pmd mapping
> finds subpages_mapcount raised (double-map case, not the common case).
> 
> But are those counts (used to decide when to split an anon THP, and
> in vmscan's pagecache_reclaimable heuristic) correctly maintained?
> Not quite: since page_remove_rmap() (and also split_huge_pmd()) is
> often called without page lock, there can be races when a subpage pte
> mapcount 0<->1 while compound pmd mapcount 0<->1 is scanning - races
> which the previous implementation had prevented. The statistics might
> become inaccurate, and even drift down until they underflow through 0.
> That is not good enough, but is better dealt with in a followup patch.
> 
> Update a few comments on first and second tail page overlaid fields.
> hugepage_add_new_anon_rmap() has to "increment" compound_mapcount, but
> subpages_mapcount and compound_pincount are already correctly at 0,
> so delete its reinitialization of compound_pincount.
> 
> A simple 100 X munmap(mmap(2GB, MAP_SHARED|MAP_POPULATE, tmpfs), 2GB)
> took 18 seconds on small pages, and used to take 1 second on huge pages,
> but now takes 119 milliseconds on huge pages.  Mapping by pmds a second
> time used to take 860ms and now takes 92ms; mapping by pmds after mapping
> by ptes (when the scan is needed) used to take 870ms and now takes 495ms.
> But there might be some benchmarks which would show a slowdown, because
> tail struct pages now fall out of cache until final freeing checks them.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks for doing this!

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

And sorry again for PageDoubleMap() :/

Minor nitpick and a question below.

> @@ -829,12 +829,20 @@ static inline int folio_entire_mapcount(struct folio *folio)
>  
>  /*
>   * Mapcount of compound page as a whole, does not include mapped sub-pages.
> - *
> - * Must be called only for compound pages.
> + * Must be called only on head of compound page.
>   */
> -static inline int compound_mapcount(struct page *page)
> +static inline int head_compound_mapcount(struct page *head)
>  {
> -	return folio_entire_mapcount(page_folio(page));
> +	return atomic_read(compound_mapcount_ptr(head)) + 1;
> +}
> +
> +/*
> + * Sum of mapcounts of sub-pages, does not include compound mapcount.
> + * Must be called only on head of compound page.
> + */
> +static inline int head_subpages_mapcount(struct page *head)
> +{
> +	return atomic_read(subpages_mapcount_ptr(head));
>  }
>  
>  /*

Any particular reason these two do not take struct folio as an input?
It would guarantee that it is non-tail page. It will not guarantee
large-folio, but it is something.

> @@ -1265,8 +1288,6 @@ void page_add_new_anon_rmap(struct page *page,
>  		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
>  		/* increment count (starts at -1) */
>  		atomic_set(compound_mapcount_ptr(page), 0);
> -		atomic_set(compound_pincount_ptr(page), 0);
> -

It has to be initialized to 0 on allocation, right?

>  		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
>  	} else {
>  		/* increment count (starts at -1) */

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
