Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF488606227
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJTNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJTNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:47:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 033431A9133;
        Thu, 20 Oct 2022 06:47:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74163ED1;
        Thu, 20 Oct 2022 06:47:58 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.5.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D5093F67D;
        Thu, 20 Oct 2022 06:47:49 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, john.garry@huawei.com,
        acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, nick.forrington@arm.com,
        al.grant@arm.com, James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf vendor events: Add Arm Neoverse V2 PMU events
Date:   Thu, 20 Oct 2022 14:45:11 +0100
Message-Id: <20221020134512.1345013-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the neoverse-n2 folder to make it clear that it includes V2, and
add V2 to mapfile.csv. V2 has the same events as N2, visible by running
the following command in the ARM-software/data github repo [1]:

  diff pmu/neoverse-v2.json pmu/neoverse-n2.json | grep code

Testing:

  $ perf test pmu

  10: PMU events                                           :
  10.1: PMU event table sanity                             : Ok
  10.2: PMU event map aliases                              : Ok
  10.3: Parsing of PMU event table metrics                 : Ok
  10.4: Parsing of PMU event table metrics with fake PMUs  : Ok

[1]: https://github.com/ARM-software/data

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/branch.json | 0
 .../arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/bus.json    | 0
 .../arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/cache.json  | 0
 .../arm64/arm/{neoverse-n2 => neoverse-n2-v2}/exception.json   | 0
 .../arm64/arm/{neoverse-n2 => neoverse-n2-v2}/instruction.json | 0
 .../arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/memory.json | 0
 .../arm64/arm/{neoverse-n2 => neoverse-n2-v2}/pipeline.json    | 0
 .../arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/spe.json    | 0
 .../arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/trace.json  | 0
 tools/perf/pmu-events/arch/arm64/mapfile.csv                   | 3 ++-
 10 files changed, 2 insertions(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/branch.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/bus.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/cache.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/exception.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/instruction.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/memory.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/pipeline.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/spe.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/trace.json (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/branch.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/bus.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/bus.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/cache.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/instruction.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/instruction.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/pipeline.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/pipeline.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json
rename to tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index ad502d00f460..f134e833c069 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -34,7 +34,8 @@
 0x00000000410fd460,v1,arm/cortex-a510,core
 0x00000000410fd470,v1,arm/cortex-a710,core
 0x00000000410fd480,v1,arm/cortex-x2,core
-0x00000000410fd490,v1,arm/neoverse-n2,core
+0x00000000410fd490,v1,arm/neoverse-n2-v2,core
+0x00000000410fd4f0,v1,arm/neoverse-n2-v2,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000460f0010,v1,fujitsu/a64fx,core
-- 
2.28.0

