Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234E06372D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKXHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKXHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:14:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF60252BA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:23:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y10so747621plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0ItXHtVldnViD1Is3zbjn5/H8sbsgkFTOcvApNIeO0=;
        b=BqAwcv6IdzdyiBWU+KEmdfVVpMWWXW8TsIPHNHfTio0aD+0MCzp4i8lMq0dYCfsHt9
         0mksZGs50dZNNTkmWkD259c3BY9ak3MereU7txWN7OHVv0GcAy6FBlVudnZvGsGx+mgv
         5WnNR8DO2Qt2MzX5VI1KpbMZvpYzXfmBB5b+MwBCTjsjSWiHgGqBK0vn50cAI4TARk+P
         oedkg7GzvQCYJagCgDFFB4HEmdpmqbNZvqWSSdfhLWkVE2wrNw1KM+TX3Nzxq5dIWhsX
         X9jmSHf/E88/GVzIYJPPBXdEqw1MuN/dyVjnrMfOaiCB5ORVivhigtf9cOmqeay3QYZy
         mj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0ItXHtVldnViD1Is3zbjn5/H8sbsgkFTOcvApNIeO0=;
        b=qxQ/qwmuObpP9NjljBURdZEju2Ive4gxE/tpGA7Sj4lYa7kuMeRPhGUB5sJdjVDd+G
         /+3Fjjw/EQZ4Nh/XuFD0VDUiCz4swdN+busA3f5fi2tDWXitZO4UfkRLMbN+WHyrj+Gb
         Yx3JTrt3THUv5RP94Q/oIUlnCBtuTw5fwqgVQ+5dFoKTB4SuISVV3dsOMW6n9Jji5ghU
         yatPHg4Xdq/DpBdiPGQLNyFUhiG/pYoiwDCMytC32jxDZPI53THfVXvqdTExnamv/7uI
         XYqRTeyscHxKg0VVeJvE+GUr9QUQEW64kidDbMX+S3naokj14R9A6MC7M7Tbd7GpBcgX
         jRRg==
X-Gm-Message-State: ANoB5pmZjYLp6pkMaBz5xDfT88I5nEneRf359uSVndlQpxxhxCT9uMIm
        gtUX8Id7cy+bcCZFBJD6lkpSIA==
X-Google-Smtp-Source: AA0mqf4vylb5EvSDjW2Uv0WxT12J+ZnodEGoa9UR/umQc+DmLMwM0WUYq2dRkbaLCB7edJ9NJIuOKQ==
X-Received: by 2002:a17:903:40cb:b0:178:b4b7:d74d with SMTP id t11-20020a17090340cb00b00178b4b7d74dmr12331156pld.83.1669274628236;
        Wed, 23 Nov 2022 23:23:48 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id q10-20020a6557ca000000b004393f60db36sm485716pgr.32.2022.11.23.23.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:23:47 -0800 (PST)
Date:   Wed, 23 Nov 2022 23:23:46 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221124072346.GB1149630@debug.ba.rivosinc.com>
References: <20221124005006.1788315-1-debug@rivosinc.com>
 <A190DD6B-18A3-4DFE-AF8B-D5D50B6B6409@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <A190DD6B-18A3-4DFE-AF8B-D5D50B6B6409@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 06:30:35AM +0000, Conor Dooley wrote:
>Hey Deepak,
>Guo Ren s issues aside, there's some process bits here.
>
>On 24 November 2022 00:50:06 GMT, Deepak Gupta <debug@rivosinc.com> wrote:
>>commit 31da94c25aea835ceac00575a9fd206c5a833fed added support for
>
>Please check the documentation for how to format commit references in patch text.
>As a reader, a hash requires access to a git tree to do anything with.
>Id show you the format but I am on my phone ;)
>

Thanks I'll make that correction.

