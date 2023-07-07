Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CC374B2E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGGOP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGGOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:15:54 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB9B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:15:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B6785C00E5;
        Fri,  7 Jul 2023 10:06:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jul 2023 10:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688738798; x=
        1688825198; bh=bADSXRjJT2VmAksj+Ouw6c8IcnPfSllb5RqRT0CkeE8=; b=j
        cayRFtEls/DJA98t3Sk+RlAsJLpgPwlJmaciNCLG6tkZKQWVGWWggVzVw59I+lre
        JRZDktVvqf2xKEXHPd/iwufqmhz2YEcMP4H1mso2PwzVmnhls6orSs+Ezut4T8dp
        djCt5xEuayEZ3EhPaLdNyQIO6IarAPhdF7jbIWGdfbZuS6BESTXXTLzbLrtlIy4/
        BBHmtUZoduRUVACMOJKm5OAOA9GU97jSpkQtO/ybP7hzOj9/RT6qdhV/Y2fJPBMW
        /g6oGjr/70o18XdY1QEvs9uliGQQUM8/AVdxlow8hx39qbVOoVVFyCDVuiVZU9BM
        0zh2tyPdBcWHinCHI56jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688738798; x=1688825198; bh=bADSXRjJT2VmA
        ksj+Ouw6c8IcnPfSllb5RqRT0CkeE8=; b=lggPlMa0cZVCZmjkEOGipKpWrXYzO
        /Rojg+83gDxy0qizSLXqCywiy3xlRzYQH9xzkbceXq/G+lk315yjJy6jkSrzKBwk
        A7p7UQr+RN95ThruQkpsiLb8i9ZD1dRR5CBksiZ3fRUGMrbdfvWLtOZ6O9PsaWqB
        hr0GnXCI6qay4u12qB8pm+fob7Zb4JICFMRltwE0vEYmA0iaaqPjdpVSuwsW8Vyk
        HKTIFtmnvVfTVmu4cChW7nk0uD5ZoCCqoRPZzOk4WyQ49pcSQJKUnUGiLpX1udlj
        XiFQ3AEK8fOdK+HUdQMCtNCoMW/HBzPxxCJsraIDtwzATzmEXAzjFA4WQ==
X-ME-Sender: <xms:7RuoZKa01ekPYKYCV-SVovBUMdqTXq-A-QE9TQAXMuvU6IZJWWJyBw>
    <xme:7RuoZNYqSVW1k-LiohzJcXQhLEVfQrga9gWmD7jCccxngmG6NeCjsdmh-eUFppatF
    em4mh-uM4lqxEB3iYw>
X-ME-Received: <xmr:7RuoZE_ZSxX68l4mdyctxfSIl9yNXBguzOLJZRDeGPdyqaZF4WdqqNtEZ9jxAYSg5s_ihw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:7RuoZMrsP1KBPjbv6bwxml61DE1xeGZTDSO4FbPZ8xJMtUq7Ej7gBg>
    <xmx:7RuoZFoScSZojB8156IAEiCU_Oq_lyiey_df_mIi2tAuWToajN732A>
    <xmx:7RuoZKRIgGzf4ugC1T5m9Av5h6u9mo9NrOVPuVpsPHR6FxfrTeoPug>
    <xmx:7huoZGTMCTbGRiLjrCzEuaLzbKMnR0pBSNn17o5bbqXUT_MI7hJoxA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 10:06:36 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1E199109AB9; Fri,  7 Jul 2023 17:06:33 +0300 (+03)
Date:   Fri, 7 Jul 2023 17:06:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Message-ID: <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) wrote:
> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, June 6, 2023 2:56 AM
> > 
> > During review of TDX guests on Hyper-V patchset Dave pointed to the
> > potential race between changing page private/shared status and
> > load_unaligned_zeropad().
> > 
> > Fix the issue.
> > 
> > v3:
> >  - Fix grammar;
> >  - Add Sathya's Reviewed-bys;
> > v2:
> >  - Add more info in commit message of the first patch.
> >  - Move enc_status_change_finish_noop() into a separate patch.
> >  - Fix typo in commit message and comment.
> > 
> > Kirill A. Shutemov (3):
> >   x86/mm: Allow guest.enc_status_change_prepare() to fail
> >   x86/tdx: Fix race between set_memory_encrypted() and
> >     load_unaligned_zeropad()
> >   x86/mm: Fix enc_status_change_finish_noop()
> > 
> >  arch/x86/coco/tdx/tdx.c         | 64 +++++++++++++++++++++++++++++++--
> >  arch/x86/include/asm/x86_init.h |  2 +-
> >  arch/x86/kernel/x86_init.c      |  4 +--
> >  arch/x86/mm/mem_encrypt_amd.c   |  4 ++-
> >  arch/x86/mm/pat/set_memory.c    |  3 +-
> >  5 files changed, 69 insertions(+), 8 deletions(-)
> > 
> > --
> > 2.39.3
> 
> These fixes notwithstanding, load_unaligned_zeropad() is not handled
> properly in a TDX VM.  The problem was introduced with commit
> c4e34dd99f2e, which moved the fixup code to function
> ex_handler_zeropad().

