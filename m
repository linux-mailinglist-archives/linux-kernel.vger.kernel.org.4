Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1938370EBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjEXDlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbjEXDll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:41:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23B3CC1;
        Tue, 23 May 2023 20:41:37 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxuPFwh21kxUsAAA--.896S3;
        Wed, 24 May 2023 11:41:36 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTtvh21ki8ZyAA--.60243S3;
        Wed, 24 May 2023 11:41:36 +0800 (CST)
Subject: Re: [PATCH v2 1/3] loongarch: export loongarch pm interface
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522093156.7108-1-zhuyinbo@loongson.cn>
 <20230522093156.7108-2-zhuyinbo@loongson.cn>
 <CAAhV-H5Your97dAMOWjGCMgq5QsGPS21QNPa7OmfOHO6vM8sqw@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <9e1fc32f-2b77-3b55-2ca5-23ac00dff7ff@loongson.cn>
Date:   Wed, 24 May 2023 11:41:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5Your97dAMOWjGCMgq5QsGPS21QNPa7OmfOHO6vM8sqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfTtvh21ki8ZyAA--.60243S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw15ArWxCFyxGFyftw17trb_yoW7GrW3p3
        sFyFs8Ga1rKrn5Zr98tas8XFyUJrs5Kr4I9FsrKa4UCwsrWw1rur18Kr98WF1qkw1rGF40
        vry0ga1a9F1UKa7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8FAp5UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/24 上午9:57, Huacai Chen 写道:
> Hi, Yinbo,
> 
> The title can be regular:
>   LoongArch: Export some arch-specific pm interfaces
> 
> And in commit message,
> "Some Power Management Controllers" should be
> "Some power management controllers" or
> "Some PMC (Power Management Controllers)"


okay, I got it.

Thanks.
> 
> Huacai
> 
> On Mon, May 22, 2023 at 5:32 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>
>> Some Power Management Controllers need to support DTS and will use
>> the suspend interface thus this patch was to export such interface
>> for their use.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/acpi.h    |  5 ++---
>>   arch/loongarch/include/asm/suspend.h | 10 ++++++++++
>>   arch/loongarch/power/suspend.c       | 10 +++++-----
>>   arch/loongarch/power/suspend_asm.S   |  8 ++++----
>>   4 files changed, 21 insertions(+), 12 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/suspend.h
>>
>> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
>> index 976a810352c6..d63507cc705f 100644
>> --- a/arch/loongarch/include/asm/acpi.h
>> +++ b/arch/loongarch/include/asm/acpi.h
>> @@ -8,6 +8,7 @@
>>   #ifndef _ASM_LOONGARCH_ACPI_H
>>   #define _ASM_LOONGARCH_ACPI_H
>>
>> +#include <asm/suspend.h>
>>   #ifdef CONFIG_ACPI
>>   extern int acpi_strict;
>>   extern int acpi_disabled;
>> @@ -37,13 +38,11 @@ extern struct list_head acpi_wakeup_device_list;
>>
>>   extern int loongarch_acpi_suspend(void);
>>   extern int (*acpi_suspend_lowlevel)(void);
>> -extern void loongarch_suspend_enter(void);
>>
>>   static inline unsigned long acpi_get_wakeup_address(void)
>>   {
>>   #ifdef CONFIG_SUSPEND
>> -       extern void loongarch_wakeup_start(void);
>> -       return (unsigned long)loongarch_wakeup_start;
>> +       return (unsigned long)loongson_wakeup_start;
>>   #endif
>>          return 0UL;
>>   }
>> diff --git a/arch/loongarch/include/asm/suspend.h b/arch/loongarch/include/asm/suspend.h
>> new file mode 100644
>> index 000000000000..a40b42f4f7f3
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/suspend.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_SUSPEND_H
>> +#define __ASM_SUSPEND_H
>> +
>> +void loongson_common_resume(void);
>> +void loongson_common_suspend(void);
>> +void loongson_suspend_enter(void);
>> +void loongson_wakeup_start(void);
>> +
>> +#endif
>> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
>> index 5e19733e5e05..0587681b33ce 100644
>> --- a/arch/loongarch/power/suspend.c
>> +++ b/arch/loongarch/power/suspend.c
>> @@ -27,7 +27,7 @@ struct saved_registers {
>>   };
>>   static struct saved_registers saved_regs;
>>
>> -static void arch_common_suspend(void)
>> +void loongson_common_suspend(void)
>>   {
>>          save_counter();
>>          saved_regs.pgd = csr_read64(LOONGARCH_CSR_PGDL);
>> @@ -40,7 +40,7 @@ static void arch_common_suspend(void)
>>          loongarch_suspend_addr = loongson_sysconf.suspend_addr;
>>   }
>>
>> -static void arch_common_resume(void)
>> +void loongson_common_resume(void)
>>   {
>>          sync_counter();
>>          local_flush_tlb_all();
>> @@ -62,12 +62,12 @@ int loongarch_acpi_suspend(void)
>>          enable_gpe_wakeup();
>>          enable_pci_wakeup();
>>
>> -       arch_common_suspend();
>> +       loongson_common_suspend();
>>
>>          /* processor specific suspend */
>> -       loongarch_suspend_enter();
>> +       loongson_suspend_enter();
>>
>> -       arch_common_resume();
>> +       loongson_common_resume();
>>
>>          return 0;
>>   }
>> diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
>> index e2fc3b4e31f0..809abd3b119d 100644
>> --- a/arch/loongarch/power/suspend_asm.S
>> +++ b/arch/loongarch/power/suspend_asm.S
>> @@ -57,13 +57,13 @@
>>          .align 12
>>
>>   /* Sleep/wakeup code for Loongson-3 */
>> -SYM_FUNC_START(loongarch_suspend_enter)
>> +SYM_FUNC_START(loongson_suspend_enter)
>>          SETUP_SLEEP
>>          bl              __flush_cache_all
>>
>>          /* Pass RA and SP to BIOS */
>>          addi.d          a1, sp, 0
>> -       la.pcrel        a0, loongarch_wakeup_start
>> +       la.pcrel        a0, loongson_wakeup_start
>>          la.pcrel        t0, loongarch_suspend_addr
>>          ld.d            t0, t0, 0
>>          jirl            a0, t0, 0 /* Call BIOS's STR sleep routine */
>> @@ -72,7 +72,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
>>           * This is where we return upon wakeup.
>>           * Reload all of the registers and return.
>>           */
>> -SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
>> +SYM_INNER_LABEL(loongson_wakeup_start, SYM_L_GLOBAL)
>>          li.d            t0, CSR_DMW0_INIT       # UC, PLV0
>>          csrwr           t0, LOONGARCH_CSR_DMWIN0
>>          li.d            t0, CSR_DMW1_INIT       # CA, PLV0
>> @@ -89,4 +89,4 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
>>          SETUP_WAKEUP
>>          addi.d          sp, sp, PT_SIZE
>>          jr              ra
>> -SYM_FUNC_END(loongarch_suspend_enter)
>> +SYM_FUNC_END(loongson_suspend_enter)
>> --
>> 2.20.1
>>

