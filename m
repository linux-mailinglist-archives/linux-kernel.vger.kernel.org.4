Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4E6D1675
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCaEyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCaEyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:54:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2331AC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680238481; x=1711774481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fd75vsjSJy6EbCzI5Lu++FGJSnhh9YekoxFeV38EkyE=;
  b=TCkomDbvtHWCStYWvcdTP7if6KlqkhzZ6dxQ6zn7lUCpb6lldzeOLZND
   kxivmuP5njSGdj3Ht6EHDI7fGvqtjBPg0Zq+EIwhSr5l7YD6K+ADj9lHt
   my3EHIL6MXGHPkBcYVron6jtbVzsCc1abEuG+MgvXH0zSRYyZAIHhbY+s
   jqsCqKpgs4Njbvw5AtLsGkcRctJIFBhKWQ7HVANPg14gOuR48xhAyoDCW
   nnpWf/aYi71xgAwU71MjGGVnNP1+hXpwmeJOFkMFI2UxnSCKnZxuiDQql
   wJ5nY8Vka5nJXFMP46VnvU9NAHL+3Q7jLxBhjAf2up7X8PCw6rj79gjEn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427635890"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="427635890"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 21:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="749475185"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="749475185"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2023 21:54:40 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Remove extern from function prototypes
Date:   Fri, 31 Mar 2023 12:54:52 +0800
Message-Id: <20230331045452.500265-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from drivers/iommu/intel/iommu.h as they are
not needed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d6df3b865812..f843493dc4f2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -796,18 +796,18 @@ static inline bool context_present(struct context_entry *context)
 	return (context->lo & 1);
 }
 
-extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-
-extern int dmar_enable_qi(struct intel_iommu *iommu);
-extern void dmar_disable_qi(struct intel_iommu *iommu);
-extern int dmar_reenable_qi(struct intel_iommu *iommu);
-extern void qi_global_iec(struct intel_iommu *iommu);
-
-extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
-			     u8 fm, u64 type);
-extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
-			  unsigned int size_order, u64 type);
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+struct dmar_drhd_unit *dmar_find_matched_drhd_unit(struct pci_dev *dev);
+
+int dmar_enable_qi(struct intel_iommu *iommu);
+void dmar_disable_qi(struct intel_iommu *iommu);
+int dmar_reenable_qi(struct intel_iommu *iommu);
+void qi_global_iec(struct intel_iommu *iommu);
+
+void qi_flush_context(struct intel_iommu *iommu, u16 did,
+		      u16 sid, u8 fm, u64 type);
+void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+		    unsigned int size_order, u64 type);
+void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
 
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
@@ -830,7 +830,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
-extern int dmar_ir_support(void);
+int dmar_ir_support(void);
 
 void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
@@ -838,9 +838,9 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-extern void intel_svm_check(struct intel_iommu *iommu);
-extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-extern int intel_svm_finish_prq(struct intel_iommu *iommu);
+void intel_svm_check(struct intel_iommu *iommu);
+int intel_svm_enable_prq(struct intel_iommu *iommu);
+int intel_svm_finish_prq(struct intel_iommu *iommu);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
@@ -887,8 +887,8 @@ extern const struct iommu_ops intel_iommu_ops;
 
 #ifdef CONFIG_INTEL_IOMMU
 extern int intel_iommu_sm;
-extern int iommu_calculate_agaw(struct intel_iommu *iommu);
-extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
+int iommu_calculate_agaw(struct intel_iommu *iommu);
+int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob);
 
 static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
-- 
2.34.1

