Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F966C00D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjAPNrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjAPNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:47:15 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499871DB9E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:47:14 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4D937320070D;
        Mon, 16 Jan 2023 08:47:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 16 Jan 2023 08:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673876832; x=1673963232; bh=qe
        FZXXLsONTLO08sEOva/PbkznU4x6Y3TTAjXZnzwCI=; b=l5NfDo3XSmx5RiV7ZL
        NJHSta5wUfsjZZ1fPagghVzeqflRBHiBsndqRaGnBRFUIfEzGnLD9rBiu0EWw6RF
        w/Ph5HeFy2m3cPpffYuMZV745oCg0/9pN8q+ttkfq4QhL8oiy7EUDBNfElvkDq0F
        4K6f15ySSzHGP/Q6iXIebs9z6e96z22B8WzZaPYfVbFI/OnMurL4ydS7NNcwEbHu
        rkhelTYc0KjxhRTQx9sAjgeUohMfKh/yLnkr/c2g+Ee0anyaqe4fOfZtElowIJlY
        Gq68J3ezKMFOvlm3LZRZVrevhMJtkXAzgtQdY+ujqayCMwrACNBoLxgNqswY2Hq1
        bxvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673876832; x=1673963232; bh=qeFZXXLsONTLO08sEOva/PbkznU4
        x6Y3TTAjXZnzwCI=; b=qt3B+4zlwwSGqo9VOqR8Ym/o41LfeWpzjfTuvhe7gkDy
        zwHeMouPKZSPfLqv2/DLZQ2gZeSlytw0ZXSxqUlcwEXiDPIUhUMvyvf4RJjrC0Ue
        aC2DvMa5HKSYxnP7LXQqZzabu9ZdOIh8AXzEDKR5IqtAvowA91l7S45pGNoWgpAS
        WrDiI8j4808C0gsCStNYbN4RyHbzJUiv6YaTbWH9bIedFWO0Gil7WqXFO/zgw8+m
        JqaO8n601PyKdANBGvlPt+/8ZXjdqSDxU7RyRljIYgePfYNgmW4+3pUpaOMYx1cG
        GREVRWgjNRZRSQkBTaPefOlupQ5JFFSKRulNjSsN4w==
X-ME-Sender: <xms:YFXFYzLA4xa1xr70ETfjULI1zquaku4FSxra7zpP2SHM-efj6lcqsA>
    <xme:YFXFY3Ldsy_cYhULgg-X9gGAhEji4zl1BgGN1Thr6DdtgG4pZlFokJhqpPUsrICkI
    4VAP8dDR0nMljpmdBA>
X-ME-Received: <xmr:YFXFY7sNAuEWaDEcfNCzoWj1ieCb71HqDvHqMCuHNkELgdAurpB27NRYmSqYvb4ZyuKEOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:YFXFY8ZGfb2gBt0rgNV0SrpA1fjaBS7vwKwRaL7ZJG4pqNigtFJNlg>
    <xmx:YFXFY6bKuGpiGnR9sXLBZCs9J4XyZ1fXfi036M7egHDJPdGU50FUpw>
    <xmx:YFXFYwAJrrwR_BAhFETEjTqb1n2OT87QFKy5qDjtpnTGo5259Chkog>
    <xmx:YFXFY_OVaRnuMbhf-6qLY4KXoe_y2fNyTF1yL9lBD0dgRsokZHx67g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 08:47:12 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 636E7109792; Mon, 16 Jan 2023 16:47:10 +0300 (+03)
Date:   Mon, 16 Jan 2023 16:47:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Message-ID: <20230116134710.n4dgtrutt6rqif62@box.shutemov.name>
References: <20230111133351.807024-1-jannh@google.com>
 <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
 <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
 <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
 <20230116123403.fiyv22esqgh7bzp3@box.shutemov.name>
 <5a7fdfa7-5b25-0ed4-2479-661d387b397b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7fdfa7-5b25-0ed4-2479-661d387b397b@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 02:07:41PM +0100, David Hildenbrand wrote:
> On 16.01.23 13:34, Kirill A. Shutemov wrote:
> > On Mon, Jan 16, 2023 at 01:06:59PM +0100, Jann Horn wrote:
> > > On Sun, Jan 15, 2023 at 8:07 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > On Fri, Jan 13, 2023 at 08:28:59PM +0100, Jann Horn wrote:
> > > > > No, that lockdep assert has to be there. Page table traversal is
> > > > > allowed under any one of the mmap lock, the anon_vma lock (if the VMA
> > > > > is associated with an anon_vma), and the mapping lock (if the VMA is
> > > > > associated with a mapping); and so to be able to remove page tables,
> > > > > we must hold all three of them.
> > > > 
> > > > Okay, that's fair. I agree with the patch now. Maybe adjust the commit
> > > > message a bit?
> > > 
> > > Just to make sure we're on the same page: Are you suggesting that I
> > > add this text?
> > > "Page table traversal is allowed under any one of the mmap lock, the
> > > anon_vma lock (if the VMA is associated with an anon_vma), and the
> > > mapping lock (if the VMA is associated with a mapping); and so to be
> > > able to remove page tables, we must hold all three of them."
> > > Or something else?
> > 
> > Looks good to me.
> > 
> > > > Anyway:
> > > > 
> > > > Acked-by: Kirill A. Shutemov <kirill.shutemov@intel.linux.com>
> > > 
> > > Thanks!
> > > 
> > > > BTW, I've noticied that you recently added tlb_remove_table_sync_one().
> > > > I'm not sure why it is needed. Why IPI in pmdp_collapse_flush() in not
> > > > good enough to serialize against GUP fast?
> > > 
> > > If that sent an IPI, it would be good enough; but
> > > pmdp_collapse_flush() is not guaranteed to send an IPI.
> > > It does a TLB flush, but on some architectures (including arm64 and
> > > also virtualized x86), a remote TLB flush can be done without an IPI.
> > > For example, arm64 has some fancy hardware support for remote TLB
> > > invalidation without IPIs ("broadcast TLB invalidation"), and
> > > virtualized x86 has (depending on the hypervisor) things like TLB
> > > shootdown hypercalls (under Hyper-V, see hyperv_flush_tlb_multi) or
> > > TLB shootdown signalling for preempted CPUs through shared memory
> > > (under KVM, see kvm_flush_tlb_multi).
> > 
> > I think such architectures must provide proper pmdp_collapse_flush()
> > with the required serialization. Power and S390 already do that.
> > 
> 
> The plan is to eventually move away from (ab)using IPI to synchronize with
> GUP-fast. Moving further into that direction a is wrong.
> 
> The flush was added as a quick fix for all architectures by Jann, until
> we can do better.
> 
> Even for ppc64, see:
> 
> commit bedf03416913d88c796288f9dca109a53608c745
> Author: Yang Shi <shy828301@gmail.com>
> Date:   Wed Sep 7 11:01:44 2022 -0700
> 
>     powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush
>     The IPI broadcast is used to serialize against fast-GUP, but fast-GUP will
>     move to use RCU instead of disabling local interrupts in fast-GUP.  Using
>     an IPI is the old-styled way of serializing against fast-GUP although it
>     still works as expected now.
>     And fast-GUP now fixed the potential race with THP collapse by checking
>     whether PMD is changed or not.  So IPI broadcast in radix pmd collapse
>     flush is not necessary anymore.  But it is still needed for hash TLB.

Okay. But I think tlb_remove_table_sync_one() belongs inside
pmdp_collapse_flush(). Collapsing pmd table into huge page without
serialization is a bug. They should not be separate.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
