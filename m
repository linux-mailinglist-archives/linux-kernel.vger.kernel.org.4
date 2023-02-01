Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4429268630A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBAJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjBAJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:42:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE1B5DC3B;
        Wed,  1 Feb 2023 01:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C831DB820FE;
        Wed,  1 Feb 2023 09:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83425C4339B;
        Wed,  1 Feb 2023 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675244533;
        bh=8IL9177iDUVTWFImzws1ExqCOazIxjzkkyC9YYfBRkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iU9nXthCQy5DSIoAsDMUqqx2TxVBB0dEVwVfGQ8mo1Ni7VCMOR2iYF5xFs3VCWQIz
         lpwHrePy/OJeeHkNyh8DzKVBFlPx/6RLSm2+R2bHGvuXXOuIABzg/+LfbA9FCfaaaW
         Eu8LFJXW2vGNG40TodVS64V9m+jKO2Ni1SR5SMJ+tPC1xRml2j2GzW/KDPavIyq7VP
         R+8xzy0OmwJ5qbeJz5boOYtHgsThIpgPyzqxQfQvmU++4tKIAGAB4kmPPBmFELclLk
         pTl5R59uW/S679/UNbKyyCxooBOIPmnTgSa/6wRhCrVJ98Fcm0STPraGzAu2adWZIk
         MUYa1bNiL82Bg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 2/3] docs/mm: remove useless markup
Date:   Wed,  1 Feb 2023 11:41:55 +0200
Message-Id: <20230201094156.991542-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230201094156.991542-1-rppt@kernel.org>
References: <20230201094156.991542-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 Documentation/mm/active_mm.rst                           | 2 --
 Documentation/mm/arch_pgtable_helpers.rst                | 2 --
 Documentation/mm/balance.rst                             | 2 --
 Documentation/mm/free_page_reporting.rst                 | 2 --
 Documentation/mm/frontswap.rst                           | 2 --
 Documentation/mm/highmem.rst                             | 2 --
 Documentation/mm/hmm.rst                                 | 4 +---
 Documentation/mm/hugetlbfs_reserv.rst                    | 4 +---
 Documentation/mm/hwpoison.rst                            | 2 --
 Documentation/mm/ksm.rst                                 | 4 +---
 Documentation/mm/memory-model.rst                        | 2 --
 Documentation/mm/mmu_notifier.rst                        | 2 --
 Documentation/mm/numa.rst                                | 4 +---
 Documentation/mm/page_frags.rst                          | 2 --
 Documentation/mm/page_migration.rst                      | 6 ++----
 Documentation/mm/page_owner.rst                          | 2 --
 Documentation/mm/page_table_check.rst                    | 2 --
 Documentation/mm/remap_file_pages.rst                    | 2 --
 Documentation/mm/slub.rst                                | 2 --
 Documentation/mm/split_page_table_lock.rst               | 2 --
 Documentation/mm/transhuge.rst                           | 2 --
 Documentation/mm/unevictable-lru.rst                     | 2 --
 Documentation/mm/z3fold.rst                              | 2 --
 Documentation/mm/zsmalloc.rst                            | 2 --
 Documentation/translations/zh_CN/mm/hmm.rst              | 2 +-
 Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst | 2 +-
 Documentation/translations/zh_CN/mm/numa.rst             | 2 +-
 27 files changed, 9 insertions(+), 57 deletions(-)

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
index e1410974c941..0f1b56809dca 100644
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
index 0f4cb59bcaf4..e8d5090a9e6b 100644
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
diff --git a/Documentation/translations/zh_CN/mm/hmm.rst b/Documentation/translations/zh_CN/mm/hmm.rst
index 5024a8a15516..babbbe756c0f 100644
--- a/Documentation/translations/zh_CN/mm/hmm.rst
+++ b/Documentation/translations/zh_CN/mm/hmm.rst
@@ -248,7 +248,7 @@ migrate_vma_finalize() 函数旨在使驱动程序更易于编写并集中跨驱
 还有devm_request_free_mem_region(), devm_memremap_pages(),
 devm_memunmap_pages() 和 devm_release_mem_region() 当资源可以绑定到 ``struct device``.
 
-整体迁移步骤类似于在系统内存中迁移 NUMA 页面(see :ref:`Page migration <page_migration>`) ，
+整体迁移步骤类似于在系统内存中迁移 NUMA 页面(see Documentation/mm/page_migration.rst) ，
 但这些步骤分为设备驱动程序特定代码和共享公共代码:
 
 1. ``mmap_read_lock()``
diff --git a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
index 752e5696cd47..80787af29222 100644
--- a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
+++ b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
@@ -15,7 +15,7 @@ Hugetlbfs 预留
 概述
 ====
 
-:ref:`hugetlbpage` 中描述的巨页通常是预先分配给应用程序使用的。如果VMA指
+Documentation/mm/hugetlbpage.rst 中描述的巨页通常是预先分配给应用程序使用的。如果VMA指
 示要使用巨页，这些巨页会在缺页异常时被实例化到任务的地址空间。如果在缺页异常
 时没有巨页存在，任务就会被发送一个SIGBUS，并经常不高兴地死去。在加入巨页支
 持后不久，人们决定，在mmap()时检测巨页的短缺情况会更好。这个想法是，如果
diff --git a/Documentation/translations/zh_CN/mm/numa.rst b/Documentation/translations/zh_CN/mm/numa.rst
index b15cfeeb6dfb..61fad89272fa 100644
--- a/Documentation/translations/zh_CN/mm/numa.rst
+++ b/Documentation/translations/zh_CN/mm/numa.rst
@@ -76,7 +76,7 @@ Linux将系统的硬件资源划分为多个软件抽象，称为“节点”。
 系统管理员和应用程序设计者可以使用各种CPU亲和命令行接口，如taskset(1)和numactl(1)，以及程
 序接口，如sched_setaffinity(2)，来限制任务的迁移，以改善NUMA定位。此外，人们可以使用
 Linux NUMA内存策略修改内核的默认本地分配行为。 [见
-:ref:`Documentation/admin-guide/mm/numa_memory_policy.rst <numa_memory_policy>`].
+Documentation/admin-guide/mm/numa_memory_policy.rst].
 
 系统管理员可以使用控制组和CPUsets限制非特权用户在调度或NUMA命令和功能中可以指定的CPU和节点
 的内存。 [见 Documentation/admin-guide/cgroup-v1/cpusets.rst]
-- 
2.35.1

