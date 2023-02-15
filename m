Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486169796F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjBOKAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjBOKAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:00:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202834F77;
        Wed, 15 Feb 2023 02:00:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB8DB820D3;
        Wed, 15 Feb 2023 10:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C52C433EF;
        Wed, 15 Feb 2023 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676455228;
        bh=mDiRor3E4ZX33EM7RX0jdS9MVO0pkbLsViLQbVngh98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yi2W4qujXQ5grfXuo0aJ0p0hJDBynwr6MVgdwIS220XMQOJQBmRUeioQadBQttZrj
         rn5OVhQaXwtHit+GHaqO1+89b1bc5XyRwJNYtmYW0hMx60kas5QKtRpiZZ/Cnz4G3o
         RtIK72KEpA+SbARqdaIZuH9psbzKcPAUT/50wxwQp/TmvYUr2bcw8uMwxrnQe6IwSr
         hFSBqg0vl7xLJCoR+uashZLIyLMrLLTWMBiwlG+BytGBl+XAqi44wGRwhvMcuXHjA+
         LcG3UFtJDf/J2PcmUxZmgNn/4CXMjBcU254pBHUPTjzmiB6kAoRBm2zsPDQJVayarH
         jiqZWOMYniFWw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: [RFC PATCH 3/5] Documentation: Drop IA64 from feature descriptions
Date:   Wed, 15 Feb 2023 11:00:06 +0100
Message-Id: <20230215100008.2565237-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215100008.2565237-1-ardb@kernel.org>
References: <20230215100008.2565237-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25995; i=ardb@kernel.org; h=from:subject; bh=mDiRor3E4ZX33EM7RX0jdS9MVO0pkbLsViLQbVngh98=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj7K0VLF412T83OsjWL0xLWEkk2zLqt6241Jrnc qfo+7MsEG6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+ytFQAKCRDDTyI5ktmP JGx/C/9I45h85fYxgtmTpgPgawuP7F4jUCshCoRvZ9F1v5Zn13TnLrzts/MX4blR1EZ3/kzFS9p IFXX/dmSJccZ6DaA0uQ8DdIfySIVmAzi6X64nU0xhPEVf3DLikcCP5+86ZLkGb3gzjr2XovHRyH jqqqUAGh8EEDCATAu8yscJTrPR50JkxCuK6jlLgHgxABGXiOHra3Rk0yQdPiRILBCjjYgTgLupz F0yJdhsNOBRiCSDXcMi2UTOhw8dvjM4LZ/eWxHygzvSzJSxKHvTeybwbEOqooCn8w59AYI9gDMF yEEThC9iitkYbkszK57Sn1cBHTGFMNOsQJlbRw+mCu7uEDi8aB7kx7k4x6Epw11PBHuv96s9m8p dO7yq+7vETsxVps3JIeeNK19K4Xwyi7um7XISu4MqZRiPOdS7Szte1YAYReY7RFz5Arz9t2rKML VIgZVKlN6J20AgBbwoakZnoCiplTlcY7PaYV3oXT2Vio6Sycab56A6V4+E0WGSdwRtRX0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Itanium (IA64) is going away, so drop it from the kernel feature
documentation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/features/core/cBPF-JIT/arch-support.txt              | 1 -
 Documentation/features/core/eBPF-JIT/arch-support.txt              | 1 -
 Documentation/features/core/generic-idle-thread/arch-support.txt   | 1 -
 Documentation/features/core/jump-labels/arch-support.txt           | 1 -
 Documentation/features/core/thread-info-in-task/arch-support.txt   | 1 -
 Documentation/features/core/tracehook/arch-support.txt             | 1 -
 Documentation/features/debug/KASAN/arch-support.txt                | 1 -
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt     | 1 -
 Documentation/features/debug/gcov-profile-all/arch-support.txt     | 1 -
 Documentation/features/debug/kcov/arch-support.txt                 | 1 -
 Documentation/features/debug/kgdb/arch-support.txt                 | 1 -
 Documentation/features/debug/kmemleak/arch-support.txt             | 1 -
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt    | 1 -
 Documentation/features/debug/kprobes/arch-support.txt              | 1 -
 Documentation/features/debug/kretprobes/arch-support.txt           | 1 -
 Documentation/features/debug/optprobes/arch-support.txt            | 1 -
 Documentation/features/debug/stackprotector/arch-support.txt       | 1 -
 Documentation/features/debug/uprobes/arch-support.txt              | 1 -
 Documentation/features/debug/user-ret-profiler/arch-support.txt    | 1 -
 Documentation/features/io/dma-contiguous/arch-support.txt          | 1 -
 Documentation/features/locking/cmpxchg-local/arch-support.txt      | 1 -
 Documentation/features/locking/lockdep/arch-support.txt            | 1 -
 Documentation/features/locking/queued-rwlocks/arch-support.txt     | 1 -
 Documentation/features/locking/queued-spinlocks/arch-support.txt   | 1 -
 Documentation/features/perf/kprobes-event/arch-support.txt         | 1 -
 Documentation/features/perf/perf-regs/arch-support.txt             | 1 -
 Documentation/features/perf/perf-stackdump/arch-support.txt        | 1 -
 Documentation/features/sched/membarrier-sync-core/arch-support.txt | 1 -
 Documentation/features/sched/numa-balancing/arch-support.txt       | 1 -
 Documentation/features/seccomp/seccomp-filter/arch-support.txt     | 1 -
 Documentation/features/time/arch-tick-broadcast/arch-support.txt   | 1 -
 Documentation/features/time/clockevents/arch-support.txt           | 1 -
 Documentation/features/time/context-tracking/arch-support.txt      | 1 -
 Documentation/features/time/irq-time-acct/arch-support.txt         | 1 -
 Documentation/features/time/virt-cpuacct/arch-support.txt          | 1 -
 Documentation/features/vm/ELF-ASLR/arch-support.txt                | 1 -
 Documentation/features/vm/PG_uncached/arch-support.txt             | 1 -
 Documentation/features/vm/THP/arch-support.txt                     | 1 -
 Documentation/features/vm/TLB/arch-support.txt                     | 1 -
 Documentation/features/vm/huge-vmap/arch-support.txt               | 1 -
 Documentation/features/vm/ioremap_prot/arch-support.txt            | 1 -
 Documentation/features/vm/pte_special/arch-support.txt             | 1 -
 42 files changed, 42 deletions(-)

diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index 0a1f5bb7eeb9a63a..937840080de718cd 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: | TODO |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index 6c0f3d759e6a0b2e..7434b43c2ff8727f 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 0b94099cf6aca230..0735cb5367b4b179 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: |  ok  |
-    |        ia64: |  ok  |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 2328eada3a491a4d..f1921393981c6e4c 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
index 9c5d39eebef21520..89a9f69ff9fdbc60 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index aed5679da651cad2..a72330e2554245c2 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: |  ok  |
-    |        ia64: |  ok  |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index bf0124fae643a1bb..83633c583104774a 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 9ec5d13f4939c6b3..bbf029f095cb57eb 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index dc4014f7e1f8ad77..63494bddc2638e13 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
diff --git a/Documentation/features/debug/kcov/arch-support.txt b/Documentation/features/debug/kcov/arch-support.txt
index ffcc9f2b1d74d393..cdeace38aa9775b3 100644
--- a/Documentation/features/debug/kcov/arch-support.txt
+++ b/Documentation/features/debug/kcov/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 958498f9f2a41f2b..9c7e23d574ef4c05 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: |  ok  |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
diff --git a/Documentation/features/debug/kmemleak/arch-support.txt b/Documentation/features/debug/kmemleak/arch-support.txt
index 0cfa5f0e4db15230..1fa8bd638716979e 100644
--- a/Documentation/features/debug/kmemleak/arch-support.txt
+++ b/Documentation/features/debug/kmemleak/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index bcc29d3aba9ad884..9343ec9347b7148f 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: | TODO |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 8a77d62a42c59b81..4bf01cc4e023be0a 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: |  ok  |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index cf4723c5ac55df9c..0493d0b07ea4b496 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: |  ok  |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 83a4639a5c0a15aa..92f5d0f444faa554 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: | TODO |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 71cd4ba18f7df6b0..8919efaeef989c59 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index d53f2f94fbda5fda..6f8296c0dbbee1db 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 059110a5fa6eb9cc..3e431767581d1f33 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: | TODO |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index bfe0921a3853ad6c..3c6ce35d704f97f4 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 68329e96dffad2d0..2c3a4b91f16df341 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index ddb945278589e1d8..4d9c5306f72f1c71 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: |  ok  |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 5deb845477e4909a..b286a5fff283be7b 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 2d3961bfef5d666e..22f2990392ff8f5c 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 641a7d2ff2a3cacb..713a69fcd697bd70 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: |  ok  |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 33866eb242c18b27..09431518b0e858ee 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index c8e4c7c65012c1b3..f9db4dd8ef79a1be 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 1e51614c136eb6e2..c7e41e91559fd144 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -35,7 +35,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 532cc67cdf921784..984601c7c479dabf 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ..  |
     |     hexagon: |  ..  |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index dc71bf7b1a7ef333..1c2067944a64c9c6 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 9bffac80019e990a..ccba965e8d07178b 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 625160048f68f012..4d4bfac529701f11 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: |  ok  |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 72bc5bad0348cae0..891be9f619030293 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index ceb036610d09bdba..3d10075a8a8a4ab1 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: |  ..  |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index c063dffd5261dce0..21f11d47ef722c56 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
-    |        ia64: |  ok  |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 15164f36f2240816..ad0180c3b75f58ec 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 5acd64b97dba5cfb..5a7508b8c967e2fc 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: | TODO |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: |  ok  |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 9dd7d75d04653ebf..b4a5ce16940dfd3d 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: |  ..  |
     |     hexagon: |  ..  |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 7f049c251a79e4c0..e83b49d2d7563f65 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: | N/A  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 34647d9bdca46e2c..2d6de7b045385db1 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index a24149e59d73e492..1638c2cb17f15cb2 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index d2b22a06945e7526..3f777f8b67d539c2 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -12,7 +12,6 @@
     |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
-    |        ia64: | TODO |
     |   loongarch: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
-- 
2.39.1

