Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4746A6BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCAL0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCAL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:26:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FD3BDA7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677669962; x=1709205962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3twCZnslPOK8VLy8qhzbPCje3slsLMGvjMau+QlkqpM=;
  b=VZd58Q9e/AcDkP8y33ktqOwV9ExiL2jjdyz7pq7VcgTgd/rJD+gU9mqt
   LmpeqhqiV5pp/h8RqydOpfew48i4/qktaNQs05KIaCsfeMb0qja8jJAU1
   TvgCZTDKhX+tKtI+Y0avpCkRSu9Le3oWNsplZkip9HbO8QP1Se6rJoBv6
   chmBMExJMTtcrwbvpcBUymWTi5g3q0nGJS6dFoCR4DHl1HDcVoFUdvuo8
   VAZmK5rLZonIDxAJTgfXMcUX/yQs2qdilFXY7Di4YbtwRSN1mawKaZl5L
   sDFohfpnOgap9G/XWzeOsY/n5eJcAjj83t0xYS3Wy2LymgSzMZswA/uii
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335875489"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="335875489"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 03:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798405772"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="798405772"
Received: from nemesa.iind.intel.com ([10.190.239.22])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2023 03:25:59 -0800
From:   "Garg, Nemesa" <nemesa.garg@intel.com>
To:     linux-kernel@vger.kernel.org, gfx-internal-devel@eclists.intel.com
Cc:     matthew.d.roper@intel.com, chaitanya.kumar.borah@intel.com,
        clinton.a.taylor@intel.com, Garg@vger.kernel.org,
        Nemesa <nemesa.garg@intel.com>
Subject: [PATCH dii-client 3/3] REVIEW: Full tree diff against origin/dii-client
Date:   Wed,  1 Mar 2023 16:54:45 +0530
Message-Id: <20230301112445.2207064-4-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301112445.2207064-1-nemesa.garg@intel.com>
References: <20230301112445.2207064-1-nemesa.garg@intel.com>
MIME-Version: 1.0
Content-Type: text/x-patch; charset=UTF-8
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

Auto-generated diff between origin/dii-client..dii-client
---
 drivers/gpu/drm/i915/i915_drv.h          |  2 ++
 drivers/gpu/drm/i915/intel_device_info.c |  7 +++++++
 drivers/gpu/drm/i915/intel_device_info.h |  1 +
 drivers/gpu/drm/i915/soc/intel_pch.c     |  6 ++++--
 include/drm/i915_pciids.h                | 11 +++++++++--
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index da3ee9b27747..0490fa282663 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -574,6 +574,8 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_M)
 #define IS_METEORLAKE_P(dev_priv) \
 	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_P)
+#define IS_ARROWLAKE_P(dev_priv) \
+	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_ARL_P)
 #define IS_DG2_G10(dev_priv) \
 	IS_SUBPLATFORM(dev_priv, INTEL_DG2, INTEL_SUBPLATFORM_G10)
 #define IS_DG2_G11(dev_priv) \
diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index 98769e5f2c3d..bda73201417f 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -224,6 +224,10 @@ static const u16 subplatform_p_ids[] = {
 	INTEL_MTL_P_IDS(0),
 };
 
+static const u16 subplatform_arl_p_ids[] = {
+	INTEL_ARL_P_IDS(0),
+};
+
 static bool find_devid(u16 id, const u16 *p, unsigned int num)
 {
 	for (; num; num--, p++) {
@@ -284,6 +288,9 @@ static void intel_device_info_subplatform_init(struct drm_i915_private *i915)
 	} else if (find_devid(devid, subplatform_p_ids,
 			      ARRAY_SIZE(subplatform_p_ids))) {
 		mask = BIT(INTEL_SUBPLATFORM_P);
+	} else if (find_devid(devid, subplatform_arl_p_ids,
+				ARRAY_SIZE(subplatform_arl_p_ids))) {
+		mask = BIT(INTEL_SUBPLATFORM_ARL_P);
 	}
 
 	GEM_BUG_ON(mask & ~INTEL_SUBPLATFORM_MASK);
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index 80bda653d61b..eba718d98482 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -131,6 +131,7 @@ enum intel_platform {
 /* MTL */
 #define INTEL_SUBPLATFORM_M	0
 #define INTEL_SUBPLATFORM_P	1
+#define INTEL_SUBPLATFORM_ARL_P 2
 
 enum intel_ppgtt_type {
 	INTEL_PPGTT_NONE = I915_GEM_PPGTT_NONE,
diff --git a/drivers/gpu/drm/i915/soc/intel_pch.c b/drivers/gpu/drm/i915/soc/intel_pch.c
index ba9843cb1b13..82ac8d978eef 100644
--- a/drivers/gpu/drm/i915/soc/intel_pch.c
+++ b/drivers/gpu/drm/i915/soc/intel_pch.c
@@ -171,7 +171,7 @@ intel_virt_detect_pch(const struct drm_i915_private *dev_priv,
 	 * make an educated guess as to which PCH is really there.
 	 */
 
-	if (IS_METEORLAKE(dev_priv))
+	if (IS_METEORLAKE(dev_priv) || IS_ARROWLAKE_P(dev_priv))
 		id = INTEL_PCH_MTP_DEVICE_ID_TYPE;
 	else if (IS_ALDERLAKE_S(dev_priv) || IS_ALDERLAKE_P(dev_priv))
 		id = INTEL_PCH_ADP_DEVICE_ID_TYPE;
@@ -223,7 +223,9 @@ void intel_detect_pch(struct drm_i915_private *dev_priv)
 	} else if (IS_DG2(dev_priv)) {
 		dev_priv->pch_type = PCH_DG2;
 		return;
-	}
+	} else if (IS_ARROWLAKE_P(dev_priv)) {
+		dev_priv->pch_type = PCH_MTP;
+		return;
 
 	/*
 	 * The reason to probe ISA bridge instead of Dev31:Fun0 is to
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 92205054e542..cc3f01c7e98b 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -738,15 +738,22 @@
 /* MTL */
 #define INTEL_MTL_M_IDS(info) \
 	INTEL_VGA_DEVICE(0x7D40, info), \
-	INTEL_VGA_DEVICE(0x7D60, info)
+	INTEL_VGA_DEVICE(0x7D41, info), \
+	INTEL_VGA_DEVICE(0x7D60, info), \
+	INTEL_VGA_DEVICE(0x7D67, info)
 
 #define INTEL_MTL_P_IDS(info) \
 	INTEL_VGA_DEVICE(0x7D45, info), \
 	INTEL_VGA_DEVICE(0x7D55, info), \
 	INTEL_VGA_DEVICE(0x7DD5, info)
 
+#define INTEL_ARL_P_IDS(info) \
+	INTEL_VGA_DEVICE(0x7D51, info), \
+	INTEL_VGA_DEVICE(0x7DD1, info)
+
 #define INTEL_MTL_IDS(info) \
 	INTEL_MTL_M_IDS(info), \
-	INTEL_MTL_P_IDS(info)
+	INTEL_MTL_P_IDS(info), \
+	INTEL_ARL_P_IDS(info)
 
 #endif /* _I915_PCIIDS_H */
--
git-pile 1.1

