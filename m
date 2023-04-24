Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA86CFD48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjC3HtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjC3Hsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:48:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A994C13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:48:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l12so18064783wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680162528;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=okeSFnANawi1LC1aBHEsxSK/GYfBSKiaqPeM+AamHZg=;
        b=HzMJRijwdPPEPy8qvkSlWVtDrQWbV6dX/IL9jpBcjDXV5uqcfCKxOOzHCZbYFRAYG9
         PusIZChCya8EGmAMCT6kgYuzD4J2gzg2TMrbZr/2YX4LHmNMTKGkwWb+1qc/m3Aouwo0
         Pk8GcPYf09RdHiRVewn+Z085xM0Qb9aDCv1E+ZRCKQBq1j+mwW6mkzvRepX9pEnryCbo
         LNK6+ZH8/UojXRD/l6SrrhXj6lreIAjsqW0h+a28rfzS1vPWYufZ7uObUt8gdDt931rC
         S/gMa8KGdjKfyceVQVMUx5FjJS76Sc32y8i/cAO0ok/3Nnf/1vgP9lvisyAOrgPVObJQ
         nypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162528;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okeSFnANawi1LC1aBHEsxSK/GYfBSKiaqPeM+AamHZg=;
        b=V8+2ImrNuAXtPZSxsk2RpoNpYdRQVvCPXwjSqsyCpxmOKJdHrx1wa50ttMbr9YEMu/
         VeTgLJ4uI/D37A6qUDqja5z8AyBuPpuSxt2NI32dZA/nFYGmIlfuknqcO9WKnIiP0Kz7
         g7JXc0VwZ++sMqT8+Fpcm1jEBcI6yfBM2LbqQhkzgJv+CrsmO9KD+QCygNpI54AvWJAd
         vXU09ceQQ0I/Qvu5B0chdBtP3Vz5G257uOofmnmoCZKlk+inXu9B0lRIsmlgzQBa171C
         AHGxytw//+s4Hy8RVupzzgk/GXcxzVtwY8OLaZM5uqYtu1VWSCuZHsobatTY68DRhV7I
         g8Sg==
X-Gm-Message-State: AAQBX9c7N2CBXvSXMvntOIdJ95NkxFf6MljexEkPXWhgJVmRyjyXHiC1
        Mx8UZmlVpDvZc2wCgIwUQQybVw==
X-Google-Smtp-Source: AKy350YBDtDK4PFtkzL9mw2TdTBg5d1e+av3yV0hQ8sa0sVV3ghf+fwGAiaHFlngdg878+Nut7sZlA==
X-Received: by 2002:adf:f0ca:0:b0:2d3:f610:8417 with SMTP id x10-20020adff0ca000000b002d3f6108417mr16612494wro.0.1680162527868;
        Thu, 30 Mar 2023 00:48:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f? ([2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f])
        by smtp.gmail.com with ESMTPSA id z1-20020adff1c1000000b002c6e8af1037sm32115528wro.104.2023.03.30.00.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:48:47 -0700 (PDT)
Message-ID: <d7f36a28-0cae-a035-791b-363754aefeee@linaro.org>
Date:   Thu, 30 Mar 2023 09:48:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Daniel Golle <daniel@makrotopia.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-19-arnd@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230327121317.4081816-19-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 14:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The cache management operations for noncoherent DMA on ARMv6 work
> in two different ways:
> 
>   * When CONFIG_DMA_CACHE_RWFO is set, speculative prefetches on in-flight
>     DMA buffers lead to data corruption when the prefetched data is written
>     back on top of data from the device.
> 
>   * When CONFIG_DMA_CACHE_RWFO is disabled, a cache flush on one CPU
>     is not seen by the other core(s), leading to inconsistent contents
>     accross the system.
> 
> As a consequence, neither configuration is actually safe to use in a
> general-purpose kernel that is used on both MPCore systems and ARM1176
> with prefetching enabled.
> 
> We could add further workarounds to make the behavior more dynamic based
> on the system, but realistically, there are close to zero remaining
> users on any ARM11MPCore anyway, and nobody seems too interested in it,
> compared to the more popular ARM1176 used in BMC2835 and AST2500.
> 
> The Oxnas platform has some minimal support in OpenWRT, but most of the
> drivers and dts files never made it into the mainline kernel, while the
> Arm Versatile/Realview platform mainly serves as a reference system but
> is not necessary to be kept working once all other ARM11MPCore are gone.

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

