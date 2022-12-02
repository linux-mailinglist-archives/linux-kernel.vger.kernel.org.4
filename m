Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5918640885
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiLBOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiLBOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:33:23 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255CD4F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:33:21 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 67D495C0117;
        Fri,  2 Dec 2022 09:33:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Dec 2022 09:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1669991600; x=
        1670078000; bh=2z523A/B5cMV9WqCPYgweDb1Dp8SXwFClHP8kjid4hs=; b=V
        I2FyXemLDSaXJh+hWB+te9d/1b5JH8dZ4tIowJG0CTWhxOveVAvhpmRz6xpmLePo
        0jYmIjXy9BdJcYSVdIgheK5RhZihnkOc7vhc1LdePhN6DF0N6pa/P1xiL8Y+Wufj
        MhuV478rXcllbsH8n7bPvahYk/ip6g4UelhS9ifwZktCZQxFsF9JBv/qEsy801+k
        MTq4pnxxh6RjvRePQQd+9G28oVJVfpo1UfpDj2qAoyU70/F88wtdy8HlLJViTQqt
        EHi/3dwW8Q0UtJTD3KJwiThbfVa6y4qSXTtblowE7REnFVelsTZVrPpFTLe/mkh2
        +aTOeMaBH4w2kcIp1oA8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669991600; x=
        1670078000; bh=2z523A/B5cMV9WqCPYgweDb1Dp8SXwFClHP8kjid4hs=; b=d
        Hd7pU/KShEtqy1thSgVHV9u7KqRLuq6z/0udgsbOic4jTBYAAX9fxLWFNoq7caxH
        vOpaYuLhAkwJ4bbPBkDilg+pRm+cXl7d+Ygz4TG0IFyHUqD3DKFdXVABYunmaiOG
        Tn/QLiI0iA+nNHrRxjMWN3pgV8E+hp2D8cQ7fXaooGog2LwsLw0NZi5YjiY6l5R3
        +tKzGi+2qhYNZGrQMd4T1d2HZjtYeFeqNcOObBdnl+mPeL8ycdupmMZsLLIYEm8v
        OTW/VVv2a0xnGwh+kerOg7jvCHoeu3XVJVXURNra50z41OQaljRxXJ8ykjAjuaXr
        LfaCfW0Zjs8PMLml6HCtw==
X-ME-Sender: <xms:rwyKY2XrtQIKd5u43GbHamjPO-bBMq2G7ppIbeOzRLjpRkGRDbK4-A>
    <xme:rwyKYykUBHg5IAro54ixuaXTfCauQ38-i9OvROExuB4Z9DMrUgiQQJcYkkNOq9SMC
    Px8GFEdpIVExPkV7gA>
X-ME-Received: <xmr:rwyKY6bDBd_Ck1D2qERSI5gxz0A3XpasKq89QDg5JH20rM2Pv8Ov1fMqmpPtzK8tU3xY0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeeiteekgfejuedtleetgedvkefhhedvgfefjefh
    veehkefgjefhtdekfeetfeefgfenucffohhmrghinhepihhnthgvlhdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:rwyKY9XdJrkLU7kKBvo7LGB1rlsmY-eUpo2DnN78tAmuAV6YdD11Lg>
    <xmx:rwyKYwmWeTMT--eGAMIJIhUqO_FsFGxO7ctnScPxlrfH2b4Hh4LQ4Q>
    <xmx:rwyKYyeUw8YUm3oGUbSqRXsuSoRpHnDQ1zYxLS1aGerWst6zWpF_WA>
    <xmx:sAyKY67h5MpoJn15Gw9kQ4mao6CLfsVHTrLZHq6ZGQPpGyCJcsP4Rw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 09:33:19 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0E01210975F; Fri,  2 Dec 2022 17:33:16 +0300 (+03)
Date:   Fri, 2 Dec 2022 17:33:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
Message-ID: <20221202143316.mtjz6dghecshldk2@box.shutemov.name>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
 <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
 <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:39:58PM +0100, Juergen Gross wrote:
