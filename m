Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A865D5A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjADO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjADO3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:29:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A712AE1;
        Wed,  4 Jan 2023 06:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672842549; x=1704378549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hdFrVFJWV/kkaBDSXJkUe7wBua0nhiEPIaDdE0DhSK0=;
  b=R3vH3BinS88mzJTjI4cvFQfB+FVVJEoSWjIyYjn1PBmB+vmwCmqj68mA
   RMiSjbrPcbB2pH2ctoiuL90e23hfd7jSCAOzd5dQ1PG8aeYW0Hid7umfd
   W8HfqNXvYouYrZXYLyN09wnn5Def3tRks9f35quccNJWBBrurG++PwtcM
   84lW9PmnFEAIHpDUS0TMntm/luUzhf8zCyT+5v+ADwmEbBab8d4hG2tgq
   WmAsqrYiU1B6+Ze9VLVo5nwRnXiZDAJrhI8+DOuW2vBWXr3qLh6uADZhO
   a1tgN9sCNAIcZQ+Y2+tks9UZ2DL+SGX1rimCwedIhYcJPLWHXF68A6wYn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319652440"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="319652440"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:29:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762684939"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762684939"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2023 06:29:08 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powercap: intel_rapl: add support for EMERALDRAPIDS
Date:   Wed,  4 Jan 2023 22:36:02 +0800
Message-Id: <20230104143602.23792-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230104143602.23792-1-rui.zhang@intel.com>
References: <20230104143602.23792-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EMERALDRAPIDS to the list of supported processor models in the Intel
RAPL power capping driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index ca6ff27b4384..9a9192fc8391 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1116,6 +1116,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-- 
2.25.1

