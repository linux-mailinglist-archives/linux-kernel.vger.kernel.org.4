Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F3565C5BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbjACSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjACSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:08:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECF11183E;
        Tue,  3 Jan 2023 10:08:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D236A614C6;
        Tue,  3 Jan 2023 18:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA687C4339B;
        Tue,  3 Jan 2023 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769282;
        bh=rnmBsFuUSLudytnhsoqP0P88PgJIqLj22g/9l6kDmp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBpRuw3EasDD1MsN9xNfHnof3lqVUtDZ6Q5fqulIxjf2w5d77F2y9NmFOum/Sflpt
         cptwyYeAL36RX455MQktiHVEDt7dBn1jbBGhJdHWoWh5FMKhb+gzwWfSR1WfqdfJhF
         uBZhBevPZ0sdyz5KxlnwbHmzPqRwW4TqtH4LNPXgQqU+SUv6DVFnued4+1yaB8+IAN
         aCN0t6yG8fURILAOGxlM3Px5+pd+LS/29C5p2BuOtqpFv6/LijsxjP9AZd+ZyWWmqP
         Td4HpT6Pq97SeG/iy8X5QXjBYlgMzErf1d3aNpxvaXICUU3FQ4uMyX/EI1IAwCfVfC
         GR4ZdVLJF0sVw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] tools/vm: rename tools/vm to tools/mm
Date:   Tue,  3 Jan 2023 18:07:52 +0000
Message-Id: <20230103180754.129637-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103180754.129637-1-sj@kernel.org>
References: <20230103180754.129637-1-sj@kernel.org>
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

Rename tools/vm to tools/mm for being more consistent with the code and
documentation directories, and won't be confused with virtual machines.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/idle_page_tracking.rst | 2 +-
 Documentation/admin-guide/mm/pagemap.rst            | 4 ++--
 Documentation/mm/page_owner.rst                     | 2 +-
 Documentation/mm/slub.rst                           | 2 +-
 Documentation/translations/zh_CN/mm/page_owner.rst  | 2 +-
 MAINTAINERS                                         | 2 +-
 mm/Kconfig.debug                                    | 2 +-
 mm/memory-failure.c                                 | 2 +-
 tools/{vm => mm}/.gitignore                         | 0
 tools/{vm => mm}/Makefile                           | 0
 tools/{vm => mm}/page-types.c                       | 0
 tools/{vm => mm}/page_owner_sort.c                  | 0
 tools/{vm => mm}/slabinfo-gnuplot.sh                | 0
 tools/{vm => mm}/slabinfo.c                         | 0
 14 files changed, 9 insertions(+), 9 deletions(-)
 rename tools/{vm => mm}/.gitignore (100%)
 rename tools/{vm => mm}/Makefile (100%)
 rename tools/{vm => mm}/page-types.c (100%)
 rename tools/{vm => mm}/page_owner_sort.c (100%)
 rename tools/{vm => mm}/slabinfo-gnuplot.sh (100%)
 rename tools/{vm => mm}/slabinfo.c (100%)

diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
index df9394fb39c2..19492064278c 100644
--- a/Documentation/admin-guide/mm/idle_page_tracking.rst
+++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
@@ -65,7 +65,7 @@ workload one should:
     are not reclaimable, he or she can filter them out using
     ``/proc/kpageflags``.
 
-The page-types tool in the tools/vm directory can be used to assist in this.
+The page-types tool in the tools/mm directory can be used to assist in this.
 If the tool is run initially with the appropriate option, it will mark all the
 queried pages as idle.  Subsequent runs of the tool can then show which pages have
 their idle flag cleared in the interim.
diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index 6e2e416af783..ceb5da3172ba 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -46,7 +46,7 @@ There are four components to pagemap:
  * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
    times each page is mapped, indexed by PFN.
 
-The page-types tool in the tools/vm directory can be used to query the
+The page-types tool in the tools/mm directory can be used to query the
 number of times a page is mapped.
 
  * ``/proc/kpageflags``.  This file contains a 64-bit set of flags for each
@@ -173,7 +173,7 @@ LRU related page flags
 14 - SWAPBACKED
    The page is backed by swap/RAM.
 
