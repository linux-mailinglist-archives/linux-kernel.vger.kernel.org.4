Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE766AA6F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjANJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjANJ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:27:38 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AFC47A91
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:27:37 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Ax3eqIdcJjdp0BAA--.5105S3;
        Sat, 14 Jan 2023 17:27:36 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+SBdcJjcVYZAA--.11667S6;
        Sat, 14 Jan 2023 17:27:34 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v11 4/6] LoongArch: Mark some assembler symbols as non-kprobe-able
Date:   Sat, 14 Jan 2023 17:27:22 +0800
Message-Id: <1673688444-24251-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
References: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Bxb+SBdcJjcVYZAA--.11667S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uw45Wr4fCw45ZrWUGFW7urg_yoW8Kr17pw
        1DAr4vgrs5Gr1fJry7tF1UZ3yDZws7Gr12v3W29FW8CF47WF18Zry093yDXFyxtw43GFWF
        qFn5J3929F4UJa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some assembler symbols are not kprobe safe, such as handle_syscall
(used as syscall exception handler), *memcpy* (may cause recursive
exceptions), they can not be instrumented, just blacklist them for
kprobing.

Here is a related problem and discussion:
Link: https://lore.kernel.org/lkml/20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org/

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/asm.h | 10 ++++++++++
 arch/loongarch/kernel/entry.S    |  1 +
 arch/loongarch/lib/memcpy.S      |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/arch/loongarch/include/asm/asm.h b/arch/loongarch/include/asm/asm.h
index 40eea6a..f591b32 100644
--- a/arch/loongarch/include/asm/asm.h
+++ b/arch/loongarch/include/asm/asm.h
@@ -188,4 +188,14 @@
 #define PTRLOG		3
 #endif
 
+/* Annotate a function as being unsuitable for kprobes. */
+#ifdef CONFIG_KPROBES
+#define _ASM_NOKPROBE(name)				\
+	.pushsection "_kprobe_blacklist", "aw";		\
+	.quad	name;					\
+	.popsection
+#else
+#define _ASM_NOKPROBE(name)
+#endif
+
 #endif /* __ASM_ASM_H */
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d53b631..55e23b1 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -67,6 +67,7 @@ SYM_FUNC_START(handle_syscall)
 
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_syscall)
+_ASM_NOKPROBE(handle_syscall)
 
 SYM_CODE_START(ret_from_fork)
 	bl	schedule_tail		# a0 = struct task_struct *prev
diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
index 7c07d59..3b7e1de 100644
--- a/arch/loongarch/lib/memcpy.S
+++ b/arch/loongarch/lib/memcpy.S
@@ -17,6 +17,7 @@ SYM_FUNC_START(memcpy)
 	ALTERNATIVE	"b __memcpy_generic", \
 			"b __memcpy_fast", CPU_FEATURE_UAL
 SYM_FUNC_END(memcpy)
+_ASM_NOKPROBE(memcpy)
 
 EXPORT_SYMBOL(memcpy)
 
@@ -41,6 +42,7 @@ SYM_FUNC_START(__memcpy_generic)
 2:	move	a0, a3
 	jr	ra
 SYM_FUNC_END(__memcpy_generic)
+_ASM_NOKPROBE(__memcpy_generic)
 
 /*
  * void *__memcpy_fast(void *dst, const void *src, size_t n)
@@ -93,3 +95,4 @@ SYM_FUNC_START(__memcpy_fast)
 3:	move	a0, a3
 	jr	ra
 SYM_FUNC_END(__memcpy_fast)
+_ASM_NOKPROBE(__memcpy_fast)
-- 
2.1.0

