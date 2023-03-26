Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD16C973D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCZRgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjCZRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE187688;
        Sun, 26 Mar 2023 10:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09D4360F0E;
        Sun, 26 Mar 2023 17:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ECFC4339E;
        Sun, 26 Mar 2023 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679852140;
        bh=PZxpnhhZbamFTT/t8UtmIePJbWohJuSJJo9g/CgKKm4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aaLFp9eKj+TikZo2dNBgiqoL+9HrESCrhfi8ylmml7TbWLt0zFtgLzc8C0BekqPIT
         eHgqf//uV4Lv2lWFG7NXrhgG8VahcIzW5e7LcKGykw8b3+jfdjE/iT+OgZC/w++wpc
         dcrE2nXSD+U1zTLaFvbZ7wDmWPEh0STpkSsMwVEyVwnC927ljjsXTzt122cs79iuwB
         jkBj7M5ucP/2eWRm0zXHERilFMY9SOp74PlsNHAVVR7AJfxoT3cnN04IUCU0wYFuUo
         qTLXuGaQ5PtflMkAWrXutCvx2x9tAnPPJ1j0BfGvjNwVtXUql9qCUhYOmL7e4T4Znu
         AW+daCSx42gtw==
Received: by mail-lf1-f54.google.com with SMTP id c29so8388642lfv.3;
        Sun, 26 Mar 2023 10:35:40 -0700 (PDT)
X-Gm-Message-State: AO0yUKXE4KD4Kpr5rLoY/lI01UpDzYHI+ZGvDGWOkmF223VcBAtQLz5a
        Nq7Noy2jiIrZ7DuNBoRGnEgABiz/0EVSaBpFGeg=
X-Google-Smtp-Source: AK7set8MhI54rX7cunUQGOOwyaUTiuc0bIc7VefUVU9R/XrtIF9ENhdhTG7xoNjnoi93YTg8AZ52IU3E6XHxsTXlfLo=
X-Received: by 2002:a05:6512:b8a:b0:4e8:4409:bb76 with SMTP id
 b10-20020a0565120b8a00b004e84409bb76mr8435400lfv.2.1679852138126; Sun, 26 Mar
 2023 10:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230326170756.3021936-1-sdonthineni@nvidia.com>
In-Reply-To: <20230326170756.3021936-1-sdonthineni@nvidia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 26 Mar 2023 19:35:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4MUGbuiW1bcupMs1VdxxE_74WWDt1YdUTg0o9ft+=JQ@mail.gmail.com>
Message-ID: <CAMj1kXF4MUGbuiW1bcupMs1VdxxE_74WWDt1YdUTg0o9ft+=JQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Increase MODULES_VSIZE to 512MB
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2023 at 19:08, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>
> The allocation of modules occurs in two regions: the first region
> MODULES_VSIZE (128MB) is shared with the core kernel, while the
> the second region (2GB) is shared with other vmalloc callers.
> Depending on the size of the core kernel, the 128MB region may
> quickly fill up after loading a few modules, causing the system
> to switch to the 2GB region.

How much module space are you actually using? This 128 MiB region is
not shared with vmalloc() so it should be dedicated to modules
entirely.

If you are doing EFI boot, you may need to following patch to ensure
that the 128 MiB region is actually the one being used.

commit 010338d729c1090036eb40d2a60b7b7bce2445b8
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Thu Feb 23 21:41:01 2023 +0100

    arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN


