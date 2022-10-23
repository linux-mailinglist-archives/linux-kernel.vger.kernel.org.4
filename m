Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9479D6092FC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJWMtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJWMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:49:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786475383;
        Sun, 23 Oct 2022 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666529332; x=1698065332;
  h=from:to:cc:subject:date:message-id;
  bh=EBDEp9fMFhSMNQl9t4zJ05KU6qeNGLZnGb/t5yOcmfY=;
  b=EfCgMhm1c6P+bf7gvhukjz/GLK+iSsN/2nUlRcN55x9MbFa9AZwhVD3J
   htFTvpLQDkOPWUFlbx/qNlubcJJjIeih0LFdyINFxZLV763NVY7kaOKVD
   QLgxLPBZaVP6FjrqpPXHNqdyJ2LsOjzEjhEI2KzT9jDxME37cqpPDVy9r
   nfhEDYn56lAb1aYhTCEfmgrlT9S5WZ7H8FDWvkNsZ6cxMZaYl/zejA5cx
   f6a4V+4TGmcUoS+d7JRRBFN4CcmOTIz+uirAQ+sywx9uNY1P3M+VASnXO
   ubZWDEjYYfrWSR+DMtcNraMbyC6AnmW5/X13HUOisTirT5hWgX9soqR3I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="308944499"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="308944499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 05:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="756303919"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="756303919"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2022 05:48:49 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com
Subject: [PATCH 1/2] perf/x86/rapl: Add support for Intel AlderLake-N
Date:   Sun, 23 Oct 2022 20:51:19 +0800
Message-Id: <20221023125120.2727-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AlderLake-N RAPL support is the same as previous Sky Lake.
Add AlderLake-N model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5ad..165c506cd37c 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -806,6 +806,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	{},
 };
-- 
2.25.1

