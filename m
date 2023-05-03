Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703EB6F607A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjECVST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA2F6190;
        Wed,  3 May 2023 14:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23EEE63024;
        Wed,  3 May 2023 21:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6956C433EF;
        Wed,  3 May 2023 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683148690;
        bh=sw7MhQamelB9/KZ0d2gNhPbZnMNBvyqSOf0E6V/varg=;
        h=From:To:Cc:Subject:Date:From;
        b=pWwcaudwrwSvjfHS4qMUFw6gnoWK6e+gevE+riY5hxCCtwtRnVrPHude52EhaViW3
         58KjqE0/xTipVGJM9wZniEwj7HKke62dS9P9Nc1TsLd9e5NWM4413ka3bCGEGcGngB
         rOWghwS7WuMwimH+hDIAmJppYMtQpIoeO5e4SLU6wJsxCubMn0nDnr9FuVnw8PTnnu
         dxh+YZ5j+ry7SoPnrsDAT2HbB3hzBqLS6cwjhMJp/Y4IAMQvchR/6XM0a8e3ApgDoX
         y/3eIEmsgK1g1aCndsho0JzXq7hSMcSwJKWjXVWktogo/z2dbQsop/lcIKbLdnHFTT
         toeakolKVHhAQ==
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
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.4
Date:   Wed,  3 May 2023 18:18:01 -0300
Message-Id: <20230503211801.897735-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit 55a21105ecc156495446d8ae75d7d73f66baed7b:

  Merge tag 'riscv-for-linus-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-03-10 09:19:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.4-1-2023-05-03

for you to fetch changes up to 1f85d016768ff19f060f3cce014a43c761de8259:

  perf test record+probe_libc_inet_pton: Fix call chain match on x86_64 (2023-05-03 11:02:21 -0300)

----------------------------------------------------------------
perf tools changes and fixes for v6.4:

Build:

- Require libtraceevent to build, one can disable it using NO_LIBTRACEEVENT=1.

  It is required for tools like 'perf sched', 'perf kvm', 'perf trace', etc.

  libtraceevent is available in most distros so installing 'libtraceevent-devel' should
  be a one-time event to continue building perf as usual.

  Using NO_LIBTRACEEVENT=1 produces tooling that is functional and sufficient
  for lots of users not interested in those libtraceevent dependent features.

- Allow Python support in 'perf script' when libtraceevent isn't linked, as not
  all features requires it, for instance Intel PT does not use tracepoints.

- Error if the python interpreter needed for jevents to work isn't available
  and NO_JEVENTS=1 isn't set, preventing a build without support for JSON
  vendor events, which is a rare but possible condition.  The two check error
  messages:

     $(error ERROR: No python interpreter needed for jevents generation. Install python or build with NO_JEVENTS=1.)
     $(error ERROR: Python interpreter needed for jevents generation too old (older than 3.6). Install a newer python or build with NO_JEVENTS=1.)

- Make libbpf 1.0 the minimum required when building with out of tree, distro
  provided libbpf.

- Use libsdtc++'s and LLVM's libcxx's __cxa_demangle, a portable C++ demangler, add
  'perf test' entry for it.

- Make binutils libraries opt in, as distros disable building with it due to licensing,
  they were used for C++ demangling, for instance.

- Switch libpfm4 to opt-out rather than opt-in, if libpfm-devel (or equivalent) isn't installed, we'll
  just have a build warning:

    Makefile.config:1144: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev

- Add a feature test for scandirat(), that is not implemented so far in musl and uclibc,
  disabling features that need it, such as scanning for tracepoints in /sys/kernel/tracing/events.

- Build by default with BPF skels, to disable it use NO_BPF_SKEL=1 in the make
  command line.

  This make the following features to be available by default, which were
  introduced in previous kernel versions built required building with BUILD_BPF_SKEL=1:

  - perf lock contention
  - perf kwork
  - off-cpu profiling
  - Filtering events using BPF
  - 'perf stat' for counting events on BPF programs

- Features are being implemented using BPF skels, where BPF is built and linked
  with the native perf tool to then be loaded and attached to places in the
  kernel where information can be obtained to implement features that previously
  required kernel changes.

  These load and attach operations are only performed when the feature that
  uses it is requested by the user in the perf command line.

  One can look at the git history for the files in the
  tools/perf/util/bpf_skel/ directory to find out about them, in addition to the
  perf tools man pages, as of this writing the contents of this directory:

    $ cd tools/perf/util/bpf_skel/
    $ ls
    bperf_follower.bpf.c    bperf_leader.bpf.c
    bpf_prog_profiler.bpf.c func_latency.bpf.c
    kwork_trace.bpf.c       lock_contention.bpf.c
    off_cpu.bpf.c           sample_filter.bpf.c

perf BPF filters:

- New feature where BPF can be used to filter samples, for instance:

  $ sudo ./perf record -e cycles --filter 'period > 1000' true
  $ sudo ./perf script
       perf-exec 2273949 546850.708501:       5029 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
       perf-exec 2273949 546850.708508:      32409 cycles:  ffffffff826f9e25 finish_wait+0x5 ([kernel.kallsyms])
       perf-exec 2273949 546850.708526:     143369 cycles:  ffffffff82b4cdbf xas_start+0x5f ([kernel.kallsyms])
       perf-exec 2273949 546850.708600:     372650 cycles:  ffffffff8286b8f7 __pagevec_lru_add+0x117 ([kernel.kallsyms])
       perf-exec 2273949 546850.708791:     482953 cycles:  ffffffff829190de __mod_memcg_lruvec_state+0x4e ([kernel.kallsyms])
            true 2273949 546850.709036:     501985 cycles:  ffffffff828add7c tlb_gather_mmu+0x4c ([kernel.kallsyms])
            true 2273949 546850.709292:     503065 cycles:      7f2446d97c03 _dl_map_object_deps+0x973 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)

- In addition to 'period' (PERF_SAMPLE_PERIOD), the other PERF_SAMPLE_ can be
  used for filtering, and also some other sample accessible values, from
  tools/perf/Documentation/perf-record.txt:

     Essentially the BPF filter expression is:

     <term> <operator> <value> (("," | "||") <term> <operator> <value>)*

   The <term> can be one of:
     ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
     code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
     p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
     mem_dtlb, mem_blk, mem_hops

   The <operator> can be one of:
     ==, !=, >, >=, <, <=, &

   The <value> can be one of:
     <number> (for any term)
     na, load, store, pfetch, exec (for mem_op)
     l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
     na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
     remote (for mem_remote)
     na, locked (for mem_locked)
     na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
     na, by_data, by_addr (for mem_blk)
     hops0, hops1, hops2, hops3 (for mem_hops)

perf lock contention:

- Show lock type with address.

- Track and show mmap_lock, siglock and per-cpu rq_lock with address. This is
  done for mmap_lock by following the current->mm pointer:

  $ sudo ./perf lock con -abl -- sleep 10
   contended   total wait     max wait     avg wait            address   symbol
   ...
       16344    312.30 ms      2.22 ms     19.11 us   ffff8cc702595640
       17686    310.08 ms      1.49 ms     17.53 us   ffff8cc7025952c0
           3     84.14 ms     45.79 ms     28.05 ms   ffff8cc78114c478   mmap_lock
        3557     76.80 ms     68.75 us     21.59 us   ffff8cc77ca3af58
           1     68.27 ms     68.27 ms     68.27 ms   ffff8cda745dfd70
           9     54.53 ms      7.96 ms      6.06 ms   ffff8cc7642a48b8   mmap_lock
       14629     44.01 ms     60.00 us      3.01 us   ffff8cc7625f9ca0
        3481     42.63 ms    140.71 us     12.24 us   ffffffff937906ac   vmap_area_lock
       16194     38.73 ms     42.15 us      2.39 us   ffff8cd397cbc560
          11     38.44 ms     10.39 ms      3.49 ms   ffff8ccd6d12fbb8   mmap_lock
           1      5.43 ms      5.43 ms      5.43 ms   ffff8cd70018f0d8
        1674      5.38 ms    422.93 us      3.21 us   ffffffff92e06080   tasklist_lock
         581      4.51 ms    130.68 us      7.75 us   ffff8cc9b1259058
           5      3.52 ms      1.27 ms    703.23 us   ffff8cc754510070
         112      3.47 ms     56.47 us     31.02 us   ffff8ccee38b3120
         381      3.31 ms     73.44 us      8.69 us   ffffffff93790690   purge_vmap_area_lock
         255      3.19 ms     36.35 us     12.49 us   ffff8d053ce30c80

- Update default map size to 16384.

- Allocate single letter option -M for --map-nr-entries, as it is proving being
  frequently used.

- Fix struct rq lock access for older kernels with BPF's CO-RE (Compile once,
  run everywhere).

