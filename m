Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7D5FF676
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJNW4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:56:00 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC44A107
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:55:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 846193200909;
        Fri, 14 Oct 2022 18:55:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 14 Oct 2022 18:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1665788157; x=1665874557; bh=M7
        3D+dncr5/TWrQ5CiXGIZUf2R2xBbwveAi+EFE4fEk=; b=RMqn5vaWWc6KfSESFS
        bFrZxeHCm6h+SYVXKblWfKEKiJvD6sEwhZlqEn2bLZK1GQlkCbVD4yG8mwGW5DAB
        rvHbW/FmrbXUKMpCs0Cs0OKPo8cJ8JzsxEwnab9PLk2ude/SBmzmqJsnoXJehJP0
        veo5d6MV2wqochWSph6FNlazyb6oygmEdxBzICaXBQwUz4MiCa+gYjyAjNldJ/8Q
        70F/6VBiW4gTnfVMKWW20wtsw0WM4+98YqK7abSB9VzdxzVjzyVX172vFQeZyfkU
        4e1bBVk5ioAqI+bfUUcl03SBAXmgsMKuFvNOTLcJHvUkDCCHeVwU72Y4l1ONqokd
        np8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665788157; x=1665874557; bh=M73D+dncr5/TWrQ5CiXGIZUf2R2x
        BbwveAi+EFE4fEk=; b=DgBUj8WmGfVVXapD9O1r6q63nPgkH3lf0Cl3vtVKLUVc
        ELr8FXoWR8k0kHFx+WxIeMCoKXFOz/Sq3dn+xYD1sg/3bj0txk8dlEiZhI0G+NJi
        Cckx/8x8Mw2NytaIhjAhxjvUmm3ymmoOH1CxWY229Upq+ymJRqgCMgBTAIJGB0qa
        vTcHpSXZzlNEsKfOJbF0cgIPbuJU0UkJJvge9i3nwjIeZSSuo6yXRkg5D9QTsF+M
        3TIKt2KYfcZqbxIdXOmveJBFQyEKL6o/byhl86qfn80MySFQrSmDzfdeC6cYI3Dc
        rWpuCGJJLq1pKeAD9s0tmpblgIguIwY11oJJHsh/1w==
X-ME-Sender: <xms:_OhJY06TjXUbZkrNHI-xu3vnGlzVzNqP7iNsL1BIUA_IH7Dl8OAzwQ>
    <xme:_OhJY17offd4mr3Lwm3i6GqyWpF3aMhZWozkaBFnLvBOygnMl3DuTfrtkcfQuaKYG
    XgW0TMUMWpN0Ygz-p0>
X-ME-Received: <xmr:_OhJYze8aDEEzwnEj5WtL9GIPbayDAfO0rDiAUC4gjJuHM0OtwyJavoxhsa2ncL-go1-5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekfedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:_OhJY5L5SJzDRnl1wRPy3OHgkhQJX97p0LbdUt96QJajArsvWVpzIw>
    <xmx:_OhJY4IzJwaftLU1P4bhybgjVaS5-HKnD3HC0kWkPP2Msr3FGHil9A>
    <xmx:_OhJY6xWto_6xdzMXmk34YGATzGuxxpTDuNdIK3R07aYk5qbdsvdnw>
    <xmx:_ehJY2xsf-4slFfEWj84YhlhrJfSnE9a5ldxJHAuWRIgkJTGGlzoRg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Oct 2022 18:55:56 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 188911094FB; Sat, 15 Oct 2022 01:55:54 +0300 (+03)
Date:   Sat, 15 Oct 2022 01:55:54 +0300
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
Message-ID: <20221014225554.q6lxvc2ffp5drqvs@box.shutemov.name>
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
 <20221014222346.n337tvkbyr33dsdx@box.shutemov.name>
 <CAG48ez1B11EFyssTi=4izy04_FBOP1qdYVhEomYRdDBXb3jHkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1B11EFyssTi=4izy04_FBOP1qdYVhEomYRdDBXb3jHkA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 12:29:57AM +0200, Jann Horn wrote:
> On Sat, Oct 15, 2022 at 12:23 AM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> > On Fri, Oct 14, 2022 at 08:19:42PM +0200, Jann Horn wrote:
> > > Hi!
> > >
> > > I haven't actually managed to reproduce this behavior, so maybe I'm
> > > just misunderstanding how this works; but I think the
> > > arch_tlbbatch_flush() path for batched TLB flushing in vmscan ought to
> > > have some kind of integration with mm_tlb_flush_nested().
> > >
> > > I think that currently, the following race could happen:
> > >
> > > [initial situation: page P is mapped into a page table of task B, but
> > > the page is not referenced, the PTE's A/D bits are clear]
> > > A: vmscan begins
> > > A: vmscan looks at P and P's PTEs, and concludes that P is not currently in use
> > > B: reads from P through the PTE, setting the Accessed bit and creating
> > > a TLB entry
> > > A: vmscan enters try_to_unmap_one()
> > > A: try_to_unmap_one() calls should_defer_flush(), which returns true
> > > A: try_to_unmap_one() removes the PTE and queues a TLB flush
> > > (arch_tlbbatch_add_mm())
> > > A: try_to_unmap_one() returns, try_to_unmap() returns to shrink_folio_list()
> > > B: calls munmap() on the VMA that mapped P
> > > B: no PTEs are removed, so no TLB flush happens
> > > B: munmap() returns
> >
> > I think here we will serialize against anon_vma/i_mmap lock in
> > __do_munmap() -> unmap_region() -> free_pgtables() that A also holds.
> >
> > So I believe munmap() is safe, but MADV_DONTNEED (and its flavours) is not.
> 
> shrink_folio_list() is not in a context that is operating on a
> specific MM; it is operating on a list of pages that might be mapped
> into different processes all over the system.

s/specific MM/specific page/

> So A has temporarily held those locks somewhere inside
> try_to_unmap_one(), but it will drop them before it reaches the point

inside try_to_unmap(), which handles all mappings of the page.

> where it issues the batched TLB flush.
> And this batched TLB flush potentially covers multiple MMs at once; it
> is not targeted towards a specific MM, but towards all of the CPUs on
> which any of the touched MMs might be active.

But, yes, you are right. I thought that try_to_unmap_flush() called inside
try_to_unmap() under the lock.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
