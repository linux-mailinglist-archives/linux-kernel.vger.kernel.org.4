Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0398641CDE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLDMTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 07:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLDMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 07:19:15 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7879413F7E;
        Sun,  4 Dec 2022 04:19:12 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxSuk+kIxjLxYDAA--.4064S3;
        Sun, 04 Dec 2022 20:19:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbuA8kIxjkmMlAA--.26442S2;
        Sun, 04 Dec 2022 20:19:08 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] docs: Correct the arch name of LoongArch
Date:   Sun,  4 Dec 2022 20:18:45 +0800
Message-Id: <1670156327-9631-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxbuA8kIxjkmMlAA--.26442S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZrW7Zry8XFW7KFyxtr4ruFg_yoW5trW8pa
        s7Zrnxtrn8Ar1qk34kXFnrXF4UJa98Wa1qgr1jyw10gF4kCF13Aa1ayFs8Z3Z5XrWxXFW8
        Wrs2qryYyF1UA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on git.lwn.net/linux.git docs-next

Tiezhu Yang (2):
  Documentation/features-refresh.sh: Only sed the beginning "arch" of
    ARCH_DIR
  Documentation/features: Use loongarch instead of loong

 Documentation/features/core/cBPF-JIT/arch-support.txt              | 2 +-
 Documentation/features/core/eBPF-JIT/arch-support.txt              | 2 +-
 Documentation/features/core/generic-idle-thread/arch-support.txt   | 2 +-
 Documentation/features/core/jump-labels/arch-support.txt           | 2 +-
 Documentation/features/core/thread-info-in-task/arch-support.txt   | 2 +-
 Documentation/features/core/tracehook/arch-support.txt             | 2 +-
 Documentation/features/debug/KASAN/arch-support.txt                | 2 +-
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt     | 2 +-
 Documentation/features/debug/gcov-profile-all/arch-support.txt     | 2 +-
 Documentation/features/debug/kcov/arch-support.txt                 | 2 +-
 Documentation/features/debug/kgdb/arch-support.txt                 | 2 +-
 Documentation/features/debug/kmemleak/arch-support.txt             | 2 +-
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt    | 2 +-
 Documentation/features/debug/kprobes/arch-support.txt              | 2 +-
 Documentation/features/debug/kretprobes/arch-support.txt           | 2 +-
 Documentation/features/debug/optprobes/arch-support.txt            | 2 +-
 Documentation/features/debug/stackprotector/arch-support.txt       | 2 +-
 Documentation/features/debug/uprobes/arch-support.txt              | 2 +-
 Documentation/features/debug/user-ret-profiler/arch-support.txt    | 2 +-
 Documentation/features/io/dma-contiguous/arch-support.txt          | 2 +-
 Documentation/features/locking/cmpxchg-local/arch-support.txt      | 2 +-
 Documentation/features/locking/lockdep/arch-support.txt            | 2 +-
 Documentation/features/locking/queued-rwlocks/arch-support.txt     | 2 +-
 Documentation/features/locking/queued-spinlocks/arch-support.txt   | 2 +-
 Documentation/features/perf/kprobes-event/arch-support.txt         | 2 +-
 Documentation/features/perf/perf-regs/arch-support.txt             | 2 +-
 Documentation/features/perf/perf-stackdump/arch-support.txt        | 2 +-
 Documentation/features/sched/membarrier-sync-core/arch-support.txt | 2 +-
 Documentation/features/sched/numa-balancing/arch-support.txt       | 2 +-
 Documentation/features/scripts/features-refresh.sh                 | 2 +-
 Documentation/features/seccomp/seccomp-filter/arch-support.txt     | 2 +-
 Documentation/features/time/arch-tick-broadcast/arch-support.txt   | 2 +-
 Documentation/features/time/clockevents/arch-support.txt           | 2 +-
 Documentation/features/time/context-tracking/arch-support.txt      | 2 +-
 Documentation/features/time/irq-time-acct/arch-support.txt         | 2 +-
 Documentation/features/time/virt-cpuacct/arch-support.txt          | 2 +-
 Documentation/features/vm/ELF-ASLR/arch-support.txt                | 2 +-
 Documentation/features/vm/PG_uncached/arch-support.txt             | 2 +-
 Documentation/features/vm/THP/arch-support.txt                     | 2 +-
 Documentation/features/vm/TLB/arch-support.txt                     | 2 +-
 Documentation/features/vm/huge-vmap/arch-support.txt               | 2 +-
 Documentation/features/vm/ioremap_prot/arch-support.txt            | 2 +-
 Documentation/features/vm/pte_special/arch-support.txt             | 2 +-
 43 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.1.0