It's sad but it's the reality, there's no chance full OXNAS support will
ever come upstream and no real work has been done for years.

I think OXNAS support can be programmed for removal for next release,
it would need significant work to rework current support to make it acceptable
before trying to upstream missing bits anyway.

Thanks,
Neil


> 
> Take the easy way out here and drop support for multiprocessing on
> ARMv6, along with the CONFIG_DMA_CACHE_RWFO option and the cache
> management implementation for it. This also helps with other ARMv6
> issues, but for the moment leaves the ability to build a kernel that
> can run on both ARMv7 SMP and single-processor ARMv6, which we probably
> want to stop supporting as well, but not as part of this series.
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-oxnas@groups.io
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I could use some help clarifying the above changelog text to describe
> the exact problem, and how the CONFIG_DMA_CACHE_RWFO actually works on
> MPCore. The TRMs for both 1176 and 11MPCore only describe prefetching
> into the instruction cache, not the data cache, but this can end up in
> the outercache as a result. The 1176 has some extra control bits to
> control prefetching, but I found no reference that explains why an
> MPCore does not run into the problem.
> ---
>   arch/arm/mach-oxnas/Kconfig                |  4 -
>   arch/arm/mach-oxnas/Makefile               |  1 -
>   arch/arm/mach-oxnas/headsmp.S              | 23 ------
>   arch/arm/mach-oxnas/platsmp.c              | 96 ----------------------
>   arch/arm/mach-versatile/platsmp-realview.c |  4 -
>   arch/arm/mm/Kconfig                        | 19 -----
>   arch/arm/mm/cache-v6.S                     | 31 -------
>   7 files changed, 178 deletions(-)
>   delete mode 100644 arch/arm/mach-oxnas/headsmp.S
>   delete mode 100644 arch/arm/mach-oxnas/platsmp.c
> 
> diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
> index a9ded7079268..a054235c3d6c 100644
> --- a/arch/arm/mach-oxnas/Kconfig
> +++ b/arch/arm/mach-oxnas/Kconfig
> @@ -28,10 +28,6 @@ config MACH_OX820
>   	bool "Support OX820 Based Products"
>   	depends on ARCH_MULTI_V6
>   	select ARM_GIC
> -	select DMA_CACHE_RWFO if SMP
> -	select HAVE_SMP
> -	select HAVE_ARM_SCU if SMP
> -	select HAVE_ARM_TWD if SMP
>   	help
>   	  Include Support for the Oxford Semiconductor OX820 SoC Based Products.
>   
> diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
> index 0e78ecfe6c49..a4e40e534e6a 100644
> --- a/arch/arm/mach-oxnas/Makefile
> +++ b/arch/arm/mach-oxnas/Makefile
> @@ -1,2 +1 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> diff --git a/arch/arm/mach-oxnas/headsmp.S b/arch/arm/mach-oxnas/headsmp.S
> deleted file mode 100644
> index 9c0f1479f33a..000000000000
> --- a/arch/arm/mach-oxnas/headsmp.S
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
> - * Copyright (c) 2003 ARM Limited
> - * All Rights Reserved
> - */
> -#include <linux/linkage.h>
> -#include <linux/init.h>
> -
> -	__INIT
> -
> -/*
> - * OX820 specific entry point for secondary CPUs.
> - */
> -ENTRY(ox820_secondary_startup)
> -	mov r4, #0
> -	/* invalidate both caches and branch target cache */
> -	mcr p15, 0, r4, c7, c7, 0
> -	/*
> -	 * we've been released from the holding pen: secondary_stack
> -	 * should now contain the SVC stack for this core
> -	 */
> -	b	secondary_startup
> diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
> deleted file mode 100644
> index f0a50b9e61df..000000000000
> --- a/arch/arm/mach-oxnas/platsmp.c
> +++ /dev/null
> @@ -1,96 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
> - * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
> - * Copyright (C) 2002 ARM Ltd.
> - * All Rights Reserved
> - */
> -#include <linux/io.h>
> -#include <linux/delay.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -
> -#include <asm/cacheflush.h>
> -#include <asm/cp15.h>
> -#include <asm/smp_plat.h>
> -#include <asm/smp_scu.h>
> -
> -extern void ox820_secondary_startup(void);
> -
> -static void __iomem *cpu_ctrl;
> -static void __iomem *gic_cpu_ctrl;
> -
> -#define HOLDINGPEN_CPU_OFFSET		0xc8
> -#define HOLDINGPEN_LOCATION_OFFSET	0xc4
> -
> -#define GIC_NCPU_OFFSET(cpu)		(0x100 + (cpu)*0x100)
> -#define GIC_CPU_CTRL			0x00
> -#define GIC_CPU_CTRL_ENABLE		1
> -
> -static int __init ox820_boot_secondary(unsigned int cpu,
> -		struct task_struct *idle)
> -{
> -	/*
> -	 * Write the address of secondary startup into the
> -	 * system-wide flags register. The BootMonitor waits
> -	 * until it receives a soft interrupt, and then the
> -	 * secondary CPU branches to this address.
> -	 */
> -	writel(virt_to_phys(ox820_secondary_startup),
> -			cpu_ctrl + HOLDINGPEN_LOCATION_OFFSET);
> -
> -	writel(cpu, cpu_ctrl + HOLDINGPEN_CPU_OFFSET);
> -
> -	/*
> -	 * Enable GIC cpu interface in CPU Interface Control Register
> -	 */
> -	writel(GIC_CPU_CTRL_ENABLE,
> -		gic_cpu_ctrl + GIC_NCPU_OFFSET(cpu) + GIC_CPU_CTRL);
> -
> -	/*
> -	 * Send the secondary CPU a soft interrupt, thereby causing
> -	 * the boot monitor to read the system wide flags register,
> -	 * and branch to the address found there.
> -	 */
> -	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> -
> -	return 0;
> -}
> -
> -static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
> -{
> -	struct device_node *np;
> -	void __iomem *scu_base;
> -
> -	np = of_find_compatible_node(NULL, NULL, "arm,arm11mp-scu");
> -	scu_base = of_iomap(np, 0);
> -	of_node_put(np);
> -	if (!scu_base)
> -		return;
> -
> -	/* Remap CPU Interrupt Interface Registers */
> -	np = of_find_compatible_node(NULL, NULL, "arm,arm11mp-gic");
> -	gic_cpu_ctrl = of_iomap(np, 1);
> -	of_node_put(np);
> -	if (!gic_cpu_ctrl)
> -		goto unmap_scu;
> -
> -	np = of_find_compatible_node(NULL, NULL, "oxsemi,ox820-sys-ctrl");
> -	cpu_ctrl = of_iomap(np, 0);
> -	of_node_put(np);
> -	if (!cpu_ctrl)
> -		goto unmap_scu;
> -
> -	scu_enable(scu_base);
> -	flush_cache_all();
> -
> -unmap_scu:
> -	iounmap(scu_base);
> -}
> -
> -static const struct smp_operations ox820_smp_ops __initconst = {
> -	.smp_prepare_cpus	= ox820_smp_prepare_cpus,
> -	.smp_boot_secondary	= ox820_boot_secondary,
> -};
> -
> -CPU_METHOD_OF_DECLARE(ox820_smp, "oxsemi,ox820-smp", &ox820_smp_ops);
> diff --git a/arch/arm/mach-versatile/platsmp-realview.c b/arch/arm/mach-versatile/platsmp-realview.c
> index 5d363385c801..fa31fd2d211d 100644
> --- a/arch/arm/mach-versatile/platsmp-realview.c
> +++ b/arch/arm/mach-versatile/platsmp-realview.c
> @@ -18,16 +18,12 @@
>   #define REALVIEW_SYS_FLAGSSET_OFFSET	0x30
>   
>   static const struct of_device_id realview_scu_match[] = {
> -	{ .compatible = "arm,arm11mp-scu", },
>   	{ .compatible = "arm,cortex-a9-scu", },
>   	{ .compatible = "arm,cortex-a5-scu", },
>   	{ }
>   };
>   
>   static const struct of_device_id realview_syscon_match[] = {
> -        { .compatible = "arm,core-module-integrator", },
> -        { .compatible = "arm,realview-eb-syscon", },
> -        { .compatible = "arm,realview-pb11mp-syscon", },
>           { .compatible = "arm,realview-pbx-syscon", },
>           { },
>   };
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index c5bbae86f725..16b62bc0a970 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -937,25 +937,6 @@ config VDSO
>   	  You must have glibc 2.22 or later for programs to seamlessly
>   	  take advantage of this.
>   
> -config DMA_CACHE_RWFO
> -	bool "Enable read/write for ownership DMA cache maintenance"
> -	depends on CPU_V6K && SMP
> -	default y
> -	help
> -	  The Snoop Control Unit on ARM11MPCore does not detect the
> -	  cache maintenance operations and the dma_{map,unmap}_area()
> -	  functions may leave stale cache entries on other CPUs. By
> -	  enabling this option, Read or Write For Ownership in the ARMv6
> -	  DMA cache maintenance functions is performed. These LDR/STR
> -	  instructions change the cache line state to shared or modified
> -	  so that the cache operation has the desired effect.
> -
> -	  Note that the workaround is only valid on processors that do
> -	  not perform speculative loads into the D-cache. For such
> -	  processors, if cache maintenance operations are not broadcast
> -	  in hardware, other workarounds are needed (e.g. cache
> -	  maintenance broadcasting in software via FIQ).
> -
>   config OUTER_CACHE
>   	bool
>   
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index abae7ff5defc..f6ee53c1de20 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -201,10 +201,6 @@ ENTRY(v6_flush_kern_dcache_area)
>    *	- end     - virtual end address of region
>    */
>   ENTRY(v6_dma_inv_range)
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrb	r2, [r0]			@ read for ownership
> -	strb	r2, [r0]			@ write for ownership
> -#endif
>   	tst	r0, #D_CACHE_LINE_SIZE - 1
>   	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>   #ifdef HARVARD_CACHE
> @@ -213,10 +209,6 @@ ENTRY(v6_dma_inv_range)
>   	mcrne	p15, 0, r0, c7, c11, 1		@ clean unified line
>   #endif
>   	tst	r1, #D_CACHE_LINE_SIZE - 1
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrbne	r2, [r1, #-1]			@ read for ownership
> -	strbne	r2, [r1, #-1]			@ write for ownership
> -#endif
>   	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
>   #ifdef HARVARD_CACHE
>   	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D line
> @@ -231,10 +223,6 @@ ENTRY(v6_dma_inv_range)
>   #endif
>   	add	r0, r0, #D_CACHE_LINE_SIZE
>   	cmp	r0, r1
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrlo	r2, [r0]			@ read for ownership
> -	strlo	r2, [r0]			@ write for ownership
> -#endif
>   	blo	1b
>   	mov	r0, #0
>   	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
> @@ -248,9 +236,6 @@ ENTRY(v6_dma_inv_range)
>   ENTRY(v6_dma_clean_range)
>   	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>   1:
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldr	r2, [r0]			@ read for ownership
> -#endif
>   #ifdef HARVARD_CACHE
>   	mcr	p15, 0, r0, c7, c10, 1		@ clean D line
>   #else
> @@ -269,10 +254,6 @@ ENTRY(v6_dma_clean_range)
>    *	- end     - virtual end address of region
>    */
>   ENTRY(v6_dma_flush_range)
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrb	r2, [r0]		@ read for ownership
> -	strb	r2, [r0]		@ write for ownership
> -#endif
>   	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>   1:
>   #ifdef HARVARD_CACHE
> @@ -282,10 +263,6 @@ ENTRY(v6_dma_flush_range)
>   #endif
>   	add	r0, r0, #D_CACHE_LINE_SIZE
>   	cmp	r0, r1
> -#ifdef CONFIG_DMA_CACHE_RWFO
> -	ldrblo	r2, [r0]			@ read for ownership
> -	strblo	r2, [r0]			@ write for ownership
> -#endif
>   	blo	1b
>   	mov	r0, #0
>   	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
> @@ -301,13 +278,7 @@ ENTRY(v6_dma_map_area)
>   	add	r1, r1, r0
>   	teq	r2, #DMA_FROM_DEVICE
>   	beq	v6_dma_inv_range
> -#ifndef CONFIG_DMA_CACHE_RWFO
>   	b	v6_dma_clean_range
> -#else
> -	teq	r2, #DMA_TO_DEVICE
> -	beq	v6_dma_clean_range
> -	b	v6_dma_flush_range
> -#endif
>   ENDPROC(v6_dma_map_area)
>   
>   /*
> @@ -317,11 +288,9 @@ ENDPROC(v6_dma_map_area)
>    *	- dir	- DMA direction
>    */
>   ENTRY(v6_dma_unmap_area)
> -#ifndef CONFIG_DMA_CACHE_RWFO
>   	add	r1, r1, r0
>   	teq	r2, #DMA_TO_DEVICE
>   	bne	v6_dma_inv_range
> -#endif
>   	ret	lr
>   ENDPROC(v6_dma_unmap_area)
>   

