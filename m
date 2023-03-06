Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872766AC0AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCFNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCFNUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:20:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A002DE4C;
        Mon,  6 Mar 2023 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678108817; x=1709644817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WuQ0f29JV35vLLZH2nXyxwepY7cnYNfmBtgyXny2K6Y=;
  b=ahTUhAjsM3AuYpRGQaKTwH+lbCbNopUDNP5jIWmt7wh7Fv/8Gng0VrLJ
   r3ZiuEejUugvQXwzabI/WVVAT/FYk+gwkgleBGLo80jRDJFCtqQISyLkL
   E4UIcCb8oDvRsfaB6O/0GDzhaFc13yH/82yj1OYbzw3z4EIAtkrqrSl3c
   DBIk+Ic3HMb/0qdYlFGRDBvAHmDUpf9Co4S/81EhrthN8BAk9MSu3vmz0
   iAyqbw6hg7smrje5BuXxVH/UAlHnUDZn8t3Njf4sQYZWMfMf9NsooRKIe
   OupFS1WK9OKPa32apo27163mB0IbbYHVZqpI5/EC963E3mAyA4A5xjt3g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="334263994"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="334263994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 05:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="745053321"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="745053321"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.82])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 05:20:13 -0800
Message-ID: <d62c6cc7-9f43-2c23-d9e2-1ddbd0f5234c@intel.com>
Date:   Mon, 6 Mar 2023 15:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [linus:master] [perf symbols] ce4c8e7966:
 perf-sanity-tests.Test_data_symbol.fail
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <202303061424.6ad43294-yujie.liu@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <202303061424.6ad43294-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/23 08:30, kernel test robot wrote:
> Greeting,
> 
> FYI, we sent a report when this commit was in linux-next/master:
> 
> https://lore.kernel.org/all/202302092156.c0b14693-oliver.sang@intel.com/
> 
> This commit has been merged to mainline and we still observe similar
> failures, so we report again FYI.
> 
> We noticed perf-sanity-tests.Test_data_symbol.fail due to commit (built with gcc-11):
> 
> commit: ce4c8e7966f317ef2af896778b5fa9105a5cd351 ("perf symbols: Get symbols for .plt.got for x86-64")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master 1acf39ef8f1425cd105f630dc2c7c1d8fff27ed1]
> 
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
> 
> 	perf_compiler: clang
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 2023-02-08 19:29:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-ce4c8e7966f317ef2af896778b5fa91
> 05a5cd351/tools/perf/perf test 105
> 105: Test data symbol                                                : FAILED!
> 
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/perf_compiler:
>   lkp-kbl-d01/perf-sanity-tests/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/clang
> 
> commit: 
>   51a188ad8c2d8 ("perf symbols: Start adding support for .plt.got for x86")
>   ce4c8e7966f31 ("perf symbols: Get symbols for .plt.got for x86-64")
> 
> 51a188ad8c2d89c5 ce4c8e7966f317ef2af896778b5 
> ---------------- --------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>            :6           50%           3:6     perf-sanity-tests.Check_branch_stack_sampling.fail
>            :6          100%           6:6     perf-sanity-tests.Test_data_symbol.fail
>            :6           33%           2:6     perf-sanity-tests.perf_record_tests.fail
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.

Works fine for me.  See below.

You will have to debug your environment:
Add option -v to perf test (e.g. perf test -c "data symbol") and
add 'set -x' to tools/perf/tests/shell/test_data_symbol.sh

e.g.

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index 69bb6fe86c50..e083ad3be205 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -4,6 +4,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Leo Yan <leo.yan@linaro.org>, 2022
 
