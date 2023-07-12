Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B607509D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjGLNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGLNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:43:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2788E77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:43:52 -0700 (PDT)
Received: from loongson.cn (unknown [36.161.91.4])
        by gateway (Coremail) with SMTP id _____8Cx7+sXrq5ktgQEAA--.10398S3;
        Wed, 12 Jul 2023 21:43:51 +0800 (CST)
Received: from [198.18.0.1] (unknown [36.161.91.4])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8wVrq5kd4wqAA--.14283S3;
        Wed, 12 Jul 2023 21:43:50 +0800 (CST)
Message-ID: <62fc4f20-1567-8c2d-fcac-b8339e89da9f@loongson.cn>
Date:   Wed, 12 Jul 2023 21:43:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] LoongArch: Add LBT extensions support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Oleg Nesterov <oleg@redhat.com>,
        Jun Yi <yijun@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xiaotian Wu <wuxiaotian@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230710124048.153562-1-huqi@loongson.cn>
 <CAAhV-H6frcriLqNeCEOU4Ez5AEqMtQJajytQ4Fzjx9bz-X9YYw@mail.gmail.com>
Content-Language: en-US
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <CAAhV-H6frcriLqNeCEOU4Ez5AEqMtQJajytQ4Fzjx9bz-X9YYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF8wVrq5kd4wqAA--.14283S3
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAKCWSuKC0HwAABsL
X-Coremail-Antispam: 1Uk129KBj9fXoWfXF18tr1kXw4fWFWxAF1xCrX_yoW5KFWfWo
        W3tF1xKr4xGr47KFnxt3srXa4av34Y9w47Aay3Aanxur17tayj9F4UKw13tFW3tF97GFWU
        Ca43X347Zayxtwn3l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UR
        a0PUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/10 21:00, Huacai Chen wrote:
> Hi,
>
> On Mon, Jul 10, 2023 at 8:41 PM Qi Hu <huqi@loongson.cn> wrote:
>> Loongson Binary Translation (LBT) is used to accelerate binary translation,
>> which contains 4 scratch registers (scr0 to scr3), x86/ARM eflags (eflags)
>> and x87 fpu stack pointer (ftop).
>>
>> This patch support kernel to save/restore these registers, handle the LBT
>> exception and maintain sigcontext.
>>
>> Signed-off-by: Qi Hu <huqi@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig                       |  13 ++
>>   arch/loongarch/include/asm/asm-prototypes.h  |   1 +
>>   arch/loongarch/include/asm/asmmacro.h        |  85 +++++++-
>>   arch/loongarch/include/asm/lbt.h             | 115 +++++++++++
>>   arch/loongarch/include/asm/loongarch.h       |   4 +
>>   arch/loongarch/include/asm/processor.h       |   6 +-
>>   arch/loongarch/include/asm/switch_to.h       |   2 +
>>   arch/loongarch/include/asm/thread_info.h     |   4 +
>>   arch/loongarch/include/uapi/asm/ptrace.h     |   6 +
>>   arch/loongarch/include/uapi/asm/sigcontext.h |  10 +
>>   arch/loongarch/kernel/Makefile               |   2 +
>>   arch/loongarch/kernel/asm-offsets.c          |   1 +
>>   arch/loongarch/kernel/cpu-probe.c            |  14 ++
>>   arch/loongarch/kernel/fpu.S                  |   9 +-
>>   arch/loongarch/kernel/lbt.S                  | 166 ++++++++++++++++
>>   arch/loongarch/kernel/process.c              |   5 +
>>   arch/loongarch/kernel/ptrace.c               |  54 ++++++
>>   arch/loongarch/kernel/signal.c               | 193 +++++++++++++++++++
>>   arch/loongarch/kernel/traps.c                |  44 ++++-
>>   19 files changed, 722 insertions(+), 12 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/lbt.h
>>   create mode 100644 arch/loongarch/kernel/lbt.S
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 6ae21f4f7dd3..fa7b8a68e69b 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -255,6 +255,9 @@ config AS_HAS_LSX_EXTENSION
>>   config AS_HAS_LASX_EXTENSION
>>          def_bool $(as-instr,xvld \$xr0$(comma)\$a0$(comma)0)
>>
>> +config AS_HAS_LBT_EXTENSION
>> +       def_bool $(as-instr,movscr2gr \$a0$(comma)\$scr0)
>> +
>>   menu "Kernel type and options"
>>
>>   source "kernel/Kconfig.hz"
>> @@ -535,6 +538,16 @@ config CPU_HAS_LASX
>>
>>            If unsure, say Y.
>>
>> +config CPU_HAS_LBT
>> +       bool "Support for Loongson Binary Translation"
>> +       depends on AS_HAS_LBT_EXTENSION
>> +       help
>> +         Loongson Binary Translation (LBT) introduces 4 sketch registers (SCR0 to SCR3),
> Change 'sketch' to 'scratch'?
>
>> +         x86/ARM eflags (eflags) and x87 fpu stack pointer (ftop).
>> +         When this option is enabled, the kernel will support allocation and switching
>> +         LBT related registers.
>> +         If you want to use this feature or Loongson Architecture Translator (LAT), say Y.
> Add a blank line and change 'or' to 'such as'?
>
>> +
>>   config CPU_HAS_PREFETCH
>>          bool
>>          default y
>> diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/include/asm/asm-prototypes.h
>> index ed06d3997420..cf8e1a4e7c19 100644
>> --- a/arch/loongarch/include/asm/asm-prototypes.h
>> +++ b/arch/loongarch/include/asm/asm-prototypes.h
>> @@ -1,6 +1,7 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   #include <linux/uaccess.h>
>>   #include <asm/fpu.h>
>> +#include <asm/lbt.h>
>>   #include <asm/mmu_context.h>
>>   #include <asm/page.h>
>>   #include <asm/ftrace.h>
>> diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
>> index 79e1d53fea89..203491c0d0fc 100644
>> --- a/arch/loongarch/include/asm/asmmacro.h
>> +++ b/arch/loongarch/include/asm/asmmacro.h
>> @@ -148,12 +148,53 @@
>>
>>          .macro fpu_save_csr thread tmp
>>          movfcsr2gr      \tmp, fcsr0
>> -       stptr.w \tmp, \thread, THREAD_FCSR
>> +       stptr.w         \tmp, \thread, THREAD_FCSR
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +       andi            \tmp, \tmp, FPU_CSR_TM
>> +       beqz            \tmp, 1f
>> +       /* save ftop */
>> +       x86mftop        \tmp
>> +       st.b            \tmp, \thread, THREAD_FTOP
> Maybe st.w?

