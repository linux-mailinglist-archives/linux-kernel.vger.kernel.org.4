Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45EF6A6BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCALZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCALZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:25:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420283B0C5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677669947; x=1709205947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nhI8Qubg8WQl47vGteaEMeJxeUGgkrokzqxRYwakSMw=;
  b=Y0DSyRe+PAh4FxoHkR1G4h88DA/2MYB1nxnQJIUrtgT5OFyw0Ymwaw8h
   zvKtyhmYeEPx+B2hcQksE18tJW4Ar8866kCi/WGUANBhIfzR5L+5Z5atm
   bOLMVgJaeiwU2aA0QOtAKwRqI/k5mJSa7vRWARsKZnN83MGTYk3fbneyY
   AJpuyIp92QzRlsMCAkcxfKdtF1CfTT44++GSwVOq+aFAgYWIR8CiLvvn4
   jyFKurIsymRTPpgbTrLOVaBEne8K4plECLEbqZEevKzWcBt+RYS6mlICx
   9dV2mfFQVI3JLGdLom9iza5uAGvOapbleNxodKYtgu+p3rPoHyO8BYRUi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335875442"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="335875442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 03:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798405746"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="798405746"
Received: from nemesa.iind.intel.com ([10.190.239.22])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2023 03:25:43 -0800
From:   "Garg, Nemesa" <nemesa.garg@intel.com>
To:     linux-kernel@vger.kernel.org, gfx-internal-devel@eclists.intel.com
Cc:     matthew.d.roper@intel.com, chaitanya.kumar.borah@intel.com,
        clinton.a.taylor@intel.com, Garg@vger.kernel.org,
        Nemesa <nemesa.garg@intel.com>
Subject: [PATCH dii-client 0/3] Adding Device Ids for ARL-S and ARL-P
Date:   Wed,  1 Mar 2023 16:54:42 +0530
Message-Id: <20230301112445.2207064-1-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Git-Pile: INTEL_DII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Add ARL P and S PCI IDs. Add ARL to the
 false PCH logic and assign as PCH_MTP.
---
baseline: c1c71a12b19171be4dd368176809ec9cfb65ebcc
pile-commit: 8b08df49ad0b7219aae3216c0b562b78825b5244
range-diff:
  -:  ------------ > 164:  a41c7f6e99c1 drm/pciid : Adding ARL-S and ARL-P PCI/device ids
  -:  ------------ > 165:  dff452869c89 INTEL_DII: drm/i915/arl: ARL false PCH ID

 series                                             |  2 +
 ...iid-Adding-ARL-S-and-ARL-P-PCI-device-ids.patch | 94 ++++++++++++++++++++++
 0001-INTEL_DII-drm-i915-arl-ARL-false-PCH-ID.patch | 35 ++++++++
 3 files changed, 131 insertions(+)

diff --git a/series b/series
index ec817b05d84c..25c5a4bce9bb 100644
--- a/series
+++ b/series
@@ -163,4 +163,6 @@
 0001-NOT_UPSTREAM-drm-i915-huc-load-HuC-via-non-POR-GSC-e.patch
 0001-END-SECTION-CI-only-patches-part-2.patch
 0001-START-SECTION-ARL-Platform-Enabling.patch
+0001-drm-pciid-Adding-ARL-S-and-ARL-P-PCI-device-ids.patch
+0001-INTEL_DII-drm-i915-arl-ARL-false-PCH-ID.patch
 0001-END-SECTION-ARL-Platform-Enabling.patch
