Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4961FB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiKGRd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiKGRd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:33:57 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93426EA5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:33:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E74E5C011B;
        Mon,  7 Nov 2022 12:33:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 12:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667842435; x=1667928835; bh=kU
        NE2iBPOSjzRRFTO7BCAn/Lk++D7uSvRl+/5vPA3tY=; b=WC1gzb+XtQOcl1rmjN
        gELstHuXY/Ue4k/fnrG2pTPwYY6ohB57od78ksHfeG0XPyreJUekteap45aERHlF
        EbbklduMfsvFL5DGY5JZ3lrnbKplNdentLcL7o0ckzQlKTGUUGJOvJJ5w+6MVbD5
        jdrt5U7J2nXn6VqmqxbOkYE1PiM/Gqg0jisHiqahYQSsDz+cekvNB04hovH3YIna
        D7IOefPYSpi0jQPJyMJ5S94DGeNcIJah9j5FEQF0IFajS8XmTcmNkAFkzdV7RDSE
        2kXFkwo5x4P0abORMgdhHyti6hprELQAW3u/Kl9xjL+EiAVDdkV0u+2ijNgNrH7G
        gf+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667842435; x=1667928835; bh=kUNE2iBPOSjzRRFTO7BCAn/Lk++D
        7uSvRl+/5vPA3tY=; b=A+M+SgwUOYHM74VLmFnR1wyMeJvowrVYmsexZEnf2WCG
        xmeOiTYAFbBA3mL20KNoMmMuSyp2yYKVDliZkxt2QG8j+3Id2t22CA5N9vSpF0jS
        in3SXiY7TKqEtagIVfwVkuDByEoXu7DTgFWpNhDeJqY/W7LDyJy0LlNyrtoegG5f
        4SYX9znueBYS+ghsRAPQ+S34sqLkFIxHG8Y3ou52keAK4rZ3Ikq4q6Fztc6eKKNU
        SdCVgLgCg5HE7LanXtmjYhvKo3ddABU9/lkMvwmW5M2z8rWdCYYsEI48hJLfeIUp
        +ByySMqxAkZbHGUhNW3UFfotVHU6m5Auv2DS6fETiA==
X-ME-Sender: <xms:g0FpY_t595-nXhF8t61qNPsCde14hYIfmqrkM5xxR4-pfU-vADB9Cg>
    <xme:g0FpYweOUNlGbLRFSVZ6B_jOHtZkoF2PJ2kzkfXYuGWtv5Gz4Lezs4k-GpdnIfLhd
    Qehb9XAUzI3U9STOwY>
X-ME-Received: <xmr:g0FpYywbu96AlGAnCbO8pxVm-evIPMKZQ18tkXozsFtBgv3un4xVJdE8eDbuMjxtdVt4fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:g0FpY-OFh2k_HELe4m_oz_js7ao3OCpHmYZ0ocVuNYSIynjrq0JBIg>
    <xmx:g0FpY_-3hTSm5hWkEC44pN-1CBX8UtzCGnQtnH1u3jJ_nrziYgLOYA>
    <xmx:g0FpY-UNOcJggApn5U-KF-OzDyjZTDovoxUnaDDcLMc1UcsBxwy23Q>
    <xmx:g0FpY8hHbfapt15iQmOXkMAMki5HPw4lf7zIufl8x5ILBDgZ26DQIQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 12:33:54 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 96A5310964A; Mon,  7 Nov 2022 20:33:52 +0300 (+03)
Date:   Mon, 7 Nov 2022 20:33:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <20221107173352.nx5zu67umwhuccir@box.shutemov.name>
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
 <20221025001722.17466-6-kirill.shutemov@linux.intel.com>
 <dd9e8b36-2421-6142-764a-f44b891b9774@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9e8b36-2421-6142-764a-f44b891b9774@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:50:51AM -0800, Andy Lutomirski wrote:
> > @@ -21,6 +22,30 @@ static inline bool pagefault_disabled(void);
> >   # define WARN_ON_IN_IRQ()
> >   #endif
> > +#ifdef CONFIG_X86_64
> > +/*
> > + * Mask out tag bits from the address.
> > + *
> > + * Magic with the 'sign' allows to untag userspace pointer without any branches
> > + * while leaving kernel addresses intact.
> > + */
> > +#define untagged_addr(mm, addr)	({					\
> > +	u64 __addr = (__force u64)(addr);				\
> > +	s64 sign = (s64)__addr >> 63;					\
> > +	__addr &= (mm)->context.untag_mask | sign;			\
> > +	(__force __typeof__(addr))__addr;				\
> > +})
> > +
> 
> I think this implementation is correct, but I'm wondering if there are any
> callers of untagged_addr that actually need to preserve kernel addresses.
> Are there?  (There certainly *were* back when we had set_fs().)

I don't think there's any.

CONFIG_KASAN_SW_TAGS uses untagged_addr() on kernel addresses, but it is
only enabled on arm64. On x86, it will use CR4.LAM_SUP and the enabling
would require a new helper for untagging kernel addresses.

That said, I would rather stay on the safe side.

> I'm also mildly uneasy about a potential edge case.  Naively, one would
> expect:
> 
> untagged_addr(current->mm, addr) + size ==
> untagged_addr(current->mm, addr + size)
> 
> at least for an address that is valid enough to be potentially dereferenced.
> This isn't true any more for size that overflows into the tag bit range.

That's definitely a new edge case.

From quick grep, the only CONFIG_KASAN_SW_TAGS code obviously does
arithmetics on address before untagging.

> I *think* we're okay though -- __access_ok requires that addr <= limit -
> size, so any range that overflows into tag bits will be rejected even if the
> entire range consists of valid (tagged) user addresses.

True.

> So:
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>

Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
