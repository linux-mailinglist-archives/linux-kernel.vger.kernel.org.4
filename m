Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663E65455E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLVQtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiLVQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:49:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32705139;
        Thu, 22 Dec 2022 08:49:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8D47B81F18;
        Thu, 22 Dec 2022 16:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60862C433D2;
        Thu, 22 Dec 2022 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671727762;
        bh=uXchOU/QRKEDAznzQqbUcejnwz+pNy6Ln4PMIsTFTWw=;
        h=From:To:Cc:Subject:Date:From;
        b=q6SLIgTrKsIljSu+AcSADf3b3/HTZeuQiX//iwBUP+yKU+4MAAlEopXeiIRUb+WmT
         AaFMotzXVIDK40LhrvgErEBV8KaUpHW2C9b+HHwb+851Od0cZDsx/CDv0kHG1P9HKf
         QYQ7wMnrrSiSEqXPRCPcYyDzw7GWtXAOo7EwOndQwzjjv+LEZ57MBi0lBVsEKe72y2
         T0tjDRD1I/vBIF39fVK7UBta/MSe70NOto7tLbN0AAkiCSNv8jBKZcSI8zO53kskgM
         d44EWPfQ80ewme8vqdAmd2a7Xg30QSGv4bjaoNr4cZ9L+d4nxYzimuDbAv6n60pGwc
         O5BHnH5uRy/Pw==
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
        Changbin Du <changbin.du@gmail.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.2: 2nd batch
Date:   Thu, 22 Dec 2022 13:49:14 -0300
Message-Id: <20221222164914.508929-1-acme@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit aeba12b26c79fc35e07e511f692a8907037d95da:

  Merge tag 'nfsd-6.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2022-12-19 09:10:33 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.2-2-2022-12-22

for you to fetch changes up to 09e6f9f98370be9a9f8978139e0eb1be87d1125f:

  perf python: Fix splitting CC into compiler and options (2022-12-22 11:34:30 -0300)

----------------------------------------------------------------
perf tools fixes and improvements for v6.2: 2nd batch

- Don't stop building perf if python setuptools isn't installed, just
  disable the affected perf feature.

- Remove explicit reference to python 2.x devel files, that warning is
  about python-devel, no matter what version, being unavailable and thus
  disabling the linking with libpython.

- Don't use -Werror=switch-enum when building the python support that
  handles libtraceevent enumerations, as there is no good way to test
  if some specific enum entry is available with the libtraceevent
  installed on the system.

- Introduce 'perf lock contention' --type-filter and --lock-filter, to
  filter by lock type and lock name:

  $ sudo ./perf lock record -a -- ./perf bench sched messaging

  $ sudo ./perf lock contention -E 5 -Y spinlock
   contended  total wait   max wait  avg wait      type  caller

         802     1.26 ms   11.73 us   1.58 us  spinlock  __wake_up_common_lock+0x62
          13   787.16 us  105.44 us  60.55 us  spinlock  remove_wait_queue+0x14
          12   612.96 us   78.70 us  51.08 us  spinlock  prepare_to_wait+0x27
         114   340.68 us   12.61 us   2.99 us  spinlock  try_to_wake_up+0x1f5
          83   226.38 us    9.15 us   2.73 us  spinlock  folio_lruvec_lock_irqsave+0x5e

  $ sudo ./perf lock contention -l
   contended  total wait  max wait  avg wait           address  symbol

          57     1.11 ms  42.83 us  19.54 us  ffff9f4140059000
          15   280.88 us  23.51 us  18.73 us  ffffffff9d007a40  jiffies_lock
           1    20.49 us  20.49 us  20.49 us  ffffffff9d0d50c0  rcu_state
           1     9.02 us   9.02 us   9.02 us  ffff9f41759e9ba0

  $ sudo ./perf lock contention -L jiffies_lock,rcu_state
   contended  total wait  max wait  avg wait      type  caller

          15   280.88 us  23.51 us  18.73 us  spinlock  tick_sched_do_timer+0x93
           1    20.49 us  20.49 us  20.49 us  spinlock  __softirqentry_text_start+0xeb

  $ sudo ./perf lock contention -L ffff9f4140059000
   contended  total wait  max wait  avg wait      type  caller

          38   779.40 us  42.83 us  20.51 us  spinlock  worker_thread+0x50
          11   216.30 us  39.87 us  19.66 us  spinlock  queue_work_on+0x39
           8   118.13 us  20.51 us  14.77 us  spinlock  kthread+0xe5

