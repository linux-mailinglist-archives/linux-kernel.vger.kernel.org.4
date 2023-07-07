Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1414174A917
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGGCoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGGCox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:44:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55519A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688697892; x=1720233892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0xQCq0KTUe+3o4ZtkzB10P8MGevG2TAsZeWl9i/V1ck=;
  b=LrU5nWTiikmQh8KhLMcnzbWmzotojJUQR6Lxyu5xBJDvilExI08Tz67S
   +6cUTzXg1Lh4G8uOYvhn3FJZHI+vmY/gdL5lM/JVfo789LZddZs1+loHI
   f7V5L34EsRmXmYSGtkO2tse7AWy6cR006dnfUY00kmMI84mde/NyL5u+C
   9TDoXdgyFbKAZ0+zvD8QczXdJG48h6AhE/rEetEHfHxLUYjF31/qvzU4D
   imSKU9jRhtSrZA41FQepHPkMcWVqE0z0T0to8/PrwYvZaz95sWx70L0x7
   wHdYCHNDpef3QMlUsk1Fyt7zfLwCfraVyrsw+8mg+xUBSmhaSrRFXlNZd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="353626896"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="353626896"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 19:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="966463291"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="966463291"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.118])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 19:44:48 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, ricardo.neri-calderon@linux.intel.com
Subject: [PATCH] sched/fair: Remove repeated words in a comment
Date:   Fri,  7 Jul 2023 10:44:20 +0800
Message-Id: <20230707024420.93140-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated words in a comment.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..2d6f47eecb66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10700,8 +10700,8 @@ asym_active_balance(struct lb_env *env)
 	/*
 	 * ASYM_PACKING needs to force migrate tasks from busy but lower
 	 * priority CPUs in order to pack all tasks in the highest priority
-	 * CPUs. When done between cores, do it only if the whole core if the
-	 * whole core is idle.
+	 * CPUs. When done between cores, do it only if the whole core is
+	 * idle.
 	 *
 	 * If @env::src_cpu is an SMT core with busy siblings, let
 	 * the lower priority @env::dst_cpu help it. Do not follow
-- 
2.34.1

