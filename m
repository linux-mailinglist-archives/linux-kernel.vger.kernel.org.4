Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CB659F43
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 01:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbiLaAKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 19:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiLaAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 19:10:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884591CB3E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:10:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 194095C00F9;
        Fri, 30 Dec 2022 19:10:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 30 Dec 2022 19:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1672445435; x=1672531835; bh=Km
        Ti3OMN2+n56vjLr46C+M5tll/zcVZms2stchBnkng=; b=MwiC+1jZ1eM+UoI3JW
        kYRUMbTW2YZKF1urCZ74QPXI1dj/s2lXhjWTmTRgRutwlbo9SB3E/qBokOnWd3Ph
        /PiM7xXzHT3f90SjmRGRnSSORpFmuZEPjsYc5Qkvo492KcaTwIw68EXnzjwDDiTF
        5wQOoHARV19dW74PD1A6mYw2urCmQHF7oJ+OTW6J5SyHLgMCcu8baSTsUamvnszg
        wMKBAwOzORfgdTH4ZiRVF4HTUQikMn/O9ZIDAX23EwN/WGKhjo5DPpvPSStOV48f
        /GZ8FxqauaIxAhiBDDkX1Pyi8ItiNoPPFEao6GwY/GwvZ25BRU9dyLyTUUxQOQYX
        tx/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672445435; x=1672531835; bh=KmTi3OMN2+n56vjLr46C+M5tll/z
        cVZms2stchBnkng=; b=Sw9BvIDUHSpJTGhjyhvIwqVQ9qAiddEYi0uLWz27A3fj
        115fyMpgCSixXV6zHqF+3cLxEKP04STcOCeuFnBq/BwHHGtg6dK7izoDAdTH5E64
        dLKy9nsEIgXVkC5dgm1Zo/PpU1g8j8KHdnkfvxOQ9XpaErCqFPqQ9lxYfupvZNsa
        9/KWVSZLiaeApSUGrmbkX68BVDa/QztnFjmTMmGPSzwYBApx+Ufs2kEs/9HpqSZJ
        c0ghF+l8r7IxCnUj9CumETbE3s4hiHqfcjqXBXTlgcES7L5PL/4pU1AvWMg67Lz3
        Z09ZqAJvhl03RJfu2jGkHl57YL9hojOC+sDlrUABbw==
X-ME-Sender: <xms:-n2vY7VZKHu1-w1-QFYTZdMLGcf27mXhjFccPaUxLW9QnjYhV6oruw>
    <xme:-n2vYznsmKG48yWhmQUmtWu8CUxJFt0taRJnbiO9JGggC08LK-9pr3K9UM09iv4O6
    1DiEdly8Tb6H3Cxnd8>
X-ME-Received: <xmr:-n2vY3YiRFxf__al95Ra-CwMkMXc4NyLASfvRuGB1AZwM1k4k7RaryiIwxD_i4EIW0kr9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepleetuefhfeekhfejheeluedugfdvtdelkedufeei
    vdfhlefhhfegffegheeigfeinecuffhomhgrihhnpehgvghtuhhsvghrrdhssgdpphhuth
    hushgvrhdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:-n2vY2UcpN3inJBFDIlUFmD_G9akWvbxmyB1chczalAR6X-StvCzqw>
    <xmx:-n2vY1mZws-tXW76ldaFz0dMyb7GDYcf1sbJNY5yu9RkhZRf3eOePA>
    <xmx:-n2vYzfdk1hpLGHXmg6hh6icBxw4wB2V0xBK-iGlFitqidlHTRl0HQ>
    <xmx:-32vY0cbgeHfggIHSAWPmnz_nhh5uGi0LiWiuGgbYVp9J3Uqx_dA0A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Dec 2022 19:10:33 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EDEB2109EF4; Sat, 31 Dec 2022 03:10:29 +0300 (+03)
Date:   Sat, 31 Dec 2022 03:10:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <20221231001029.5nckrhtmwahb65jo@box>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-6-kirill.shutemov@linux.intel.com>
 <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 11:10:31AM -0800, Linus Torvalds wrote:
> On Mon, Dec 26, 2022 at 7:08 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -21,6 +22,37 @@ static inline bool pagefault_disabled(void);
> >  # define WARN_ON_IN_IRQ()
> >  #endif
> >
> > +#ifdef CONFIG_X86_64
> 
> I think this should be CONFIG_ADDRESS_MASKING or something like that.
> 
> This is not a "64 vs 32-bit feature". This is something else.
> 
> Even if you then were to select it unconditionally for 64-bit kernels
> (but why would you?) it reads better if the #ifdef's make sense.