- Fix problems found with MSAn.

perf report/top:

- Add inline information when using --call-graph=fp or lbr, as was already done
  to the --call-graph=dwarf callchain mode.

- Improve the 'srcfile' sort key performance by really using an optimization
  introduced in 6.2 for the 'srcline' sort key that avoids calling addr2line for
  comparision with each sample.

perf sched:

- Make 'perf sched latency/map/replay' to use "sched:sched_waking" instead of
  "sched:sched_waking", consistent with 'perf record' since d566a9c2d482 ("perf
  sched: Prefer sched_waking event when it exists").

perf ftrace:

- Make system wide the default target for latency subcommand, run the following
  command then generate some network traffic and press control+C:

  # perf ftrace latency -T __kfree_skb
^C#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |         27 | #############                                  |
     1 - 2    us |         22 | ###########                                    |
     2 - 4    us |          8 | ####                                           |
     4 - 8    us |          5 | ##                                             |
     8 - 16   us |         24 | ############                                   |
    16 - 32   us |          2 | #                                              |
    32 - 64   us |          1 |                                                |
    64 - 128  us |          0 |                                                |
   128 - 256  us |          0 |                                                |
   256 - 512  us |          0 |                                                |
   512 - 1024 us |          0 |                                                |
     1 - 2    ms |          0 |                                                |
     2 - 4    ms |          0 |                                                |
     4 - 8    ms |          0 |                                                |
     8 - 16   ms |          0 |                                                |
    16 - 32   ms |          0 |                                                |
    32 - 64   ms |          0 |                                                |
    64 - 128  ms |          0 |                                                |
   128 - 256  ms |          0 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |
  #

perf top:

- Add --branch-history (LBR: Last Branch Record) option, just like already
  available for 'perf record'.

- Fix segfault in thread__comm_len() where thread->comm was being used outside
  thread->comm_lock.

perf annotate:

- Allow configuring objdump and addr2line in ~/.perfconfig., so that you can
  use alternative binaries, such as llvm's.

perf kvm:

- Add TUI mode for 'perf kvm stat report'.

Reference counting:

- Add reference count checking infrastructure to check for use after free, done
  to the 'cpumap', 'namespaces', 'maps' and 'map' structs, more to come. To
  build with it use -DREFCNT_CHECKING=1 in the make command line to build
  tools/perf.

  Documented at: https://perf.wiki.kernel.org/index.php/Reference_Count_Checking

- This caught, for instance, fix, present in this series:

    - Fix maps use after put in 'perf test "Share thread maps"':

    'maps' is copied from leader, but the leader is put on line 79 and then
    'maps' is used to read the reference count below - so a use after put, with the
    put of maps happening within thread__put. Fix by reversing the order of puts so
    that the leader is put last.

- Also several fixes were made to places where reference counts were not being held.

- Make this one of the tests in 'make -C tools/perf build-test' to regularly
  build test it and to make sure no direct access to the reference counted
  structs are made, doing that via accessors to check the validity of the struct
  pointer.

ARM64:

- Fix 'perf report' segfault when filtering coresight traces by sparse lists of CPUs.

- Add support for 'simd' as a sort field for 'perf report', to show ARM's NEON SIMD's
  predicate flags: "partial" and "empty".

Vendor events (JSON):

arm64:

- Add N1 metrics.

Intel:

- Add graniterapids, grandridge and sierraforrest events.

- Refresh events for: alderlake, aldernaken, broadwell, broadwellde,
  broadwellx, cascadelakx, haswell, haswellx, icelake, icelakex, jaketown,
  meteorlake, knightslanding, sandybridge, sapphirerapids, silvermont, skylake,
  tigerlake and westmereep-dp

- Refresh metrics for alderlake-n, broadwell, broadwellde, broadwellx, haswell,
  haswellx, icelakex, ivybridge, ivytown and skylakex.

perf stat:

- Implement --topdown using JSON metrics.

- Add TopdownL1 JSON metric as a default if present, but disable it for
  now for some Intel hybrid architectures, a series of patches
  addressing this is being reviewed and will be submitted for v6.5.

- Use metrics for --smi-cost.

- Update topdown documentation.

Vendor events (JSON) infrastructure:

- Add support for computing and printing metric threshold values. For instance,
  here is one found in the tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
  file:

    {
        "BriefDescription": "Percentage of cycles spent in System Management Interrupts.",
        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0 else 0)",
        "MetricGroup": "smi",
        "MetricName": "smi_cycles",
        "MetricThreshold": "smi_cycles > 0.1",
        "ScaleUnit": "100%"
    },

- Test parsing metric thresholds with the fake PMU in 'perf test pmu-events'.

- Support for printing metric thresholds in 'perf list'.

- Add --metric-no-threshold option to 'perf stat'.

- Add rand (reverse and) and has_pmem (optane memory) support to metrics.

- Sort list of input files to avoid depending on the order from readdir()
  helping in obtaining reproducible builds.

S/390:

- Add common metrics: - CPI (cycles per instruction), prbstate (ratio of
  instructions executed in problem state compared to total number of
  instructions), l1mp (Level one instruction and data cache misses per 100
  instructions).

- Add cache metrics for z13, z14, z15 and z16.

- Add metric for TLB and cache.

ARM:

- Add raw decoding for SPE (Statistical Profiling Extension) v1.3 MTE (Memory
  Tagging Extension) and MOPS (Memory Operations) load/store.

Hardware tracing:

Intel PT:

- Add event type names UINTR (User interrupt delivered) and UIRET (Exiting from
  user interrupt routine), documented in table 32-50 "CFE Packet Type and Vector
  Fields Details" in the Intel Processor Trace chapter of The Intel SDM
  Volume 3 version 078.

- Add support for new branch instructions ERETS and ERETU.

- Fix CYC timestamps after standalone CBR

ARM CoreSight:

- Allow user to override timestamp and contextid settings.

- Fix segfault in dso lookup.

- Fix timeless decode mode detection.

- Add separate decode paths for timeless and per-thread modes.

auxtrace:

- Fix address filter entire kernel size.

Miscellaneous:

- Fix use-after-free and unaligned bugs in the PLT handling routines.

- Use zfree() to reduce chances of use after free.

- Add missing 0x prefix for addresses printed in hexadecimal in 'perf probe'.

- Suppress massive unsupported target platform errors in the unwind code.

- Fix return incorrect build_id size in elf_read_build_id().

- Fix 'perf scripts intel-pt-events.py' IPC output for Python 2 .

- Add missing new parameter in kfree_skb tracepoint to the python scripts using it.

- Add 'perf bench syscall fork' benchmark.

- Add support for printing PERF_MEM_LVLNUM_UNC (Uncached access) in 'perf mem'.

- Fix wrong size expectation for perf test 'Setup struct perf_event_attr' caused by
  the patch adding perf_event_attr::config3.

- Fix some spelling mistakes.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (10):
      perf script: Fix Python support when no libtraceevent
      perf intel-pt: Add event type names UINTR and UIRET
      perf intel-pt: Add support for new branch instructions ERETS and ERETU
      perf symbols: Fix use-after-free in get_plt_got_name()
      perf symbols: Fix unaligned access in get_x86_64_plt_disp()
      perf tools: Avoid warning in do_realloc_array_as_needed()
      perf top: Add --branch-history option
      perf symbol: Remove unused branch_callstack
      perf auxtrace: Fix address filter entire kernel size
      perf intel-pt: Fix CYC timestamps after standalone CBR

Alexander Pantyukhin (1):
      perf scripts python intel-pt-events: Delete unused 'event_attr variable

Andreas Herrmann (1):
      perf bench numa: Fix type of loop iterator in do_work, it should be 'long'

