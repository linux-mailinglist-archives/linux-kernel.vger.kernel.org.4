Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05576370D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKXDNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKXDNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:13:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4AC63BA1;
        Wed, 23 Nov 2022 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669259578; x=1700795578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4prZrIQunAyEs+pfZpyW80IqX42i4VR3coK0+MOxgM=;
  b=eIX5prSTDz5jMIdJaRgI1xFO7nT3lz9caDnR/d3BajxpwYL/+hnFpcZp
   6WAj5ffyebSEghE/thbM5djl29DprM+AOa1VnDHn+DXu8q2OmlREYgzBE
   V0durR4Zf1JDMsCdGAQ4xfYGu+Wa/mZnoJ0W5zcklJk95BiuRYEfL0Oal
   gm9kfePyyCLzY48bgtatgmytg7Bekt7PfAUazI3o2tRmlCQ64EJ4NDG8G
   HF1LgdVhkmK+vsAE6w9fi9aqJQsj9jK4t0fb/WBXTuPNDAYoPTuwIpkl+
   lXVhopbOI+G77SghDmdf13oPvuYBJhHmkfuV8sWZaaD+NlUj+GlHwxPIa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="316025749"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="316025749"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 19:12:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644330831"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="644330831"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2022 19:12:48 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH v3 2/4] perf vendor events intel: Add uncore event list for Alderlake-N
Date:   Thu, 24 Nov 2022 11:14:39 +0800
Message-Id: <20221124031441.110134-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124031441.110134-1-zhengjun.xing@linux.intel.com>
References: <20221124031441.110134-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Add JSON uncore events for Alderlake-N

Based on JSON list v1.16:

https://github.com/intel/perfmon/tree/main/ADL/events/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Ian Rogers <irogers@google.com>
---
Change log:
  v3:
    * Adds "Acked-by" from Ian Rogers <irogers@google.com>

  v2:
    * Regenerate the uncore event list with the new converter scripts.
      (https://github.com/intel/perfmon/pull/32 and add the ADL-N fix)

 .../arch/x86/alderlaken/uncore-memory.json    | 175 ++++++++++++++++++
 .../arch/x86/alderlaken/uncore-other.json     |  33 ++++
 2 files changed, 208 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
new file mode 100644
index 000000000000..2ccd9cf96957
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
@@ -0,0 +1,175 @@
+[
+    {
+        "BriefDescription": "Counts every 64B read  request entering the Memory Controller 0 to DRAM (sum of all channels).",
+        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every 64B read request entering the Memory Controller 0 to DRAM (sum of all channels).",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B write request entering the Memory Controller 0 to DRAM (sum of all channels). Each write request counts as a new request incrementing this counter. However, same cache line write requests (both full and partial) are combined to a single 64 byte data transfer to DRAM.",
+        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B read request entering the Memory Controller 1 to DRAM (sum of all channels).",
+        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts every 64B read entering the Memory Controller 1 to DRAM (sum of all channels).",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B write request entering the Memory Controller 1 to DRAM (sum of all channels). Each write request counts as a new request incrementing this counter. However, same cache line write requests (both full and partial) are combined to a single 64 byte data transfer to DRAM.",
+        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a read request sent to DRAM",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_ACT_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command sent to DRAM",
+        "EventCode": "0x26",
+        "EventName": "UNC_M_ACT_COUNT_TOTAL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a write request sent to DRAM",
+        "EventCode": "0x25",
+        "EventName": "UNC_M_ACT_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS command sent to DRAM",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_CAS_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write CAS command sent to DRAM",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_CAS_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of clocks",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Empty",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Empty",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Hit",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Hit",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Miss",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Miss",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Hot state",
+        "EventCode": "0x19",
+        "EventName": "UNC_M_DRAM_THERMAL_HOT",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Warm state",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M_DRAM_THERMAL_WARM",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read prefetch request from IA.",
+        "EventCode": "0x0A",
+        "EventName": "UNC_M_PREFETCH_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command sent to DRAM due to page table idle timer expiration",
+        "EventCode": "0x28",
+        "EventName": "UNC_M_PRE_COUNT_IDLE",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command sent to DRAM for a read/write request",
+        "EventCode": "0x27",
+        "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 read request",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_VC0_REQUESTS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 write request",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_VC0_REQUESTS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 read request",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_VC1_REQUESTS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 write request",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_VC1_REQUESTS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
new file mode 100644
index 000000000000..f9e7777cd2be
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
@@ -0,0 +1,33 @@
+[
+    {
+        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "CLOCK"
+    }
+]
-- 
2.25.1