>>CONFIG_VMAP_STACK. If overflow is detected, CPU switches to `shadow_stack`
>>temporarily before switching finally to per-cpu `overflow_stack`.
>>
>>If two CPUs/harts are racing and end up in over flowing kernel stack, one
>>or both will end up corrupting each other state because `shadow_stack` is
>>not per-cpu.
>>
>>Following are the changes in this patch
>>
>> - Defines an asm macro to obtain per-cpu symbols in destination
>>   register.
>> - Computing per-cpu symbol requires a temporary register. When stack is
>>   out of question, a place is needed to spill a register. `thread_info`
>>   is good location to have spill register.
>> - In entry.S when overflow is detected x31 is spilled into thread_info.
>>   x31 is used as temp reg for asm macro to locate per-cpu overflow stack
>>
>>Other relevant disccussion on this
>>https://lore.kernel.org/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t
>
>Link: foo
>
>>
>>Tested by `echo EXHAUST_STACK > /sys/kernel/debug/provoke-crash/DIRECT`
>>
>>[  286.223273] Insufficient stack space to handle exception!/debug/provoke-crash/DIRECT
>>[  286.223878] Task stack:     [0xff20000010a98000..0xff20000010a9c000]
>>[  286.224411] Overflow stack: [0xff600001f7d98370..0xff600001f7d99370]
>>[  286.226057] CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>>[  286.227139] Hardware name: riscv-virtio,qemu (DT)
>>[  286.228000] epc : __memset+0x60/0xfc
>>[  286.229299]  ra : recursive_loop+0x48/0xc6 [lkdtm]
>>[  286.231457] epc : ffffffff808de0e4 ra : ffffffff0163a752 sp : ff20000010a97e80
>>[  286.232207]  gp : ffffffff815c0330 tp : ff600000820ea280 t0 : ff20000010a97e88
>>[  286.233584]  t1 : 000000000000002e t2 : 3233206874706564 s0 : ff20000010a982b0
>>[  286.234293]  s1 : 0000000000000012 a0 : ff20000010a97e88 a1 : 0000000000000000
>>[  286.234998]  a2 : 0000000000000400 a3 : ff20000010a98288 a4 : 0000000000000000
>>[  286.235697]  a5 : 0000000000000000 a6 : fffffffffffe43f0 a7 : 00007fffffffffff
>>[  286.236384]  s2 : ff20000010a97e88 s3 : ffffffff01644680 s4 : ff20000010a9be90
>>[  286.237743]  s5 : ff600000842ba6c0 s6 : 00aaaaaac29e42b0 s7 : 00fffffff0aa3684
>>[  286.238691]  s8 : 00aaaaaac2978040 s9 : 0000000000000065 s10: 00ffffff8a7cad10
>>[  286.239591]  s11: 00ffffff8a76a4e0 t3 : ffffffff815dbaf4 t4 : ffffffff815dbaf4
>>[  286.240537]  t5 : ffffffff815dbab8 t6 : ff20000010a9bb48
>>[  286.241540] status: 0000000200000120 badaddr: ff20000010a97e88 cause: 000000000000000f
>>[  286.242979] Kernel panic - not syncing: Kernel stack overflow
>>[  286.244106] CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>>[  286.245276] Hardware name: riscv-virtio,qemu (DT)
>>[  286.245929] Call Trace:
>>[  286.246954] [<ffffffff80006754>] dump_backtrace+0x30/0x38
>>[  286.247813] [<ffffffff808de798>] show_stack+0x40/0x4c
>>[  286.248429] [<ffffffff808ea2a8>] dump_stack_lvl+0x44/0x5c
>>[  286.249439] [<ffffffff808ea2d8>] dump_stack+0x18/0x20
>>[  286.250056] [<ffffffff808dec06>] panic+0x126/0x2fe
>>[  286.250642] [<ffffffff800065ea>] walk_stackframe+0x0/0xf0
>>[  286.251357] [<ffffffff0163a752>] recursive_loop+0x48/0xc6 [lkdtm]
>>[  286.253321] SMP: stopping secondary CPUs
>>[  286.256724] ---[ end Kernel panic - not syncing: Kernel stack overflow ]---
>
>For stack traces, especially long ones, please cut out the timestamps.

