Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7F5F7ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJGUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJGUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38356127BCE;
        Fri,  7 Oct 2022 13:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8F861B6C;
        Fri,  7 Oct 2022 20:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5BCC433C1;
        Fri,  7 Oct 2022 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665174737;
        bh=8RKVYrERlzKbkub/ZvGeNYeJaii8w6dE8/2khz0Z8Zw=;
        h=From:To:Cc:Subject:Date:From;
        b=fYUiH1b886AJIhX5Dj1WVgom9JoEu/x5bDLHZo0/wAGdX+V1bKOFxpz03m3UXZlG8
         56Kr0CsCKhzhz1v/0abreoYsfo50Jzpib4KkRV0SNX4uSba+RdjfmLcmkdM1wevXn6
         XzI6cD3jxBOUFe3kYszOQ8/DwpNusSCAJxtpxL69XRRU/kQ8EbaH9+SZW7nuwRLV4t
         pVBbOgmIvZWfmApm9oYbdA/apV5jWOwXaDr2tbb7yLH4DVCmYFWIXGTI44nkpyhB6/
         q6VBNOv5Vvy7+se+/y3Q2KXlq08P54uO1SMbUitiUDrwWOO0JO1qF793o67QoHABCj
         /h0X/Zj+oiOig==
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
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Raul Silvera <rsilvera@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Xin Gao <gaoxin@cdjrlc.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.1: 1st batch
Date:   Fri,  7 Oct 2022 17:31:53 -0300
Message-Id: <20221007203153.228388-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.3
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


The following changes since commit 725737e7c21d2d25a4312c2aaa82a52bd03e3126:

  Merge tag 'statx-dioalign-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux (2022-10-03 20:33:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.1-1-2022-10-07

for you to fetch changes up to d79310700590b8b40d8c867012d6c899ea6fd505:

  perf script: Add missing fields in usage hint (2022-10-06 16:32:20 -0300)

----------------------------------------------------------------
perf tools changes for v6.1: 1st batch

- Add support for AMD on 'perf mem' and 'perf c2c', the kernel enablement
  patches went via tip.

  Example:

  $ sudo perf mem record -- -c 10000
  ^C[ perf record: Woken up 227 times to write data ]
  [ perf record: Captured and wrote 58.760 MB perf.data (836978 samples) ]

  $ sudo perf mem report -F mem,sample,snoop
  Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
  Memory access                  Samples  Snoop
  N/A                             700620  N/A
  L1 hit                          126675  N/A
  L2 hit                             424  N/A
  L3 hit                             664  HitM
  L3 hit                              10  N/A
  Local RAM hit                        2  N/A
  Remote RAM (1 hop) hit            8558  N/A
  Remote Cache (1 hop) hit             3  N/A
  Remote Cache (1 hop) hit             2  HitM
  Remote Cache (2 hops) hit           10  HitM
  Remote Cache (2 hops) hit            6  N/A
  Uncached hit                         4  N/A
  $

- "perf lock" improvements:

  - Add -E/--entries option to limit the number of entries to display, say to ask for
    just the top 5 contended locks.

  - Add -q/--quiet option to suppress header and debug messages.

  - Add a 'perf test' kernel lock contention entry to test 'perf lock'.

- "perf lock contention" improvements:

  - Ask BPF's bpf_get_stackid() to skip some callchain entries.

    The ones closer to the tooling are bpf related and not that interesting, the
    ones calling the locking function are the ones we're interested in, example
    of a full, unskipped callstack:

  - Allow changing the callstack depth and number of entries to skip.

           1     10.74 us     10.74 us     10.74 us     spinlock   __bpf_trace_contention_begin+0xb
                          0xffffffffc03b5c47  bpf_prog_bf07ae9e2cbd02c5_contention_begin+0x117
                          0xffffffffc03b5c47  bpf_prog_bf07ae9e2cbd02c5_contention_begin+0x117
                          0xffffffffbb8b8e75  bpf_trace_run2+0x35
                          0xffffffffbb7eab9b  __bpf_trace_contention_begin+0xb
                          0xffffffffbb7ebe75  queued_spin_lock_slowpath+0x1f5
                          0xffffffffbc1c26ff  _raw_spin_lock+0x1f
                          0xffffffffbb841015  tick_do_update_jiffies64+0x25
                          0xffffffffbb8409ee  tick_irq_enter+0x9e

  - Show full callstack in verbose mode (-v option), sometimes this is desirable
    instead of showing just one callstack entry.

