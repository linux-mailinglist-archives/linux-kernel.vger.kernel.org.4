Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63476746F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjASXNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjASXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:13:00 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D61BDB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:07:06 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DBF795C00A5;
        Thu, 19 Jan 2023 18:07:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 18:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674169623; x=1674256023; bh=r+
        +m5npef9Z2Dvz6d7fU0ciFE3OnTgWcXxCyHr666VU=; b=wmotPjFAJWqkqA21x0
        cAZp2OnMhLCCfxuYtNZwsqqRJnqVp8tLaSFJ5lHIKb9lX5NmFVjdna+XwwLPiSCS
        JKHpVvKfkDb6mWvwt8btGty/zakCbGGFPBVVA1LG2qRyV18GYs9a4AtuU/kj9lVl
        RNZQC2fNX36wZWuvNHDUd4KZsp+AEti9oVV0fipolvcOUxsvI8Z1Vqjw1BU+QBs6
        zgt4sA8IYEbaSTopbvNqf1p34NXD4WI1S7BzZ9xwAZB0t5uXmuwFMR9AFLDOXfq4
        2gnbIcRDfL011FrGhwMHdQt/WzXtPV/GcBWGSEpOooDQ1ZAP8EE0wSvXQ7zark0x
        fqvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674169623; x=1674256023; bh=r++m5npef9Z2Dvz6d7fU0ciFE3On
        TgWcXxCyHr666VU=; b=Sz4qXjKs3PmsXl4+Px/iD/KqEPtr7XnnAQTl0mypVQ9H
        zC7/3hNR7zcP+k68FtpMsIy8xnok/4tB6zyBINRkgiTSZ1gTN1Mi0Q4/ZHK/pLZv
        y2ZwZINGZtfDu1dZXK+PeH+v/YXB9a9vwebs1zsl0OTtZhG/TgUOkLuQ5RODs5+y
        KTJRcDFCbS9lemnnabSRUNqU1GoX390gBrQOhNAqRC8/PtmdTM2PNh+ngkTemImB
        JJC/OJPAs2HPtXPYM2IBwlbrtDj5cXcqbLWIw7JCef5oUG1dkvIcsVx8b+pvc3B8
        Sjy1de+EDj/5IfK+nRkZBr+y1Dtm/SwTqMRvc6E4ag==
X-ME-Sender: <xms:F83JYxdc7ohf4RofjV72paaCMwZOrvLqV87zAg0qO4uSB6TSFZSAlQ>
    <xme:F83JY_P7Y5OGAu_MxnDC2aNkjLX0NJZjazvUMYnHU6nzCyfMop-dZqzG5nHWAIvkV
    WcUfuFS1ES91yw6owU>
X-ME-Received: <xmr:F83JY6jwUovHaeY0-_SNiKU0kKRRszwjT6_H8dr-ia5i6-b966SZydeqZ_RdbBJB2SVAtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:F83JY6_TSqY98ciRwEndzQa2TdKmVly1ur5UcQV-TZ9HThFC83Ozhw>
    <xmx:F83JY9sfoytmw3fbQseqGUDBA1s1bX6ELPAEoW-d6fAYUrRueXn_1A>
    <xmx:F83JY5Hu3evh9kxKf2eQ8mcUsiuzIa3WAmgumH4_c0Glzp34ktnrNg>
    <xmx:F83JY9dNjpIKIY9riHmHxzynvso_3NZe_VhQQlC9Mda9NlRWFrXKtg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 18:07:02 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id AE4F0104925; Fri, 20 Jan 2023 02:06:59 +0300 (+03)
Date:   Fri, 20 Jan 2023 02:06:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
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
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        ndesaulniers@google.com, joao@overdrivepizza.com,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
Message-ID: <20230119230659.pda5jigd5qxpnpq4@box.shutemov.name>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
 <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box>
 <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:02:06PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 17, 2023 at 04:57:03PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jan 17, 2023 at 02:05:22PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 11, 2023 at 03:37:27PM +0300, Kirill A. Shutemov wrote:
> > > 
> > > >  #define __untagged_addr(untag_mask, addr)
> > > >  	u64 __addr = (__force u64)(addr);				\
> > > > -	s64 sign = (s64)__addr >> 63;					\
> > > > -	__addr &= untag_mask | sign;					\
> > > > +	if (static_branch_likely(&tagged_addr_key)) {			\
> > > > +		s64 sign = (s64)__addr >> 63;				\
> > > > +		__addr &= untag_mask | sign;				\
> > > > +	}								\
> > > >  	(__force __typeof__(addr))__addr;				\
> > > >  })
> > > >  
> > > > #define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)
> > > 
> > > Is the compiler clever enough to put the memop inside the branch?
> > 
> > Hm. You mean current_untag_mask() inside static_branch_likely()?
> > 
> > But it is preprocessor who does this, not compiler. So, yes, the memop is
> > inside the branch.
> > 
> > Or I didn't understand your question.
> 
> Nah, call it a pre-lunch dip, I overlooked the whole CPP angle -- d'0h.
> 
> That said, I did just put it through a compiler to see wth it did and it
> is pretty gross:

