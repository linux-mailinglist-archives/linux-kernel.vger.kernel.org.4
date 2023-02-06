Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AE68C30F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBFQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBFQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:21:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE0E4EED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675700464; x=1707236464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yuXZRjRm7tCGuBSnfwstn4+vFjvD12EliJOXuHUYabY=;
  b=ldNcS6C/bcGuqQK7ZM13fgQ+nUDi3w23/A0HK1kJHU0gsIzZPRHmWabZ
   5qJh4yPZiesEr6dTO3106zLMVfUpKRB+7h+LBcvaKZMNPvIRvRw4er3qO
   PRPfqkGH555HEcWMF9oW+cbau2/ZVBaVmE+w8vhrvO+iMoOjq+NeDfEAT
   3nWw2h/hF01P4MVleu/cgucf8L1A4uEges5YRx7RdVT851DozzH8UKdWL
   cTgs74NdDyKDHBV3VMauYD3WbVhGW+l+RwNSUemRNRQsop3Bttd6PMaQH
   pCHxu6LmKxMbfiVe2OO7aay3KozhcB6NMXbevttd1ec8DYyQn+FhtsRAk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="356603971"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356603971"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995364402"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995364402"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2023 08:21:02 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 2/2] perf script: Fix missing Retire Latency fields option documentation
Date:   Mon,  6 Feb 2023 08:21:00 -0800
Message-Id: <20230206162100.3329395-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230206162100.3329395-1-kan.liang@linux.intel.com>
References: <20230206162100.3329395-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The 'perf script' documentation is missing the fields option for Retire
Latency. Add it.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index a2ebadc9d948..777a0d8ba7d1 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -134,7 +134,7 @@ OPTIONS
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
         phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
-        machine_pid, vcpu, cgroup.
+        machine_pid, vcpu, cgroup, retire_lat.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
-- 
2.35.1

