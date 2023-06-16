Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5415A7325C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbjFPDQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbjFPDPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:15:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C52948;
        Thu, 15 Jun 2023 20:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686885304; x=1718421304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBEPmh61zw29Ct+zyG/HNLraCxjB9FpFXjiQ320MNR4=;
  b=ipI9nUXfi6AHSVf2U4Xf6+pdgEH5AAMXdIcZUoJS9uwY8KE2/BEEkh13
   7ksc2Z/IuvPqSEzKzg+DCy+NUfwTsR3CPIw7n8cxMIHTAEwOd9Yl7nhqA
   AurjQEpxipdVilb2m4jvBXBpNOD9m8imtqeBtLO4+KCqFW35rSY0pRCxT
   i5jcURPeMyCt2SIKIR7/oeI2X6FoXXp3j9wojV6hY4hOkRqVY+0vjvCnx
   yORx7DtVPKSBvTcDmZq5JqIHpsVlUgoh7f++hBd/00x+cP72LueQtqEHL
   kdsCJVIWDUItdxtNf87TFB/t7oX6+trZU8+7g3CGxIagqFMw5/Mvd03Px
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338718231"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="338718231"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825555636"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="825555636"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 20:14:57 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH V4 5/5] perf vendor events arm64: Add default tags for Hisi hip08 L1 metrics
Date:   Thu, 15 Jun 2023 20:14:20 -0700
Message-Id: <20230616031420.3751973-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230616031420.3751973-1-kan.liang@linux.intel.com>
References: <20230616031420.3751973-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add the default tags for Hisi hip08 as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: John Garry <john.g.garry@oracle.com>
---
 .../arch/arm64/hisilicon/hip08/metrics.json          | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
index 6443a061e22a..6463531b9941 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -3,28 +3,32 @@
         "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
         "PublicDescription": "Frontend bound L1 topdown metric",
         "BriefDescription": "Frontend bound L1 topdown metric",
-        "MetricGroup": "TopDownL1",
+        "DefaultMetricgroupName": "TopDownL1",
+        "MetricGroup": "Default;TopDownL1",
         "MetricName": "frontend_bound"
     },
     {
         "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
         "PublicDescription": "Bad Speculation L1 topdown metric",
         "BriefDescription": "Bad Speculation L1 topdown metric",
-        "MetricGroup": "TopDownL1",
+        "DefaultMetricgroupName": "TopDownL1",
+        "MetricGroup": "Default;TopDownL1",
         "MetricName": "bad_speculation"
     },
     {
         "MetricExpr": "INST_RETIRED / (CPU_CYCLES * 4)",
         "PublicDescription": "Retiring L1 topdown metric",
         "BriefDescription": "Retiring L1 topdown metric",
-        "MetricGroup": "TopDownL1",
+        "DefaultMetricgroupName": "TopDownL1",
+        "MetricGroup": "Default;TopDownL1",
         "MetricName": "retiring"
     },
     {
         "MetricExpr": "1 - (frontend_bound + bad_speculation + retiring)",
         "PublicDescription": "Backend Bound L1 topdown metric",
         "BriefDescription": "Backend Bound L1 topdown metric",
-        "MetricGroup": "TopDownL1",
+        "DefaultMetricgroupName": "TopDownL1",
+        "MetricGroup": "Default;TopDownL1",
         "MetricName": "backend_bound"
     },
     {
-- 
2.35.1