Arnaldo Carvalho de Melo (41):
      Merge remote-tracking branch 'acme/perf-tools' into perf-tools-next
      perf tools bpf: Add vmlinux.h to .gitignore
      tools build: Add a feature test for scandirat(), that is not implemented so far in musl and uclibc
      perf inject: Use zfree() to reduce chances of use after free
      perf daemon: Use zfree() to reduce chances of use after free
      perf trace: Use zfree() to reduce chances of use after free
      perf c2c: Use zfree() to reduce chances of use after free
      perf list: Use zfree() to reduce chances of use after free
      perf symbol: Use zfree() to reduce chances of use after free
      perf x86 iostat: Use zfree() to reduce chances of use after free
      perf env: Use zfree() to reduce chances of use after free
      perf pmu: Use zfree() to reduce chances of use after free
      perf evsel: Use zfree() to reduce chances of use after free
      perf expr: Use zfree() to reduce chances of use after free
      perf parse-events: Use zfree() to reduce chances of use after free
      perf annotate: Use zfree() to reduce chances of use after free
      perf evlist: Use zfree() to reduce chances of use after free
      perf genelf: Use zfree() to reduce chances of use after free
      perf bench inject-buildid: Use zfree() to reduce chances of use after free
      perf tests api-io: Use zfree() to reduce chances of use after free
      perf arm-spe: Use zfree() to reduce chances of use after free
      perf metricgroups: Use zfree() to reduce chances of use after free
      perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents
      perf map: Add map__refcnt() accessor to use in the maps test
      libperf: Add a perf_cpu_map__set_nr() available as an internal function for tools/perf to use
      perf pmu: Use perf_cpu_map__set_nr() in perf_pmu__cpus_match() to allow for refcnt checking
      perf test: Simplify for_each_test() to avoid tripping on -Werror=array-bounds
      libperf: Add perf_cpu_map__refcnt() interanl accessor to use in the maps test
      perf cpumap: Remove initializations done in perf_cpu_map__alloc()
      perf dso: Add dso__filename_with_chroot() to reduce number of accesses to dso->nsinfo members
      perf namespaces: Use the need_setns() accessors instead of accessing ->need_setns directly
      perf namespaces: Introduce nsinfo__refcnt() accessor to avoid accessing ->refcnt directly
      perf namespaces: Introduce nsinfo__mntns_path() accessor to avoid accessing ->mntns_path directly
      perf dso: Fix use before NULL check introduced by map__dso() introduction
      perf maps: Add maps__refcnt() accessor to allow checking maps pointer
      perf maps: Use maps__nr_maps() instead of open coded maps->nr_maps
      perf map: Add missing conversions to map__refcnt()
      perf map: Add set_ methods for map->{start,end,pgoff,pgoff,reloc,erange_warned,dso,map_ip,unmap_ip,priv}
      perf build: Test the refcnt check build
      perf probe: Add missing 0x prefix for addresses printed in hexadecimal
      perf evsel: Introduce evsel__name_is() method to check if the evsel name is equal to a given string

Artem Savkov (1):
      perf report: Append inlines to non-DWARF callchains

Bernhard M. Wiedemann (1):
      perf jevents: Sort list of input files

Changbin Du (4):
      perf record: Reuse target::initial_delay
      perf ftrace: Reuse target::initial_delay
      perf script: Print raw ip instead of binary offset for callchain
      perf unwind: Suppress massive unsupported target platform errors

Chunxin Zang (1):
      perf sched: Fix sched latency analysis incorrection when using 'sched:sched_wakeup'

Colin Ian King (1):
      perf script task-analyzer: Fix spelling mistake "miliseconds" -> "milliseconds"

Ganapatrao Kulkarni (1):
      perf cs-etm: Add fix for coresight trace for any range of CPUs

German Gomez (4):
      perf event: Add 'simd_flags' field to 'struct perf_sample'
      perf arm-spe: Refactor arm-spe to support operation packet type
      perf arm-spe: Add SVE flags to the SPE samples
      perf report: Add 'simd' sort field

Hangliang Lai (1):
      perf top: Expand the range of multithreaded phase

Ian Rogers (188):
      perf tools: Ensure evsel name is initialized
      perf metrics: Improve variable names
      perf pmu-events: Remove aggr_mode from pmu_event
      perf pmu-events: Change aggr_mode to be an enum
      perf pmu-events: Change deprecated to be a bool
      perf pmu-events: Change perpkg to be a bool
      perf expr: Make the online topology accessible globally
      perf pmu-events: Make the metric_constraint an enum
      perf pmu-events: Don't '\0' terminate enum values
      perf vendor events intel: Refresh alderlake events
      perf vendor events intel: Refresh alderlake-n metrics
      perf vendor events intel: Refresh broadwell metrics
      perf vendor events intel: Refresh broadwellde metrics
      perf vendor events intel: Refresh broadwellx metrics
      perf vendor events intel: Refresh cascadelakex events
      perf vendor events intel: Add graniterapids events
      perf vendor events intel: Refresh haswell metrics
      perf vendor events intel: Refresh haswellx metrics
      perf vendor events intel: Refresh icelake events
      perf vendor events intel: Refresh icelakex metrics
      perf vendor events intel: Refresh ivybridge metrics
      perf vendor events intel: Refresh ivytown metrics
      perf vendor events intel: Refresh jaketown events
      perf vendor events intel: Refresh knightslanding events
      perf vendor events intel: Refresh sandybridge events
      perf vendor events intel: Refresh sapphirerapids events
      perf vendor events intel: Refresh silvermont events
      perf vendor events intel: Refresh skylake events
      perf vendor events intel: Refresh skylakex metrics
      perf vendor events intel: Refresh tigerlake events
      perf vendor events intel: Refresh westmereep-dp events
      perf jevents: Add rand support to metrics
      perf jevent: Parse metric thresholds
      perf pmu-events: Test parsing metric thresholds with the fake PMU
      perf list: Support for printing metric thresholds
      perf metric: Compute and print threshold values
      perf expr: More explicit NAN handling
      perf metric: Add --metric-no-threshold option
      perf stat: Add TopdownL1 metric as a default if present
      perf stat: Implement --topdown using json metrics
      perf stat: Remove topdown event special handling
      perf doc: Refresh topdown documentation
      perf stat: Remove hard coded transaction events
      perf stat: Use metrics for --smi-cost
      perf stat: Remove perf_stat_evsel_id
      perf stat: Move enums from header
      perf stat: Hide runtime_stat
      perf stat: Add cpu_aggr_map for loop
      perf metric: Directly use counts rather than saved_value
      perf stat: Use counts rather than saved_value
      perf stat: Remove saved_value/runtime_stat
      perf vendor events intel: Update alderlake to v1.19
      perf vendor events intel: Update alderlaken to v1.19
      perf vendor events intel: Update icelakex to v1.19
      libperf evlist: Avoid a use of evsel idx
      perf stat: Don't remove all grouped events when CPU maps disagree
      perf pmu: Earlier PMU auxtrace initialization
      perf stat: Modify the group test
      perf evsel: Allow const evsel for certain accesses
      perf evsel: Add function to compute group PMU name
      perf parse-events: Pass ownership of the group name
      perf parse-events: Sort and group parsed events
      perf evsel: Remove use_uncore_alias
      perf evlist: Remove nr_groups
      perf parse-events: Warn when events are regrouped
      perf lock contention: Fix compiler builtin detection
      tools build: Pass libbpf feature only if libbpf 1.0+
      perf build: Remove libbpf pre-1.0 feature tests
      perf bpf: Remove pre libbpf 1.0 conditional logic
      perf build: Support python/perf.so testing
      perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL
      perf build: Remove unused HAVE_GLIBC_SUPPORT
      perf util: Remove weak sched_getcpu
      perf build: Error if jevents won't work and NO_JEVENTS=1 isn't set
      perf build: Make binutil libraries opt in
      tools build: Add feature test for abi::__cxa_demangle
      perf symbol: Add abi::__cxa_demangle C++ demangling support
      perf build: Switch libpfm4 to opt-out rather than opt-in
      perf build: If libtraceevent isn't present error the build
      perf build: Remove redundant NO_NEWT build option
      perf build: Error if no libelf and NO_LIBELF isn't set
      perf test: Fix "PMU event table sanity" for NO_JEVENTS=1
      perf vendor events intel: Update graniterapids events
      perf vendor events intel: Update meteorlake events
      perf vendor events intel: Update skylake events
      perf symbol: Avoid memory leak from abi::__cxa_demangle
      perf bpf_counter: Use public cpumap accessors
      perf tests: Add common error route for code-reading
      perf test: Fix memory leak in symbols
      perf symbol: Sort names under write lock
      perf build: Add warning for when vmlinux.h generation fails
      perf vendor events intel: Broadwell v27 events
      perf vendor events intel: Broadwellde v9 events
      perf vendor events intel: Broadwellx v20 events
      perf vendor events intel: Haswell v33 events
      perf vendor events intel: Haswellx v27 events
      perf vendor events intel: Jaketown v23 events
      perf vendor events intel: Sandybridge v19 events
      perf metrics: Add has_pmem literal
      perf vendor events intel: Update metrics to detect pmem at runtime
      perf annotate: Delete session for debug builds
      perf report: Additional config warnings
      perf annotate: Add init/exit to annotation_options remove default
      perf annotate: Own objdump_path and disassembler_style strings
      perf annotate: Allow objdump to be set in perfconfig
      perf symbol: Add command line support for addr2line path
      perf vendor events: Update Alderlake for E-Core TMA v2.3
      perf bench: Avoid NDEBUG warning
      perf block-range: Move debug code behind ifndef NDEBUG
      perf build: Conditionally define NDEBUG
      perf vendor events intel: Update ivybridge and ivytown
      tools api: Add io__getline
      perf srcline: Simplify addr2line subprocess
      perf srcline: Support for llvm-addr2line
      perf srcline: Avoid addr2line SIGPIPEs
      perf build: Allow C++ demangle without libelf
      perf jit: Fix a few memory leaks
      perf map: Move map list node into symbol
      perf maps: Remove rb_node from struct map
      perf maps: Add functions to access maps
      perf map: Add accessor for dso
      perf map: Add accessor for start and end
      perf pmu: Make parser reentrant
      perf pmu: Fix a few potential fd leaks
      perf pmu: Fewer const casts
      perf pmu: Improve name/comments, avoid a memory allocation
      perf pmu: Sort and remove duplicates using JSON PMU name
      perf vendor events intel: Update free running alderlake events
      perf vendor events intel: Update free running icelakex events
      perf vendor events intel: Correct knightslanding memory topic
      perf vendor events intel: Update free running snowridgex events
      perf vendor events intel: Update free running tigerlake events
      perf map: Rename map_ip() and unmap_ip()
      perf map: Add helper for ->map_ip() and ->unmap_ip()
      perf map: Add accessors for ->prot, ->priv and ->flags
      perf map: Add accessors for ->pgoff and ->reloc
      perf test: Add extra diagnostics to maps test
      perf maps: Modify maps_by_name to hold a reference to a map
      perf map: Changes to reference counting
      perf lock contention: Support pre-5.14 kernels
      perf bpf filter: Support pre-5.16 kernels where 'mem_hops' isn't in 'union perf_mem_data_src'
      perf test stat+csv_output: Write CSV output to a file
      perf stat: Don't write invalid "started on" comment for JSON output
      perf test stat+json_output: Write JSON output to a file
      perf ui: Move window resize signal functions
      perf usage: Move usage strings
      perf header: Move perf_version_string declaration
      perf version: Use regular verbose flag
      perf util: Move input_name to util
      perf util: Move perf_guest/host declarations
      perf build: Warn for BPF skeletons if endian mismatches
      perf evsel: Avoid SEGV if delete is called on NULL
      perf bperf: Avoid use after free via unrelated 'struct evsel' anonymous union field
      perf vendor events: Update alderlake to v1.20
      perf vendor events: Update icelakex to v1.20
      perf cpumap: Use perf_cpu_map__nr(cpus) to access cpus->nr
      libperf: Make perf_cpu_map__alloc() available as an internal function for tools/perf to use
      perf vendor events intel: Update sapphirerapids to v1.12
      perf vendor events intel: Add grandridge
      perf vendor events intel: Add sierraforest
      perf vendor events intel: Fix uncore topics for alderlake
      perf vendor events intel: Fix uncore topics for broadwell
      perf vendor events intel: Fix uncore topics for broadwellde
      perf vendor events intel: Fix uncore topics for broadwellx
      perf vendor events intel: Fix uncore topics for cascadelakex
      perf vendor events intel: Fix uncore topics for haswell
      perf vendor events intel: Fix uncore topics for haswellx
      perf vendor events intel: Fix uncore topics for icelake
      perf vendor events intel: Fix uncore topics for icelakex
      perf vendor events intel: Fix uncore topics for ivybridge
      perf vendor events intel: Fix uncore topics for ivytown
      perf vendor events intel: Fix uncore topics for jaketown
      perf vendor events intel: Fix uncore topics for knightslanding
      perf vendor events intel: Fix uncore topics for sandybridge
      perf vendor events intel: Fix uncore topics for skylake
      perf vendor events intel: Fix uncore topics for skylakex
      perf vendor events intel: Fix uncore topics for snowridgex
      perf vendor events intel: Fix uncore topics for tigerlake
      libperf: Add reference count checking macros
      perf cpumap: Use perf_cpu_map__cpu(map, cpu) instead of accessing map->map[cpu] directly
      perf cpumap: Add reference count checking
      perf namespaces: Add reference count checking
      perf maps: Add reference count checking
      perf map: Add reference count checking
      perf test: Fix maps use after put
      libperf rc_check: Enable implicitly with sanitizers
      perf stat: Avoid SEGV on counter->name
      perf stat: Disable TopdownL1 on hybrid