Since the FTOP is only 3 bits (0 - 7), using "st.b" and "ld.b" is 
sufficient.

But the type of FTOP in "loongarch_fpu" is uint32_t, so using 'st.w' and 
'ld.w' is better. I will change them latter.

>> +       /* Since LSX/LASX is not controlled by TM, we need
>> +        * to turn off TM before each context switch to ensure
>> +        * that the order of FPR in memory is independent of TM.
>> +        */
>> +       x86clrtm
>> +       1 :
>> +#endif
>>          .endm
>>
>> -       .macro fpu_restore_csr thread tmp
>> -       ldptr.w \tmp, \thread, THREAD_FCSR
>> -       movgr2fcsr      fcsr0, \tmp
>> +       .macro fpu_restore_csr thread tmp0 tmp1
>> +       ldptr.w         \tmp0, \thread, THREAD_FCSR
>> +       movgr2fcsr      fcsr0, \tmp0
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +       /* TM bit is always 0 if LBT not supported */
>> +       andi            \tmp0, \tmp0, FPU_CSR_TM
>> +       beqz            \tmp0, 1f
>> +       /* restore ftop */
>> +       ld.b            \tmp0, \thread, THREAD_FTOP
> Maybe ld.w?
~
>> +       andi            \tmp0, \tmp0, 0x7
>> +       la.pcrel        \tmp1, 2f
>> +       alsl.d          \tmp1, \tmp0, \tmp1, 3
>> +       jr                      \tmp1
>> +       2 :
>> +       x86mttop        0
>> +       b       1f
>> +       x86mttop        1
>> +       b       1f
>> +       x86mttop        2
>> +       b       1f
>> +       x86mttop        3
>> +       b       1f
>> +       x86mttop        4
>> +       b       1f
>> +       x86mttop        5
>> +       b       1f
>> +       x86mttop        6
>> +       b       1f
>> +       x86mttop        7
>> +       1 :
>> +#endif
>>          .endm
>>
>>          .macro fpu_save_cc thread tmp0 tmp1
>> @@ -353,7 +394,7 @@
>>          .macro  lsx_restore_all thread tmp0 tmp1
>>          lsx_restore_data        \thread, \tmp0
>>          fpu_restore_cc          \thread, \tmp0, \tmp1
>> -       fpu_restore_csr         \thread, \tmp0
>> +       fpu_restore_csr         \thread, \tmp0, \tmp1
>>          .endm
>>
>>          .macro  lsx_save_upper vd base tmp off
>> @@ -563,7 +604,7 @@
>>          .macro  lasx_restore_all thread tmp0 tmp1
>>          lasx_restore_data       \thread, \tmp0
>>          fpu_restore_cc          \thread, \tmp0, \tmp1
>> -       fpu_restore_csr         \thread, \tmp0
>> +       fpu_restore_csr         \thread, \tmp0, \tmp1
>>          .endm
>>
>>          .macro  lasx_save_upper xd base tmp off
>> @@ -663,6 +704,38 @@
>>          lasx_init_upper $xr31 \tmp
>>          .endm
>>
>> +       .macro  lbt_save_scr thread tmp
>> +       movscr2gr       \tmp, $scr0
>> +       stptr.d \tmp, \thread, THREAD_SCR0
>> +       movscr2gr       \tmp, $scr1
>> +       stptr.d \tmp, \thread, THREAD_SCR1
>> +       movscr2gr       \tmp, $scr2
>> +       stptr.d \tmp, \thread, THREAD_SCR2
>> +       movscr2gr       \tmp, $scr3
>> +       stptr.d \tmp, \thread, THREAD_SCR3
>> +       .endm
>> +
>> +       .macro  lbt_restore_scr thread tmp
>> +       ldptr.d \tmp, \thread, THREAD_SCR0
>> +       movgr2scr       $scr0, \tmp
>> +       ldptr.d \tmp, \thread, THREAD_SCR1
>> +       movgr2scr       $scr1, \tmp
>> +       ldptr.d \tmp, \thread, THREAD_SCR2
>> +       movgr2scr       $scr2, \tmp
>> +       ldptr.d \tmp, \thread, THREAD_SCR3
>> +       movgr2scr       $scr3, \tmp
>> +       .endm
>> +
>> +       .macro  lbt_save_eflag thread tmp
>> +       x86mfflag       \tmp, 0x3f
>> +       stptr.d \tmp, \thread, THREAD_EFLAGS
>> +       .endm
>> +
>> +       .macro  lbt_restore_eflag thread tmp
>> +       ldptr.d \tmp, \thread, THREAD_EFLAGS
>> +       x86mtflag       \tmp, 0x3f
>> +       .endm
>> +
>>   .macro not dst src
>>          nor     \dst, \src, zero
>>   .endm
>> diff --git a/arch/loongarch/include/asm/lbt.h b/arch/loongarch/include/asm/lbt.h
>> new file mode 100644
>> index 000000000000..ef1242d10356
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/lbt.h
>> @@ -0,0 +1,115 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Author: Qi Hu <huqi@loongson.cn>
>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>> + */
>> +#ifndef _ASM_LBT_H
>> +#define _ASM_LBT_H
>> +
>> +#include <linux/sched.h>
>> +#include <linux/sched/task_stack.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/thread_info.h>
>> +#include <linux/bitops.h>
>> +
>> +#include <asm/cpu.h>
>> +#include <asm/cpu-features.h>
>> +#include <asm/current.h>
>> +#include <asm/loongarch.h>
>> +#include <asm/processor.h>
>> +#include <asm/ptrace.h>
>> +
>> +extern void _save_lbt(struct task_struct *);
>> +extern void _restore_lbt(struct task_struct *);
>> +
>> +static inline int is_lbt_enabled(void)
>> +{
>> +       if (!cpu_has_lbt)
>> +               return 0;
>> +       return (csr_read32(LOONGARCH_CSR_EUEN) & CSR_EUEN_LBTEN) != 0;
>> +}
>> +
>> +static inline int is_lbt_owner(void)
>> +{
>> +       return test_thread_flag(TIF_USEDLBT);
>> +}
>> +
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +
>> +static inline void enable_lbt(void)
>> +{
>> +       if (cpu_has_lbt)
>> +               csr_xchg32(CSR_EUEN_LBTEN, CSR_EUEN_LBTEN, LOONGARCH_CSR_EUEN);
>> +}
>> +
>> +static inline void disable_lbt(void)
>> +{
>> +       if (cpu_has_lbt)
>> +               csr_xchg32(0, CSR_EUEN_LBTEN, LOONGARCH_CSR_EUEN);
>> +}
>> +
>> +
>> +static inline void __own_lbt(void)
>> +{
>> +       enable_lbt();
>> +       set_thread_flag(TIF_USEDLBT);
>> +       KSTK_EUEN(current) |= CSR_EUEN_LBTEN;
>> +}
>> +
>> +static inline void own_lbt_inatomic(int restore)
>> +{
>> +       if (cpu_has_lbt && !is_lbt_owner()) {
>> +               __own_lbt();
>> +               if (restore)
>> +                       _restore_lbt(current);
>> +       }
>> +}
>> +
>> +static inline void own_lbt(int restore)
>> +{
>> +       preempt_disable();
>> +       own_lbt_inatomic(restore);
>> +       preempt_enable();
>> +}
>> +
>> +static inline void lose_lbt_inatomic(int save, struct task_struct *tsk)
>> +{
>> +       if (cpu_has_lbt && is_lbt_owner()) {
>> +               if (save)
>> +                       _save_lbt(tsk);
>> +
>> +               disable_lbt();
>> +               clear_tsk_thread_flag(tsk, TIF_USEDLBT);
>> +       }
>> +       KSTK_EUEN(tsk) &= ~(CSR_EUEN_LBTEN);
>> +}
>> +
>> +static inline void lose_lbt(int save)
>> +{
>> +       preempt_disable();
>> +       lose_lbt_inatomic(save, current);
>> +       preempt_enable();
>> +}
>> +
>> +static inline void init_lbt(void)
>> +{
>> +       __own_lbt();
>> +       set_thread_flag(TIF_LBT_CTX_LIVE);
>> +}
>> +#else
>> +static inline void enable_lbt(void) {}
>> +static inline void disable_lbt(void) {}
>> +static inline void own_lbt_inatomic(int restore) {}
>> +static inline void lose_lbt_inatomic(int save, struct task_struct *tsk) {}
>> +static inline void own_lbt(int restore) {}
>> +static inline void lose_lbt(int save) {}
>> +#endif
>> +
>> +static inline int thread_lbt_context_live(void)
>> +{
>> +       if (!cpu_has_lbt)
>> +               return 0;
>> +       return test_thread_flag(TIF_LBT_CTX_LIVE);
>> +}
>> +
>> +#endif /* _ASM_LBT_H */
>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
>> index 10748a20a2ab..d1324e8accfe 100644
>> --- a/arch/loongarch/include/asm/loongarch.h
>> +++ b/arch/loongarch/include/asm/loongarch.h
>> @@ -1453,6 +1453,10 @@ __BUILD_CSR_OP(tlbidx)
>>   #define FPU_CSR_RU     0x200   /* towards +Infinity */
>>   #define FPU_CSR_RD     0x300   /* towards -Infinity */
>>
>> +/* Bit 6 of FPU Status Register specify the LBT TOP simulation mode */
>> +#define FPU_CSR_TM_SHIFT       0x6
>> +#define FPU_CSR_TM             (_ULCAST_(1) << FPU_CSR_TM_SHIFT)
>> +
>>   #define read_fcsr(source)      \
>>   ({     \
>>          unsigned int __res;     \
>> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
>> index 636e1c66398c..1c8e2aab3538 100644
>> --- a/arch/loongarch/include/asm/processor.h
>> +++ b/arch/loongarch/include/asm/processor.h
>> @@ -80,8 +80,9 @@ BUILD_FPR_ACCESS(32)
>>   BUILD_FPR_ACCESS(64)
>>
>>   struct loongarch_fpu {
>> -       unsigned int    fcsr;
>>          uint64_t        fcc;    /* 8x8 */
>> +       uint32_t        fcsr;
>> +       uint32_t        ftop;
>>          union fpureg    fpr[NUM_FPU_REGS];
>>   };
>>
>> @@ -174,8 +175,9 @@ struct thread_struct {
>>           * FPU & vector registers                               \
>>           */                                                     \
>>          .fpu                    = {                             \
>> -               .fcsr           = 0,                            \
>>                  .fcc            = 0,                            \
>> +               .fcsr           = 0,                            \
>> +               .ftop           = 0,                            \
>>                  .fpr            = {{{0,},},},                   \
>>          },                                                      \
>>          .hbp_break              = {0},                          \
>> diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
>> index 24e3094bebab..5b225aff3ba2 100644
>> --- a/arch/loongarch/include/asm/switch_to.h
>> +++ b/arch/loongarch/include/asm/switch_to.h
>> @@ -7,6 +7,7 @@
>>
>>   #include <asm/cpu-features.h>
>>   #include <asm/fpu.h>
>> +#include <asm/lbt.h>
>>
>>   struct task_struct;
>>
>> @@ -34,6 +35,7 @@ extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
>>   #define switch_to(prev, next, last)                                            \
>>   do {                                                                           \
>>          lose_fpu_inatomic(1, prev);                                             \
>> +       lose_lbt_inatomic(1, prev);                                             \
>>          hw_breakpoint_thread_switch(next);                                      \
>>          (last) = __switch_to(prev, next, task_thread_info(next),                \
>>                   __builtin_return_address(0), __builtin_frame_address(0));      \
>> diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
>> index 1a3354ca056e..8cb653d49a54 100644
>> --- a/arch/loongarch/include/asm/thread_info.h
>> +++ b/arch/loongarch/include/asm/thread_info.h
>> @@ -84,6 +84,8 @@ register unsigned long current_stack_pointer __asm__("$sp");
>>   #define TIF_SINGLESTEP         16      /* Single Step */
>>   #define TIF_LSX_CTX_LIVE       17      /* LSX context must be preserved */
>>   #define TIF_LASX_CTX_LIVE      18      /* LASX context must be preserved */
>> +#define TIF_USEDLBT            19      /* LBT was used by this task this quantum (SMP) */
>> +#define TIF_LBT_CTX_LIVE       20      /* LBT context must be preserved */
>>
>>   #define _TIF_SIGPENDING                (1<<TIF_SIGPENDING)
>>   #define _TIF_NEED_RESCHED      (1<<TIF_NEED_RESCHED)
>> @@ -101,6 +103,8 @@ register unsigned long current_stack_pointer __asm__("$sp");
>>   #define _TIF_SINGLESTEP                (1<<TIF_SINGLESTEP)
>>   #define _TIF_LSX_CTX_LIVE      (1<<TIF_LSX_CTX_LIVE)
>>   #define _TIF_LASX_CTX_LIVE     (1<<TIF_LASX_CTX_LIVE)
>> +#define _TIF_USEDLBT           (1<<TIF_USEDLBT)
>> +#define _TIF_LBT_CTX_LIVE      (1<<TIF_LBT_CTX_LIVE)
>>
>>   #endif /* __KERNEL__ */
>>   #endif /* _ASM_THREAD_INFO_H */
>> diff --git a/arch/loongarch/include/uapi/asm/ptrace.h b/arch/loongarch/include/uapi/asm/ptrace.h
>> index 06e3be52cb04..ac915f841650 100644
>> --- a/arch/loongarch/include/uapi/asm/ptrace.h
>> +++ b/arch/loongarch/include/uapi/asm/ptrace.h
>> @@ -56,6 +56,12 @@ struct user_lasx_state {
>>          uint64_t vregs[32*4];
>>   };
>>
>> +struct user_lbt_state {
>> +       uint64_t scr[4];
>> +       uint32_t eflags;
>> +       uint32_t ftop;
>> +};
>> +
>>   struct user_watch_state {
>>          uint64_t dbg_info;
>>          struct {
>> diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
>> index 4cd7d16f7037..6c22f616b8f1 100644
>> --- a/arch/loongarch/include/uapi/asm/sigcontext.h
>> +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
>> @@ -59,4 +59,14 @@ struct lasx_context {
>>          __u32   fcsr;
>>   };
>>
>> +/* LBT context */
>> +#define LBT_CTX_MAGIC          0x42540001
>> +#define LBT_CTX_ALIGN          8
>> +struct lbt_context {
>> +       __u64   regs[4];
>> +       __u32   eflags;
>> +       __u32   ftop;
>> +};
>> +
>> +
>>   #endif /* _UAPI_ASM_SIGCONTEXT_H */
>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>> index 9048ab4e5d40..6601b6d00738 100644
>> --- a/arch/loongarch/kernel/Makefile
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -15,6 +15,8 @@ obj-$(CONFIG_EFI)             += efi.o
>>
>>   obj-$(CONFIG_CPU_HAS_FPU)      += fpu.o kfpu.o
>>
>> +obj-$(CONFIG_CPU_HAS_LBT)      += lbt.o
>> +
>>   obj-$(CONFIG_ARCH_STRICT_ALIGN)        += unaligned.o
>>
>>   ifdef CONFIG_FUNCTION_TRACER
>> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
>> index 505e4bf59603..2f79ba93e895 100644
>> --- a/arch/loongarch/kernel/asm-offsets.c
>> +++ b/arch/loongarch/kernel/asm-offsets.c
>> @@ -172,6 +172,7 @@ void output_thread_fpu_defines(void)
>>
>>          OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
>>          OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
>> +       OFFSET(THREAD_FTOP, loongarch_fpu, ftop);
>>          BLANK();
>>   }
>>
>> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
>> index e925579c7a71..55320813ee08 100644
>> --- a/arch/loongarch/kernel/cpu-probe.c
>> +++ b/arch/loongarch/kernel/cpu-probe.c
>> @@ -144,6 +144,20 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>                  c->options |= LOONGARCH_CPU_LVZ;
>>                  elf_hwcap |= HWCAP_LOONGARCH_LVZ;
>>          }
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +       if (config & CPUCFG2_X86BT) {
>> +               c->options |= LOONGARCH_CPU_LBT_X86;
>> +               elf_hwcap |= HWCAP_LOONGARCH_LBT_X86;
>> +       }
>> +       if (config & CPUCFG2_ARMBT) {
>> +               c->options |= LOONGARCH_CPU_LBT_ARM;
>> +               elf_hwcap |= HWCAP_LOONGARCH_LBT_ARM;
>> +       }
>> +       if (config & CPUCFG2_MIPSBT) {
>> +               c->options |= LOONGARCH_CPU_LBT_MIPS;
>> +               elf_hwcap |= HWCAP_LOONGARCH_LBT_MIPS;
>> +       }
>> +#endif
>>
>>          config = read_cpucfg(LOONGARCH_CPUCFG6);
>>          if (config & CPUCFG6_PMP)
>> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
>> index f3df5f0a4509..9526b15f1c83 100644
>> --- a/arch/loongarch/kernel/fpu.S
>> +++ b/arch/loongarch/kernel/fpu.S
>> @@ -138,6 +138,13 @@
>>          .macro sc_save_fcsr base, tmp0
>>          movfcsr2gr      \tmp0, fcsr0
>>          EX      st.w    \tmp0, \base, 0
>> +#if defined(CONFIG_CPU_HAS_LBT)
>> +       /* TM bit is always 0 if LBT not supported */
>> +       andi            \tmp0, \tmp0, FPU_CSR_TM
>> +       beqz            \tmp0, 1f
>> +       x86clrtm
>> +       1:
>> +#endif
>>          .endm
>>
>>          .macro sc_restore_fcsr base, tmp0
>> @@ -309,7 +316,7 @@ EXPORT_SYMBOL(_save_fp)
>>    */
>>   SYM_FUNC_START(_restore_fp)
>>          fpu_restore_double      a0 t1           # clobbers t1
>> -       fpu_restore_csr         a0 t1
>> +       fpu_restore_csr         a0 t1 t2
>>          fpu_restore_cc          a0 t1 t2        # clobbers t1, t2
>>          jr                      ra
>>   SYM_FUNC_END(_restore_fp)
>> diff --git a/arch/loongarch/kernel/lbt.S b/arch/loongarch/kernel/lbt.S
>> new file mode 100644
>> index 000000000000..40cfeec2018c
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/lbt.S
>> @@ -0,0 +1,166 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Author: Lu Zeng <zenglu@loongson.cn>
>> + *         Pei Huang <huangpei@loongson.cn>
>> + *         Huacai Chen <chenhuacai@loongson.cn>
>> + *
>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>> + */
>> +#include <asm/asm.h>
>> +#include <asm/asmmacro.h>
>> +#include <asm/asm-extable.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/errno.h>
>> +#include <asm/export.h>
>> +#include <asm/fpregdef.h>
>> +#include <asm/loongarch.h>
>> +#include <asm/regdef.h>
>> +
>> +#if defined(CONFIG_CPU_HAS_LBT)
> Why need this? This file is compiled only when CONFIG_CPU_HAS_LBT is set.
>> +
>> +#define SCR_REG_WIDTH 8
>> +
>> +       .macro  EX insn, reg, src, offs
>> +.ex\@: \insn   \reg, \src, \offs
>> +       _asm_extable .ex\@, lbt_fault
>> +       .endm
>> +
>> +       .macro  sc_save_scr base, tmp0
>> +       movscr2gr       \tmp0, $scr0
>> +       EX      st.d    \tmp0, \base, (0 * SCR_REG_WIDTH)
>> +       movscr2gr       \tmp0, $scr1
>> +       EX      st.d    \tmp0, \base, (1 * SCR_REG_WIDTH)
>> +       movscr2gr       \tmp0, $scr2
>> +       EX      st.d    \tmp0, \base, (2 * SCR_REG_WIDTH)
>> +       movscr2gr       \tmp0, $scr3
>> +       EX      st.d    \tmp0, \base, (3 * SCR_REG_WIDTH)
>> +       .endm
>> +
>> +       .macro  sc_restore_scr base, tmp0
>> +       EX      ld.d    \tmp0, \base, (0 * SCR_REG_WIDTH)
>> +       movgr2scr       $scr0, \tmp0
>> +       EX      ld.d    \tmp0, \base, (1 * SCR_REG_WIDTH)
>> +       movgr2scr       $scr1, \tmp0
>> +       EX      ld.d    \tmp0, \base, (2 * SCR_REG_WIDTH)
>> +       movgr2scr       $scr2, \tmp0
>> +       EX      ld.d    \tmp0, \base, (3 * SCR_REG_WIDTH)
>> +       movgr2scr       $scr3, \tmp0
>> +       .endm
>> +
>> +       .macro  sc_save_eflag base, tmp0
>> +       x86mfflag       \tmp0, 0x3f
>> +       EX st.w         \tmp0, \base, 0
>> +       .endm
>> +
>> +       .macro  sc_restore_eflag base, tmp0
>> +       EX ld.w         \tmp0, \base, 0
>> +       x86mtflag       \tmp0, 0x3f
>> +       .endm
>> +
>> +/*
>> + * Save a thread's lbt context.
>> + */
>> +SYM_FUNC_START(_save_lbt)
>> +       lbt_save_scr    a0 t1           # clobbers t1
>> +       lbt_save_eflag  a0 t1           # clobbers t1
> lbt_save_scr and lbt_save_eflag are very simple, from my point of view
> we can inline them here.
>
>> +       jr                              ra
>> +SYM_FUNC_END(_save_lbt)
>> +EXPORT_SYMBOL(_save_lbt)
>> +
>> +/*
>> + * Restore a thread's lbt context.
>> + */
>> +SYM_FUNC_START(_restore_lbt)
>> +       lbt_restore_eflag       a0 t1   # clobbers t1
>> +       lbt_restore_scr         a0 t1   # clobbers t1
> The same as above.
>
>> +       jr                                      ra
>> +SYM_FUNC_END(_restore_lbt)
>> +EXPORT_SYMBOL(_restore_lbt)
>> +
>> +/*
>> + * a0: scr
>> + * a1: eflag
>> + */
>> +SYM_FUNC_START(_save_lbt_context)
>> +       sc_save_scr             a0 t1
>> +       sc_save_eflag   a1 t1
>> +       li.w                    a0, 0           # success
>> +       jr                              ra
>> +SYM_FUNC_END(_save_lbt_context)
>> +
>> +/*
>> + * a0: scr
>> + * a1: eflag
>> + */
>> +SYM_FUNC_START(_restore_lbt_context)
>> +       sc_restore_scr          a0 t1
>> +       sc_restore_eflag        a1 t1
>> +       li.w                            a0, 0   # success
>> +       jr                                      ra
>> +SYM_FUNC_END(_restore_lbt_context)
>> +
>> +/*
>> + * a0: ftop
>> + */
>> +SYM_FUNC_START(_save_ftop_context)
>> +       x86mftop        t1
>> +       st.b            t1, a0, 0
>> +       li.w            a0, 0                   # success
>> +       jr                      ra
>> +SYM_FUNC_END(_save_ftop_context)
>> +
>> +/*
>> + * a0: ftop
>> + */
>> +SYM_FUNC_START(_restore_ftop_context)
>> +       ld.b            t1, a0, 0
>> +       andi            t1, t1, 0x7
>> +       la.pcrel        a0, 2f
>> +       alsl.d          a0, t1, a0, 3
>> +       jr                      a0
>> +       2 :
>> +       x86mttop        0
>> +       b       1f
>> +       x86mttop        1
>> +       b       1f
>> +       x86mttop        2
>> +       b       1f
>> +       x86mttop        3
>> +       b       1f
>> +       x86mttop        4
>> +       b       1f
>> +       x86mttop        5
>> +       b       1f
>> +       x86mttop        6
>> +       b       1f
>> +       x86mttop        7
>> +       1 :
>> +       li.w            a0, 0                   # success
>> +       jr                      ra
>> +SYM_FUNC_END(_restore_ftop_context)
>> +
>> +
>> +SYM_FUNC_START(lbt_fault)
>> +       li.w            a0, -EFAULT             # failure
>> +       jr                      ra
>> +SYM_FUNC_END(lbt_fault)
>> +
>> +#else
>> +
>> +/*
>> + * Save a thread's lbt context.
>> + */
>> +SYM_FUNC_START(_save_lbt)
>> +       jr      ra
>> +SYM_FUNC_END(_save_lbt)
>> +EXPORT_SYMBOL(_save_lbt)
>> +
>> +/*
>> + * Restore a thread's lbt context.
>> + */
>> +SYM_FUNC_START(_restore_lbt)
>> +       jr      ra
>> +SYM_FUNC_END(_restore_lbt)
>> +EXPORT_SYMBOL(_restore_lbt)
>> +
>> +#endif
>> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
>> index 2e04eb07abb6..7e11ef2c8fd2 100644
>> --- a/arch/loongarch/kernel/process.c
>> +++ b/arch/loongarch/kernel/process.c
>> @@ -38,6 +38,7 @@
>>   #include <asm/cpu.h>
>>   #include <asm/elf.h>
>>   #include <asm/fpu.h>
>> +#include <asm/lbt.h>
>>   #include <asm/io.h>
>>   #include <asm/irq.h>
>>   #include <asm/irq_regs.h>
>> @@ -89,9 +90,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
>>          euen = regs->csr_euen & ~(CSR_EUEN_FPEN);
>>          regs->csr_euen = euen;
>>          lose_fpu(0);
>> +       lose_lbt(0);
>>
>>          clear_thread_flag(TIF_LSX_CTX_LIVE);
>>          clear_thread_flag(TIF_LASX_CTX_LIVE);
>> +       clear_thread_flag(TIF_LBT_CTX_LIVE);
>>          clear_used_math();
>>          regs->csr_era = pc;
>>          regs->regs[3] = sp;
>> @@ -196,8 +199,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>          ptrace_hw_copy_thread(p);
>>          clear_tsk_thread_flag(p, TIF_USEDFPU);
>>          clear_tsk_thread_flag(p, TIF_USEDSIMD);
>> +       clear_tsk_thread_flag(p, TIF_USEDLBT);
>>          clear_tsk_thread_flag(p, TIF_LSX_CTX_LIVE);
>>          clear_tsk_thread_flag(p, TIF_LASX_CTX_LIVE);
>> +       clear_tsk_thread_flag(p, TIF_LBT_CTX_LIVE);
>>
>>          return 0;
>>   }
>> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
>> index a0767c3a0f0a..4192e20c6277 100644
>> --- a/arch/loongarch/kernel/ptrace.c
>> +++ b/arch/loongarch/kernel/ptrace.c
>> @@ -38,6 +38,7 @@
>>   #include <asm/cpu.h>
>>   #include <asm/cpu-info.h>
>>   #include <asm/fpu.h>
>> +#include <asm/lbt.h>
>>   #include <asm/loongarch.h>
>>   #include <asm/page.h>
>>   #include <asm/pgtable.h>
>> @@ -334,6 +335,46 @@ static int simd_set(struct task_struct *target,
>>
>>   #endif /* CONFIG_CPU_HAS_LSX */
>>
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +static int lbt_get(struct task_struct *target,
>> +                  const struct user_regset *regset,
>> +                  struct membuf to)
>> +{
>> +       int r;
>> +
>> +       r = membuf_write(&to, &target->thread.scr0, sizeof(target->thread.scr0));
>> +       r = membuf_write(&to, &target->thread.scr1, sizeof(target->thread.scr1));
>> +       r = membuf_write(&to, &target->thread.scr2, sizeof(target->thread.scr2));
>> +       r = membuf_write(&to, &target->thread.scr3, sizeof(target->thread.scr3));
>> +
>> +       r = membuf_write(&to, &target->thread.eflags, sizeof(u32));
>> +       r = membuf_write(&to, &target->thread.fpu.ftop, sizeof(u32));
>> +
>> +       return r;
>> +}
>> +
>> +static int lbt_set(struct task_struct *target,
>> +                  const struct user_regset *regset,
>> +                  unsigned int pos, unsigned int count,
>> +                  const void *kbuf, const void __user *ubuf)
>> +{
>> +       const int eflags_start = 4 * sizeof(target->thread.scr0);
>> +       const int ftop_start = eflags_start + sizeof(u32);
>> +       int err = 0;
>> +
>> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +                                 &target->thread.scr0,
>> +                                 0, 4 * sizeof(target->thread.scr0));
>> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +                                 &target->thread.eflags,
>> +                                 eflags_start, ftop_start);
>> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +                                 &target->thread.fpu.ftop, ftop_start,
>> +                                 ftop_start + sizeof(u32));
>> +       return err;
>> +}
>> +#endif /* CONFIG_CPU_HAS_LBT */
>> +
>>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
>>
>>   /*
>> @@ -798,6 +839,9 @@ enum loongarch_regset {
>>   #ifdef CONFIG_CPU_HAS_LASX
>>          REGSET_LASX,
>>   #endif
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +       REGSET_LBT,
>> +#endif
>>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
>>          REGSET_HW_BREAK,
>>          REGSET_HW_WATCH,
>> @@ -849,6 +893,16 @@ static const struct user_regset loongarch64_regsets[] = {
>>                  .set            = simd_set,
>>          },
>>   #endif
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +       [REGSET_LBT] = {
>> +               .core_note_type = NT_LOONGARCH_LBT,
>> +               .n              = 5,
>> +               .size           = sizeof(u64),
>> +               .align          = sizeof(u64),
>> +               .regset_get     = lbt_get,
>> +               .set            = lbt_set,
>> +       },
>> +#endif
>>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
>>          [REGSET_HW_BREAK] = {
>>                  .core_note_type = NT_LOONGARCH_HW_BREAK,
>> diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
>> index ceb899366c0a..7ebfa49e7456 100644
>> --- a/arch/loongarch/kernel/signal.c
>> +++ b/arch/loongarch/kernel/signal.c
>> @@ -32,6 +32,7 @@
>>   #include <asm/cacheflush.h>
>>   #include <asm/cpu-features.h>
>>   #include <asm/fpu.h>
>> +#include <asm/lbt.h>
>>   #include <asm/ucontext.h>
>>   #include <asm/vdso.h>
>>
>> @@ -44,6 +45,9 @@
>>   /* Make sure we will not lose FPU ownership */
>>   #define lock_fpu_owner()       ({ preempt_disable(); pagefault_disable(); })
>>   #define unlock_fpu_owner()     ({ pagefault_enable(); preempt_enable(); })
>> +/* Make sure we will not lose LBT ownership */
>> +#define lock_lbt_owner()       lock_fpu_owner()
>> +#define unlock_lbt_owner()     unlock_fpu_owner()
>>
>>   /* Assembly functions to move context to/from the FPU */
>>   extern asmlinkage int
>> @@ -58,6 +62,12 @@ extern asmlinkage int
>>   _save_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
>>   extern asmlinkage int
>>   _restore_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +extern asmlinkage int _save_lbt_context(void __user *regs, void __user *eflags);
>> +extern asmlinkage int _restore_lbt_context(void __user *regs, void __user *eflags);
>> +extern asmlinkage int _save_ftop_context(void __user *ftop);
>> +extern asmlinkage int _restore_ftop_context(void __user *ftop);
> After some thinkings, I prefer to remove the ftop handlings since you
> said that it is unused now. But we can keep ftop definition in
> lbt_context.
>
> Huacai

It is a bit absurd when you define a 'ftop' in 'sigcontext' but do not 
handle this (or give an incorrect result).

So it seems to me that we may need to keep ftop handling.


Qi

>> +#endif
>>
>>   struct rt_sigframe {
>>          struct siginfo rs_info;
>> @@ -75,6 +85,7 @@ struct extctx_layout {
>>          struct _ctx_layout fpu;
>>          struct _ctx_layout lsx;
>>          struct _ctx_layout lasx;
>> +       struct _ctx_layout lbt;
>>          struct _ctx_layout end;
>>   };
>>
>> @@ -125,6 +136,54 @@ static int copy_fpu_from_sigcontext(struct fpu_context __user *ctx)
>>          return err;
>>   }
>>
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +static int copy_lbt_to_sigcontext(struct lbt_context __user *ctx)
>> +{
>> +       int err = 0;
>> +       uint64_t __user *regs   = (uint64_t *)&ctx->regs;
>> +       uint32_t __user *eflags = &ctx->eflags;
>> +
>> +       err |= __put_user(current->thread.scr0, &regs[0]);
>> +       err |= __put_user(current->thread.scr1, &regs[1]);
>> +       err |= __put_user(current->thread.scr2, &regs[2]);
>> +       err |= __put_user(current->thread.scr3, &regs[3]);
>> +
>> +       err |= __put_user(current->thread.eflags, eflags);
>> +
>> +       return err;
>> +}
>> +
>> +static int copy_lbt_from_sigcontext(struct lbt_context __user *ctx)
>> +{
>> +       int err = 0;
>> +       uint64_t __user *regs   = (uint64_t *)&ctx->regs;
>> +       uint32_t __user *eflags = &ctx->eflags;
>> +
>> +       err |= __get_user(current->thread.scr0, &regs[0]);
>> +       err |= __get_user(current->thread.scr1, &regs[1]);
>> +       err |= __get_user(current->thread.scr2, &regs[2]);
>> +       err |= __get_user(current->thread.scr3, &regs[3]);
>> +
>> +       err |= __get_user(current->thread.eflags, eflags);
>> +
>> +       return err;
>> +}
>> +
>> +static int copy_ftop_to_sigcontext(struct lbt_context __user *ctx)
>> +{
>> +       uint32_t  __user *ftop  = &ctx->ftop;
>> +
>> +       return __put_user(current->thread.fpu.ftop, ftop);
>> +}
>> +
>> +static int copy_ftop_from_sigcontext(struct lbt_context __user *ctx)
>> +{
>> +       uint32_t  __user *ftop  = &ctx->ftop;
>> +
>> +       return __get_user(current->thread.fpu.ftop, ftop);
>> +}
>> +#endif
>> +
>>   static int copy_lsx_to_sigcontext(struct lsx_context __user *ctx)
>>   {
>>          int i;
>> @@ -291,6 +350,41 @@ static int fcsr_pending(unsigned int __user *fcsr)
>>          return err ?: sig;
>>   }
>>
>> +/*
>> + * Wrappers for the assembly _{save,restore}_lbt_context functions.
>> + */
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +static int save_hw_lbt_context(struct lbt_context __user *ctx)
>> +{
>> +       uint64_t __user *regs   = (uint64_t *)&ctx->regs;
>> +       uint32_t __user *eflags = &ctx->eflags;
>> +
>> +       return _save_lbt_context(regs, eflags);
>> +}
>> +
>> +static int restore_hw_lbt_context(struct lbt_context __user *ctx)
>> +{
>> +       uint64_t __user *regs   = (uint64_t *)&ctx->regs;
>> +       uint32_t __user *eflags = &ctx->eflags;
>> +
>> +       return _restore_lbt_context(regs, eflags);
>> +}
>> +
>> +static int save_hw_ftop_context(struct lbt_context __user *ctx)
>> +{
>> +       uint32_t  __user *ftop  = &ctx->ftop;
>> +
>> +       return _save_ftop_context(ftop);
>> +}
>> +
>> +static int restore_hw_ftop_context(struct lbt_context __user *ctx)
>> +{
>> +       uint32_t  __user *ftop  = &ctx->ftop;
>> +
>> +       return _restore_ftop_context(ftop);
>> +}
>> +#endif
>> +
>>   /*
>>    * Helper routines
>>    */
>> @@ -519,6 +613,83 @@ static int protected_restore_lasx_context(struct extctx_layout *extctx)
>>          return err ?: sig;
>>   }
>>
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +static int protected_save_lbt_context(struct extctx_layout *extctx)
>> +{
>> +       int err = 0;
>> +       struct sctx_info __user *info = extctx->lbt.addr;
>> +       struct lbt_context __user *lbt_ctx =
>> +               (struct lbt_context *)get_ctx_through_ctxinfo(info);
>> +       uint64_t __user *regs   = (uint64_t *)&lbt_ctx->regs;
>> +       uint32_t __user *eflags = &lbt_ctx->eflags;
>> +
>> +       while (1) {
>> +               lock_lbt_owner();
>> +               /* save lbt except ftop */
>> +               if (is_lbt_owner())
>> +                       err |= save_hw_lbt_context(lbt_ctx);
>> +               else
>> +                       err |= copy_lbt_to_sigcontext(lbt_ctx);
>> +               /* save ftop */
>> +               if (is_fpu_owner())
>> +                       err |= save_hw_ftop_context(lbt_ctx);
>> +               else
>> +                       err |= copy_ftop_to_sigcontext(lbt_ctx);
>> +               unlock_lbt_owner();
>> +
>> +               err |= __put_user(LBT_CTX_MAGIC, &info->magic);
>> +               err |= __put_user(extctx->lbt.size, &info->size);
>> +
>> +               if (likely(!err))
>> +                       break;
>> +               /* Touch the LBT context and try again */
>> +               err = __put_user(0, &regs[0]) |
>> +                       __put_user(0, eflags);
>> +
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +static int protected_restore_lbt_context(struct extctx_layout *extctx)
>> +{
>> +       int err = 0, tmp __maybe_unused;
>> +       struct sctx_info __user *info = extctx->lbt.addr;
>> +       struct lbt_context __user *lbt_ctx =
>> +               (struct lbt_context *)get_ctx_through_ctxinfo(info);
>> +       uint64_t __user *regs   = (uint64_t *)&lbt_ctx->regs;
>> +       uint32_t __user *eflags = &lbt_ctx->eflags;
>> +
>> +       while (1) {
>> +               lock_lbt_owner();
>> +               /* restore lbt except ftop */
>> +               if (is_lbt_owner())
>> +                       err |= restore_hw_lbt_context(lbt_ctx);
>> +               else
>> +                       err |= copy_lbt_from_sigcontext(lbt_ctx);
>> +               /* restore ftop */
>> +               if (is_fpu_owner())
>> +                       err |= restore_hw_ftop_context(lbt_ctx);
>> +               else
>> +                       err |= copy_ftop_from_sigcontext(lbt_ctx);
>> +               unlock_lbt_owner();
>> +
>> +               if (likely(!err))
>> +                       break;
>> +               /* Touch the LBT context and try again */
>> +               err = __get_user(tmp, &regs[0]) |
>> +                       __get_user(tmp, eflags);
>> +
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>> +       return err;
>> +}
>> +#endif
>> +
>>   static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
>>                              struct extctx_layout *extctx)
>>   {
>> @@ -539,6 +710,11 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
>>          else if (extctx->fpu.addr)
>>                  err |= protected_save_fpu_context(extctx);
>>
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +       if (extctx->lbt.addr)
>> +               err |= protected_save_lbt_context(extctx);
>> +#endif
>> +
>>          /* Set the "end" magic */
>>          info = (struct sctx_info *)extctx->end.addr;
>>          err |= __put_user(0, &info->magic);
>> @@ -584,6 +760,13 @@ static int parse_extcontext(struct sigcontext __user *sc, struct extctx_layout *
>>                          extctx->lasx.addr = info;
>>                          break;
>>
>> +               case LBT_CTX_MAGIC:
>> +                       if (size < (sizeof(struct sctx_info) +
>> +                                   sizeof(struct lbt_context)))
>> +                               goto invalid;
>> +                       extctx->lbt.addr = info;
>> +                       break;
>> +
>>                  default:
>>                          goto invalid;
>>                  }
>> @@ -636,6 +819,11 @@ static int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc
>>          else if (extctx.fpu.addr)
>>                  err |= protected_restore_fpu_context(&extctx);
>>
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +       if (extctx.lbt.addr)
>> +               err |= protected_restore_lbt_context(&extctx);
>> +#endif
>> +
>>   bad:
>>          return err;
>>   }
>> @@ -700,6 +888,11 @@ static unsigned long setup_extcontext(struct extctx_layout *extctx, unsigned lon
>>                            sizeof(struct fpu_context), FPU_CTX_ALIGN, new_sp);
>>          }
>>
>> +       if (cpu_has_lbt && thread_lbt_context_live()) {
>> +               new_sp = extframe_alloc(extctx, &extctx->lbt,
>> +                         sizeof(struct lbt_context), LBT_CTX_ALIGN, new_sp);
>> +       }
>> +
>>          return new_sp;
>>   }
>>
>> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
>> index 8fb5e7a77145..fd20e22a02b4 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -36,6 +36,7 @@
>>   #include <asm/break.h>
>>   #include <asm/cpu.h>
>>   #include <asm/fpu.h>
>> +#include <asm/lbt.h>
>>   #include <asm/inst.h>
>>   #include <asm/loongarch.h>
>>   #include <asm/mmu_context.h>
>> @@ -904,6 +905,24 @@ static void init_restore_lasx(void)
>>          BUG_ON(!is_lasx_enabled());
>>   }
>>
>> +#ifdef CONFIG_CPU_HAS_LBT
>> +static void init_restore_lbt(void)
>> +{
>> +       if (!thread_lbt_context_live()) {
>> +               /* First time lbt context user */
>> +               init_lbt();
>> +       } else {
>> +               /* Enable and restore */
>> +               if (!is_lbt_owner())
>> +                       own_lbt_inatomic(1);
>> +       }
>> +
>> +       BUG_ON(!is_lbt_enabled());
>> +}
>> +#else
>> +static void init_restore_lbt(void) {}
>> +#endif
>> +
>>   asmlinkage void noinstr do_fpu(struct pt_regs *regs)
>>   {
>>          irqentry_state_t state = irqentry_enter(regs);
>> @@ -968,10 +987,29 @@ asmlinkage void noinstr do_lbt(struct pt_regs *regs)
>>   {
>>          irqentry_state_t state = irqentry_enter(regs);
>>
>> -       local_irq_enable();
>> -       force_sig(SIGILL);
>> -       local_irq_disable();
>> +       /*
>> +        * BTD (Binary Translation Disable exception) can be triggered
>> +        * during FP save/restore if TM (Top Mode) is open, which may
>> +        * cause irq_enable during 'switch_to'. To avoid this situation
>> +        * (including the user using 'MOVGR2GCSR' to open the TM, which
>> +        * will not trigger the BTE), we need to check PRMD first.
>> +        */
>> +       if (likely(regs->csr_prmd & CSR_PRMD_PIE))
>> +               local_irq_enable();
>> +
>> +       if (!cpu_has_lbt) {
>> +               force_sig(SIGILL);
>> +               goto out;
>> +       }
>> +
>> +       BUG_ON(is_lbt_enabled());
>>
>> +       preempt_disable();
>> +       init_restore_lbt();
>> +       preempt_enable();
>> +
>> +out:
>> +       local_irq_disable();
>>          irqentry_exit(regs, state);
>>   }
>>
>> --
>> 2.40.1
>>

