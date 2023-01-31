Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91D6825C0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjAaHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAaHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:46:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC23A5A8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151168; x=1706687168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0YLLs+j2MWKb2XKOlEoDSy+Rw/i9cYLM8wl9qJXrpw=;
  b=VskNPWj/i1Cv9hhOdSYRkPX06iFxJU3WQygguoKeXQpvTDDPPwwiwe6O
   JUaFvZWOVSD1RS85YdNonKRkFCDA5fdTdtL5PDsbvOhIitnBviNYjWZK7
   71SlIP0JoYevRf2OcWiOOGl5usFCM6bRecWr+xRMPNULG55IJ1/ISr5Lf
   avXD7emJDMs2DuxVxBgOYKgU7ULB5m3XCiTZbZhXiXY4PqQJA/3Jpd8Cn
   /VyT2ogH8iw9e3CF7IDVQHAffzp4Et3J4pzZiqC0qpPmUiLgvapuH4jlP
   ZgxXsOQbUzuoOHQQ1QmcM9LwaJtpmXKC/xOePrJYtUcU2Ww8f/S3o5frR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736592"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736592"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775514"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775514"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:45:54 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kan.liang@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] iommu/vt-d: Remove unused fields in svm structures
Date:   Tue, 31 Jan 2023 15:37:30 +0800
Message-Id: <20230131073740.378984-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
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

They aren't used anywhere. Remove them to avoid dead code.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230109014955.147068-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 4 ----
 drivers/iommu/intel/svm.c   | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f89f63d7a72a..e7c732979364 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -762,18 +762,14 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct intel_iommu *iommu;
 	struct iommu_sva sva;
-	u32 pasid;
 	int users;
 	u16 did;
-	u16 dev_iotlb:1;
 	u16 sid, qdep;
 };
 
 struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
-
-	unsigned int flags;
 	u32 pasid;
 	struct list_head devs;
 };
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d38a54396c23..d1e445f03aa6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -351,11 +351,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 	sdev->users = 1;
-	sdev->pasid = svm->pasid;
 	sdev->sva.dev = dev;
 	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
-		sdev->dev_iotlb = 1;
 		sdev->qdep = info->ats_qdep;
 		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
 			sdev->qdep = 0;
-- 
2.34.1