I hoped to get away without a new option. It leads to more ifdeffery, but
well...

> > +#define __untagged_addr(mm, addr)      ({                              \
> > +       u64 __addr = (__force u64)(addr);                               \
> > +       s64 sign = (s64)__addr >> 63;                                   \
> > +       __addr &= READ_ONCE((mm)->context.untag_mask) | sign;           \
> 
> Now the READ_ONCE() doesn't make much sense. There shouldn't be any
> data races on that thing.

True. Removed.

> Plus:
> 
> > +#define untagged_addr(addr) __untagged_addr(current->mm, addr)
> 
> I think this should at least allow caching it in 'current' without the
> mm indirection.
> 
> In fact, it might be even better off as a per-cpu variable.
> 
> Because it is now in somewhat crititcal code sections:
> 
> > -#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
> > +#define get_user(x,ptr)                                                        \
> > +({                                                                     \
> > +       might_fault();                                                  \
> > +       do_get_user_call(get_user,x,untagged_ptr(ptr)); \
> > +})
> 
> This is disgusting and wrong.
> 
> The whole reason we do do_get_user_call() as a function call is
> because we *don't* want to do this kind of stuff at the call sites. We
> used to inline it all, but with all the clac/stac and access_ok
> checks, it all just ended up ballooning so much that it was much
> better to make it a special function call with particular calling
> conventions.
> 
> That untagged_ptr() should be done in that asm function, not in every call site.
> 
> Now, the sad part is that we got *rid* of all this kind of crap not
> that long ago when Christoph cleaned up the old legacy set_fs() mess,
> and we were able to make the task limit be a constant (ok, be _two_
> constants, depending on LA57). So we'd have to re-introduce that nasty
> "look up task size dynamically". See commit 47058bb54b57 ("x86: remove
> address space overrides using set_fs()") for the removal that would
> have to be re-instated.
> 
> But see above about "maybe it should be a per-cpu variable" - and
> making that ALTERNATIVE th8ing even nastier.

I made it a per-cpu variable (outside struct tlb_state to be visible in
modules). __get/put_user_X() now have a single instruction to untag the
address and it is gated by X86_FEATURE_LAM.

Seems reasonable to me.

BTW, am I blind or we have no infrastructure to hookup static branches
from assembly?

I would be a better fit than ALTERNATIVE here. It would allow to defer
overhead until the first user of the feature.

Is there any fundamental reason for this or just no demand?

> Another alternative mght be to *only* test the sign bit in the
> get_user/put_user functions, and just take the fault instead. Right
> now we warn about non-canonical addresses because it implies somebody
> might have missed an access_ok(), but we'd just mark those
> get_user/put_user accesses special.
> 
> That would get this all entirely off the critical path. Most other
> address masking is for relatively rare things (ie mmap/munmap), but
> the user accesses are hot.
> 
> Hmm?

Below is fixup that suppose to address your concerns. I will also extend
selftests to cover get/put_user().

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..211869aa618d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2290,6 +2290,17 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 
 	  If unsure, leave at the default value.
 
+config ADDRESS_MASKING
+	bool "Linear Address Masking support"
+	depends on X86_64
+	help
+	  Linear Address Masking (LAM) modifies the checking that is applied
+	  to 64-bit linear addresses, allowing software to use of the
+	  untranslated address bits for metadata.
+
+	  The capability can be used for efficient address sanitizers (ASAN)
+	  implementation and for optimizations in JITs.
+
 config HOTPLUG_CPU
 	def_bool y
 	depends on SMP
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c44b56f7ffba..66be8acabe92 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -99,6 +99,12 @@
 # define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+# define DISABLE_LAM	0
+#else
+# define DISABLE_LAM	(1 << (X86_FEATURE_LAM & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -115,7 +121,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING)
-#define DISABLED_MASK12	0
+#define DISABLED_MASK12	(DISABLE_LAM)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 90d20679e4d7..0da5c227f490 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -44,7 +44,9 @@ typedef struct {
 
 #ifdef CONFIG_X86_64
 	unsigned long flags;
+#endif
 
+#ifdef CONFIG_ADDRESS_MASKING
 	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
 	unsigned long lam_cr3_mask;
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 4bc95c35cbd3..6ffc42dfd59d 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -91,7 +91,7 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 }
 #endif
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_ADDRESS_MASKING
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 {
 	return READ_ONCE(mm->context.lam_cr3_mask);
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 662598dea937..75bfaa421030 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_TLBFLUSH_H
 #define _ASM_X86_TLBFLUSH_H
 
-#include <linux/mm.h>
+#include <linux/mm_types.h>
 #include <linux/sched.h>
 
 #include <asm/processor.h>
@@ -12,6 +12,7 @@
 #include <asm/invpcid.h>
 #include <asm/pti.h>
 #include <asm/processor-flags.h>
+#include <asm/pgtable.h>
 
 void __flush_tlb_all(void);
 
@@ -53,6 +54,15 @@ static inline void cr4_clear_bits(unsigned long mask)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_ADDRESS_MASKING
+DECLARE_PER_CPU(u64, tlbstate_untag_mask);
+
+static inline u64 current_untag_mask(void)
+{
+	return this_cpu_read(tlbstate_untag_mask);
+}
+#endif
+
 #ifndef MODULE
 /*
  * 6 because 6 should be plenty and struct tlb_state will fit in two cache
@@ -101,7 +111,7 @@ struct tlb_state {
 	 */
 	bool invalidate_other;
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_ADDRESS_MASKING
 	/*
 	 * Active LAM mode.
 	 *
@@ -367,27 +377,29 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
 }
 #define huge_pmd_needs_flush huge_pmd_needs_flush
 
-#ifdef CONFIG_X86_64
-static inline unsigned long tlbstate_lam_cr3_mask(void)
+#ifdef CONFIG_ADDRESS_MASKING
+static inline  u64 tlbstate_lam_cr3_mask(void)
 {
-	unsigned long lam = this_cpu_read(cpu_tlbstate.lam);
+	u64 lam = this_cpu_read(cpu_tlbstate.lam);
 
 	return lam << X86_CR3_LAM_U57_BIT;
 }
 
-static inline void set_tlbstate_cr3_lam_mask(unsigned long mask)
+static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
 {
-	this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(cpu_tlbstate.lam,
+		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
 }
 
 #else
 
-static inline unsigned long tlbstate_lam_cr3_mask(void)
+static inline u64 tlbstate_lam_cr3_mask(void)
 {
 	return 0;
 }
 
-static inline void set_tlbstate_cr3_lam_mask(u64 mask)
+static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
 {
 }
 #endif
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1d931c7f6741..730649175191 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -13,6 +13,7 @@
 #include <asm/page.h>
 #include <asm/smap.h>
 #include <asm/extable.h>
+#include <asm/tlbflush.h>
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 static inline bool pagefault_disabled(void);
@@ -22,7 +23,7 @@ static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()
 #endif
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_ADDRESS_MASKING
 DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
 
 /*
@@ -31,31 +32,24 @@ DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
  * Magic with the 'sign' allows to untag userspace pointer without any branches
  * while leaving kernel addresses intact.
  */
-#define __untagged_addr(mm, addr)	({				\
+#define __untagged_addr(untag_mask, addr)	({			\
 	u64 __addr = (__force u64)(addr);				\
 	if (static_branch_likely(&tagged_addr_key)) {			\
 		s64 sign = (s64)__addr >> 63;				\
-		u64 mask = READ_ONCE((mm)->context.untag_mask);		\
-		__addr &= mask | sign;					\
+		__addr &= untag_mask | sign;				\
 	}								\
 	(__force __typeof__(addr))__addr;				\
 })
 
