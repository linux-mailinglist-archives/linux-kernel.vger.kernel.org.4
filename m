Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886DE70AA91
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjETSru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjETSrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBE102;
        Sat, 20 May 2023 11:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F169360A24;
        Sat, 20 May 2023 18:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD3C433EF;
        Sat, 20 May 2023 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684608465;
        bh=vAsy3b6m4W7pvFwc0gkzgM+KCqjO+Wvh1JR/XMhX1mk=;
        h=From:To:Cc:Subject:Date:From;
        b=lbFJ/ZeE2e/Wti9rQK1JOrfRRwRvNr7Pqx3V9p0mbF8P7KCmErLAGcBVF2Q22IraL
         64EtXue/X/5S5lmS2f6IfYD7P7XnvWBoDDRqvlDghBXsFzI0n8NqweLwiaZba4VMIY
         K9DSJW4UqqCnSmc2ygas4qvAP7U6RH5KFrY8WIAJB+2k/AriXby9zOw4NGGJX8hHJb
         7sA9Utk2veMrvpmqsPy/qLp3P6jZVONUwR2gFZuVY0kNUGMUvzm71OL3FHtErPAD5L
         D7dFxOm6DhM9jDYMn+WzzsPXcYTum+1V8sjMz/p5YpwHL1Y7O/0iducDTho/BHDwbQ
         75gmhYiQEUekA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.4
Date:   Sat, 20 May 2023 15:47:31 -0300
Message-Id: <20230520184731.1690465-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit ad2fd53a7870a395b8564697bef6c329d017c6c9:

  Merge tag 'platform-drivers-x86-v6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2023-05-10 09:36:42 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.4-1-2023-05-20

for you to fetch changes up to 4e111f0cf0ee973ce7e7e012b4ceb07867d2dae5:

  perf bench syscall: Fix __NR_execve undeclared build error (2023-05-19 12:08:00 -0300)

----------------------------------------------------------------
perf tools fixes for v6.4:

- Fail graciously if BUILD_BPF_SKEL=1 is specified and clang isn't available.

- Add empty 'struct rq' to 'perf lock contention' to satisfy libbpf 'runqueue'
  type verification. This feature is built only with BUILD_BPF_SKEL=1.

- Make vmlinux.h use bpf.h and perf_event.h in source directory, not system
  ones that may be old and not have things like 'union perf_sample_weight'.

- Add system include paths to BPF builds to pick things missing in the headers
  included by clang -target bpf.

- Update various header copies with the kernel sources.

- Change divide by zero and not supported events behavior to show 'nan'/'not
  counted' in 'perf stat' output. This happens when using things like
  'perf stat -M TopdownL2 true', involving JSON metrics.

- Update no event/metric expectations affected by using JSON metrics in
  'perf stat -ddd' perf test.

- Avoid segv with 'perf stat --topdown' for metrics without a group.

- Do not assume which events may have a PMU name, allowing the logic to keep an
  AUX event group together. Makes this usecase work again:

    $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any/aux-sample-size=8192/pp}:u' -- sleep 0.1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.078 MB perf.data ]
    $ perf script -F-dso,+addr | grep -C5 tlb_flush.stlb_any | head -11
    sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc82a2 dl_main+0x9a2 => 7f5350cb38f0 _dl_add_to_namespace_list+0x0
    sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cb3908 _dl_add_to_namespace_list+0x18 => 7f5350cbb080 rtld_mutex_dummy+0x0
    sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc8350 dl_main+0xa50 => 0 [unknown]
    sleep 20444 [003]  7939.510244:  1  branches:uH:  7f5350cc83ca dl_main+0xaca => 7f5350caeb60 _dl_process_pt_gnu_property+0x0
    sleep 20444 [003]  7939.510245:  1  branches:uH:  7f5350caeb60 _dl_process_pt_gnu_property+0x0 => 0 [unknown]
    sleep 20444  7939.510245:       10 tlb_flush.stlb_any/aux-sample-size=8192/pp: 0 7f5350caeb60 _dl_process_pt_gnu_property+0x0
    sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc87fe dl_main+0xefe => 7f5350ccd240 strcmp+0x0
    sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc8862 dl_main+0xf62 => 0 [unknown]

- Add a check for the above use case in 'perf test test_intel_pt'.

- Fix build with refcount checking on arm64, it was still accessing fields that
  need to be wrapped so that the refcounted struct gets checked.

- Fix contextid validation in ARM's CS-ETM, so that older kernels without that
  field can still be supported.

- Skip unsupported aggregation for stat events found in perf.data files in 'perf script'.

- Add stat test for record and script to check the previous problem.

- Remove needless debuginfod queries from 'perf test java symbol', this was
  just making the test take a long time to complete.

- Address python SafeConfigParser() deprecation warning in 'perf test attr'.

- Fix __NR_execve undeclared on i386 'perf bench syscall' build error.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf test test_intel_pt.sh: Test sample mode with event with PMU name
      perf parse-events: Do not break up AUX event group

Arnaldo Carvalho de Melo (7):
      perf build: Gracefully fail the build if BUILD_BPF_SKEL=1 is specified and clang isn't available
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers UAPI: Sync s390 syscall table file that wires up the memfd_secret syscall
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools headers: Update the copy of x86's mem{cpy,set}_64.S used in 'perf bench'
      tools headers UAPI: Sync arch prctl headers with the kernel sources
      tools headers disabled-features: Sync with the kernel sources