> Unfortunately, even the 2GB region
> can run out of space if previously loaded modules and the other
> kernel subsystems consume the entire area, leaving no space for
> additional modules.
>
> This issue usually occurs when the system has a large number of
> CPU cores, PCIe host-brigde controllers, and I/O devices. For
> instance, the ECAM region of one host-bridge controller can use
> up to 256MB of vmalloc space, while eight controllers can occupy
> the entire 2GB.
>
> One potential solution to address this issue is to increase the
> size of the MODULES_VSIZE region to 512MB, which would enhance
> the system's ability to support a greater number of dynamically
> loaded modules and drivers.
>
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>
> I am seeking your guidance and feedback on the proposed solution
> to address the module load failures, specifically regarding any
> potential side effects that I need to be aware of. Additionally,
> I would appreciate your suggestions on any alternative solutions
> to resolve the issue.
>
> On a NVIDIA T241 system with Ubuntu-22.04, hitting boot failures
> due to vmalloc/vmap allocation errors when loading modules.
> dmesg:
>  [   64.181308] ipmi_ssif: IPMI SSIF Interface driver
>  [   64.184494] usbcore: registered new interface driver r8152
>  [   64.242492] vmap allocation for size 393216 failed: use vmalloc=<size> to increase size
>  [   64.242499] systemd-udevd: vmalloc error: size 327680, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-3
>  [   64.242510] CPU: 32 PID: 2910 Comm: systemd-udevd Tainted: G           OE      6.2-generic-64k
>  [   64.242513] Hardware name: NVIDIA T241, BIOS v1.1.0 2023-03-18T21:32:31+00:00
>  [   64.242515] Call trace:
>  [   64.242516]  dump_backtrace+0xe0/0x130
>  [   64.242523]  show_stack+0x20/0x60
>  [   64.242525]  dump_stack_lvl+0x68/0x84
>  [   64.242530]  dump_stack+0x18/0x34
>  [   64.242532]  warn_alloc+0x11c/0x1b0
>  [   64.242537]  __vmalloc_node_range+0xe0/0x20c
>  [   64.242540]  module_alloc+0x118/0x160
>  [   64.242543]  move_module+0x2c/0x190
>  [   64.242546]  layout_and_allocate+0xfc/0x160
>  [   64.242548]  load_module+0x260/0xbc4
>  [   64.242549]  __do_sys_finit_module+0xac/0x130
>  [   64.242551]  __arm64_sys_finit_module+0x28/0x34
>  [   64.242552]  invoke_syscall+0x78/0x100
>  [   64.242553]  el0_svc_common.constprop.0+0x170/0x194
>  [   64.242555]  do_el0_svc+0x38/0x4c
>  [   64.242556]  el0_svc+0x2c/0xc0
>  [   64.242558]  el0t_64_sync_handler+0xbc/0x13c
>  [   64.242560]  el0t_64_sync+0x1a0/0x1a4
>
>  Documentation/arm64/memory.rst  | 8 ++++----
>  arch/arm64/include/asm/memory.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> index 2a641ba7be3b..76c2fd8bbbf7 100644
> --- a/Documentation/arm64/memory.rst
> +++ b/Documentation/arm64/memory.rst
> @@ -33,8 +33,8 @@ AArch64 Linux memory layout with 4KB pages + 4 levels (48-bit)::
>    0000000000000000     0000ffffffffffff         256TB          user
>    ffff000000000000     ffff7fffffffffff         128TB          kernel logical memory map
>   [ffff600000000000     ffff7fffffffffff]         32TB          [kasan shadow region]
> -  ffff800000000000     ffff800007ffffff         128MB          modules
> -  ffff800008000000     fffffbffefffffff         124TB          vmalloc
> +  ffff800000000000     ffff80001fffffff         512MB          modules
> +  ffff800020000000     fffffbffefffffff         124TB          vmalloc
>    fffffbfff0000000     fffffbfffdffffff         224MB          fixed mappings (top down)
>    fffffbfffe000000     fffffbfffe7fffff           8MB          [guard region]
>    fffffbfffe800000     fffffbffff7fffff          16MB          PCI I/O space
> @@ -50,8 +50,8 @@ AArch64 Linux memory layout with 64KB pages + 3 levels (52-bit with HW support):
>    0000000000000000     000fffffffffffff           4PB          user
>    fff0000000000000     ffff7fffffffffff          ~4PB          kernel logical memory map
>   [fffd800000000000     ffff7fffffffffff]        512TB          [kasan shadow region]
> -  ffff800000000000     ffff800007ffffff         128MB          modules
> -  ffff800008000000     fffffbffefffffff         124TB          vmalloc
> +  ffff800000000000     ffff80001fffffff         512MB          modules
> +  ffff800020000000     fffffbffefffffff         124TB          vmalloc
>    fffffbfff0000000     fffffbfffdffffff         224MB          fixed mappings (top down)
>    fffffbfffe000000     fffffbfffe7fffff           8MB          [guard region]
>    fffffbfffe800000     fffffbffff7fffff          16MB          PCI I/O space
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 78e5163836a0..dd5d634e235f 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -46,7 +46,7 @@
>  #define KIMAGE_VADDR           (MODULES_END)
>  #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
>  #define MODULES_VADDR          (_PAGE_END(VA_BITS_MIN))
> -#define MODULES_VSIZE          (SZ_128M)
> +#define MODULES_VSIZE          (SZ_512M)
>  #define VMEMMAP_START          (-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
>  #define VMEMMAP_END            (VMEMMAP_START + VMEMMAP_SIZE)
>  #define PCI_IO_END             (VMEMMAP_START - SZ_8M)
> --
> 2.25.1
>
