Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8E6407A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiLBN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLBN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:27:10 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAEF83E95
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:27:07 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DA935C00DE;
        Fri,  2 Dec 2022 08:27:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Dec 2022 08:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1669987626; x=1670074026; bh=nn
        H2aCJND8jeSVoTp/sLLPIwU0GcEcoqylwasYtGMK0=; b=vPcmXRbnU4666E/as6
        EEysrh54PYRraOm54SuaJGlaHJih702gtrVzqc8tTpP9e0iIBmpCOuNUt1jiSqDW
        5llT3N5cO3+AzQzvKVaupxFZ0FZstbZJevzs7CmLoTu/wRusI9wbnLFRPS+Zl7bb
        4+W9fzEy9LihlXTi3Vhadad0TvSlo9AeIaqRZohvBH9NIg93duBL25jwD3JSDPvI
        bAEY68ciICntwBv9YDoawbEfQlYm1zxnE2updXcObxtyjXLWD4yoMA9EZTe2Ntde
        /Wc9HUYYFkLvlLAVnd03CFPB0QwOruQPtueKLGWVKEZWMLJc6evAENb18dJ0qusS
        FQxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669987626; x=1670074026; bh=nnH2aCJND8jeSVoTp/sLLPIwU0Gc
        EcoqylwasYtGMK0=; b=l8H95D3qVNTMxEA4awNIIFpPHFuhM5LPGxsMis65DbKl
        Dqp4O16nZKb9PlHMdhKPNScSHHoY+pCyKMAKg2NGxXNbGgAwpsUfl7nglQ8w4uP+
        S328IzhfxYiYOa3cn8dz3PAXJQIGLQNbjYUDSQ5K5H+7HkJlEfacRbFFJqR3kdqC
        WpAiKb1KKs6P9Cw8TI2H00lq5lVO9/nTtNwAg/LTD2/XaYUxs5R4QU0VkvvNFtj/
        0ViL2eJR2jc7VbfQi/TwiaUl5UjVPH6C8PaN8KW9UOxza9Ju3gAw6K/VbCpeaYdL
        j4XMMvufq27UUpslLBFai3Zgl/PKM7AzyOZcjnb/tg==
X-ME-Sender: <xms:Kf2JY5EP_l511x7W9L2UTaw5aOcN9AIDrALYxQqPUGQX7cqtd41g5w>
    <xme:Kf2JY-UCyxPzrm7it8PKtq4CguImWkZZbklJ7XpXFq0c6kL3SPDMgXerfRjaoe9Ie
    nl4Cmm4MR6lya77hQs>
X-ME-Received: <xmr:Kf2JY7JRhgp8F7lwkN4D-xgV3bjlJDePzxzGA-BaNGvT6QQy4C6fZGZQua_TLe8uU49IYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepfeeileeffeeiteeljeekheetieehhffhfeeuheel
    tdetgfeuvddvffegvdelhfdunecuffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Kf2JY_EgkhkZxUUH3UMWOg-fuq7Hpsh6swohC1ybw1bipBt9T6yEnQ>
    <xmx:Kf2JY_VQQMV7gdLabiomOS8tEa_oA2U5u-6hEc_ypkL00AScb5rqXA>
    <xmx:Kf2JY6My4V20lXlxYpM1bxyh81m5aR7pORqU1ODAIMw9PKWtDWS4Bg>
    <xmx:Kv2JY7oKFbWuMU7V49T_tYCZi58prMHsnLNbq9h0mc00XguvbqA-aw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 08:27:04 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EC5B210975F; Fri,  2 Dec 2022 16:27:01 +0300 (+03)
