Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCA6020BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJRCCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJRCCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0935580515;
        Mon, 17 Oct 2022 19:02:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c24so12458098pls.9;
        Mon, 17 Oct 2022 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dXiBhtiiGX2gaVqn8atJkfkWgiCpu0hyyh6MvxjNUNM=;
        b=dC2GSUOJYa46BbAmpzD3phhO+UpqHHX3pWxr425U2IfMJRilj2zHjhCicyv8rcHQ04
         07AfVqi55PKSjQJvB8Uiwck8nzHjj40TcaA/aeAWXcNmhNOKEDWbimEKiUFIadt0RMMh
         yvOKMFloqvlaPtTCGlXgyvhV2WOLE7DgpQ/Inw0FVgkEKeBJbP+bEixPyL2WeN0zV7sI
         wJE/Jj6Z0JaycKoBrEOHtiav6pS8HnOaGryaoKC54j7gC0CHEZHkOBtD1apXhiKJcTnk
         AKPcDNpRJTyy0FNY6dgiCWeqSKkL+P4ApffS2nkp6SwbWADTKNa7qKNQKzVfyQSfcKyC
         goVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXiBhtiiGX2gaVqn8atJkfkWgiCpu0hyyh6MvxjNUNM=;
        b=tCxr6ll08ePvH926yqLTy15JtKCdugbWBOY+QfnXqn9cQ5RWAhvQMm+gHP5lMHDc/k
         8e9K2DC1Kx34IX0BGoX8/kruDXST3RjEN5Ed4aMM/aCuSaq/g9fqndPd7/FW/vjeXXmW
         t/mf/2T9XK7j07a6wD8NPbpIpzhxVjflLoM5uiUr7bNYAAPusFjjaH/1l0x1tflRWMvM
         ctDUD2y8229Dnr5PJrtl03uvdPRsFOFQcBsh0fxHocor/9flgrobdU72fHxtv17oHocQ
         DWxxAxqeURBADjeeB/SD8WmNuIMvHPD2xKegHDcG2dCQNj2LkYm6w86MaE5KpKHX1EqW
         cxbQ==
X-Gm-Message-State: ACrzQf1QUmyCgkGx8kgTveQuEDzfkXohGDbLtKeByiNdh+3E0VY3P3fd
        ZBsfX0YbS5lmL/SUmki6jYU=
X-Google-Smtp-Source: AMsMyM7Or8rTGWNsBW7Six7djZS/6QrXCd5/sq/0KSE1DRRd/WAMjwDzHS067zBCYMTWz0J49PIm6A==
X-Received: by 2002:a17:903:247:b0:179:b5e1:54b7 with SMTP id j7-20020a170903024700b00179b5e154b7mr607858plh.84.1666058550327;
        Mon, 17 Oct 2022 19:02:30 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCHSET 00/20] perf stat: Cleanup counter aggregation (v3)
Date:   Mon, 17 Oct 2022 19:02:07 -0700
Message-Id: <20221018020227.85905-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Current perf stat code is somewhat hard to follow since it handles
many combinations of PMUs/events for given display and aggregation
options.  This is my attempt to clean it up a little. ;-)

changes in v3)
 * fix cgroup event display
 * fix perf test failures  (Arnaldo)
 * add comment on the global debug output  (Athira)

changes in v2)
 * fix a segfault in perf stat report for per-process record  (Jiri)
 * fix metric only display  (Jiri)
 * add evsel__reset_aggr_stat  (ian)
 * add more comments  (Ian)
 * add Acked-by from Ian


My first concern is that aggregation and display routines are intermixed
and processed differently depends on the aggregation mode.  I'd like to
separate them apart and make the logic clearer.

To do that, I added struct perf_stat_aggr to save the aggregated counter
values and other info.  It'll be allocated and processed according to
the aggr_mode and display logic will use it.

I've tested the following combination.

  $ cat test-matrix.sh
  #!/bin/sh

  set -e

  yes > /dev/null &
  TARGET=$!

  ./perf stat true
  ./perf stat -a true
  ./perf stat -C0 true
  ./perf stat -p $TARGET true
  ./perf stat -t $TARGET true

  ./perf stat -a -A true
  ./perf stat -a --per-node true
  ./perf stat -a --per-socket true
  ./perf stat -a --per-die true
  ./perf stat -a --per-core true
  ./perf stat -a --per-thread true

  ./perf stat -a -I 500 sleep 1
  ./perf stat -a -I 500 --summary sleep 1
  ./perf stat -a -I 500 --per-socket sleep 1
  ./perf stat -a -I 500 --summary --per-socket sleep 1

  ./perf stat -a --metric-only true
  ./perf stat -a --metric-only --per-socket true
  ./perf stat -a --metric-only -I 500 sleep 1
  ./perf stat -a --metric-only -I 500 --per-socket sleep 1

  ./perf stat record true && ./perf stat report
  ./perf stat record -p $TARGET true && ./perf stat report
  ./perf stat record -a true && ./perf stat report
  ./perf stat record -a --per-core true && ./perf stat report
  ./perf stat record -a --per-core --metric-only true && ./perf stat report
  ./perf stat record -a -I 500 sleep 1 && ./perf stat report
  ./perf stat record -a -I 500 --per-core sleep 1 && ./perf stat report
  ./perf stat record -a -I 500 --per-core --metric-only sleep 1 && ./perf stat report

  ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ true
  ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ --percore-show-thread true

  kill $TARGET

The code is available at 'perf/stat-aggr-v3' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (20):
  perf tools: Save evsel->pmu in parse_events()
  perf tools: Use pmu info in evsel__is_hybrid()
  perf stat: Use evsel__is_hybrid() more
  perf stat: Add aggr id for global mode
  perf stat: Add cpu aggr id for no aggregation mode
  perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
  perf stat: Add struct perf_stat_aggr to perf_stat_evsel
  perf stat: Allocate evsel->stats->aggr properly
  perf stat: Aggregate events using evsel->stats->aggr
  perf stat: Factor out evsel__count_has_error()
  perf stat: Aggregate per-thread stats using evsel->stats->aggr
  perf stat: Allocate aggr counts for recorded data
  perf stat: Reset aggr counts for each interval
  perf stat: Split process_counters()
  perf stat: Add perf_stat_merge_counters()
  perf stat: Add perf_stat_process_percore()
  perf stat: Add perf_stat_process_shadow_stats()
  perf stat: Display event stats using aggr counts
  perf stat: Display percore events properly
  perf stat: Remove unused perf_counts.aggr field

 tools/perf/builtin-script.c                   |   4 +-
 tools/perf/builtin-stat.c                     | 186 +++++--
 tools/perf/tests/parse-metric.c               |   2 +-
 tools/perf/tests/pmu-events.c                 |   2 +-
 tools/perf/util/counts.c                      |   1 -
 tools/perf/util/counts.h                      |   1 -
 tools/perf/util/cpumap.c                      |  16 +-
 tools/perf/util/cpumap.h                      |   8 +-
 tools/perf/util/evsel.c                       |  32 +-
 tools/perf/util/parse-events.c                |   1 +
 tools/perf/util/pmu.c                         |   4 +
 .../scripting-engines/trace-event-python.c    |   6 -
 tools/perf/util/stat-display.c                | 462 +++---------------
 tools/perf/util/stat.c                        | 407 ++++++++++++---
 tools/perf/util/stat.h                        |  40 +-
 15 files changed, 633 insertions(+), 539 deletions(-)


base-commit: a3a365655a28f12f07eddf4f3fd596987b175e1d
-- 
2.38.0.413.g74048e4d9e-goog

