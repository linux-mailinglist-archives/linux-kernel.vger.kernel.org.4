Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766E064ED67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiLPPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiLPPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:05:47 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414222608
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:05:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B796A5C0126;
        Fri, 16 Dec 2022 10:05:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 10:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1671203137; x=1671289537; bh=Jb
        W3KEtZfZariLm5oItAxfW7tsPaibDSdTXl5iS5g1w=; b=lQiQ/aviIPcZ8eEkqv
        kUnFLOhezi3mODxkEL13qGWr1WG4dYVwRfp8zOZLXnRwI8l0ey3nrt1uZKTUwQVg
        CcVhYKprcXTDfBpJgfvCq6U1YnwuTpy89j6X/Qihy4BK4F8SfC+DLQk5WJTmfTDh
        cjXt7yw8/Z4dJnSYrACWBz+FTi5+mBob0JkndWEvTj8r99733ngv7/uVV/4TmnEw
        CZTEXMuTc6ntg0Je0AXctQuiVGF9JtUvb3ACJx10pmSvUJOcZmJi6U/H6QE/MdjH
        /XSyDxKXPX03npbxpIFZZwhfyVymzspVxk5jc9inFDzWRZxT4+lVXuIIliYFCi3p
        f6tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671203137; x=1671289537; bh=JbW3KEtZfZariLm5oItAxfW7tsPa
        ibDSdTXl5iS5g1w=; b=IcAQeGrjO7/rgcaZfErQIFm7GW4LNpNeceoZCM7MRmuG
        1IRFqNVoBHgfh58CmL9h2bPl2eLfxzXeUsDM5H2VBLIo3vp6kJmKs8C+vP/63TV4
        0VDiDbgDyLtI9DOipnNGEQsVV8pLt5Q02s8nJoXdUjuriKN1ABEE5bXXAGj1PPT6
        39hI8myfp85pOCXs3ZD36txbqw1Op1Gm5hBaMSAOna5nEHC/5VVxprMIqOz6aVZW
        zp6ADScpyEDidltwFGNDSPEuUuYxR2UmtvOWfQ9kJVnwc51AectEjUsNZW1w8FXQ
        BOlMhzOhWlosTKKaVTjrTgZSqMxh8OoJV/AKTcpTKg==
X-ME-Sender: <xms:QYmcY-WOo_HuylyaUo-kr4drOJYT51XSGFL_lea6x44jpo3PqKBBFg>
    <xme:QYmcY6mxF27ahRQldEoDVsTpXLLe86qK4bV7JnrcM1-q66XR-eQWEf0Ma_KgnhT0I
    KnqH1Z_BHfUgXDYyAM>
X-ME-Received: <xmr:QYmcYybT4HbiBn-wS2eeRBl54EPJiDB11iYH75wTp1z2zyyZOBr35i5z983WUragXor1fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:QYmcY1V3WXuxsjBzZxsAe0OZAnLYn3K5X8PZ-Q9s0VU9nObclrkLwg>
    <xmx:QYmcY4nx7dqXIWKFHBUbobPYxVRD6JL6cIS5q_nmfb-MMdlDXKiyAQ>
    <xmx:QYmcY6eJg_ewCK1MU45J5ZqLsxpm-3leUxKrqmoD5Gz2nkadDJNMsg>
    <xmx:QYmcY3tYRPlI8pXyYXGwZzcDCrACaOd1ogLm_sYUDjdw0FtSASDUQg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Dec 2022 10:05:36 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CA321100557; Fri, 16 Dec 2022 18:05:32 +0300 (+03)
Date:   Fri, 16 Dec 2022 18:05:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     kirill.shutemov@linux.intel.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: Re: [GIT PULL] x86/mm for 6.2
Message-ID: <20221216150532.ll4oyff2tlrisqsh@box.shutemov.name>
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
 <20221215123007.cagd7qiidehqd77k@box.shutemov.name>
 <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
 <20221216021645.jn576zrhadocpt66@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216021645.jn576zrhadocpt66@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 05:16:45AM +0300, kirill.shutemov@linux.intel.com wrote:
> On Thu, Dec 15, 2022 at 09:17:11AM -0800, Linus Torvalds wrote:
> >  - make thread creation lock it (and unlock it on creating a new mm at
> > execve, but not fork).
> > 
> > And yes, I would actually suggest that _any_ thread creation locks it,
> > so that you never *EVER* have any issues with "oh, now I need to
> > synchronize with other threads". A process can set its LAM state at
> > startup, not in the middle of running!
> 
> By thread creation, you mean CLONE_VM, right?
> 
> Do we care to avoid locking for CLONE_VFORK case? Seems excessive.
> 
> > Note that io_uring will automatically do that locking, because it does
> > that thread creation (create_io_thread()). So io_uring threads won't
> > even be a special case.
> 
> I've missed that io_uring does not use kthread_use_mm() anymore. But what
> about other kthread_use_mm() users?
> 
> I did not find concrete cases where missing LAM setup would breaks things,
> but I cannot prove opposite too.
> 
> kthread_use_mm() usage is suspicious in amdkfd, but I donno.
> 
> io_uring was a clear before it moved away from kthread_use_mm().

Below is preliminary fixup that suppose to address the issue. It does not
include change to untagged_addr() interface to avoid the clutter.

LAM mode kept per-mm, but cannot be changed after the first thread has
spawn (or LAM enabled). Bit in mm->context.flags is used to indicate LAM
mode lock.

I've added few test cases for new limitations around threads.

kthread_use_mm() should be safe as long as no arch actually implements
per-thread tagging enabling.

Any comments?

If looks okay, I will integrate the fixup into the LAM patchset properly.
Or maybe you want an incremental patchset on top?

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4af81df133ee..ed320e145cf9 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -317,7 +317,7 @@ static struct vm_area_struct gate_vma __ro_after_init = {
 struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 #ifdef CONFIG_COMPAT
-	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
+	if (!mm || test_bit(MM_CONTEXT_HAS_VSYSCALL, &mm->context.flags))
 		return NULL;
 #endif
 	if (vsyscall_mode == NONE)
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 1215b0a714c9..4e7e8d9893de 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -9,11 +9,13 @@
 #include <linux/bits.h>
 
 /* Uprobes on this MM assume 32-bit code */
-#define MM_CONTEXT_UPROBE_IA32		BIT(0)
+#define MM_CONTEXT_UPROBE_IA32		0
 /* vsyscall page is accessible on this MM */
-#define MM_CONTEXT_HAS_VSYSCALL		BIT(1)
+#define MM_CONTEXT_HAS_VSYSCALL		1
 /* Allow LAM and SVA coexisting */
-#define MM_CONTEXT_FORCE_TAGGED_SVA	BIT(2)
+#define MM_CONTEXT_FORCE_TAGGED_SVA	2
+/* Do not allow changing LAM mode */
+#define MM_CONTEXT_LOCK_LAM		3
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
@@ -41,7 +43,7 @@ typedef struct {
 #endif
 
 #ifdef CONFIG_X86_64
-	unsigned short flags;
+	unsigned long flags;
 
 	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
 	unsigned long lam_cr3_mask;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 32483ab3f763..4bc95c35cbd3 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -118,7 +118,7 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
 {
 	return !mm_lam_cr3_mask(mm) ||
-		(mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVA);
+		test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags);
 }
 #else
 
@@ -228,7 +228,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 static inline bool is_64bit_mm(struct mm_struct *mm)
 {
 	return	!IS_ENABLED(CONFIG_IA32_EMULATION) ||
-		!(mm->context.flags & MM_CONTEXT_UPROBE_IA32);
+		!test_bit(MM_CONTEXT_UPROBE_IA32, &mm->context.flags);
 }
 #else
 static inline bool is_64bit_mm(struct mm_struct *mm)
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index bd92e1ee1c1a..6286885dc1e2 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -35,7 +35,7 @@ DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
 	u64 __addr = (__force u64)(addr);				\
 	if (static_branch_likely(&tagged_addr_key)) {			\
 		s64 sign = (s64)__addr >> 63;				\
-		__addr &= (mm)->context.untag_mask | sign;		\
+		__addr &= READ_ONCE((mm)->context.untag_mask) | sign;	\
 	}								\
 	(__force __typeof__(addr))__addr;				\
 })
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index d1e83ba21130..9bcec8195714 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -162,6 +162,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
+
+	if (p->mm && (clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM)
+		set_bit(MM_CONTEXT_LOCK_LAM, &p->mm->context.flags);
 #else
 	p->thread.sp0 = (unsigned long) (childregs + 1);
 	savesegment(gs, p->thread.gs);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b06de18215ce..7b8df4769486 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -671,7 +671,7 @@ void set_personality_64bit(void)
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
 	if (current->mm)
-		current->mm->context.flags = MM_CONTEXT_HAS_VSYSCALL;
+		__set_bit(MM_CONTEXT_HAS_VSYSCALL, &current->mm->context.flags);
 
 	/* TBD: overwrites user setup. Should have two bits.
 	   But 64bit processes have always behaved this way,
@@ -708,7 +708,7 @@ static void __set_personality_ia32(void)
 		 * uprobes applied to this MM need to know this and
 		 * cannot use user_64bit_mode() at that time.
 		 */
-		current->mm->context.flags = MM_CONTEXT_UPROBE_IA32;
+		__set_bit(MM_CONTEXT_UPROBE_IA32, &current->mm->context.flags);
 	}
 
 	current->personality |= force_personality32;