diff --git a/0001-drm-pciid-Adding-ARL-S-and-ARL-P-PCI-device-ids.patch b/0001-drm-pciid-Adding-ARL-S-and-ARL-P-PCI-device-ids.patch
new file mode 100644
index 000000000000..62deda9499dd
--- /dev/null
+++ b/0001-drm-pciid-Adding-ARL-S-and-ARL-P-PCI-device-ids.patch
@@ -0,0 +1,94 @@
+From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
+From: "Garg, Nemesa" <nemesa.garg@intel.com>
+Date: Thu, 16 Feb 2023 18:48:34 +0530
+Subject: [PATCH] drm/pciid : Adding ARL-S and ARL-P PCI/device ids
+
+Arrow Lake behaves the same as Meteor Lake with just minor differences.
+Add definitions for ARL_P. Update MTL and ARL definitions with new
+device IDs for ARL-S and ARL-P.
+
+Bspec: 55420
+
+Signed-off-by: Garg, Nemesa <nemesa.garg@intel.com>
+---
+ drivers/gpu/drm/i915/i915_drv.h          |  2 ++
+ drivers/gpu/drm/i915/intel_device_info.c |  7 +++++++
+ drivers/gpu/drm/i915/intel_device_info.h |  1 +
+ include/drm/i915_pciids.h                | 11 +++++++++--
+ 4 files changed, 19 insertions(+), 2 deletions(-)
+
+diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
+--- a/drivers/gpu/drm/i915/i915_drv.h
++++ b/drivers/gpu/drm/i915/i915_drv.h
+@@ -574,6 +574,8 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
+ 	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_M)
+ #define IS_METEORLAKE_P(dev_priv) \
+ 	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_P)
++#define IS_ARROWLAKE_P(dev_priv) \
++	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_ARL_P)
+ #define IS_DG2_G10(dev_priv) \
+ 	IS_SUBPLATFORM(dev_priv, INTEL_DG2, INTEL_SUBPLATFORM_G10)
+ #define IS_DG2_G11(dev_priv) \
+diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
+--- a/drivers/gpu/drm/i915/intel_device_info.c
++++ b/drivers/gpu/drm/i915/intel_device_info.c
+@@ -224,6 +224,10 @@ static const u16 subplatform_p_ids[] = {
+ 	INTEL_MTL_P_IDS(0),
+ };
+ 
++static const u16 subplatform_arl_p_ids[] = {
++	INTEL_ARL_P_IDS(0),
++};
++
+ static bool find_devid(u16 id, const u16 *p, unsigned int num)
+ {
+ 	for (; num; num--, p++) {
+@@ -284,6 +288,9 @@ static void intel_device_info_subplatform_init(struct drm_i915_private *i915)
+ 	} else if (find_devid(devid, subplatform_p_ids,
+ 			      ARRAY_SIZE(subplatform_p_ids))) {
+ 		mask = BIT(INTEL_SUBPLATFORM_P);
++	} else if (find_devid(devid, subplatform_arl_p_ids,
++				ARRAY_SIZE(subplatform_arl_p_ids))) {
++		mask = BIT(INTEL_SUBPLATFORM_ARL_P);
+ 	}
+ 
+ 	GEM_BUG_ON(mask & ~INTEL_SUBPLATFORM_MASK);
+diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
+--- a/drivers/gpu/drm/i915/intel_device_info.h
++++ b/drivers/gpu/drm/i915/intel_device_info.h
+@@ -131,6 +131,7 @@ enum intel_platform {
+ /* MTL */
+ #define INTEL_SUBPLATFORM_M	0
+ #define INTEL_SUBPLATFORM_P	1
++#define INTEL_SUBPLATFORM_ARL_P 2
+ 
+ enum intel_ppgtt_type {
+ 	INTEL_PPGTT_NONE = I915_GEM_PPGTT_NONE,
+diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
+--- a/include/drm/i915_pciids.h
++++ b/include/drm/i915_pciids.h
+@@ -738,15 +738,22 @@
+ /* MTL */
+ #define INTEL_MTL_M_IDS(info) \
+ 	INTEL_VGA_DEVICE(0x7D40, info), \
+-	INTEL_VGA_DEVICE(0x7D60, info)
++	INTEL_VGA_DEVICE(0x7D41, info), \
++	INTEL_VGA_DEVICE(0x7D60, info), \
++	INTEL_VGA_DEVICE(0x7D67, info)
+ 
+ #define INTEL_MTL_P_IDS(info) \
+ 	INTEL_VGA_DEVICE(0x7D45, info), \
+ 	INTEL_VGA_DEVICE(0x7D55, info), \
+ 	INTEL_VGA_DEVICE(0x7DD5, info)
+ 
++#define INTEL_ARL_P_IDS(info) \
++	INTEL_VGA_DEVICE(0x7D51, info), \
++	INTEL_VGA_DEVICE(0x7DD1, info)
++
+ #define INTEL_MTL_IDS(info) \
+ 	INTEL_MTL_M_IDS(info), \
+-	INTEL_MTL_P_IDS(info)
++	INTEL_MTL_P_IDS(info), \
++	INTEL_ARL_P_IDS(info)
+ 
+ #endif /* _I915_PCIIDS_H */
diff --git a/0001-INTEL_DII-drm-i915-arl-ARL-false-PCH-ID.patch b/0001-INTEL_DII-drm-i915-arl-ARL-false-PCH-ID.patch
new file mode 100644
index 000000000000..0585e8dc7c4c
--- /dev/null
+++ b/0001-INTEL_DII-drm-i915-arl-ARL-false-PCH-ID.patch
@@ -0,0 +1,35 @@
+From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
+From: "Garg, Nemesa" <nemesa.garg@intel.com>
+Date: Wed, 1 Mar 2023 11:21:53 +0530
+Subject: [PATCH] INTEL_DII: drm/i915/arl: ARL false PCH ID
+
+Add ARL to the fake PCH handler and assign PCH_MTP
+
+Signed-off-by: Garg, Nemesa <nemesa.garg@intel.com>
+---
+ drivers/gpu/drm/i915/soc/intel_pch.c | 6 ++++--
+ 1 file changed, 4 insertions(+), 2 deletions(-)
+
+diff --git a/drivers/gpu/drm/i915/soc/intel_pch.c b/drivers/gpu/drm/i915/soc/intel_pch.c
+--- a/drivers/gpu/drm/i915/soc/intel_pch.c
++++ b/drivers/gpu/drm/i915/soc/intel_pch.c
+@@ -171,7 +171,7 @@ intel_virt_detect_pch(const struct drm_i915_private *dev_priv,
+ 	 * make an educated guess as to which PCH is really there.
+ 	 */
+ 
+-	if (IS_METEORLAKE(dev_priv))
++	if (IS_METEORLAKE(dev_priv) || IS_ARROWLAKE_P(dev_priv))
+ 		id = INTEL_PCH_MTP_DEVICE_ID_TYPE;
+ 	else if (IS_ALDERLAKE_S(dev_priv) || IS_ALDERLAKE_P(dev_priv))
+ 		id = INTEL_PCH_ADP_DEVICE_ID_TYPE;
+@@ -223,7 +223,9 @@ void intel_detect_pch(struct drm_i915_private *dev_priv)
+ 	} else if (IS_DG2(dev_priv)) {
+ 		dev_priv->pch_type = PCH_DG2;
+ 		return;
+-	}
++	} else if (IS_ARROWLAKE_P(dev_priv)) {
++		dev_priv->pch_type = PCH_MTP;
++		return;
+ 
+ 	/*
+ 	 * The reason to probe ISA bridge instead of Dev31:Fun0 is to
--
git-pile 1.1