-#define untagged_addr(addr) __untagged_addr(current->mm, addr)
+#define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)
 
 #define untagged_addr_remote(mm, addr)	({				\
 	mmap_assert_locked(mm);						\
-	__untagged_addr(mm, addr);					\
+	__untagged_addr((mm)->context.untag_mask, addr);		\
 })
 
-#define untagged_ptr(ptr)	({					\
-	u64 __ptrval = (__force u64)(ptr);				\
-	__ptrval = untagged_addr(__ptrval);				\
-	(__force __typeof__(ptr))__ptrval;				\
-})
 #else
-#define untagged_addr(addr)	(addr)
-#define untagged_ptr(ptr)	(ptr)
+#define untagged_addr(addr)    (addr)
 #endif
 
 /**
@@ -167,7 +161,7 @@ extern int __get_user_bad(void);
 #define get_user(x,ptr)							\
 ({									\
 	might_fault();							\
-	do_get_user_call(get_user,x,untagged_ptr(ptr));	\
+	do_get_user_call(get_user,x,ptr);				\
 })
 
 /**
@@ -270,7 +264,7 @@ extern void __put_user_nocheck_8(void);
  */
 #define put_user(x, ptr) ({						\
 	might_fault();							\
-	do_put_user_call(put_user,x,untagged_ptr(ptr));			\
+	do_put_user_call(put_user,x,ptr);				\
 })
 
 /**
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index add85615d5ae..1f61e3a13b4f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -743,6 +743,7 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
 DEFINE_STATIC_KEY_FALSE(tagged_addr_key);
 EXPORT_SYMBOL_GPL(tagged_addr_key);
 
@@ -775,7 +776,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	}
 
 	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_cr3_lam_mask(mm->context.lam_cr3_mask);
+	set_tlbstate_lam_mode(mm);
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
 	mmap_write_unlock(mm);
@@ -783,6 +784,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	static_branch_enable(&tagged_addr_key);
 	return 0;
 }
+#endif
 
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
@@ -871,6 +873,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
+#ifdef CONFIG_ADDRESS_MASKING
 	case ARCH_GET_UNTAG_MASK:
 		return put_user(task->mm->context.untag_mask,
 				(unsigned long __user *)arg2);
@@ -884,6 +887,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			return put_user(0, (unsigned long __user *)arg2);
 		else
 			return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
+#endif
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index b70d98d79a9d..22e92236e8f6 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -35,6 +35,13 @@
 #include <asm/smap.h>
 #include <asm/export.h>
 
+#ifdef CONFIG_ADDRESS_MASKING
+#define UNTAG_ADDR \
+	ALTERNATIVE "", __stringify(and PER_CPU_VAR(tlbstate_untag_mask), %rax), X86_FEATURE_LAM
+#else
+#define UNTAG_ADDR
+#endif
+
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
 #ifdef CONFIG_X86_5LEVEL
@@ -48,6 +55,7 @@
 
 	.text
 SYM_FUNC_START(__get_user_1)
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
@@ -62,6 +70,7 @@ SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
 SYM_FUNC_START(__get_user_2)
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
@@ -76,6 +85,7 @@ SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
 SYM_FUNC_START(__get_user_4)
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
@@ -91,6 +101,7 @@ EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
 #ifdef CONFIG_X86_64
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_DX,%_ASM_AX
 	jae bad_get_user
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 32125224fcca..9e0276c553a8 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -33,6 +33,13 @@
  * as they get called from within inline assembly.
  */
 