- Fix splitting CC into compiler and options when checking if a option
  is present in clang to build the python binding, needed in systems
  such as yocto that set CC to, e.g.: "gcc --sysroot=/a/b/c".

- Refresh metrics and events for Intel systems: alderlake.  alderlake-n,
  bonnell, broadwell, broadwellde, broadwellx, cascadelakex,
  elkhartlake, goldmont, goldmontplus, haswell, haswellx, icelake,
  icelakex, ivybridge, ivytown, jaketown, knightslanding, meteorlake,
  nehalemep, nehalemex, sandybridge, sapphirerapids, silvermont, skylake,
  skylakex, snowridgex, tigerlake, westmereep-dp, westmereep-sp,
  westmereex.

- Add vendor events files (JSON) for AMD Zen 4, from sections 2.1.15.4
  "Core Performance Monitor Counters", 2.1.15.5 "L3 Cache Performance
  Monitor Counter"s and Section 7.1 "Fabric Performance Monitor Counter
  (PMC) Events" in the Processor Programming Reference (PPR) for AMD
  Family 19h Model 11h Revision B1 processors.

  This constitutes events which capture op dispatch, execution and
  retirement, branch prediction, L1 and L2 cache activity, TLB activity,
  L3 cache activity and data bandwidth for various links and interfaces in
  the Data Fabric.

- Also, from the same PPR are metrics taken from Section 2.1.15.2
  "Performance Measurement", including pipeline utilization, which are
  new to Zen 4 processors and useful for finding performance bottlenecks
  by analyzing activity at different stages of the pipeline.

- Greatly improve the 'srcline', 'srcline_from', 'srcline_to' and
  'srcfile' sort keys performance by postponing calling the external
  addr2line utility to the collapse phase of histogram bucketing.

- Fix 'perf test' "all PMU test" to skip parametrized events, that
  requires setting up and are not supported by this test.

- Update tools/ copies of kernel headers: features, disabled-features,
  fscrypt.h, i915_drm.h, msr-index.h, power pc syscall table and kvm.h.

- Add .DELETE_ON_ERROR special Makefile target to clean up partially
  updated files on error.

- Simplify the mksyscalltbl script for arm64 by avoiding to run the host
  compiler to create the syscall table, do it all just with the shell
  script.

- Further fixes to honour quiet mode (-q).

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (12):
      perf python: Don't stop building if python setuptools isn't installed
      Merge remote-tracking branch 'torvalds/master' into perf/core
      tools headers disabled-cpufeatures: Sync with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync powerpc syscall table with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      perf build: Remove explicit reference to python 2.x devel files
      perf scripting python: Don't be strict at handling libtraceevent enumerations
      perf python: Fix splitting CC into compiler and options

Changbin Du (1):
      perf tools: Add .DELETE_ON_ERROR special Makefile target to clean up partially updated files on error.

Hans-Peter Nilsson (1):
      perf arm64: Simplify mksyscalltbl