James Clark (12):
      perf cs-etm: Reduce verbosity of ts_source warning
      perf cs-etm: Avoid printing warning in cs_etm_is_ete() check
      perf vendor events arm64: Add N1 metrics
      perf cs-etm: Fix segfault in dso lookup
      perf cs-etm: Fix timeless decode mode detection
      perf tools: Add util function for overriding user set config values
      perf cs-etm: Don't test full_auxtrace because it's always set
      perf cs-etm: Validate options after applying them
      perf cs-etm: Allow user to override timestamp and contextid settings
      perf cs-etm: Use bool type for boolean values
      perf cs-etm: Add separate decode paths for timeless and per-thread modes
      perf build: Fix unescaped # in perf build-test

Kajol Jain (1):
      perf vendor events power9: Remove UTF-8 characters from JSON files

Kan Liang (1):
      perf record: Fix "read LOST count failed" msg with sample read

Leo Yan (18):
      perf kvm: Refactor overall statistics
      perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
      perf kvm: Move up metrics helpers
      perf kvm: Use subtraction for comparison metrics
      perf kvm: Use macro to replace variable 'decode_str_len'
      perf kvm: Introduce histograms data structures
      perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
      perf kvm: Parse address location for samples
      perf hist: Add 'kvm_info' field in histograms entry
      perf kvm: Add dimensions for KVM event statistics
      perf kvm: Use histograms list to replace cached list
      perf kvm: Polish sorting key
      perf kvm: Support printing attributions for dimensions
      perf kvm: Add dimensions for percentages
      perf kvm: Add TUI mode for stat report
      perf kvm: Update documentation to reflect new changes
      perf kvm: Reference count 'struct kvm_info'
      perf kvm: Delete histograms entries before exiting

Liam Howlett (1):
      tools: Rename __fallthrough to fallthrough

Markus Elfring (1):
      perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()

Mike Leach (3):
      perf cs-etm: Move mapping of Trace ID and cpu into helper function
      perf cs-etm: Update record event to use new Trace ID protocol
      perf cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet

Namhyung Kim (39):
      perf test: Fix offcpu test prev_state check
      perf lock contention: Track and show mmap_lock with address
      perf lock contention: Track and show siglock with address
      perf lock contention: Show per-cpu rq_lock with address
      perf lock contention: Show lock type with address
      perf bpf filter: Introduce basic BPF filter expression
      perf bpf filter: Implement event sample filtering
      perf record: Add BPF event filter support
      perf record: Record dropped sample count
      perf bpf filter: Add 'pid' sample data support
      perf bpf filter: Add more weight sample data support
      perf bpf filter: Add data_src sample data support
      perf bpf filter: Add logical OR operator
      perf bpf filter: Show warning for missing sample flags
      perf record: Update documentation for BPF filters
      perf hist: Improve srcfile sort key performance (really)
      perf lock contention: Fix msan issue in lock_contention_read()
      perf lock contention: Fix debug stat if no contention
      perf lock contention: Show detail failure reason for BPF
      perf list: Use relative path for tracepoint scan
      perf tools: Fix a asan issue in parse_events_multi_pmu_add()
      perf pmu: Add perf_pmu__destroy() function
      perf bench: Add pmu-scan benchmark
      perf pmu: Use relative path for sysfs scan
      perf pmu: Use relative path in perf_pmu__caps_parse()
      perf pmu: Use relative path in setup_pmu_alias_list()
      perf pmu: Add perf_pmu__{open,scan}_file_at()
      perf intel-pt: Use perf_pmu__scan_file_at() if possible
      perf lock contention: Simplify parse_lock_type()
      perf lock contention: Use -M for --map-nr-entries
      perf lock contention: Update default map size to 16384
      perf lock contention: Add data failure stat
      perf lock contention: Update total/bad stats for hidden entries
      perf lock contention: Revise needs_callstack() condition
      perf lock contention: Do not try to update if hash map is full
      perf lock contention: Fix struct rq lock access
      perf lock contention: Rework offset calculation with BPF CO-RE
      perf list: Fix memory leaks in print_tracepoint_events()
      perf list: Modify the warning message about scandirat(3)

Patrice Duroux (2):
      perf tests record_offcpu.sh: Fix redirection of stderr to stdin
      perf tests test_bridge_fdb_stress.sh: Fix redirection of stderr to stdin

Ravi Bangoria (6):
      tools include UAPI: Sync uapi/linux/perf_event.h with the kernel sources
      perf mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_DATA_SRC_NONE
      perf mem: Add support for printing PERF_MEM_LVLNUM_UNC
      perf mem: Refactor perf_mem__lvl_scnprintf() to process 'union perf_mem_data_src' more intuitively
      perf mem: Increase HISTC_MEM_LVL column size to 39 chars
      perf script ibs: Change bit description according to latest AMD PPR ("Processor Programming Reference")