> On 02.12.22 14:27, Kirill A. Shutemov wrote:
> > On Fri, Dec 02, 2022 at 06:56:47AM +0100, Juergen Gross wrote:
> > > On 02.12.22 00:57, Kirill A. Shutemov wrote:
> > > > On Thu, Dec 01, 2022 at 05:33:28PM +0100, Juergen Gross wrote:
> > > > > On 01.12.22 17:26, Kirill A. Shutemov wrote:
> > > > > > On Wed, Nov 02, 2022 at 08:47:10AM +0100, Juergen Gross wrote:
> > > > > > > Today PAT is usable only with MTRR being active, with some nasty tweaks
> > > > > > > to make PAT usable when running as Xen PV guest, which doesn't support
> > > > > > > MTRR.
> > > > > > > 
> > > > > > > The reason for this coupling is, that both, PAT MSR changes and MTRR
> > > > > > > changes, require a similar sequence and so full PAT support was added
> > > > > > > using the already available MTRR handling.
> > > > > > > 
> > > > > > > Xen PV PAT handling can work without MTRR, as it just needs to consume
> > > > > > > the PAT MSR setting done by the hypervisor without the ability and need
> > > > > > > to change it. This in turn has resulted in a convoluted initialization
> > > > > > > sequence and wrong decisions regarding cache mode availability due to
> > > > > > > misguiding PAT availability flags.
> > > > > > > 
> > > > > > > Fix all of that by allowing to use PAT without MTRR and by reworking
> > > > > > > the current PAT initialization sequence to match better with the newly
> > > > > > > introduced generic cache initialization.
> > > > > > > 
> > > > > > > This removes the need of the recently added pat_force_disabled flag, so
> > > > > > > remove the remnants of the patch adding it.
> > > > > > > 
> > > > > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > > > 
> > > > > > This patch breaks boot for TDX guest.
> > > > > > 
> > > > > > Kernel now tries to set CR0.CD which is forbidden in TDX guest[1] and
> > > > > > causes #VE:
> > > > > > 
> > > > > > 	tdx: Unexpected #VE: 28
> > > > > > 	VE fault: 0000 [#1] PREEMPT SMP NOPTI
> > > > > > 	CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00015-gadfe7512e1d0 #2646
> > > > > > 	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > > > > > 	RIP: 0010:native_write_cr0 (arch/x86/kernel/cpu/common.c:427)
> > > > > > 	 Call Trace:
> > > > > > 	  <TASK>
> > > > > > 	 ? cache_disable (arch/x86/include/asm/cpufeature.h:173 arch/x86/kernel/cpu/cacheinfo.c:1085)
> > > > > > 	 ? cache_cpu_init (arch/x86/kernel/cpu/cacheinfo.c:1132 (discriminator 3))
> > > > > > 	 ? setup_arch (arch/x86/kernel/setup.c:1079)
> > > > > > 	 ? start_kernel (init/main.c:279 (discriminator 3) init/main.c:477 (discriminator 3) init/main.c:960 (discriminator 3))
> > > > > > 	 ? load_ucode_bsp (arch/x86/kernel/cpu/microcode/core.c:155)
> > > > > > 	 ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358)
> > > > > > 	  </TASK>
> > > > > > 
> > > > > > Any suggestion how to fix it?
> > > > > > 
> > > > > > [1] Section 10.6.1. "CR0", https://cdrdv2.intel.com/v1/dl/getContent/733568
> > > > > 
> > > > > What was the solution before?
> > > > > 
> > > > > I guess MTRR was disabled, so there was no PAT, too?
> > > > 
> > > > Right:
> > > > 
> > > > Linus' tree:
> > > > 
> > > > [    0.002589] last_pfn = 0x480000 max_arch_pfn = 0x10000000000
> > > > [    0.003976] Disabled
> > > > [    0.004452] x86/PAT: MTRRs disabled, skipping PAT initialization too.
> > > > [    0.005856] CPU MTRRs all blank - virtualized system.
> > > > [    0.006915] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
> > > > 
> > > > tip/master:
> > > > 
> > > > [    0.003443] last_pfn = 0x20b8e max_arch_pfn = 0x10000000000
> > > > [    0.005220] Disabled
> > > > [    0.005818] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> > > > [    0.007752] tdx: Unexpected #VE: 28
> > > > 
> > > > The dangling "Disabled" comes mtrr_bp_init().
> > > > 
> > > > 
> > > > > If this is the case, you can go the same route as Xen PV guests do.
> > > > 
> > > > Any reason X86_FEATURE_HYPERVISOR cannot be used instead of
> > > > X86_FEATURE_XENPV there?
> > > > 
> > > > Do we have any virtualized platform that supports it?
> > > 
> > > Yes, of course. Any hardware virtualized guest should be able to use it,
> > > obviously TDX guests are the first ones not being able to do so.
> > > 
> > > And above dmesg snipplets are showing rather nicely that not disabling
> > > PAT completely should be a benefit for TDX guests, as all caching modes
> > > would be usable (the PAT MSR seems to be initialized quite fine).
> > > 
> > > Instead of X86_FEATURE_XENPV we could introduce something like
> > > X86_FEATURE_PAT_READONLY, which could be set for Xen PV guests and for
> > > TDX guests.
> > 
> > Technically, the MSR is writable on TDX. But it seems there's no way to
> > properly change it, following the protocol of changing on MP systems.
> 
> Why not? I don't see why it is possible in a non-TDX system, but not within
> a TDX guest.

