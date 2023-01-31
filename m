Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961BD682F87
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjAaOmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjAaOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:42:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CD4E513;
        Tue, 31 Jan 2023 06:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C134B81CE3;
        Tue, 31 Jan 2023 14:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81245C433EF;
        Tue, 31 Jan 2023 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675176157;
        bh=xo0XfQEBGUn7tJDASw7xd+ynPvHY4wSjZm8sVyCBFCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KA1H6byLK98UIQ3k3oX2usRM/NHECqoRq6foPQdeaKQIJbkkHiFCv6UPaI0zzVbrv
         HRf6EQJyWeHXEzlNJOFv5GztlBnqVldIF/MdHYvQ5YVhSYe0XdeoAwxPsscsDNsbmE
         TQAaKte3i5SBBW6K87PXJsCnBiMqqs0varV0be45yAL9c3XrHXXXdMCDNhjLEPHT/+
         Onf9YTskmo2r39dLNWxqG8WBcKLbHwePiThoBy9oFB7yfnIxVObRM4GI2nUkmL7D4N
         46hGF9SKfJLVlZLXbhY8Z3Ob8VQCaal1kv8mJ77nLezlVa2fRpywToMhmyfEldZMUJ
         KVu3RDI6QWldw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/2] docs/mm: remove useless markup
Date:   Tue, 31 Jan 2023 16:42:20 +0200
Message-Id: <20230131144220.822989-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230131144220.822989-1-rppt@kernel.org>
References: <20230131144220.822989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

It is enough to use a file name to cross-reference another rst document.

Jon says:
  The right things will happen in the HTML output, readers of the
  plain-text will know immediately where to go, and we don't have to add
  the label clutter.

Drop reference markup and unnecessary labels and use plain file names.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/mm/active_mm.rst             | 2 --
 Documentation/mm/arch_pgtable_helpers.rst  | 2 --
 Documentation/mm/balance.rst               | 2 --
 Documentation/mm/free_page_reporting.rst   | 2 --
 Documentation/mm/frontswap.rst             | 2 --
 Documentation/mm/highmem.rst               | 2 --
 Documentation/mm/hmm.rst                   | 4 +---
 Documentation/mm/hugetlbfs_reserv.rst      | 4 +---
 Documentation/mm/hwpoison.rst              | 2 --
 Documentation/mm/ksm.rst                   | 4 +---
 Documentation/mm/memory-model.rst          | 2 --
 Documentation/mm/mmu_notifier.rst          | 2 --
 Documentation/mm/numa.rst                  | 4 +---
 Documentation/mm/page_frags.rst            | 2 --
 Documentation/mm/page_migration.rst        | 6 ++----
 Documentation/mm/page_owner.rst            | 2 --
 Documentation/mm/page_table_check.rst      | 2 --
 Documentation/mm/remap_file_pages.rst      | 2 --
 Documentation/mm/slub.rst                  | 2 --
 Documentation/mm/split_page_table_lock.rst | 2 --
 Documentation/mm/transhuge.rst             | 2 --
 Documentation/mm/unevictable-lru.rst       | 2 --
 Documentation/mm/z3fold.rst                | 2 --
 Documentation/mm/zsmalloc.rst              | 2 --
 24 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/Documentation/mm/active_mm.rst b/Documentation/mm/active_mm.rst
index 6f8269c284ed..45d89f8fb3a8 100644
--- a/Documentation/mm/active_mm.rst
+++ b/Documentation/mm/active_mm.rst
@@ -1,5 +1,3 @@
-.. _active_mm:
-
 =========
 Active MM
 =========
diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index fd2a19df884e..30d9a09f01f4 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -1,7 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. _arch_page_table_helpers:
-
 ===============================
 Architecture Page Table Helpers
 ===============================
diff --git a/Documentation/mm/balance.rst b/Documentation/mm/balance.rst
index 6a1fadf3e173..6cd0127154ac 100644
--- a/Documentation/mm/balance.rst
+++ b/Documentation/mm/balance.rst
@@ -1,5 +1,3 @@
-.. _balance:
-
 ================
 Memory Balancing
 ================
