Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315A4641727
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLCNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLCNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:54:22 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70D05193EE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 05:54:19 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx1vAJVYtjDPsCAA--.6924S3;
        Sat, 03 Dec 2022 21:54:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZ1cIVYtjkBMlAA--.8238S2;
        Sat, 03 Dec 2022 21:54:16 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Make lscpu show "Model name" and "CPU family"
Date:   Sat,  3 Dec 2022 21:54:16 +0800
Message-Id: <1670075656-4754-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxZ1cIVYtjkBMlAA--.8238S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF4fZrWrZr4rtrW7Xr43KFg_yoW8Ar1DpF
        W3CF4UJw4DGwn8J3yxta48uw4Y9Fn8J3W2van3GrW3C3WUXr4kXw10vw4xXF4Y9r1fKw4r
        ZFZYgF15KFyUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When update the latest kernel on LoongArch, and then use lscpu command
to show cpuinfo, we can not see "Model name" and "CPU family", this is
because there are no matched patterns in /proc/cpuinfo, use small letter
of "Model Name" and "CPU Family" in show_cpuinfo() to fix it.

Here is the related code of lscpu:

static const struct cpuinfo_pattern type_patterns[] =
{
...
        DEF_PAT_CPUTYPE( "cpu family",          PAT_FAMILY,     family),
...
        DEF_PAT_CPUTYPE( "model name",          PAT_MODEL_NAME, modelname),
...
};

Link: https://github.com/util-linux/util-linux/blob/master/sys-utils/lscpu-cputype.c
Fixes: 7153c3cbb5b9 ("LoongArch: Add misc common routines")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
index 5c67cc4..eafd1cf 100644
--- a/arch/loongarch/kernel/proc.c
+++ b/arch/loongarch/kernel/proc.c
@@ -49,8 +49,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
 	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
-	seq_printf(m, "CPU Family\t\t: %s\n", __cpu_family[n]);
-	seq_printf(m, "Model Name\t\t: %s\n", __cpu_full_name[n]);
+	seq_printf(m, "cpu family\t\t: %s\n", __cpu_family[n]);
+	seq_printf(m, "model name\t\t: %s\n", __cpu_full_name[n]);
 	seq_printf(m, "CPU Revision\t\t: 0x%02x\n", version);
 	seq_printf(m, "FPU Revision\t\t: 0x%02x\n", fp_version);
 	seq_printf(m, "CPU MHz\t\t\t: %llu.%02llu\n",
-- 
2.1.0

