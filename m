Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFB63F53E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiLAQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiLAQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:26:46 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59309C637
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:26:45 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 50E605C005C;
        Thu,  1 Dec 2022 11:26:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 01 Dec 2022 11:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1669912004; x=1669998404; bh=kK
        8tjfIpX7xXRH9wAV/NGprqCcNFpZBgtzVaZrvKOcQ=; b=AiTIC5dWBp2wSd+Fnl
        1jnJl3iAOWM2utMe00NeTzGV5y+oqpjxngq7X6E1mGEHbdMTgJ0sInHMkOMR+eVh
        mcZdXi7RQ6PinLl3mxoYSQaoJ4SZkdux7AHa7zzaELISN22zwT7k+Yzb2xzctTef
        +/iAgqLiaMNO/dyliTGss8SveDmPLR22y0XjARBk6y+KkUoxan6RsNmUGeBl05wo
        s+RPJJJTOA7TeZUBPlSX+pQj+gz7qhmXGAker7seoJZ5F0JH2VsQ1jPYl2caSd7w
        ZkSnq1VmEAv/WxgMODIH2zt73ATKf7BTrSaISZ1ZEcD2taoC42CaXNR2fskofejL
        M2Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669912004; x=1669998404; bh=kK8tjfIpX7xXRH9wAV/NGprqCcNF
        pZBgtzVaZrvKOcQ=; b=EUnC+kzcB7/9E4GLUTwYoUAVAn7yNQb6/c37Ygxf77G9
        qxexz3cNkdwn/MozkQTG+QQWX7J8LnGfXs4fLDoSyo4/gtkHI01hXknCuEklO/4m
        y81AvfFF6xGfSvZ0RLIXhtXdNQWR9CFSATBHbOxwjqVne6GL2+nxMR4plazauZAd
        0tWh+t5Ywtv4w7r7P53/N1x3WD+vt6HL17WgKiC2txju7+GFy2hRfGwzAVrKEBPZ
        8ZU7KBRoww19mV13N/5mQjDjHwObK8YMZ1eIAHpSUUdiAP40A6aqrGsfeCtdoNX1
        J0WdM//UHLTKmt15TDFOLf3KFnaNok2eZ+G5H7Bs4Q==
X-ME-Sender: <xms:wtWIY56hUumOChzUoxWgLsx9NR4fjnsBfELadDNPOBVoZAAMIpIe8A>
    <xme:wtWIY27gAN-wAKsrGqZQk2y4rzqyJlAp-yyKpHEFoCK4YZToVe7CdbKDe_G4o5W1V
    z2Pq6VvpgHXPPjcGH4>
X-ME-Received: <xmr:wtWIYwe7yv2kh2Zq53D54aBDVk5y2M3d7_it0tgljxTulM-UeFYNi7z7_viqO8YJ80az1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepfeeileeffeeiteeljeekheetieehhffhfeeuheel
    tdetgfeuvddvffegvdelhfdunecuffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:wtWIYyJYsfQnV_qzO1J6DnV1Tjm8q4h6Zk1fZ2ImLLhCX9b2LW8NYA>
    <xmx:wtWIY9LWTHxJXLuTyo7F-EVXUwMnt0t7GCCdc6XS0AIr7PDWYM7GMg>
    <xmx:wtWIY7y_Npyr51F8GDGCGf3A1ju4TIzprJNI-TcBmIOA-AE8xh36Xw>
    <xmx:xNWIY09zypy1SO3N-r-7Qutp78aN-zKG24WIf8MTLoq5Up84qcIChg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 11:26:42 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ADFCE109781; Thu,  1 Dec 2022 19:26:39 +0300 (+03)
Date:   Thu, 1 Dec 2022 19:26:39 +0300
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
Message-ID: <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102074713.21493-14-jgross@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:47:10AM +0100, Juergen Gross wrote:
> Today PAT is usable only with MTRR being active, with some nasty tweaks
> to make PAT usable when running as Xen PV guest, which doesn't support
> MTRR.
> 
> The reason for this coupling is, that both, PAT MSR changes and MTRR
> changes, require a similar sequence and so full PAT support was added
> using the already available MTRR handling.
> 
> Xen PV PAT handling can work without MTRR, as it just needs to consume
> the PAT MSR setting done by the hypervisor without the ability and need
> to change it. This in turn has resulted in a convoluted initialization
> sequence and wrong decisions regarding cache mode availability due to
> misguiding PAT availability flags.
> 
> Fix all of that by allowing to use PAT without MTRR and by reworking
> the current PAT initialization sequence to match better with the newly
> introduced generic cache initialization.
> 
> This removes the need of the recently added pat_force_disabled flag, so
> remove the remnants of the patch adding it.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

This patch breaks boot for TDX guest.

Kernel now tries to set CR0.CD which is forbidden in TDX guest[1] and
causes #VE:

	tdx: Unexpected #VE: 28
	VE fault: 0000 [#1] PREEMPT SMP NOPTI
	CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00015-gadfe7512e1d0 #2646
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
	RIP: 0010:native_write_cr0 (arch/x86/kernel/cpu/common.c:427) 
	 Call Trace:
	  <TASK>
	 ? cache_disable (arch/x86/include/asm/cpufeature.h:173 arch/x86/kernel/cpu/cacheinfo.c:1085) 
	 ? cache_cpu_init (arch/x86/kernel/cpu/cacheinfo.c:1132 (discriminator 3)) 
	 ? setup_arch (arch/x86/kernel/setup.c:1079) 
	 ? start_kernel (init/main.c:279 (discriminator 3) init/main.c:477 (discriminator 3) init/main.c:960 (discriminator 3)) 
	 ? load_ucode_bsp (arch/x86/kernel/cpu/microcode/core.c:155) 
	 ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
	  </TASK>

Any suggestion how to fix it?

[1] Section 10.6.1. "CR0", https://cdrdv2.intel.com/v1/dl/getContent/733568
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