Date:   Fri, 2 Dec 2022 16:27:01 +0300
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
Message-ID: <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 06:56:47AM +0100, Juergen Gross wrote:
> On 02.12.22 00:57, Kirill A. Shutemov wrote:
> > On Thu, Dec 01, 2022 at 05:33:28PM +0100, Juergen Gross wrote:
> > > On 01.12.22 17:26, Kirill A. Shutemov wrote:
> > > > On Wed, Nov 02, 2022 at 08:47:10AM +0100, Juergen Gross wrote:
> > > > > Today PAT is usable only with MTRR being active, with some nasty tweaks
> > > > > to make PAT usable when running as Xen PV guest, which doesn't support
> > > > > MTRR.
> > > > > 
> > > > > The reason for this coupling is, that both, PAT MSR changes and MTRR
> > > > > changes, require a similar sequence and so full PAT support was added
> > > > > using the already available MTRR handling.
> > > > > 
> > > > > Xen PV PAT handling can work without MTRR, as it just needs to consume
> > > > > the PAT MSR setting done by the hypervisor without the ability and need
> > > > > to change it. This in turn has resulted in a convoluted initialization
> > > > > sequence and wrong decisions regarding cache mode availability due to
> > > > > misguiding PAT availability flags.
> > > > > 
> > > > > Fix all of that by allowing to use PAT without MTRR and by reworking
> > > > > the current PAT initialization sequence to match better with the newly
> > > > > introduced generic cache initialization.
> > > > > 
> > > > > This removes the need of the recently added pat_force_disabled flag, so
> > > > > remove the remnants of the patch adding it.
> > > > > 
> > > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > 
> > > > This patch breaks boot for TDX guest.
> > > > 
> > > > Kernel now tries to set CR0.CD which is forbidden in TDX guest[1] and
> > > > causes #VE:
> > > > 
> > > > 	tdx: Unexpected #VE: 28
> > > > 	VE fault: 0000 [#1] PREEMPT SMP NOPTI
> > > > 	CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00015-gadfe7512e1d0 #2646
> > > > 	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > > > 	RIP: 0010:native_write_cr0 (arch/x86/kernel/cpu/common.c:427)
> > > > 	 Call Trace:
> > > > 	  <TASK>
> > > > 	 ? cache_disable (arch/x86/include/asm/cpufeature.h:173 arch/x86/kernel/cpu/cacheinfo.c:1085)
> > > > 	 ? cache_cpu_init (arch/x86/kernel/cpu/cacheinfo.c:1132 (discriminator 3))
> > > > 	 ? setup_arch (arch/x86/kernel/setup.c:1079)
> > > > 	 ? start_kernel (init/main.c:279 (discriminator 3) init/main.c:477 (discriminator 3) init/main.c:960 (discriminator 3))
> > > > 	 ? load_ucode_bsp (arch/x86/kernel/cpu/microcode/core.c:155)
> > > > 	 ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358)
> > > > 	  </TASK>
> > > > 
> > > > Any suggestion how to fix it?
> > > > 
> > > > [1] Section 10.6.1. "CR0", https://cdrdv2.intel.com/v1/dl/getContent/733568
> > > 
> > > What was the solution before?
> > > 
> > > I guess MTRR was disabled, so there was no PAT, too?
> > 
> > Right:
> > 
> > Linus' tree:
> > 
> > [    0.002589] last_pfn = 0x480000 max_arch_pfn = 0x10000000000
> > [    0.003976] Disabled
> > [    0.004452] x86/PAT: MTRRs disabled, skipping PAT initialization too.
> > [    0.005856] CPU MTRRs all blank - virtualized system.
> > [    0.006915] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
> > 
> > tip/master:
> > 
> > [    0.003443] last_pfn = 0x20b8e max_arch_pfn = 0x10000000000
> > [    0.005220] Disabled
> > [    0.005818] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> > [    0.007752] tdx: Unexpected #VE: 28
> > 
> > The dangling "Disabled" comes mtrr_bp_init().
> > 
> > 
> > > If this is the case, you can go the same route as Xen PV guests do.
> > 
> > Any reason X86_FEATURE_HYPERVISOR cannot be used instead of
> > X86_FEATURE_XENPV there?
> > 
> > Do we have any virtualized platform that supports it?
> 
> Yes, of course. Any hardware virtualized guest should be able to use it,
> obviously TDX guests are the first ones not being able to do so.
> 
> And above dmesg snipplets are showing rather nicely that not disabling
> PAT completely should be a benefit for TDX guests, as all caching modes
> would be usable (the PAT MSR seems to be initialized quite fine).
> 
> Instead of X86_FEATURE_XENPV we could introduce something like
> X86_FEATURE_PAT_READONLY, which could be set for Xen PV guests and for
> TDX guests.

Technically, the MSR is writable on TDX. But it seems there's no way to
properly change it, following the protocol of changing on MP systems.

Although, I don't quite follow what role cache disabling playing on system
with self-snoop support. Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
