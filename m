Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DA4731A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbjFONzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344469AbjFONyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:54:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4A1FD5;
        Thu, 15 Jun 2023 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837282; x=1718373282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jazqzmxuygKHAVF1T3XyECyr+VZwL4+XwB2HASyrSgQ=;
  b=ADYGDOf3H+cdA92Ar+vhVwGS/K3msFYJKp68j/WHgNmfJbozrTlpdaxi
   wxKvXdT3ZZOw8COcUajuHlZnRaUpWTvoSVFgzeuBZhTzWu2HwCCNw5sy6
   E7tIcw1Us2EXpNqAsVekoZfOVt/ky5LW1YRaAbURapoGZ6sqrwdk6K9Q8
   VE+H4LQkqX/Fv1x294Pq8bi8llBWRLArLXHz60DwScbo3F51wG+DNeA6M
   nYYSZOGRyawnb5kE3Zij8k55VPQtU2dad5GumZbR3I3nlVey3zKsRBBDK
   gPKH4eBSv/YrBdifmII6piqGgw9xsuSNPpCcKbd9aGtBXHORXgRGVMLE2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356411418"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356411418"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782527066"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782527066"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 06:54:40 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 6/8] pert tests: Update metric-value for perf stat JSON output
Date:   Thu, 15 Jun 2023 06:53:13 -0700
Message-Id: <20230615135315.3662428-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230615135315.3662428-1-kan.liang@linux.intel.com>
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There may be multiplexing triggered, e.g., e-core of ADL.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 5e9bd68c83fe..ea55d5ea1ced 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -66,10 +66,10 @@ def check_json_output(expected_items):
   for item in json.loads(input):
     if expected_items != -1:
       count = len(item)
-      if count != expected_items and count >= 1 and count <= 4 and 'metric-value' in item:
+      if count != expected_items and count >= 1 and count <= 6 and 'metric-value' in item:
         # Events that generate >1 metric may have isolated metric
-        # values and possibly other prefixes like interval, core and
-        # aggregate-number.
+        # values and possibly other prefixes like interval, core,
+        # aggregate-number, or event-runtime/pcnt-running from multiplexing.
         pass
       elif count != expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
         pass
-- 
2.35.1

