Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487BC730C15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjFOASg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjFOASL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:18:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF70212C;
        Wed, 14 Jun 2023 17:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686788290; x=1718324290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZXASlYjjvVdCvbUa3jANIWB5T9bW3KeIVToNgdODp7k=;
  b=YB9QJgiG9sKp9uP+ayB5UgmWermFB5PZzr+z2Pp8dSneVfYtuqebFD9D
   2urC4bPZS5vnItMGfvu5+juHZpxdTHGzQudNRA/gYXOEuZ1Xj0P0Rrxp9
   Vq8MNLSZektgTXlk9jE39kHw40uVMtQ/JUt9J92Xb1N5TWzoSDMKvTEzH
   NTwboQK5t8Ni+zrttqzA1xpulCoTYN9/pLHSI3lOgzmDBsHrcGmWqKPnH
   DOgVLj2BhGcO3+QzS13Unl1cAkTDfJSrx5wDsY4pz4BAvSGjabWcyZ69t
   Oz+dIf4gT1H+l1PV73rp2hOkVEFxI2FMWZCVQYXI87jgDfGQwZxPpZOmX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="357652519"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="357652519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="825021505"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="825021505"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2023 17:18:02 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 6/8] pert tests: Update metric-value for perf stat JSON output
Date:   Wed, 14 Jun 2023 17:17:33 -0700
Message-Id: <20230615001735.3643996-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230615001735.3643996-1-kan.liang@linux.intel.com>
References: <20230615001735.3643996-1-kan.liang@linux.intel.com>
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