Rob Herring (2):
      perf tools: Add support for perf_event_attr::config3
      perf arm-spe: Add raw decoding for SPEv1.3 MTE and MOPS load/store

Roman Lozko (1):
      perf scripts intel-pt-events.py: Fix IPC output for Python 2

Sriram Yagnaraman (1):
      perf script: Add new parameter in kfree_skb tracepoint to the python scripts using it

Thomas Richter (12):
      perf vendor events s390: Add common metrics
      perf vendor events s390: Add cache metrics for z16
      perf list: Add PMU pai_ext event description for IBM z16
      perf vendor events s390: Add cache metrics for z15
      perf vendor events s390: Add cache metrics for z14
      perf vendor events s390: Add cache metrics for z13
      perf vendor events s390: Add metric for TLB and cache
      perf test: Fix wrong size expectation for 'Setup struct perf_event_attr'
      perf vendor events s390: Remove UTF-8 characters from JSON file
      perf stat: Suppress warning when using cpum_cf events on s390
      perf test record+probe_libc_inet_pton: Fix call chain match on s390
      perf test record+probe_libc_inet_pton: Fix call chain match on x86_64

Tiezhu Yang (2):
      perf bench syscall: Add fork syscall benchmark
      tools headers: Remove s390 ptrace.h in check-headers.sh

Yang Jihong (3):
      perf ftrace: Make system wide the default target for latency subcommand
      perf symbols: Fix return incorrect build_id size in elf_read_build_id()
      perf tracepoint: Fix memory leak in is_valid_tracepoint()