+#ifdef CONFIG_ADDRESS_MASKING
+#define UNTAG_ADDR \
+	ALTERNATIVE "", __stringify(and PER_CPU_VAR(tlbstate_untag_mask), %rcx), X86_FEATURE_LAM
+#else
+#define UNTAG_ADDR
+#endif
+
 #ifdef CONFIG_X86_5LEVEL
 #define LOAD_TASK_SIZE_MINUS_N(n) \
 	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rbx), \
@@ -44,6 +51,7 @@
 
 .text
 SYM_FUNC_START(__put_user_1)
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(0)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
@@ -66,6 +74,7 @@ SYM_FUNC_END(__put_user_nocheck_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
 SYM_FUNC_START(__put_user_2)
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
@@ -88,6 +97,7 @@ SYM_FUNC_END(__put_user_nocheck_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
 SYM_FUNC_START(__put_user_4)
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(3)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
@@ -110,6 +120,7 @@ SYM_FUNC_END(__put_user_nocheck_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
 SYM_FUNC_START(__put_user_8)
+	UNTAG_ADDR
 	LOAD_TASK_SIZE_MINUS_N(7)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d3987359d441..be5c7d1c0265 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1044,6 +1044,11 @@ __visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) = {
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
 };
 
+#ifdef CONFIG_ADDRESS_MASKING
+DEFINE_PER_CPU(u64, tlbstate_untag_mask);
+EXPORT_PER_CPU_SYMBOL(tlbstate_untag_mask);
+#endif
+
 void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
 {
 	/* entry 0 MUST be WB (hardwired to speed up translations) */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9d1e7a5f141c..8c330a6d0ece 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -635,7 +635,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		barrier();
 	}
 
-	set_tlbstate_cr3_lam_mask(new_lam);
+	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -726,7 +726,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_cr3_lam_mask(0);
+	set_tlbstate_lam_mode(mm);
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
