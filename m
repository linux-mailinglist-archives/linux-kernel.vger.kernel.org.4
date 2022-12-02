Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEF6640CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiLBR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiLBR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:59:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC42E4659
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:59:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so5836141pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/g5uvnYwRmr+sEhxP8QlxzB990ZKGcFSKeR2r1HQQM=;
        b=hKd2bbRvFgxgtZ3+kjtTc3tknNO/vB/XvEb6+VDNMH84KLCdsNbCs4yclNkQ9q0SvS
         F+6SebZk9l6FLCm8I06gT8ZJfrTIdbAfhWFF3TqnHG+PSm+lTfBNI1SRoeES8Pkm3eob
         NW0t3ZIZcj9SORPQ/AuMRnh6ZEWUonOWXxDkVTSNLOXHfVdtPT9rb/vR2ldZnzeGHxTg
         bTOPJH/Ny9lcM/le8DPrkKDw6dP67j7JDJLejNmv8tP4NJdohUUbXMab+qH/pJMIh7xy
         uSd3bIVh8Z9TDPyyXfmw7emBWFkD6abT5lUOXkNQD2bpFm6MAiAormYrJ4HHebeNxFKY
         cq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/g5uvnYwRmr+sEhxP8QlxzB990ZKGcFSKeR2r1HQQM=;
        b=6/u9/kSo3NA0d3HgQ99sOc8WGxPKGpaSqjnpcUG1yUaOVLTMilQ0IBCXZQ1KAWqrHf
         LOuBPoiVorcfA3VyW2FCdPRsd+EMqBBXZMv/NkRzM+Ec3eBk2+n4b0r5JrvtRd0sKZXI
         66yk704tGwZXNVMp8i1Tsb3L/av4n8hAKOED/8pcFyONBYSd0YYBG77dNgtWVP7nmLAO
         UUgpoMZU/YmXT9bQ/Scd8fxVPfjp4k/tqemmYvatbhY123nZPtgRGtElhwXhDcvBGAfs
         BrS0ZdQqHA98Mvl86yTg2Lo0o5FHKMAZnAiu4HwCjEvOMy5xC7oiD4xtvd1fImPYxmw2
         JK9A==
X-Gm-Message-State: ANoB5plvPuqUKXy3745ThbjPMgTSnfyuxkDpri1G7GiYanh/jj4M/QC5
        u/kPqjEXdVq8jgqalWAAQthS/dFHv8iUhTR+s1k=
X-Google-Smtp-Source: AA0mqf4EAYlfKGmJpNuAVg/4gPX8vH+N4DLNdOuDKE1pDeWtyWMiecWeRuBd3+Fo+nZ/rKUQH1tN+A==
X-Received: by 2002:a17:902:7584:b0:189:6292:990a with SMTP id j4-20020a170902758400b001896292990amr38759413pll.171.1670003960005;
        Fri, 02 Dec 2022 09:59:20 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b0018948b0082asm5948744plf.140.2022.12.02.09.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:59:19 -0800 (PST)
Date:   Fri, 02 Dec 2022 09:59:19 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 09:59:08 PST (-0800)
Subject:     Re: [PATCH 12/12] mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
In-Reply-To: <20221121171202.22080-13-vbabka@suse.cz>
CC:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, 42.hyeyoo@gmail.com, roman.gushchin@linux.dev,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        willy@infradead.org, patches@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz,
        linux@armlinux.org.uk, aaro.koskinen@iki.fi, jmkrzyszt@gmail.com,
        tony@atomide.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        ysato@users.sourceforge.jp, dalias@libc.org,
        Arnd Bergmann <arnd@arndb.de>, josh@joshtriplett.org,
        Conor Dooley <conor@kernel.org>, christophe.leroy@csgroup.eu,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vbabka@suse.cz, damien.lemoal@opensource.wdc.com
