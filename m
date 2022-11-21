Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE49B63226D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiKUMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiKUMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:38:21 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EDB6B3A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:38:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C617D32007E8;
        Mon, 21 Nov 2022 07:38:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 21 Nov 2022 07:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669034294; x=1669120694; bh=T8
        0Ixd8IplxWaxxkiIeZY9gINSKEir9nQQHp4lWGxVk=; b=Y5faw+yRWPNOV2hnUX
        LASny6c2pOyCWupx2QWAxgQkAxVqhhNxzABiywBKZObmiB+J6cJKmH7554p/n73G
        bz3lUt+rsQPAxPUrrWvyIAIqoH3ffeo/mzRofAI+8QC+tFO8SgWyGnO5g0Y8NkVF
        Qu2udl3ngnON8skNwSsBA89mWXID86D+FZwDd3Jagr9EXFqBajbKoxfsbLq4FpA1
        ZZULMMs9P76kG+o4spa+X0G3AiXwGjuWZUsFblBdTikjIdJcJ4TQHYmJBcGege5D
        10JX5RDHHEUGWNO8fw7SXmiewcaX6a4fKOVwWRZ73qD2c2YUHRt4ZCZfLsk/9wEc
        FIQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669034294; x=1669120694; bh=T80Ixd8IplxWaxxkiIeZY9gINSKE
        ir9nQQHp4lWGxVk=; b=OYUC11qV0I2IrvHvHtUA0RSGB2/xDAkyKQGluEfCEfBw
        DJxF9up8rpG3ZAejxCGco7+x3UKYakTpf5Fsv8dXtCxkL3eFxnr+7BmuyRULph3D
        6OuSc0/h4rwsaV9SJCx7zX6Iu8eZM2jElaHgO/f21rUwZw7tstUGxfgQbaMvmml4
        B20IaTb9MNxyuAY9O6xs30C0jDi1Ka5X8V3q1tY/ipU7yyDspBZwWDHY2ZX4pZH3
        go/esFGC0zDT01RiwJ7ZVNBF8/yu6uJ+/hTqw7rMFpzS+pFc0jg9P/HmhXfpedR0
        qoJrhXTsLozMVsr6B8JpnkgQSHlz9UtiFK8l5wEYdA==
X-ME-Sender: <xms:NXF7Y8lga2uH2ye8Nf3zkXZtxuWiImf-gRD5aciOjiRQ9zNLf5SwjQ>
    <xme:NXF7Y73n7gTM11HnIEeb2G9oMiY6DzVpJ1nPHueIknSSKVrF2vMDwYvgCR_U7x6bh
    2eNkFvO9dAG5cYCENA>
X-ME-Received: <xmr:NXF7Y6rRiD071_LoKI0VALPc4wqdQb577pnZqrQzfDV1Ep420vIvMJLCITMXUQ9hDrbucg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:NnF7Y4ltOxmwlXVzP9SEzwPg58vHsC-z9pKzvBhBTDj5-FY-2Hv-Jw>
    <xmx:NnF7Y619RifMHo68zOuLawYlfcSpQMVfIxNLCF6cvrvLxwCEwBmqdQ>
    <xmx:NnF7Y_uMT3DDFBPfYxZ11DJQsv3wVIHQHZyvhwW7zHrcO82fMnzO6g>
    <xmx:NnF7Yz6akadTNNLoIFfPr8cu-trS9QB8whlgAyqdp8TvtXK2iOoGTQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 07:38:13 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2CC2B109A30; Mon, 21 Nov 2022 15:38:12 +0300 (+03)
Date:   Mon, 21 Nov 2022 15:38:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
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
Subject: Re: [PATCH 1/3 fix] mm,thp,rmap: subpages_mapcount of PTE-mapped
 subpages: fix
Message-ID: <20221121123812.4sxk7ewzfhdqq6zs@box.shutemov.name>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <78fa518-85b5-32c0-ee92-537fa46131f6@google.com>
 <CAOUHufYf9Ns6vPpDeSOnUBaQm3Th+N6WbLiT7F=191LNpsatNQ@mail.gmail.com>
 <759077a6-a08-5bb0-a0b6-53be2fe8b56a@google.com>
 <7a4f5e5e-de33-dace-c526-4a3d3cf5f6e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4f5e5e-de33-dace-c526-4a3d3cf5f6e0@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 05:35:05PM -0800, Hugh Dickins wrote:
> Yu Zhao reports compiler warning in page_add_anon_rmap():
> 
> mm/rmap.c:1236:13: warning: variable 'first' is used uninitialized
> whenever 'if' condition is false [-Wsometimes-uninitialized]
>         } else if (PageTransHuge(page)) {
>                    ^~~~~~~~~~~~~~~~~~~
> mm/rmap.c:1248:18: note: uninitialized use occurs here
>         VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
>                         ^~~~~
> 
> We do need to fix that, even though it's only uninitialized in an
> impossible condition: I've chosen to initialize "first" true, to
> minimize the BUGs it might then hit; but you could just as well
> choose to initialize it false, to maximize the BUGs it might hit.
> 
> Reported-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/rmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 66be8cae640f..25b720d5ba17 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1281,7 +1281,7 @@ void page_add_anon_rmap(struct page *page,
>  	struct compound_mapcounts mapcounts;
>  	int nr = 0, nr_pmdmapped = 0;
>  	bool compound = flags & RMAP_COMPOUND;
> -	bool first;
> +	bool first = true;
>  
>  	if (unlikely(PageKsm(page)))
>  		lock_page_memcg(page);

Other option is to drop PageTransHuge() check that you already claim to be
redundant.

Or have else BUG() to catch cases where the helper called with
compound=true on non-THP page.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