@@ -746,31 +746,6 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 DEFINE_STATIC_KEY_FALSE(tagged_addr_key);
 EXPORT_SYMBOL_GPL(tagged_addr_key);
 
-static void enable_lam_func(void *mm)
-{
-	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	unsigned long lam_mask;
-	unsigned long cr3;
-
-	if (loaded_mm != mm)
-		return;
-
-	lam_mask = READ_ONCE(loaded_mm->context.lam_cr3_mask);
-
-	/*
-	 * Update CR3 to get LAM active on the CPU.
-	 *
-	 * This might not actually need to update CR3 if a context switch
-	 * happened between updating 'lam_cr3_mask' and running this IPI
-	 * handler.  Update it unconditionally for simplicity.
-	 */
-	cr3 = __read_cr3();
-	cr3 &= ~(X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
-	cr3 |= lam_mask;
-	write_cr3(cr3);
-	set_tlbstate_cr3_lam_mask(lam_mask);
-}
-
 #define LAM_U57_BITS 6
 
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
@@ -780,36 +755,27 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
 		return -ENODEV;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
-	/* Already enabled? */
-	if (mm->context.lam_cr3_mask) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags))
+		return -EBUSY;
 
 	if (mm_valid_pasid(mm) &&
-	    !(mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVA)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	    !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
+		return -EBUSY;
 
 	if (!nr_bits) {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	} else if (nr_bits <= LAM_U57_BITS) {
 		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
 		mm->context.untag_mask =  ~GENMASK(62, 57);
 	} else {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
+	set_tlbstate_cr3_lam_mask(mm->context.lam_cr3_mask);
+	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+
 	static_branch_enable(&tagged_addr_key);
-out:
-	mmap_write_unlock(mm);
 	return ret;
 }
 
@@ -906,10 +872,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
 	case ARCH_FORCE_TAGGED_SVA:
-		if (mmap_write_lock_killable(task->mm))
-			return -EINTR;
-		task->mm->context.flags |= MM_CONTEXT_FORCE_TAGGED_SVA;
-		mmap_write_unlock(task->mm);
+		set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
 		return 0;
 	case ARCH_GET_MAX_TAG_BITS:
 		if (!cpu_feature_enabled(X86_FEATURE_LAM))
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 8934c32e923c..bfe70d45dd1e 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -33,14 +33,8 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	    min == 0 || max < min)
 		return -EINVAL;
 
-	/* Serialize against address tagging enabling */
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
-	if (!arch_pgtable_dma_compat(mm)) {
-		mmap_write_unlock(mm);
+	if (!arch_pgtable_dma_compat(mm))
 		return -EBUSY;
-	}
 
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
@@ -57,7 +51,6 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		mm_pasid_set(mm, pasid);
 out:
 	mutex_unlock(&iommu_sva_lock);
