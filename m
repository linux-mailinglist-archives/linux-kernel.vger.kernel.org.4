Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34B67FD72
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 08:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjA2Hui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 02:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjA2Huf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 02:50:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911B212AB;
        Sat, 28 Jan 2023 23:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE3360ADB;
        Sun, 29 Jan 2023 07:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F492C4339C;
        Sun, 29 Jan 2023 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674978633;
        bh=3jJqHVoeLZn0v52CVG9WHq6U+px10MUrJkpO7CMitf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HT6i3xhQx1EzQNQN3D1FXDFmvuY54Q6xkOE0bXNhgHiVHgV4jTrui/Hnzh0+/REsa
         ia/N4VfY2z8J7LJAfX1unh8ibLtqciv6eS3qZaYDSXeNXLS9zcoSuCP/XIIFUZEZls
         h1U2pyA7zNV0zAt4HxEACBDjqohjqI50wY7/K+qyvUlI5GXKTNWc32YTrxkMCaSP8Q
         TfnoAeZQNxKvuBhVFpqFS2RNviI9pY1mBK/EGB4bGDWzk1nNIQVamZBkoKbq8xeMdm
         VTjRRb3Hpqkqw458zAZ1Ok+E/BNgrCK3FNnREGngj1C4weR7FGQtY2zO/ouFY/VOzA
         uRMQLX6qHn1UQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH 1/2] docs/admin-guide/mm: remove useless markup
Date:   Sun, 29 Jan 2023 09:50:17 +0200
Message-Id: <20230129075018.207678-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230129075018.207678-1-rppt@kernel.org>
References: <20230129075018.207678-1-rppt@kernel.org>
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
 Documentation/admin-guide/mm/concepts.rst           | 13 +++++--------
 Documentation/admin-guide/mm/hugetlbpage.rst        |  4 +---
 Documentation/admin-guide/mm/idle_page_tracking.rst |  7 ++-----
 Documentation/admin-guide/mm/index.rst              |  3 +--
 Documentation/admin-guide/mm/ksm.rst                |  2 --
 Documentation/admin-guide/mm/memory-hotplug.rst     |  2 --
 Documentation/admin-guide/mm/numa_memory_policy.rst |  2 --
 Documentation/admin-guide/mm/numaperf.rst           |  2 --
 Documentation/admin-guide/mm/pagemap.rst            | 11 ++++-------
 Documentation/admin-guide/mm/shrinker_debugfs.rst   |  2 --
 Documentation/admin-guide/mm/soft-dirty.rst         |  2 --
 Documentation/admin-guide/mm/swap_numa.rst          |  2 --
 Documentation/admin-guide/mm/transhuge.rst          |  2 --
 Documentation/admin-guide/mm/userfaultfd.rst        |  2 --
 Documentation/admin-guide/mm/zswap.rst              |  2 --
 15 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/admin-guide/mm/concepts.rst
index c79f1e336222..e796b0a7e4a5 100644
--- a/Documentation/admin-guide/mm/concepts.rst
+++ b/Documentation/admin-guide/mm/concepts.rst
@@ -1,5 +1,3 @@
-.. _mm_concepts:
-
 =================
 Concepts overview
 =================
@@ -86,16 +84,15 @@ memory with the huge pages. The first one is `HugeTLB filesystem`, or
 hugetlbfs. It is a pseudo filesystem that uses RAM as its backing
 store. For the files created in this filesystem the data resides in
 the memory and mapped using huge pages. The hugetlbfs is described at
-:ref:`Documentation/admin-guide/mm/hugetlbpage.rst <hugetlbpage>`.
+Documentation/admin-guide/mm/hugetlbpage.rst.
 
 Another, more recent, mechanism that enables use of the huge pages is
 called `Transparent HugePages`, or THP. Unlike the hugetlbfs that
 requires users and/or system administrators to configure what parts of
 the system memory should and can be mapped by the huge pages, THP
 manages such mappings transparently to the user and hence the
-name. See
-:ref:`Documentation/admin-guide/mm/transhuge.rst <admin_guide_transhuge>`
-for more details about THP.
+name. See Documentation/admin-guide/mm/transhuge.rst for more details
+about THP.
 
 Zones
 =====
@@ -125,8 +122,8 @@ processor. Each bank is referred to as a `node` and for each node Linux
 constructs an independent memory management subsystem. A node has its
 own set of zones, lists of free and used pages and various statistics
 counters. You can find more details about NUMA in
