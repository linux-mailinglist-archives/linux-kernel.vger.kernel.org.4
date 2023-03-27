Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA096C99B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjC0Cqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjC0Cqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:46:32 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835649CE;
        Sun, 26 Mar 2023 19:46:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VeeqFQN_1679885186;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VeeqFQN_1679885186)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 10:46:27 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH RFC 4/4] perf vendor events: Add JSON metrics for Yitian 710 DDR
Date:   Mon, 27 Mar 2023 10:46:12 +0800
Message-Id: <1679885172-95021-5-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for T-HEAD Yitian 710 SoC DDR.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
 .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
 tools/perf/pmu-events/jevents.py                   |   1 +
 3 files changed, 394 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
new file mode 100644
index 0000000..cb8694b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
@@ -0,0 +1,373 @@
+[
+	{
+		"BriefDescription": "A Write or Read Op at HIF interface. 64B",
+		"ConfigCode": "0x0",
+		"EventName": "hif_rd_or_wr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Write Op at HIF interface. 64B",
+		"ConfigCode": "0x1",
+		"EventName": "hif_wr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710" 
+	},
+	{
+		"BriefDescription": "A Read Op at HIF interface. 64B",
+		"ConfigCode": "0x2",
+		"EventName": "hif_rd",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Read-Modify-Write Op at HIF interface. 64B",
+		"ConfigCode": "0x3",
+		"EventName": "hif_rmw",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A high priority Read at HIF interface. 64B",
+		"ConfigCode": "0x4",
+		"EventName": "hif_hi_pri_rd",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A write data cycle at DFI interface (to DRAM)",
+		"ConfigCode": "0x7",
+		"EventName": "dfi_wr_data_cycles",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A read data cycle at DFI interface (to DRAM).",
+		"ConfigCode": "0x8",
+		"EventName": "dfi_rd_data_cycles",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A high priority read becomes critical.",
+		"ConfigCode": "0x9",
+		"EventName": "hpr_xact_when_critical",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"  
+	},
+	{
+		"BriefDescription": "A low priority read becomes critical.",
+		"ConfigCode": "0xA",
+		"EventName": "lpr_xact_when_critical",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A write becomes critical.",
+		"ConfigCode": "0xB",
+		"EventName": "wr_xact_when_critical",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "An Activate (ACT) command to DRAM.",
+		"ConfigCode": "0xC",
+		"EventName": "op_is_activate",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Read or Write CAS command to DRAM.",
+		"ConfigCode": "0xD",
+		"EventName": "op_is_rd_or_wr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "An ACT command for read to DRAM.",
+		"ConfigCode": "0xE",
+		"EventName": "op_is_rd_activate",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Read CAS command to DRAM.",
+		"ConfigCode": "0xF",
+		"EventName": "op_is_rd",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Write CAS command to DRAM.",
+		"ConfigCode": "0x10",
+		"EventName": "op_is_wr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Masked Write command to DRAM.",
+		"ConfigCode": "0x11",
+		"EventName": "op_is_mwr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Precharge (PRE) command to DRAM.",
+		"ConfigCode": "0x12",
+		"EventName": "op_is_precharge",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A PRE required by read or write.",
+		"ConfigCode": "0x13",
+		"EventName": "precharge_for_rdwr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A PRE required by other conditions.",
+		"ConfigCode": "0x14",
+		"EventName": "precharge_for_other",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A read-write turnaround.",
+		"ConfigCode": "0x15",
+		"EventName": "rdwr_transitions",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A write combine (merge) in write data buffer.",
+		"ConfigCode": "0x16",
+		"EventName": "write_combine",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Write-After-Read hazard.",
+		"ConfigCode": "0x17",
+		"EventName": "war_hazard",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Read-After-Write hazard.",
+		"ConfigCode": "0x18",
+		"EventName": "raw_hazard",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A Write-After-Write hazard.",
+		"ConfigCode": "0x19",
+		"EventName": "waw_hazard",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank0 enters self-refresh (SRE).",
+		"ConfigCode": "0x1A",
+		"EventName": "op_is_enter_selfref_rk0",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank1 enters self-refresh (SRE).",
+		"ConfigCode": "0x1B",
+		"EventName": "op_is_enter_selfref_rk1",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank2 enters self-refresh (SRE).",
+		"ConfigCode": "0x1C",
+		"EventName": "op_is_enter_selfref_rk2",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank3 enters self-refresh (SRE).",
+		"ConfigCode": "0x1D",
+		"EventName": "op_is_enter_selfref_rk3",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank0 enters power-down (PDE).",
+		"ConfigCode": "0x1E",
+		"EventName": "op_is_enter_powerdown_rk0",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank1 enters power-down (PDE).",
+		"ConfigCode": "0x1F",
+		"EventName": "op_is_enter_powerdown_rk1",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank2 enters power-down (PDE).",
+		"ConfigCode": "0x20",
+		"EventName": "op_is_enter_powerdown_rk2",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "Rank3 enters power-down (PDE).",
+		"ConfigCode": "0x21",
+		"EventName": "op_is_enter_powerdown_rk3",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A cycle that Rank0 stays in self-refresh mode.",
+		"ConfigCode": "0x26",
+		"EventName": "selfref_mode_rk0",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A cycle that Rank1 stays in self-refresh mode.",
+		"ConfigCode": "0x27",
+		"EventName": "selfref_mode_rk1",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A cycle that Rank2 stays in self-refresh mode.",
+		"ConfigCode": "0x28",
+		"EventName": "selfref_mode_rk2",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A cycle that Rank3 stays in self-refresh mode.",
+		"ConfigCode": "0x29",
+		"EventName": "selfref_mode_rk3",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "An auto-refresh (REF) command to DRAM.",
+		"ConfigCode": "0x2A",
+		"EventName": "op_is_refresh",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A critical REF command to DRAM.",
+		"ConfigCode": "0x2B",
+		"EventName": "op_is_crit_ref",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "An MRR or MRW command to DRAM.",
+		"ConfigCode": "0x2D",
+		"EventName": "op_is_load_mode",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A ZQCal command to DRAM.",
+		"ConfigCode": "0x2E",
+		"EventName": "op_is_zqcl",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "At least one entry in read queue reaches the visible window limit.",
+		"ConfigCode": "0x30",
+		"EventName": "visible_window_limit_reached_rd",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "At least one entry in write queue reaches the visible window limit.",
+		"ConfigCode": "0x31",
+		"EventName": "visible_window_limit_reached_wr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A DQS Oscillator MPC command to DRAM.",
+		"ConfigCode": "0x34",
+		"EventName": "op_is_dqsosc_mpc",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A DQS Oscillator MRR command to DRAM.",
+		"ConfigCode": "0x35",
+		"EventName": "op_is_dqsosc_mrr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A TCR (Temperature Compensated Refresh) MRR command to DRAM.",
+		"ConfigCode": "0x36",
+		"EventName": "op_is_tcr_mrr",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A ZQCal Start command to DRAM.",
+		"ConfigCode": "0x37",
+		"EventName": "op_is_zqstart",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A ZQCal Latch command to DRAM.",
+		"ConfigCode": "0x38",
+		"EventName": "op_is_zqlatch",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A packet at CHI TXREQ interface (request).",
+		"ConfigCode": "0x39",
+		"EventName": "chi_txreq",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A packet at CHI TXDAT interface (read data).",
+		"ConfigCode": "0x3A",
+		"EventName": "chi_txdat",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A packet at CHI RXDAT interface (write data).",
+		"ConfigCode": "0x3B",
+		"EventName": "chi_rxdat",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A packet at CHI RXRSP interface.",
+		"ConfigCode": "0x3C",
+		"EventName": "chi_rxrsp",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "A violation detected in TZC.",
+		"ConfigCode": "0x3D",
+		"EventName": "tsz_vio",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"BriefDescription": "The ddr cycle.",
+		"ConfigCode": "0x80",
+		"EventName": "cycle",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
new file mode 100644
index 0000000..c14ecac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
@@ -0,0 +1,20 @@
+[
+	{
+		"MetricName": "ddr_read_bandwidth.all",
+		"BriefDescription": "The ddr read bandwidth(MB/s).",
+		"MetricGroup": "ddr",
+		"MetricExpr": "hif_rd * 64 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	},
+	{
+		"MetricName": "ddr_write_bandwidth.all",
+		"BriefDescription": "The ddr write bandwidth(MB/s).",
+		"MetricGroup": "ddr",
+		"MetricExpr": "(hif_wr + hif_rmw) * 64 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "yitian710_ddr",
+		"Compat": "ali_drw_yitian710"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 20ed492..8cfb4b6 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -257,6 +257,7 @@ class JsonEvent:
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
           'cmn700': 'cmn700',
+          'yitian710_ddr': 'yitian710_ddr',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
-- 
1.8.3.1