liuwenyu (1):
      perf top: Fix rare segfault in thread__comm_len()

 tools/arch/x86/include/uapi/asm/unistd_32.h        |     4 +-
 tools/arch/x86/include/uapi/asm/unistd_64.h        |     3 +
 tools/build/Makefile.feature                       |     2 +
 tools/build/feature/Makefile                       |    15 +-
 tools/build/feature/test-all.c                     |     5 +
 tools/build/feature/test-cxa-demangle.cpp          |    17 +
 tools/build/feature/test-libbpf-bpf_map_create.c   |     8 -
 .../feature/test-libbpf-bpf_object__next_map.c     |     8 -
 .../feature/test-libbpf-bpf_object__next_program.c |     8 -
 tools/build/feature/test-libbpf-bpf_prog_load.c    |     9 -
 .../feature/test-libbpf-bpf_program__set_insns.c   |     8 -
 .../test-libbpf-btf__load_from_kernel_by_id.c      |     8 -
 tools/build/feature/test-libbpf-btf__raw_data.c    |     8 -
 tools/build/feature/test-libbpf.c                  |     4 +
 tools/build/feature/test-scandirat.c               |    13 +
 tools/include/linux/compiler-gcc.h                 |     6 +-
 tools/include/linux/compiler.h                     |     4 -
 tools/include/linux/coresight-pmu.h                |    47 +-
 tools/include/uapi/linux/perf_event.h              |     3 +-
 tools/lib/api/io.h                                 |    45 +
 tools/lib/perf/Makefile                            |     2 +-
 tools/lib/perf/cpumap.c                            |    94 +-
 tools/lib/perf/evlist.c                            |    31 +-
 tools/lib/perf/include/internal/cpumap.h           |    10 +-
 tools/lib/perf/include/internal/evlist.h           |     1 -
 tools/lib/perf/include/internal/rc_check.h         |   102 +
 tools/lib/perf/include/perf/event.h                |     2 +
 tools/lib/perf/include/perf/evlist.h               |     1 +
 tools/perf/Build                                   |     2 +-
 tools/perf/Documentation/perf-annotate.txt         |     3 +
 tools/perf/Documentation/perf-config.txt           |     8 +-
 tools/perf/Documentation/perf-kvm.txt              |     9 +-
 tools/perf/Documentation/perf-lock.txt             |     4 +-
 tools/perf/Documentation/perf-record.txt           |    60 +-
 tools/perf/Documentation/perf-report.txt           |     4 +
 tools/perf/Documentation/perf-stat.txt             |    27 +-
 tools/perf/Documentation/perf-top.txt              |    10 +
 tools/perf/Documentation/topdown.txt               |    70 +-
 tools/perf/Makefile.config                         |   126 +-
 tools/perf/Makefile.perf                           |    29 +-
 tools/perf/arch/arm/tests/dwarf-unwind.c           |     2 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   264 +-
 tools/perf/arch/arm/util/pmu.c                     |     2 +
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |     2 +-
 tools/perf/arch/arm64/util/arm-spe.c               |    28 +-
 tools/perf/arch/arm64/util/kvm-stat.c              |     5 +-
 tools/perf/arch/common.c                           |     4 +-
 tools/perf/arch/common.h                           |     2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |     2 +-
 tools/perf/arch/powerpc/util/header.c              |     2 +-
 tools/perf/arch/powerpc/util/kvm-stat.c            |     7 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |     4 +-
 tools/perf/arch/powerpc/util/sym-handling.c        |     4 +-
 tools/perf/arch/s390/annotate/instructions.c       |     2 +-
 tools/perf/arch/s390/util/Build                    |     1 +
 tools/perf/arch/s390/util/kvm-stat.c               |     1 -
 tools/perf/arch/s390/util/pmu.c                    |    23 +
 tools/perf/arch/x86/tests/dwarf-unwind.c           |     2 +-
 tools/perf/arch/x86/tests/insn-x86.c               |     4 +
 tools/perf/arch/x86/util/auxtrace.c                |     4 -
 tools/perf/arch/x86/util/event.c                   |    13 +-
 tools/perf/arch/x86/util/evlist.c                  |    45 +-
 tools/perf/arch/x86/util/intel-pt.c                |    72 +-
 tools/perf/arch/x86/util/iostat.c                  |     7 +-
 tools/perf/arch/x86/util/kvm-stat.c                |    15 +-
 tools/perf/arch/x86/util/pmu.c                     |    21 +-
 tools/perf/arch/x86/util/topdown.c                 |    78 +-
 tools/perf/arch/x86/util/topdown.h                 |     1 -
 tools/perf/bench/Build                             |     1 +
 tools/perf/bench/bench.h                           |     2 +
 tools/perf/bench/find-bit-bench.c                  |     8 +-
 tools/perf/bench/inject-buildid.c                  |     3 +-
 tools/perf/bench/numa.c                            |     2 +-
 tools/perf/bench/pmu-scan.c                        |   184 +
 tools/perf/bench/syscall.c                         |    35 +
 tools/perf/builtin-annotate.c                      |    60 +-
 tools/perf/builtin-bench.c                         |     2 +
 tools/perf/builtin-buildid-list.c                  |     6 +-
 tools/perf/builtin-c2c.c                           |    20 +-
 tools/perf/builtin-daemon.c                        |    14 +-
 tools/perf/builtin-data.c                          |     2 +-
 tools/perf/builtin-diff.c                          |     6 +-
 tools/perf/builtin-evlist.c                        |     2 +-
 tools/perf/builtin-ftrace.c                        |    16 +-
 tools/perf/builtin-help.c                          |     1 +
 tools/perf/builtin-inject.c                        |    20 +-
 tools/perf/builtin-kallsyms.c                      |     6 +-
 tools/perf/builtin-kmem.c                          |     6 +-
 tools/perf/builtin-kvm.c                           |   870 +-
 tools/perf/builtin-kwork.c                         |     2 +-
 tools/perf/builtin-list.c                          |    21 +-
 tools/perf/builtin-lock.c                          |   144 +-
 tools/perf/builtin-mem.c                           |    12 +-
 tools/perf/builtin-probe.c                         |     2 +-
 tools/perf/builtin-record.c                        |    56 +-
 tools/perf/builtin-report.c                        |    63 +-
 tools/perf/builtin-sched.c                         |    17 +-
 tools/perf/builtin-script.c                        |    39 +-
 tools/perf/builtin-stat.c                          |   275 +-
 tools/perf/builtin-timechart.c                     |     2 +-
 tools/perf/builtin-top.c                           |    67 +-
 tools/perf/builtin-trace.c                         |    18 +-
 tools/perf/builtin-version.c                       |     9 +-
 tools/perf/builtin.h                               |     3 -
 tools/perf/check-headers.sh                        |     1 -
 tools/perf/perf.c                                  |    27 +-
 tools/perf/perf.h                                  |     9 -
 .../arm/{cortex-a76-n1 => cortex-a76}/branch.json  |     0
 .../arm/{cortex-a76-n1 => cortex-a76}/bus.json     |     0
 .../arm/{cortex-a76-n1 => cortex-a76}/cache.json   |     0
 .../{cortex-a76-n1 => cortex-a76}/exception.json   |     0
 .../{cortex-a76-n1 => cortex-a76}/instruction.json |     0
 .../arm/{cortex-a76-n1 => cortex-a76}/memory.json  |     0
 .../{cortex-a76-n1 => cortex-a76}/pipeline.json    |     0
 .../pmu-events/arch/arm64/arm/neoverse-n1/bus.json |    18 +
 .../arch/arm64/arm/neoverse-n1/exception.json      |    62 +
 .../arch/arm64/arm/neoverse-n1/general.json        |     6 +
 .../arch/arm64/arm/neoverse-n1/l1d_cache.json      |    50 +
 .../arch/arm64/arm/neoverse-n1/l1i_cache.json      |    10 +
 .../arch/arm64/arm/neoverse-n1/l2_cache.json       |    46 +
 .../arch/arm64/arm/neoverse-n1/l3_cache.json       |    18 +
 .../arch/arm64/arm/neoverse-n1/ll_cache.json       |    10 +
 .../arch/arm64/arm/neoverse-n1/memory.json         |    22 +
 .../arch/arm64/arm/neoverse-n1/metrics.json        |   219 +
 .../arch/arm64/arm/neoverse-n1/retired.json        |    26 +
 .../pmu-events/arch/arm64/arm/neoverse-n1/spe.json |    18 +
 .../arch/arm64/arm/neoverse-n1/spec_operation.json |   102 +
 .../arch/arm64/arm/neoverse-n1/stall.json          |    10 +
 .../pmu-events/arch/arm64/arm/neoverse-n1/tlb.json |    66 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |     4 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |     4 +-
 .../pmu-events/arch/powerpc/power9/pipeline.json   |     2 +-
 .../pmu-events/arch/s390/cf_z13/transaction.json   |    70 +
 .../pmu-events/arch/s390/cf_z14/transaction.json   |    65 +
 .../pmu-events/arch/s390/cf_z15/transaction.json   |    65 +
 .../perf/pmu-events/arch/s390/cf_z16/extended.json |    10 +-
 .../perf/pmu-events/arch/s390/cf_z16/pai_ext.json  |   178 +
 .../pmu-events/arch/s390/cf_z16/transaction.json   |    65 +
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  3230 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |    36 +-
 .../arch/x86/alderlake/floating-point.json         |    27 +
 .../pmu-events/arch/x86/alderlake/frontend.json    |     9 +
 .../perf/pmu-events/arch/x86/alderlake/memory.json |    11 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |     3 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |    28 +-
 .../arch/x86/alderlake/uncore-interconnect.json    |    90 +
 .../arch/x86/alderlake/uncore-memory.json          |    16 +-
 .../arch/x86/alderlake/uncore-other.json           |    64 -
 .../arch/x86/alderlaken/adln-metrics.json          |   825 +-
 .../pmu-events/arch/x86/alderlaken/memory.json     |     7 +
 .../arch/x86/alderlaken/uncore-interconnect.json   |    26 +
 .../arch/x86/alderlaken/uncore-memory.json         |    16 +-
 .../arch/x86/alderlaken/uncore-other.json          |    24 -
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  1439 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |   296 +-
 .../arch/x86/broadwell/floating-point.json         |     7 +
 .../pmu-events/arch/x86/broadwell/frontend.json    |    18 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json |   248 +-
 .../pmu-events/arch/x86/broadwell/pipeline.json    |    22 +-
 .../arch/x86/broadwell/uncore-cache.json           |    30 +-
 .../arch/x86/broadwell/uncore-interconnect.json    |    61 +
 .../arch/x86/broadwell/uncore-other.json           |    59 -
 .../arch/x86/broadwellde/bdwde-metrics.json        |  1405 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |   105 +-
 .../arch/x86/broadwellde/floating-point.json       |    45 +-
 .../pmu-events/arch/x86/broadwellde/frontend.json  |    18 +-
 .../pmu-events/arch/x86/broadwellde/memory.json    |    64 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |    79 +-
 .../arch/x86/broadwellde/uncore-cache.json         |   396 +-
 .../arch/x86/broadwellde/uncore-interconnect.json  |   614 +
 .../{uncore-other.json => uncore-io.json}          |   595 +-
 .../arch/x86/broadwellde/uncore-memory.json        |   256 +-
 .../arch/x86/broadwellde/uncore-power.json         |    10 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |  1626 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |    16 +-
 .../pmu-events/arch/x86/broadwellx/frontend.json   |    18 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |    20 +-
 .../arch/x86/broadwellx/uncore-cache.json          |   456 +-
 .../arch/x86/broadwellx/uncore-interconnect.json   |  4305 ++-
 .../pmu-events/arch/x86/broadwellx/uncore-io.json  |   555 +
 .../arch/x86/broadwellx/uncore-memory.json         |   522 +-
 .../arch/x86/broadwellx/uncore-other.json          |  3250 --
 .../arch/x86/broadwellx/uncore-power.json          |    10 +-
 .../pmu-events/arch/x86/cascadelakex/cache.json    |    24 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |  2204 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |     8 +-
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |    16 +
 .../arch/x86/cascadelakex/uncore-cache.json        | 10764 ++++++
 .../arch/x86/cascadelakex/uncore-interconnect.json | 11334 +++++++
 .../arch/x86/cascadelakex/uncore-io.json           |  4250 +++
 .../arch/x86/cascadelakex/uncore-memory.json       |    18 +-
 .../arch/x86/cascadelakex/uncore-other.json        | 26336 ---------------
 .../arch/x86/cascadelakex/uncore-power.json        |     8 +-
 .../perf/pmu-events/arch/x86/grandridge/cache.json |   155 +
 .../pmu-events/arch/x86/grandridge/frontend.json   |    16 +
 .../pmu-events/arch/x86/grandridge/memory.json     |    20 +
 .../perf/pmu-events/arch/x86/grandridge/other.json |    20 +
 .../pmu-events/arch/x86/grandridge/pipeline.json   |    96 +
 .../arch/x86/grandridge/virtual-memory.json        |    24 +
 .../pmu-events/arch/x86/graniterapids/cache.json   |    54 +
 .../arch/x86/graniterapids/frontend.json           |    10 +
 .../pmu-events/arch/x86/graniterapids/memory.json  |   174 +
 .../pmu-events/arch/x86/graniterapids/other.json   |    29 +
 .../arch/x86/graniterapids/pipeline.json           |   102 +
 .../arch/x86/graniterapids/virtual-memory.json     |    26 +
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |    38 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  1220 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |    38 +-
 .../perf/pmu-events/arch/x86/haswell/pipeline.json |     8 +
 .../pmu-events/arch/x86/haswell/uncore-cache.json  |    50 +-
 .../arch/x86/haswell/uncore-interconnect.json      |    52 +
 .../pmu-events/arch/x86/haswell/uncore-other.json  |    50 -
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |     2 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  1397 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json     |     8 +
 .../pmu-events/arch/x86/haswellx/uncore-cache.json |   376 +-
 .../arch/x86/haswellx/uncore-interconnect.json     |  4242 ++-
 .../pmu-events/arch/x86/haswellx/uncore-io.json    |   528 +
 .../pmu-events/arch/x86/haswellx/uncore-other.json |  3160 --
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |    16 +
 .../arch/x86/icelake/floating-point.json           |    31 +
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  1932 +-
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |    23 +-
 .../arch/x86/icelake/uncore-interconnect.json      |    74 +
 .../pmu-events/arch/x86/icelake/uncore-other.json  |    16 -
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |     8 +
 .../arch/x86/icelakex/floating-point.json          |    31 +
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  2153 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     |    10 +
 .../pmu-events/arch/x86/icelakex/uncore-cache.json |  9860 ++++++
 .../arch/x86/icelakex/uncore-interconnect.json     | 14571 ++++++++
 .../pmu-events/arch/x86/icelakex/uncore-io.json    |  9270 +++++
 .../arch/x86/icelakex/uncore-memory.json           |     6 +-
 .../pmu-events/arch/x86/icelakex/uncore-other.json | 33727 -------------------
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  1270 +-
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |     8 +
 .../arch/x86/ivybridge/uncore-cache.json           |    50 +-
 ...{uncore-other.json => uncore-interconnect.json} |     0
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  1311 +-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |     8 +
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   314 +-
 .../arch/x86/ivytown/uncore-interconnect.json      |  2025 +-
 .../pmu-events/arch/x86/ivytown/uncore-io.json     |   549 +
 .../pmu-events/arch/x86/ivytown/uncore-other.json  |  2174 --
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |     6 +-
 .../arch/x86/jaketown/floating-point.json          |     2 +-
 .../pmu-events/arch/x86/jaketown/frontend.json     |    12 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   602 +-
 .../pmu-events/arch/x86/jaketown/pipeline.json     |    10 +-
 .../pmu-events/arch/x86/jaketown/uncore-cache.json |   216 +-
 .../arch/x86/jaketown/uncore-interconnect.json     |  1311 +-
 .../pmu-events/arch/x86/jaketown/uncore-io.json    |   324 +
 .../arch/x86/jaketown/uncore-memory.json           |     4 +-
 .../pmu-events/arch/x86/jaketown/uncore-other.json |  1393 -
 .../pmu-events/arch/x86/jaketown/uncore-power.json |     8 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  |    94 +-
 .../arch/x86/knightslanding/pipeline.json          |     8 +-
 .../{uncore-other.json => uncore-cache.json}       |   304 +-
 .../arch/x86/knightslanding/uncore-io.json         |   194 +
 .../arch/x86/knightslanding/uncore-memory.json     |   106 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    47 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |     8 +
 .../pmu-events/arch/x86/meteorlake/frontend.json   |     9 +
 .../pmu-events/arch/x86/meteorlake/memory.json     |    13 +-
 .../perf/pmu-events/arch/x86/meteorlake/other.json |     4 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |    36 +-
 .../arch/x86/meteorlake/virtual-memory.json        |     4 +
 .../pmu-events/arch/x86/sandybridge/cache.json     |     8 +-
 .../arch/x86/sandybridge/floating-point.json       |     2 +-
 .../pmu-events/arch/x86/sandybridge/frontend.json  |    12 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |    10 +-
 .../arch/x86/sandybridge/snb-metrics.json          |   601 +-
 .../arch/x86/sandybridge/uncore-cache.json         |    50 +-
 ...{uncore-other.json => uncore-interconnect.json} |     0
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |    24 +-
 .../arch/x86/sapphirerapids/floating-point.json    |    32 +
 .../arch/x86/sapphirerapids/frontend.json          |     8 +
 .../pmu-events/arch/x86/sapphirerapids/other.json  |     3 +-
 .../arch/x86/sapphirerapids/pipeline.json          |    23 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |  2293 +-
 .../arch/x86/sapphirerapids/uncore-cache.json      |  5644 ++++
 .../arch/x86/sapphirerapids/uncore-cxl.json        |   450 +
 .../x86/sapphirerapids/uncore-interconnect.json    |  6199 ++++
 .../arch/x86/sapphirerapids/uncore-io.json         |  3651 ++
 .../arch/x86/sapphirerapids/uncore-memory.json     |  3283 +-
 .../arch/x86/sapphirerapids/uncore-other.json      |  4465 ---
 .../arch/x86/sapphirerapids/uncore-power.json      |   107 +
 .../pmu-events/arch/x86/sierraforest/cache.json    |   155 +
 .../pmu-events/arch/x86/sierraforest/frontend.json |    16 +
 .../pmu-events/arch/x86/sierraforest/memory.json   |    20 +
 .../pmu-events/arch/x86/sierraforest/other.json    |    20 +
 .../pmu-events/arch/x86/sierraforest/pipeline.json |    96 +
 .../arch/x86/sierraforest/virtual-memory.json      |    24 +
 .../pmu-events/arch/x86/silvermont/frontend.json   |     2 +-
 .../pmu-events/arch/x86/silvermont/pipeline.json   |     2 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json  |    17 +-
 .../arch/x86/skylake/floating-point.json           |    15 +
 .../perf/pmu-events/arch/x86/skylake/frontend.json |     8 +-
 tools/perf/pmu-events/arch/x86/skylake/other.json  |     1 +
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |    26 +
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  1877 +-
 .../pmu-events/arch/x86/skylake/uncore-cache.json  |    28 +-
 .../arch/x86/skylake/uncore-interconnect.json      |    67 +
 .../pmu-events/arch/x86/skylake/uncore-other.json  |    64 -
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |     8 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |     8 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |    16 +
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  2097 +-
 .../pmu-events/arch/x86/skylakex/uncore-cache.json | 10649 ++++++
 .../arch/x86/skylakex/uncore-interconnect.json     | 11248 +++++++
 .../pmu-events/arch/x86/skylakex/uncore-io.json    |  4250 +++
 .../arch/x86/skylakex/uncore-memory.json           |     2 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json | 26135 --------------
 .../pmu-events/arch/x86/skylakex/uncore-power.json |     6 +-
 .../arch/x86/snowridgex/uncore-cache.json          |  7100 ++++
 .../arch/x86/snowridgex/uncore-interconnect.json   |  6016 ++++
 .../pmu-events/arch/x86/snowridgex/uncore-io.json  |  8944 +++++
 .../arch/x86/snowridgex/uncore-memory.json         |     4 +-
 .../arch/x86/snowridgex/uncore-other.json          | 22094 ------------
 .../arch/x86/tigerlake/floating-point.json         |    31 +
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |    18 +
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  1942 +-
 .../arch/x86/tigerlake/uncore-interconnect.json    |    90 +
 .../arch/x86/tigerlake/uncore-memory.json          |    50 +
 .../arch/x86/tigerlake/uncore-other.json           |   100 -
 .../pmu-events/arch/x86/westmereep-dp/cache.json   |     2 +-
 .../arch/x86/westmereep-dp/virtual-memory.json     |     2 +-
 tools/perf/pmu-events/empty-pmu-events.c           |     6 +-
 tools/perf/pmu-events/jevents.py                   |    61 +-
 tools/perf/pmu-events/metric.py                    |     8 +-
 tools/perf/pmu-events/pmu-events.h                 |    35 +-
 tools/perf/scripts/Build                           |     4 +-
 tools/perf/scripts/python/Perf-Trace-Util/Build    |     2 +-
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |    17 +-
 tools/perf/scripts/python/intel-pt-events.py       |     8 +-
 tools/perf/scripts/python/net_dropmonitor.py       |     4 +-
 tools/perf/scripts/python/netdev-times.py          |     6 +-
 tools/perf/scripts/python/task-analyzer.py         |     2 +-
 tools/perf/tests/api-io.c                          |    39 +-
 tools/perf/tests/attr/base-record                  |     2 +-
 tools/perf/tests/attr/base-stat                    |     2 +-
 tools/perf/tests/attr/system-wide-dummy            |     2 +-
 tools/perf/tests/bpf.c                             |     1 -
 tools/perf/tests/builtin-test.c                    |     4 +-
 tools/perf/tests/code-reading.c                    |    76 +-
 tools/perf/tests/cpumap.c                          |     4 +-
 tools/perf/tests/expand-cgroup.c                   |     5 +-
 tools/perf/tests/expr.c                            |     7 +-
 tools/perf/tests/hists_common.c                    |     8 +-
 tools/perf/tests/hists_cumulate.c                  |    14 +-
 tools/perf/tests/hists_filter.c                    |    14 +-
 tools/perf/tests/hists_link.c                      |    22 +-
 tools/perf/tests/hists_output.c                    |    12 +-
 tools/perf/tests/make                              |    28 +-
 tools/perf/tests/maps.c                            |    69 +-
 tools/perf/tests/mmap-thread-lookup.c              |     3 +-
 tools/perf/tests/parse-events.c                    |    49 +-
 tools/perf/tests/parse-metric.c                    |    23 +-
 tools/perf/tests/pfm.c                             |    12 +-
 tools/perf/tests/pmu-events.c                      |    53 +-
 tools/perf/tests/pmu.c                             |     9 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |     3 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |     3 -
 tools/perf/tests/shell/record_offcpu.sh            |     4 +-
 tools/perf/tests/shell/stat+csv_output.sh          |    58 +-
 tools/perf/tests/shell/stat+json_output.sh         |    48 +-
 tools/perf/tests/shell/test_arm_coresight.sh       |    24 +
 tools/perf/tests/symbols.c                         |     7 +-
 tools/perf/tests/thread-maps-share.c               |    28 +-
 tools/perf/tests/vmlinux-kallsyms.c                |    54 +-
 tools/perf/ui/browsers/annotate.c                  |     9 +-
 tools/perf/ui/browsers/hists.c                     |    22 +-
 tools/perf/ui/browsers/map.c                       |     4 +-
 tools/perf/ui/gtk/annotate.c                       |    11 +-
 tools/perf/ui/gtk/browser.c                        |     2 +-
 tools/perf/ui/gtk/gtk.h                            |     2 +
 tools/perf/ui/gtk/helpline.c                       |     2 +-
 tools/perf/ui/gtk/hists.c                          |     2 +-
 tools/perf/ui/hist.c                               |     2 +-
 tools/perf/ui/setup.c                              |    19 +
 tools/perf/ui/tui/setup.c                          |     1 -
 tools/perf/ui/ui.h                                 |     3 +
 tools/perf/util/Build                              |    19 +-
 tools/perf/util/amd-sample-raw.c                   |    14 +-
 tools/perf/util/annotate.c                         |    85 +-
 tools/perf/util/annotate.h                         |     9 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |    30 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |    47 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |     9 +
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |     3 +
 tools/perf/util/arm-spe.c                          |    28 +-
 tools/perf/util/auxtrace.c                         |     7 +-
 tools/perf/util/block-info.c                       |     4 +-
 tools/perf/util/block-range.c                      |     6 +-
 tools/perf/util/bpf-event.c                        |    76 +-
 tools/perf/util/bpf-filter.c                       |   197 +
 tools/perf/util/bpf-filter.h                       |    49 +
 tools/perf/util/bpf-filter.l                       |   159 +
 tools/perf/util/bpf-filter.y                       |    78 +
 tools/perf/util/bpf-loader.c                       |    18 -
 tools/perf/util/bpf_counter.c                      |    28 +-
 tools/perf/util/bpf_lock_contention.c              |    54 +-
 tools/perf/util/bpf_skel/.gitignore                |     3 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   136 +-
 tools/perf/util/bpf_skel/lock_data.h               |    17 +
 tools/perf/util/bpf_skel/sample-filter.h           |    27 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c       |   196 +
 tools/perf/util/build-id.c                         |     2 +-
 tools/perf/util/callchain.c                        |    28 +-
 tools/perf/util/cloexec.c                          |    13 -
 tools/perf/util/cpumap.c                           |    43 +-
 tools/perf/util/cpumap.h                           |     3 +
 tools/perf/util/cputopo.c                          |    14 +
 tools/perf/util/cputopo.h                          |     5 +
 tools/perf/util/cs-etm-base.c                      |     3 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |     7 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |     8 +-
 tools/perf/util/cs-etm.c                           |   568 +-
 tools/perf/util/cs-etm.h                           |    20 +-
 tools/perf/util/data-convert-json.c                |    10 +-
 tools/perf/util/db-export.c                        |    16 +-
 tools/perf/util/demangle-cxx.cpp                   |    49 +
 tools/perf/util/demangle-cxx.h                     |    16 +
 tools/perf/util/dlfilter.c                         |    28 +-
 tools/perf/util/dso.c                              |    13 +-
 tools/perf/util/dso.h                              |     2 +
 tools/perf/util/dsos.c                             |     3 +-
 tools/perf/util/env.c                              |     2 +-
 tools/perf/util/event.c                            |    29 +-
 tools/perf/util/event.h                            |     3 +-
 tools/perf/util/evlist.c                           |    42 +-
 tools/perf/util/evlist.h                           |     8 +-
 tools/perf/util/evsel.c                            |    46 +-
 tools/perf/util/evsel.h                            |    21 +-
 tools/perf/util/evsel_fprintf.c                    |    13 +-
 tools/perf/util/expr.c                             |    49 +-
 tools/perf/util/expr.y                             |    12 +-
 tools/perf/util/ftrace.h                           |     1 -
 tools/perf/util/genelf_debug.c                     |    46 +-
 tools/perf/util/header.c                           |     3 +-
 tools/perf/util/header.h                           |     2 +
 tools/perf/util/hist.c                             |    49 +-
 tools/perf/util/hist.h                             |     4 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |     8 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    18 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.h  |     2 +
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |     2 +-
 tools/perf/util/intel-pt.c                         |    63 +-
 tools/perf/util/jitdump.c                          |     7 +-
 tools/perf/util/kvm-stat.h                         |    73 +-
 tools/perf/util/lock-contention.h                  |    10 +-
 tools/perf/util/machine.c                          |   257 +-
 tools/perf/util/map.c                              |   219 +-
 tools/perf/util/map.h                              |   144 +-
 tools/perf/util/maps.c                             |   317 +-
 tools/perf/util/maps.h                             |    72 +-
 tools/perf/util/mem-events.c                       |    90 +-
 tools/perf/util/metricgroup.c                      |   199 +-
 tools/perf/util/metricgroup.h                      |     5 +-
 tools/perf/util/namespaces.c                       |   141 +-
 tools/perf/util/namespaces.h                       |     3 +-
 tools/perf/util/ordered-events.c                   |     2 +-
 tools/perf/util/parse-events.c                     |   295 +-
 tools/perf/util/parse-events.h                     |    15 +-
 tools/perf/util/parse-events.l                     |     1 +
 tools/perf/util/parse-events.y                     |    28 +-
 tools/perf/util/pfm.c                              |     1 -
 tools/perf/util/pmu.c                              |   461 +-
 tools/perf/util/pmu.h                              |    23 +-
 tools/perf/util/pmu.l                              |    17 +-
 tools/perf/util/pmu.y                              |     5 +-
 tools/perf/util/print-events.c                     |    50 +-
 tools/perf/util/print-events.h                     |     1 +
 tools/perf/util/probe-event.c                      |    62 +-
 tools/perf/util/probe-finder.c                     |     2 +-
 tools/perf/util/python.c                           |    21 +-
 tools/perf/util/record.h                           |     1 -
 tools/perf/util/sample.h                           |    13 +
 tools/perf/util/scripting-engines/Build            |     2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    10 +-
 .../util/scripting-engines/trace-event-python.c    |   101 +-
 tools/perf/util/session.c                          |     5 +-
 tools/perf/util/smt.c                              |    11 +-
 tools/perf/util/smt.h                              |    12 +-
 tools/perf/util/sort.c                             |   126 +-
 tools/perf/util/sort.h                             |     3 +
 tools/perf/util/srcline.c                          |   183 +-
 tools/perf/util/stat-display.c                     |   119 +-
 tools/perf/util/stat-shadow.c                      |  1287 +-
 tools/perf/util/stat.c                             |    74 -
 tools/perf/util/stat.h                             |    96 +-
 tools/perf/util/strfilter.c                        |     2 +-
 tools/perf/util/string.c                           |     2 +-
 tools/perf/util/symbol-elf.c                       |    94 +-
 tools/perf/util/symbol.c                           |   314 +-
 tools/perf/util/symbol_conf.h                      |     2 +-
 tools/perf/util/symbol_fprintf.c                   |     2 +-
 tools/perf/util/synthetic-events.c                 |    36 +-
 tools/perf/util/thread-stack.c                     |     4 +-
 tools/perf/util/thread.c                           |    69 +-
 tools/perf/util/top.c                              |     2 +-
 tools/perf/util/topdown.c                          |    68 +-
 tools/perf/util/topdown.h                          |    11 +-
 tools/perf/util/trace-event-scripting.c            |     9 +-
 tools/perf/util/tracepoint.c                       |     1 +
 tools/perf/util/unwind-libdw.c                     |    20 +-
 tools/perf/util/unwind-libunwind-local.c           |    68 +-
 tools/perf/util/unwind-libunwind.c                 |    39 +-
 tools/perf/util/usage.c                            |     6 +
 tools/perf/util/util.c                             |    21 +-
 tools/perf/util/util.h                             |     8 +
 tools/perf/util/vdso.c                             |     7 +-
 .../drivers/net/dsa/test_bridge_fdb_stress.sh      |     2 +-
 513 files changed, 169251 insertions(+), 146289 deletions(-)
 create mode 100644 tools/build/feature/test-cxa-demangle.cpp
 delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c
 create mode 100644 tools/build/feature/test-scandirat.c
 create mode 100644 tools/lib/perf/include/internal/rc_check.h
 create mode 100644 tools/perf/arch/s390/util/pmu.c
 create mode 100644 tools/perf/bench/pmu-scan.c
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/branch.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/bus.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/cache.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/exception.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/instruction.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/memory.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 => cortex-a76}/pipeline.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
 rename tools/perf/pmu-events/arch/x86/broadwellde/{uncore-other.json => uncore-io.json} (54%)
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-other.json
 rename tools/perf/pmu-events/arch/x86/ivybridge/{uncore-other.json => uncore-interconnect.json} (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
 rename tools/perf/pmu-events/arch/x86/knightslanding/{uncore-other.json => uncore-cache.json} (90%)
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
 rename tools/perf/pmu-events/arch/x86/sandybridge/{uncore-other.json => uncore-interconnect.json} (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-io.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/uncore-memory.json
 create mode 100644 tools/perf/util/bpf-filter.c
 create mode 100644 tools/perf/util/bpf-filter.h
 create mode 100644 tools/perf/util/bpf-filter.l
 create mode 100644 tools/perf/util/bpf-filter.y
 create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
 create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c
 create mode 100644 tools/perf/util/demangle-cxx.cpp
 create mode 100644 tools/perf/util/demangle-cxx.h