- Allow multiple time ranges in 'perf record --delay' to help in reducing the
  amount of data collected from hardware tracing (Intel PT, etc) when there is
  a rough idea of periods of time where events of interest take time.

- Add Intel PT to record only decoder debug messages when error happens.

- Improve layout of Intel PT man page.

- Add new branch types: alignment, data and inst faults and arch specific ones,
  such as fiq, debug_halt, debug_exit, debug_inst and debug_data on arm64.

  Kernel enablement went thru the tip tree.

- Fix 'perf probe' error log check in 'perf test' when no debuginfo is
  available.

- Fix 'perf stat' aggregation mode logic, it should be looking at the CPU
  not at the core number.

- Fix flags parsing in 'perf trace' filters.

- Introduce compact encoding of CPU range encoding on perf.data, to avoid
  having a bitmap with all the CPUs.

- Improvements to the 'perf stat' metrics, including adding "core_wide", and
  computing "smt" from the CPU topology.

- Add support to the new PERF_FORMAT_LOST perf_event_attr.read_format, that allows
  tooling to ask for the precise number of lost samples for a given event.

- Add 'addr' sort key to see just the address of sampled instructions:

  $ perf record -o- true | perf report -i- -s addr
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  # Samples: 12  of event 'cycles:u'
  # Event count (approx.): 252512
  #
  # Overhead  Address
  # ........  ..................
      42.96%  0x7f96f08443d7
      29.55%  0x7f96f0859b50
      14.76%  0x7f96f0852e02
       8.30%  0x7f96f0855028
       4.43%  0xffffffff8de01087

  perf annotate: Toggle full address <-> offset display

- Add 'f' hotkey to the 'perf annotate' TUI interface when in 'disassembler output'
  mode ('o' hotkey) to toggle showing full virtual address or just the offset.

- Cache DSO build-ids when synthesizing PERF_RECORD_MMAP records for pre-existing threads,
  at the start of a 'perf record' session, speeding up that record startup phase.

- Add a command line option to specify build ids in 'perf inject'.

- Update JSON event files for the Intel alderlake, broadwell, broadwellde,
  broadwellx, cascadelakex, haswell, haswellx, icelake, icelakex, ivybridge,
  ivytown, jaketown, sandybridge, sapphirerapids, skylake, skylakex, and
  tigerlake processors.

- Update vendor JSON event files for the ARM Neoverse V1 and E1 platforms.

- Add a 'perf test' entry for 'perf mem' where a struct has false sharing and
  this gets detected in the 'perf mem' output, tested with Intel, AMD and ARM64
  systems.

- Add a 'perf test' entry to test the resolution of java symbols, where an
  output like this is expected:

     8.18%  jshell    jitted-50116-29.so    [.] Interpreter
     0.75%  Thread-1  jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)

- Add tests for the ARM64 CoreSight hardware tracing feature, with specially
  crafted pureloop, memcpy, thread loop and unroll tread that then gets
  traced and the output compared with expected output.

  Documentation explaining it is also included.

- Add per thread Intel PT 'perf test' entry to check that PERF_RECORD_TEXT_POKE events
  are recorded per CPU, resulting in a mixture of per thread and per CPU events and mmaps,
  verify that this gets all recorded correctly.

- Introduce pthread mutex wrappers to allow for building with clang's
  -Wthread-safety, i.e. using the "guarded_by" "pt_guarded_by" "lockable",
  "exclusive_lock_function", "exclusive_trylock_function",
  "exclusive_locks_required", and "no_thread_safety_analysis" compiler function
  attributes.

- Fix empty version number when building outside of a git repo.

- Improve feature detection display when multiple versions of a feature are present, such
  as for binutils libbfd, that has a mix of possible ways to detect according to the
  Linux distribution.

  Previously in some cases we had:

  Auto-detecting system features
  <SNIP>
  ...                                  libbfd: [ on  ]
  ...                          libbfd-liberty: [ on  ]
  ...                        libbfd-liberty-z: [ on  ]
  <SNIP>

  Now for this case we show just the main feature:

  Auto-detecting system features
  <SNIP>
  ...                                  libbfd: [ on  ]
  <SNIP>