I followed formatting of stack traces in commit 31da94c25ae. 
Assumed since that's merged, that's how test and stack traces 
should be included in commit msg.

I'll follow your suggestion and remove timestamps.

>
>
>>Fixes: 31da94c25aea835ceac00575a9fd206c5a833fed
>
>https://gist.githubusercontent.com/conor-pwbot/8882fc7ef7cd4fe833774574fbf509f5/raw/d360ec7aebfaa6c2d043e9bd87f59745ad6a4c85/desc
>
>Please use the correct format for fixes tags.
>
>>Cc: Guo Ren <guoren@kernel.org>
>>Cc: Jisheng Zhang <jszhang@kernel.org>
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>
>All of the tags need to be in one block, so:
>
>Link:
>Fixes:
>SoB:

Noted.

>
>Thanks,
>Conor.
>
>>---
>> arch/riscv/include/asm/asm.h         | 11 ++++++
>> arch/riscv/include/asm/thread_info.h |  3 ++
>> arch/riscv/kernel/asm-offsets.c      |  4 +++
>> arch/riscv/kernel/entry.S            | 54 ++++------------------------
>> arch/riscv/kernel/traps.c            | 12 +------
>> 5 files changed, 26 insertions(+), 58 deletions(-)
>>
>>diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>>index 1b471ff73178..373eba843331 100644
>>--- a/arch/riscv/include/asm/asm.h
>>+++ b/arch/riscv/include/asm/asm.h
>>@@ -69,6 +69,7 @@
>>
>> #ifdef __ASSEMBLY__
>>
>>+#include <asm/asm-offsets.h>
>> /* Common assembly source macros */
>>
>> /*
>>@@ -80,6 +81,16 @@
>> 	.endr
>> .endm
>>
>>+.macro asm_per_cpu dst sym tmp
>>+	REG_L \tmp, TASK_TI_CPU_NUM(tp)
>>+	slli \tmp, \tmp, 0x3
>>+	la \dst, __per_cpu_offset
>>+	add \dst, \dst, \tmp
>>+	REG_L \tmp, 0(\dst)
>>+	la \dst, \sym
>>+	add \dst, \dst, \tmp
>>+.endm
>>+
>> #endif /* __ASSEMBLY__ */
>>
>> #endif /* _ASM_RISCV_ASM_H */
>>diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>index 67322f878e0d..7e17dc07cf11 100644
>>--- a/arch/riscv/include/asm/thread_info.h
>>+++ b/arch/riscv/include/asm/thread_info.h
>>@@ -65,6 +65,9 @@ struct thread_info {
>> 	 */
>> 	long			kernel_sp;	/* Kernel stack pointer */
>> 	long			user_sp;	/* User stack pointer */
>>+#ifdef CONFIG_VMAP_STACK
>>+	long			spill_reg;      /* per cpu scratch space to spill a single register */
>>+#endif
>> 	int			cpu;
>> };
>>
>>diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>>index df9444397908..bed3c83bfb8f 100644
>>--- a/arch/riscv/kernel/asm-offsets.c
>>+++ b/arch/riscv/kernel/asm-offsets.c
>>@@ -38,6 +38,10 @@ void asm_offsets(void)
>> 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>> 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>>
>>+	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>>+#ifdef CONFIG_VMAP_STACK
>>+	OFFSET(TASK_TI_SPILL_REG, task_struct, thread_info.spill_reg);
>>+#endif
>> 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>> 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>> 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
>>diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>index b9eda3fcbd6d..12f285cec136 100644
>>--- a/arch/riscv/kernel/entry.S
>>+++ b/arch/riscv/kernel/entry.S
>>@@ -10,9 +10,11 @@
>> #include <asm/asm.h>
>> #include <asm/csr.h>
>> #include <asm/unistd.h>
>>+#include <asm/page.h>
>> #include <asm/thread_info.h>
>> #include <asm/asm-offsets.h>
>> #include <asm/errata_list.h>
>>+#include <linux/sizes.h>
>>
>> #if !IS_ENABLED(CONFIG_PREEMPTION)
>> .set resume_kernel, restore_all
>>@@ -404,54 +406,12 @@ handle_syscall_trace_exit:
>>
>> #ifdef CONFIG_VMAP_STACK
>> handle_kernel_stack_overflow:
>>-	la sp, shadow_stack
>>-	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>>+	REG_S x31, TASK_TI_SPILL_REG(tp)
>>+	asm_per_cpu sp, overflow_stack, x31
>>+	li x31, OVERFLOW_STACK_SIZE
>>+	add sp, sp, x31
>>+	REG_L x31, TASK_TI_SPILL_REG(tp)
>>
>>-	//save caller register to shadow stack
>>-	addi sp, sp, -(PT_SIZE_ON_STACK)
>>-	REG_S x1,  PT_RA(sp)
>>-	REG_S x5,  PT_T0(sp)
>>-	REG_S x6,  PT_T1(sp)
>>-	REG_S x7,  PT_T2(sp)
>>-	REG_S x10, PT_A0(sp)
>>-	REG_S x11, PT_A1(sp)
>>-	REG_S x12, PT_A2(sp)
>>-	REG_S x13, PT_A3(sp)
>>-	REG_S x14, PT_A4(sp)
>>-	REG_S x15, PT_A5(sp)
>>-	REG_S x16, PT_A6(sp)
>>-	REG_S x17, PT_A7(sp)
>>-	REG_S x28, PT_T3(sp)
>>-	REG_S x29, PT_T4(sp)
>>-	REG_S x30, PT_T5(sp)
>>-	REG_S x31, PT_T6(sp)
>>-
>>-	la ra, restore_caller_reg
>>-	tail get_overflow_stack
>>-
>>-restore_caller_reg:
>>-	//save per-cpu overflow stack
>>-	REG_S a0, -8(sp)
>>-	//restore caller register from shadow_stack
>>-	REG_L x1,  PT_RA(sp)
>>-	REG_L x5,  PT_T0(sp)
>>-	REG_L x6,  PT_T1(sp)
>>-	REG_L x7,  PT_T2(sp)
>>-	REG_L x10, PT_A0(sp)
>>-	REG_L x11, PT_A1(sp)
>>-	REG_L x12, PT_A2(sp)
>>-	REG_L x13, PT_A3(sp)
>>-	REG_L x14, PT_A4(sp)
>>-	REG_L x15, PT_A5(sp)
>>-	REG_L x16, PT_A6(sp)
>>-	REG_L x17, PT_A7(sp)
>>-	REG_L x28, PT_T3(sp)
>>-	REG_L x29, PT_T4(sp)
>>-	REG_L x30, PT_T5(sp)
>>-	REG_L x31, PT_T6(sp)
>>-
>>-	//load per-cpu overflow stack
>>-	REG_L sp, -8(sp)
>> 	addi sp, sp, -(PT_SIZE_ON_STACK)
>>
>> 	//save context to overflow stack
>>diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>index f3e96d60a2ff..eef3a87514c7 100644
>>--- a/arch/riscv/kernel/traps.c
>>+++ b/arch/riscv/kernel/traps.c
>>@@ -208,18 +208,8 @@ int is_valid_bugaddr(unsigned long pc)
>> #endif /* CONFIG_GENERIC_BUG */
>>
>> #ifdef CONFIG_VMAP_STACK
>>-static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>>+DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>> 		overflow_stack)__aligned(16);
>>-/*
>>- * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
>>- * to get per-cpu overflow stack(get_overflow_stack).
>>- */
>>-long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
>>-asmlinkage unsigned long get_overflow_stack(void)
>>-{
>>-	return (unsigned long)this_cpu_ptr(overflow_stack) +
>>-		OVERFLOW_STACK_SIZE;
>>-}
>>
>> asmlinkage void handle_bad_stack(struct pt_regs *regs)
>> {
