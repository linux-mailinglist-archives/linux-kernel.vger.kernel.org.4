Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF69750BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjGLPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjGLPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:13:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9431BCC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:13:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0147A5C00E8;
        Wed, 12 Jul 2023 11:13:14 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Wed, 12 Jul 2023 11:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689174793; x=1689261193; bh=dS
        gpbN2qqN6BLnaVZrXrgZ301dLlfYvJq2QGVf6hj70=; b=VRcANVnEB2elnO8va5
        7qDzlklh+Nx+prfh8PRfHEKkTXshU67ofceeigTZ9rT5UDSk8eEOJEa5v5vGynWY
        SKxEIc2xWdNcG5Fp7nxQiBenVluT7+pbKVS/PtmVaCYe2THBu+Y3i5LsoC/SsQus
        5HDA5bbAM9575RbxSE8TMt7kkjvMXkacW4pPbkC7anwh/1oYeHvbqJYPYHQcD5ZX
        YfPHfhBsFeOLQO453EUuy/sX6DDHEuYHgE0mMc5qEUHEY4HopZjtdriX+JpjH32P
        AqQ0wzchbFzP7XzVi9Cjr8qs90QOfpWciNwobxhXsCPlzDOz7WY+a2K/NMerUaAG
        ygrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689174793; x=1689261193; bh=dSgpbN2qqN6BL
        naVZrXrgZ301dLlfYvJq2QGVf6hj70=; b=bVjH8KDBs5z5dsZkuFwFImLh8Slui
        QqmG02Oy49twz7BISKEgnY/ZjFeZ+llsc1+VE2JrZ1L2jhxCL9WrSWeW1xa3/jex
        VrTNsK8otzYHHsCVMwWsxl0tx8NAiJHOerGZMcXSWS4V/wfvURG18KbYEgLVHKap
        JQ5NmZbnDRjHyJZ7cIwBK21dC7VzH2JPwMZn+0Scp4C53kYawRAtY7kg9GGUHUET
        5PEUOurEHtKWOpZmN2cGfUu2rSnFMOGl2C6DecMTnXyu2Tnkkua2tYem8McGi7zS
        hwkVyyREt8oWnHwPwJHtQ3ieIOF0X6R77vGVOMB9q5aNaNwhZUZztYimg==
X-ME-Sender: <xms:CcOuZD-Fkg0ZqLQjR2zxdcaFBKB-jUMrzK5GpBf9OiHxyJqRqF4xWQ>
    <xme:CcOuZPtxIyt8qtTKO1vQ_FGEQa-Z-J2yQTdsD5imCd3KNTR-WkrCcJIly7tLhpT_X
    t8Bj9MZonzZQQsTpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejueehgedtueetgefhheejjeeigffhieefjeehuddvueegtdfh
    heevgfeggfektdenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CcOuZBBiQ-u8LQDVG2wTHBQnbC3NrSY-0LVLKcE5GM9T6MyzF7w_jw>
    <xmx:CcOuZPeMbkHMafJyQYhhPCnBw-dTI7bNOUtwBt4TNClc4LwKsd5DvA>
    <xmx:CcOuZIOzr5DH2IkQel3fUL-35NiT7ydsci_pxLH3EeQdUL5kibP_Yw>
    <xmx:CcOuZEC4N0Oxa4qLd4rkrTSV_8Bo-2PyEOAGG2g9U92Jd0IhGEb3Zg>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0BDAD1700096; Wed, 12 Jul 2023 11:13:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <31c4024b-3553-4117-a22a-b39259c8fea4@app.fastmail.com>
In-Reply-To: <20230711130754.481209-3-gerg@kernel.org>
References: <20230711130754.481209-1-gerg@kernel.org>
 <20230711130754.481209-3-gerg@kernel.org>
