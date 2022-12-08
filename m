Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4896478AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiLHWNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLHWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:12:53 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811EBF0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:12:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D5035C00FF;
        Thu,  8 Dec 2022 17:12:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Dec 2022 17:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670537571; x=1670623971; bh=Gc
        fCs1furkqjeJ9JsMjH5B9zmyb9nXl02haRXvdO0Rs=; b=nmQjB3rzsudjZsJNsX
        KKvXkmJe3NKCsowJNyE5E/SXKuVrZ6KDZEZIC+tdcWT0wmBJ9mdEpXiSTsgir8oP
        ySfAChOsxcJx+Nidk/q4fvO4Z3NkoMXqF6cqvWcPW1ViBrjZ+CMD5PJFDZTiJhPS
        1Ce4V9DO/WchgWgYV/P3UYfyhn2WHXMlmG2Pj7PNPwNCvj+aUUt5ZgX5JPfRVRyM
        I7VP+mjHbVerhk9CPtp7PKGSlDG+iv4/qM7agOm4sk8GJEROXDqYPI7GN1O1+WAJ
        F+f3HeiPI27FFid9UyN1ukQCfgTVYfMOGcbsPnGIeml8A85fjWKeigRoxJSYo+um
        gqUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670537571; x=1670623971; bh=GcfCs1furkqjeJ9JsMjH5B9zmyb9
        nXl02haRXvdO0Rs=; b=nLChVJvnkQKdG60uB2lg435tQIefvrwpLcNvfuJnmhEC
        d+yu3uKbWMyvVjsMVBodTX/u5KjyoS4pYG0WB7QNLqRQN0hdbfcPQw2riE9tIdrJ
        I6aR0Slh+IrjFebyfJ/pV8DhIqHSnTbDkduiIRqQF6M/dB+FW+ofSfSlXJt1jgJ3
        BuquafkfHP6Sk/LbXjGCfL09Vcrp3pZ0jmX8ynofgIgj62A7uKqmCjLYbgEHZKHd
        ZllFV27BgykyhnW4bOHfnAMK6L34IFjDKJibtIz2ah1WFECncnIBaPN08ZsRu6Mi
        SSa+2DNVDBq7h24gdlzLR/X/YM6hPbxerO0h26jlYA==
X-ME-Sender: <xms:YmGSY1ZoTzN0MvpwnnlEijb6sRsCWOwUuvbZDU2CPZ8sFpIvfwN06g>
    <xme:YmGSY8bMyjtGSDh3WFXNCvJzUdIJKvQQYrVqwFCps2mLWdGRqpVwVC5RGIAEAxrnw
    Ka94_zpJUOmgJiljvs>
X-ME-Received: <xmr:YmGSY39sOxvoeShn6L0th2LEPG18L_j_bxIjYnOlEctObJN27vjqmlq6dlMWSuc-R7ykoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:YmGSYzq4vmdJabHrXUGpkfineSwS6xJGHQnDoU1pMIr1BMdC7pd05Q>
    <xmx:YmGSYwpRdOPXxkYe0he7vwx-lc_OUcqha6rFvhSDrvyi64iwnjdr6w>
    <xmx:YmGSY5QZdDtNfrRXxgTBk2kJvITv-RGqgkLasbVPNfEiVD_ssVGLew>
    <xmx:Y2GSY9g5GbIoehLe47QAmtKnMA__5oOSEic98AC_96OAlpLQrarrpg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 17:12:50 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CEF48109CB7; Fri,  9 Dec 2022 01:12:48 +0300 (+03)
Date:   Fri, 9 Dec 2022 01:12:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/5] x86/sev: Add SNP-specific unaccepted memory
 support
Message-ID: <20221208221248.slltzm5ehnbltdee@box.shutemov.name>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <cover.1670513353.git.thomas.lendacky@amd.com>
 <a46c897353203bf24bc104c314cd99dc68f5cdca.1670513353.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46c897353203bf24bc104c314cd99dc68f5cdca.1670513353.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 09:29:13AM -0600, Tom Lendacky wrote:
> Add SNP-specific hooks to the unaccepted memory support in the boot
> path (__accept_memory()) and the core kernel (accept_memory()) in order
> to support booting SNP guests when unaccepted memory is present. Without
> this support, SNP guests will fail to boot and/or panic() when unaccepted
> memory is present in the EFI memory map.
> 
> The process of accepting memory under SNP involves invoking the hypervisor
> to perform a page state change for the page to private memory and then
> issuing a PVALIDATE instruction to accept the page.
> 
> Since the boot path and the core kernel paths perform similar operations,
> move the pvalidate_pages() and vmgexit_psc() functions into sev-shared.c
> to avoid code duplication.
> 
> Create the new header file arch/x86/boot/compressed/sev.h because adding
> the function declaration to any of the existing SEV related header files
> pulls in too many other header files, causing the build to fail.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/Kconfig                |   1 +
>  arch/x86/boot/compressed/mem.c  |   3 +
>  arch/x86/boot/compressed/sev.c  |  54 ++++++++++++++-
>  arch/x86/boot/compressed/sev.h  |  23 +++++++
>  arch/x86/include/asm/sev.h      |   3 +
>  arch/x86/kernel/sev-shared.c    | 103 +++++++++++++++++++++++++++++
>  arch/x86/kernel/sev.c           | 112 ++++----------------------------
>  arch/x86/mm/unaccepted_memory.c |   4 ++
>  8 files changed, 204 insertions(+), 99 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/sev.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d88f61940aa7..0704d4795919 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1549,6 +1549,7 @@ config AMD_MEM_ENCRYPT
>  	select INSTRUCTION_DECODER
>  	select ARCH_HAS_CC_PLATFORM
>  	select X86_MEM_ENCRYPT
> +	select UNACCEPTED_MEMORY
>  	help
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory

I think it misses "depends on EFI_STUB".

The code I've submitted contains "select EFI_STUB", but it causes build
issues for some configurations. I've changed it to "depends on" in git.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
