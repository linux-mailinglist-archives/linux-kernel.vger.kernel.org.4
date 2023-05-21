Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8F70B201
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjEUXKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 19:10:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC8EC3;
        Sun, 21 May 2023 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=K4WPA18aOPTDws24S0fhivh+wdB5uMs20IVqeoLDFVg=; b=hJTNXKpY1GbFcDud/StMM0mEm2
        xOmsZsaInQKpMD9FooAVISqofGLGHm9a5H/rHHpttDavg1t7RPFnHv8iu4yaUr4I+Skm4f77Ts7dJ
        N2rIhAHDLkfqC7vOSwQBkIZ+8V7ubQvABAmenRS2bJGr7w2aWA++bPIRU/l7QEgnL9z+xQKpIf0O8
        gXwWSbOoxhiW+4lat9w6/+2JVZ+DJixh+RMPg1k6trv0YRuSKave9LzH9XIY2TvdiFKQwJ5R7v2gl
        pGJdi2o9fdGbWKWa+/Afah6LjIxCRvgysMR2L09BoIET2yphe3qVs/N+Gt0oXMonLk1kEizCDctvw
        p0QorifA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0sCL-004pPC-1G;
        Sun, 21 May 2023 23:10:47 +0000
Message-ID: <7ee02152-d498-87dc-d372-017212888db9@infradead.org>
Date:   Sun, 21 May 2023 16:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] Documentation: kernel-parameters: Add some MIPS
 parameters
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-doc@vger.kernel.org, corbet@lwn.net
References: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
 <20230521223124.21911-4-jiaxun.yang@flygoat.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230521223124.21911-4-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

A few of these new entries are out of place, i.e., not in
sorted order. See below.


On 5/21/23 15:31, Jiaxun Yang wrote:
> Those parameters lives in MIPS kernel since very start.
> Document them for convenience.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9c502d3aa0cd..67a0c3f7eca3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -713,6 +713,8 @@
>  			Sets the size of memory pool for coherent, atomic dma
>  			allocations, by default set to 256K.
>  
> +	coherentio	[KNL,MIPS] Force enable hardware DMA cache coherency.
> +

This one should be just above "coherent_pool".

>  	com20020=	[HW,NET] ARCnet - COM20020 chipset
>  			Format:
>  			<io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
> @@ -3626,6 +3628,8 @@
>  
>  	nocache		[ARM]
>  
> +	nocoherentio	[KNL,MIPS] Force enable software DMA cache coherency.
> +

OK.

>  	no_console_suspend
>  			[HW] Never suspend the console
>  			Disable suspending of consoles during suspend and
> @@ -3645,6 +3649,7 @@
>  			[KNL] Disable object debugging
>  
>  	nodsp		[SH] Disable hardware DSP at boot time.
> +			[MIPS] Disable DSP ASE at boot time.
>  
>  	noefi		Disable EFI runtime services support.
>  
> @@ -3667,6 +3672,8 @@
>  
>  	nofsgsbase	[X86] Disables FSGSBASE instructions.
>  
> +	noftlb		[MIPS] Disable Fixed TLB at boot time.

OK.

> +
>  	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
>  			register save and restore. The kernel will only save
>  			legacy floating-point registers on task switch.
> @@ -3678,6 +3685,8 @@
>  			in certain environments such as networked servers or
>  			real-time systems.
>  
> +	nohtw		[MIPS] Disable hardware page table walker at boot time.
> +

nohtw should be immediately after "nohlt".

>  	no_hash_pointers
>  			Force pointers printed to the console or buffers to be
>  			unhashed.  By default, when a pointer is printed via %p
> @@ -3758,6 +3767,8 @@
>  
>  	nolapic_timer	[X86-32,APIC] Do not use the local APIC timer.
>  
> +	noulri          [MIPS] Disable RDHWR ULR access for user space.
> +
This should be just after "no_uaccess_flush".

>  	nomca		[IA-64] Disable machine check abort handling
>  
>  	nomce		[X86-32] Disable Machine Check Exception
> @@ -3882,6 +3893,8 @@
>  			[X86,PV_OPS] Disable paravirtualized VMware scheduler
>  			clock and use the default one.
>  
> +	nowait		[MIPS] Disable the wait instruction for idle.
> +

OK.

>  	nowatchdog	[KNL] Disable both lockup detectors, i.e.
>  			soft-lockup and NMI watchdog (hard-lockup).
>  
> @@ -3893,6 +3906,8 @@
>  			LEGACY_XAPIC_DISABLED bit set in the
>  			IA32_XAPIC_DISABLE_STATUS MSR.
>  
> +	noxpa		[MIPS] Disable XPA (eXtended Physical Addressing) ASE.
> +

OK.

>  	noxsave		[BUGS=X86] Disables x86 extended register state save
>  			and restore using xsave. The kernel will fallback to
>  			enabling legacy floating-point and sse state.
> @@ -3936,6 +3951,8 @@
>  
>  	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
>  
> +	ntlb=		[MIPS] Override max number of TLB entries.
> +

OK.

>  	numa=off 	[KNL, ARM64, PPC, RISCV, SPARC, X86] Disable NUMA, Only
>  			set up a single NUMA node spanning all memory.
>  
> @@ -5273,6 +5290,18 @@
>  	rcupdate.rcu_self_test= [KNL]
>  			Run the RCU early boot self tests
>  
> +	rd_size=	[KNL,MIPS]
> +			Specify size of initrd in memory.
> +			Need to be used with rd_start.
> +
> +	rd_start=	[KNL,MIPS]
> +			Specify a virtual address from which to load the initrd.
> +			Must in KSEG0 or XKPHYS space.
> +			Need to be used with rd_size.
> +

rd_size and rd_start should be just after "rdrand".

> +	rdhwr_noopt	[MIPS] Disable optimization of trap and emulation for
> +			"RDHWR v1, $29" instruction.
> +

OK.

>  	rdinit=		[KNL]
>  			Format: <full_path>
>  			Run specified binary instead of /init from the ramdisk,

thanks.
-- 
~Randy
