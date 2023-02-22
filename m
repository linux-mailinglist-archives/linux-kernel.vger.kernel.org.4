Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1769F249
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBVJ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjBVJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:55:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 034ABDBEE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:54:42 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8CxEZRh5vVja4oDAA--.1727S3;
        Wed, 22 Feb 2023 17:54:41 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF71g5vVjeqg4AA--.37796S3;
        Wed, 22 Feb 2023 17:54:41 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: kdump: Add the same binary implementation
To:     WANG Xuerui <kernel@xen0n.name>
References: <1677048791-26951-1-git-send-email-tangyouling@loongson.cn>
 <1677048791-26951-2-git-send-email-tangyouling@loongson.cn>
 <6d71e063-8e18-dd08-ac40-36b41ccfcfdb@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <3ec77f64-55b2-5549-52f8-b875392d992e@loongson.cn>
Date:   Wed, 22 Feb 2023 17:54:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <6d71e063-8e18-dd08-ac40-36b41ccfcfdb@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxF71g5vVjeqg4AA--.37796S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuw45Xr4xXw4rZr4rWF1ftFb_yoW7ur48pr
        93AF4kKF4kGr1rK3y8t3s3ury8Jws7GFyagF1Dta4FyrnrZw1xZrnYkrnrWFyjq39Yg3y0
        qF95Wa4ava17A37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bOxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E
        6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWrMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
        6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWl
        kUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui

On 02/22/2023 05:05 PM, WANG Xuerui wrote:
> On 2023/2/22 14:53, Youling Tang wrote:
>> This feature depends on the relocation function, so the relocation
>> configuration
>> CONFIG_RELOCATABLE will be enabled.
>
> In general try to describe things briefly: "This depends on the kernel
> being relocatable" would be enough in this case.
OK.

>
>>
>> Add the same set of binary implementations for kdump, and then no
>> longer need to
>> compile two kernels (the production kernel and the capture kernel
>> share the same
>> binary).
>
> Sorry but what do you mean by "same set of binary implementation",
> where's the "first set of binary implementation"?

kdump requires two kernels, the production kernel and the capture
kernel, which made the final link address different through different
configuration options in the previous implementation. Now it is
possible to share a kernel, and after entering the capture kernel, it
can be corrected by relocation.

>
> Judging from the patch content, I guess it's kinda wrong translation,
> and what you actually mean is something like "enable using the same
> image for crashkernel"?

Or "LoongArch: kdump: Add support for using a single image" ?

>
>>
>> CONFIG_CRASH_DUMP is enabled by default (CONFIG_RELOCATABLE is also
>> enabled).
>
> No it's not: you didn't add "default y" anywhere. What you actually did
> is to enable it *in the defconfig*. And the latter part about
> CONFIG_RELOCATABLE shouldn't be necessary, it's implementation detail
> after all, and the users likely don't have to be aware of it.
>
> Better reword a little bit, like "Also enable CONFIG_CRASH_DUMP in
> loongson3_defconfig".

Thanks, I'll rewrite the commit message.

>
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig                     | 12 +-----------
>>   arch/loongarch/Makefile                    |  4 ----
>>   arch/loongarch/configs/loongson3_defconfig |  1 +
>>   arch/loongarch/include/asm/addrspace.h     |  2 ++
>>   arch/loongarch/kernel/head.S               |  2 +-
>>   5 files changed, 5 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index ab4c2ab146ab..84f220273296 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -502,6 +502,7 @@ config KEXEC
>>     config CRASH_DUMP
>>       bool "Build kdump crash kernel"
>> +    select RELOCATABLE
>>       help
>>         Generate crash dump after being started by kexec. This should
>>         be normally only set in special crash dump kernels which are
>> @@ -511,17 +512,6 @@ config CRASH_DUMP
>>           For more details see Documentation/admin-guide/kdump/kdump.rst
>>   -config PHYSICAL_START
>> -    hex "Physical address where the kernel is loaded"
>> -    default "0x90000000a0000000"
>> -    depends on CRASH_DUMP
>> -    help
>> -      This gives the XKPRANGE address where the kernel is loaded.
>> -      If you plan to use kernel for capturing the crash dump change
>> -      this value to start of the reserved region (the "X" value as
>> -      specified in the "crashkernel=YM@XM" command line boot parameter
>> -      passed to the panic-ed kernel).
>> -
>>   config RELOCATABLE
>>       bool "Relocatable kernel"
>>       help
>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> index 2aba6ff30436..8304fed7aa42 100644
>> --- a/arch/loongarch/Makefile
>> +++ b/arch/loongarch/Makefile
>> @@ -79,11 +79,7 @@ endif
>>   cflags-y += -ffreestanding
>>   cflags-y += $(call cc-option, -mno-check-zero-division)
>>   -ifndef CONFIG_PHYSICAL_START
>>   load-y        = 0x9000000000200000
>> -else
>> -load-y        = $(CONFIG_PHYSICAL_START)
>> -endif
>>   bootvars-y    = VMLINUX_LOAD_ADDRESS=$(load-y)
>
> Both load-y and VMLINUX_LOAD_ADDRESS are kinda LoongArch-ism (stemming
> from similar usage in arch/mips apparently), so why not just drop load-y
> and fold the constant into the bootvars-y definition? So we have one
> piece of "special" definition instead of two.

This series of patches will not modify it, perhaps it can be submitted
and discussed separately later.

Thanks,
Youling.

>
>>     drivers-$(CONFIG_PCI)        += arch/loongarch/pci/
>> diff --git a/arch/loongarch/configs/loongson3_defconfig
>> b/arch/loongarch/configs/loongson3_defconfig
>> index cb52774c80e8..7885f6e5de93 100644
>> --- a/arch/loongarch/configs/loongson3_defconfig
>> +++ b/arch/loongarch/configs/loongson3_defconfig
>> @@ -48,6 +48,7 @@ CONFIG_HOTPLUG_CPU=y
>>   CONFIG_NR_CPUS=64
>>   CONFIG_NUMA=y
>>   CONFIG_KEXEC=y
>> +CONFIG_CRASH_DUMP=y
>>   CONFIG_SUSPEND=y
>>   CONFIG_HIBERNATION=y
>>   CONFIG_ACPI=y
>> diff --git a/arch/loongarch/include/asm/addrspace.h
>> b/arch/loongarch/include/asm/addrspace.h
>> index d342935e5a72..4edcb3c21cf5 100644
>> --- a/arch/loongarch/include/asm/addrspace.h
>> +++ b/arch/loongarch/include/asm/addrspace.h
>> @@ -125,4 +125,6 @@ extern unsigned long vm_map_base;
>>   #define ISA_IOSIZE    SZ_16K
>>   #define IO_SPACE_LIMIT    (PCI_IOSIZE - 1)
>>   +#define PHYS_LINK_ADDR    PHYSADDR(VMLINUX_LOAD_ADDRESS)
>> +
>>   #endif /* _ASM_ADDRSPACE_H */
>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>> index b12f459ad73a..57962ff08f6d 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -24,7 +24,7 @@ _head:
>>       .org    0x8
>>       .dword    kernel_entry        /* Kernel entry point */
>>       .dword    _end - _text        /* Kernel image effective size */
>> -    .quad    0            /* Kernel image load offset from start of
>> RAM */
>> +    .quad    PHYS_LINK_ADDR        /* Kernel image load offset from
>> start of RAM */
>>       .org    0x38            /* 0x20 ~ 0x37 reserved */
>>       .long    LINUX_PE_MAGIC
>>       .long    pe_header - _head    /* Offset to the PE header */
>