-	mmap_write_unlock(mm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 52a876a7ccb8..93e6089164b6 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -12,6 +13,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <inttypes.h>
+#include <sched.h>
 
 #include <sys/uio.h>
 #include <linux/io_uring.h>
@@ -50,6 +52,8 @@
 
 #define PAGE_SIZE               (4 << 10)
 
+#define STACK_SIZE		65536
+
 #define barrier() ({						\
 		   __asm__ __volatile__("" : : : "memory");	\
 })
@@ -731,6 +735,75 @@ static int handle_inheritance(struct testcases *test)
 	return 0;
 }
 
+static int thread_fn_get_lam(void *arg)
+{
+	return get_lam();
+}
+
+static int thread_fn_set_lam(void *arg)
+{
+	struct testcases *test = arg;
+
+	return set_lam(test->lam);
+}
+
+static int handle_thread(struct testcases *test)
+{
+	char stack[STACK_SIZE];
+	int ret, child_ret;
+	int lam = 0;
+	pid_t pid;
+
+	/* Set LAM mode in parent process */
+	if (!test->later) {
+		lam = test->lam;
+		if (set_lam(lam) != 0)
+			return 1;
+	}
+
+	pid = clone(thread_fn_get_lam, stack + STACK_SIZE,
+		    SIGCHLD | CLONE_FILES | CLONE_FS | CLONE_VM, NULL);
+	if (pid < 0) {
+		perror("Clone failed.");
+		return 1;
+	}
+
+	waitpid(pid, &child_ret, 0);
+	ret = WEXITSTATUS(child_ret);
+
+	if (lam != ret)
+		return 1;
+
+	if (test->later) {
+		if (set_lam(test->lam) != 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int handle_thread_enable(struct testcases *test)
+{
+	char stack[STACK_SIZE];
+	int ret, child_ret;
+	int lam = test->lam;
+	pid_t pid;
+
+	pid = clone(thread_fn_set_lam, stack + STACK_SIZE,
+		    SIGCHLD | CLONE_FILES | CLONE_FS | CLONE_VM, test);
+	if (pid < 0) {
+		perror("Clone failed.");
+		return 1;
+	}
+
+	waitpid(pid, &child_ret, 0);
+	ret = WEXITSTATUS(child_ret);
+
+	if (lam != ret)
+		return 1;
+
+	return 0;
+}
 static void run_test(struct testcases *test, int count)
 {
 	int i, ret = 0;
@@ -846,6 +919,25 @@ static struct testcases inheritance_cases[] = {
 		.test_func = handle_inheritance,
 		.msg = "FORK: LAM_U57, child process should get LAM mode same as parent\n",
 	},
+	{
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread,
+		.msg = "THREAD: LAM_U57, child thread should get LAM mode same as parent\n",
+	},
+	{
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread_enable,
+		.msg = "THREAD: [NEGATIVE] Enable LAM in child.\n",
+	},
+	{
+		.expected = 1,
+		.later = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread,
+		.msg = "THREAD: [NEGATIVE] Enable LAM in parent after thread created.\n",
+	},
 	{
 		.expected = 0,
 		.lam = LAM_U57_BITS,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a587e34fc750..14d7e7d72f14 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1943,22 +1943,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	if (mem->guest_phys_addr & (PAGE_SIZE - 1))
 		return -EINVAL;
-
-	/* Serialize against tagging enabling */
-	if (mmap_read_lock_killable(kvm->mm))
-		return -EINTR;
-
 	/* We can read the guest memory with __xxx_user() later on. */
 	if ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
 	    (mem->userspace_addr != untagged_addr(kvm->mm, mem->userspace_addr)) ||
 	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
-			mem->memory_size)) {
-		mmap_read_unlock(kvm->mm);
+			mem->memory_size))
 		return -EINVAL;
-	}
-
-	mmap_read_unlock(kvm->mm);
-
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_MEM_SLOTS_NUM)
 		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
