Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBEE6226AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKIJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKIJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:18:02 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3722B29
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:17:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 392D35C005E;
        Wed,  9 Nov 2022 04:17:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 09 Nov 2022 04:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667985467; x=1668071867; bh=cL
        9C5JMjfk8ahczXfQIOfuLjD6paSuh3KR3x+a4cAOQ=; b=fHZduUcX/bqH07s70d
        KQjFOsjQQpsXexTu/qN9z9xW3RPKizY+oUmB5Qcv6SFOOp6fwAwlN36FiZQY6xGm
        6f7qSqFJvo8/JWuC/+EX8x0uZQ3UrkwRhU4dg7VKPdpYetNFYbiEWqMBxi72UuUm
        e1rRwI0greWcLRaTvHENLkgb+iLOMl3XJzWBXlMsAageWsaQutvVAIE0Nal3gL0f
        jdRbCAVwZoAaNjj0rhzaF8x9HUJshL4xHw2okuDiqz8ulJCtvXiFtzzitINMxG6i
        vJvSzMNDLM3mw35bxvdcoDazXzsUr+7oQ5QSW2hCrwAqlJz1UuBes4c9gcgaeo6N
        d0fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667985467; x=1668071867; bh=cL9C5JMjfk8ahczXfQIOfuLjD6pa
        Suh3KR3x+a4cAOQ=; b=CwGbMWQBwEJCVGqWvMsWxs4v7MRu5VP86H5BF1iVjKwP
        KxHKNpGpI0iQ3erWgG40WEtFuuhUC/dTsfitRUlZOLopDREgnMTIBTgIDSuVeEoR
        MTUGiPK0rmx1kgDKkBP9cI7+Ck5nsuBMfbwcuJ3rZ5KJy0y7bJk2QkvUmnV0CGd9
        rh8F9QeDUIiI5EZglYwipKmsoHnL20irb+yaK0us2UJBg7jr6gnbub5MQonLReJG
        LpPuv8XUQYoT6RUxVANBpa+ve3kHn5082iRhMaosn9NfaiaHWNYQ/6nZBGXUYcE+
        BqoFm47cz82uHTfTzC7cjjnmvn96GLxMmTvb5b5f/A==
X-ME-Sender: <xms:OnBrY-P3II3uGeb-YxQGfp8f9DE8mdEQsqzYjhUWEbEudjZWl_HFLg>
    <xme:OnBrY8-Z-VwhlDB3GxHT-A5_nZUa51Dk-voVbJibD_0QciTbFaukCHLYtq7FHeUkT
    FA_Bgj_fsPrgb9HVrc>
X-ME-Received: <xmr:OnBrY1TPqhphNGbIuwF7yBz57dynlZ0U8zu5SHubc3BuRZnEmWw53P0PsZllPWueqAia8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpehkihhrihhl
    lhesshhhuhhtvghmohhvrdhnrghmvgenucggtffrrghtthgvrhhnpeehleevveejudejke
    evueevteevfffhkeejgfehleethefhueejvdehieejgffhhfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmoh
    hvrdhnrghmvg
X-ME-Proxy: <xmx:OnBrY-sqUw-CdRdWJvSRVOgFm-108ggDyMRnt2mBqQZqNaDsKJT2Kg>
    <xmx:OnBrY2cs4NXGtXyWQ_esDDAn48PWUyOfLucB_GnMegSlz7-g8Vn1Gw>
    <xmx:OnBrYy0OMjrwMfYfIjhFp9wKH6hrotAqPWcEthjamDKL71nNdmslrQ>
    <xmx:O3BrY5URPPTWmyDs8bnCbVs07j2Q9GrVZAqpCDWgOrwhXwqtbCxrfA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Nov 2022 04:17:46 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E57C810410A; Wed,  9 Nov 2022 12:17:42 +0300 (+03)
Date:   Wed, 9 Nov 2022 12:17:42 +0300
From:   kirill@shutemov.name
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com, ak@linux.intel.com, andreyknvl@gmail.com,
        ashok.raj@intel.com, bharata@amd.com, dave.hansen@linux.intel.com,
        dvyukov@google.com, glider@google.com, hjl.tools@gmail.com,
        jacob.jun.pan@linux.intel.com, kcc@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com,
        ryabinin.a.a@gmail.com, tarasmadan@google.com, x86@kernel.org
