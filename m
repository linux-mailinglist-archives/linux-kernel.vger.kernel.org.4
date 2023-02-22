Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9C69F82A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjBVPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjBVPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:37:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FFE38B6A;
        Wed, 22 Feb 2023 07:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64E1AB815E0;
        Wed, 22 Feb 2023 15:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D75C433D2;
        Wed, 22 Feb 2023 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677080193;
        bh=KPyBluyD8RxSLlOM6S1dr9Xo4GNKEgseQCfSsuhya2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=OJEHyizOzUIJ28lUtLpSwe/i0QofgqrvZaEx6Pcu17WR0wE4hq+V5P+w9A5dTQKmE
         PKZIX05dJBmRZPprjPPe/2J6ZOeXTr6n6xdYooEISyomKu5cPOv9+9KwcXCncYA8mD
         gvMXaCNDHS9m4Jh3yY99aUR2rOMwI1DCs+TR4e1+bkycBPf1B6iRstwLBk3Dzbe1jP
         fp/rSQNN8XrxzwPkSJK5G3fGMtJ2Z9rED6physWzgzMmsd+45ZN9ovHJDpcyXn0I7c
         v+Unn5nVNRGk/paex+MGxHXjTcKeNSWVv1n+dAZbzWKlRHWSna/Xp5Ug4+L65jO8ek
         tNKd73Dk/pgLw==
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Disha Goel <disgoel@linux.ibm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Mike Leach <mike.leach@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        qinyu <qinyu32@huawei.com>, Rob Herring <robh@kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.3
Date:   Wed, 22 Feb 2023 12:36:15 -0300
Message-Id: <20230222153615.210643-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.1
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


The following changes since commit d2d11f342b179f1894a901f143ec7c008caba43e:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2023-02-05 17:17:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.3-1-2023-02-22

for you to fetch changes up to f9fa0778ee7349a9aa3d2ea10e9f2ab843a0b44e:

  perf tests stat_all_metrics: Change true workload to sleep workload for system wide check (2023-02-17 17:22:56 -0300)

----------------------------------------------------------------
perf tools changes for v6.3:

- 'perf lock contention' improvements:

  - Add -o/--lock-owner option:

  $ sudo ./perf lock contention -abo -- ./perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 4.766 [sec]

         4.766540 usecs/op
           209795 ops/sec
   contended   total wait     max wait     avg wait          pid   owner

         403    565.32 us     26.81 us      1.40 us           -1   Unknown
           4     27.99 us      8.57 us      7.00 us      1583145   sched-pipe
           1      8.25 us      8.25 us      8.25 us      1583144   sched-pipe
           1      2.03 us      2.03 us      2.03 us         5068   chrome

   The owner is unknown in most cases.  Filtering only for the mutex locks, it
   will more likely get the owners.

  - -S/--callstack-filter is to limit display entries having the given
   string in the callstack

  $ sudo ./perf lock contention -abv -S net sleep 1
  ...
   contended   total wait     max wait     avg wait         type   caller

           5     70.20 us     16.13 us     14.04 us     spinlock   __dev_queue_xmit+0xb6d
                          0xffffffffa5dd1c60  _raw_spin_lock+0x30
                          0xffffffffa5b8f6ed  __dev_queue_xmit+0xb6d
                          0xffffffffa5cd8267  ip6_finish_output2+0x2c7
                          0xffffffffa5cdac14  ip6_finish_output+0x1d4
                          0xffffffffa5cdb477  ip6_xmit+0x457
                          0xffffffffa5d1fd17  inet6_csk_xmit+0xd7
                          0xffffffffa5c5f4aa  __tcp_transmit_skb+0x54a
                          0xffffffffa5c6467d  tcp_keepalive_timer+0x2fd

  Please note that to have the -b option (BPF) working above one has to build
  with BUILD_BPF_SKEL=1.

  - Add more 'perf test' entries to test these new features.

- Add Ian Rogers to MAINTAINERS as a perf tools reviewer.

- Add support for retire latency feature (pipeline stall of a instruction
  compared to the previous one, in cycles) present on some Intel processors.

- Add 'perf c2c' report option to show false sharing with adjacent cachelines, to
  be used in machines with cacheline prefetching, where accesses to a cacheline
  brings the next one too.

- Skip 'perf test bpf' when the required kernel-debuginfo package isn't installed.

perf script:

- Add 'cgroup' field for 'perf script' output:

  $ perf record --all-cgroups -- true
  $ perf script -F comm,pid,cgroup
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...

