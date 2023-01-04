Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C566E65D59E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjADO3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjADO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:29:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFE1743A;
        Wed,  4 Jan 2023 06:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672842548; x=1704378548;
  h=from:to:cc:subject:date:message-id;
  bh=LjoN4gPM2Xqx189nas75Dz8thY4msPK/MRpkF+8Sm0w=;
  b=EroMluxrM0S4a6LWbRiVdkBK/rnVocJG5BTDc+SQKTFH3ydf3YnNmU20
   wdu7RfEE1r+oSC8fQ96mYFYqzQ6R4bCWZ3D1Zc218sDa5R85BNIZT2gJK
   i6OwiSqAFc+XYCRLdurBTASHCWd9+YZ9aFkSHaJtVMMd4lIf8gCfz33L/
   dj++vSwwC7KnqyfOt/RJkbdMm707oisxeP5J5IZJj0X7AxDjZlgdlKr4I
   VwH8KwxGSIjyj5lluHSz4s1/IFbxxaD8AtSvDrmasKkOsRFAXsNQ8I2hE
   +O8Nky3Dxrk/2f1CHMbQs4qWJ+B/f0kHA70BYrqME1KdQ3L7KLkct0eii
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319652435"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="319652435"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:29:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762684935"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762684935"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2023 06:29:06 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powercap: intel_rapl: add support for METEORLAKE
Date:   Wed,  4 Jan 2023 22:36:01 +0800
Message-Id: <20230104143602.23792-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add METEORLAKE to the list of supported processor models in the Intel
RAPL power capping driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 26d00b1853b4..ca6ff27b4384 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1113,6 +1113,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
-- 
2.25.1

