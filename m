Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE46825B8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjAaHqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjAaHqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:46:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C93B3DE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151166; x=1706687166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1MxTLdDeLeeouG952McaeDlNjDKN6G16uZN42WANIs=;
  b=egrv5gbIhaHc3wxA8PBTIRGEs8XGAW59cPcdr6PO8G58aW2C801USx80
   bn12HhD8Ig8LZuVDr0WUlBMo4ZMGZQhcxylVMN2ps6plUmrlzfWf6kENU
   R7TJ9Tq9xVJzRd/GPQ9WkF54E/gyOjpnSFqGUjdVzF+m6RABlZCuTMvaH
   +WMA03cf8kEMd6Jmfw409kA9XO8d6QEaeU8HKVJMvV0CrzhHI79cm7Ayf
   39rTiSkRzP2sFWbAabnV76EfAfnSyQVABHTrhdNrYcvKcPd/OFFPVLqJY
   oY1qGjjqqTjADuakLkxkBbInSppDOYJBtjd5+PNv/DOHJE/oQphRd6oGo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736587"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736587"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775510"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775510"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:45:53 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kan.liang@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] iommu/vt-d: Remove include/linux/intel-svm.h
Date:   Tue, 31 Jan 2023 15:37:29 +0800
Message-Id: <20230131073740.378984-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to have a public header for Intel SVA implementation.
The device driver should interact with Intel SVA implementation via
the IOMMU generic APIs.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230109014955.147068-2-baolu.lu@linux.intel.com
---
 include/linux/intel-svm.h   | 16 ----------------
 drivers/iommu/intel/iommu.h |  5 +++++
 drivers/iommu/intel/iommu.c |  1 -
 drivers/iommu/intel/svm.c   |  1 -
 MAINTAINERS                 |  1 -
 5 files changed, 5 insertions(+), 19 deletions(-)
 delete mode 100644 include/linux/intel-svm.h

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
deleted file mode 100644
index f9a0d44f6fdb..000000000000
--- a/include/linux/intel-svm.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright © 2015 Intel Corporation.
- *
- * Authors: David Woodhouse <David.Woodhouse@intel.com>
- */
-
-#ifndef __INTEL_SVM_H__
-#define __INTEL_SVM_H__
-
-/* Page Request Queue depth */
-#define PRQ_ORDER	4
-#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
-#define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
-
-#endif /* __INTEL_SVM_H__ */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 06e61e474856..f89f63d7a72a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -438,6 +438,11 @@ struct q_inval {
 	int             free_cnt;
 };
 
+/* Page Request Queue depth */
+#define PRQ_ORDER	4
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
+#define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
+
 struct dmar_pci_notify_info;
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..317af67b6098 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -16,7 +16,6 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 #include <linux/dmi.h>
-#include <linux/intel-svm.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c76b66263467..d38a54396c23 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -9,7 +9,6 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
-#include <linux/intel-svm.h>
 #include <linux/rculist.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
diff --git a/MAINTAINERS b/MAINTAINERS
index f781f936ae35..dbc36fa870d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10458,7 +10458,6 @@ L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
-F:	include/linux/intel-svm.h
 
 INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
-- 
2.34.1