I tried to replace static branch with alternative. It kinda works, but
required few hack. Thanks to Andrew Cooper for helping to untangle them.

I am not sure if it worth the effort. I don't have any evidence that it
helps. untagged_addr() overhead is rather small and hides in noise of
syscall cost.

I only made alternative for untagged_addr(), but not for
untagged_addr_remote(). _remote() case has very few users.

BTW, it would be nice to be able to apply alternative later, delaying it
until the first user of LAM, like I did with static_branch.
We don't have a way to do this right?

Any opinions? I am okay dropping the patch altogether.

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c44b56f7ffba..3f0c31044f02 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -75,6 +75,12 @@
 # define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+# define DISABLE_LAM		0
+#else
+# define DISABLE_LAM		(1 << (X86_FEATURE_LAM & 31))
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 # define DISABLE_ENQCMD		0
 #else
@@ -115,7 +121,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING)
-#define DISABLED_MASK12	0
+#define DISABLED_MASK12	(DISABLE_LAM)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f9f85d596581..57ccb91fcccf 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -9,6 +9,7 @@
 #include <linux/kasan-checks.h>
 #include <linux/mm_types.h>
 #include <linux/string.h>
+#include <linux/mmap_lock.h>
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/smap.h>
@@ -24,28 +25,48 @@ static inline bool pagefault_disabled(void);
 #endif
 
 #ifdef CONFIG_ADDRESS_MASKING
-DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
+static inline unsigned long __untagged_addr(unsigned long addr)
+{
+	/*
+	 * Magic with the 'sign' allows to untag userspace pointer without
+	 * any branches while leaving kernel addresses intact.
+	 */
+	long sign;
+
+	/*
+	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
+	 * in alternative instructions. The relocation gets wrong when gets
+	 * copied to the target place.
+	 */
+	asm (ALTERNATIVE("",
+			 "sar $63, %[sign]\n\t" /* user_ptr ? 0 : -1UL */
+			 "or %%gs:tlbstate_untag_mask, %[sign]\n\t"
+			 "and %[sign], %[addr]\n\t", X86_FEATURE_LAM)
+	     : [addr] "+r" (addr), [sign] "=r" (sign)
+	     : "m" (tlbstate_untag_mask), "[sign]" (addr));
+
+	return addr;
+}
 
-/*
- * Mask out tag bits from the address.
- *
- * Magic with the 'sign' allows to untag userspace pointer without any branches
- * while leaving kernel addresses intact.
- */
-#define __untagged_addr(untag_mask, addr)	({			\
-	u64 __addr = (__force u64)(addr);				\
-	if (static_branch_likely(&tagged_addr_key)) {			\
-		s64 sign = (s64)__addr >> 63;				\
-		__addr &= untag_mask | sign;				\
-	}								\
-	(__force __typeof__(addr))__addr;				\
+#define untagged_addr(addr)	({					\
+	unsigned long __addr = (__force unsigned long)(addr);		\
+	(__force __typeof__(addr))__untagged_addr(__addr);		\
 })
 
-#define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)
+static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
+						   unsigned long addr)
+{
+	long sign = addr >> 63;
+
+	mmap_assert_locked(mm);
+	addr &= (mm)->context.untag_mask | sign;
+
+	return addr;
+}
 
 #define untagged_addr_remote(mm, addr)	({				\
-	mmap_assert_locked(mm);						\
-	__untagged_addr((mm)->context.untag_mask, addr);		\
+	unsigned long __addr = (__force unsigned long)(addr);		\
+	(__force __typeof__(addr))__untagged_addr_remote(mm, __addr);	\
 })
 
 #else
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 0831d2be190f..e006725afdf1 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -745,9 +745,6 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #ifdef CONFIG_ADDRESS_MASKING
 
-DEFINE_STATIC_KEY_FALSE(tagged_addr_key);
-EXPORT_SYMBOL_GPL(tagged_addr_key);
-
 #define LAM_U57_BITS 6
 
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
@@ -787,8 +784,6 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
 
 	mmap_write_unlock(mm);
-
-	static_branch_enable(&tagged_addr_key);
 	return 0;
 }
 #endif
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
