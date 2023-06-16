Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904737339BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbjFPTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA744A3;
        Fri, 16 Jun 2023 12:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C8363E4F;
        Fri, 16 Jun 2023 19:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FFEC433CB;
        Fri, 16 Jun 2023 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943071;
        bh=f3HOe9/kZR2u+JAC7ZFka5WaxvMhj+FaHkWQpsoLpnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paP/cMrrN2YC1qI+2IOL6lzfXW+Cgu9GTDAFTYdWea8Vi9SeJGajGut/HE8gpTI1G
         YPSdaHIqP/xEAjnvjXDzgDU7D82IMUJGXx8HhmVYuSXRfm7bP3Ec1KgfFqvXSgR1QJ
         NNMxIA79qpBl4DsDGX6d0dF5bWvxj+IjySwODmHLwaJTKDIOY4j/QV2/4SSNyUGrii
         0FxdXjaDU/4yVD2D8dQ8cy8Lvw0xpXDuDSlxj4MUFEzG+fcnEI5J2GsaueAGO24eRA
         SlZ4VI+1u4Dfkw+hjNHxjGUfSwNalwcnN6/BsiETA6RsnAPLVcYAoGp0kKpCY69N7J
         c3HDybrTKMGmA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] Docs/admin-guide/mm/damon/usage: link design document for DAMOS
Date:   Fri, 16 Jun 2023 19:17:40 +0000
Message-Id: <20230616191742.87531-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616191742.87531-1-sj@kernel.org>
References: <20230616191742.87531-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The background and concept of DAMOS is redundantly documented, in the
design document and the usage document.  Replace the duplicated ones in
usage document with links to the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 104 +++++++------------
 Documentation/mm/damon/design.rst            |  14 +++
 2 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 82a79838a47d..ea6a5dc8930e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -257,12 +257,9 @@ be equal or smaller than ``start`` of directory ``N+1``.
 contexts/<N>/schemes/
 ---------------------
 
-For usual DAMON-based data access aware memory management optimizations, users
-would normally want the system to apply a memory management action to a memory
-region of a specific access pattern.  DAMON receives such formalized operation
-schemes from the user and applies those to the target memory regions.  Users
-can get and set the schemes by reading from and writing to files under this
-directory.
+The directory for DAMON-based Operation Schemes (:ref:`DAMOS
+<damon_design_damos>`).  Users can get and set the schemes by reading from and
+writing to files under this directory.
 
 In the beginning, this directory has only one file, ``nr_schemes``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
