Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F076E7024
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDSABO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDSABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:01:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9834C19
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:01:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AF40C5C00D2;
        Tue, 18 Apr 2023 20:01:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Apr 2023 20:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681862468; x=
        1681948868; bh=4BY3h0MGaISpFWebjCDo3oYbjhhLl06wlbW9MqKaQ+I=; b=b
        PS3JOUG6PWlj4rTL+8d3Y1eeFgiJM/NumqMiUfkkz8LYzBMPDiSaumIlC+HbySSN
        VdbpxgkzLfmpM64sQRXMP+CvEqgIzQghURRT++1sgrUMgo8Wj5nYIUt1Z3WpJjdY
        sWo65qybnZQqrHVjqhjgRMy+upDtiGdh1yGqbHAsoCBgEMGHCyvBuNg4qI23Kypw
        rKlbhYjnYrMmA9fC7upfbbzeLXHp/Vkt3jsNfb3WRNnqfAZB/DEN7MIK6zw7Avco
        /Eg13RFDcn4MGhI9DL6Wo/6V7L/MCZun80N9apTHZkCtzLHtvm5WCXY/Zn+RhO/r
        wX69+3GefZfoz/0Ng4lOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681862468; x=1681948868; bh=4BY3h0MGaISpF
        WebjCDo3oYbjhhLl06wlbW9MqKaQ+I=; b=eOD9667srpbMck5IHRIPvPaNPQjG/
        jFPAms1rHRc+Et4Bg5FVmoD8Inv9hNdpsLfmNurCEnOZ4I6Y0M/iykivnw2STt2G
        /MzIlgO9RjYCNWq5hTOjh6FO67niHjkGYJdlHToQLBUg0ygy7vn6D7FMAxZxXsAK
        VUDgYu8fcCtJUzlKRsx1ZiOrcbRVY/kxCgEGQmwZ/pwgulhKEsoe00ofeRWm0zxN
        XGlilfxFHQDl8t04jcfATOYXAOAQRX9C7wzPT36cZ9w9kL7j8z7EXhqIuSmMyzEB
        02yJ2/wB6WhcWQzbWYqE4T41mLggAx8ujhOuESaj92pgw8ldoJ45p4Lbg==
X-ME-Sender: <xms:Qy8_ZMGz-rbF4u1OAWXriDRTfkrzsue1botgxrUMwiuvNSiLz_R--w>
    <xme:Qy8_ZFULIIL9Hkj-FtFfzQWnJRBlGBDeBn6eXt0yzGTUpoNUlt1rMK7uAPrgSBXiu
    nhxJ3KC75Zq9xIA7yk>
X-ME-Received: <xmr:Qy8_ZGKJj1HXBk0SF09GF06gyzy2jonsqZC78pav5GAe0PuO0GDu_zPoRnodTryfSy91QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Qy8_ZOH2xpbsafMDQQxtU7nyg5MRtle_mh61xDfPHNNihExMprdPQA>
    <xmx:Qy8_ZCUINeYXFu7viWlZZEfzwfGBn5qs-9lIn-wRpUI3tnBFlr5X5Q>
    <xmx:Qy8_ZBNS6ML0vh4zzOfzHmRP0ZWjbumymC7hu3im44rPrSLFOS1uQg>
    <xmx:RC8_ZEKL8OmuWEIQsvIa03ZEOYRHuWGlBq8aUIgI0B0rDbkO50kYbQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Apr 2023 20:01:07 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8ED3810C351; Wed, 19 Apr 2023 03:01:05 +0300 (+03)
Date:   Wed, 19 Apr 2023 03:01:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Message-ID: <20230419000105.matz43p6ihrqmado@box.shutemov.name>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-4-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:50PM -0400, Johannes Weiner wrote:
> pageblock_order can be of various sizes, depending on configuration,
> but the default is MAX_ORDER-1.

Note that MAX_ORDER got redefined in -mm tree recently.

> Given 4k pages, that comes out to
> 4M. This is a large chunk for the allocator/reclaim/compaction to try
> to keep grouped per migratetype. It's also unnecessary as the majority
> of higher order allocations - THP and slab - are smaller than that.

This seems way to x86-specific. Other arches have larger THP sizes. I
believe 16M is common.

Maybe define it as min(MAX_ORDER, PMD_ORDER)?

> Before subsequent patches increase the effort that goes into
> maintaining migratetype isolation, it's important to first set the
> defrag block size to what's likely to have common consumers.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/pageblock-flags.h | 4 ++--
>  mm/page_alloc.c                 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index 5f1ae07d724b..05b6811f8cee 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -47,8 +47,8 @@ extern unsigned int pageblock_order;
>  
>  #else /* CONFIG_HUGETLB_PAGE */
>  
> -/* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
> -#define pageblock_order		(MAX_ORDER-1)
> +/* Manage fragmentation at the 2M level */
> +#define pageblock_order		ilog2(2U << (20 - PAGE_SHIFT))
>  
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ac03571e0532..5e04a69f6a26 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7634,7 +7634,7 @@ static inline void setup_usemap(struct zone *zone) {}
>  /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
>  void __init set_pageblock_order(void)
>  {
> -	unsigned int order = MAX_ORDER - 1;
> +	unsigned int order = ilog2(2U << (20 - PAGE_SHIFT));
>  
>  	/* Check that pageblock_nr_pages has not already been setup */
>  	if (pageblock_order)
> -- 
> 2.39.2
> 
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