Ian Rogers (32):
      perf test pmu-events: Fake PMU metric workaround
      perf vendor events intel: Refresh alderlake metrics
      perf vendor events intel: Refresh alderlake-n metrics
      perf vendor events intel: Refresh bonnell events
      perf vendor events intel: Refresh broadwell metrics and events
      perf vendor events intel: Refresh broadwellde metrics and events
      perf vendor events intel: Refresh broadwellx metrics and events
      perf vendor events intel: Refresh cascadelakex metrics and events
      perf vendor events intel: Refresh elkhartlake events
      perf vendor events intel: Refresh goldmont events
      perf vendor events intel: Refresh goldmontplus events
      perf vendor events intel: Refresh haswell metrics and events
      perf vendor events intel: Refresh haswellx metrics and events
      perf vendor events intel: Refresh icelake metrics and events
      perf vendor events intel: Refresh icelakex metrics and events
      perf vendor events intel: Refresh ivybridge metrics and events
      perf vendor events intel: Refresh ivytown metrics and events
      perf vendor events intel: Refresh jaketown metrics and events
      perf vendor events intel: Refresh knightslanding events
      perf vendor events intel: Refresh meteorlake events
      perf vendor events intel: Refresh nehalemep events
      perf vendor events intel: Refresh nehalemex events
      perf vendor events intel: Refresh sandybridge metrics and events
      perf vendor events intel: Refresh sapphirerapids metrics and events
      perf vendor events intel: Refresh silvermont events
      perf vendor events intel: Refresh skylake metrics and events
      perf vendor events intel: Refresh skylakex metrics and events
      perf vendor events intel: Refresh snowridgex events
      perf vendor events intel: Refresh tigerlake metrics and events
      perf vendor events intel: Refresh westmereep-dp events
      perf vendor events intel: Refresh westmereep-sp events
      perf vendor events intel: Refresh westmereex events

Michael Petlan (1):
      perf test: Fix "all PMU test" to skip parametrized events

Namhyung Kim (14):
      perf lock contention: Factor out lock_type_table
      perf lock contention: Add -Y/--type-filter option
      perf lock contention: Support lock type filtering for BPF
      perf lock contention: Add -L/--lock-filter option
      perf lock contention: Support lock addr/name filtering for BPF
      perf test: Update 'perf lock contention' test
      perf srcline: Do not return NULL for srcline
      perf symbol: Add filename__has_section()
      perf srcline: Skip srcline if .debug_line is missing
      perf srcline: Conditionally suppress addr2line warnings
      perf hist: Add perf_hpp_fmt->init() callback
      perf hist: Improve srcline sort key performance
      perf hist: Improve srcfile sort key performance
      perf hist: Improve srcline_{from,to} sort key performance

Sandipan Das (4):
      perf vendor events amd: Add Zen 4 core events
      perf vendor events amd: Add Zen 4 uncore events
      perf vendor events amd: Add Zen 4 metrics
      perf vendor events amd: Add Zen 4 mapping