Ian Rogers (9):
      perf metric: Change divide by zero and !support events behavior
      perf stat: Introduce skippable evsels
      perf metric: JSON flag to not group events if gathering a metric group
      perf parse-events: Don't reorder ungrouped events by PMU
      perf evsel: Modify group pmu name for software events
      perf build: Add system include paths to BPF builds
      perf metrics: Avoid segv with --topdown for metrics without a group
      perf test attr: Update no event/metric expectations
      perf test attr: Fix python SafeConfigParser() deprecation warning

James Clark (2):
      perf arm64: Fix build with refcount checking
      perf cs-etm: Fix contextid validation

Jiri Olsa (1):
      perf lock contention: Add empty 'struct rq' to satisfy libbpf 'runqueue' type verification

Sandipan Das (2):
      perf script: Skip aggregation for stat events
      perf test: Add stat test for record and script

Thomas Richter (1):
      perf test java symbol: Remove needless debuginfod queries

Tiezhu Yang (1):
      perf bench syscall: Fix __NR_execve undeclared build error

Yang Jihong (1):
      perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in source directory

Yanteng Si (7):
      tools headers UAPI: Sync the linux/in.h with the kernel sources
      tools headers UAPI: Sync the drm/drm.h with the kernel sources
      tools headers UAPI: Sync the i915_drm.h with the kernel sources
      tools headers UAPI: Sync the linux/const.h with the kernel headers
      tools include UAPI: Sync the sound/asound.h copy with the kernel sources
      tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources

 tools/arch/arm64/include/uapi/asm/kvm.h            |  36 ++++++
 tools/arch/x86/include/asm/cpufeatures.h           |  26 ++++-
 tools/arch/x86/include/asm/disabled-features.h     |   8 +-
 tools/arch/x86/include/asm/msr-index.h             |   2 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   3 +
 tools/arch/x86/include/uapi/asm/prctl.h            |   8 ++
 tools/arch/x86/include/uapi/asm/unistd_32.h        |   3 +
 tools/arch/x86/lib/memcpy_64.S                     |  34 ++----
 tools/arch/x86/lib/memset_64.S                     |  47 ++------
 tools/include/asm/alternative.h                    |   3 +-
 tools/include/uapi/drm/drm.h                       |  57 ++++++++-
 tools/include/uapi/drm/i915_drm.h                  |  25 +++-
 tools/include/uapi/linux/const.h                   |   2 +-
 tools/include/uapi/linux/in.h                      |   1 +
 tools/include/uapi/linux/kvm.h                     |  12 +-
 tools/include/uapi/linux/prctl.h                   |   2 +
 tools/include/uapi/sound/asound.h                  |  14 ++-
 tools/perf/Makefile.config                         |   6 +
 tools/perf/Makefile.perf                           |  22 +++-
 tools/perf/arch/arm/util/cs-etm.c                  |   9 +-
 tools/perf/arch/arm64/util/header.c                |   4 +-
 tools/perf/arch/arm64/util/pmu.c                   |   2 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   2 +-
 tools/perf/bench/mem-memcpy-x86-64-asm-def.h       |   4 -
 tools/perf/bench/mem-memcpy-x86-64-asm.S           |   2 +-
 tools/perf/bench/mem-memset-x86-64-asm-def.h       |   4 -
 tools/perf/bench/mem-memset-x86-64-asm.S           |   2 +-
 tools/perf/builtin-script.c                        |   7 ++
 tools/perf/builtin-stat.c                          |  38 ++++--
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  26 +++++
 .../arch/x86/alderlaken/adln-metrics.json          |  14 +++
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  12 ++
 .../arch/x86/broadwellde/bdwde-metrics.json        |  12 ++
 .../arch/x86/broadwellx/bdx-metrics.json           |  12 ++
 .../arch/x86/cascadelakex/clx-metrics.json         |  12 ++
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  12 ++
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  12 ++
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  12 ++
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  12 ++
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  12 ++
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  12 ++
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  12 ++
 .../arch/x86/sandybridge/snb-metrics.json          |  12 ++
 .../arch/x86/sapphirerapids/spr-metrics.json       |  12 ++
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  12 ++
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  12 ++
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  12 ++
 tools/perf/pmu-events/jevents.py                   |   4 +-
 tools/perf/pmu-events/pmu-events.h                 |   1 +
 tools/perf/tests/attr.py                           |   6 +-
 tools/perf/tests/attr/base-stat                    |   2 +-
 tools/perf/tests/attr/test-stat-default            |  80 ++++++++-----
 tools/perf/tests/attr/test-stat-detailed-1         |  95 +++++++++------
 tools/perf/tests/attr/test-stat-detailed-2         | 119 +++++++++++--------
 tools/perf/tests/attr/test-stat-detailed-3         | 127 ++++++++++++---------
 tools/perf/tests/expr.c                            |   3 +-
 tools/perf/tests/parse-metric.c                    |   1 +
 tools/perf/tests/shell/stat.sh                     |  13 +++
 tools/perf/tests/shell/test_intel_pt.sh            |   7 ++
 tools/perf/tests/shell/test_java_symbol.sh         |   2 +-
 tools/perf/trace/beauty/arch_prctl.c               |   2 +
 tools/perf/trace/beauty/x86_arch_prctl.sh          |   1 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   2 +
 tools/perf/util/bpf_skel/vmlinux.h                 |   1 +
 tools/perf/util/evsel.c                            |  37 +++---
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/expr.y                             |   6 +-
 tools/perf/util/metricgroup.c                      |  10 +-
 tools/perf/util/parse-events.c                     |  23 ++--
 tools/perf/util/stat-display.c                     |   2 +-
 tools/perf/util/stat-shadow.c                      |  25 +++-
 71 files changed, 865 insertions(+), 322 deletions(-)
