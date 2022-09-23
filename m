Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DC5E76A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiIWJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiIWJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:16:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 747F612ED94
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:16:32 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWteeS1jbpggAA--.60757S3;
        Fri, 23 Sep 2022 17:16:18 +0800 (CST)
Subject: Re: [PATCH v4 0/3] LoongArch: Add kexec/kdump support
To:     Huacai Chen <chenhuacai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
References: <1663919073-26849-1-git-send-email-tangyouling@loongson.cn>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <711d53ae-197f-3c55-d09d-2f40e6886ad1@loongson.cn>
Date:   Fri, 23 Sep 2022 17:16:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1663919073-26849-1-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxXWteeS1jbpggAA--.60757S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF13uFW3AFWUKr4Duw4kWFg_yoWrCrW3pF
        4kCr1rKr4kGrn3J3Wxtr13uF95Zwn7Ga1ag3ZFy348ZFnFqr1UZrnYqF9rZF1qqw4fGr40
        qFnYgw129a4DGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUyq-eDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/2022 03:44 PM, Youling Tang wrote:
> This patch series to support kexec/kdump (only 64bit).
>
> Kexec is a system call that enables you to load and boot into another kernel
> from the currently running kernel. This is useful for kernel developers or
> other people who need to reboot very quickly without waiting for the whole
> BIOS boot process to finish.
>
> Kdump uses kexec to quickly boot to a dump-capture kernel whenever a
> dump of the system kernel's memory needs to be taken (for example, when
> the system panics). The system kernel's memory image is preserved across
> the reboot and is accessible to the dump-capture kernel.
>
> For details, see Documentation/admin-guide/kdump/kdump.rst.
>
> User tools kexec-tools see link [1].
>
> TODO:
> Currently kdump does not support the same binary image, the production kernel
> and the capture kernel will be generated with different configurations. I will
> support kernel relocation support in the near future. Then will go to implement
> the same binary support based on kernel relocation support.
>
> [1] Link: https://github.com/tangyouling/kexec-tools
>
> Changes in v4:
>  After applying the following series of patches [1], the following
>  modifications need to be made:
>  - Adjust the number of parameters and the content of the parameters passed.
>  - Removed build and processing of fdt.
>  - Add handling of command line segments.
>  - Use the command line argument "elfcorehdr=" instead of the "linux,elfcorehdr"
>    member in fdt.
>  - Use the command line argument "mem=" instead of the "linux, usable-memory-range"
>    member in fdt.
>  - Use the command line argument "initrd=" instead of the "linux,initrd-start" and
>    "linux,initrd-end" members of fdt.

For the command line "initrd=start,size" method:
We need to move the reserve_initrd_mem call after parse_early_param to
make sure we can get the correct start and size.

Youling.

>  - Removed handling of "linux,elfcorehdr" and "linux, usable-memory-range".
>  - Add handling of "elfcorehdr=".
>  - Modify the handling of "mem=".
>  - Add implementation of reserve_oldmem_region.
>  - Reimplemented kexec-tools (note that kexec-tools needs to be updated).
>
>    Link [1]: https://lore.kernel.org/loongarch/20220920183554.3870247-1-ardb@kernel.org/T/#md02ad4a1510586b2df177cbce4422434eff2d457
>    [PATCH v2 0/8] efi: disentangle the generic EFI stub from FDT
>
> Changes in v3:
>  - Adjust the PE header (note that kexec-tools needs to be updated).
>  - Add ibar in kexec_reboot().
>  - boot_flag is replaced by efi_boot.
>  - Adjust do_kexec parameter passing order.
>  - Adjust the order of static variables to be consistent with do_kexec.
>  - Remove a-series register save.
>  - Some comments and register usage modification.
>  - Add the opening and closing of the cpu core state.
>  - Add a call to cpu_device_up to turn it on when the cpu core state is offline.
>
> Changes in v2:
>  - Add ibar.
>  - Access via IOCSR.
>  - Remove the settings of the tp, sp registers.
>  - Remove the crash.c file and merge the relevant code into machine_kexec.c.
>  - Adjust the use of CONFIG_SMP macro to avoid build errors under !SMP
>    configuration.
>  - Change the default value of PHYSICAL_START of the capture kernel to
>    0x90000000a0000000.
>
> Youling Tang (3):
>   LoongArch: Add kexec support
>   LoongArch: Add kdump support
>   LoongArch: Enable CONFIG_KEXEC
>
>  arch/loongarch/Kconfig                     |  33 +++
>  arch/loongarch/Makefile                    |   4 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/kexec.h         |  60 ++++
>  arch/loongarch/kernel/Makefile             |   3 +
>  arch/loongarch/kernel/crash_dump.c         |  19 ++
>  arch/loongarch/kernel/head.S               |   6 +-
>  arch/loongarch/kernel/machine_kexec.c      | 309 +++++++++++++++++++++
>  arch/loongarch/kernel/mem.c                |   1 +
>  arch/loongarch/kernel/relocate_kernel.S    | 112 ++++++++
>  arch/loongarch/kernel/setup.c              | 123 +++++++-
>  arch/loongarch/kernel/traps.c              |   4 +
>  12 files changed, 664 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kexec.h
>  create mode 100644 arch/loongarch/kernel/crash_dump.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec.c
>  create mode 100644 arch/loongarch/kernel/relocate_kernel.S
>