Yang Jihong (3):
      perf debug: Set debug_peo_args and redirect_to_stderr variable to correct values in perf_quiet_option()
      perf tools: Fix usage of the verbose variable
      perf probe: Check -v and -q options in the right place

 tools/arch/x86/include/asm/cpufeatures.h           |     6 +
 tools/arch/x86/include/asm/disabled-features.h     |    17 +-
 tools/arch/x86/include/asm/msr-index.h             |    24 +-
 tools/include/uapi/drm/i915_drm.h                  |    62 +-
 tools/include/uapi/linux/fscrypt.h                 |     4 +-
 tools/include/uapi/linux/kvm.h                     |    13 +-
 tools/perf/Documentation/perf-lock.txt             |    27 +-
 tools/perf/Makefile.config                         |    11 +-
 tools/perf/Makefile.perf                           |     3 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |    23 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |     7 +-
 tools/perf/builtin-lock.c                          |   311 +-
 tools/perf/builtin-probe.c                         |    17 +-
 tools/perf/builtin-record.c                        |     4 +-
 tools/perf/builtin-script.c                        |     2 +-
 tools/perf/builtin-stat.c                          |     4 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c        |     2 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |   116 +-
 .../arch/x86/alderlaken/adln-metrics.json          |    18 +-
 tools/perf/pmu-events/arch/x86/amdzen4/branch.json |    82 +
 tools/perf/pmu-events/arch/x86/amdzen4/cache.json  |   772 +
 tools/perf/pmu-events/arch/x86/amdzen4/core.json   |   122 +
 .../pmu-events/arch/x86/amdzen4/data-fabric.json   |  1090 +
 .../arch/x86/amdzen4/floating-point.json           |   818 +
 tools/perf/pmu-events/arch/x86/amdzen4/memory.json |   174 +
 tools/perf/pmu-events/arch/x86/amdzen4/other.json  |   138 +
 .../perf/pmu-events/arch/x86/amdzen4/pipeline.json |    98 +
 .../pmu-events/arch/x86/amdzen4/recommended.json   |   334 +
 tools/perf/pmu-events/arch/x86/bonnell/cache.json  |    93 -
 .../arch/x86/bonnell/floating-point.json           |    47 +-
 .../perf/pmu-events/arch/x86/bonnell/frontend.json |    11 -
 tools/perf/pmu-events/arch/x86/bonnell/memory.json |    19 -
 tools/perf/pmu-events/arch/x86/bonnell/other.json  |    74 +-
 .../perf/pmu-events/arch/x86/bonnell/pipeline.json |    65 +-
 .../arch/x86/bonnell/virtual-memory.json           |    15 -
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   137 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |   957 -
 .../arch/x86/broadwell/floating-point.json         |    40 -
 .../pmu-events/arch/x86/broadwell/frontend.json    |    56 -
 .../perf/pmu-events/arch/x86/broadwell/memory.json |   890 -
 .../perf/pmu-events/arch/x86/broadwell/other.json  |     8 -
 .../pmu-events/arch/x86/broadwell/pipeline.json    |   272 -
 .../arch/x86/broadwell/uncore-cache.json           |    19 -
 .../arch/x86/broadwell/uncore-other.json           |    25 +-
 .../arch/x86/broadwell/virtual-memory.json         |    76 -
 .../arch/x86/broadwellde/bdwde-metrics.json        |   143 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |   153 -
 .../arch/x86/broadwellde/floating-point.json       |    40 -
 .../pmu-events/arch/x86/broadwellde/frontend.json  |    56 -
 .../pmu-events/arch/x86/broadwellde/memory.json    |    86 -
 .../pmu-events/arch/x86/broadwellde/other.json     |     8 -
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |   272 -
 .../arch/x86/broadwellde/uncore-cache.json         |   414 +-
 .../arch/x86/broadwellde/uncore-memory.json        |   477 +-
 .../arch/x86/broadwellde/uncore-other.json         |   163 +-
 .../arch/x86/broadwellde/uncore-power.json         |    57 -
 .../arch/x86/broadwellde/virtual-memory.json       |    76 -
 .../arch/x86/broadwellx/bdx-metrics.json           |  1703 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |   191 -
 .../arch/x86/broadwellx/floating-point.json        |    40 -
 .../pmu-events/arch/x86/broadwellx/frontend.json   |    56 -
 .../pmu-events/arch/x86/broadwellx/memory.json     |   143 -
 .../perf/pmu-events/arch/x86/broadwellx/other.json |     8 -
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |   272 -
 .../arch/x86/broadwellx/uncore-cache.json          |  3740 +-
 .../arch/x86/broadwellx/uncore-interconnect.json   |  1225 +-
 .../arch/x86/broadwellx/uncore-memory.json         |  2052 +-
 .../arch/x86/broadwellx/uncore-other.json          |  2410 +-
 .../arch/x86/broadwellx/uncore-power.json          |   198 +-
 .../arch/x86/broadwellx/virtual-memory.json        |    76 -
 .../pmu-events/arch/x86/cascadelakex/cache.json    |  3644 --
 .../arch/x86/cascadelakex/clx-metrics.json         |  2217 +-
 .../arch/x86/cascadelakex/floating-point.json      |    24 -
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   109 -
 .../pmu-events/arch/x86/cascadelakex/memory.json   |  2194 -
 .../pmu-events/arch/x86/cascadelakex/other.json    |   490 -
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   194 -
 .../arch/x86/cascadelakex/uncore-memory.json       |  3185 +-
 .../arch/x86/cascadelakex/uncore-other.json        | 29770 ++++++------
 .../arch/x86/cascadelakex/uncore-power.json        |    45 +-
 .../arch/x86/cascadelakex/virtual-memory.json      |    56 -
 .../pmu-events/arch/x86/elkhartlake/cache.json     |   252 -
 .../arch/x86/elkhartlake/floating-point.json       |    11 -
 .../pmu-events/arch/x86/elkhartlake/frontend.json  |    36 -
 .../pmu-events/arch/x86/elkhartlake/memory.json    |    84 -
 .../pmu-events/arch/x86/elkhartlake/other.json     |   143 -
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   213 -
 .../arch/x86/elkhartlake/virtual-memory.json       |   117 -
 tools/perf/pmu-events/arch/x86/goldmont/cache.json |   288 -
 .../arch/x86/goldmont/floating-point.json          |     6 -
 .../pmu-events/arch/x86/goldmont/frontend.json     |    16 -
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |     6 -
 tools/perf/pmu-events/arch/x86/goldmont/other.json |    10 -
 .../pmu-events/arch/x86/goldmont/pipeline.json     |    77 -
 .../arch/x86/goldmont/virtual-memory.json          |    14 -
 .../pmu-events/arch/x86/goldmontplus/cache.json    |   470 -
 .../arch/x86/goldmontplus/floating-point.json      |    11 -
 .../pmu-events/arch/x86/goldmontplus/frontend.json |    32 -
 .../pmu-events/arch/x86/goldmontplus/memory.json   |    10 -
 .../pmu-events/arch/x86/goldmontplus/other.json    |    20 -
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |   143 -
 .../arch/x86/goldmontplus/virtual-memory.json      |    69 -
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |   211 -
 .../arch/x86/haswell/floating-point.json           |    20 -
 .../perf/pmu-events/arch/x86/haswell/frontend.json |    58 -
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   117 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |   149 -
 tools/perf/pmu-events/arch/x86/haswell/other.json  |     8 -
 .../perf/pmu-events/arch/x86/haswell/pipeline.json |   258 -
 .../pmu-events/arch/x86/haswell/uncore-cache.json  |    50 -
 .../pmu-events/arch/x86/haswell/uncore-other.json  |    21 +-
 .../arch/x86/haswell/virtual-memory.json           |    98 -
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |   217 -
 .../arch/x86/haswellx/floating-point.json          |    20 -
 .../pmu-events/arch/x86/haswellx/frontend.json     |    58 -
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  1467 +-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  |   170 -
 tools/perf/pmu-events/arch/x86/haswellx/other.json |     8 -
 .../pmu-events/arch/x86/haswellx/pipeline.json     |   258 -
 .../pmu-events/arch/x86/haswellx/uncore-cache.json |  2448 +-
 .../arch/x86/haswellx/uncore-interconnect.json     |   722 +-
 .../arch/x86/haswellx/uncore-memory.json           |  2037 +-
 .../pmu-events/arch/x86/haswellx/uncore-other.json |  1834 +-
 .../pmu-events/arch/x86/haswellx/uncore-power.json |   150 +-
 .../arch/x86/haswellx/virtual-memory.json          |    98 -
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |   412 -
 .../arch/x86/icelake/floating-point.json           |    28 -
 .../perf/pmu-events/arch/x86/icelake/frontend.json |   144 -
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |   151 +-
 tools/perf/pmu-events/arch/x86/icelake/memory.json |   171 -
 tools/perf/pmu-events/arch/x86/icelake/other.json  |   132 -
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |   349 +-
 .../pmu-events/arch/x86/icelake/uncore-other.json  |    10 +-
 .../arch/x86/icelake/virtual-memory.json           |    80 -
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |   316 +-
 .../arch/x86/icelakex/floating-point.json          |    28 -
 .../pmu-events/arch/x86/icelakex/frontend.json     |   140 -
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  2192 +-
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |   139 +-
 tools/perf/pmu-events/arch/x86/icelakex/other.json |   117 -
 .../pmu-events/arch/x86/icelakex/pipeline.json     |   344 +-
 .../arch/x86/icelakex/uncore-memory.json           |  1878 +-
 .../pmu-events/arch/x86/icelakex/uncore-other.json | 45144 +++++++++----------
 .../pmu-events/arch/x86/icelakex/uncore-power.json |   115 +-
 .../arch/x86/icelakex/virtual-memory.json          |    88 -
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |   235 -
 .../arch/x86/ivybridge/floating-point.json         |    34 -
 .../pmu-events/arch/x86/ivybridge/frontend.json    |    60 -
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   119 +-
 .../perf/pmu-events/arch/x86/ivybridge/memory.json |    54 -
 .../perf/pmu-events/arch/x86/ivybridge/other.json  |     8 -
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |   250 -
 .../arch/x86/ivybridge/uncore-cache.json           |    50 -
 .../arch/x86/ivybridge/uncore-other.json           |    28 +-
 .../arch/x86/ivybridge/virtual-memory.json         |    36 -
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  |   274 -
 .../arch/x86/ivytown/floating-point.json           |    34 -
 .../perf/pmu-events/arch/x86/ivytown/frontend.json |    60 -
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   133 +-
 tools/perf/pmu-events/arch/x86/ivytown/memory.json |   121 -
 tools/perf/pmu-events/arch/x86/ivytown/other.json  |     8 -
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |   250 -
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   388 +-
 .../arch/x86/ivytown/uncore-interconnect.json      |   505 +-
 .../pmu-events/arch/x86/ivytown/uncore-memory.json |   209 +-
 .../pmu-events/arch/x86/ivytown/uncore-other.json  |   254 +-
 .../pmu-events/arch/x86/ivytown/uncore-power.json  |    95 -
 .../arch/x86/ivytown/virtual-memory.json           |    40 -
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |   289 -
 .../arch/x86/jaketown/floating-point.json          |    30 -
 .../pmu-events/arch/x86/jaketown/frontend.json     |    64 -
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |    91 +-
 .../perf/pmu-events/arch/x86/jaketown/memory.json  |   103 -
 tools/perf/pmu-events/arch/x86/jaketown/other.json |    12 -
 .../pmu-events/arch/x86/jaketown/pipeline.json     |   255 -
 .../pmu-events/arch/x86/jaketown/uncore-cache.json |   266 +-
 .../arch/x86/jaketown/uncore-interconnect.json     |   132 -
 .../arch/x86/jaketown/uncore-memory.json           |    58 -
 .../pmu-events/arch/x86/jaketown/uncore-other.json |   155 +-
 .../pmu-events/arch/x86/jaketown/uncore-power.json |    51 -
 .../arch/x86/jaketown/virtual-memory.json          |    32 -
 .../pmu-events/arch/x86/knightslanding/cache.json  |   411 -
 .../arch/x86/knightslanding/floating-point.json    |     3 -
 .../arch/x86/knightslanding/frontend.json          |     7 -
 .../pmu-events/arch/x86/knightslanding/memory.json |   201 -
 .../arch/x86/knightslanding/pipeline.json          |    44 -
 .../arch/x86/knightslanding/uncore-other.json      |  1016 +-
 .../arch/x86/knightslanding/virtual-memory.json    |     7 -
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    17 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |   170 +-
 .../pmu-events/arch/x86/meteorlake/frontend.json   |     6 -
 .../pmu-events/arch/x86/meteorlake/memory.json     |    77 +-
 .../perf/pmu-events/arch/x86/meteorlake/other.json |    24 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |   222 +-
 .../arch/x86/meteorlake/virtual-memory.json        |    28 +-
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  |   524 -
 .../arch/x86/nehalemep/floating-point.json         |    28 -
 .../pmu-events/arch/x86/nehalemep/frontend.json    |     3 -
 .../perf/pmu-events/arch/x86/nehalemep/memory.json |   134 -
 .../perf/pmu-events/arch/x86/nehalemep/other.json  |    18 -
 .../pmu-events/arch/x86/nehalemep/pipeline.json    |   127 +-
 .../arch/x86/nehalemep/virtual-memory.json         |    13 -
 .../perf/pmu-events/arch/x86/nehalemex/cache.json  |   519 -
 .../arch/x86/nehalemex/floating-point.json         |    28 -
 .../pmu-events/arch/x86/nehalemex/frontend.json    |     3 -
 .../perf/pmu-events/arch/x86/nehalemex/memory.json |   134 -
 .../perf/pmu-events/arch/x86/nehalemex/other.json  |    18 -
 .../pmu-events/arch/x86/nehalemex/pipeline.json    |   127 +-
 .../arch/x86/nehalemex/virtual-memory.json         |    13 -
 .../pmu-events/arch/x86/sandybridge/cache.json     |   441 -
 .../arch/x86/sandybridge/floating-point.json       |    30 -
 .../pmu-events/arch/x86/sandybridge/frontend.json  |    64 -
 .../pmu-events/arch/x86/sandybridge/memory.json    |   108 -
 .../pmu-events/arch/x86/sandybridge/other.json     |    12 -
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |   257 -
 .../arch/x86/sandybridge/snb-metrics.json          |    83 +-
 .../arch/x86/sandybridge/uncore-cache.json         |    50 -
 .../arch/x86/sandybridge/uncore-other.json         |    28 +-
 .../arch/x86/sandybridge/virtual-memory.json       |    32 -
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |   350 +-
 .../arch/x86/sapphirerapids/floating-point.json    |    63 -
 .../arch/x86/sapphirerapids/frontend.json          |   144 -
 .../pmu-events/arch/x86/sapphirerapids/memory.json |   125 +-
 .../pmu-events/arch/x86/sapphirerapids/other.json  |    91 +-
 .../arch/x86/sapphirerapids/pipeline.json          |   424 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |  2309 +-
 .../arch/x86/sapphirerapids/uncore-memory.json     |   526 +-
 .../arch/x86/sapphirerapids/uncore-other.json      |  6606 ++-
 .../arch/x86/sapphirerapids/uncore-power.json      |    84 +-
 .../arch/x86/sapphirerapids/virtual-memory.json    |    80 -
 .../perf/pmu-events/arch/x86/silvermont/cache.json |   133 -
 .../arch/x86/silvermont/floating-point.json        |     1 -
 .../pmu-events/arch/x86/silvermont/frontend.json   |     8 -
 .../pmu-events/arch/x86/silvermont/memory.json     |     1 -
 .../perf/pmu-events/arch/x86/silvermont/other.json |     2 -
 .../pmu-events/arch/x86/silvermont/pipeline.json   |    35 -
 .../arch/x86/silvermont/virtual-memory.json        |     7 -
 tools/perf/pmu-events/arch/x86/skylake/cache.json  |   660 -
 .../arch/x86/skylake/floating-point.json           |    14 -
 .../perf/pmu-events/arch/x86/skylake/frontend.json |   109 -
 tools/perf/pmu-events/arch/x86/skylake/memory.json |   358 -
 tools/perf/pmu-events/arch/x86/skylake/other.json  |     4 -
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |   192 -
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   155 +-
 .../pmu-events/arch/x86/skylake/uncore-cache.json  |    18 -
 .../pmu-events/arch/x86/skylake/uncore-other.json  |    31 +-
 .../arch/x86/skylake/virtual-memory.json           |    56 -
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |   368 -
 .../arch/x86/skylakex/floating-point.json          |    18 -
 .../pmu-events/arch/x86/skylakex/frontend.json     |   109 -
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |   310 -
 tools/perf/pmu-events/arch/x86/skylakex/other.json |    30 -
 .../pmu-events/arch/x86/skylakex/pipeline.json     |   194 -
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  2134 +-
 .../arch/x86/skylakex/uncore-memory.json           |  2303 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json | 29356 ++++++------
 .../pmu-events/arch/x86/skylakex/uncore-power.json |    45 +-
 .../arch/x86/skylakex/virtual-memory.json          |    56 -
 .../perf/pmu-events/arch/x86/snowridgex/cache.json |   252 -
 .../arch/x86/snowridgex/floating-point.json        |    11 -
 .../pmu-events/arch/x86/snowridgex/frontend.json   |    36 -
 .../pmu-events/arch/x86/snowridgex/memory.json     |    84 -
 .../perf/pmu-events/arch/x86/snowridgex/other.json |   143 -
 .../pmu-events/arch/x86/snowridgex/pipeline.json   |   213 -
 .../arch/x86/snowridgex/uncore-memory.json         |   624 +-
 .../arch/x86/snowridgex/uncore-other.json          | 26334 +++++------
 .../arch/x86/snowridgex/uncore-power.json          |   114 +-
 .../arch/x86/snowridgex/virtual-memory.json        |   117 -
 .../perf/pmu-events/arch/x86/tigerlake/cache.json  |   210 +-
 .../arch/x86/tigerlake/floating-point.json         |    27 -
 .../pmu-events/arch/x86/tigerlake/frontend.json    |   125 -
 .../perf/pmu-events/arch/x86/tigerlake/memory.json |    77 -
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |    13 -
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |   287 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   141 +-
 .../arch/x86/tigerlake/uncore-other.json           |    96 +-
 .../arch/x86/tigerlake/virtual-memory.json         |    60 -
 .../pmu-events/arch/x86/westmereep-dp/cache.json   |   445 -
 .../arch/x86/westmereep-dp/floating-point.json     |    28 -
 .../arch/x86/westmereep-dp/frontend.json           |     3 -
 .../pmu-events/arch/x86/westmereep-dp/memory.json  |   137 -
 .../pmu-events/arch/x86/westmereep-dp/other.json   |    22 -
 .../arch/x86/westmereep-dp/pipeline.json           |   129 +-
 .../arch/x86/westmereep-dp/virtual-memory.json     |    21 -
 .../pmu-events/arch/x86/westmereep-sp/cache.json   |   517 -
 .../arch/x86/westmereep-sp/floating-point.json     |    28 -
 .../arch/x86/westmereep-sp/frontend.json           |     3 -
 .../pmu-events/arch/x86/westmereep-sp/memory.json  |   134 -
 .../pmu-events/arch/x86/westmereep-sp/other.json   |    22 -
 .../arch/x86/westmereep-sp/pipeline.json           |   129 +-
 .../arch/x86/westmereep-sp/virtual-memory.json     |    18 -
 .../perf/pmu-events/arch/x86/westmereex/cache.json |   516 -
 .../arch/x86/westmereex/floating-point.json        |    28 -
 .../pmu-events/arch/x86/westmereex/frontend.json   |     3 -
 .../pmu-events/arch/x86/westmereex/memory.json     |   135 -
 .../perf/pmu-events/arch/x86/westmereex/other.json |    22 -
 .../pmu-events/arch/x86/westmereex/pipeline.json   |   129 +-
 .../arch/x86/westmereex/virtual-memory.json        |    21 -
 tools/perf/tests/builtin-test.c                    |     2 +-
 tools/perf/tests/dlfilter-test.c                   |     2 +-
 tools/perf/tests/pmu-events.c                      |    17 +-
 tools/perf/tests/shell/lock_contention.sh          |    58 +-
 tools/perf/tests/shell/stat_all_pmu.sh             |    13 +-
 tools/perf/util/bpf_lock_contention.c              |    57 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |    38 +-
 tools/perf/util/debug.c                            |     4 +
 tools/perf/util/dlfilter.c                         |     2 +-
 tools/perf/util/hist.c                             |    10 +-
 tools/perf/util/hist.h                             |     1 +
 tools/perf/util/lock-contention.h                  |    10 +
 tools/perf/util/scripting-engines/Build            |     2 +-
 tools/perf/util/setup.py                           |    13 +-
 tools/perf/util/sort.c                             |   129 +-
 tools/perf/util/sort.h                             |     1 +
 tools/perf/util/srcline.c                          |    20 +-
 tools/perf/util/symbol-elf.c                       |    28 +
 tools/perf/util/symbol-minimal.c                   |     5 +
 tools/perf/util/symbol.h                           |     1 +
 318 files changed, 92040 insertions(+), 124719 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