+set -x
+
 skip_if_no_mem_event() {
 	perf mem record -e list 2>&1 | grep -E -q 'available' && return 0
 	return 2

Results:

~/git/lkp-tests/atmp$ sudo ../bin/lkp run ../job-defaults.yaml
2023-03-06 15:06:24 +0200 WARN -- Jobfile is a dirty file, better to run
'lkp split-job --compatible ../job-defaults.yaml' first
2023-03-06 15:06:25 /lkp/benchmarks/perf/perf test
  1: vmlinux symtab matches kallsyms                                 : Ok
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus                         : Ok
  4: mmap interface tests                                            :
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok
  5: Test data source output                                         : Ok
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Test parsing of "hybrid" CPU events                           :
Skip (not hybrid)
  6.3: Parsing of all PMU events from sysfs                          : Ok
  6.4: Parsing of given PMU events from sysfs                        : Ok
  6.5: Parsing of aliased events from sysfs                          :
Skip (no aliases in sysfs)
  6.6: Parsing of aliased events                                     : Ok
  6.7: Parsing of terms (event modifiers)                            : Ok
  7: Simple expression parser                                        : Ok
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
  9: Parse perf pmu format                                           : Ok
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 11: DSO data read                                                   : Ok
 12: DSO data cache                                                  : Ok
 13: DSO data reopen                                                 : Ok
 14: Roundtrip evsel->name                                           : Ok
 15: Parse sched tracepoints fields                                  : Ok
 16: syscalls:sys_enter_openat event fields                          : Ok
 17: Setup struct perf_event_attr                                    : Ok
 18: Match and link multiple hists                                   : Ok
 19: 'import perf' in python                                         :
FAILED!
 20: Breakpoint overflow signal handler                              : Ok
 21: Breakpoint overflow sampling                                    : Ok
 22: Breakpoint accounting                                           : Ok
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          :
Skip (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
 24: Number of exit events of a simple workload                      : Ok
 25: Software clock events period values                             : Ok
 26: Object code reading                                             : Ok
 27: Sample parsing                                                  : Ok
 28: Use a dummy software event to keep tracking                     : Ok
 29: Parse with no sample_id_all bit set                             : Ok
 30: Filter hist entries                                             : Ok
 31: Lookup mmap thread                                              : Ok
 32: Share thread maps                                               : Ok
 33: Sort output of hist entries                                     : Ok
 34: Cumulate child hist entries                                     : Ok
 35: Track with sched_switch                                         : Ok
 36: Filter fds with revents mask in a fdarray                       : Ok
 37: Add fd to a fdarray, making it autogrow                         : Ok
 38: kmod_path__parse                                                : Ok
 39: Thread map                                                      : Ok
 40: LLVM search and compile                                         :
 40.1: Basic BPF llvm compile                                        : Ok
 40.2: kbuild searching                                              : Ok
 40.3: Compile source for BPF prologue generation                    : Ok
 40.4: Compile source for BPF relocation                             : Ok
 41: Session topology                                                : Ok
 42: BPF filter                                                      :
 42.1: Basic BPF filtering                                           : Ok
 42.2: BPF pinning                                                   : Ok
 42.3: BPF prologue generation                                       : Ok
 43: Synthesize thread map                                           : Ok
 44: Remove thread map                                               : Ok
 45: Synthesize cpu map                                              : Ok
 46: Synthesize stat config                                          : Ok
 47: Synthesize stat                                                 : Ok
 48: Synthesize stat round                                           : Ok
 49: Synthesize attr update                                          : Ok
 50: Event times                                                     : Ok
 51: Read backward ring buffer                                       : Ok
 52: Print cpu map                                                   : Ok
 53: Merge cpu map                                                   : Ok
 54: Probe SDT events                                                : Ok
 55: is_printable_array                                              : Ok
 56: Print bitmap                                                    : Ok
 57: perf hooks                                                      : Ok
 58: builtin clang support                                           :
 58.1: builtin clang compile C source to IR                          :
Skip (not compiled in)
 58.2: builtin clang compile C source to ELF object                  :
Skip (not compiled in)
 59: unit_number__scnprintf                                          : Ok
 60: mem2node                                                        : Ok
 61: time utils                                                      : Ok
 62: Test jit_write_elf                                              : Ok
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               :
Skip (not compiled in)
 63.2: test groups of --pfm-events                                   :
Skip (not compiled in)
 64: Test api io                                                     : Ok
 65: maps__merge_in                                                  : Ok
 66: Demangle Java                                                   : Ok
 67: Demangle OCaml                                                  : Ok
 68: Parse and process metrics                                       : Ok
 69: PE file support                                                 : Ok
 70: Event expansion for cgroups                                     : Ok
 71: Convert perf time to TSC                                        :
 71.1: TSC support                                                   : Ok
 71.2: Perf time to TSC                                              : Ok
 72: dlfilter C API                                                  : Skip
 73: Sigtrap                                                         : Ok
 74: Event groups                                                    : Skip
 75: Symbols                                                         : Ok
 76: Test dwarf unwind                                               : Ok
 77: x86 instruction decoder - new instructions                      : Ok
 78: Intel PT                                                        :
 78.1: Intel PT packet decoder                                       : Ok
 78.2: Intel PT hybrid CPU compatibility                             : Skip
 79: x86 bp modify                                                   : Ok
 80: x86 Sample parsing                                              : Ok
 81: build id cache operations                                       : Ok
 82: CoreSight / ASM Pure Loop                                       : Skip
 83: CoreSight / Memcpy 16k 10 Threads                               : Skip
 84: CoreSight / Thread Loop 10 Threads - Check TID                  : Skip
 85: CoreSight / Thread Loop 2 Threads - Check TID                   : Skip
 86: CoreSight / Unroll Loop Thread 10                               : Skip
 87: daemon operations                                               : Ok
 88: kernel lock contention analysis test                            : Ok
 89: perf pipe recording and injection test                          : Ok
 90: Add vfs_getname probe to get syscall args filenames             : Ok
 91: probe libc's inet_pton & backtrace it with ping                 : Ok
 92: Use vfs_getname probe to get syscall args filenames             : Ok
 93: Zstd perf.data compression/decompression                        : Ok
 94: perf record tests                                               : Ok
 95: perf record offcpu profiling tests                              : Skip
 96: perf stat CSV output linter                                     : Ok
 97: perf stat csv summary test                                      : Ok
 98: perf stat JSON output linter                                    : Ok
 99: perf stat metrics (shadow stat) test                            : Ok
100: perf stat tests                                                 : Ok
101: perf all metricgroups test                                      : Ok
102: perf all metrics test                                           : Skip
103: perf all PMU test                                               : Ok
104: perf stat --bpf-counters test                                   : Skip
105: perf stat --bpf-counters --for-each-cgroup test                 : Skip
106: Check Arm64 callgraphs are complete in fp mode                  : Skip
107: Check Arm CoreSight trace data recording and synthesized samples: Skip
108: Check Arm SPE trace data recording and synthesized samples      : Skip
109: Check Arm SPE doesn't hang when there are forks                 : Skip
110: Check branch stack sampling                                     : Ok
111: Test data symbol                                                : Ok
112: Miscellaneous Intel PT testing                                  : Ok
113: Test java symbol                                                : Skip
114: perf script task-analyzer tests                                 : Ok
115: Check open filename arg using perf trace + vfs_getname          : Ok
kill 29113 vmstat --timestamp -n 10
kill 29111 dmesg --follow --decode
wait for background processes: 29115 meminfo
~/git/lkp-tests/atmp$



