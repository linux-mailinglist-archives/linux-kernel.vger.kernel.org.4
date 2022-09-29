Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E385EEB86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiI2CQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiI2CQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:16:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AAE870B7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:16:14 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdH0X5YnYzHtgJ;
        Thu, 29 Sep 2022 10:11:24 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 10:16:12 +0800
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 10:16:12 +0800
Message-ID: <2d57b0a4-e1ad-fbae-8c28-5db2299ea84e@huawei.com>
Date:   Thu, 29 Sep 2022 10:16:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v2 0/2] Remove unused variables in x86/boot
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <kirill.shutemov@linux.intel.com>, <akpm@linux-foundation.org>,
        <ndesaulniers@google.com>, <masahiroy@kernel.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <michael.roth@amd.com>, <brijesh.singh@amd.com>,
        <venu.busireddy@oracle.com>, <linux-kernel@vger.kernel.org>
References: <20220927081512.2456624-1-lizetao1@huawei.com>
 <YzNwG3iWz+qfNCC9@dev-arch.thelio-3990X>
From:   Li Zetao <lizetao1@huawei.com>
In-Reply-To: <YzNwG3iWz+qfNCC9@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.176]
X-ClientProxiedBy: dggpeml100001.china.huawei.com (7.185.36.47) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 2022/9/28 5:50, Nathan Chancellor wrote:
> Hi Li,
>
> On Tue, Sep 27, 2022 at 08:15:10AM +0000, Li Zetao wrote:
>> This patch set removes some unused variables in x86/boot, and add the
>> "-Wall" flag to Makefile, which is the old problem of x86 not sharing
>> makefiles.
>>
>> Changes since v1:
>> - Add "-Wall" flag to x86/boot/compressed/Makefile
>> - Remove unused variables "et" in efi_get_system_table() and "ret" in
>>    efi_get_conf_table()
>> - Remove unused variables "ret" in __efi_get_rsdp_addr() and
>>    "nr_tables" in efi_get_rsdp_addr()
>>
>> v1 at:
>> https://lore.kernel.org/all/20220923113209.3046960-1-lizetao1@huawei.com/
>>
>> Li Zetao (2):
>>    x86/boot/compressed: Add "-Wall" flag to Makefile
>>    x86/boot: Remove unused variables
>>
>>   arch/x86/boot/compressed/Makefile | 2 +-
>>   arch/x86/boot/compressed/acpi.c   | 2 --
>>   arch/x86/boot/compressed/efi.c    | 2 --
>>   arch/x86/boot/compressed/sev.c    | 1 -
>>   4 files changed, 1 insertion(+), 6 deletions(-)
> I took this series for a spin with clang and found a few extra warnings.
>
> 1.
>
>    In file included from arch/x86/boot/compressed/misc.c:15:
>    In file included from arch/x86/boot/compressed/misc.h:24:
>    In file included from ./include/linux/elf.h:6:
>    In file included from ./arch/x86/include/asm/elf.h:8:
>    In file included from ./include/linux/thread_info.h:60:
>    ./arch/x86/include/asm/thread_info.h:175:13: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
>            oldframe = __builtin_frame_address(1);
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    ./arch/x86/include/asm/thread_info.h:177:11: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
>                    frame = __builtin_frame_address(2);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This warning is disabled in the main Makefile for this reason so we
> should just be able to disable it:
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 10abb7c45d04..3f004567f3d5 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -43,6 +43,7 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
>   KBUILD_CFLAGS += -ffreestanding -fshort-wchar
>   KBUILD_CFLAGS += -fno-stack-protector
>   KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> +KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
>   KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>   KBUILD_CFLAGS += -Wno-pointer-sign
>   KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>
> 2.
>
>    arch/x86/boot/compressed/kaslr.c:627:6: warning: unused variable 'i' [-Wunused-variable]
>            int i;
>                ^
>
> This happens when CONFIG_MEMORY_HOTREMOVE or CONFIG_ACPI are 'n'. I
> think it can just be fixed by aligning arch/x86/boot/compressed with the
> rest of the kernel and explicitly compiling with '-std=gnu11', which
> will allow us to declare the variable within the for loop, like so.
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 3f004567f3d5..6c7e366a437b 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -34,7 +34,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>   # be valid.
>   KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
>   KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> -KBUILD_CFLAGS += -Wundef -Wall
> +KBUILD_CFLAGS += -Wundef -Wall -std=gnu11
>   KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>   cflags-$(CONFIG_X86_32) := -march=i386
>   cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 4a3f223973f4..be859c7e7f6b 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -624,7 +624,6 @@ static bool process_mem_region(struct mem_vector *region,
>   			       unsigned long minimum,
>   			       unsigned long image_size)
>   {
> -	int i;
>   	/*
>   	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>   	 * use @region directly.
> @@ -644,7 +643,7 @@ static bool process_mem_region(struct mem_vector *region,
>   	 * If immovable memory found, filter the intersection between
>   	 * immovable memory and @region.
>   	 */
> -	for (i = 0; i < num_immovable_mem; i++) {
> +	for (int i = 0; i < num_immovable_mem; i++) {
>   		u64 start, end, entry_end, region_end;
>   		struct mem_vector entry;
>   
>
> Additionally, I think these two patches should be reordered so that the
> warnings are fixed before they are enabled.
>
> With those comments addressed, consider the series:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> Cheers,
> Nathan

What is your clang compiler version and .config? My clang compiler is 
14.0.0-1ubuntu1, and I can't reproduce

problem 1("calling '__builtin_frame_address' with a nonzero argument is 
unsafe"). Can you provide more

information.


Thx.


Best regards,

Li Zetao

