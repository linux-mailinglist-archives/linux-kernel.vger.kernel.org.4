Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10906DACAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjDGMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjDGMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:41:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022CA5E1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:41:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 788DF5C015A;
        Fri,  7 Apr 2023 08:40:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 07 Apr 2023 08:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680871258; x=
        1680957658; bh=kSEpnMPkGTPPsN41+arr7bHAPWSDvj7dNaWlKlNJTSo=; b=J
        1ByI0DdWJSjbPhCaC8Za6UyGSTuv8DlwV8ovnqKGob7U0qaKWlwV9Aoj/3uCOsGe
        34d81S/JISQ5EH9jhoV8yC+hjxRWWD0vRbvPRnOZL631wbCz8CmXfw7Qxjb2hg/x
        baW6T4f5O156eaIWXpUpCG+6XgvHIO5havNqJU5cr/Z3bhk77+cPZx2THpzEQ/yX
        SRmjCmTYb4wzZGkdbOjRrQH6VG7hyQRu+wQ8ob9iynVkM/ie70uCgdgBTtndZq74
        F0DxKNgD6mKVpY7v5DeDcz38asTD7Hd7UuVV/gwcehSnN+iMLpLPBtT2RA2YloUi
        4SwRfHCcA++KQ8mpQyhGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680871258; x=1680957658; bh=kSEpnMPkGTPPs
        N41+arr7bHAPWSDvj7dNaWlKlNJTSo=; b=H6t2g66RQ9epY60kio5/w1xbmxlFe
        CzYs8ViS6+rtEq+3VWTCAm5BnbKwizT5E+8LNvRPm2M9OhM/oY5I3jj5qS/gtMYO
        3SIE3AvD4kXRlMSliR/N9p5gXOMaw4lWUhWkzwuofnWQROYkyiyjWcdn9IajfXy1
        w/PGE0z8/aHvkbQ5BzdV+rie2a6sVS2quyAAqXoLFK9sye87KDsRyO8+ifQu2p54
        t7/HYuTNXweznCEhB4gprF19HiCpvJVhcEOT/T8th+Za5O3fSpff7cul9CXldjmr
        QN3JUoU6l4lPfRct23oQZznzeS2ugwCv9t5fSqLWIrd5qW4dps9hiMxFQ==
X-ME-Sender: <xms:Wg8wZBB6LLnFqN-cjxuqqlgdlSXW4-cFZ6A_zB37cxyKmiHXnoLS6Q>
    <xme:Wg8wZPh0UHz79QoPt2xX6uEhDdPS9cZfDr_qnbXlvk8QNp8B3fdk5hC7fW7ml9hHZ
    Ayft4dOZGTu927ze4M>
X-ME-Received: <xmr:Wg8wZMn1WBOXQc1_Vt-oWehEUkXiBLy0M3xfxcDWWvgKBR0FvIWFGpqTLIBkgRk1o7P3yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfeige
    fhtdefhedtfedthefghedutddvueehtedttdehjeeukeejgeeuiedvkedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshh
    huthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Wg8wZLyo4lEtU9tylGMuBaaK7DxRk19sBVP9S2mDSE-3EOQ8SBGRzw>
    <xmx:Wg8wZGSErlI9vQ2LWqX9r8rgVpCM-6cqqlA-kvtH8J2eSbqr2J3bLQ>
    <xmx:Wg8wZObSVkRDd-MET0UBXKZ3E92diQXnD_hoUoLZLOCVjhUuwt4Q2g>
    <xmx:Wg8wZEdvFPf6J3p97Tn0tPd_9MKDG0AZ0Ql9N34nF_WLT9tN3upzYQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Apr 2023 08:40:58 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2118A109B00; Fri,  7 Apr 2023 15:40:54 +0300 (+03)
Date:   Fri, 7 Apr 2023 15:40:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Message-ID: <20230407124054.27iiers6o36pdfei@box.shutemov.name>
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
 <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
 <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
 <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
 <ZC82N4sP5xE63kl4@kernel.org>
 <20230406154423.20a991bbdd47630fc38d94e8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406154423.20a991bbdd47630fc38d94e8@linux-foundation.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 03:44:23PM -0700, Andrew Morton wrote:
> On Fri, 7 Apr 2023 00:14:31 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > > Shouldn't that be
> > > > 		else
> > > > 			order = 0;
> > > > ?
> > > 
> > > +Mike.
> > > 
> > > No. start == 0 is MAX_ORDER-aligned. We want to free the pages in the
> > > largest chunks alignment allows.
> > 
> > Right. Before the changes to MAX_ORDER it was
> > 
> > 		order = min(MAX_ORDER - 1UL, __ffs(start));
> > 
> > which would evaluate to 10.
> > 
> > I'd just prefer the comment to include the explanation about why we choose
> > MAX_ORDER for start == 0. Say
> > 
> > 	/*
> > 	 * __ffs() behaviour is undefined for 0 and we want to free the
> > 	 * pages in the largest chunks alignment allows, so set order to
> > 	 * MAX_ORDER when start == 0
> > 	 */
> 
> Meanwhile I'd like to fix "various boot failures (hang) on arm targets"
> in -next, so I queued up Kirill's informal fix for now.

Here's my variant of the fix up with more vervose comments.

diff --git a/mm/memblock.c b/mm/memblock.c
index 7911224b1ed3..381e36ac9e4d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2043,7 +2043,16 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	int order;
 
 	while (start < end) {
-		order = min_t(int, MAX_ORDER, __ffs(start));
+		/*
+		 * Free the pages in the largest chunks alignment allows.
+		 *
+		 * __ffs() behaviour is undefined for 0. start == 0 is
+		 * MAX_ORDER-aligned, Set order to MAX_ORDER for the case.
+		 */
+		if (start)
+			order = min_t(int, MAX_ORDER, __ffs(start));
+		else
+			order = MAX_ORDER;
 
 		while (start + (1UL << order) > end)
 			order--;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c8f0a8c2d049..8e0fa209d533 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -605,7 +605,18 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	 * this and the first chunk to online will be pageblock_nr_pages.
 	 */
 	for (pfn = start_pfn; pfn < end_pfn;) {
-		int order = min_t(int, MAX_ORDER, __ffs(pfn));
+		int order;
+
+		/*
+		 * Free to online pages in the largest chunks alignment allows.
+		 *
+		 * __ffs() behaviour is undefined for 0. start == 0 is
+		 * MAX_ORDER-aligned, Set order to MAX_ORDER for the case.
+		 */
+		if (pfn)
+			order = min_t(int, MAX_ORDER, __ffs(pfn));
+		else
+			order = MAX_ORDER;
 
 		(*online_page_callback)(pfn_to_page(pfn), order);
 		pfn += (1UL << order);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