-The page-types tool in the tools/vm directory can be used to query the
+The page-types tool in the tools/mm directory can be used to query the
 above flags.
 
 Using pagemap to do something useful
diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index 127514955a5e..5df26c0a0c1f 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -61,7 +61,7 @@ Usage
 
 1) Build user-space helper::
 
-	cd tools/vm
+	cd tools/mm
 	make page_owner_sort
 
 2) Enable page owner: add "page_owner=on" to boot cmdline.
diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index 7f652216dabe..3ffa7eded251 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -21,7 +21,7 @@ slabs that have data in them. See "slabinfo -h" for more options when
 running the command. ``slabinfo`` can be compiled with
 ::
 
-	gcc -o slabinfo tools/vm/slabinfo.c
+	gcc -o slabinfo tools/mm/slabinfo.c
 
 Some of the modes of operation of ``slabinfo`` require that slub debugging
 be enabled on the command line. F.e. no tracking information will be
diff --git a/Documentation/translations/zh_CN/mm/page_owner.rst b/Documentation/translations/zh_CN/mm/page_owner.rst
index 21a6a0837d42..4d3b2c33e4ef 100644
--- a/Documentation/translations/zh_CN/mm/page_owner.rst
+++ b/Documentation/translations/zh_CN/mm/page_owner.rst
@@ -62,7 +62,7 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
 
 1) 构建用户空间的帮助::
 
-	cd tools/vm
+	cd tools/mm
 	make page_owner_sort
 
 2) 启用page owner: 添加 "page_owner=on" 到 boot cmdline.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3073432ff0bf..65426446f09a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13483,8 +13483,8 @@ F:	include/linux/mm.h
 F:	include/linux/mmzone.h
 F:	include/linux/pagewalk.h
 F:	mm/
+F:	tools/mm/
 F:	tools/testing/selftests/vm/
-F:	tools/vm/
 
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index fca699ad1fb0..d62f48131952 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -90,7 +90,7 @@ config PAGE_OWNER
 	  help to find bare alloc_page(s) leaks. Even if you include this
 	  feature on your build, it is disabled in default. You should pass
 	  "page_owner=on" to boot parameter in order to enable it. Eats
-	  a fair amount of memory if enabled. See tools/vm/page_owner_sort.c
+	  a fair amount of memory if enabled. See tools/mm/page_owner_sort.c
 	  for user-space helper.
 
 	  If unsure, say N.
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c77a9e37e27e..6bf07345ea2c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -24,7 +24,7 @@
  * - You have a test that can be added to mce-test
  *   https://git.kernel.org/cgit/utils/cpu/mce/mce-test.git/
  * - The case actually shows up as a frequent (top 10) page state in
- *   tools/vm/page-types when running a real workload.
+ *   tools/mm/page-types when running a real workload.
  * 
  * There are several operations here with exponential complexity because
  * of unsuitable VM data structures. For example the operation to map back 
diff --git a/tools/vm/.gitignore b/tools/mm/.gitignore
similarity index 100%
rename from tools/vm/.gitignore
rename to tools/mm/.gitignore
diff --git a/tools/vm/Makefile b/tools/mm/Makefile
similarity index 100%
rename from tools/vm/Makefile
rename to tools/mm/Makefile
diff --git a/tools/vm/page-types.c b/tools/mm/page-types.c
similarity index 100%
rename from tools/vm/page-types.c
rename to tools/mm/page-types.c
diff --git a/tools/vm/page_owner_sort.c b/tools/mm/page_owner_sort.c
similarity index 100%
rename from tools/vm/page_owner_sort.c
rename to tools/mm/page_owner_sort.c
diff --git a/tools/vm/slabinfo-gnuplot.sh b/tools/mm/slabinfo-gnuplot.sh
similarity index 100%
rename from tools/vm/slabinfo-gnuplot.sh
rename to tools/mm/slabinfo-gnuplot.sh
diff --git a/tools/vm/slabinfo.c b/tools/mm/slabinfo.c
similarity index 100%
rename from tools/vm/slabinfo.c
rename to tools/mm/slabinfo.c
-- 
2.25.1