- Add support for showing branch speculation information in 'perf
  script' and in the 'perf report' raw dump (-D).

perf record:

- Fix 'perf record' segfault with --overwrite and --max-size.

Intel PT:

- Add support for synthesizing "cycle" events from Intel PT traces as we
  support "instruction" events when Intel PT CYC packets are available. This
  enables much more accurate profiles than when using the regular 'perf record -e
  cycles' (the default) when the workload lasts for very short periods (<10ms).

- .plt symbol handling improvements, better handling IBT (in the past
  MPX) done in the context of decoding Intel PT processor traces, IFUNC
  symbols on x86_64, static executables, understanding .plt.got symbols on
  x86_64.

- Add a 'perf test' to test symbol resolution, part of the .plt
  improvements series, this tests things like symbol size in contexts
  where only the symbol start is available (kallsyms), etc.

- Better handle auxtrace/Intel PT data when using pipe mode (perf record sleep 1|perf report).

- Fix symbol lookup with kcore with multiple segments match stext,
  getting the symbol resolution to just show DSOs as unknown.

ARM:

- Timestamp improvements for ARM64 systems with ETMv4 (Embedded Trace
  Macrocell v4).

- Ensure ARM64 CoreSight timestamps don't go backwards.

- Document that ARM64 SPE (Statistical Profiling Extension) is used with 'perf c2c/mem'.

- Add raw decoding for ARM64 SPEv1.2 previous branch address.

- Update neoverse-n2-v2 ARM vendor events (JSON tables): topdown L1, TLB,
  cache, branch, PE utilization and instruction mix metrics.

- Update decoder code for OpenCSD version 1.4, on ARM64 systems.

- Fix command line auto-complete of CPU events on aarch64.

perf test/bench:

- Switch basic BPF filtering test to use syscall tracepoint to avoid the
  variable number of probes inserted when using the previous probe point
  (do_epoll_wait) that happens on different CPU architectures.

- Fix DWARF unwind test by adding non-inline to expected function in a
  backtrace.

- Use 'grep -c' where the longer form 'grep | wc -l' was being used.

- Add getpid and execve benchmarks to 'perf bench syscall'.

Miscellaneous:

- Avoid d3-flame-graph package dependency in 'perf script flamegraph',
  making this feature more generally available.

- Add JSON metric events to present CPI stall cycles in Power10.

- Assorted improvements/refactorings on the JSON metrics parsing code.

Build:

- Fix 'perf probe' and 'perf test' when libtraceevent isn't linked, as
  several tests use tracepoints, those should be skipped.

- More fallout fixes for the removal of tools/lib/traceevent/.

- Fix build error when linking with libpfm.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (19):
      perf test: Add Symbols test
      perf symbols: Factor out get_plt_sizes()
      perf symbols: Check plt_entry_size is not zero
      perf symbols: Add dso__find_symbol_nocache()
      perf symbols: Slightly simplify 'err' usage in dso__synthesize_plt_symbols()
      perf symbols: Do not check ss->dynsym twice
      perf symbols: Add symbol for .plt header
      perf symbols: Allow for .plt entries with no symbol
      perf symbols: Combine handling for SHT_RELA and SHT_REL
      perf symbols: Check SHT_RELA and SHT_REL type earlier
      perf symbols: Correct plt entry sizes for x86
      perf symbols: Add support for x86 .plt.sec
      perf symbols: Sort plt relocations for x86
      perf symbols: Record whether a symbol is an alias for an IFUNC symbol
      perf symbols: Add support for IFUNC symbols for x86_64
      perf symbols: Allow for .plt without header
      perf symbols: Allow for static executables with .plt
      perf symbols: Start adding support for .plt.got for x86
      perf symbols: Get symbols for .plt.got for x86-64

Arnaldo Carvalho de Melo (3):
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf tools: Add Ian Rogers to MAINTAINERS as a reviewer
      Merge remote-tracking branch 'torvalds/master' into perf/core

Athira Rajeev (8):
      perf test buildid: Fix shell string substitutions
      perf tests shell: Add check for perf data file in record+probe_libc_inet_pton test
      perf tests shell: Fix check for libtracevent support
      perf probe: Fix usage when libtraceevent is missing
      perf test bpf: Check for libtraceevent support
      perf probe: Update the exit error codes in function try_to_find_probe_trace_event
      perf test bpf: Skip test if kernel-debuginfo is not present
      perf vendor events power10: Add JSON metric events to present CPI stall cycles in powerpc

Diederik de Haas (3):
      perf: Various spelling fixes
      perf test: Replace 'grep | wc -l' with 'grep -c'
      perf test: Replace legacy `...` with $(...)

