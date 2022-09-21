Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75B5BF7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIUHlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiIUHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:41:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A7BF303C3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:41:25 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+AZwCpjyE0fAA--.52706S2;
        Wed, 21 Sep 2022 15:41:15 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Remove unused kernel stack padding
Date:   Wed, 21 Sep 2022 15:41:13 +0800
Message-Id: <1663746073-12584-1-git-send-email-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxT+AZwCpjyE0fAA--.52706S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4DKw4DuF4Uur4UKF4UArb_yoWrXry7pF
        9rAw1DGr4jkFnYyryDtrs8ZryDJwn7Kw1aga17ta4rArnFqF1rZryxAryDXFyYqa95Kay0
        gFy3Kwsxta15X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel stack padding looks like obey MIPS o32 Calling Convention, as
LoongArch is inspired by MIPS and keep it. Remove it avoid not clear
code.

Link: https://lore.kernel.org/loongarch/1662130897-13156-1-git-send-email-hejinyang@loongson.cn/

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 v2: Remove TOP_OF_KERNEL_STACK_PADDING
     Remove 'init stack pointer' in head.S

 arch/loongarch/include/asm/processor.h | 2 +-
 arch/loongarch/include/asm/ptrace.h    | 2 +-
 arch/loongarch/kernel/head.S           | 3 +--
 arch/loongarch/kernel/process.c        | 4 ++--
 arch/loongarch/kernel/switch.S         | 2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index 1c4b4308378d..780e0d39f638 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -194,7 +194,7 @@ static inline void flush_thread(void)
 unsigned long __get_wchan(struct task_struct *p);
 
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
-			 THREAD_SIZE - 32 - sizeof(struct pt_regs))
+			 THREAD_SIZE - sizeof(struct pt_regs))
 #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
 #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index 17838c6b7ccd..82649a78fec1 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -133,7 +133,7 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 #define current_pt_regs()						\
 ({									\
 	unsigned long sp = (unsigned long)__builtin_frame_address(0);	\
-	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;	\
+	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1) - 1;		\
 })
 
 /* Helpers for working with the user stack pointer */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 4d352230fbc3..0e1752fbc857 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -81,10 +81,9 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 
 	la.pcrel	tp, init_thread_union
 	/* Set the SP after an empty pt_regs.  */
-	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
+	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
 	PTR_ADD		sp, sp, tp
 	set_saved_sp	sp, t0, t1
-	PTR_ADDI	sp, sp, -4 * SZREG	# init stack pointer
 
 	bl		start_kernel
 
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 660492f064e7..dae087d6c458 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long clone_flags = args->flags;
 	struct pt_regs *childregs, *regs = current_pt_regs();
 
-	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
+	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 
 	/* set up new TSS. */
 	childregs = (struct pt_regs *) childksp - 1;
@@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
 			struct stack_info *info)
 {
 	unsigned long begin = (unsigned long)task_stack_page(task);
-	unsigned long end = begin + THREAD_SIZE - 32;
+	unsigned long end = begin + THREAD_SIZE;
 
 	if (stack < begin || stack >= end)
 		return false;
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index 43ebbc3990f7..202a163cb32f 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
 	move	tp, a2
 	cpu_restore_nonscratch a1
 
-	li.w		t0, _THREAD_SIZE - 32
+	li.w		t0, _THREAD_SIZE
 	PTR_ADD		t0, t0, tp
 	set_saved_sp	t0, t1, t2
 
-- 
2.31.1

