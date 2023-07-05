Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2347A748774
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjGEPGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjGEPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:06:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2931713;
        Wed,  5 Jul 2023 08:06:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CB115C013C;
        Wed,  5 Jul 2023 11:06:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 11:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688569576; x=1688655976; bh=xA
        WlrtmWIGFsGqKku/ln8wTfTlYDAGy8buXk/3wv9RE=; b=FTtjRrEg80eMcp7J+7
        3pwJsRjPZHaHP4zHSl9PNr0RPHqzpOkF2+29rVqbkseVJbIp0wxkTnB92nkIGYII
        eNt5hEQ1yp7VGmfJCvtDCyerq+AkGIH19p4Y1+zMWVCvKeJiFYetMKd6e65NDhUD
        YfvWM+t7WRsIVrwBQr5Kf53UY5FkDK2exygAQh2vQU8e1mcA33m48MC/I071t89U
        Odq7kVORGEuaSyg8QGgRRqEq+V9b1wJvgL9cBFtk/haMesDly/9DkqtmKlj3uzrb
        FY9mztVl5tNyQ0k2553B9aCI2R+0utNnGgi60M9TtYo+SMe+nyQUw5lugJCqjqnz
        qRaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688569576; x=1688655976; bh=xAWlrtmWIGFsG
        qKku/ln8wTfTlYDAGy8buXk/3wv9RE=; b=kPkHZ58RBmAts6EgoaOIgxUfDxh68
        jJQ0LGXwTg7TWkIjLnIeM4EBuXQ9I0L63V9b4S4+yPc8OUnzhFOv1RjSkUZUamVc
        jRqzdcxVDGiJV5kJnU3BsdnAeecB9JOOPyQoKgSz+rskkjzucVjn4Ax4rSIUm1bG
        B1R8J15zSESE+SvUAHE6p6eQDud0/SqRctjV+GIVwhyDdAsy/i+JTaGqsGg/pUFQ
        BNACpXhn8Qp2o2+XKbj3/h/pF0KjHxkYJWCoc9XRzZxoK9FnxxWsqp/uTuBQ97bf
        H/gSGbxNmwJGMflid0MLss9DjZrf8KdckV7tKlBnRCqRmxuVxy2T2An2Q==
X-ME-Sender: <xms:5YalZJPpaMUzPHAimjWcbAx7HperBaO6JlGIglBCAcuPmFdvoqk2VQ>
    <xme:5YalZL-h_2SDnXLiyS2ShPNmFKTtye72KfuTbNTcPL09hfuW0nhlfxQCwaU82B3oi
    MP5675VKThZC7XsTi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5YalZITQnWG-ZIaBGLa1VB8tvlgw2vIFa8hEd_KcH1mxy-VpS9s-Bg>
    <xmx:5YalZFvMG1DlqLA_-gW9wEQFU-uGok5Yj62sqkVCl_UdGqcWQVOgUQ>
    <xmx:5YalZBeJl5848TssZZCgIiqasgPjqMiGGtp9mr1zvEmANZyl5iVgoQ>
    <xmx:6IalZEAzqVrcN4WDkk0NgBpcSLDC4PKWtDRDvZa84pD24H367l-2Jw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BFA19B6008D; Wed,  5 Jul 2023 11:06:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <09f70de6-9409-4fa4-b9ea-831078d914e7@app.fastmail.com>
In-Reply-To: <20230705142004.3605799-4-eric.devolder@oracle.com>
References: <20230705142004.3605799-1-eric.devolder@oracle.com>
 <20230705142004.3605799-4-eric.devolder@oracle.com>
Date:   Wed, 05 Jul 2023 17:05:53 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Eric DeVolder" <eric.devolder@oracle.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Cc:     "WANG Xuerui" <kernel@xen0n.name>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, "Sven Schnelle" <svens@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Juerg Haefliger" <juerg.haefliger@canonical.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Zi Yan" <ziy@nvidia.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Zhen Lei" <thunder.leizhen@huawei.com>,
        "Xin Li" <xin3.li@intel.com>, "Tejun Heo" <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, tsi@tuyoix.net,
        "Baoquan He" <bhe@redhat.com>, hbathini@linux.ibm.com,
        sourabhjain@linux.ibm.com,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Subject: Re: [PATCH v4 03/13] arm/kexec: refactor for kernel/Kconfig.kexec
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023, at 16:19, Eric DeVolder wrote:
> The kexec and crash kernel options are provided in the common
> kernel/Kconfig.kexec. Utilize the common options and provide
> the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
> equivalent set of KEXEC and CRASH options.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

> +config ARCH_SUPPORTS_KEXEC
> +	def_bool (!SMP || PM_SLEEP_SMP) && MMU
> 
>  config ATAGS_PROC
>  	bool "Export atags in procfs"
> @@ -1668,17 +1656,8 @@ config ATAGS_PROC
>  	  Should the atags used to boot the kernel be exported in an "atags"
>  	  file in procfs. Useful with kexec.
> 
> -config CRASH_DUMP
> -	bool "Build kdump crash kernel (EXPERIMENTAL)"
> -	help
> -	  Generate crash dump after being started by kexec. This should
> -	  be normally only set in special crash dump kernels which are
> -	  loaded in the main kernel with kexec-tools into a specially
> -	  reserved region and then later executed after a crash by
> -	  kdump/kexec. The crash dump kernel must be compiled to a
> -	  memory address not used by the main kernel
> -
> -	  For more details see Documentation/admin-guide/kdump/kdump.rst
> +config ARCH_SUPPORTS_CRASH_DUMP
> +	def_bool y
> 

I see this is now in linux-next, and it caused a few randconfig
build issues, these never happened in the past:

* The #ifdef CONFIG_KEXEC check in arch/arm/include/asm/kexec.h
  needs to be changed to CONFIG_KEXEC_CORE:

include/linux/kexec.h:41:2: error: #error KEXEC_SOURCE_MEMORY_LIMIT not defined

  same thing on m68k

* ARCH_SUPPORTS_CRASH_DUMP needs the same dependency as ARCH_SUPPORTS_KEXEC,
  otherwise we seem to run into an obscure assembler error building the kdump
  core on architectures that do not support kdump:

  /tmp/ccpYl6w9.s:1546: Error: selected processor does not support requested special purpose register -- `mrs r2,cpsr'

* Most architectures build machine_kexec.o only when KEXEC is enabled,
  this also needs to be changed to KEXEC_CORE:

--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_FUNCTION_TRACER) += entry-ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)   += ftrace.o insn.o patch.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)       += jump_label.o insn.o patch.o
-obj-$(CONFIG_KEXEC)            += machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)       += machine_kexec.o relocate_kernel.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
 obj-$(CONFIG_KPROBES)          += patch.o insn.o
 obj-$(CONFIG_OABI_COMPAT)      += sys_oabi-compat.o


   Arnd