-:ref:`Documentation/mm/numa.rst <numa>` and in
-:ref:`Documentation/admin-guide/mm/numa_memory_policy.rst <numa_memory_policy>`.
+Documentation/mm/numa.rst` and in
+Documentation/admin-guide/mm/numa_memory_policy.rst.
 
 Page cache
 ==========
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 19f27c0d92e0..5f9121b287d9 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -1,5 +1,3 @@
-.. _hugetlbpage:
-
 =============
 HugeTLB Pages
 =============
@@ -313,7 +311,7 @@ memory policy mode--bind, preferred, local or interleave--may be used.  The
 resulting effect on persistent huge page allocation is as follows:
 
 #. Regardless of mempolicy mode [see
-   :ref:`Documentation/admin-guide/mm/numa_memory_policy.rst <numa_memory_policy>`],
+   Documentation/admin-guide/mm/numa_memory_policy.rst],
    persistent huge pages will be distributed across the node or nodes
    specified in the mempolicy as if "interleave" had been specified.
    However, if a node in the policy does not contain sufficient contiguous
diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
index df9394fb39c2..b5a285bd73fd 100644
--- a/Documentation/admin-guide/mm/idle_page_tracking.rst
+++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
@@ -1,5 +1,3 @@
-.. _idle_page_tracking:
-
 ==================
 Idle Page Tracking
 ==================
@@ -70,9 +68,8 @@ If the tool is run initially with the appropriate option, it will mark all the
 queried pages as idle.  Subsequent runs of the tool can then show which pages have
 their idle flag cleared in the interim.
 
-See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
-information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
-``/proc/kpagecgroup``.
+See Documentation/admin-guide/mm/pagemap.rst for more information about
+``/proc/pid/pagemap``, ``/proc/kpageflags``, and ``/proc/kpagecgroup``.
 
 .. _impl_details:
 
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index d1064e0ba34a..1f883abf3f00 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -16,8 +16,7 @@ are described in Documentation/admin-guide/sysctl/vm.rst and in `man 5 proc`_.
 .. _man 5 proc: http://man7.org/linux/man-pages/man5/proc.5.html
 
 Linux memory management has its own jargon and if you are not yet
-familiar with it, consider reading
-:ref:`Documentation/admin-guide/mm/concepts.rst <mm_concepts>`.
+familiar with it, consider reading Documentation/admin-guide/mm/concepts.rst.
 
 Here we document in detail how to interact with various mechanisms in
 the Linux memory management.
diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index fb6ba2002a4b..eed51a910c94 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -1,5 +1,3 @@
-.. _admin_guide_ksm:
-
 =======================
 Kernel Samepage Merging
 =======================
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0..1b02fe5807cc 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -1,5 +1,3 @@
-.. _admin_guide_memory_hotplug:
-
 ==================
 Memory Hot(Un)Plug
 ==================
diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 5a6afecbb0d0..f5cc2a368dac 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -1,5 +1,3 @@
-.. _numa_memory_policy:
-
 ==================
 NUMA Memory Policy
 ==================
diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index 166697325947..24e63e740420 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -1,5 +1,3 @@
-.. _numaperf:
-
 =============
 NUMA Locality
 =============
diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index 6e2e416af783..1a22674ab18e 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -1,5 +1,3 @@
-.. _pagemap:
-
 =============================
 Examining Process Page Tables
 =============================
@@ -19,10 +17,10 @@ There are four components to pagemap:
     * Bits 0-4   swap type if swapped
     * Bits 5-54  swap offset if swapped
     * Bit  55    pte is soft-dirty (see
-      :ref:`Documentation/admin-guide/mm/soft-dirty.rst <soft_dirty>`)
+      Documentation/admin-guide/mm/soft-dirty.rst)
     * Bit  56    page exclusively mapped (since 4.2)
     * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
-      :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
+      Documentation/admin-guide/mm/userfaultfd.rst)
     * Bits 58-60 zero
     * Bit  61    page is file-page or shared-anon (since 3.5)
     * Bit  62    page swapped
@@ -105,8 +103,7 @@ Short descriptions to the page flags
     A compound page with order N consists of 2^N physically contiguous pages.
     A compound page with order 2 takes the form of "HTTT", where H donates its
     head page and T donates its tail page(s).  The major consumers of compound
-    pages are hugeTLB pages
-    (:ref:`Documentation/admin-guide/mm/hugetlbpage.rst <hugetlbpage>`),
+    pages are hugeTLB pages (Documentation/admin-guide/mm/hugetlbpage.rst),
     the SLUB etc.  memory allocators and various device drivers.
     However in this interface, only huge/giga pages are made visible
     to end users.
@@ -128,7 +125,7 @@ Short descriptions to the page flags
     Zero page for pfn_zero or huge_zero page.
 25 - IDLE
     The page has not been accessed since it was marked idle (see
-    :ref:`Documentation/admin-guide/mm/idle_page_tracking.rst <idle_page_tracking>`).
+    Documentation/admin-guide/mm/idle_page_tracking.rst).
     Note that this flag may be stale in case the page was accessed via
     a PTE. To make sure the flag is up-to-date one has to read
     ``/sys/kernel/mm/page_idle/bitmap`` first.
diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
index 3887f0b294fe..c582033bd113 100644
--- a/Documentation/admin-guide/mm/shrinker_debugfs.rst
+++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
@@ -1,5 +1,3 @@
-.. _shrinker_debugfs:
-
 ==========================
 Shrinker Debugfs Interface
 ==========================
diff --git a/Documentation/admin-guide/mm/soft-dirty.rst b/Documentation/admin-guide/mm/soft-dirty.rst
index cb0cfd6672fa..aeea936caa44 100644
--- a/Documentation/admin-guide/mm/soft-dirty.rst
+++ b/Documentation/admin-guide/mm/soft-dirty.rst
@@ -1,5 +1,3 @@
-.. _soft_dirty:
-
 ===============
 Soft-Dirty PTEs
 ===============
diff --git a/Documentation/admin-guide/mm/swap_numa.rst b/Documentation/admin-guide/mm/swap_numa.rst
index e0466f2db8fa..2e630627bcee 100644
--- a/Documentation/admin-guide/mm/swap_numa.rst
+++ b/Documentation/admin-guide/mm/swap_numa.rst
@@ -1,5 +1,3 @@
-.. _swap_numa:
-
 ===========================================
 Automatically bind swap device to numa node
 ===========================================
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 8ee78ec232eb..b0cc8243e093 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -1,5 +1,3 @@
-.. _admin_guide_transhuge:
-
 ============================
 Transparent Hugepage Support
 ============================
diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 83f31919ebb3..7dc823b56ca4 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -1,5 +1,3 @@
-.. _userfaultfd:
-
 ===========
 Userfaultfd
 ===========
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index f67de481c7f6..fa5f6c9c78f3 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -1,5 +1,3 @@
-.. _zswap:
-
 =====
 zswap
 =====
-- 
2.35.1