Ughh.. I needed to pay more attention to the rework around
load_unaligned_zeropad() :/

> This new function does a verification against
> fault_addr, and the verification always fails because fault_addr is zero.
> The call sequence is:
> 
> exc_virtualization_exception()
> ve_raise_fault()
> gp_try_fixup_and_notify()  <-- always passes 0 as fault_addr
> fixup_exception()
> ex_handler_zeropad()
> 
> The validation of fault_addr could probably be removed since
> such validation wasn't there prior to c4e34dd99f2e.  But before
> going down that path, I want to propose a different top-level
> solution to the interaction between load_unaligned_zeropad()
> and CoCo VM page transitions between private and shared.
> 
> When a page is transitioning, the caller can and should ensure
> that it is not being accessed during the transition.  But we have
> the load_unaligned_zeropad() wildcard.   So do the following for
> the transition sequence in __set_memory_enc_pgtable():
> 
> 1.  Remove aliasing mappings
> 2.  Remove the PRESENT bit from the PTEs of all transitioning pages
> 3.  Flush the TLB globally
> 4.  Flush the data cache if needed
> 5.  Set/clear the encryption attribute as appropriate
> 6.  Notify the hypervisor of the page status change
> 7.  Add back the PRESENT bit
> 
> With this approach, load_unaligned_zeropad() just takes the
> normal page-fault-based fixup path if it touches a page that is
> transitioning.  As a result, load_unaligned_zeropad() and CoCo
> VM page transitioning are completely decoupled.  We don't
> need to handle architecture-specific CoCo VM exceptions and
> fix things up.

It only addresses the problem that happens on transition, but
load_unaligned_zeropad() is still a problem for the shared mappings in
general, after transition is complete. Like if load_unaligned_zeropad()
steps from private to shared mapping and shared mapping triggers #VE,
kernel should be able to handle it.

The testcase that triggers the problem (It is ugly, but useful.):

#include <linux/mm.h>
#include <asm/word-at-a-time.h>

static int f(pte_t *pte, unsigned long addr, void *data)
{
	pte_t ***p = data;

	if (p) {
		*(*p) = pte;
		(*p)++;
	}
	return 0;
}

static struct vm_struct *alloc_vm_area(size_t size, pte_t **ptes)
{
	struct vm_struct *area;

	area = get_vm_area_caller(size, VM_IOREMAP,
				  __builtin_return_address(0));
	if (area == NULL)
		return NULL;

	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
				size, f, ptes ? &ptes : NULL)) {
		free_vm_area(area);
		return NULL;
	}

	return area;
}

#define SHARED_PFN_TRIGGERS_VE 0x80000

static int test_zeropad(void)
{
	struct vm_struct *area;
	pte_t *pte[2];
	unsigned long a;
	struct page *page;

	page = alloc_page(GFP_KERNEL);
	area = alloc_vm_area(2 * PAGE_SIZE, pte);

	set_pte_at(&init_mm, (unsigned long)area->addr, pte[0],
		   pfn_pte(page_to_pfn(page), PAGE_KERNEL));
	set_pte_at(&init_mm, (unsigned long)(area->addr + PAGE_SIZE), pte[1],
		   pfn_pte(SHARED_PFN_TRIGGERS_VE, pgprot_decrypted(PAGE_KERNEL)));

	a = load_unaligned_zeropad(area->addr + PAGE_SIZE - 1);
	printk("a: %#lx\n", a);
	for(;;);
	return 0;
}
late_initcall(test_zeropad);

Below is a patch that provides fixup code with the address it wants.

Any comments?

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58b1f208eff5..4a817d20ce3b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -697,9 +697,10 @@ static bool try_fixup_enqcmd_gp(void)
 }
 
 static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
-				    unsigned long error_code, const char *str)
+				    unsigned long error_code, const char *str,
+				    unsigned long address)
 {
-	if (fixup_exception(regs, trapnr, error_code, 0))
+	if (fixup_exception(regs, trapnr, error_code, address))
 		return true;
 
 	current->thread.error_code = error_code;
@@ -759,7 +760,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		goto exit;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc, 0))
 		goto exit;
 
 	if (error_code)
@@ -1357,17 +1358,20 @@ DEFINE_IDTENTRY(exc_device_not_available)
 
 #define VE_FAULT_STR "VE fault"
 
-static void ve_raise_fault(struct pt_regs *regs, long error_code)
+static void ve_raise_fault(struct pt_regs *regs, long error_code,
+			   unsigned long address)
 {
 	if (user_mode(regs)) {
 		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
 		return;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code,
+				    VE_FAULT_STR, address)) {
 		return;
+	}
 
-	die_addr(VE_FAULT_STR, regs, error_code, 0);
+	die_addr(VE_FAULT_STR, regs, error_code, address);
 }
 
 /*
@@ -1431,7 +1435,7 @@ DEFINE_IDTENTRY(exc_virtualization_exception)
 	 * it successfully, treat it as #GP(0) and handle it.
 	 */
 	if (!tdx_handle_virt_exception(regs, &ve))
-		ve_raise_fault(regs, 0);
+		ve_raise_fault(regs, 0, ve.gla);
 
 	cond_local_irq_disable(regs);
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
