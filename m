Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040B697C23
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjBOMqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBOMqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:46:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D6BB81;
        Wed, 15 Feb 2023 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676465206; x=1708001206;
  h=from:to:cc:subject:date:message-id;
  bh=XMsYh2wmI7gJI4wUfH8bLNGEEGMD/YuTAXHzbBS5eRo=;
  b=EdctLciNBxTpg/1EHQQMhczO+lmD9HDokwO+/vM5+/bHBRQXRQNGuzdR
   3u+OPk/3x3SrlN5wgyh+uENHLINT21STp1b9za+tAitbYRHAzmYkzltC3
   99VyC5dfLUPkKIUgVkSULS/7JGD/cnOvMgq/fPQqPl4kNjf3iABHSSbvE
   CrQ1YMTvEsZ9es+UqAaRgErVBXNsi8lFfUbADOx1IKoYURLatixHSc9ub
   +ZK2UA5AAzzpi4lVUzqUdQh0fsRSD+QdgxLJgLfawRV6kysjJyb4SEjAw
   9TuqBR6prCikbS768NRGK6dcev56fesfTGBdrnqsDOT4mCR5nllAbiZjR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311783937"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="311783937"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778773753"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="778773753"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by fmsmga002.fm.intel.com with ESMTP; 15 Feb 2023 04:46:44 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: RAPL: Add Power Limit4 support for Meteor Lake SoC
Date:   Wed, 15 Feb 2023 18:02:49 +0530
Message-Id: <20230215123249.4473-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Meteor Lake SoC to the list of processor models for which
Power Limit4 is supported by the Intel RAPL driver.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/powercap/intel_rapl_msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index bc6adda58883..a27673706c3d 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -143,6 +143,8 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE, X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE_L, X86_FEATURE_ANY },
 	{}
 };
 
-- 
2.17.1

