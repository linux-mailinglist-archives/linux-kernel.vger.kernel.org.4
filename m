Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A26E05BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDMEHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDMEHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:07:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C64B7D96
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358818; x=1712894818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXw7iRfpei7pJiqdEoClA47q842CS/GvW0oVWNgTE1k=;
  b=C75+GQT3j+VEHeBkv/KJdj2/LqRGrEuxdWO4hhO+DEWK1YWGZdlrOfIw
   bu7zbuZp5Crv6iuCf8dTfVIQgENwDH58fKS6rXpT+lRUU8I1bneM1dEq+
   4IvNAzi7BnuyJrsAJx7s7K7o6SSF1yFJaamhN6SfKDyGJO7fgjhVloeXD
   HF8SCvDK2sVo3wTPX11etjMAJ95gP8DUFdWWLq630gNdMdZvFVqHo4G2i
   9PUds1oF3zQYv0wnPveBXjMu9/D/MilZ2ee0kXFE/g1qUlpQgXn3+6nKt
   SZjqE97vkUNkLi7bF73AFWBw7VlgiB8Q46Vhc944rVcdn153nl4H8+AIK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786586"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786586"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361032"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361032"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] iommu/vt-d: Remove extern from function prototypes
Date:   Thu, 13 Apr 2023 12:06:36 +0800
Message-Id: <20230413040645.46157-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel coding style does not require 'extern' in function prototypes
in .h files, so remove them from drivers/iommu/intel/iommu.h as they are
not needed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230331045452.500265-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 694ab9b7d3e9..19494713d6b3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -798,18 +798,18 @@ static inline bool context_present(struct context_entry *context)
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
@@ -832,7 +832,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
-extern int dmar_ir_support(void);
+int dmar_ir_support(void);
 
 void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
@@ -840,9 +840,9 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
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
@@ -889,8 +889,8 @@ extern const struct iommu_ops intel_iommu_ops;
 
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