Subject: Re: [PATCHv11.1 04/16] x86/mm: Handle LAM on context switch
Message-ID: <20221109091742.tpqxho5kvdmrto3r@box.shutemov.name>
References: <b778fcdd-5c20-e897-9d17-1a884172a826@intel.com>
 <20221107213558.27807-1-kirill.shutemov@linux.intel.com>
 <6782d309-5e4b-580c-fbbb-4388bda69bf3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6782d309-5e4b-580c-fbbb-4388bda69bf3@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 07:54:35PM -0800, Andy Lutomirski wrote:
> On 11/7/22 13:35, Kirill A. Shutemov wrote:
> > Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> > The mode is selected per-process and stored in mm_context_t.
> > 
> > switch_mm_irqs_off() now respects selected LAM mode and constructs CR3
> > accordingly.
> > 
> > The active LAM mode gets recorded in the tlb_state.
> > 
> 
> > +static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> > +{
> > +	return mm->context.lam_cr3_mask;
> 
> READ_ONCE -- otherwise this has a data race and might generate sanitizer
> complaints.

Yep, thanks for pointing it out.

> > +}
> 
> > @@ -491,6 +496,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >   {
> >   	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> >   	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> > +	unsigned long prev_lam = tlbstate_lam_cr3_mask();
> > +	unsigned long new_lam = mm_lam_cr3_mask(next);
> 
> So I'm reading this again after drinking a cup of coffee.  new_lam is next's
> LAM mask according to mm_struct (and thus can change asynchronously due to a
> remote CPU).  prev_lam is based on tlbstate and can't change asynchronously,
> at least not with IRQs off.
> 
> 
> >   	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
> >   	unsigned cpu = smp_processor_id();
> >   	u64 next_tlb_gen;
> > @@ -520,7 +527,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >   	 * isn't free.
> >   	 */
> >   #ifdef CONFIG_DEBUG_VM
> > -	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
> > +	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
> 
> So is the only purpose of tlbstate_lam_cr3_mask() to enable this warning to
> work?

Right. And disabling CONFIG_DEBUG_VM leads to warning. See the fixup
below.

> >   		/*
> >   		 * If we were to BUG here, we'd be very likely to kill
> >   		 * the system so hard that we don't see the call trace.
> > @@ -552,9 +559,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >   	 * instruction.
> >   	 */
> >   	if (real_prev == next) {
> > +		/* Not actually switching mm's */
> >   		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
> >   			   next->context.ctx_id);
> > +		/*
> > +		 * If this races with another thread that enables lam, 'new_lam'
> > +		 * might not match 'prev_lam'.
> > +		 */
> > +
> 
> Indeed.
> 
> >   		/*
> >   		 * Even in lazy TLB mode, the CPU should stay set in the
> >   		 * mm_cpumask. The TLB shootdown code can figure out from
> > @@ -622,15 +635,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >   		barrier();
> >   	}
> 
> > @@ -691,6 +705,10 @@ void initialize_tlbstate_and_flush(void)
> >   	/* Assert that CR3 already references the right mm. */
> >   	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
> > +	/* LAM expected to be disabled in CR3 and init_mm */
> > +	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
> > +	WARN_ON(mm_lam_cr3_mask(&init_mm));
> > +
> 
> I think the callers all have init_mm selected, but the rest of this function
> is not really written with this assumption.  (But it does force ASID 0,
> which is at least a bizarre thing to do for non-init-mm.)

Hm. It uses tlb_gen of init_mm, so I assumed &init_mm == mm, but yeah it
is not strictly correct.

> What's the purpose of this warning?  I'm okay with keeping it, but maybe
> also add a warning that fires if mm != &init_mm.

Just to make sure we are in sane state. I can drop init_mm reference if it
helps.

The fixup based on your feedback:

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 1ab7ecf61659..6f5b58a5f951 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -94,7 +94,7 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 #ifdef CONFIG_X86_64
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 {
-	return mm->context.lam_cr3_mask;
+	return READ_ONCE(mm->context.lam_cr3_mask);
 }
 
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4380776b3c61..ab66a48f38ce 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -496,7 +496,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long prev_lam = tlbstate_lam_cr3_mask();
 	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
@@ -527,7 +526,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
+	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid,
+						   tlbstate_lam_cr3_mask()))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
 		 * the system so hard that we don't see the call trace.
@@ -565,7 +565,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 		/*
 		 * If this races with another thread that enables lam, 'new_lam'
-		 * might not match 'prev_lam'.
+		 * might not match tlbstate_lam_cr3_mask().
 		 */
 
 		/*
@@ -705,9 +705,9 @@ void initialize_tlbstate_and_flush(void)
 	/* Assert that CR3 already references the right mm. */
 	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
 
-	/* LAM expected to be disabled in CR3 and init_mm */
+	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(&init_mm));
+	WARN_ON(mm_lam_cr3_mask(mm));
 
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
