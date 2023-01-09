Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB773661C28
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 02:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjAIB6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 20:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjAIB6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:58:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E010072
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673229482; x=1704765482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=puzEiCLaFj6PIN4/Wwibk3XN7n6katY+/NOVoiu348c=;
  b=aB7r5kzPBbVrdi3uF9g3K5g0YSvKx5pU+53ZFldWqHHvBUSUNwxyq0ta
   HI9Zvci+mY62TMe/ReHoC0DYFcnKJDt7aCPXnbGq6Yjp7mLmh7TlLI9vm
   Qr4C8Y9hUZ1/0fDO1BF12tEl4PBtTmpPbdIxc1EGO798QUN6DIkZ+V07H
   NiIM6L+DfvApLhrPCIDw9j/VfsIhySGZ9JnP3XDPuRmDD41FpPUKCuChA
   UJflsZoTFJhOnLm6MXp2KD3B/xBfQJBuAtwkZ/38nYTFXdyrEQ6anPCn2
   su+u4lNUJnUoDa/unUPlSkIA7HBt2b/GefXYlVc0BRnNjZxJWJU8Sfi7J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322848730"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322848730"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 17:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649867421"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649867421"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 17:57:50 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Remove unused fields in svm structures
Date:   Mon,  9 Jan 2023 09:49:53 +0800
Message-Id: <20230109014955.147068-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109014955.147068-1-baolu.lu@linux.intel.com>
References: <20230109014955.147068-1-baolu.lu@linux.intel.com>
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

They aren't used anywhere. Remove them to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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