Message-ID: <mhng-b0214281-7ee5-4698-a158-980427a97472@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 09:12:02 PST (-0800), vbabka@suse.cz wrote:
> As explained in [1], we would like to remove SLOB if possible.
>
> - There are no known users that need its somewhat lower memory footprint
>   so much that they cannot handle SLUB (after some modifications by the
>   previous patches) instead.
>
> - It is an extra maintenance burden, and a number of features are
>   incompatible with it.
>
> - It blocks the API improvement of allowing kfree() on objects allocated
>   via kmem_cache_alloc().
>
> As the first step, rename the CONFIG_SLOB option in the slab allocator
> configuration choice to CONFIG_SLOB_DEPRECATED. Add CONFIG_SLOB
> depending on CONFIG_SLOB_DEPRECATED as an internal option to avoid code
> churn. This will cause existing .config files and defconfigs with
> CONFIG_SLOB=y to silently switch to the default (and recommended
> replacement) SLUB, while still allowing SLOB to be configured by anyone
> that notices and needs it. But those should contact the slab maintainers
> and linux-mm@kvack.org as explained in the updated help. With no valid
> objections, the plan is to update the existing defconfigs to SLUB and
> remove SLOB in a few cycles.
>
> To make SLUB more suitable replacement for SLOB, a CONFIG_SLUB_TINY
> option was introduced to limit SLUB's memory overhead.
> There is a number of defconfigs specifying CONFIG_SLOB=y. As part of
> this patch, update them to select CONFIG_SLUB and CONFIG_SLUB_TINY.
>
> [1] https://lore.kernel.org/all/b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz/
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-omap@vger.kernel.org>
> Cc: <openrisc@lists.librecores.org>
> Cc: <linux-riscv@lists.infradead.org>
> Cc: <linux-sh@vger.kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  arch/arm/configs/clps711x_defconfig            |  3 ++-
>  arch/arm/configs/collie_defconfig              |  3 ++-
>  arch/arm/configs/multi_v4t_defconfig           |  3 ++-
>  arch/arm/configs/omap1_defconfig               |  3 ++-
>  arch/arm/configs/pxa_defconfig                 |  3 ++-
>  arch/arm/configs/tct_hammer_defconfig          |  3 ++-
>  arch/arm/configs/xcep_defconfig                |  3 ++-
>  arch/openrisc/configs/or1ksim_defconfig        |  3 ++-
>  arch/openrisc/configs/simple_smp_defconfig     |  3 ++-
>  arch/riscv/configs/nommu_k210_defconfig        |  3 ++-
>  arch/riscv/configs/nommu_k210_sdcard_defconfig |  3 ++-
>  arch/riscv/configs/nommu_virt_defconfig        |  3 ++-
>  arch/sh/configs/rsk7201_defconfig              |  3 ++-
>  arch/sh/configs/rsk7203_defconfig              |  3 ++-
>  arch/sh/configs/se7206_defconfig               |  3 ++-
>  arch/sh/configs/shmin_defconfig                |  3 ++-
>  arch/sh/configs/shx3_defconfig                 |  3 ++-
>  kernel/configs/tiny.config                     |  5 +++--
>  mm/Kconfig                                     | 17 +++++++++++++++--
>  19 files changed, 52 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
> index 92481b2a88fa..adcee238822a 100644
> --- a/arch/arm/configs/clps711x_defconfig
> +++ b/arch/arm/configs/clps711x_defconfig
> @@ -14,7 +14,8 @@ CONFIG_ARCH_EDB7211=y
>  CONFIG_ARCH_P720T=y
>  CONFIG_AEABI=y
>  # CONFIG_COREDUMP is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
> index 2a2d2cb3ce2e..69341c33e0cc 100644
> --- a/arch/arm/configs/collie_defconfig
> +++ b/arch/arm/configs/collie_defconfig
> @@ -13,7 +13,8 @@ CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
>  CONFIG_FPE_NWFPE=y
>  CONFIG_PM=y
>  # CONFIG_SWAP is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
> index e2fd822f741a..b60000a89aff 100644
> --- a/arch/arm/configs/multi_v4t_defconfig
> +++ b/arch/arm/configs/multi_v4t_defconfig
> @@ -25,7 +25,8 @@ CONFIG_ARM_CLPS711X_CPUIDLE=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_PARTITION_ADVANCED=y
>  # CONFIG_COREDUMP is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
> diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
> index 70511fe4b3ec..246f1bba7df5 100644
> --- a/arch/arm/configs/omap1_defconfig
> +++ b/arch/arm/configs/omap1_defconfig
> @@ -42,7 +42,8 @@ CONFIG_MODULE_FORCE_UNLOAD=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_BINFMT_MISC=y
>  # CONFIG_SWAP is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index d60cc9cc4c21..0a0f12df40b5 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -49,7 +49,8 @@ CONFIG_PARTITION_ADVANCED=y
>  CONFIG_LDM_PARTITION=y
>  CONFIG_CMDLINE_PARTITION=y
>  CONFIG_BINFMT_MISC=y
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  # CONFIG_COMPACTION is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
> index 3b29ae1fb750..6bd38b6f22c4 100644
> --- a/arch/arm/configs/tct_hammer_defconfig
> +++ b/arch/arm/configs/tct_hammer_defconfig
> @@ -19,7 +19,8 @@ CONFIG_FPE_NWFPE=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_SWAP is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
> index ea59e4b6bfc5..6bd9f71b71fc 100644
> --- a/arch/arm/configs/xcep_defconfig
> +++ b/arch/arm/configs/xcep_defconfig
> @@ -26,7 +26,8 @@ CONFIG_MODULE_UNLOAD=y
>  CONFIG_MODVERSIONS=y
>  CONFIG_MODULE_SRCVERSION_ALL=y
>  # CONFIG_BLOCK is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  # CONFIG_COMPAT_BRK is not set
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  CONFIG_NET=y
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index 6e1e004047c7..0116e465238f 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -10,7 +10,8 @@ CONFIG_EXPERT=y
>  # CONFIG_AIO is not set
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_MODULES=y
>  # CONFIG_BLOCK is not set
>  CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
> diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> index ff49d868e040..b990cb6c9309 100644
> --- a/arch/openrisc/configs/simple_smp_defconfig
> +++ b/arch/openrisc/configs/simple_smp_defconfig
> @@ -16,7 +16,8 @@ CONFIG_EXPERT=y
>  # CONFIG_AIO is not set
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_MODULES=y
>  # CONFIG_BLOCK is not set
>  CONFIG_OPENRISC_BUILTIN_DTB="simple_smp"
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> index 96fe8def644c..79b3ccd58ff0 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -25,7 +25,8 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_EMBEDDED=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_CANAAN=y
>  CONFIG_NONPORTABLE=y
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index 379740654373..6b80bb13b8ed 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -17,7 +17,8 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_EMBEDDED=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_CANAAN=y
>  CONFIG_NONPORTABLE=y
> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
> index 1a56eda5ce46..4cf0f297091e 100644
> --- a/arch/riscv/configs/nommu_virt_defconfig
> +++ b/arch/riscv/configs/nommu_virt_defconfig
> @@ -22,7 +22,8 @@ CONFIG_EXPERT=y
>  # CONFIG_KALLSYMS is not set
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_VIRT=y
>  CONFIG_NONPORTABLE=y

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Though I don't have a K210 to test against, maybe Damien still does?