diff --git a/Documentation/mm/free_page_reporting.rst b/Documentation/mm/free_page_reporting.rst
index 8c05e62d8b2b..1468f71c261f 100644
--- a/Documentation/mm/free_page_reporting.rst
+++ b/Documentation/mm/free_page_reporting.rst
@@ -1,5 +1,3 @@
-.. _free_page_reporting:
-
 =====================
 Free Page Reporting
 =====================
diff --git a/Documentation/mm/frontswap.rst b/Documentation/mm/frontswap.rst
index feecc5e24477..c892412988af 100644
--- a/Documentation/mm/frontswap.rst
+++ b/Documentation/mm/frontswap.rst
@@ -1,5 +1,3 @@
-.. _frontswap:
-
 =========
 Frontswap
 =========
diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index 0f731d9196b0..bb3f90e195fa 100644
--- a/Documentation/mm/highmem.rst
+++ b/Documentation/mm/highmem.rst
@@ -1,5 +1,3 @@
-.. _highmem:
-
 ====================
 High Memory Handling
 ====================
diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index f2a59ed82ed3..9aa512c3a12c 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -1,5 +1,3 @@
-.. _hmm:
-
 =====================================
 Heterogeneous Memory Management (HMM)
 =====================================
@@ -304,7 +302,7 @@ devm_memunmap_pages(), and devm_release_mem_region() when the resources can
 be tied to a ``struct device``.
 
 The overall migration steps are similar to migrating NUMA pages within system
-memory (see :ref:`Page migration <page_migration>`) but the steps are split
+memory (see Documentation/mm/page_migration.rst) but the steps are split
 between device driver specific code and shared common code:
 
 1. ``mmap_read_lock()``
diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
index f143954e0d05..05a44760da32 100644
--- a/Documentation/mm/hugetlbfs_reserv.rst
+++ b/Documentation/mm/hugetlbfs_reserv.rst
@@ -1,5 +1,3 @@
-.. _hugetlbfs_reserve:
-
 =====================
 Hugetlbfs Reservation
 =====================
@@ -7,7 +5,7 @@ Hugetlbfs Reservation
 Overview
 ========
 
-Huge pages as described at :ref:`hugetlbpage` are typically
+Huge pages as described at Documentation/mm/hugetlbpage.rst are typically
 preallocated for application use.  These huge pages are instantiated in a
 task's address space at page fault time if the VMA indicates huge pages are
 to be used.  If no huge page exists at page fault time, the task is sent
diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
index b9d5253c1305..ba48a441feed 100644
--- a/Documentation/mm/hwpoison.rst
+++ b/Documentation/mm/hwpoison.rst
@@ -1,5 +1,3 @@
-.. hwpoison:
-
 ========
 hwpoison
 ========
diff --git a/Documentation/mm/ksm.rst b/Documentation/mm/ksm.rst
index f83cfbc12f4c..2806e3e4a10e 100644
--- a/Documentation/mm/ksm.rst
+++ b/Documentation/mm/ksm.rst
@@ -1,5 +1,3 @@
-.. _ksm:
-
 =======================
 Kernel Samepage Merging
 =======================
@@ -8,7 +6,7 @@ KSM is a memory-saving de-duplication feature, enabled by CONFIG_KSM=y,
 added to the Linux kernel in 2.6.32.  See ``mm/ksm.c`` for its implementation,
 and http://lwn.net/Articles/306704/ and https://lwn.net/Articles/330589/
 
-The userspace interface of KSM is described in :ref:`Documentation/admin-guide/mm/ksm.rst <admin_guide_ksm>`
+The userspace interface of KSM is described in Documentation/admin-guide/mm/ksm.rst
 
 Design
 ======
diff --git a/Documentation/mm/memory-model.rst b/Documentation/mm/memory-model.rst
index 3779e562dc76..5f3eafbbc520 100644
--- a/Documentation/mm/memory-model.rst
+++ b/Documentation/mm/memory-model.rst
@@ -1,7 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. _physical_memory_model:
-
 =====================
 Physical Memory Model
 =====================
diff --git a/Documentation/mm/mmu_notifier.rst b/Documentation/mm/mmu_notifier.rst
index df5d7777fc6b..c687bea4922f 100644
--- a/Documentation/mm/mmu_notifier.rst
+++ b/Documentation/mm/mmu_notifier.rst
@@ -1,5 +1,3 @@
-.. _mmu_notifier:
-
 When do you need to notify inside page table lock ?
 ===================================================
 
