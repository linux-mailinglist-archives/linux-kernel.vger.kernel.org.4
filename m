Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510506603E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjAFQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjAFQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:05:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA106A0CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673021107; x=1704557107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ri+4ibZMX3GOsl5AyTBUXhX5n8y+EO6HdQPGGFh1onU=;
  b=lcGCgygdx/a9fFeH9Q2dE9fdf4q3TrgsKIa3IOqt6CftnnUqItwawo/5
   XuMVmFcJFuK0XI1n/HFuBhQ1jecurVgrW5kGPSz+x2n6zG5Jn+NqCta7e
   kMJJ+S+cHFGr8ecmvh927COIUCZqLCfnM18PTTeYPrurbRJnzrXm7yuF1
   o1UdAgC5TL5DauESzSiKyd21p+4P8H2t30ogqc+NyC7G1cZsGCYVyWVy4
   hWOEoZxh4VY5NS9DEFnKJJp3gQ7vus/8nWNFaXJqgG5hbWA1lBgxZrldq
   04Opt/Se/lLHJK9Z/Cjm9H91tVioDKt/mS4vOoi0EC9d+K8gYKno5rDUt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="302199911"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="302199911"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 08:05:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="633521613"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="633521613"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2023 08:05:04 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf/x86/intel: Add Emerald Rapids
Date:   Fri,  6 Jan 2023 08:04:46 -0800
Message-Id: <20230106160449.3566477-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From core PMU's perspective, Emerald Rapids is the same as the Sapphire
Rapids. The only difference is the event list, which will be
supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 29d2d0411caf..72943243c95c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6487,6 +6487,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case INTEL_FAM6_EMERALDRAPIDS_X:
 		pmem = true;
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
-- 
2.35.1