> diff --git a/arch/sh/configs/rsk7201_defconfig b/arch/sh/configs/rsk7201_defconfig
> index 619c18699459..376e95fa77bc 100644
> --- a/arch/sh/configs/rsk7201_defconfig
> +++ b/arch/sh/configs/rsk7201_defconfig
> @@ -10,7 +10,8 @@ CONFIG_USER_NS=y
>  CONFIG_PID_NS=y
>  CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_AIO is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_PROFILING=y
>  CONFIG_MODULES=y
>  # CONFIG_BLK_DEV_BSG is not set
> diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
> index d00fafc021e1..1d5fd67a3949 100644
> --- a/arch/sh/configs/rsk7203_defconfig
> +++ b/arch/sh/configs/rsk7203_defconfig
> @@ -11,7 +11,8 @@ CONFIG_USER_NS=y
>  CONFIG_PID_NS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_PROFILING=y
>  CONFIG_MODULES=y
>  # CONFIG_BLK_DEV_BSG is not set
> diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
> index 122216123e63..78e0e7be57ee 100644
> --- a/arch/sh/configs/se7206_defconfig
> +++ b/arch/sh/configs/se7206_defconfig
> @@ -21,7 +21,8 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
>  # CONFIG_ELF_CORE is not set
>  # CONFIG_COMPAT_BRK is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_PROFILING=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> diff --git a/arch/sh/configs/shmin_defconfig b/arch/sh/configs/shmin_defconfig
> index c0b6f40d01cc..e078b193a78a 100644
> --- a/arch/sh/configs/shmin_defconfig
> +++ b/arch/sh/configs/shmin_defconfig
> @@ -9,7 +9,8 @@ CONFIG_LOG_BUF_SHIFT=14
>  # CONFIG_FUTEX is not set
>  # CONFIG_EPOLL is not set
>  # CONFIG_SHMEM is not set
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_CPU_SUBTYPE_SH7706=y
>  CONFIG_MEMORY_START=0x0c000000
> diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
> index 32ec6eb1eabc..aa353dff7f19 100644
> --- a/arch/sh/configs/shx3_defconfig
> +++ b/arch/sh/configs/shx3_defconfig
> @@ -20,7 +20,8 @@ CONFIG_USER_NS=y
>  CONFIG_PID_NS=y
>  # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>  CONFIG_KALLSYMS_ALL=y
> -CONFIG_SLOB=y
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
>  CONFIG_PROFILING=y
>  CONFIG_KPROBES=y
>  CONFIG_MODULES=y
> diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
> index 8a44b93da0f3..c2f9c912df1c 100644
> --- a/kernel/configs/tiny.config
> +++ b/kernel/configs/tiny.config
> @@ -7,5 +7,6 @@ CONFIG_KERNEL_XZ=y
>  # CONFIG_KERNEL_LZO is not set
>  # CONFIG_KERNEL_LZ4 is not set
>  # CONFIG_SLAB is not set
> -# CONFIG_SLUB is not set
> -CONFIG_SLOB=y
> +# CONFIG_SLOB_DEPRECATED is not set
> +CONFIG_SLUB=y
> +CONFIG_SLUB_TINY=y
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 5941cb34e30d..dcc49c69552f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -219,17 +219,30 @@ config SLUB
>  	   and has enhanced diagnostics. SLUB is the default choice for
>  	   a slab allocator.
>
> -config SLOB
> +config SLOB_DEPRECATED
>  	depends on EXPERT
> -	bool "SLOB (Simple Allocator)"
> +	bool "SLOB (Simple Allocator - DEPRECATED)"
>  	depends on !PREEMPT_RT
>  	help
> +	   Deprecated and scheduled for removal in a few cycles. SLUB
> +	   recommended as replacement. CONFIG_SLUB_TINY can be considered
> +	   on systems with 16MB or less RAM.
> +
> +	   If you need SLOB to stay, please contact linux-mm@kvack.org and
> +	   people listed in the SLAB ALLOCATOR section of MAINTAINERS file,
> +	   with your use case.
> +
>  	   SLOB replaces the stock allocator with a drastically simpler
>  	   allocator. SLOB is generally more space efficient but
>  	   does not perform as well on large systems.
>
>  endchoice
>
> +config SLOB
> +	bool
> +	default y
> +	depends on SLOB_DEPRECATED
> +
>  config SLUB_TINY
>  	bool "Configure SLUB for minimal memory footprint"
>  	depends on SLUB && EXPERT