Date:   Wed, 12 Jul 2023 11:12:45 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Greg Ungerer" <gerg@kernel.org>, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org, brauner@kernel.org
Subject: Re: [PATCH v2 2/2] riscv: support the elf-fdpic binfmt loader
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023, at 9:07 AM, Greg Ungerer wrote:
> Add support for enabling and using the binfmt_elf_fdpic program loader
> on RISC-V platforms. The most important change is to setup registers
> during program load to pass the mapping addresses to the new process.
>
> One of the interesting features of the elf-fdpic loader is that it
> also allows appropriately compiled ELF format binaries to be loaded on
> nommu systems. Appropriate being those compiled with -pie.
>
> Signed-off-by: Greg Ungerer <gerg@kernel.org>
> ---
> v1->v2: rebase onto linux-6.5-rc1
>         increment PTRACE_GETFDPIC value to keep it unique
>
>  arch/riscv/include/asm/elf.h         | 11 ++++++++++-
>  arch/riscv/include/asm/mmu.h         |  4 ++++
>  arch/riscv/include/uapi/asm/ptrace.h |  5 +++++
>  fs/Kconfig.binfmt                    |  2 +-
>  4 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index c24280774caf..c33fe923ef6d 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -41,6 +41,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>  #define compat_elf_check_arch	compat_elf_check_arch
> 
>  #define CORE_DUMP_USE_REGSET
> +#define ELF_FDPIC_CORE_EFLAGS	0
>  #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
> 
>  /*
> @@ -69,6 +70,13 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>  #define ELF_HWCAP	riscv_get_elf_hwcap()
>  extern unsigned long elf_hwcap;
> 
> +#define ELF_FDPIC_PLAT_INIT(_r, _exec_map_addr, _interp_map_addr, 
> dynamic_addr) \
> +	do { \
> +		(_r)->a1 = _exec_map_addr; \
> +		(_r)->a2 = _interp_map_addr; \
> +		(_r)->a3 = dynamic_addr; \
> +	} while (0)
> +

This should probably be left empty for now; it will be defined by the
ELF FDPIC ABI when that is done, and shouldn't be used by normal ELF
binaries.  I'd ask if there's a reason it starts at a1 instead of a0,
but it seems idiosyncratic on all arches that have full FDPIC support.

-s

>  /*
>   * This yields a string that ld.so will use to load implementation
>   * specific libraries for optimization.  This is more specific in
> @@ -78,7 +86,6 @@ extern unsigned long elf_hwcap;
> 
>  #define COMPAT_ELF_PLATFORM	(NULL)
> 
> -#ifdef CONFIG_MMU
>  #define ARCH_DLINFO						\
>  do {								\
>  	/*							\
> @@ -115,6 +122,8 @@ do {								\
>  	else							 \
>  		NEW_AUX_ENT(AT_IGNORE, 0);			 \
>  } while (0)
> +
> +#ifdef CONFIG_MMU
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
>  struct linux_binprm;
>  extern int arch_setup_additional_pages(struct linux_binprm *bprm,
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 0099dc116168..355504b37f8e 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -20,6 +20,10 @@ typedef struct {
>  	/* A local icache flush is needed before user execution can resume. */
>  	cpumask_t icache_stale_mask;
>  #endif
> +#ifdef CONFIG_BINFMT_ELF_FDPIC
> +	unsigned long exec_fdpic_loadmap;
> +	unsigned long interp_fdpic_loadmap;
> +#endif
>  } mm_context_t;
> 
>  void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t 
> pa,
> diff --git a/arch/riscv/include/uapi/asm/ptrace.h 
> b/arch/riscv/include/uapi/asm/ptrace.h
> index e17c550986a6..30f6d6537adc 100644
> --- a/arch/riscv/include/uapi/asm/ptrace.h
> +++ b/arch/riscv/include/uapi/asm/ptrace.h
> @@ -10,6 +10,11 @@
> 
>  #include <linux/types.h>
> 
> +#define PTRACE_GETFDPIC		33
> +
> +#define PTRACE_GETFDPIC_EXEC	0
> +#define PTRACE_GETFDPIC_INTERP	1
> +
>  /*
>   * User-mode register state for core dumps, ptrace, sigcontext
>   *
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 93539aac0e5b..f5693164ca9a 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>  	bool "Kernel support for FDPIC ELF binaries"
>  	default y if !BINFMT_ELF
> -	depends on ARM || ((M68K || SUPERH || XTENSA) && !MMU)
> +	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>  	select ELFCORE
>  	help
>  	  ELF FDPIC binaries are based on ELF, but allow the individual load
> -- 
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
