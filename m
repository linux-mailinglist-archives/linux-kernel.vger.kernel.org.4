Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B679D66BDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjAPMeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAPMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:34:07 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA531E1D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:34:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BD37E32002D8;
        Mon, 16 Jan 2023 07:34:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 16 Jan 2023 07:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673872445; x=1673958845; bh=VU
        Dr8cpDb6H5GOfkB07vTgHvt+AyLkABhj5WKeHRWOI=; b=eaCUJLCbqY7U95iVyK
        Cw7AQCMwjzTi+UuBbeNUvKgFvo58VbOdSEZ4W9AsMINRv3UBMW+e8JPKWxL7y1l6
        G2mRaVYcIXM61R8WfT/PuXTAfzVnD3gJmo8xpARon9AYMSBfQi1BircwitNkZY55
        wvbCF2tXj5Xn11taRW1gA6ad/3BCx0+wDYXgQGsS8sBB0pAHdJ47o00rqHIcStjO
        u7KLJwxPWzNCfwwSWMcVcKknra/XZOfANcSH49gOMbKtArgx2khO8JuGlPb45ENQ
        Hw1EBermNgQLv5MEGOIxGB1h4pd13zj+bhNcReESZwh9hLfZyZef4o1sxCwNMvh2
        9c5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673872445; x=1673958845; bh=VUDr8cpDb6H5GOfkB07vTgHvt+Ay
        LkABhj5WKeHRWOI=; b=itIuCA2aFBIqr2YAugpAWhNf9HE0dvFM/H7bRGvhPY/g
        3Aqr77gcrbHqPzH77XT+XzHb3WJmFOisNu1rKn9IB6rzxidqpQiepGTh/qNvWjs4
        1P3tTlFjLip5h8ms736X/ft3UDK0n/txN3YOoxZW9z6slK6qaV6mq18pvNUYVt+6
        f6EbmENMASccI/Zxc4KlKBiuLnEMbpTkrRWGITWwh+Myr03BL2HdgPR/jI7NM3oG
        tP+g5ebr+TkPMuKBYnhsm647l7qC8K3sfgrmpDWQmxQWgzsiHRqS39udEPpvbnrR
        s5zNjmXcvSlp3PZC8eyeGzqAY/rY8Eu2F4AMpWbhmg==
X-ME-Sender: <xms:PUTFY6HvAaByJYHECFpTZf5JaFEQ1c8gsFYFzkfH1sT5Oj0x-dzC8Q>
    <xme:PUTFY7XJf6yj-YETqxCqRG28D578Mobbu7vr6FXrIBBYkDY_q1C89JrOefw4vSOqA
    aezEW3GTV28jJyfFV0>
X-ME-Received: <xmr:PUTFY0LY3SGyuNJPT-Lf4EobkFrOD3-YOc414xdygqHjSUWbZXrdzjd1VxAe3cxxe96KlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:PUTFY0HMe5kcGZs4gs4eNnkwu1ETo6WT4QTPw59sqQUdAbRZefT1PA>
    <xmx:PUTFYwUiaHlpWnV3apZ447Lyo3k6vznpgIqwKMpp815dbNeEFAG28w>
    <xmx:PUTFY3OWaXO5GsF3xXTFcd8ZoZyt3Edn37yYFW3dIooagVvvf5qtdA>
    <xmx:PUTFYyJ_vkQGpusP6ms_x6oyXtXmZM5Q8FOd3xFLSPXZSbCkDxTfEA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 07:34:04 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 33F96109792; Mon, 16 Jan 2023 15:34:03 +0300 (+03)
Date:   Mon, 16 Jan 2023 15:34:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Message-ID: <20230116123403.fiyv22esqgh7bzp3@box.shutemov.name>
References: <20230111133351.807024-1-jannh@google.com>
 <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
 <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
 <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:06:59PM +0100, Jann Horn wrote:
> On Sun, Jan 15, 2023 at 8:07 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Fri, Jan 13, 2023 at 08:28:59PM +0100, Jann Horn wrote:
> > > No, that lockdep assert has to be there. Page table traversal is
> > > allowed under any one of the mmap lock, the anon_vma lock (if the VMA
> > > is associated with an anon_vma), and the mapping lock (if the VMA is
> > > associated with a mapping); and so to be able to remove page tables,
> > > we must hold all three of them.
> >
> > Okay, that's fair. I agree with the patch now. Maybe adjust the commit
> > message a bit?
> 
> Just to make sure we're on the same page: Are you suggesting that I
> add this text?
> "Page table traversal is allowed under any one of the mmap lock, the
> anon_vma lock (if the VMA is associated with an anon_vma), and the
> mapping lock (if the VMA is associated with a mapping); and so to be
> able to remove page tables, we must hold all three of them."
> Or something else?

Looks good to me.

> > Anyway:
> >
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@intel.linux.com>
> 
> Thanks!
> 
> > BTW, I've noticied that you recently added tlb_remove_table_sync_one().
> > I'm not sure why it is needed. Why IPI in pmdp_collapse_flush() in not
> > good enough to serialize against GUP fast?
> 
> If that sent an IPI, it would be good enough; but
> pmdp_collapse_flush() is not guaranteed to send an IPI.
> It does a TLB flush, but on some architectures (including arm64 and
> also virtualized x86), a remote TLB flush can be done without an IPI.
> For example, arm64 has some fancy hardware support for remote TLB
> invalidation without IPIs ("broadcast TLB invalidation"), and
> virtualized x86 has (depending on the hypervisor) things like TLB
> shootdown hypercalls (under Hyper-V, see hyperv_flush_tlb_multi) or
> TLB shootdown signalling for preempted CPUs through shared memory
> (under KVM, see kvm_flush_tlb_multi).

I think such architectures must provide proper pmdp_collapse_flush()
with the required serialization. Power and S390 already do that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
