Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7AA6EC946
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDXJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjDXJok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:44:40 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DCB26B0;
        Mon, 24 Apr 2023 02:44:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VgsU8kx_1682329472;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VgsU8kx_1682329472)
          by smtp.aliyun-inc.com;
          Mon, 24 Apr 2023 17:44:33 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v2 5/5] perf vendor events: Add JSON metrics for Yitian 710 DDR
Date:   Mon, 24 Apr 2023 17:44:16 +0800
Message-Id: <1682329456-19418-6-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for T-HEAD Yitian 710 SoC DDR.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/freescale/yitian710/sys/metrics.json  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
new file mode 100644
index 0000000..1a92477
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
+		"Unit": "ali_drw",
+		"Compat": "ali_drw_pmu"
+	},
+	{
+		"MetricName": "ddr_write_bandwidth.all",
+		"BriefDescription": "The ddr write bandwidth(MB/s).",
+		"MetricGroup": "ddr",
+		"MetricExpr": "(hif_wr + hif_rmw) * 64 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "ali_drw",
+		"Compat": "ali_drw_pmu"
+	}
+]
-- 
1.8.3.1

