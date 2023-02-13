Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD06693DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBMFZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMFZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:25:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB4BEB60;
        Sun, 12 Feb 2023 21:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676265923; x=1707801923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hIZhaejz1nsQtgqa1/2qLhleUvBiUD8Jcqdv1d1/SSs=;
  b=N1DAZtnzSblRhG4NlEpsiBWdNNz2TeQjurxFA5EhKA4EoKSV044UR10m
   I+zEVr2sOsXBEg/E0Bh5/f/fzmLnP2bh+AVQ9URy8YqkTtEF1EYFexJLD
   O5mLJQckXgtKPb6jZuAyoo1Hynmp2cW5ICgcg17HrRCrTNz/YMQBZxnb9
   ugMAyJuI9Gpghitox+DBJbouZgnFpSH5i+Cj4WlomHBSCUS7TSz2+afWk
   XbJA4mAxrzXqqXJMPS9M2UhAIqku5H6XmcrPENx771GMsFtCP8HJz4vG5
   fLlg096t5tManWMnxPoq58K0Ok/Dx+ckRZ6uXIrYbcpOceoPeT61IiXUm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="311173382"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="311173382"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 21:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="670680365"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="670680365"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 12 Feb 2023 21:25:22 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [thermal-bleeding-edge][PATCH] thermal: intel: powerclamp: Fix warnings
Date:   Sun, 12 Feb 2023 21:25:19 -0800
Message-Id: <20230213052519.801458-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two warnings are reported during make htmldocs:
1.Documentation/admin-guide/index.rst:62: WARNING: toctree contains
reference to nonexisting document 'admin-guide/thermal'
2.Documentation/admin-guide/thermal/intel_powerclamp.rst:328:
WARNING: Inline emphasis start-string without end-string

Fix the first warning by adding index.rst in thermal folder and
for the second issue use \ for *.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/index.rst                    |  2 +-
 Documentation/admin-guide/thermal/index.rst            | 10 ++++++++++
 Documentation/admin-guide/thermal/intel_powerclamp.rst |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/thermal/index.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c872a8a1ddfa..0571938ecdc8 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -116,7 +116,7 @@ configure specific aspects of kernel behavior to your liking.
    svga
    syscall-user-dispatch
    sysrq
-   thermal
+   thermal/index
    thunderbolt
    ufs
    unicode
diff --git a/Documentation/admin-guide/thermal/index.rst b/Documentation/admin-guide/thermal/index.rst
new file mode 100644
index 000000000000..6eb3f4da40e6
--- /dev/null
+++ b/Documentation/admin-guide/thermal/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+Thermal Management
+==================
+
+.. toctree::
+   :maxdepth: 1
+
+   intel_powerclamp
diff --git a/Documentation/admin-guide/thermal/intel_powerclamp.rst b/Documentation/admin-guide/thermal/intel_powerclamp.rst
index 2d9d2d739f02..f919fbe1cdd9 100644
--- a/Documentation/admin-guide/thermal/intel_powerclamp.rst
+++ b/Documentation/admin-guide/thermal/intel_powerclamp.rst
@@ -326,7 +326,7 @@ Module Parameters
 
 ``cpumask`` (RW)
 	A bit mask of CPUs to inject idle. The format of the bitmask is same as
-	used in other subsystems like in /proc/irq/*/smp_affinity. The mask is
+	used in other subsystems like in /proc/irq/\*/smp_affinity. The mask is
 	comma separated 32 bit groups. Each CPU is one bit. For example for a 256
 	CPU system the full mask is:
 	ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
-- 
2.39.1