Feng Tang (1):
      perf c2c: Add report option to show false sharing in adjacent cachelines

German Gomez (4):
      perf pmu: Add function to check if a pmu file exists
      perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
      perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
      perf cs_etm: Set the time field in the synthetic samples

Ian Rogers (24):
      perf script flamegraph: Avoid d3-flame-graph package dependency
      perf llvm: Fix inadvertent file creation
      perf tools: Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
      perf trace: Reduce #ifdefs for TEP_FIELD_IS_RELATIVE
      perf debug: Increase libtraceevent logging when verbose
      perf test workload thloop: Make count increments atomic
      perf tools: Fix foolproof typo
      perf buildid: Avoid copy of uninitialized memory
      perf jevents metric: Correct Function equality
      perf jevents metric: Add ability to rewrite metrics in terms of others
      perf jevents: Rewrite metrics in the same file with each other
      perf pmu-events: Add separate metric from pmu_event
      perf pmu-events: Separate the metrics from events for no jevents
      perf pmu-events: Remove now unused event and metric variables
      perf stat: Remove evsel metric_name/expr
      perf jevents: Combine table prefix and suffix writing
      perf pmu-events: Introduce pmu_metrics_table
      perf jevents: Generate metrics and events as separate tables
      perf jevents: Add model list option
      perf pmu-events: Fix testing with JEVENTS_ARCH=all
      perf jevents: Correct bad character encoding
      tools build: Add test echo-cmd
      perf jevents: Run metric_test.py at compile-time
      perf stat: Avoid merging/aggregating metric counts twice

James Clark (6):
      perf pmu: Remove duplication around EVENT_SOURCE_DEVICE_PATH
      perf pmu: Use perf_pmu__open_file() and perf_pmu__scan_file()
      perf pmu: Remove remaining duplication of bus/event_source/devices/...
      perf cs-etm: Ensure that Coresight timestamps don't go backwards
      perf cs-etm: Improve missing sink warning message
      perf mem/c2c: Document that SPE is used for mem and c2c on ARM

Jing Zhang (9):
      perf pmu: Add #slots literal support for arm64
      perf jevent: Add general metrics support
      perf vendor events arm64: Add common topdown L1 metrics
      perf vendor events arm64: Add topdown L1 metrics for neoverse-n2-v2
      perf vendor events arm64: Add TLB metrics for neoverse-n2-v2
      perf vendor events arm64: Add cache metrics for neoverse-n2-v2
      perf vendor events arm64: Add branch metrics for neoverse-n2-v2
      perf vendor events arm64: Add PE utilization metrics for neoverse-n2-v2
      perf vendor events arm64: Add instruction mix metrics for neoverse-n2-v2

Kajol Jain (1):
      perf tests stat_all_metrics: Change true workload to sleep workload for system wide check

Kan Liang (6):
      perf vendor events intel: Add Emerald Rapids
      perf report: Support Retire Latency
      perf script: Support Retire Latency
      perf test x86: Support the retire_lat (Retire Latency) sample_type check
      perf event x86: Add retire_lat when synthesizing PERF_SAMPLE_WEIGHT_STRUCT
      perf script: Fix missing Retire Latency fields option documentation

Krister Johansen (1):
      perf symbols: Symbol lookup with kcore can fail if multiple segments match stext

Mike Leach (1):
      perf cs-etm: Update decoder code for OpenCSD version 1.4

Namhyung Kim (14):
      perf inject: Use perf_data__read() for auxtrace
      perf intel-pt: Do not try to queue auxtrace data on pipe
      perf session: Avoid calling lseek(2) for pipe
      perf test: Add pipe mode test to the Intel PT test suite
      perf script: Add 'cgroup' field for output
      perf lock contention: Add -S/--callstack-filter option
      perf stat: Hide invalid uncore event output for aggr mode
      perf test: Add more test cases for perf lock contention
      perf lock contention: Factor out lock_contention_get_name()
      perf lock contention: Use lock_stat_find{,new}
      perf lock contention: Support filters for different aggregation
      perf lock contention: Fix to save callstack for the default modified
      perf lock contention: Add -o/--lock-owner option
      perf lock contention: Support old rw_semaphore type

Naveen N. Rao (2):
      perf test: Switch basic bpf filtering test to use syscall tracepoint
      perf test: Fix DWARF unwind test by adding non-inline to expected function in a backtrace

Rob Herring (2):
      perf arm-spe: Only warn once for each unsupported address packet
      perf arm-spe: Add raw decoding for SPEv1.2 previous branch address