- Remove some unused structs, variables, macros, function prototypes and
  includes from various places.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (24):
      perf record: Fix way of handling non-perf-event pollfds
      perf record: Fix done_fd wakeup event
      perf record: Change evlist->ctl_fd to use fdarray_flag__non_perf_event
      perf evlist: Add evlist__{en/dis}able_non_dummy()
      perf record: Allow multiple recording time ranges
      perf tools: Add perf_config_scan()
      perf auxtrace: Add itrace option flag d+e to log on error
      perf intel-pt: Improve man page layout slightly
      perf intel-pt: Improve object code read error message
      perf intel-pt: Support itrace option flag d+e to log on error
      perf intel-pt: Remove first line of log dumped on error
      perf test: test_intel_pt.sh: Add cleanup function
      perf test: test_intel_pt.sh: Use a temp directory
      perf test: test_intel_pt.sh: Fix redirection
      perf test: test_intel_pt.sh: Stop using expr
      perf test: test_intel_pt.sh: Stop using backticks
      perf test: test_intel_pt.sh: Use grep -c instead of grep plus wc -l
      perf test: test_intel_pt.sh: Use quotes around variable expansion
      perf test: test_intel_pt.sh: Fix return checking
      perf test: test_intel_pt.sh: Add more output in preparation for more tests
      perf tools: Add debug messages and comments for testing
      perf test: test_intel_pt.sh: Add per-thread test
      perf test: test_intel_pt.sh: Move helper functions for waiting
      perf test: waiting.sh: Parameterize timeouts

Anshuman Khandual (4):
      perf branch: Add system error and not in transaction branch types
      perf branch: Extend branch type classification
      perf branch: Add branch privilege information request flag
      perf branch: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

Athira Rajeev (2):
      perf tests: Fix 'perf probe' error log check in skip_if_no_debuginfo
      perf stat: Fix cpu check to use id.cpu.cpu in aggr_printout()

Carsten Haitzler (13):
      perf test: Add CoreSight shell lib shared code for future tests
      perf test: Add build infra for perf test tools for ARM CoreSight tests
      perf test: Add asm pureloop test tool
      perf test: Add arm64 asm pureloop test shell script
      perf test: Add git ignore for perf data generated by the ARM CoreSight tests
      perf test coresight: Add memcpy thread test tool
      perf test coresight: Add memcpy thread test shell script
      perf test coresight: Add thread loop test tool
      perf test coresight: Add thread loop test shell scripts
      perf test coresight: Add unroll thread test tool
      perf test coresight: Add unroll thread test shell script
      perf test: Add git ignore for tmp and output files of ARM CoreSight tests
      perf test coresight: Add relevant documentation about ARM64 CoreSight testing

Chen Zhongjin (4):
      perf string: Remove unused macro K()
      perf trace: Fix show_arg_names not working for tp arg names
      perf trace: Fix incorrectly parsed hexadecimal value for flags in filter
      perf parse-events: Remove unused macros __PERF_EVENT_FIELD()

Gaosheng Cui (2):
      perf sort: Remove hist_entry__sort_list() and sort__first_dimension() leftover declarations
      perf pmu: Remove perf_pmu_lex() needless declaration

