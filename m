Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72596E5D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDRJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjDRJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:13:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E4A59FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:13:53 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxedlQXz5kxWAeAA--.47516S3;
        Tue, 18 Apr 2023 17:13:52 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxGL1QXz5k5qosAA--.51153S2;
        Tue, 18 Apr 2023 17:13:52 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] LoongArch: Add pad structure members for explicit alignment
Date:   Tue, 18 Apr 2023 17:13:48 +0800
Message-Id: <20230418091348.9239-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxGL1QXz5k5qosAA--.51153S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrW7AF4fCF13Gry8Kr15Jwb_yoW8KFyfpr
        ZrAwnrKF4UKFyfGFs5tr4DZrn8J3s2kryI9as3Ca4SyF9IqryUXry8GryqyF43K3y0qFyS
        qFyakrWYva1DXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done in order to easily calculate the number of breakpoints
in hw_break_get.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/uapi/asm/ptrace.h |  3 ++-
 arch/loongarch/kernel/ptrace.c           | 13 +++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/uapi/asm/ptrace.h b/arch/loongarch/include/uapi/asm/ptrace.h
index 2282ae1fd3b6..06e3be52cb04 100644
--- a/arch/loongarch/include/uapi/asm/ptrace.h
+++ b/arch/loongarch/include/uapi/asm/ptrace.h
@@ -57,11 +57,12 @@ struct user_lasx_state {
 };
 
 struct user_watch_state {
-	uint16_t dbg_info;
+	uint64_t dbg_info;
 	struct {
 		uint64_t    addr;
 		uint64_t    mask;
 		uint32_t    ctrl;
+		uint32_t    pad;
 	} dbg_regs[8];
 };
 
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index 0c7c41e41cad..9c3bc1bbf2ff 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -475,10 +475,10 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
 	return 0;
 }
 
-static int ptrace_hbp_get_resource_info(unsigned int note_type, u16 *info)
+static int ptrace_hbp_get_resource_info(unsigned int note_type, u64 *info)
 {
 	u8 num;
-	u16 reg = 0;
+	u64 reg = 0;
 
 	switch (note_type) {
 	case NT_LOONGARCH_HW_BREAK:
@@ -616,7 +616,7 @@ static int hw_break_get(struct task_struct *target,
 			const struct user_regset *regset,
 			struct membuf to)
 {
-	u16 info;
+	u64 info;
 	u32 ctrl;
 	u64 addr, mask;
 	int ret, idx = 0;
@@ -646,6 +646,7 @@ static int hw_break_get(struct task_struct *target,
 		membuf_store(&to, addr);
 		membuf_store(&to, mask);
 		membuf_store(&to, ctrl);
+		membuf_zero(&to, sizeof(u32));
 		idx++;
 	}
 
@@ -662,7 +663,7 @@ static int hw_break_set(struct task_struct *target,
 	int ret, idx = 0, offset, limit;
 	unsigned int note_type = regset->core_note_type;
 
-	/* Resource info */
+	/* Resource info and pad */
 	offset = offsetof(struct user_watch_state, dbg_regs);
 	user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0, offset);
 
@@ -704,6 +705,10 @@ static int hw_break_set(struct task_struct *target,
 		if (ret)
 			return ret;
 		offset += PTRACE_HBP_CTRL_SZ;
+
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  offset, offset + PTRACE_HBP_PAD_SZ);
+		offset += PTRACE_HBP_PAD_SZ;
 		idx++;
 	}
 
-- 
2.20.1