Ross Zwisler (1):
      perf tools docs: Use canonical ftrace path

Sandipan Das (2):
      perf script: Show branch speculation info
      perf session: Show branch speculation info in raw dump

Steinar H. Gunderson (1):
      perf intel-pt: Synthesize cycle events

Thomas Richter (1):
      perf tools: Fix perf tool build error in util/pfm.c

Tiezhu Yang (4):
      tools x86: Keep list sorted by number in unistd_{32,64}.h
      perf bench syscall: Introduce bench_syscall_common()
      perf bench syscall: Add getpgid syscall benchmark
      perf bench syscall: Add execve syscall benchmark

Yang Jihong (1):
      perf record: Fix segfault with --overwrite and --max-size

Yicong Yang (1):
      perf tools: Fix auto-complete on aarch64

qinyu (1):
      perf docs: Fix a typo in 'perf probe' man page: l20th -> 120th

 MAINTAINERS                                        |   1 +
 tools/arch/x86/include/uapi/asm/unistd_32.h        |  23 +-
 tools/arch/x86/include/uapi/asm/unistd_64.h        |  23 +-
 tools/build/Makefile.build                         |   1 +
 tools/perf/.gitignore                              |   1 +
 tools/perf/Documentation/itrace.txt                |   3 +-
 tools/perf/Documentation/perf-bench.txt            |   2 +-
 tools/perf/Documentation/perf-c2c.txt              |  16 +-
 tools/perf/Documentation/perf-intel-pt.txt         |  66 ++-
 tools/perf/Documentation/perf-list.txt             |   2 +-
 tools/perf/Documentation/perf-lock.txt             |  11 +
 tools/perf/Documentation/perf-mem.txt              |   7 +-
 tools/perf/Documentation/perf-probe.txt            |   2 +-
 tools/perf/Documentation/perf-report.txt           |   4 +-
 tools/perf/Documentation/perf-script-perl.txt      |   2 +-
 tools/perf/Documentation/perf-script-python.txt    |   4 +-
 tools/perf/Documentation/perf-script.txt           |   7 +-
 tools/perf/Documentation/perf-test.txt             |   3 +
 tools/perf/Documentation/perf-top.txt              |   2 +-
 tools/perf/Makefile.config                         |   4 -
 tools/perf/Makefile.perf                           |   1 +
 tools/perf/arch/arm/util/auxtrace.c                |   5 +-
 tools/perf/arch/arm/util/cs-etm.c                  | 103 +++-
 tools/perf/arch/arm64/util/pmu.c                   |  44 +-
 tools/perf/arch/powerpc/util/header.c              |   4 +-
 tools/perf/arch/x86/tests/sample-parsing.c         |   5 +-
 tools/perf/arch/x86/util/event.c                   |  21 +
 tools/perf/arch/x86/util/pmu.c                     |  12 +-
 tools/perf/bench/bench.h                           |   2 +
 tools/perf/bench/syscall.c                         |  76 ++-
 tools/perf/builtin-bench.c                         |   4 +-
 tools/perf/builtin-c2c.c                           |  21 +-
 tools/perf/builtin-inject.c                        |   6 +-
 tools/perf/builtin-list.c                          |  20 +-
 tools/perf/builtin-lock.c                          | 147 +++++-
 tools/perf/builtin-probe.c                         |   9 +
 tools/perf/builtin-record.c                        |  16 +-
 tools/perf/builtin-script.c                        |  40 +-
 tools/perf/builtin-stat.c                          |   1 -
 tools/perf/builtin-trace.c                         |   4 +-
 tools/perf/perf-completion.sh                      |  11 +-
 tools/perf/pmu-events/Build                        |  16 +-
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     | 273 +++++++++++
 tools/perf/pmu-events/arch/arm64/sbsa.json         |  30 ++
 .../pmu-events/arch/powerpc/power10/metrics.json   |   8 +-
 .../pmu-events/arch/powerpc/power10/others.json    |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   2 +-
 tools/perf/pmu-events/empty-pmu-events.c           | 108 ++++-
 tools/perf/pmu-events/jevents.py                   | 359 +++++++++++---
 tools/perf/pmu-events/metric.py                    |  79 ++-
 tools/perf/pmu-events/metric_test.py               |  15 +-
 tools/perf/pmu-events/pmu-events.h                 |  26 +-
 tools/perf/scripts/python/flamegraph.py            | 107 ++++-
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/bpf-script-example.c              |   2 +-
 tools/perf/tests/bpf.c                             |  28 +-
 tools/perf/tests/builtin-test.c                    |   3 +
 tools/perf/tests/dwarf-unwind.c                    |   5 +-
 tools/perf/tests/expand-cgroup.c                   |   4 +-
 tools/perf/tests/parse-metric.c                    |   4 +-
 tools/perf/tests/pmu-events.c                      |  69 +--
 tools/perf/tests/sample-parsing.c                  |   2 +-
 tools/perf/tests/shell/buildid.sh                  |  18 +-
 tools/perf/tests/shell/lib/coresight.sh            |  18 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   8 +
 tools/perf/tests/shell/lock_contention.sh          |  66 ++-
 .../tests/shell/record+probe_libc_inet_pton.sh     |  11 +
 .../tests/shell/record+script_probe_vfs_getname.sh |   3 +
 tools/perf/tests/shell/stat_all_metrics.sh         |   2 +-
 tools/perf/tests/shell/test_brstack.sh             |  18 +-
 tools/perf/tests/shell/test_intel_pt.sh            |  17 +
 tools/perf/tests/symbols.c                         | 150 ++++++
 tools/perf/tests/tests.h                           |   3 +
 tools/perf/tests/workloads/thloop.c                |   2 +-
 tools/perf/util/Build                              |   5 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   6 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |   4 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   1 +
 tools/perf/util/auxtrace.c                         |  12 +-
 tools/perf/util/auxtrace.h                         |   7 +-
 tools/perf/util/bpf_lock_contention.c              | 183 ++++---
 tools/perf/util/bpf_skel/lock_contention.bpf.c     | 104 +++-
 tools/perf/util/bpf_skel/lock_data.h               |   4 +-
 tools/perf/util/branch.c                           |  15 +
 tools/perf/util/branch.h                           |   2 +
 tools/perf/util/cacheline.h                        |  25 +-
 tools/perf/util/cgroup.c                           |   1 -
 tools/perf/util/cputopo.c                          |   9 +-
 tools/perf/util/cs-etm-base.c                      |  34 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  71 ++-
 tools/perf/util/cs-etm.c                           |  95 +++-
 tools/perf/util/cs-etm.h                           |  16 +-
 tools/perf/util/data-convert-bt.c                  |   4 +-
 tools/perf/util/debug.c                            |  15 +
 tools/perf/util/evsel.c                            |  21 +-
 tools/perf/util/evsel.h                            |   2 -
 tools/perf/util/evswitch.h                         |   4 +-
 tools/perf/util/expr.c                             |   5 +
 tools/perf/util/expr.h                             |   1 +
 tools/perf/util/expr.l                             |   8 +-
 tools/perf/util/intel-pt.c                         |  73 ++-
 tools/perf/util/llvm-utils.c                       |  25 +-
 tools/perf/util/lock-contention.h                  |   7 +
 tools/perf/util/metricgroup.c                      | 207 ++++----
 tools/perf/util/metricgroup.h                      |   4 +-
 tools/perf/util/parse-events.c                     |   2 -
 tools/perf/util/pfm.c                              |   6 +-
 tools/perf/util/pmu-hybrid.c                       |  27 +-
 tools/perf/util/pmu.c                              | 227 ++++-----
 tools/perf/util/pmu.h                              |  21 +-
 tools/perf/util/print-events.c                     |  32 +-
 tools/perf/util/print-events.h                     |   3 +-
 tools/perf/util/probe-event.c                      |   4 +-
 tools/perf/util/python.c                           |  19 +-
 tools/perf/util/sample.h                           |   5 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   4 +-
 .../util/scripting-engines/trace-event-python.c    |   4 +-
 tools/perf/util/session.c                          |  14 +-
 tools/perf/util/sort.c                             |  20 +-
 tools/perf/util/sort.h                             |   3 +
 tools/perf/util/stat-display.c                     |  51 +-
 tools/perf/util/stat-shadow.c                      | 114 +----
 tools/perf/util/stat.h                             |   1 -
 tools/perf/util/symbol-elf.c                       | 527 +++++++++++++++++----
 tools/perf/util/symbol.c                           |  26 +-
 tools/perf/util/symbol.h                           |   3 +
 tools/perf/util/symsrc.h                           |   1 +
 tools/perf/util/synthetic-events.c                 |   4 +-
 tools/perf/util/trace-event.h                      |  19 +
 129 files changed, 3210 insertions(+), 1092 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/sbsa.json
 mode change 100644 => 100755 tools/perf/pmu-events/metric_test.py
 create mode 100644 tools/perf/tests/symbols.c
