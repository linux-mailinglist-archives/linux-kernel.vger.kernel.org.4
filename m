Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807E7376C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjFTVlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:41:12 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F6170D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:41:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 59608320091D;
        Tue, 20 Jun 2023 17:41:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 20 Jun 2023 17:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687297266; x=1687383666; bh=IF
        jjY5roZiwIkKPSUbI5fcD7pRZU5oiVbQVG2wmNIyk=; b=h1fsw2NWh5JvfJotED
        pWAHMvSeuUWwgN6ejG3ulwtxY01wU4Bx3GlAnbfz1blo++XmLfnxHXu5q4uhEg7F
        +eYLNbG6BoJQ5pRcU5Cj6mdwbCYP6KGF63IR/OZua+A9/TlfNI4tbViujV44QOEs
        eJ+A1QV2WW2PF9/QZBLhiyrDLnJH0+LJN/vsQvpePaCrxNO8t76TL+UBrhZhmktH
        LinlWnVdLjxKPSGAd7nPewPGq8+2GADYL66Qi56cApOipg3zouDIsdaZpNISoKEN
        XKNQ/rz1bMqc641hFOnMTVQRDKuHqKqFDD9aVLSTVA3YCQLv6O544XkAEMdj0kPF
        JFow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687297266; x=1687383666; bh=IFjjY5roZiwIk
        KPSUbI5fcD7pRZU5oiVbQVG2wmNIyk=; b=eQVIyGYPd5rS5NNsI653/DGuL5SUK
        zfEVfjFjKFYyoEX42Mj9taTFKf9Hj1miWpJEAxCHc2kgcdzXvIxgmxVJLC6QpMBh
        FQF+ow+RfBVHLJC5YdQNGgYpR0eCQWSUq6ZMPVcvI2QIQrS1/H+qUCnwwl7HRAXG
        H3XCAvT+yEJP1E7MiQdz92pc6oiR2EsO5weP6hyZd1eeh8n6Iovo58AgkEWezbHB
        P7IUXc/0YuuMuCipInZ/A9Q7IDPtEk43/ap3+XudS15BIho0Yp+tlS/8SOgd7hPh
        zzhYNjV89pOm0nKV5RD4DidRR/lNXZ8lqsMc+ytjAq1pOo9O7XQcZWrtA==
X-ME-Sender: <xms:8hySZNIMIlgcTtc8vq-Cet9x9RyYvo4O1YfIPefGDxvbhBOJUp7J4A>
    <xme:8hySZJI9klPjfnjBN05N5UrpBXO6HK3oj8nxM8OtHP9ExT9sB1RPfwJmtFEWGPsxM
    CzsW4M5N1FcZAp_4w>
X-ME-Received: <xmr:8hySZFu7jU7ucc5uMsZm3Pl03Ze9BJMuMf9Tq33aoikH0IklD-fWN1fYDKgrXgd8O3vUWOl-5kleHbK1d9RRmgq81vYSU2GuiJ8F0MNKuBhJjH8-4QLwppgEqnHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefiedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepueelhedvkeehvddvgeevleektefhteefueefhefhteeigffgtdegkeek
    geeigeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:8hySZObzc6904TBtXY1rG1ULqGHOca2QZIe3QIk7sdvS8-yd39Kecg>
    <xmx:8hySZEZBy2n069RmgmNkPql71Ezw28Pt1gYeCwxCB0OYEdaPQ6Rg-A>
    <xmx:8hySZCBLngn1_K_dXbDGHhypRzqpiip6M6n-Z5E5Qu_uE8QROUeM4w>
    <xmx:8hySZCnapVWhKAW2-ZPTe9TKOkxSK0whOm8l8FtHlSp8d-bojD4eaQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jun 2023 17:41:06 -0400 (EDT)
Date:   Tue, 20 Jun 2023 14:41:05 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <20230620214105.3d4tm54gzodcx3uk@awork3.anarazel.de>
References: <20230404120117.2562166-1-stevensd@google.com>
 <20230404120117.2562166-5-stevensd@google.com>
 <20230620205547.qzmivkjox2hkpzmm@awork3.anarazel.de>
 <ZJIWAvTczl0rHJBv@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJIWAvTczl0rHJBv@x1n>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-06-20 17:11:30 -0400, Peter Xu wrote:
> On Tue, Jun 20, 2023 at 01:55:47PM -0700, Andres Freund wrote:
> > On 2023-04-04 21:01:17 +0900, David Stevens wrote:
> > > From: David Stevens <stevensd@chromium.org>
> > > 
> > > Make sure that collapse_file doesn't interfere with checking the
> > > uptodate flag in the page cache by only inserting hpage into the page
> > > cache after it has been updated and marked uptodate. This is achieved by
> > > simply not replacing present pages with hpage when iterating over the
> > > target range.
> > > 
> > > The present pages are already locked, so replacing them with the locked
> > > hpage before the collapse is finalized is unnecessary. However, it is
> > > necessary to stop freezing the present pages after validating them,
> > > since leaving long-term frozen pages in the page cache can lead to
> > > deadlocks. Simply checking the reference count is sufficient to ensure
> > > that there are no long-term references hanging around that would the
> > > collapse would break. Similar to hpage, there is no reason that the
> > > present pages actually need to be frozen in addition to being locked.
> > > 
> > > This fixes a race where folio_seek_hole_data would mistake hpage for
> > > an fallocated but unwritten page. This race is visible to userspace via
> > > data temporarily disappearing from SEEK_DATA/SEEK_HOLE. This also fixes
> > > a similar race where pages could temporarily disappear from mincore.
> > > 
> > > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > 
> > I noticed that recently MADV_COLLAPSE stopped being able to collapse a
> > binary's executable code, always failing with EAGAIN. I bisected it down to
> > a2e17cc2efc7 - this commit.
> > 
> > Using perf trace -e 'huge_memory:*' -a I see
> > 
> >   1000.433 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 1537, is_shmem: 1, filename: "postgres.2", result: 17)
> >   1000.445 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
> >   1000.485 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 2049, is_shmem: 1, filename: "postgres.2", result: 17)
> >   1000.489 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
> >   1000.526 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 2561, is_shmem: 1, filename: "postgres.2", result: 17)
> >   1000.532 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
> >   1000.570 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 3073, is_shmem: 1, filename: "postgres.2", result: 17)
> >   1000.575 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
> > 
> > for every attempt at doing madvise(MADV_COLLAPSE).
> > 
> > 
> > I'm sad about that, because MADV_COLLAPSE was the first thing that allowed
> > using huge pages for executable code that wasn't entirely completely gross.
> > 
> > 
> > I don't yet have a standalone repro, but can write one if that's helpful.
> 
> There's a fix:
> 
> https://lore.kernel.org/all/20230607053135.2087354-1-stevensd@google.com/
> 
> Already in today's Andrew's pull for rc7:
> 
> https://lore.kernel.org/all/20230620123828.813b1140d9c13af900e8edb3@linux-foundation.org/

Ah, great!

I can confirm that the fix unbreaks our use of MADV_COLLAPSE for executable
code...

Greetings,

Andres Freund
