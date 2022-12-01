Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439C63FC60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiLAX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiLAX6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:58:05 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9A1BE87
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:58:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1BECD3200973;
        Thu,  1 Dec 2022 18:57:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Dec 2022 18:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1669939077; x=1670025477; bh=HU
        b79/u3DHt9exkJriR6aYTYCbhg1aynIlctuTDFlM8=; b=v12t/8Mqp3h7TSrJxP
        bqwVIXt4FosA/BnSwWLCNOeKAcPtDIPdLsgVQV4b98Dyrzpw1PgokSquillqt4o4
        zXKm0Kb34kqV4kasthh5EsDP0qRDz9zgwWfxUdXK1KSxAGeUu+AGFVCwF4VuKaDk
        vCAon/Xp7g2iYratKqrhUfqmKcb3d03YfQB5JbczRvvseSJwz6DpjKqvIBszSZaU
        3kB6cbw9UgBHXh1wTXxSPdqdqn0n8KsjPOw1h5gO/UTs45d49O6Wzi1mQJLVmJfH
        XBgumscP7g4pw+L1Jyp6SClthcfnAZE7YsKnSSnX2SCyO8J5+jI0KkFCgn2PBUjE
        C80A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669939077; x=1670025477; bh=HUb79/u3DHt9exkJriR6aYTYCbhg
        1aynIlctuTDFlM8=; b=OZzmklLoXrDZXu/dVqEFZMy3M8fd0CloieNx05pWgjSi
        3PtsZsjGtgV7mGTuyP3W1g7JVqQAQo0Nw6t/onztRtckdK9Oxq0XARSX2WUn5O4v
        sdkCuu372coDPFneKpF/C5Nm0dmrWsa4XzK4caXQ6DkWVySlaub3mvVjSWVzukMq
        mZD5Pu3P2UVQfhXFzvBE+LsaB3weCw8GqmGgrIBsy2tvwhVIcHfjqWKPJE5T85a+
        uMnpC7QqRUPLQjP59beZjFoOc/SoHPCwEeGxX1M7UH13nGwenMubxOKRwe7HxWrG
        KQMCR/+mzDTjkfsbsx3BwIDr9/3presZakhsnkFEjQ==
X-ME-Sender: <xms:hD-JY31xBAPYeQG-Cb0KVszFrMbpfm5BRV7NyyaYGtXrakMfljGesw>
    <xme:hD-JY2G8DJRizhIrU8ax2iDiJLlNunhqPCMYKeLXdws-J3dQQcpQbsvNSAH4zvmQv
    GvCKO6Xl8r52aesoFA>
X-ME-Received: <xmr:hD-JY36zdznFkcCEbg8-iP-QR872pPaQKzJAth9OKIx_ktbA1cKwsaakY63yEoZhDPFqmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdeigddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepfeeileeffeeiteeljeekheetieehhffhfeeuheel
    tdetgfeuvddvffegvdelhfdunecuffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:hD-JY80MRgThr2XyWKZlqgFw-tWJ1jpCVc-Q74d38PfIeghTiZg04A>
    <xmx:hD-JY6Flk5C0tdZc8cYrxVQ-3YJOWryYFOitm1SrrnwFUVPiK_MJlQ>
    <xmx:hD-JY9-HY8tMERCmQmYBGg0jbeNwDH_38tr6okJtgj0X0s35KaFigQ>
    <xmx:hT-JY4Z3klNOwFaIsBcVQz1PS1FrRqLLzt0fKAiyri9-0L2VGRJZtw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 18:57:56 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8FCE8109781; Fri,  2 Dec 2022 02:57:53 +0300 (+03)
Date:   Fri, 2 Dec 2022 02:57:53 +0300
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
Message-ID: <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 05:33:28PM +0100, Juergen Gross wrote:
> On 01.12.22 17:26, Kirill A. Shutemov wrote:
> > On Wed, Nov 02, 2022 at 08:47:10AM +0100, Juergen Gross wrote:
> > > Today PAT is usable only with MTRR being active, with some nasty tweaks
> > > to make PAT usable when running as Xen PV guest, which doesn't support
> > > MTRR.
> > > 
> > > The reason for this coupling is, that both, PAT MSR changes and MTRR
> > > changes, require a similar sequence and so full PAT support was added
> > > using the already available MTRR handling.
> > > 
> > > Xen PV PAT handling can work without MTRR, as it just needs to consume
> > > the PAT MSR setting done by the hypervisor without the ability and need
> > > to change it. This in turn has resulted in a convoluted initialization
> > > sequence and wrong decisions regarding cache mode availability due to
> > > misguiding PAT availability flags.
> > > 
> > > Fix all of that by allowing to use PAT without MTRR and by reworking
> > > the current PAT initialization sequence to match better with the newly
> > > introduced generic cache initialization.
> > > 
> > > This removes the need of the recently added pat_force_disabled flag, so
> > > remove the remnants of the patch adding it.
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > 
> > This patch breaks boot for TDX guest.
> > 
> > Kernel now tries to set CR0.CD which is forbidden in TDX guest[1] and
> > causes #VE:
> > 
> > 	tdx: Unexpected #VE: 28
> > 	VE fault: 0000 [#1] PREEMPT SMP NOPTI
> > 	CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00015-gadfe7512e1d0 #2646
> > 	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > 	RIP: 0010:native_write_cr0 (arch/x86/kernel/cpu/common.c:427)
> > 	 Call Trace:
> > 	  <TASK>
> > 	 ? cache_disable (arch/x86/include/asm/cpufeature.h:173 arch/x86/kernel/cpu/cacheinfo.c:1085)
> > 	 ? cache_cpu_init (arch/x86/kernel/cpu/cacheinfo.c:1132 (discriminator 3))
> > 	 ? setup_arch (arch/x86/kernel/setup.c:1079)
> > 	 ? start_kernel (init/main.c:279 (discriminator 3) init/main.c:477 (discriminator 3) init/main.c:960 (discriminator 3))
> > 	 ? load_ucode_bsp (arch/x86/kernel/cpu/microcode/core.c:155)
> > 	 ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358)
> > 	  </TASK>
> > 
> > Any suggestion how to fix it?
> > 
> > [1] Section 10.6.1. "CR0", https://cdrdv2.intel.com/v1/dl/getContent/733568
> 
> What was the solution before?
> 
> I guess MTRR was disabled, so there was no PAT, too?

Right:

Linus' tree:

[    0.002589] last_pfn = 0x480000 max_arch_pfn = 0x10000000000
[    0.003976] Disabled
[    0.004452] x86/PAT: MTRRs disabled, skipping PAT initialization too.
[    0.005856] CPU MTRRs all blank - virtualized system.
[    0.006915] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC

tip/master:

[    0.003443] last_pfn = 0x20b8e max_arch_pfn = 0x10000000000
[    0.005220] Disabled
[    0.005818] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.007752] tdx: Unexpected #VE: 28

The dangling "Disabled" comes mtrr_bp_init().


> If this is the case, you can go the same route as Xen PV guests do.

Any reason X86_FEATURE_HYPERVISOR cannot be used instead of
X86_FEATURE_XENPV there?

Do we have any virtualized platform that supports it?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
