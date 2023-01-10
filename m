Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880A66392A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAJGR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjAJGR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:17:27 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF621A399
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:17:26 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F290A3200994;
        Tue, 10 Jan 2023 01:17:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Jan 2023 01:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673331441; x=1673417841; bh=hY
        lkSoI0PLF6Nkqz+NXXc2oNHQRDgQQ+vdlc/JfCbRk=; b=ZlDbZsL6BOeb+mlKoe
        LRFnbf6UtVeuiz6uru5aYDJXbWpAAV5HxbzNGFXZZvUVVB7op9dmdWGNgBwlz0RO
        7mzoXnsVCa+x06bYcjkmm5d5fu90+KcKjrD6UHyqVx5IMcQRgHkoLw9pfu+j8AaC
        71bU+vlIyyhAYS0SyZnCSMXWUhKROT5zwvaefY+YFhlBBXn8qIlaZGNd5N8VWRQj
        14caZPumJLeM7WTPGeWHUn7USScx32RVd36Eiuc+F2c3dmYWb+kiFUpYkcN69e0C
        VEd6W6B1F2Xfbj4Mc/R47woVkgN1Gl9voyR2A3Hkzx+qzlrBATWKGjeAaeqAhhFV
        +Tvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673331441; x=1673417841; bh=hYlkSoI0PLF6Nkqz+NXXc2oNHQRD
        gQQ+vdlc/JfCbRk=; b=QoYvydhjdX9cioNRmCS+exDCwvp2G5j597G/4smDqhFp
        c4YcX0DZymKSEcPQRR1DeAp4yw+27wgwh/nzNMA9XH7nx6mFNAAA0TAD+Twv3fnP
        PtUuJ3w74R/o0QowodK8Do9dm9VrYM6/o/l0WfY8xhXkCQgObGUNpPh05t+Y4Lh+
        pWoOrlZIJSeYno/e2uoZq5AOQPM4q84Vl+UQI50W50JLEypaLYYYAtdxv+QUYXnE
        LEgfZAvYfFdo5wDQfmi5hsdN+OSVdWVDxkaVE3XrRrtwBnjKhj5yZzYElWRJ/Cdr
        5t9hjj0mbaM6utnJR7+Q/Lh+dFFdO0mW2HwUnuxhhw==
X-ME-Sender: <xms:8AK9YyUSBsFZESOZBnPWUxRvA_pOWv1if2zm-cyvHQpmPrw7TLouzg>
    <xme:8AK9Y-kT9btLV6Beh2HQw-Jh6Pjs-J7QS9Bvx9LxvcHbC01C9iKchfkkC4xjHh2wK
    HM958vz4eRNgCa6MfY>
X-ME-Received: <xmr:8AK9Y2YoaZdNgIexQlnXA0SByj-OLj_invPUuMOuz4b_md9eXDPAL_ZlqUzKAuZCHPUygg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeejgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:8AK9Y5VD_eiiOFbQekMB11yaKUTc1E1qYXGqvySTd_E-JOEHo8V2SQ>
    <xmx:8AK9Y8loLX6jkHByYKsWAo_YxfvUKy4TSPPAbbNOJsfANpR4bcb1rQ>
    <xmx:8AK9Y-fPrO21ZePmduvUjujc4WLVQeNWa_xXguNn9mJehC0JE4VyNA>
    <xmx:8QK9Y7ekel8EiJvSOmwsEZ_WfIxei9UI_r3cOjN1gkz9S8IcISwLow>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jan 2023 01:17:20 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C9FFB109BD2; Tue, 10 Jan 2023 09:17:16 +0300 (+03)
Date:   Tue, 10 Jan 2023 09:17:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "tarasmadan@google.com" <tarasmadan@google.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv13 06/16] x86/mm: Provide arch_prctl() interface for LAM
Message-ID: <20230110061716.tcy74yseydbaeqjo@box.shutemov.name>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-7-kirill.shutemov@linux.intel.com>
 <ed28e8a56b64f1bb3855a5d2a9b40672af9d6a14.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed28e8a56b64f1bb3855a5d2a9b40672af9d6a14.camel@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:55:45PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-12-27 at 06:08 +0300, Kirill A. Shutemov wrote:
> > Add a couple of arch_prctl() handles:
> > 
> >  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required
> > number
> >    of tag bits. It is rounded up to the nearest LAM mode that can
> >    provide it. For now only LAM_U57 is supported, with 6 tag bits.
> > 
> >  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
> >    bits located in the address.
> > 
> >  - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can
> > request.
> >    Zero if LAM is not supported.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/mmu.h        |  2 ++
> >  arch/x86/include/uapi/asm/prctl.h |  4 +++
> >  arch/x86/kernel/process.c         |  3 +++
> >  arch/x86/kernel/process_64.c      | 44
> > ++++++++++++++++++++++++++++++-
> >  4 files changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> > index ed72fcd2292d..54e4a3e9b5c5 100644
> > --- a/arch/x86/include/asm/mmu.h
> > +++ b/arch/x86/include/asm/mmu.h
> > @@ -12,6 +12,8 @@
> >  #define MM_CONTEXT_UPROBE_IA32		0
> >  /* vsyscall page is accessible on this MM */
> >  #define MM_CONTEXT_HAS_VSYSCALL		1
> > +/* Do not allow changing LAM mode */
> > +#define MM_CONTEXT_LOCK_LAM		2
> >  
> >  /*
> >   * x86 has arch-specific MMU state beyond what lives in mm_struct.
> > diff --git a/arch/x86/include/uapi/asm/prctl.h
> > b/arch/x86/include/uapi/asm/prctl.h
> > index 500b96e71f18..a31e27b95b19 100644
> > --- a/arch/x86/include/uapi/asm/prctl.h
> > +++ b/arch/x86/include/uapi/asm/prctl.h
> > @@ -20,4 +20,8 @@
> >  #define ARCH_MAP_VDSO_32		0x2002
> >  #define ARCH_MAP_VDSO_64		0x2003
> >  
> > +#define ARCH_GET_UNTAG_MASK		0x4001
> > +#define ARCH_ENABLE_TAGGED_ADDR		0x4002
> > +#define ARCH_GET_MAX_TAG_BITS		0x4003
> > +
> >  #endif /* _ASM_X86_PRCTL_H */
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index ef6bde1d40d8..cc0677f58f42 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -162,6 +162,9 @@ int copy_thread(struct task_struct *p, const
> > struct kernel_clone_args *args)
> >  
> >  	savesegment(es, p->thread.es);
> >  	savesegment(ds, p->thread.ds);
> > +
> > +	if (p->mm && (clone_flags & (CLONE_VM | CLONE_VFORK)) ==
> > CLONE_VM)
> > +		set_bit(MM_CONTEXT_LOCK_LAM, &p->mm->context.flags);
> >  #else
> >  	p->thread.sp0 = (unsigned long) (childregs + 1);
> >  	savesegment(gs, p->thread.gs);
> > diff --git a/arch/x86/kernel/process_64.c
> > b/arch/x86/kernel/process_64.c
> > index 8b06034e8c70..fef127ed79b6 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -743,6 +743,39 @@ static long prctl_map_vdso(const struct
> > vdso_image *image, unsigned long addr)
> >  }
> >  #endif
> >  
> > +#define LAM_U57_BITS 6
> > +
> > +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned
> > long nr_bits)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_LAM))
> > +		return -ENODEV;
> > +
> > +	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags))
> > +		return -EBUSY;
> 
> Since this bit doesn't get set on vfork, you might be able to work
> around this by enabling LAM in a vforked task, then enabling it again
> after returning to the parent.

I don't think so.

Yes, child can enable LAM after vfork(), but it will set the flag, so
parent won't be able to enable it again. And there's no cuncurency between
parent and child due to vfork() semantics.

Anyway, I will move the check inside mmap lock. It may clarify situation
for a reader.

> > +
> > +	if (mmap_write_lock_killable(mm))
> > +		return -EINTR;
> > +
> > +	if (!nr_bits) {
> > +		mmap_write_unlock(mm);
> > +		return -EINVAL;
> > +	} else if (nr_bits <= LAM_U57_BITS) {
> > +		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
> > +		mm->context.untag_mask =  ~GENMASK(62, 57);
> > +	} else {
> > +		mmap_write_unlock(mm);
> > +		return -EINVAL;
> > +	}
> > +
> > +	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
> 
> mm might not be from the current task if it came from
> PTRACE_ARCH_PRCTL, so then this would write to the wrong CR3. Maybe for
> simplicity just return an error if task != current.

Oh. Forgot about PTRACE_ARCH_PRCTL. Yes, will add the check.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