Ian Rogers (50):
      perf hashmap: Tidy hashmap dependency
      perf bench: Update use of pthread mutex/cond
      perf tests: Avoid pthread.h inclusion
      perf hist: Update use of pthread mutex
      perf bpf: Remove unused pthread.h include
      perf lock: Remove unused pthread.h include
      perf record: Update use of pthread mutex
      perf sched: Update use of pthread mutex
      perf ui: Update use of pthread mutex
      perf mmap: Remove unnecessary pthread.h include
      perf dso: Update use of pthread mutex
      perf annotate: Update use of pthread mutex
      perf top: Update use of pthread mutex
      perf dso: Hold lock when accessing nsinfo
      perf mutex: Add thread safety annotations
      perf sched: Fixes for thread safety analysis
      perf top: Fixes for thread safety analysis
      perf build: Enable -Wthread-safety with clang
      perf smt: Tidy header guard add SPDX
      perf events: Prefer union over variable length array
      perf cpumap: Add range data encoding
      perf expr: Move the scanner_ctx into the parse_ctx
      perf smt: Compute SMT from topology
      perf topology: Add core_wide
      perf stat: Delay metric parsing
      perf metrics: Wire up core_wide
      perf test: Add basic core_wide expression test
      perf expr: Allow a double if expression
      perf test: Adjust case of test metrics
      perf expr: Remove jevents case workaround
      perf metrics: Don't scale counts going into metrics
      perf vendor events: Update Intel skylakex
      perf vendor events: Update Intel alderlake
      perf vendor events: Update Intel broadwell
      perf vendor events: Update Intel broadwellx
      perf vendor events: Update Intel cascadelakex
      perf vendor events: Update elkhartlake cpuids
      perf vendor events: Update Intel haswell
      perf vendor events: Update Intel haswellx
      perf vendor events: Update Intel icelake
      perf vendor events: Update Intel icelakex
      perf vendor events: Update Intel ivybridge
      perf vendor events: Update Intel ivytown
      perf vendor events: Update Intel jaketown
      perf vendor events: Update Intel sandybridge
      perf vendor events: Update Intel sapphirerapids
      perf vendor events: Update silvermont cpuids
      perf vendor events: Update Intel skylake
      perf vendor events: Update Intel tigerlake
      perf vendor events: Update Intel broadwellde

Leo Yan (3):
      perf subcmd: Set environment variable "PREFIX"
      perf test: Introduce script for java symbol testing
      perf test: Introduce script for data symbol testing

Namhyung Kim (32):
      perf tools: Print LOST read format in the verbose mode
      perf record: Set PERF_FORMAT_LOST by default
      perf record: Read and inject LOST_SAMPLES events
      perf hist: Add nr_lost_samples to hist_stats
      perf report: Show per-event LOST SAMPLES stat
      perf sched: Factor out destroy_tasks()
      perf test: Skip sigtrap test on old kernels
      perf lock contention: Factor out get_symbol_name_offset()
      perf lock contention: Show full callstack with -v option
      perf lock contention: Allow to change stack depth and skip
      perf lock contention: Skip stack trace from BPF
      perf record: Fix a segfault in record__read_lost_samples()
      perf inject: Clarify build-id options a little bit
      perf tools: Add 'addr' sort key
      perf annotate: Toggle full address <-> offset display
      perf lock: Add -E/--entries option
      perf lock: Add -q/--quiet option to suppress header and debug messages
      perf test: Add kernel lock contention test
      perf lock contention: Fix a build error on 32-bit
      libperf: Populate system-wide evsel maps
      libperf: Propagate maps only if necessary
      perf tools: Get rid of evlist__add_on_all_cpus()
      perf tools: Add evlist__add_sched_switch()
      perf tools: Remove special handling of system-wide evsel
      perf stat: Convert perf_stat_evsel.res_stats array
      perf stat: Don't call perf_stat_evsel_id_init() repeatedly
      perf stat: Rename saved_value->cpu_map_idx
      perf stat: Use thread map index for shadow stat
      perf stat: Kill unused per-thread runtime stats
      perf stat: Don't compare runtime stat for shadow stats
      perf stat: Rename to aggr_cpu_id.thread_idx
      perf record: Save DSO build-ID for synthesizing

Nick Forrington (3):
      perf vendor events: Add missing Neoverse V1 events
      perf vendor events arm64: Move REMOTE_ACCESS to "memory" category
      perf vendor events: Update events for Neoverse E1

Pavithra Gurushankar (1):
      perf mutex: Wrapped usage of mutex and cond

Raul Silvera (1):
      perf inject: Add a command line option to specify build ids.

Ravi Bangoria (8):
      tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel
      perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h header with the kernel
      perf mem: Add support for printing PERF_MEM_LVLNUM_{CXL|IO}
      perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
      perf mem/c2c: Add load store event mappings for AMD
      perf mem/c2c: Avoid printing empty lines for unsupported events
      perf mem: Print "LFB/MAB" for PERF_MEM_LVLNUM_LFB
      perf script: Add missing fields in usage hint

Roberto Sassu (3):
      tools build: Fix feature detection output due to eval expansion
      tools build: Increment room for feature name in feature detection output
      tools build: Display logical OR of a feature flavors

