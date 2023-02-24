Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4296A19AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjBXKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBXKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:11:26 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38EE564E3D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:10:47 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxUOUmjfhjgqQEAA--.3637S3;
        Fri, 24 Feb 2023 18:10:46 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+QjjfhjNH86AA--.6368S3;
        Fri, 24 Feb 2023 18:10:45 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] LoongArch: Rename handle_syscall to handle_sys
Date:   Fri, 24 Feb 2023 18:10:08 +0800
Message-Id: <20230224101013.26971-2-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230224101013.26971-1-hejinyang@loongson.cn>
References: <20230224101013.26971-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX+QjjfhjNH86AA--.6368S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF13Kw43Kw17GF1rCw15urg_yoW8Ar1Dp3
        45Ar4kZrWkKFnxZasxC3WUurW8AasrWw129a1UKFWrCFnxXFnY9ry0va93XF1agw4xWFW0
        vFn5J392qay5GwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original handle_sys() is a trampline for handler_syscall. Drop it
and rename handle_syscall to handle_sys for invoking it directly.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/kernel/entry.S | 13 +++++++------
 arch/loongarch/kernel/genex.S |  5 -----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d737e3cf42d3..d6e9572eb279 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -18,9 +18,9 @@
 	.text
 	.cfi_sections	.debug_frame
 	.align	5
-SYM_FUNC_START(handle_syscall)
+SYM_FUNC_START(handle_sys)
 	csrrd		t0, PERCPU_BASE_KS
-	la.pcrel	t1, kernelsp
+	la_abs		t1, kernelsp
 	add.d		t1, t1, t0
 	move		t2, sp
 	ld.d		sp, t1, 0
@@ -62,12 +62,13 @@ SYM_FUNC_START(handle_syscall)
 	li.d		tp, ~_THREAD_MASK
 	and		tp, tp, sp
 
-	move		a0, sp
-	bl		do_syscall
+	move	a0, sp
+	la_abs	ra, do_syscall
+	jirl	ra, ra, 0
 
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_syscall)
-_ASM_NOKPROBE(handle_syscall)
+SYM_FUNC_END(handle_sys)
+_ASM_NOKPROBE(handle_sys)
 
 SYM_CODE_START(ret_from_fork)
 	bl		schedule_tail		# a0 = struct task_struct *prev
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 44ff1ff64260..1af169ca3734 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -91,8 +91,3 @@ SYM_FUNC_END(except_vec_cex)
 	BUILD_HANDLER ri ri none
 	BUILD_HANDLER watch watch none
 	BUILD_HANDLER reserved reserved none	/* others */
-
-SYM_FUNC_START(handle_sys)
-	la_abs	t0, handle_syscall
-	jr	t0
-SYM_FUNC_END(handle_sys)
-- 
2.34.3