Because the protocol you described below requires setting CR0.CD which is
not allowed in TDX guest and causes #VE.

> > Although, I don't quite follow what role cache disabling playing on system
> > with self-snoop support. Hm?
> 
> It is the recommended way to do it. See SDM Vol. 3 Chapter 11 ("Memory Cache
> Control"):
> 
> The operating system is responsible for insuring that changes to a PAT entry
> occur in a manner that maintains the consistency of the processor caches and
> translation lookaside buffers (TLB). This is accomplished by following the
> procedure as specified in Section 11.11.8, “MTRR Considerations in MP Systems,
> ”for changing the value of an MTRR in a multiple processor system. It requires
> a specific sequence of operations that includes flushing the processors caches
> and TLBs.
> 
> And the sequence for the MTRRs is:
> 
> 1. Broadcast to all processors to execute the following code sequence.
> 2. Disable interrupts.
> 3. Wait for all processors to reach this point.
> 4. Enter the no-fill cache mode. (Set the CD flag in control register CR0 to 1
>    and the NW flag to 0.)
> 5. Flush all caches using the WBINVD instructions. Note on a processor that
>    supports self-snooping, CPUID feature flag bit 27, this step is unnecessary.
> 6. If the PGE flag is set in control register CR4, flush all TLBs by clearing
>    that flag.
> 7. If the PGE flag is clear in control register CR4, flush all TLBs by executing
>    a MOV from control register CR3 to another register and then a MOV from that
>    register back to CR3.
> 8. Disable all range registers (by clearing the E flag in register MTRRdefType).
>    If only variable ranges are being modified, software may clear the valid bits
>    for the affected register pairs instead.
> 9. Update the MTRRs.
> 10. Enable all range registers (by setting the E flag in register MTRRdefType).
>     If only variable-range registers were modified and their individual valid
>     bits were cleared, then set the valid bits for the affected ranges instead.
> 11. Flush all caches and all TLBs a second time. (The TLB flush is required for
>     Pentium 4, Intel Xeon, and P6 family processors. Executing the WBINVD
>     instruction is not needed when using Pentium 4, Intel Xeon, and P6 family
>     processors, but it may be needed in future systems.)
> 12. Enter the normal cache mode to re-enable caching. (Set the CD and NW flags
>     in control register CR0 to 0.)
> 13. Set PGE flag in control register CR4, if cleared in Step 6 (above).
> 14. Wait for all processors to reach this point.
> 15. Enable interrupts.
> 
> So cache disabling is recommended.

Yeah, I read that.

But the question is what kind of scenario cache disabling is actually
prevents if self-snoop is supported? In this case cache stays intact (no
WBINVD). The next time a cache line gets accessed with different caching
mode the old line gets snooped, right?

Would it be valid to avoid touching CR0.CD if X86_FEATURE_SELFSNOOP?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