Shang XiaoJing (10):
      perf tools: Add same_cmd_with_prefix() helper
      perf c2c: Add helpers to get counts of loads or stores
      perf trace: Use zalloc() to save initialization of syscall_stats
      perf lock: Add get_key_by_aggr_mode helper
      perf timechart: Add create_pidcomm helper
      perf timechart: Add p_state_end helper
      perf genelf: Fix error code in jit_write_elf()
      perf stat: Merge cases in process_evlist
      perf top: Fix error code in cmd_top()
      perf stat: Clean redundant if in process_evlist

Will Chandler (1):
      perf tools: Fix empty version number when building outside of a git repo

Xin Gao (2):
      perf parse-events: Use 'unsigned int' instead of plain 'unsigned'.
      perf metrics: Use 'unsigned int' instead of just 'unsigned'.

Yuan Can (5):
      perf machine: Remove unused struct process_args
      perf annotate: Remove unused struct disasm_line_samples
      perf metric: Remove unused struct metric_ref_node
      perf jit: Remove unused struct debug_line_info
      perf lock: Remove unused struct lock_contention_key

ye xingchen (1):
      perf callchain: Remove unneeded 'result' variable

 Documentation/trace/coresight/coresight-perf.rst   |  158 +++
 MAINTAINERS                                        |    1 +
 tools/arch/x86/include/asm/amd-ibs.h               |   16 +
 tools/build/Makefile.feature                       |   50 +-
 tools/include/uapi/linux/perf_event.h              |   40 +-
 tools/lib/api/fd/array.h                           |    5 +-
 tools/lib/perf/evlist.c                            |   28 +-
 tools/lib/perf/evsel.c                             |    3 -
 tools/lib/perf/include/internal/evlist.h           |    1 +
 tools/lib/perf/include/perf/event.h                |   25 +-
 tools/lib/subcmd/exec-cmd.c                        |    3 +
 tools/perf/.gitignore                              |    6 +-
 tools/perf/Documentation/itrace.txt                |    1 +
 tools/perf/Documentation/perf-arm-coresight.txt    |    5 +
 tools/perf/Documentation/perf-c2c.txt              |   14 +-
 tools/perf/Documentation/perf-config.txt           |    7 +
 tools/perf/Documentation/perf-inject.txt           |   13 +-
 tools/perf/Documentation/perf-intel-pt.txt         |   13 +-
 tools/perf/Documentation/perf-lock.txt             |   20 +
 tools/perf/Documentation/perf-mem.txt              |    3 +-
 tools/perf/Documentation/perf-record.txt           |    8 +-
 tools/perf/Documentation/perf-report.txt           |    3 +-
 tools/perf/Makefile.config                         |   24 +-
 tools/perf/Makefile.perf                           |   18 +-
 tools/perf/arch/x86/util/intel-pt.c                |   15 +-
 tools/perf/arch/x86/util/mem-events.c              |   31 +-
 tools/perf/bench/epoll-ctl.c                       |   33 +-
 tools/perf/bench/epoll-wait.c                      |   33 +-
 tools/perf/bench/futex-hash.c                      |   33 +-
 tools/perf/bench/futex-lock-pi.c                   |   33 +-
 tools/perf/bench/futex-requeue.c                   |   33 +-
 tools/perf/bench/futex-wake-parallel.c             |   33 +-
 tools/perf/bench/futex-wake.c                      |   33 +-
 tools/perf/bench/numa.c                            |   93 +-
 tools/perf/builtin-c2c.c                           |   66 +-
 tools/perf/builtin-inject.c                        |   89 ++
 tools/perf/builtin-lock.c                          |  274 ++--
 tools/perf/builtin-mem.c                           |    1 +
 tools/perf/builtin-record.c                        |  208 ++-
 tools/perf/builtin-report.c                        |   17 +
 tools/perf/builtin-sched.c                         |  125 +-
 tools/perf/builtin-script.c                        |   12 +-
 tools/perf/builtin-stat.c                          |  126 +-
 tools/perf/builtin-timechart.c                     |   65 +-
 tools/perf/builtin-top.c                           |   48 +-
 tools/perf/builtin-trace.c                         |   18 +-
 tools/perf/perf.c                                  |   12 +-
 .../arm/{cortex-a65 => cortex-a65-e1}/branch.json  |    0
 .../arm/{cortex-a65 => cortex-a65-e1}/bus.json     |    0
 .../arm/{cortex-a65 => cortex-a65-e1}/cache.json   |    0
 .../arm/{cortex-a65 => cortex-a65-e1}/dpu.json     |    0
 .../{cortex-a65 => cortex-a65-e1}/exception.json   |    0
 .../arm/{cortex-a65 => cortex-a65-e1}/ifu.json     |    0
 .../{cortex-a65 => cortex-a65-e1}/instruction.json |    0
 .../arm/{cortex-a65 => cortex-a65-e1}/memory.json  |    0
 .../{cortex-a65 => cortex-a65-e1}/pipeline.json    |    0
 .../arch/arm64/arm/cortex-a76-n1/memory.json       |    3 +
 .../arch/arm64/arm/cortex-a76-n1/other.json        |    5 -
 .../arch/arm64/arm/neoverse-e1/branch.json         |   17 -
 .../pmu-events/arch/arm64/arm/neoverse-e1/bus.json |   17 -
 .../arch/arm64/arm/neoverse-e1/cache.json          |  107 --
 .../arch/arm64/arm/neoverse-e1/exception.json      |   14 -
 .../arch/arm64/arm/neoverse-e1/instruction.json    |   65 -
 .../arch/arm64/arm/neoverse-e1/memory.json         |   23 -
 .../arch/arm64/arm/neoverse-e1/pipeline.json       |    8 -
 .../pmu-events/arch/arm64/arm/neoverse-e1/spe.json |   14 -
 .../arch/arm64/arm/neoverse-n2/memory.json         |    3 +
 .../arch/arm64/arm/neoverse-n2/other.json          |    5 -
 .../arch/arm64/arm/neoverse-v1/instruction.json    |   30 +
 .../arch/arm64/arm/neoverse-v1/memory.json         |    3 +
 .../arch/arm64/arm/neoverse-v1/other.json          |    5 -
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    4 +-
 .../pmu-events/arch/test/test_soc/cpu/metrics.json |    6 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json | 1353 +++++++++++++++++++-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |  129 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |   12 +
 .../perf/pmu-events/arch/x86/alderlake/memory.json |   22 +
 .../perf/pmu-events/arch/x86/alderlake/other.json  |   22 +
 .../pmu-events/arch/x86/alderlake/pipeline.json    |   14 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  679 ++++++++--
 .../arch/x86/broadwellde/bdwde-metrics.json        |  711 ++++++++--
 .../arch/x86/broadwellx/bdx-metrics.json           |  965 +++++++++-----
 .../arch/x86/broadwellx/uncore-cache.json          |   10 +-
 .../arch/x86/broadwellx/uncore-interconnect.json   |   18 +-
 .../arch/x86/broadwellx/uncore-memory.json         |   18 +-
 .../arch/x86/cascadelakex/clx-metrics.json         | 1285 +++++++++++--------
 .../arch/x86/cascadelakex/uncore-memory.json       |   18 +-
 .../arch/x86/cascadelakex/uncore-other.json        |   10 +-
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |    4 +-
 .../perf/pmu-events/arch/x86/haswell/frontend.json |   12 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  570 +++++++--
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |    2 +-
 .../pmu-events/arch/x86/haswellx/frontend.json     |   12 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  919 ++++++++-----
 .../arch/x86/haswellx/uncore-interconnect.json     |   18 +-
 .../arch/x86/haswellx/uncore-memory.json           |   18 +-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |    6 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  808 +++++++++++-
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |    2 +-
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |    6 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  | 1155 ++++++++++++-----
 .../pmu-events/arch/x86/icelakex/pipeline.json     |    2 +-
 .../pmu-events/arch/x86/icelakex/uncore-other.json |    2 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  594 +++++++--
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  |    4 +-
 .../arch/x86/ivytown/floating-point.json           |    2 +-
 .../perf/pmu-events/arch/x86/ivytown/frontend.json |   18 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  630 +++++++--
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   58 +-
 .../arch/x86/ivytown/uncore-interconnect.json      |   84 +-
 .../pmu-events/arch/x86/ivytown/uncore-memory.json |    2 +-
 .../pmu-events/arch/x86/ivytown/uncore-other.json  |    6 +-
 .../pmu-events/arch/x86/ivytown/uncore-power.json  |    8 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  327 +++--
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   18 +-
 .../arch/x86/sandybridge/snb-metrics.json          |  315 +++--
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |    4 +-
 .../arch/x86/sapphirerapids/frontend.json          |   11 +
 .../arch/x86/sapphirerapids/pipeline.json          |    4 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       | 1249 +++++++++++++-----
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  861 ++++++++++---
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  | 1262 +++++++++++-------
 .../arch/x86/skylakex/uncore-memory.json           |   18 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json |   19 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  810 +++++++++++-
 tools/perf/pmu-events/empty-pmu-events.c           |    6 +-
 tools/perf/tests/cpumap.c                          |   52 +-
 tools/perf/tests/event_update.c                    |   14 +-
 tools/perf/tests/expr.c                            |   41 +-
 tools/perf/tests/mmap-basic.c                      |    2 -
 tools/perf/tests/openat-syscall-all-cpus.c         |    2 +-
 tools/perf/tests/perf-record.c                     |    2 -
 tools/perf/tests/shell/coresight/Makefile          |   29 +
 .../perf/tests/shell/coresight/Makefile.miniconfig |   14 +
 tools/perf/tests/shell/coresight/asm_pure_loop.sh  |   18 +
 .../tests/shell/coresight/asm_pure_loop/.gitignore |    1 +
 .../tests/shell/coresight/asm_pure_loop/Makefile   |   34 +
 .../shell/coresight/asm_pure_loop/asm_pure_loop.S  |   28 +
 .../tests/shell/coresight/memcpy_thread/.gitignore |    1 +
 .../tests/shell/coresight/memcpy_thread/Makefile   |   33 +
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |   79 ++
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |   18 +
 .../tests/shell/coresight/thread_loop/.gitignore   |    1 +
 .../tests/shell/coresight/thread_loop/Makefile     |   33 +
 .../shell/coresight/thread_loop/thread_loop.c      |   86 ++
 .../shell/coresight/thread_loop_check_tid_10.sh    |   19 +
 .../shell/coresight/thread_loop_check_tid_2.sh     |   19 +
 .../shell/coresight/unroll_loop_thread/.gitignore  |    1 +
 .../shell/coresight/unroll_loop_thread/Makefile    |   33 +
 .../unroll_loop_thread/unroll_loop_thread.c        |   74 ++
 .../tests/shell/coresight/unroll_loop_thread_10.sh |   18 +
 tools/perf/tests/shell/lib/coresight.sh            |  132 ++
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |    2 +-
 tools/perf/tests/shell/lib/waiting.sh              |   77 ++
 tools/perf/tests/shell/lock_contention.sh          |   73 ++
 tools/perf/tests/shell/test_data_symbol.sh         |   93 ++
 tools/perf/tests/shell/test_intel_pt.sh            |  247 +++-
 tools/perf/tests/shell/test_java_symbol.sh         |   75 ++
 tools/perf/tests/sigtrap.c                         |   65 +-
 tools/perf/tests/switch-tracking.c                 |   15 +-
 tools/perf/tests/topology.c                        |   10 +-
 tools/perf/ui/browser.c                            |   20 +-
 tools/perf/ui/browsers/annotate.c                  |   23 +-
 tools/perf/ui/setup.c                              |    5 +-
 tools/perf/ui/tui/helpline.c                       |    5 +-
 tools/perf/ui/tui/progress.c                       |    8 +-
 tools/perf/ui/tui/setup.c                          |    8 +-
 tools/perf/ui/tui/util.c                           |   18 +-
 tools/perf/ui/ui.h                                 |    4 +-
 tools/perf/util/Build                              |    1 +
 tools/perf/util/PERF-VERSION-GEN                   |   10 +-
 tools/perf/util/annotate.c                         |   34 +-
 tools/perf/util/annotate.h                         |    8 +-
 tools/perf/util/auxtrace.c                         |   13 +
 tools/perf/util/auxtrace.h                         |    3 +
 tools/perf/util/bpf-event.h                        |    1 -
 tools/perf/util/bpf-loader.c                       |    6 +-
 tools/perf/util/bpf_lock_contention.c              |   26 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |    5 +-
 tools/perf/util/branch.c                           |   70 +-
 tools/perf/util/branch.h                           |    7 +-
 tools/perf/util/build-id.c                         |   12 +-
 tools/perf/util/callchain.c                        |   12 +-
 tools/perf/util/config.c                           |   31 +
 tools/perf/util/config.h                           |    1 +
 tools/perf/util/cpumap.c                           |   39 +-
 tools/perf/util/cpumap.h                           |    2 +-
 tools/perf/util/cputopo.c                          |   61 +
 tools/perf/util/cputopo.h                          |    5 +
 tools/perf/util/dso.c                              |   19 +-
 tools/perf/util/dso.h                              |    4 +-
 tools/perf/util/events_stats.h                     |    1 +
 tools/perf/util/evlist.c                           |  316 ++++-
 tools/perf/util/evlist.h                           |   13 +-
 tools/perf/util/evsel.c                            |   30 +-
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/expr.c                             |   40 +-
 tools/perf/util/expr.h                             |   25 +-
 tools/perf/util/expr.l                             |    6 +-
 tools/perf/util/expr.y                             |    2 +-
 tools/perf/util/genelf.c                           |    1 +
 tools/perf/util/header.c                           |   24 +-
 tools/perf/util/hist.c                             |   22 +-
 tools/perf/util/hist.h                             |    6 +-
 tools/perf/util/intel-pt-decoder/intel-pt-log.c    |  117 +-
 tools/perf/util/intel-pt-decoder/intel-pt-log.h    |    3 +-
 tools/perf/util/intel-pt.c                         |   23 +-
 tools/perf/util/jitdump.c                          |    7 -
 tools/perf/util/lock-contention.h                  |    5 +-
 tools/perf/util/machine.c                          |    4 -
 tools/perf/util/map.c                              |    3 +
 tools/perf/util/mem-events.c                       |   17 +-
 tools/perf/util/metricgroup.c                      |  145 ++-
 tools/perf/util/metricgroup.h                      |    4 +-
 tools/perf/util/mmap.h                             |    1 -
 tools/perf/util/mutex.c                            |  119 ++
 tools/perf/util/mutex.h                            |  108 ++
 tools/perf/util/parse-branch-options.c             |    1 +
 tools/perf/util/parse-events.c                     |    8 -
 tools/perf/util/perf_event_attr_fprintf.c          |    4 +-
 tools/perf/util/pmu.c                              |    2 +-
 tools/perf/util/pmu.y                              |    2 -
 tools/perf/util/probe-event.c                      |    3 +
 tools/perf/util/session.c                          |    7 +-
 tools/perf/util/smt.c                              |  110 +-
 tools/perf/util/smt.h                              |   19 +-
 tools/perf/util/sort.c                             |   38 +
 tools/perf/util/sort.h                             |    3 +-
 tools/perf/util/stat-display.c                     |   36 +-
 tools/perf/util/stat-shadow.c                      |  338 +++--
 tools/perf/util/stat.c                             |   29 +-
 tools/perf/util/stat.h                             |   12 +-
 tools/perf/util/string.c                           |    1 -
 tools/perf/util/symbol.c                           |    4 +-
 tools/perf/util/synthetic-events.c                 |  184 +--
 tools/perf/util/top.h                              |    5 +-
 236 files changed, 15807 insertions(+), 5281 deletions(-)
 create mode 100644 Documentation/trace/coresight/coresight-perf.rst
 create mode 100644 tools/perf/Documentation/perf-arm-coresight.txt
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/branch.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/bus.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/dpu.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/exception.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/ifu.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/instruction.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/memory.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/pipeline.json (100%)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json
 create mode 100644 tools/perf/tests/shell/coresight/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig
 create mode 100755 tools/perf/tests/shell/coresight/asm_pure_loop.sh
 create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
 create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
 create mode 100755 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
 create mode 100644 tools/perf/tests/shell/coresight/thread_loop/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/thread_loop/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
 create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
 create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
 create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
 create mode 100755 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
 create mode 100644 tools/perf/tests/shell/lib/coresight.sh
 create mode 100644 tools/perf/tests/shell/lib/waiting.sh
 create mode 100755 tools/perf/tests/shell/lock_contention.sh
 create mode 100755 tools/perf/tests/shell/test_data_symbol.sh
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh
 create mode 100644 tools/perf/util/mutex.c
 create mode 100644 tools/perf/util/mutex.h
