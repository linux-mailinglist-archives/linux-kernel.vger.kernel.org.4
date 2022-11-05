Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55861DDF0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiKEUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKEUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:06:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE2213DCC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 13:06:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D1D95C00D0;
        Sat,  5 Nov 2022 16:06:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 05 Nov 2022 16:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667678809; x=1667765209; bh=Bs
        Ceaf14jLHWb+fLkSxCTF9UB6AbPje9aPDJaF0NlXs=; b=mFdJR4hMQbCC0fNwm9
        5D2Ysku7jguxJH5YJQqzSbKuQxQhcKfu/gExHUza1ST+aUe0WRdQm6G9CE3o6emB
        YsjU/PGP6qgx9u+EBR+DFM1agFPLBasBEm5Ce9ypwy072Dux55D5SWItF8Hjhq7w
        j2/p+5FHijEKuDQwB3xIAsdr/RJyV5C1IE8mk85RPXcB1mV9+8PsirJ/Ft7IKiEC
        zYRovfRbis4V3H4Whon1V8fhVckSdM3yG4w0Tm983z6rDUNHJirwMLz63pBzA+1/
        aTV4FTgrpfEMmmSrid9mX67F3rLsXMQKzJbPVlNrhwHpeCtFXTAdfORVQmUKgowl
        bMAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667678809; x=1667765209; bh=BsCeaf14jLHWb+fLkSxCTF9UB6Ab
        Pje9aPDJaF0NlXs=; b=WzvdEjYiIUdCqzI8fZqymDcQ2kIGnEfpVR13xVgU3ky1
        wntOBLbC68yGVso9yrkAs45GzXgiIBLI1J6ThCiSHgb0onu6cbBektEbCdmADIwr
        RYrYcc7CynC0uHP28Bhzhx0lWNQU9vhsmMv/5UHKgrC2c0AXxXgfQ8eJlCo50YD3
        nWhMkG5RWnbMGVAvarAjbXP0k+iIx1YglZrP22bc/xMTKl9Ww+Bz+0+KmXp5Z3eC
        puYArEH7PpW6eHURd4AYsWn+uA4HcgMUhGjxNCdD4XRmGydvOzwl+lyrCmOLM+lE
        yecJV+sJ2h4dWCFe7Pssow/2J4xB6nkrs75VF6LGIQ==
X-ME-Sender: <xms:WMJmY8WJrJKhluqgzr4k52EhWT9cq-Gx9nf4Vnb6o8bk0MVb-3bx_w>
    <xme:WMJmYwnDz5Yfjs74pj-XwMpF7xlY0hd3U2wyLodXF4CRhmocVXJtJpAXRYovM_xKR
    thVIRDmt9VFbQ3j9mo>
X-ME-Received: <xmr:WMJmYwZ5XHGKfSFTQRyD5WftzN6QcTZxG1Tkgtu5QysOUXefMvhFgXJurLJK79A5DmoVRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:WMJmY7VXhmNGf0M-ltRWDl2JmzZK2uPPII1zJV7KvU0bfg38bM5B3A>
    <xmx:WMJmY2m6HyDxSwXRA9_c4g2qkeClZ1cYFZit3TkhNEQpqmgQjTZ9Tw>
    <xmx:WMJmYwdRr5bdmpO4_2_wpU1p3FNjkm_eGPuaq4IqGbYi_h9GswXCMA>
    <xmx:WcJmYw2tr6SrnqLUIBT0xAWNjNBMP5aAkZFb7n4U2T3kn_rXOr2rSg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 16:06:47 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 448F9104449; Sat,  5 Nov 2022 23:06:46 +0300 (+03)
Date:   Sat, 5 Nov 2022 23:06:46 +0300
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
Subject: Re: [PATCH 3/3] mm,thp,rmap: lock_compound_mapcounts() on THP
 mapcounts
Message-ID: <20221105200646.wmfilka6prusrb56@box.shutemov.name>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <1b42bd1a-8223-e827-602f-d466c2db7d3c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b42bd1a-8223-e827-602f-d466c2db7d3c@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:53:45PM -0700, Hugh Dickins wrote:
> Fix the races in maintaining compound_mapcount, subpages_mapcount and
> subpage _mapcount by using PG_locked in the first tail of any compound
> page for a bit_spin_lock() on such modifications; skipping the usual
> atomic operations on those fields in this case.
> 
> Bring page_remove_file_rmap() and page_remove_anon_compound_rmap()
> back into page_remove_rmap() itself.  Rearrange page_add_anon_rmap()
> and page_add_file_rmap() and page_remove_rmap() to follow the same
> "if (compound) {lock} else if (PageCompound) {lock} else {atomic}"
> pattern (with a PageTransHuge in the compound test, like before, to
> avoid BUG_ONs and optimize away that block when THP is not configured).
> Move all the stats updates outside, after the bit_spin_locked section,
> so that it is sure to be a leaf lock.
> 
> Add page_dup_compound_rmap() to manage compound locking versus atomics
> in sync with the rest.  In particular, hugetlb pages are still using
> the atomics: to avoid unnecessary interference there, and because they
> never have subpage mappings; but this exception can easily be changed.
> Conveniently, page_dup_compound_rmap() turns out to suit an anon THP's
> __split_huge_pmd_locked() too.
> 
> bit_spin_lock() is not popular with PREEMPT_RT folks: but PREEMPT_RT
> sensibly excludes TRANSPARENT_HUGEPAGE already, so its only exposure
> is to the non-hugetlb non-THP pte-mapped compound pages (with large
> folios being currently dependent on TRANSPARENT_HUGEPAGE).  There is
> never any scan of subpages in this case; but we have chosen to use
> PageCompound tests rather than PageTransCompound tests to gate the
> use of lock_compound_mapcounts(), so that page_mapped() is correct on
> all compound pages, whether or not TRANSPARENT_HUGEPAGE is enabled:
> could that be a problem for PREEMPT_RT, when there is contention on
> the lock - under heavy concurrent forking for example?  If so, then it
> can be turned into a sleeping lock (like folio_lock()) when PREEMPT_RT.
> 
> A simple 100 X munmap(mmap(2GB, MAP_SHARED|MAP_POPULATE, tmpfs), 2GB)
> took 18 seconds on small pages, and used to take 1 second on huge pages,
> but now takes 115 milliseconds on huge pages.  Mapping by pmds a second
> time used to take 860ms and now takes 86ms; mapping by pmds after mapping
> by ptes (when the scan is needed) used to take 870ms and now takes 495ms.
> Mapping huge pages by ptes is largely unaffected but variable: between 5%
> faster and 5% slower in what I've recorded.  Contention on the lock is
> likely to behave worse than contention on the atomics behaved.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
