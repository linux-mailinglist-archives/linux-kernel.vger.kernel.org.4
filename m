Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E110264ECF4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiLPOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:36:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3D26A88;
        Fri, 16 Dec 2022 06:36:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C3C862115;
        Fri, 16 Dec 2022 14:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C67BC433EF;
        Fri, 16 Dec 2022 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671201379;
        bh=SBgN16maTx49jLslTM+NjX5PdMWPnkwXxzCXcciHvbg=;
        h=From:To:Cc:Subject:Date:From;
        b=qX+Uc1gCRymJQDi4qIJ0Uquej/sBTVBSPpYARVSgEFp2fx31r1E+KZArGMHc4AcCD
         ftkCP7hdxubjdHXN1RgddaNhC/Nto4UQYDC/tgkAx752wXLl6ifGj/FyHLqT5HpMSx
         K/kolZ6WBTUS+a6bLRan4USTdD8DUsc2vfp450ihjsjxMNCmK0YF2s9xA+OEkkFTLF
         payPzKEJoVM2EMEkDvtB5UjO9AuZLnlrelrkLxPr7wYVASIWbbDJNT3VvctOOY4toV
         LAoyLUnFgmw3x6I97JbPBLdB+d2qNM82sOHtdlI7VkGywURVPV5KtyezDvObjaqZM5
         amclmgBtNQHbw==
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
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.2: 1st batch
Date:   Fri, 16 Dec 2022 11:36:09 -0300
Message-Id: <20221216143609.186415-1-acme@kernel.org>
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

	This time there is a trivial resolution of a merge conflict
