Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D662257C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKIIaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKIIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:30:19 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA37422B04;
        Wed,  9 Nov 2022 00:29:19 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_7fVZGtjdYEFAA--.16102S3;
        Wed, 09 Nov 2022 16:29:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtuPTZGtjJnIPAA--.42697S3;
        Wed, 09 Nov 2022 16:29:08 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v4 1/4] tools x86: Keep list sorted by number in unistd_{32,64}.h
Date:   Wed,  9 Nov 2022 16:29:04 +0800
Message-Id: <1667982547-22331-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
References: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxtuPTZGtjJnIPAA--.42697S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7AFyxurWrZw4Utr1rXw1kZrb_yoW8uF4fpF
        ykCrWDta15KFWag34SyF18Gw17CFZ7ZrW8KFy5W3s5ZFySqw1xXr1xursxCryUXw4vya4U
        Xa1xZw47WasrXw7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to keep list sorted by number in unistd_{32,64}.h,
so that we can add more syscall number to a proper position.

This is preparation for later patch, no functionality change.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h | 16 ++++++++--------
 tools/arch/x86/include/uapi/asm/unistd_64.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 60a89db..e1cc62d 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_perf_event_open
-# define __NR_perf_event_open 336
+#ifndef __NR_gettid
+#define __NR_gettid 224
 #endif
 #ifndef __NR_futex
-# define __NR_futex 240
-#endif
-#ifndef __NR_gettid
-# define __NR_gettid 224
+#define __NR_futex 240
 #endif
 #ifndef __NR_getcpu
-# define __NR_getcpu 318
+#define __NR_getcpu 318
+#endif
+#ifndef __NR_perf_event_open
+#define __NR_perf_event_open 336
 #endif
 #ifndef __NR_setns
-# define __NR_setns 346
+#define __NR_setns 346
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index cb52a3a..ce8b7ab 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_perf_event_open
-# define __NR_perf_event_open 298
+#ifndef __NR_gettid
+#define __NR_gettid 186
 #endif
 #ifndef __NR_futex
-# define __NR_futex 202
-#endif
-#ifndef __NR_gettid
-# define __NR_gettid 186
+#define __NR_futex 202
 #endif
-#ifndef __NR_getcpu
-# define __NR_getcpu 309
+#ifndef __NR_perf_event_open
+#define __NR_perf_event_open 298
 #endif
 #ifndef __NR_setns
 #define __NR_setns 308
 #endif
+#ifndef __NR_getcpu
+#define __NR_getcpu 309
+#endif
-- 
2.1.0