@@ -275,9 +272,9 @@ In each scheme directory, five directories (``access_pattern``, ``quotas``,
 ``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and one file
 (``action``) exist.
 
-The ``action`` file is for setting and getting what action you want to apply to
-memory regions having specific access pattern of the interest.  The keywords
-that can be written to and read from the file and their meaning are as below.
+The ``action`` file is for setting and getting the scheme's :ref:`action
+<damon_design_damos_action>`.  The keywords that can be written to and read
+from the file and their meaning are as below.
 
 Note that support of each action depends on the running DAMON operations set
 :ref:`implementation <sysfs_contexts>`.
@@ -302,10 +299,8 @@ Note that support of each action depends on the running DAMON operations set
 schemes/<N>/access_pattern/
 ---------------------------
 
-The target access pattern of each DAMON-based operation scheme is constructed
-with three ranges including the size of the region in bytes, number of
-monitored accesses per aggregate interval, and number of aggregated intervals
-for the age of the region.
+The directory for the target access :ref:`pattern
+<damon_design_damos_access_pattern>` of the given DAMON-based operation scheme.
 
 Under the ``access_pattern`` directory, three directories (``sz``,
 ``nr_accesses``, and ``age``) each having two files (``min`` and ``max``)
@@ -316,18 +311,8 @@ to and reading from the ``min`` and ``max`` files under ``sz``,
 schemes/<N>/quotas/
 -------------------
 
-Optimal ``target access pattern`` for each ``action`` is workload dependent, so
-not easy to find.  Worse yet, setting a scheme of some action too aggressive
-can cause severe overhead.  To avoid such overhead, users can limit time and
-size quota for each scheme.  In detail, users can ask DAMON to try to use only
-up to specific time (``time quota``) for applying the action, and to apply the
-action to only up to specific amount (``size quota``) of memory regions having
-the target access pattern within a given time interval (``reset interval``).
-
-When the quota limit is expected to be exceeded, DAMON prioritizes found memory
-regions of the ``target access pattern`` based on their size, access frequency,
-and age.  For personalized prioritization, users can set the weights for the
-three properties.
+The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
+DAMON-based operation scheme.
 
 Under ``quotas`` directory, three files (``ms``, ``bytes``,
 ``reset_interval_ms``) and one directory (``weights``) having three files
@@ -335,23 +320,20 @@ Under ``quotas`` directory, three files (``ms``, ``bytes``,
 
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
 ``reset interval`` in milliseconds by writing the values to the three files,
-respectively.  You can also set the prioritization weights for size, access
-frequency, and age in per-thousand unit by writing the values to the three
-files under the ``weights`` directory.
+respectively.  You can also set the :ref:`prioritization weights
+<damon_design_damos_quotas_prioritization>` for size, access frequency, and age
+in per-thousand unit by writing the values to the three files under the
+``weights`` directory.
 
 schemes/<N>/watermarks/
 -----------------------
 
-To allow easy activation and deactivation of each scheme based on system
-status, DAMON provides a feature called watermarks.  The feature receives five
-values called ``metric``, ``interval``, ``high``, ``mid``, and ``low``.  The
-``metric`` is the system metric such as free memory ratio that can be measured.
-If the metric value of the system is higher than the value in ``high`` or lower
-than ``low`` at the memoent, the scheme is deactivated.  If the value is lower
-than ``mid``, the scheme is activated.
+The directory for the :ref:`watermarks <damon_design_damos_watermarks>` of the
+given DAMON-based operation scheme.
 
 Under the watermarks directory, five files (``metric``, ``interval_us``,
-``high``, ``mid``, and ``low``) for setting each value exist.  You can set and
+``high``, ``mid``, and ``low``) for setting the metric, the time interval
+between check of the metric, and the three watermarks exist.  You can set and
 get the five values by writing to the files, respectively.
 
 Keywords and meanings of those that can be written to the ``metric`` file are
@@ -365,12 +347,8 @@ The ``interval`` should written in microseconds unit.
 schemes/<N>/filters/
 --------------------
 
-Users could know something more than the kernel for specific types of memory.
-In the case, users could do their own management for the memory and hence
-doesn't want DAMOS bothers that.  Users could limit DAMOS by setting the access
-pattern of the scheme and/or the monitoring regions for the purpose, but that
-can be inefficient in some cases.  In such cases, users could set non-access
-pattern driven filters using files in this directory.
+The directory for the :ref:`filters <damon_design_damos_filters>` of the given
+DAMON-based operation scheme.
 
 In the beginning, this directory has only one file, ``nr_filters``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
@@ -597,15 +575,10 @@ update.
 Schemes
 -------
 
-For usual DAMON-based data access aware memory management optimizations, users
-would simply want the system to apply a memory management action to a memory
-region of a specific access pattern.  DAMON receives such formalized operation
-schemes from the user and applies those to the target processes.
-
-Users can get and set the schemes by reading from and writing to ``schemes``
-debugfs file.  Reading the file also shows the statistics of each scheme.  To
-the file, each of the schemes should be represented in each line in below
-form::
+Users can get and set the DAMON-based operation :ref:`schemes
+<damon_design_damos>` by reading from and writing to ``schemes`` debugfs file.
+Reading the file also shows the statistics of each scheme.  To the file, each
+of the schemes should be represented in each line in below form::
 
     <target access pattern> <action> <quota> <watermarks>
 
@@ -614,8 +587,9 @@ You can disable schemes by simply writing an empty string to the file.
 Target Access Pattern
 ~~~~~~~~~~~~~~~~~~~~~
 
-The ``<target access pattern>`` is constructed with three ranges in below
-form::
+The target access :ref:`pattern <damon_design_damos_access_pattern>` of the
+scheme.  The ``<target access pattern>`` is constructed with three ranges in
+below form::
 
     min-size max-size min-acc max-acc min-age max-age
 
@@ -628,9 +602,9 @@ closed interval.
 Action
 ~~~~~~
 
-The ``<action>`` is a predefined integer for memory management actions, which
-DAMON will apply to the regions having the target access pattern.  The
-supported numbers and their meanings are as below.
+The ``<action>`` is a predefined integer for memory management :ref:`actions
+<damon_design_damos_action>`.  The supported numbers and their meanings are as
+below.
 
  - 0: Call ``madvise()`` for the region with ``MADV_WILLNEED``.  Ignored if
    ``target`` is ``paddr``.
@@ -646,10 +620,8 @@ supported numbers and their meanings are as below.
 Quota
 ~~~~~
 
-Optimal ``target access pattern`` for each ``action`` is workload dependent, so
-not easy to find.  Worse yet, setting a scheme of some action too aggressive
-can cause severe overhead.  To avoid such overhead, users can limit time and
-size quota for the scheme via the ``<quota>`` in below form::
+Users can set the :ref:`quotas <damon_design_damos_quotas>` of the given scheme
+via the ``<quota>`` in below form::
 
     <ms> <sz> <reset interval> <priority weights>
 
@@ -659,19 +631,17 @@ the action to memory regions of the ``target access pattern`` within the
 ``<sz>`` bytes of memory regions within the ``<reset interval>``.  Setting both
 ``<ms>`` and ``<sz>`` zero disables the quota limits.
 
-When the quota limit is expected to be exceeded, DAMON prioritizes found memory
-regions of the ``target access pattern`` based on their size, access frequency,
-and age.  For personalized prioritization, users can set the weights for the
-three properties in ``<priority weights>`` in below form::
+For the :ref:`prioritization <damon_design_damos_quotas_prioritization>`, users
+can set the weights for the three properties in ``<priority weights>`` in below
+form::
 
     <size weight> <access frequency weight> <age weight>
 
 Watermarks
 ~~~~~~~~~~
 
-Some schemes would need to run based on current value of the system's specific
-metrics like free memory ratio.  For such cases, users can specify watermarks
-for the condition.::
+Users can specify :ref:`watermarks <damon_design_damos_watermarks>` of the
+given scheme via ``<watermarks>`` in below form::
 
     <metric> <check interval> <high mark> <middle mark> <low mark>
 
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a98af99bb705..4bfdf1d30c4a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -218,6 +218,8 @@ abstracted monitoring target memory area only for each of a user-specified time
 interval (``update interval``).
 
 
+.. _damon_design_damos:
+
 Operation Schemes
 -----------------
 
@@ -255,6 +257,8 @@ the access pattern of interest, and applies the user-desired operation actions
 to the regions as soon as found.
 
 
+.. _damon_design_damos_action:
+
 Operation Action
 ~~~~~~~~~~~~~~~~
 
@@ -277,6 +281,8 @@ characteristics.  Hence, DAMOS resets the age of regions when an action is
 applied to those.
 
 
+.. _damon_design_damos_access_pattern:
+
 Target Access Pattern
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -288,6 +294,8 @@ region's three properties are in the ranges, DAMOS classifies it as one of the
 regions that the scheme is having an interest in.
 
 
+.. _damon_design_damos_quotas:
+
 Quotas
 ~~~~~~
 
@@ -305,6 +313,8 @@ can use for applying the action, and/or a maximum bytes of memory regions that
 the action can be applied within a user-specified time duration.
 
 
+.. _damon_design_damos_quotas_prioritization:
+
 Prioritization
 ^^^^^^^^^^^^^^
 
@@ -330,6 +340,8 @@ the weight will be respected are up to the underlying prioritization mechanism
 implementation.
 
 
+.. _damon_design_damos_watermarks:
+
 Watermarks
 ~~~~~~~~~~
 
@@ -350,6 +362,8 @@ is also deactivated.  In this case, the DAMON worker thread only periodically
 checks the watermarks and therefore incurs nearly zero overhead.
 
 
+.. _damon_design_damos_filters:
+
 Filters
 ~~~~~~~
 
-- 
2.25.1