diff --git a/Documentation/mm/numa.rst b/Documentation/mm/numa.rst
index 99fdeca917ca..04648d26ffd1 100644
--- a/Documentation/mm/numa.rst
+++ b/Documentation/mm/numa.rst
@@ -1,5 +1,3 @@
-.. _numa:
-
 Started Nov 1999 by Kanoj Sarcar <kanoj@sgi.com>
 
 =============
@@ -110,7 +108,7 @@ to improve NUMA locality using various CPU affinity command line interfaces,
 such as taskset(1) and numactl(1), and program interfaces such as
 sched_setaffinity(2).  Further, one can modify the kernel's default local
 allocation behavior using Linux NUMA memory policy. [see
-:ref:`Documentation/admin-guide/mm/numa_memory_policy.rst <numa_memory_policy>`].
+Documentation/admin-guide/mm/numa_memory_policy.rst].
 
 System administrators can restrict the CPUs and nodes' memories that a non-
 privileged user can specify in the scheduling or NUMA commands and functions
diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 7d6f9385d129..a81617e688a8 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -1,5 +1,3 @@
-.. _page_frags:
-
 ==============
 Page fragments
 ==============
diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
index 11493bad7112..313dce18893e 100644
--- a/Documentation/mm/page_migration.rst
+++ b/Documentation/mm/page_migration.rst
@@ -1,5 +1,3 @@
-.. _page_migration:
-
 ==============
 Page migration
 ==============
@@ -9,8 +7,8 @@ nodes in a NUMA system while the process is running. This means that the
 virtual addresses that the process sees do not change. However, the
 system rearranges the physical location of those pages.
 
-Also see :ref:`Heterogeneous Memory Management (HMM) <hmm>`
-for migrating pages to or from device private memory.
+Also see Documentation/mm/hmm.rst for migrating pages to or from device
+private memory.
 
 The main intent of page migration is to reduce the latency of memory accesses
 by moving pages near to the processor where the process accessing that memory
diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index 127514955a5e..fc8b5f2ef173 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -1,5 +1,3 @@
-.. _page_owner:
-
 ==================================================
 page owner: Tracking about who allocated each page
 ==================================================
diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
index 1a09472f10a3..cfd8f4117cf3 100644
--- a/Documentation/mm/page_table_check.rst
+++ b/Documentation/mm/page_table_check.rst
@@ -1,7 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. _page_table_check:
-
 ================
 Page Table Check
 ================
diff --git a/Documentation/mm/remap_file_pages.rst b/Documentation/mm/remap_file_pages.rst
index 7bef6718e3a9..297091ce257c 100644
--- a/Documentation/mm/remap_file_pages.rst
+++ b/Documentation/mm/remap_file_pages.rst
@@ -1,5 +1,3 @@
-.. _remap_file_pages:
-
 ==============================
 remap_file_pages() system call
 ==============================
diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index 7f652216dabe..fa01cdfd7d3a 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -1,5 +1,3 @@
-.. _slub:
-
 ==========================
 Short users guide for SLUB
 ==========================
diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
index c08919662704..50ee0dfc95be 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -1,5 +1,3 @@
-.. _split_page_table_lock:
-
 =====================
 Split page table lock
 =====================
diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index ec3dc5b04226..9d924b651c61 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -1,5 +1,3 @@
-.. _transhuge:
-
 ============================
 Transparent Hugepage Support
 ============================
diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 4a0e158aa9ce..b5dc98cd1ba8 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -1,5 +1,3 @@
-.. _unevictable_lru:
-
 ==============================
 Unevictable LRU Infrastructure
 ==============================
diff --git a/Documentation/mm/z3fold.rst b/Documentation/mm/z3fold.rst
index 224e3c61d686..25b5935d06c7 100644
--- a/Documentation/mm/z3fold.rst
+++ b/Documentation/mm/z3fold.rst
@@ -1,5 +1,3 @@
-.. _z3fold:
-
 ======
 z3fold
 ======
diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index 6e79893d6132..24616a7c115a 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -1,5 +1,3 @@
-.. _zsmalloc:
-
 ========
 zsmalloc
 ========
-- 
2.35.1

