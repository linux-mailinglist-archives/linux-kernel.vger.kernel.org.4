Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB248666D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjALJCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbjALJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:01:12 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD871DF19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:56:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 702885C009B;
        Thu, 12 Jan 2023 03:56:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 12 Jan 2023 03:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673513813; x=1673600213; bh=/m
        Z4Vm+ef7Fcse4BfKsJqYMNeCYam4CxxvzvAMJvOpI=; b=qOTbh7F0sUjm9HN6fw
        z+jXZhYpIF1EoBCHqwJnw+/w0Rur1WFX54+gBl0w76UxRKPQUlSNNZnOKvVv/rrP
        KNUTNIWKT5/86SbO2DZ7R7fgwl3gKOjTzSNmtbvj4hDdIY+oIXqdJNAV/dWFGgBy
        m2r98cQH/wahk28Fa+HE2SfJ1+h0QiGdV6SY/7rHNh5rq0BgdLsGICMVNKsNEK1B
        KoeFwMdLqHv6tTmH2i3HVYO/LpcLe7AVoiGWK0VdYMxJro/e2BAcT+JwAJdjP2tS
        vwgTWh2pHcrR9s/XOsEzN80JTlUKFBRfw/HD+PnSvA+P7DsKdaUltWz8nZgckLCp
        l7SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673513813; x=1673600213; bh=/mZ4Vm+ef7Fcse4BfKsJqYMNeCYa
        m4CxxvzvAMJvOpI=; b=f0vnSQErjrLUJGF/V1xrO7b3Q9Y2Ph3Uo+NacnV/P/FL
        Bv5aWGC4Z7+oIm2MhP7hxt1gThrmfYYLb+IPNVCqSJF/qV3rhtZpXY+CxmAMEruh
        8JnEL29EJeDRaKfp4Z7aLhtNhZcqIIJ18zY0+oQkVXXRcUh4OBkyV8d3jOPJtcfD
        VT2mUzjuQY9gDAbntgJAE5H9xtW0wGIvuGDsT63iu1eSm76uMeayHddh5cWJNNQI
        kwdb3zsjMay0CYYzlFBxVub2abVO7nNgi2vfm+8A6i1/uofyWLdGwrQ7raD5GPbY
        ntcXlLtZHgqHsyet9Ukb6ieAQDZ9kYWhXtiu//vylA==
X-ME-Sender: <xms:Vcu_Y-l_OtHcoFboiKxHSlwnP5lla-39Z5xcvhqCxkUX-pvSEhbd1Q>
    <xme:Vcu_Y13oleW2rSS2cUE8FSy5VvloxEDu5UCSL_RYPmyVyGbcAcghuInjh8SN6bkN_
    DOdu0rzjIyaxLWN-qE>
X-ME-Received: <xmr:Vcu_Y8rVs0K-k6iCMiFBKRb4xU6J3LQacoWOql1q3yoaZp_uumDO2Ua4wo8ex0MUvaXNwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleehgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelvdduleeluedtgedvhedvtedulefhjeffudeu
    heehheehhffgfffhveeifefgveenucffohhmrghinhepvhdurdhmmhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhht
    vghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Vcu_YynvwH-5SF46BTauiK43PnbHopx_mKWQZytBGSwS2bspS-4SaA>
    <xmx:Vcu_Y81uFAD4gskNxrlog7ux_mEGCLUcAWVD8bJs3eSrdCQsMJcPNA>
    <xmx:Vcu_Y5v3IdDm60BwmS9orHo3trTf5gl5wSCYzO1VrcnpQ-3KkTCMYw>
    <xmx:Vcu_Y2qx25XQ-YPGvhLl6gJIRtNpDbNVYd1evP8zrCmlCpjhJHwahA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 03:56:52 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8B97D109AF0; Thu, 12 Jan 2023 11:56:49 +0300 (+03)
Date:   Thu, 12 Jan 2023 11:56:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Message-ID: <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
References: <20230111133351.807024-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111133351.807024-1-jannh@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:33:51PM +0100, Jann Horn wrote:
> If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
> it to be locked. retract_page_tables() bails out if an ->anon_vma is
> attached, but does this check before holding the mmap lock (as the comment
> above the check explains).
> 
> If we racily merge an existing ->anon_vma (shared with a child process)
> from a neighboring VMA, subsequent rmap traversals on pages belonging to
> the child will be able to see the page tables that we are concurrently
> removing while assuming that nothing else can access them.
> 
> Repeat the ->anon_vma check once we hold the mmap lock to ensure that there
> really is no concurrent page table access.
> 
> Reported-by: Zach O'Keefe <zokeefe@google.com>
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> zokeefe@ pointed out to me that the current code (after my last round of patches)
> can hit a lockdep assert by racing, and after staring at it a bit I've
> convinced myself that this is a real, preexisting bug.
> (I haven't written a reproducer for it though. One way to hit it might be
> something along the lines of:
> 
>  - set up a process A with a private-file-mapping VMA V1
>  - let A fork() to create process B, thereby copying V1 in A to V1' in B
>  - let B extend the end of V1'
>  - let B put some anon pages into the extended part of V1'

At this point V1' gets it's own ->anon_vma, not connected to V1, right?

>  - let A map a new private-file-mapping VMA V2 directly behind V1, without
>    an anon_vma
> [race begins here]
>   - in A's thread 1: begin retract_page_tables() on V2, run through first
>     ->anon_vma check
>   - in A's thread 2: run __anon_vma_prepare() on V2 and ensure that it
>     merges the anon_vma of V1 (which implies V1 and V2 must be mapping the
>     same file at compatible offsets)
>   - in B: trigger rmap traversal on anon page in V1'

I don't follow the race. rmap on V1' will not reach V1.

>  mm/khugepaged.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5cb401aa2b9d..0bfed37f3a3b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1644,7 +1644,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>  		 * has higher cost too. It would also probably require locking
>  		 * the anon_vma.
>  		 */
> -		if (vma->anon_vma) {
> +		if (READ_ONCE(vma->anon_vma)) {
>  			result = SCAN_PAGE_ANON;
>  			goto next;
>  		}

This makes perfect sense. At least for readability. But I think
false-negative should not lead to bad results.

> @@ -1672,6 +1672,18 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>  		result = SCAN_PTE_MAPPED_HUGEPAGE;
>  		if ((cc->is_khugepaged || is_target) &&
>  		    mmap_write_trylock(mm)) {
> +			/*
> +			 * Re-check whether we have an ->anon_vma, because
> +			 * collapse_and_free_pmd() requires that either no
> +			 * ->anon_vma exists or the anon_vma is locked.
> +			 * We already checked ->anon_vma above, but that check
> +			 * is racy because ->anon_vma can be populated under the
> +			 * mmap lock in read mode.
> +			 */
> +			if (vma->anon_vma) {
> +				result = SCAN_PAGE_ANON;
> +				goto unlock_next;
> +			}

This is totally wrong direction. Or I don't understand the race.

At this point we already paid nearly all price of of pagetable retraction.
I don't see any correctness reason to stop here, except for the assert.

I think lockdep assert in collapse_and_free_pmd() is wrong and has to be
dropped.

>  			/*
>  			 * When a vma is registered with uffd-wp, we can't
>  			 * recycle the pmd pgtable because there can be pte
> 
> base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
