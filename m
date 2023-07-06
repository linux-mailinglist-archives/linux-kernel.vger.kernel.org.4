Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660374A715
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGFWcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjGFWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:32:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6214F1723
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:32:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2640a8ceefdso918127a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 15:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688682761; x=1691274761;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0I9jMQ+vOGGYxfcUxVDPVdkj3AkI/uMxWS/xRQpRdI=;
        b=JNsFpKffPwcMV5c6xXSLYavf5b5+EGJksAxRUQKoNvWLjgtnQc1hNtwYLg6+EX34qZ
         +vVBTlPPDiVRrcvywH8v7OhdyFYFpiuXYP81AoOqv/Q40DHzh/Ccqmrg7Yc6sEtR2z+M
         hosh01784Q/g87EjyuLRu+nFDjKBvWWfiE3Z3aV1Pp7c6VD6gcmJ3gJwWPrvPel8XXY1
         Mk96wPh70sWOFBN6Eh73gYCVuF/zgktmGmWRCK+TM+s4gsulN1RbLYfNTnGC9WtGzl80
         XO9r8KdThZ1ESa6xuR5HIEUZbWlwcfKMobMVNTGH1GmfbSZcY4YSfELIS/B9INadWhi+
         HLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682761; x=1691274761;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0I9jMQ+vOGGYxfcUxVDPVdkj3AkI/uMxWS/xRQpRdI=;
        b=JpaxSqDU5LRHQdUEavqlwQfvh9OAfpPXmDMgfXaZ2LQmNtDSvFRhIEK6rUrvJuqShi
         SO58RvTGrf+PhjvZLPtIkrTPjaQA+gwePStmCMmtM5pe5+s9DXUk3w9mrRJni5jMjhtm
         UT9H0tRTvLZAe6Z6G8wJn/TA5bo2PPfLtB0X0+e2dSMIxkZ/LH9WvGdA6P8uHxoaLbDL
         m7KARvFljkSAYFBhKT7zwJuUzFqEBtG4fs3UB9Le92rKUr4AaX66KhCD+rBhrd6+K/ZQ
         v8xaMXGreVA6W/01vhwLDUA4S3EOFKeAnv73mPA35vCaaKV4ePt/AjWigeWbE3TX+XDW
         9GwA==
X-Gm-Message-State: ABy/qLZTWeNv+yET45ajoe6EfkXarJ3eySK6ZE6TVYfthL6JBC1TrJnH
        hnolwo2OClYQJEoiyVoaemzAuw==
X-Google-Smtp-Source: APBJJlHrAPqoYnXyVV7hXvAq2LJAfh1k9BS/GZkN4dxKZDzzO/g5a2uMVaTMYVGNMwD2ph3kKrViJA==
X-Received: by 2002:a17:90b:23c7:b0:263:7d57:16e9 with SMTP id md7-20020a17090b23c700b002637d5716e9mr3210557pjb.21.1688682760697;
        Thu, 06 Jul 2023 15:32:40 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a34c800b00263fd82106asm282941pjf.35.2023.07.06.15.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 15:32:39 -0700 (PDT)
Date:   Thu, 06 Jul 2023 15:32:39 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jul 2023 15:31:47 PDT (-0700)
Subject:     Re: [PATCH v5 11/13] riscv/kexec: refactor for kernel/Kconfig.kexec
In-Reply-To: <20230706222027.189117-12-eric.devolder@oracle.com>
CC:     linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, chenhuacai@kernel.org,
        geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, hpa@zytor.com, keescook@chromium.org,
        paulmck@kernel.org, peterz@infradead.org, frederic@kernel.org,
        akpm@linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        Arnd Bergmann <arnd@arndb.de>, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, tsi@tuyoix.net,
        bhe@redhat.com, hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        eric.devolder@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     eric.devolder@oracle.com
Message-ID: <mhng-c1c5d9c4-b2c8-45c4-ac0a-084cfecb3833@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 15:20:25 PDT (-0700), eric.devolder@oracle.com wrote:
> The kexec and crash kernel options are provided in the common
> kernel/Kconfig.kexec. Utilize the common options and provide
> the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
> equivalent set of KEXEC and CRASH options.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/riscv/Kconfig | 44 +++++++++++++-------------------------------
>  1 file changed, 13 insertions(+), 31 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b49793cf34eb..8a3af850597a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -647,48 +647,30 @@ config RISCV_BOOT_SPINWAIT
>
>  	  If unsure what to do here, say N.
>
> -config KEXEC
> -	bool "Kexec system call"
> -	depends on MMU
> +config ARCH_SUPPORTS_KEXEC
> +	def_bool MMU
> +
> +config ARCH_SELECTS_KEXEC
> +	def_bool y
> +	depends on KEXEC
>  	select HOTPLUG_CPU if SMP
> -	select KEXEC_CORE
> -	help
> -	  kexec is a system call that implements the ability to shutdown your
> -	  current kernel, and to start another kernel. It is like a reboot
> -	  but it is independent of the system firmware. And like a reboot
> -	  you can start any kernel with it, not just Linux.
>
> -	  The name comes from the similarity to the exec system call.
> +config ARCH_SUPPORTS_KEXEC_FILE
> +	def_bool 64BIT && MMU
>
> -config KEXEC_FILE
> -	bool "kexec file based systmem call"
> -	depends on 64BIT && MMU
> +config ARCH_SELECTS_KEXEC_FILE
> +	def_bool y
> +	depends on KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
> -	select KEXEC_CORE
>  	select KEXEC_ELF
> -	help
> -	  This is new version of kexec system call. This system call is
> -	  file based and takes file descriptors as system call argument
> -	  for kernel and initramfs as opposed to list of segments as
> -	  accepted by previous system call.
> -
> -	  If you don't know what to do here, say Y.
>
>  config ARCH_HAS_KEXEC_PURGATORY
>  	def_bool KEXEC_FILE
>  	depends on CRYPTO=y
>  	depends on CRYPTO_SHA256=y
>
> -config CRASH_DUMP
> -	bool "Build kdump crash kernel"
> -	help
> -	  Generate crash dump after being started by kexec. This should
> -	  be normally only set in special crash dump kernels which are
> -	  loaded in the main kernel with kexec-tools into a specially
> -	  reserved region and then later executed after a crash by
> -	  kdump/kexec.
> -
> -	  For more details see Documentation/admin-guide/kdump/kdump.rst
> +config ARCH_SUPPORTS_CRASH_DUMP
> +	def_bool y
>
>  config COMPAT
>  	bool "Kernel support for 32-bit U-mode"

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
