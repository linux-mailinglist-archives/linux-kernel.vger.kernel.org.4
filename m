Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC315FBCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJKVUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJKVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:20:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4F4DB51
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:20:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so157470pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WgKkXYOMpCrMy4stl7yeasfMAP3tPEChdLdz+nfSz+g=;
        b=e7f0yiOYbezNSkTNIEoVtuBP1LqxZJUf06lQKR+Gg2OETyyzvMPBeG7crV0ApfGoVG
         pxeRq7bFSAc6QZys2PFlgo3JwLP4qFg6wL+rIhkrFlGeWjzBog9GeIZxMWMDn5EGQgwA
         6Aji4jvhyVHM+W6d/wTExejDjWSeUUAMvZBLajYRIxzCEOhkjHP2imp28QiciDAJhZWZ
         D/1iVuXo1n11Yxq+Pc263W48g3DSGVV/hyxKeS77gFU/z8Og+K9sW8sh3yMZGOIrquqn
         5/PsfBb8OYDLn+ULkfQoyedzn/COY/PlsoKD852dTf41bLV0Rvm2r8YDlxt0Rtjny200
         KSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgKkXYOMpCrMy4stl7yeasfMAP3tPEChdLdz+nfSz+g=;
        b=sc3GRzvS76YBEVfJUNQ77Bvn/RiU7e9pJBsOrd8Wl8I7FEB0ljybpWXG3TQdvGSMU6
         Q5mBkhh9dIypT68zgl2826u6bioXwduTTFeXHCiyCi92K21bUoes6Ib84dAKca7/qx5G
         wkfhd0Cd3LRvckF37ddTgoMNMX70XUp5/zwLD+RA4v/1PgmhH6ZdNFMH5mv83dW1adOa
         UI/ewH1TvaaguBbUopfcSGa6gL8tT2Ax33j0wFyFoI8kIL49qSTts5Jc8rm/dMIXw64R
         hvF4uWMjCI+bC2hMOuJMY4QedFdGuxNmn1uQuPfC4pwCUuNb743NqkhfAODEsCXGffkQ
         xvQw==
X-Gm-Message-State: ACrzQf3lbbsvjYdB079jB/38WCLEpJjW4m4S8zDVqkkcSuWMXEkfLhy3
        sACJteoGQLbwA/MPkEXNLWJeA/nglU5RXuCmSfScZA==
X-Google-Smtp-Source: AMsMyM5xX8RO3BVs4HCpiG+YHspj5urAByZdNn8HlAXCzE14gu+lYDGjvRN/JBlys28c8wxmYAcROtb1Il3prA2XiUg=
X-Received: by 2002:a17:90b:33c3:b0:20a:ebc3:6514 with SMTP id
 lk3-20020a17090b33c300b0020aebc36514mr1231094pjb.147.1665523247523; Tue, 11
 Oct 2022 14:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <202210090815.526C76396@keescook> <20221011012904.2330473-1-lizetao1@huawei.com>
 <20221011012904.2330473-3-lizetao1@huawei.com>
In-Reply-To: <20221011012904.2330473-3-lizetao1@huawei.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Oct 2022 14:20:36 -0700
Message-ID: <CAKwvOdmK6Niv3x-K0__5fqJ+N27wiQaB0v7kS-iAAJfBXGk7XA@mail.gmail.com>
Subject: Re: [PATCH -next v4 2/2] x86/boot/compressed: Add "-Wall" flag to Makefile
To:     Li Zetao <lizetao1@huawei.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, masahiroy@kernel.org, michael.roth@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nathan@kernel.org,
        brijesh.singh@amd.com, peterz@infradead.org,
        venu.busireddy@oracle.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 6:32 PM Li Zetao <lizetao1@huawei.com> wrote:
>
> Compressed/Makefile does not have "-Wall" flag, this is the old problem of
> x86 not sharing makefiles. Fix by adding "-Wall" flag to Makefile. But when
> "-Wall" flag added to Makefile, a few extra warnings were found.
>
> 1.
> In file included from arch/x86/boot/compressed/misc.c:15:
>   In file included from arch/x86/boot/compressed/misc.h:24:
>   In file included from ./include/linux/elf.h:6:
>   In file included from ./arch/x86/include/asm/elf.h:8:
>   In file included from ./include/linux/thread_info.h:60:
>   ./arch/x86/include/asm/thread_info.h:175:13: warning: calling
>   "__builtin_frame_address" with a nonzero argument is unsafe
>   [-Wframe-address]
>     oldframe = __builtin_frame_address(1);
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> ./arch/x86/include/asm/thread_info.h:177:11: warning: calling
>   "__builtin_frame_address" with a nonzero argument is unsafe
>   [-Wframe-address]
>     frame = __builtin_frame_address(2);
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This warning is disabled in the main Makefile for this reason so we
> should just be able to disable it, adding "frame-address" flag to
> Makefile.
>
> 2.
> arch/x86/boot/compressed/kaslr.c:627:6: warning: unused variable
>   "i" [-Wunused-variable]
>     int i;
>         ^
>
> This happens when CONFIG_MEMORY_HOTREMOVE or CONFIG_ACPI are "n".
> Fix by adding "-std=gnu11" flag to Makefile, and we should put
> the variable "i" within the for loop.
>
> 3.
> arch/x86/boot/compressed/acpi.c:23:1: warning: unused function
>   "__efi_get_rsdp_addr" [-Wunused-function]
>
> This happens when CONFIG_EFI is disabled for the reason that
> function "__efi_get_rsdp_addr" is only called in efi_get_rsdp_addr
> when CONFIG_EFI enable. So function "__efi_get_rsdp_addr" should
> not be defined when CONFIG_EFI is disabled.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

I gave this a quick spin with clang to ensure that I didn't observe
new warnings produced via -Wall:

$ make LLVM=1 -j128 -s defconfig all
$ make LLVM=1 ARCH=i386 -j128 -s defconfig all

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v1 -> v2: Patch is new
> v2 -> v3: Resolve extra warnings after "-Wall" flag added
> v3 -> v4: Put this patch at the end
>
>  arch/x86/boot/compressed/Makefile | 3 ++-
>  arch/x86/boot/compressed/acpi.c   | 5 +++--
>  arch/x86/boot/compressed/kaslr.c  | 3 +--
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 3a261abb6d15..8918a8306dff 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -35,7 +35,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>  # be valid.
>  KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
>  KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> -KBUILD_CFLAGS += -Wundef
> +KBUILD_CFLAGS += -Wundef -Wall -std=gnu11
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> @@ -44,6 +44,7 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
>  KBUILD_CFLAGS += -ffreestanding -fshort-wchar
>  KBUILD_CFLAGS += -fno-stack-protector
>  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> +KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 21febd9f21ab..c062a8230e9c 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -19,10 +19,10 @@
>   */
>  struct mem_vector immovable_mem[MAX_NUMNODES*2];
>
> +#ifdef CONFIG_EFI
>  static acpi_physical_address
>  __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
>  {
> -#ifdef CONFIG_EFI
>         unsigned long rsdp_addr;
>
>         /*
> @@ -41,9 +41,10 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
>                 return (acpi_physical_address)rsdp_addr;
>
>         debug_putstr("Error getting RSDP address.\n");
> -#endif
> +
>         return 0;
>  }
> +#endif
>
>  static acpi_physical_address efi_get_rsdp_addr(void)
>  {
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index e476bcbd9b42..4abc9c42cf4d 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -625,7 +625,6 @@ static bool process_mem_region(struct mem_vector *region,
>                                unsigned long minimum,
>                                unsigned long image_size)
>  {
> -       int i;
>         /*
>          * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>          * use @region directly.
> @@ -645,7 +644,7 @@ static bool process_mem_region(struct mem_vector *region,
>          * If immovable memory found, filter the intersection between
>          * immovable memory and @region.
>          */
> -       for (i = 0; i < num_immovable_mem; i++) {
> +       for (int i = 0; i < num_immovable_mem; i++) {
>                 u64 start, end, entry_end, region_end;
>                 struct mem_vector entry;
>
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
