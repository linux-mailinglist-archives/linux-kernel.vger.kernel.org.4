Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC476519D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiLTD7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTD7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:59:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D8E6254;
        Mon, 19 Dec 2022 19:59:50 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NbjVR0jvCzRq81;
        Tue, 20 Dec 2022 11:58:39 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 11:59:47 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <ravi.bangoria@amd.com>, <martin.lau@kernel.org>,
        <adrian.hunter@intel.com>, <ak@linux.intel.com>,
        <masami.hiramatsu.pt@hitachi.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 0/3] Fixes for debug variables
Date:   Tue, 20 Dec 2022 11:56:59 +0800
Message-ID: <20221220035702.188413-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch1 is a fix for debug_peo_args and redirect_to_stderr.
patch2 is a fix for the verbose variable.
patch3 is a correction for checking the quiet option.

Yang Jihong (3):
  perf tools: Set debug_peo_args and redirect_to_stderr to correct
    values in perf_quiet_option
  perf tools: Fix usage of the verbose variable
  perf probe: Check -v and -q options in the right place

 tools/perf/builtin-lock.c                   |  6 +++---
 tools/perf/builtin-probe.c                  | 17 +++++++++--------
 tools/perf/builtin-record.c                 |  4 ++--
 tools/perf/builtin-script.c                 |  2 +-
 tools/perf/builtin-stat.c                   |  4 ++--
 tools/perf/dlfilters/dlfilter-test-api-v0.c |  2 +-
 tools/perf/tests/builtin-test.c             |  2 +-
 tools/perf/tests/dlfilter-test.c            |  2 +-
 tools/perf/util/bpf_lock_contention.c       |  2 +-
 tools/perf/util/debug.c                     |  4 ++++
 tools/perf/util/dlfilter.c                  |  2 +-
 11 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.30.GIT

