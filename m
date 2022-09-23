Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F895E70DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiIWAsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiIWAsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:48:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A45115BE3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894090; x=1695430090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2H9F9xIz7YWs3e5xk2mJfS9/CmaMe/dKpZPvyRF2Q4=;
  b=XRy+AwWNjI6LrdeQo+GiZ1WBLvQ107qbRChr+3Xiz53uJrY5IK6kejOI
   VlsdcsgicRH3E13oYjzsBPzbIitWTKUrRX9WBRTZqMD0+P3KVjQ4XHdRF
   ni2hybIQSK/WWGviX7BqazimfB4WNwst//ZJ9lIqia9kgl+h68VszeC9t
   jMaMCaM5/9CbigVk32csFsgDlBbNweUtKrtOCOKUX21qO1s9KvUisuibP
   03uCGUrSrkfOEE32AuEXeQTP1sDZnKa3Y1aigcUwX0LQFzEslSHh9DubP
   lgKsaRDKQiZS0thiyA2GDBvf00WcBbqeyQ/fCGZoX6kWpc7GRKEDHQ0hT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278869"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278869"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650759995"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:08 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support
Date:   Fri, 23 Sep 2022 08:42:04 +0800
Message-Id: <20220923004206.3630441-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
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

From: Yi Liu <yi.l.liu@intel.com>

This renaming better describes it is for first level page table (a.k.a
first stage page table since VT-d spec 3.4).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220916071326.2223901-1-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h     | 2 +-
 drivers/iommu/intel/cap_audit.c | 4 ++--
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/intel/pasid.c     | 2 +-
 drivers/iommu/intel/svm.c       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8f29a183467d..99cc75ecac63 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -146,7 +146,7 @@
 /*
  * Decoding Capability Register
  */
-#define cap_5lp_support(c)	(((c) >> 60) & 1)
+#define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
 #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
 #define cap_read_drain(c)	(((c) >> 55) & 1)
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 3ee68393122f..806986696841 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -37,7 +37,7 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_MHMV_MASK);
 	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_IRO_MASK);
 
-	CHECK_FEATURE_MISMATCH(a, b, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, fl5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, write_drain, CAP_WD_MASK);
@@ -84,7 +84,7 @@ static int cap_audit_hotplug(struct intel_iommu *iommu, enum cap_audit_type type
 		goto out;
 	}
 
-	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, fl5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, read_drain, CAP_RD_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(iommu, cap, write_drain, CAP_WD_MASK);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6d04ee5ea3ab..81a449b5cb91 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -404,7 +404,7 @@ static unsigned long __iommu_calculate_sagaw(struct intel_iommu *iommu)
 {
 	unsigned long fl_sagaw, sl_sagaw;
 
-	fl_sagaw = BIT(2) | (cap_5lp_support(iommu->cap) ? BIT(3) : 0);
+	fl_sagaw = BIT(2) | (cap_fl5lp_support(iommu->cap) ? BIT(3) : 0);
 	sl_sagaw = cap_sagaw(iommu->cap);
 
 	/* Second level only. */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index ccaf32949254..c30ddac40ee5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -519,7 +519,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if ((flags & PASID_FLAG_FL5LP) && !cap_5lp_support(iommu->cap)) {
+	if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap)) {
 		pr_err("No 5-level paging support for first-level on %s\n",
 		       iommu->name);
 		return -EINVAL;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d1cab931dcb0..7d08eb034f2d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,7 +164,7 @@ void intel_svm_check(struct intel_iommu *iommu)
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-	    !cap_5lp_support(iommu->cap)) {
+	    !cap_fl5lp_support(iommu->cap)) {
 		pr_err("%s SVM disabled, incompatible paging mode\n",
 		       iommu->name);
 		return;
-- 
2.34.1