related to commit c302378bc157f6a7 ("libbpf: Hashmap interface update to
allow both long and void* keys/values"), that touched tools/perf/ files.

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 84e57d292203a45c96dbcb2e6be9dd80961d981a:

  Merge tag 'exfat-for-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat (2022-12-15 18:14:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.2-1-2022-12-16

for you to fetch changes up to 4ff17c448a7b0f437a17622d67f1c5c609c3a0e9:

  libperf: Fix install_pkgconfig target (2022-12-16 10:04:06 -0300)

----------------------------------------------------------------
perf tools changes for v6.2: 1st batch

Libraries:

- Drop the old copy of libtraceevent in tools/lib/traceevent/ now that all major distros
  ship it from its external repository.

  This is now just another feature detection, emitting a warning when the
  libtraceevent-dev[el] package isn't installed, disabling the build of perf features
  and tools that strictly require parsing things from tracefs while keeping
  the core functionality present and working with a subset of the events, the
  most used ones like CPU cycles, hardware cache and also vendor events, etc.

  This was tested with lots of containers for Fedora, Debian, OpenSUSE, Alpine Linux,
  Ubuntu, with cross builds, etc.

Build:

- Update to C standard to gnu11, like was done for the kernel.

- Install the tools/lib/ libraries locally instead of having headers searched
  directly from the source code directories, to help the cases where we can
  build either from in-kernel source libraries or from the same library shipped
  as a distro package, as is the case with libbpf and was the case with
  libtraceevent.

perf stat:

- Do not delay the workload with --delay, the delay is just for starting to count
  the events, to skip noise at workload startup.

- When we have events for each cgroup, the metric should be printed for each
  cgroup separately.

  $ perf stat -a --for-each-cgroup system.slice,user.slice --metric-only sleep 1

   Performance counter stats for 'system wide':

                   GHz  insn per cycle  branch-misses of all branches
   system.slice  3.792      0.61                  3.24%
   user.slice    3.661      2.32                  0.37%

- Fix printing field separator in CSV metrics output.

- Fix --metric-only --json output.

- Fix summary output in CSV with --metric-only.

- Update event group check for support of uncore event.

perf test:

- Stop requiring a C toolchain in shell tests, instead add a workload option that has
  all the previously C snippets built as part of 'perf test -w' that then get used in
  the 'perf test' shell scripts.

- Add event group test for events in multiple PMUs

- The "kernel lock contention analysis" test should not print warnings in quiet mode.

- Add attr tests for ARM64's new VG register.

- Fix record test on KVM guests, as using precise flag with the
  br_inst_retired.near_call event causes the test fail on KVM guests, even when
  the guests have PMU forwarding enabled and the event itself is supported, so just
  remove the precise flag from the event.

- Add mechanism for skipping attr tests on specific kernel versions where it is known that
  these checks will fail.

- Skip watchpoint tests if no watchpoints available.

- Add more Intel PT 'perf test' entries: hybrid CPUs, split the packet decoder
  into a suite of subtests.

perf script:

- Introduce task analyzer python script, where one first records some events:

Recording can be done in two ways:

  $ perf script record tasks-analyzer -- sleep 10
  $ perf record -e sched:sched_switch -a -- sleep 10

The script can parse any perf.data files, as long as it has sched:sched_switch events,
other events will be ignored.

The most simple report use case is to just call the script without arguments.

Runtime is the time the task was running on the CPU, Time Out-In is the time
between the process being scheduled *out* and scheduled back *in*. So the last
time span between two executions:

  $ perf script report tasks-analyzer
      Switched-In     Switched-Out CPU    PID    TID             Comm  Runtime  Time Out-In
  15576.658891407  15576.659156086   4   2412   2428            gdbus      265         1949
  15576.659111320  15576.659455410   0   2412   2412      gnome-shell      344         2267
  15576.659491326  15576.659506173   2     74     74      kworker/2:1       15        13145
  15576.659506173  15576.659825748   2   2858   2858  gnome-terminal-      320        63263
  15576.659871270  15576.659902872   6  20932  20932    kworker/u16:0       32      2314582
  15576.659909951  15576.659945501   3  27264  27264               sh       36           -1
  15576.659853285  15576.659971052   7  27265  27265             perf      118      5050741
  [...]

perf lock:

- Allow concurrent record and report to support live monitoring of kernel lock
  contention without BPF:

  # perf lock record -a -o- sleep 1 | perf lock contention -i-
   contended   total wait     max wait     avg wait         type   caller

           2     10.27 us      6.17 us      5.13 us     spinlock   load_balance+0xc03
           1      5.29 us      5.29 us      5.29 us     rwlock:W   ep_scan_ready_list+0x54
           1      4.12 us      4.12 us      4.12 us     spinlock   smpboot_thread_fn+0x116
           1      3.28 us      3.28 us      3.28 us        mutex   pipe_read+0x50

- Implement -t/--threads option when using BPF:

  $ sudo ./perf lock contention -abt -E 5 sleep 1
   contended  total wait   max wait   avg wait      pid  comm

           1   740.66 ms  740.66 ms  740.66 ms     1950  nv_queue
           3   305.50 ms  298.19 ms  101.83 ms     1884  nvidia-modeset/
           1    25.14 us   25.14 us   25.14 us  2725038  EventManager_De
          12    23.09 us    9.30 us    1.92 us        0  swapper
           1    20.18 us   20.18 us   20.18 us  2725033  EventManager_De

- Add -l/--lock-addr to aggregate per-lock-instance contention:

  $ sudo ./perf lock contention -abl sleep 1
   contended  total wait  max wait  avg wait           address  symbol

           1    36.28 us  36.28 us  36.28 us  ffff92615d6448b8
           9    10.91 us   1.84 us   1.21 us  ffffffffbaed50c0  rcu_state
           1    10.49 us  10.49 us  10.49 us  ffff9262ac4f0c80
           8     4.68 us   1.67 us    585 ns  ffffffffbae07a40  jiffies_lock
           3     3.03 us   1.45 us   1.01 us  ffff9262277861e0
           1      924 ns    924 ns    924 ns  ffff926095ba9d20
           1      436 ns    436 ns    436 ns  ffff9260bfda4f60

perf record:

- Add remaining branch filters: "no_cycles", "no_flags" & "hw_index", to be
  used with hardware such as Intel's LBR that allows things like stitching
  stacks of two samples to overcome the limits of the number of LBR registers.

Symbol resolution:

- Handle .debug files created with 'objcopy --only-keep-debug', where program
  headers are zeroed and thus can't be used for adjustments, use the info in
  the runtime_ss (runtime ELF) instead.

perf trace:

- Add BPF based augmenter for the 'perf_event_open's 'struct perf_event_attr' argument.

- Add BPF based augmenter for the 'clock_gettime's 'struct timespec' argument.

- In both cases the syscall tracepoint has just the pointer value, we
  need to hook a BPF program to collect the pointer contents, and then,
  in userspace, pretty print it in 'perf trace'.

perf list:

- Introduce JSON output of events.

- Streamline how the expression specifying what events should be shown is handled,
  fixing several corner cases, such as the metric filter that is specified as a glob
  but was using strstr().

perf probe:

- Fix to avoid crashing if DW_AT_decl_file is NULL, coping with clang generating
  DWARF5 like that.

- Use dwarf_attr_integrate() as generic DWARF attr accessor as it supersedes dwarf_attr(),
  supporting abstact origin DIEs.

perf inject:

- Set PERF_RECORD_MISC_BUILD_ID_SIZE in the PERF_RECORD_HEADER_BUILD_ID so that
  perf.data readers can get the real build-id size and avoid trailing zeros.

perf data:

- Add tracepoint fields when converting a perf.data file to JSON.

arm64:

- Fix mksyscalltbl, don't lose syscalls due to sort -nu.

- Add Arm Neoverse V2 PMU events.

riscv:

- Add riscv sbi firmware std event files.

- Add Sifive U74 vendor events (JSON) file.

- Add some more events and metrics for Alderlake/Alderlake-N.

Documentation:

- Add data documentation for the PMU structs in the C source code.

Miscellaneous:

- Periodic sanitization of headers, adding missing includes, removing needless ones,
  creating new ones, etc.

- Use sig_atomic_t for signal handlers to avoid undefined behaviour in all perf
  tools.

- Fixes for libbpf 1.0+ compatibility (maps, etc) on 'perf trace' BPF examples.

- Remove some old perf bpf examples, leave the best ones that demonstrate how
  to associate BPF functions to points in the kernel.

- Make quiet mode consistent between tools.

- Use dedicated non-atomic clear/set bit helpers.

- Use "grep -E" instead of "egrep" as recommended by warning emitted by GNU
  grep since at least version 3.8.

- Complete list of supported subcommands in the 'perf daemon' help message.

- Update John Garry's email address for arm64 perf tooling on the MAINTAINERS file,
  he moved from Huawei to Oracle.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (4):
      perf scripts python: intel-pt-events.py: Add ability interleave output
      perf intel-pt: Start turning intel-pt-pkt-decoder-test.c into a suite of intel-pt subtests
      perf intel-pt: Redefine test_suite to allow for adding more subtests
      perf intel-pt: Add hybrid CPU compatibility test

Ajay Kaher (1):
      perf symbol: correction while adjusting symbol

Alexander Gordeev (1):
      libperf: Fix install_pkgconfig target

Anshuman Khandual (1):
      perf record: Add remaining branch filters: "no_cycles", "no_flags" & "hw_index"

Arnaldo Carvalho de Melo (28):
      perf unwind arm64: Remove needless event.h & thread.h includes
      perf arch x86: Add missing stdlib.h to get free() prototype
      perf scripting python: Add missing util/perf_regs.h include to get perf_reg_name() prototype
      perf event: Drop perf_regs.h include, not needed anymore
      perf bpf: No need to include compiler.h when HAVE_LIBBPF_SUPPORT is true
      perf bpf: No need to include headers just use forward declarations
      perf branch: Remove some needless headers, add a needed one
      perf tools: Move 'struct perf_sample' to a separate header file to disentangle headers
      perf kwork: Remove includes not needed in kwork.h
      perf machine: Move machine__resolve() from event.h
      perf symbol: Move addr_location__put() from event.h
      perf thread: Move thread__resolve() from event.h
      perf tests: Add missing event.h include
      perf mmap: Remove several unneeded includes from util/mmap.h
      perf evlist: Add missing util/event.h header
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf examples bpf: Remove augmented_syscalls.c, the raw_syscalls one should be used instead
      perf bpf: Rename perf_include_dir to libbpf_include_dir
      perf trace: Add BPF augmenter to perf_event_open()'s 'struct perf_event_attr' arg
      perf trace: Add augmenter for clock_gettime's rqtp timespec arg
      Merge remote-tracking branch 'torvalds/master' into perf/core
      libperf: Remove recursive perf/cpumap.h include from perf/cpumap.h
      libperf: Add missing 'struct perf_cpu_map' forward declaration to perf/cpumap.h
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      machine: Adopt is_lock_function() from builtin-lock.c
      perf tools: Check if libtracevent has TEP_FIELD_IS_RELATIVE
      Merge remote-tracking branch 'torvalds/master' into perf/core

Athira Rajeev (2):
      perf stat: Fix printing field separator in CSV metrics output
      perf test: Update event group check for support of uncore event

Dmitrii Dolgov (1):
      perf data: Add tracepoint fields when converting to JSON

Hagen Paul Pfeifer (1):
      perf script: Introduce task analyzer python script

Hans-Peter Nilsson (1):
      perf arm64: Fix mksyscalltbl, don't lose syscalls due to sort -nu

Ian Rogers (61):
      perf test: Parse events workaround for dash/minus
      perf build: Update to C standard to gnu11
      perf record: Use sig_atomic_t for signal handlers
      perf daemon: Use sig_atomic_t to avoid UB
      perf ftrace: Use sig_atomic_t to avoid UB
      perf session: Change type to avoid undefined behaviour in a signal handler
      perf stat: Use sig_atomic_t to avoid undefined behaviour in a signal handler
      perf top: Use sig_atomic_t to avoid undefined behaviour in a signal handler
      perf trace: Use sig_atomic_t to avoid undefined behaviour in a signal handler
      perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility
      perf trace: hello fix libbpf 1.0+ compatibility
      perf trace: empty fix libbpf 1.0+ compatibility
      perf trace: 5sec fix libbpf 1.0+ compatibility
      perf bpf: Remove now unused BPF headers
      perf pmu: Remove mostly unused 'struct perf_pmu' 'is_hybrid' member
      perf pmu: Add data structure documentation
      tools lib api fs tracing_path: Add scandir alphasort
      perf tracepoint: Sort events in iterator
      perf list: Generalize limiting to a PMU name
      perf list: Simplify cache event printing
      perf list: Simplify symbol event printing
      perf pmu: Restructure print_pmu_events() to avoid memory allocations
      tools lib api: Add install target
      tools lib subcmd: Add install target
      perf build: Install libsubcmd locally when building
      perf build: Install libapi locally when building
      perf build: Install libperf locally when building
      perf build: Install libtraceevent locally when building
      tools lib api: Add missing install headers
      tools lib perf: Add missing install headers
      tool lib symbol: Add Makefile/Build
      perf build: Install libsymbol locally when building
      perf expr: Tidy hashmap dependency
      perf thread_map: Reduce exposure of libperf internal API
      perf cpumap: Tidy libperf includes
      perf build: Use tools/lib headers from install path
      tools lib api: Clean up install_headers
      tools lib bpf: Avoid install_headers make warning
      tools lib symbol: Clean up build output
      tools lib perf: Make install_headers clearer
      tools lib subcmd: Make install_headers clearer
      tools lib traceevent: Make install_headers clearer
      perf build: Fix LIBTRACEEVENT_DYNAMIC
      perf list: Reorganize to use callbacks to allow honouring command line options
      perf list: Add JSON output option
      perf list: Support newlines in wordwrap
      perf list: JSON escape encoding improvements
      perf list: List callback support for libpfm
      perf stat: Check existence of os->prefix, fixing a segfault
      tools lib api: Add dependency test to install_headers
      tools lib perf: Add dependency test to install_headers
      tools lib subcmd: Add dependency test to install_headers
      tools lib symbol: Add dependency test to install_headers
      perf util: Make header guard consistent with tool
      perf util: Add host_is_bigendian to util.h
      perf build: Fixes for LIBTRACEEVENT_DYNAMIC
      perf jevents: Parse metrics during conversion
      perf build: Use libtraceevent from the system
      tools lib traceevent: Remove libtraceevent
      perf build: Fix python/perf.so library's name
      perf evlist: Remove group option.

James Clark (14):
      perf tools: Fix "kernel lock contention analysis" test by not printing warnings in quiet mode
      perf tools: Make quiet mode consistent between tools
      perf vendor events: Add Arm Neoverse V2 PMU events
      perf branch: Fix interpretation of branch records
      perf stat: Fix invalid output handle
      perf cs-etm: Print unknown header version as an error
      perf cs-etm: Remove unused stub methods
      perf cs-etm: Tidy up auxtrace info header printing
      perf cs-etm: Cleanup cs_etm__process_auxtrace_info()
      perf cs-etm: Print auxtrace info even if OpenCSD isn't linked
      perf test: Add ability to test exit code for attr tests
      perf test: Add mechanism for skipping attr tests on auxiliary vector values
      perf test: Add mechanism for skipping attr tests on kernel versions
      perf test arm64: Add attr tests for new VG register

John Garry (1):
      MAINTAINERS: Update John Garry's email address for arm64 perf tooling

Kang Minchul (1):
      perf print-events: Remove redundant comparison with zero

Khem Raj (1):
      perf python: Account for multiple words in CC

Leo Yan (5):
      perf trace: Use macro RAW_SYSCALL_ARGS_NUM to replace number
      perf trace: Return error if a system call doesn't exist
      perf trace: Handle failure when trace point folder is missed
      perf augmented_raw_syscalls: Remove unused variable 'syscall'
      perf trace: Remove unused bpf map 'syscalls'

Masami Hiramatsu (Google) (4):
      perf probe: Fix to avoid crashing if DW_AT_decl_file is NULL
      perf probe: Use dwarf_attr_integrate as generic DWARF attr accessor
      perf probe: Fix to get declared file name from clang DWARF5
      perf probe: Fix to get the DW_AT_decl_file and DW_AT_call_file as unsinged data

Michael Petlan (1):
      perf test: Fix record test on KVM guests

Namhyung Kim (100):
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
      perf stat: Split process_counters() to share it with process_stat_round_event()
      perf stat: Add perf_stat_merge_counters()
      perf stat: Add perf_stat_process_percore()
      perf stat: Add perf_stat_process_shadow_stats()
      perf stat: Display event stats using aggr counts
      perf stat: Display percore events properly
      perf stat: Remove unused perf_counts.aggr field
      perf test: Do not use instructions:u explicitly
      perf test: Fix shellcheck issues in the record test
      perf test: Use a test program in 'perf record' tests
      perf test: Wait for a new thread when testing --per-thread record
      perf test: Add system-wide mode in 'perf record' tests
      perf test: Add target workload test in 'perf record' tests
      perf test: Test record with --threads option
      perf test: Do not set TEST_SKIP for record subtests
      perf lock contention: Fix memory sanitizer issue
      perf lock contention: Check --max-stack option
      perf lock contention: Avoid variable length arrays
      perf lock contention: Increase default stack skip to 4
      perf lock: Allow concurrent record and report
      perf stat: Increase metric length to align outputs
      perf stat: Clear screen only if output file is a tty
      perf stat: Move common code in print_metric_headers()
      perf stat: Fix --metric-only --json output
      perf stat: Do not indent headers for JSON
      perf stat: Add header for interval in JSON output
      perf stat: Fix condition in print_interval()
      perf stat: Consolidate condition to print metrics
      perf stat: Fix summary output in CSV with --metric-only
      perf stat: Add missing separator in the CSV header
      perf stat: Clear screen only if output file is a tty
      perf stat: Split print_running() function
      perf stat: Split print_noise_pct() function
      perf stat: Split print_cgroup() function
      perf stat: Split aggr_printout() function
      perf stat: Factor out print_counter_value() function
      perf stat: Handle bad events in abs_printout()
      perf stat: Add before_metric argument
      perf stat: Align cgroup names
      perf stat: Split print_metric_headers() function
      perf stat: Factor out prepare_interval()
      perf stat: Cleanup interval print alignment
      perf stat: Remove impossible condition
      perf stat: Rework header display
      perf stat: Move condition to print_footer()
      perf stat: Factor out prefix display
      perf stat: Factor out print_metric_{begin,end}()
      perf stat: Support --for-each-cgroup and --metric-only
      perf stat: Add print_aggr_cgroup() for --for-each-cgroup and --topdown
      perf test: Add -w/--workload option
      perf test: Replace pipe test workload with noploop
      perf test: Add 'thloop' test workload
      perf test: Replace record test workload with thloop
      perf test: Add 'leafloop' test workload
      perf test: Replace arm callgraph fp test workload with leafloop
      perf test: Add 'sqrtloop' test workload
      perf test: Replace arm spe fork test workload with sqrtloop
      perf test: Add 'brstack' test workload
      perf test: Replace brstack test workload
      perf test: Add 'datasym' test workload
      perf test: Replace data symbol test workload with datasym
      perf inject: Set PERF_RECORD_MISC_BUILD_ID_SIZE
      perf lock contention: Do not use BPF task local storage
      perf stat: Fix cgroup display in JSON output
      perf stat: Move summary prefix printing logic in CSV output
      perf stat: Do not align time prefix in CSV output
      perf stat: Use scnprintf() in prepare_interval()
      perf stat: Remove prefix argument in print_metric_headers()
      perf stat: Remove metric_only argument in print_counter_aggrdata()
      perf stat: Pass const char *prefix to display routines
      perf stat: Use 'struct outstate' in evlist__print_counters()
      perf stat: Pass 'struct outstate' to print_metric_begin()
      perf stat: Pass struct outstate to printout()
      perf stat: Do not pass runtime_stat to printout()
      perf stat: Pass through 'struct outstate'
      perf stat: Fix JSON output in metric-only mode
      perf stat: Rename "aggregate-number" to "cpu-count" in JSON
      perf stat: Tidy up JSON metric-only output when no metrics
      Revert "perf stat: Rename "aggregate-number" to "cpu-count" in JSON"
      perf stat: Fix multi-line metric output in JSON
      perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events
      perf off_cpu: Fix a typo in BTF tracepoint name, it should be 'btf_trace_sched_switch'
      perf lock contention: Add lock_data.h for common data
      perf lock contention: Implement -t/--threads option for BPF
      perf lock contention: Add -l/--lock-addr option
      perf test: Update perf lock contention test
      perf stat: Do not delay the workload with --delay

Naveen N. Rao (1):
      perf test: Skip watchpoint tests if no watchpoints available

Nikita Shubin (3):
      perf tools riscv: Add support for get_cpuid_str function
      perf arch events: riscv sbi firmware std event files
      perf vendor events riscv: add Sifive U74 JSON file

Petar Gligoric (2):
      perf script: task-analyzer add csv support
      perf test: add new task-analyzer tests

Ravi Bangoria (2):
      perf tool: Move pmus list variable to a new file
      perf test: Add event group test for events in multiple PMUs

Sean Christopherson (1):
      perf tools: Use dedicated non-atomic clear/set bit helpers

Tiezhu Yang (1):
      perf tools: Use "grep -E" instead of "egrep"

Yang Jihong (2):
      perf daemon: Complete list of supported subcommand in help message
      perf config: Add missing newline on pr_warning() call in home_perfconfig()

Zhengjun Xing (4):
      perf vendor events intel: Add core event list for Alderlake-N
      perf vendor events intel: Add uncore event list for Alderlake-N
      perf vendor events intel: Add metrics for Alderlake-N
      perf vendor events intel: Update events and metrics for alderlake

 MAINTAINERS                                        |    2 +-
 tools/lib/api/Makefile                             |   66 +
 tools/lib/api/fs/tracing_path.c                    |   16 +
 tools/lib/api/fs/tracing_path.h                    |    1 +
 tools/lib/bpf/Makefile                             |    1 +
 tools/lib/perf/Makefile                            |   37 +-
 tools/lib/perf/include/perf/cpumap.h               |    3 +-
 tools/lib/subcmd/Makefile                          |   52 +
 tools/lib/symbol/Build                             |    1 +
 tools/lib/symbol/Makefile                          |  122 +
 tools/lib/traceevent/.gitignore                    |    4 -
 tools/lib/traceevent/Build                         |    8 -
 tools/lib/traceevent/Documentation/Makefile        |  207 -
 tools/lib/traceevent/Documentation/asciidoc.conf   |  120 -
 .../Documentation/libtraceevent-commands.txt       |  153 -
 .../Documentation/libtraceevent-cpus.txt           |   77 -
 .../Documentation/libtraceevent-endian_read.txt    |   78 -
 .../Documentation/libtraceevent-event_find.txt     |  103 -
 .../Documentation/libtraceevent-event_get.txt      |   99 -
 .../Documentation/libtraceevent-event_list.txt     |  122 -
 .../Documentation/libtraceevent-event_print.txt    |  130 -
 .../Documentation/libtraceevent-field_find.txt     |  118 -
 .../Documentation/libtraceevent-field_get_val.txt  |  122 -
 .../Documentation/libtraceevent-field_print.txt    |  126 -
 .../Documentation/libtraceevent-field_read.txt     |   81 -
 .../Documentation/libtraceevent-fields.txt         |  105 -
 .../Documentation/libtraceevent-file_endian.txt    |   91 -
 .../Documentation/libtraceevent-filter.txt         |  209 -
 .../Documentation/libtraceevent-func_apis.txt      |  183 -
 .../Documentation/libtraceevent-func_find.txt      |   88 -
 .../Documentation/libtraceevent-handle.txt         |  101 -
 .../Documentation/libtraceevent-header_page.txt    |  102 -
 .../Documentation/libtraceevent-host_endian.txt    |  104 -
 .../Documentation/libtraceevent-long_size.txt      |   78 -
 .../Documentation/libtraceevent-page_size.txt      |   82 -
 .../Documentation/libtraceevent-parse_event.txt    |   90 -
 .../Documentation/libtraceevent-parse_head.txt     |   82 -
 .../Documentation/libtraceevent-plugins.txt        |  122 -
 .../Documentation/libtraceevent-record_parse.txt   |  137 -
 .../libtraceevent-reg_event_handler.txt            |  156 -
 .../Documentation/libtraceevent-reg_print_func.txt |  155 -
 .../Documentation/libtraceevent-set_flag.txt       |  104 -
 .../Documentation/libtraceevent-strerror.txt       |   85 -
 .../Documentation/libtraceevent-tseq.txt           |  158 -
 .../lib/traceevent/Documentation/libtraceevent.txt |  192 -
 .../lib/traceevent/Documentation/manpage-1.72.xsl  |   14 -
 .../lib/traceevent/Documentation/manpage-base.xsl  |   35 -
 .../Documentation/manpage-bold-literal.xsl         |   17 -
 .../traceevent/Documentation/manpage-normal.xsl    |   13 -
 .../Documentation/manpage-suppress-sp.xsl          |   21 -
 tools/lib/traceevent/Makefile                      |  300 -
 tools/lib/traceevent/event-parse-api.c             |  333 -
 tools/lib/traceevent/event-parse-local.h           |  123 -
 tools/lib/traceevent/event-parse.c                 | 7624 --------------------
 tools/lib/traceevent/event-parse.h                 |  750 --
 tools/lib/traceevent/event-plugin.c                |  711 --
 tools/lib/traceevent/event-utils.h                 |   67 -
 tools/lib/traceevent/kbuffer-parse.c               |  809 ---
 tools/lib/traceevent/kbuffer.h                     |   68 -
 tools/lib/traceevent/libtraceevent.pc.template     |   10 -
 tools/lib/traceevent/parse-filter.c                | 2281 ------
 tools/lib/traceevent/parse-utils.c                 |   71 -
 tools/lib/traceevent/plugins/Build                 |   12 -
 tools/lib/traceevent/plugins/Makefile              |  225 -
 tools/lib/traceevent/plugins/plugin_cfg80211.c     |   43 -
 tools/lib/traceevent/plugins/plugin_function.c     |  282 -
 tools/lib/traceevent/plugins/plugin_futex.c        |  123 -
 tools/lib/traceevent/plugins/plugin_hrtimer.c      |   74 -
 tools/lib/traceevent/plugins/plugin_jbd2.c         |   61 -
 tools/lib/traceevent/plugins/plugin_kmem.c         |   80 -
 tools/lib/traceevent/plugins/plugin_kvm.c          |  527 --
 tools/lib/traceevent/plugins/plugin_mac80211.c     |   88 -
 tools/lib/traceevent/plugins/plugin_sched_switch.c |  146 -
 tools/lib/traceevent/plugins/plugin_scsi.c         |  434 --
 tools/lib/traceevent/plugins/plugin_tlb.c          |   66 -
 tools/lib/traceevent/plugins/plugin_xen.c          |  138 -
 tools/lib/traceevent/tep_strerror.c                |   53 -
 tools/lib/traceevent/trace-seq.c                   |  249 -
 tools/lib/traceevent/trace-seq.h                   |   55 -
 tools/perf/.gitignore                              |    7 +-
 tools/perf/Build                                   |   20 +-
 tools/perf/Documentation/perf-annotate.txt         |    2 +-
 tools/perf/Documentation/perf-diff.txt             |    2 +-
 tools/perf/Documentation/perf-intel-pt.txt         |   12 +-
 tools/perf/Documentation/perf-list.txt             |   10 +-
 tools/perf/Documentation/perf-lock.txt             |    6 +-
 tools/perf/Documentation/perf-probe.txt            |    2 +-
 tools/perf/Documentation/perf-record.txt           |   11 +-
 tools/perf/Documentation/perf-report.txt           |    2 +-
 tools/perf/Documentation/perf-stat.txt             |    4 +-
 tools/perf/Documentation/perf-top.txt              |    7 +-
 tools/perf/MANIFEST                                |    4 +-
 tools/perf/Makefile                                |    2 +-
 tools/perf/Makefile.config                         |   62 +-
 tools/perf/Makefile.perf                           |  170 +-
 tools/perf/arch/arm/util/unwind-libdw.c            |    2 +-
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |    2 +-
 tools/perf/arch/arm64/util/Build                   |    2 +-
 tools/perf/arch/arm64/util/machine.c               |    1 +
 tools/perf/arch/arm64/util/pmu.c                   |    1 +
 tools/perf/arch/arm64/util/unwind-libdw.c          |    2 +-
 tools/perf/arch/powerpc/util/Build                 |    2 +-
 tools/perf/arch/powerpc/util/event.c               |    1 +
 tools/perf/arch/powerpc/util/unwind-libdw.c        |    2 +-
 tools/perf/arch/riscv/util/Build                   |    1 +
 tools/perf/arch/riscv/util/header.c                |  104 +
 tools/perf/arch/s390/util/Build                    |    2 +-
 tools/perf/arch/s390/util/unwind-libdw.c           |    1 +
 tools/perf/arch/x86/include/arch-tests.h           |    1 +
 tools/perf/arch/x86/tests/Build                    |    2 +-
 tools/perf/arch/x86/tests/arch-tests.c             |   15 +-
 ...intel-pt-pkt-decoder-test.c => intel-pt-test.c} |  154 +
 tools/perf/arch/x86/tests/sample-parsing.c         |    1 +
 tools/perf/arch/x86/util/Build                     |    2 +-
 tools/perf/arch/x86/util/event.c                   |    2 +
 tools/perf/arch/x86/util/intel-pt.c                |    4 +
 tools/perf/arch/x86/util/iostat.c                  |    4 +-
 tools/perf/arch/x86/util/tsc.c                     |    1 +
 tools/perf/arch/x86/util/unwind-libdw.c            |    2 +-
 tools/perf/bench/inject-buildid.c                  |    2 +-
 tools/perf/bench/numa.c                            |    9 +-
 tools/perf/builtin-annotate.c                      |    4 +-
 tools/perf/builtin-daemon.c                        |    4 +-
 tools/perf/builtin-data.c                          |    5 +-
 tools/perf/builtin-diff.c                          |    2 +-
 tools/perf/builtin-ftrace.c                        |    4 +-
 tools/perf/builtin-inject.c                        |    8 +
 tools/perf/builtin-kmem.c                          |    1 +
 tools/perf/builtin-kvm.c                           |   12 +-
 tools/perf/builtin-kwork.c                         |    7 +
 tools/perf/builtin-list.c                          |  565 +-
 tools/perf/builtin-lock.c                          |  251 +-
 tools/perf/builtin-mem.c                           |    1 +
 tools/perf/builtin-probe.c                         |    7 +-
 tools/perf/builtin-record.c                        |   14 +-
 tools/perf/builtin-report.c                        |   11 +-
 tools/perf/builtin-script.c                        |   23 +-
 tools/perf/builtin-stat.c                          |  250 +-
 tools/perf/builtin-timechart.c                     |    1 +
 tools/perf/builtin-top.c                           |    6 +-
 tools/perf/builtin-trace.c                         |  153 +-
 tools/perf/builtin-version.c                       |    1 +
 tools/perf/examples/bpf/5sec.c                     |    8 +-
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  175 +-
 tools/perf/examples/bpf/augmented_syscalls.c       |  169 -
 tools/perf/examples/bpf/empty.c                    |   13 +-
 tools/perf/examples/bpf/etcsnoop.c                 |   76 -
 tools/perf/examples/bpf/hello.c                    |   24 +-
 tools/perf/include/bpf/bpf.h                       |   70 -
 tools/perf/include/bpf/linux/socket.h              |   24 -
 tools/perf/include/bpf/pid_filter.h                |   21 -
 tools/perf/include/bpf/stdio.h                     |   16 -
 tools/perf/include/bpf/unistd.h                    |   10 -
 tools/perf/perf.c                                  |   24 +-
 tools/perf/pmu-events/Build                        |    2 +-
 .../{neoverse-n2 => neoverse-n2-v2}/branch.json    |    0
 .../arm/{neoverse-n2 => neoverse-n2-v2}/bus.json   |    0
 .../arm/{neoverse-n2 => neoverse-n2-v2}/cache.json |    0
 .../{neoverse-n2 => neoverse-n2-v2}/exception.json |    0
 .../instruction.json                               |    0
 .../{neoverse-n2 => neoverse-n2-v2}/memory.json    |    0
 .../{neoverse-n2 => neoverse-n2-v2}/pipeline.json  |    0
 .../arm/{neoverse-n2 => neoverse-n2-v2}/spe.json   |    0
 .../arm/{neoverse-n2 => neoverse-n2-v2}/trace.json |    0
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    3 +-
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |   17 +
 .../pmu-events/arch/riscv/riscv-sbi-firmware.json  |  134 +
 .../pmu-events/arch/riscv/sifive/u74/firmware.json |   68 +
 .../arch/riscv/sifive/u74/instructions.json        |   92 +
 .../pmu-events/arch/riscv/sifive/u74/memory.json   |   32 +
 .../arch/riscv/sifive/u74/microarch.json           |   57 +
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |   73 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  | 1391 ++--
 .../arch/x86/alderlake/floating-point.json         |   91 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |  224 +-
 .../perf/pmu-events/arch/x86/alderlake/memory.json |  214 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |  132 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    | 1932 ++---
 .../arch/x86/alderlake/uncore-memory.json          |  185 +-
 .../arch/x86/alderlake/uncore-other.json           |   73 +-
 .../arch/x86/alderlake/virtual-memory.json         |  223 +-
 .../arch/x86/alderlaken/adln-metrics.json          |  583 ++
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |  330 +
 .../arch/x86/alderlaken/floating-point.json        |   18 +
 .../pmu-events/arch/x86/alderlaken/frontend.json   |   26 +
 .../pmu-events/arch/x86/alderlaken/memory.json     |   81 +
 .../perf/pmu-events/arch/x86/alderlaken/other.json |   38 +
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |  533 ++
 .../arch/x86/alderlaken/uncore-memory.json         |  175 +
 .../arch/x86/alderlaken/uncore-other.json          |   33 +
 .../arch/x86/alderlaken/virtual-memory.json        |   47 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    3 +-
 tools/perf/pmu-events/jevents.py                   |   12 +-
 tools/perf/pmu-events/metric.py                    |  502 ++
 tools/perf/pmu-events/metric_test.py               |  157 +
 tools/perf/scripts/python/Perf-Trace-Util/Build    |    2 +-
 tools/perf/scripts/python/bin/task-analyzer-record |    2 +
 tools/perf/scripts/python/bin/task-analyzer-report |    3 +
 tools/perf/scripts/python/intel-pt-events.py       |   65 +-
 tools/perf/scripts/python/task-analyzer.py         |  934 +++
 tools/perf/tests/Build                             |   15 +-
 tools/perf/tests/attr.py                           |   71 +-
 tools/perf/tests/attr/README                       |    2 -
 tools/perf/tests/attr/test-record-group            |   22 -
 .../attr/test-record-user-regs-no-sve-aarch64      |    9 +
 .../attr/test-record-user-regs-old-sve-aarch64     |   10 +
 .../tests/attr/test-record-user-regs-sve-aarch64   |   14 +
 tools/perf/tests/attr/test-stat-group              |   17 -
 tools/perf/tests/builtin-test.c                    |   36 +
 tools/perf/tests/code-reading.c                    |    4 +-
 tools/perf/tests/cpumap.c                          |    2 +-
 tools/perf/tests/dlfilter-test.c                   |    1 +
 tools/perf/tests/event_groups.c                    |  139 +
 tools/perf/tests/expr.c                            |    1 +
 tools/perf/tests/make                              |    2 +-
 tools/perf/tests/mmap-basic.c                      |    2 +
 tools/perf/tests/openat-syscall-tp-fields.c        |    1 +
 tools/perf/tests/openat-syscall.c                  |    1 +
 tools/perf/tests/parse-events.c                    |   36 +-
 tools/perf/tests/parse-metric.c                    |    2 +-
 tools/perf/tests/parse-no-sample-id-all.c          |    1 +
 tools/perf/tests/perf-record.c                     |    2 +
 tools/perf/tests/perf-time-to-tsc.c                |    1 +
 tools/perf/tests/pmu-events.c                      |    3 +-
 tools/perf/tests/sample-parsing.c                  |    4 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |    4 +-
 tools/perf/tests/shell/lock_contention.sh          |   63 +-
 tools/perf/tests/shell/pipe_test.sh                |   55 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |    2 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    2 +-
 tools/perf/tests/shell/record.sh                   |  129 +-
 tools/perf/tests/shell/record_offcpu.sh            |    2 +-
 tools/perf/tests/shell/stat.sh                     |   10 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |   34 +-
 tools/perf/tests/shell/test_arm_coresight.sh       |    8 +-
 tools/perf/tests/shell/test_arm_spe.sh             |    6 +-
 tools/perf/tests/shell/test_arm_spe_fork.sh        |   46 +-
 tools/perf/tests/shell/test_brstack.sh             |   68 +-
 tools/perf/tests/shell/test_data_symbol.sh         |   33 +-
 tools/perf/tests/shell/test_java_symbol.sh         |    2 +-
 tools/perf/tests/shell/test_task_analyzer.sh       |  151 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    4 +-
 tools/perf/tests/sw-clock.c                        |    1 +
 tools/perf/tests/switch-tracking.c                 |    1 +
 tools/perf/tests/tests.h                           |   28 +
 tools/perf/tests/thread-map.c                      |    1 +
 tools/perf/tests/workloads/Build                   |   13 +
 tools/perf/tests/workloads/brstack.c               |   40 +
 tools/perf/tests/workloads/datasym.c               |   24 +
 tools/perf/tests/workloads/leafloop.c              |   34 +
 tools/perf/tests/workloads/noploop.c               |   32 +
 tools/perf/tests/workloads/sqrtloop.c              |   45 +
 tools/perf/tests/workloads/thloop.c                |   53 +
 tools/perf/tests/wp.c                              |   12 +-
 tools/perf/trace/beauty/Build                      |    1 +
 tools/perf/trace/beauty/beauty.h                   |    3 +
 tools/perf/trace/beauty/fadvise.sh                 |    2 +-
 tools/perf/trace/beauty/fsmount.sh                 |    2 +-
 tools/perf/trace/beauty/fspick.sh                  |    2 +-
 tools/perf/trace/beauty/kcmp_type.sh               |    2 +-
 tools/perf/trace/beauty/kvm_ioctl.sh               |    4 +-
 tools/perf/trace/beauty/madvise_behavior.sh        |    2 +-
 tools/perf/trace/beauty/mmap_flags.sh              |   22 +-
 tools/perf/trace/beauty/mmap_prot.sh               |   12 +-
 tools/perf/trace/beauty/mount_flags.sh             |    4 +-
 tools/perf/trace/beauty/move_mount_flags.sh        |    2 +-
 tools/perf/trace/beauty/mremap_flags.sh            |    4 +-
 tools/perf/trace/beauty/perf_event_open.c          |   44 +
 tools/perf/trace/beauty/perf_ioctl.sh              |    2 +-
 .../perf/trace/beauty/pkey_alloc_access_rights.sh  |    2 +-
 tools/perf/trace/beauty/prctl_option.sh            |    4 +-
 tools/perf/trace/beauty/rename_flags.sh            |    4 +-
 tools/perf/trace/beauty/sockaddr.sh                |    4 +-
 tools/perf/trace/beauty/socket.sh                  |    4 +-
 tools/perf/trace/beauty/sync_file_range.sh         |    2 +-
 tools/perf/trace/beauty/timespec.c                 |   21 +
 .../trace/beauty/tracepoints/x86_irq_vectors.sh    |    4 +-
 tools/perf/trace/beauty/tracepoints/x86_msr.sh     |   12 +-
 tools/perf/trace/beauty/usbdevfs_ioctl.sh          |    4 +-
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |    4 +-
 tools/perf/trace/beauty/x86_arch_prctl.sh          |    4 +-
 tools/perf/ui/util.c                               |    5 +
 tools/perf/util/Build                              |   30 +-
 tools/perf/util/amd-sample-raw.c                   |    1 +
 .../perf/util/arm64-frame-pointer-unwind-support.h |    6 +-
 tools/perf/util/auxtrace.c                         |    1 +
 tools/perf/util/auxtrace.h                         |    2 +-
 tools/perf/util/bpf-loader.c                       |    4 -
 tools/perf/util/bpf-prologue.h                     |    6 +-
 tools/perf/util/bpf_counter.c                      |    2 +-
 tools/perf/util/bpf_kwork.c                        |    3 +
 tools/perf/util/bpf_lock_contention.c              |  114 +-
 tools/perf/util/bpf_map.h                          |    3 +-
 tools/perf/util/bpf_off_cpu.c                      |    2 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |  101 +-
 tools/perf/util/bpf_skel/lock_data.h               |   30 +
 tools/perf/util/branch.h                           |    9 +-
 tools/perf/util/config.c                           |    4 +-
 tools/perf/util/counts.c                           |    1 -
 tools/perf/util/counts.h                           |    1 -
 tools/perf/util/cpumap.c                           |   17 +-
 tools/perf/util/cpumap.h                           |   10 +-
 tools/perf/util/cs-etm-base.c                      |  174 +
 tools/perf/util/cs-etm.c                           |  208 +-
 tools/perf/util/cs-etm.h                           |   46 +-
 tools/perf/util/data-convert-bt.c                  |    8 +-
 tools/perf/util/data-convert-json.c                |   27 +
 tools/perf/util/dwarf-aux.c                        |   77 +-
 tools/perf/util/dwarf-aux.h                        |    3 +
 tools/perf/util/event.h                            |  124 +-
 tools/perf/util/evlist.c                           |   10 +-
 tools/perf/util/evlist.h                           |    6 +-
 tools/perf/util/evsel.c                            |   54 +-
 tools/perf/util/evsel.h                            |   16 +-
 tools/perf/util/evsel_fprintf.c                    |    7 +-
 tools/perf/util/expr.c                             |    1 +
 tools/perf/util/expr.h                             |    7 +-
 tools/perf/util/header.c                           |   19 +
 tools/perf/util/header.h                           |    2 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    1 +
 tools/perf/util/intel-pt.c                         |    7 +-
 tools/perf/util/iostat.c                           |    3 +-
 tools/perf/util/iostat.h                           |    4 +-
 tools/perf/util/kwork.h                            |   12 +-
 tools/perf/util/llvm-utils.c                       |    8 +-
 tools/perf/util/lock-contention.h                  |    5 +-
 tools/perf/util/machine.c                          |   40 +
 tools/perf/util/machine.h                          |    8 +
 tools/perf/util/metricgroup.c                      |  243 +-
 tools/perf/util/metricgroup.h                      |    4 +-
 tools/perf/util/mmap.h                             |    5 -
 tools/perf/util/parse-branch-options.c             |    3 +
 tools/perf/util/parse-events.c                     |   16 +
 tools/perf/util/parse-events.h                     |    1 -
 tools/perf/util/perf_regs.c                        |    2 +-
 tools/perf/util/pfm.c                              |  154 +-
 tools/perf/util/pfm.h                              |    7 +-
 tools/perf/util/pmu.c                              |  294 +-
 tools/perf/util/pmu.h                              |  128 +-
 tools/perf/util/pmus.c                             |    5 +
 tools/perf/util/pmus.h                             |    9 +
 tools/perf/util/print-events.c                     |  639 +-
 tools/perf/util/print-events.h                     |   42 +-
 tools/perf/util/probe-finder.c                     |   37 +-
 tools/perf/util/python.c                           |   26 +-
 tools/perf/util/record.c                           |    7 -
 tools/perf/util/record.h                           |    1 -
 tools/perf/util/s390-cpumsf.c                      |    1 +
 tools/perf/util/s390-sample-raw.c                  |    1 +
 tools/perf/util/sample.h                           |  117 +
 tools/perf/util/scripting-engines/Build            |    6 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    3 +
 .../util/scripting-engines/trace-event-python.c    |   12 +-
 tools/perf/util/session.c                          |    5 +-
 tools/perf/util/session.h                          |    2 +
 tools/perf/util/setup.py                           |   15 +-
 tools/perf/util/sort.c                             |   63 +-
 tools/perf/util/stat-display.c                     | 1514 ++--
 tools/perf/util/stat-shadow.c                      |    1 +
 tools/perf/util/stat.c                             |  406 +-
 tools/perf/util/stat.h                             |   41 +-
 tools/perf/util/symbol-elf.c                       |    2 +-
 tools/perf/util/symbol.h                           |    2 +
 tools/perf/util/synthetic-events.c                 |    9 +-
 tools/perf/util/thread.h                           |    3 +
 tools/perf/util/thread_map.c                       |    1 +
 tools/perf/util/thread_map.h                       |    2 -
 tools/perf/util/trace-event-info.c                 |   14 +-
 tools/perf/util/trace-event-parse.c                |    2 +
 tools/perf/util/trace-event-read.c                 |    4 +-
 tools/perf/util/trace-event-scripting.c            |    3 +-
 tools/perf/util/trace-event.c                      |    1 -
 tools/perf/util/trace-event.h                      |   13 +-
 tools/perf/util/util.h                             |   25 +-
 374 files changed, 11404 insertions(+), 26462 deletions(-)
 create mode 100644 tools/lib/symbol/Build
 create mode 100644 tools/lib/symbol/Makefile
 delete mode 100644 tools/lib/traceevent/.gitignore
 delete mode 100644 tools/lib/traceevent/Build
 delete mode 100644 tools/lib/traceevent/Documentation/Makefile
 delete mode 100644 tools/lib/traceevent/Documentation/asciidoc.conf
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-commands.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_print.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_print.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-fields.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-filter.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_find.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-handle.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-plugins.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
 delete mode 100644 tools/lib/traceevent/Documentation/libtraceevent.txt
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-1.72.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-base.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-bold-literal.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-normal.xsl
 delete mode 100644 tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl
 delete mode 100644 tools/lib/traceevent/Makefile
 delete mode 100644 tools/lib/traceevent/event-parse-api.c
 delete mode 100644 tools/lib/traceevent/event-parse-local.h
 delete mode 100644 tools/lib/traceevent/event-parse.c
 delete mode 100644 tools/lib/traceevent/event-parse.h
 delete mode 100644 tools/lib/traceevent/event-plugin.c
 delete mode 100644 tools/lib/traceevent/event-utils.h
 delete mode 100644 tools/lib/traceevent/kbuffer-parse.c
 delete mode 100644 tools/lib/traceevent/kbuffer.h
 delete mode 100644 tools/lib/traceevent/libtraceevent.pc.template
 delete mode 100644 tools/lib/traceevent/parse-filter.c
 delete mode 100644 tools/lib/traceevent/parse-utils.c
 delete mode 100644 tools/lib/traceevent/plugins/Build
 delete mode 100644 tools/lib/traceevent/plugins/Makefile
 delete mode 100644 tools/lib/traceevent/plugins/plugin_cfg80211.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_function.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_futex.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_hrtimer.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_jbd2.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_kmem.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_kvm.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_mac80211.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_sched_switch.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_scsi.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_tlb.c
 delete mode 100644 tools/lib/traceevent/plugins/plugin_xen.c
 delete mode 100644 tools/lib/traceevent/tep_strerror.c
 delete mode 100644 tools/lib/traceevent/trace-seq.c
 delete mode 100644 tools/lib/traceevent/trace-seq.h
 create mode 100644 tools/perf/arch/riscv/util/header.c
 rename tools/perf/arch/x86/tests/{intel-pt-pkt-decoder-test.c => intel-pt-test.c} (80%)
 delete mode 100644 tools/perf/examples/bpf/augmented_syscalls.c
 delete mode 100644 tools/perf/examples/bpf/etcsnoop.c
 delete mode 100644 tools/perf/include/bpf/bpf.h
 delete mode 100644 tools/perf/include/bpf/linux/socket.h
 delete mode 100644 tools/perf/include/bpf/pid_filter.h
 delete mode 100644 tools/perf/include/bpf/stdio.h
 delete mode 100644 tools/perf/include/bpf/unistd.h
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/branch.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/bus.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/cache.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/exception.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/instruction.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/memory.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/pipeline.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/spe.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{neoverse-n2 => neoverse-n2-v2}/trace.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/metric.py
 create mode 100644 tools/perf/pmu-events/metric_test.py
 create mode 100755 tools/perf/scripts/python/bin/task-analyzer-record
 create mode 100755 tools/perf/scripts/python/bin/task-analyzer-report
 create mode 100755 tools/perf/scripts/python/task-analyzer.py
 delete mode 100644 tools/perf/tests/attr/test-record-group
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-sve-aarch64
 delete mode 100644 tools/perf/tests/attr/test-stat-group
 create mode 100644 tools/perf/tests/event_groups.c
 create mode 100755 tools/perf/tests/shell/test_task_analyzer.sh
 create mode 100644 tools/perf/tests/workloads/Build
 create mode 100644 tools/perf/tests/workloads/brstack.c
 create mode 100644 tools/perf/tests/workloads/datasym.c
 create mode 100644 tools/perf/tests/workloads/leafloop.c
 create mode 100644 tools/perf/tests/workloads/noploop.c
 create mode 100644 tools/perf/tests/workloads/sqrtloop.c
 create mode 100644 tools/perf/tests/workloads/thloop.c
 create mode 100644 tools/perf/trace/beauty/timespec.c
 create mode 100644 tools/perf/util/bpf_skel/lock_data.h
 create mode 100644 tools/perf/util/cs-etm-base.c
 create mode 100644 tools/perf/util/pmus.c
 create mode 100644 tools/perf/util/pmus.h
 create mode 100644 tools/perf/util/sample.h
