Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E45FF65A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJNWX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJNWXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:23:54 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D71BE1E9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:23:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6C0A03200945;
        Fri, 14 Oct 2022 18:23:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 14 Oct 2022 18:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1665786230; x=1665872630; bh=Y6
        ngsLLxEEPsALgDBVsNDsl4csmgSHWiccz5cFir6Vk=; b=Yiii8jrRkL8w+/owty
        jm2EvI7nONMFGGGjBK/QGCbBpIAxkty3RXMNojrEBC44tcN0RSPRH/Q8kr1OtRr/
        T+2GMwR+Rcb3n5KPusdZL55SQbADOfGV3Rb7YY02yl6fFMaiDA1wAecPhjwQovlL
        pctk2XWTIpnYfmJrd3VkbUrQQRloLst6f+icu3tegRqks84beneI9QwtCJQ2inJl
        qIIVFuZKRmRHMcSZ2him7UKefa/+hDjqqDxXaPpCtl6Td+mbJ/47hK798Nzy8+Pk
        FZ7/Pjmx9VwmNjWsE45YuE0krZ/+SHQwml4kzfcivNOEd+3uv0pXdRgSbpHYWssy
        gb2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665786230; x=1665872630; bh=Y6ngsLLxEEPsALgDBVsNDsl4csmg
        SHWiccz5cFir6Vk=; b=AFKuzg7kN5WYamgZ8J9vuz5dVRZV1akJiaRAO32SCH4+
        o0pbSnDrnXD+o8ShW4H7DwB2SRlJOmlbz9LyDneVRgbApkaFYTj75Yri47Uy8D5I
        Qh05iPd84SwlRxQ7WXAnmFo/BSb016hW+US1t0MBv2+FTKGXJKxEnDy39j4PNqMH
        S/yA/L8+I5ZA1l6mWfENCXbo7qdoSSDlOD+fj7O3SQApfb25QcnI0nByk+xbt1rq
        dLO+XSUDI1IoY/XyZCklfUIt+60MWWktnPNXGb0TgIycRFYLLbfvFjpwN1BhRIKU
        FhbHKxapSNzlUkAnJxKIX9zymycmFCURvm1yM0fO/w==
X-ME-Sender: <xms:deFJY5N_IZdoR0e2BE_RaGLUA-6Wi_jXOFLLv4AayCWUK8QktpCb3A>
    <xme:deFJY79_W89UjiXhVYAhluBaQRDybyafQRPFYzz6cKTWrkqSsDKJ8xXr3Gs4yUX6W
    cOBBFvx0SEMjsmQ3Ao>
X-ME-Received: <xmr:deFJY4RWL9y6RPQfNtEaGZxpJtQnNAWJxR2ioEwgHUjHZqAO20I0R8vO05sFDhUTYrE2dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekfedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:deFJY1vadcb1DUcb5qPCgTBe6YkXcJAatgzFxJ8E0M6BC-jWnYfzKA>
    <xmx:deFJYxd_g9RrVg6wjw4J2J1NpjfGb-DsHj89PGmm1TzL_0IN0wUrxQ>
    <xmx:deFJYx1jRjzELNxb4yydyiyzlFdgef1UpwbRTkHprf2hhplIm6urfw>
    <xmx:duFJYx13X-IcAqsGwxzYNVRBWyltVL_IwsDRzQnqKwMGgqO0zxudhQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Oct 2022 18:23:49 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4F21E1094FB; Sat, 15 Oct 2022 01:23:46 +0300 (+03)
Date:   Sat, 15 Oct 2022 01:23:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
Message-ID: <20221014222346.n337tvkbyr33dsdx@box.shutemov.name>
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 08:19:42PM +0200, Jann Horn wrote:
> Hi!
> 
> I haven't actually managed to reproduce this behavior, so maybe I'm
> just misunderstanding how this works; but I think the
> arch_tlbbatch_flush() path for batched TLB flushing in vmscan ought to
> have some kind of integration with mm_tlb_flush_nested().
> 
> I think that currently, the following race could happen:
> 
> [initial situation: page P is mapped into a page table of task B, but
> the page is not referenced, the PTE's A/D bits are clear]
> A: vmscan begins
> A: vmscan looks at P and P's PTEs, and concludes that P is not currently in use
> B: reads from P through the PTE, setting the Accessed bit and creating
> a TLB entry
> A: vmscan enters try_to_unmap_one()
> A: try_to_unmap_one() calls should_defer_flush(), which returns true
> A: try_to_unmap_one() removes the PTE and queues a TLB flush
> (arch_tlbbatch_add_mm())
> A: try_to_unmap_one() returns, try_to_unmap() returns to shrink_folio_list()
> B: calls munmap() on the VMA that mapped P
> B: no PTEs are removed, so no TLB flush happens
> B: munmap() returns

I think here we will serialize against anon_vma/i_mmap lock in
__do_munmap() -> unmap_region() -> free_pgtables() that A also holds.

So I believe munmap() is safe, but MADV_DONTNEED (and its flavours) is not.

> [at this point, the TLB entry still exists]
> B: calls mmap(), which reuses the same area that was just unmapped
> B: tries to access the newly created VMA, but instead the access goes
> through the stale TLB entry
> A: shrink_folio_list() calls try_to_unmap_flush(), which removes the
> stale TLB entry
> 
> The effect would be that after process B removes a mapping with
> munmap() and creates a new mapping in its place, it would still see
> data from the old mapping when trying to access the new mapping.
> 
> Am I missing something that protects against this scenario?
> 
> munmap() uses the mmu_gather infrastructure, which tries to protect
> against this kind of correctness bug with multiple racing TLB
> invalidations in tlb_finish_mmu() by blowing away the whole TLB
> whenever one TLB invalidation ends while another is still in progress
> (tested with mm_tlb_flush_nested(tlb->mm)). But mmu_gather doesn't
> seem to be aware of TLB flushes that are batched up in the
> arch_tlbbatch_flush() infrastructure, so that doesn't help here.
> 
> I think it might be necessary to add a new global counter of pending
> arch_tlbbatch_flush() flushes, and query that in
> mm_tlb_flush_nested(), or something like that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
