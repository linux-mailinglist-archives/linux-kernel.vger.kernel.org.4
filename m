Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF05FFF0E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJPMJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJPMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:09:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21DCBC11;
        Sun, 16 Oct 2022 05:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2839B80C9D;
        Sun, 16 Oct 2022 12:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5397BC433C1;
        Sun, 16 Oct 2022 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665922166;
        bh=GpqLSNYQjqaJSdWZ6dBPtIgeGyyWzkG+tl9KUtcB5mg=;
        h=From:To:Cc:Subject:Date:From;
        b=kfjTRtTb5Ff0joWqseNHQdsYG3OOR0DzMio+xR2hHaokwnUCJgn/sPxz6Du1EZ2Bc
         ZxZC4pU5O8u4h4kavnN9/XtU8ROjockSxz3eQIeRLr0pNipf+7iLifwCz8gXTCypfy
         sIcG5vF5wNh+TZZzKwKrUcnSdzzBb65fVFLtkcP7NiyhdRWvA52tn/wxA+X/GNwUFh
         1OMY4ymxEHcMRAdPxrkI8Ze2oym/YB94DA8jPjwLPPBVzzHkghfkLfy9RvWQgtCueI
         wtUeDk2EK9KfM3rJrv4013l3fNaOhXrURosEjAeU8qoxh6RikD+e+O7/mO0dU+Ko0S
         Dv+9z14/fScrQ==
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
        Ammy Yi <ammy.yi@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kevin Nomura <nomurak@google.com>,
        Leo Yan <leo.yan@linaro.org>, Qi Liu <liuqi115@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.1: 2nd batch
Date:   Sun, 16 Oct 2022 09:09:14 -0300
Message-Id: <20221016120914.624129-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit 9c9155a3509a2ebdb06d77c7a621e9685c802eac:

  Merge tag 'drm-next-2022-10-14' of git://anongit.freedesktop.org/drm/drm (2022-10-13 21:56:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.1-2-2022-10-16

for you to fetch changes up to a3a365655a28f12f07eddf4f3fd596987b175e1d:

  tools arch x86: Sync the msr-index.h copy with the kernel sources (2022-10-15 10:13:16 -0300)

----------------------------------------------------------------
perf tools changes for v6.1: 2nd batch

- Use BPF CO-RE (Compile Once, Run Everywhere) to support old kernels
  when using bperf (perf BPF based counters) with cgroups.

- Support HiSilicon PCIe Performance Monitoring Unit (PMU), that
  monitors bandwidth, latency, bus utilization and buffer occupancy.

  Documented in Documentation/admin-guide/perf/hisi-pcie-pmu.rst.

- User space tasks can migrate between CPUs, so when tracing selected
  CPUs, system-wide sideband is still needed, fix it in the setup of
  Intel PT on hybrid systems.

- Fix metricgroups title message in 'perf list', it should state that
  the metrics groups are to be used with the '-M' option, not '-e'.

- Sync the msr-index.h copy with the kernel sources, adding support
  for using "AMD64_TSC_RATIO" in filter expressions in 'perf trace' as
  well as decoding it when printing the MSR tracepoint arguments.

- Fix program header size and alignment when generating a JIT ELF
  in 'perf inject'.

- Add multiple new Intel PT 'perf test' entries, including a jitdump one.

- Fix the 'perf test' entries for 'perf stat' CSV and JSON output when
  running on PowerPC due to an invalid topology number in that arch.

- Fix the 'perf test' for arm_coresight failures on the ARM Juno system.

- Fix the 'perf test' attr entry for PERF_FORMAT_LOST, adding this option
  to the or expression expected in the intercepted perf_event_open() syscall.

- Add missing condition flags ('hs', 'lo', 'vc', 'vs') for arm64 in the 'perf
  annotate' asm parser.

- Fix 'perf mem record -C' option processing, it was being chopped up
  when preparing the underlying 'perf record -e mem-events' and thus being
  ignored, requiring using '-- -C CPUs' as a workaround.

- Improvements and tidy ups for 'perf test' shell infra.

- Fix Intel PT information printing segfault in uClibc, where a NULL
  format was being passed to fprintf.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (8):
      perf test: test_intel_pt.sh: Fix return checking again
      perf test: test_intel_pt.sh: Tidy some perf record options
      perf test: test_intel_pt.sh: Print a message when skipping kernel tracing
      perf test: test_intel_pt.sh: Tidy some alignment
      perf test: test_intel_pt.sh: Add jitdump test
      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
      perf intel-pt: Fix segfault in intel_pt_print_info() with uClibc
      perf intel-pt: Fix system_wide dummy event for hybrid

Ammy Yi (1):
      perf test: test_intel_pt.sh: Add 9 tests

Andi Kleen (1):
      perf list: Fix metricgroups title message

Arnaldo Carvalho de Melo (2):
      libperf: Do not include non-UAPI linux/compiler.h header
      tools arch x86: Sync the msr-index.h copy with the kernel sources

Athira Rajeev (2):
      perf tests stat+csv_output: Include sanity check for topology
      perf tests stat+json_output: Include sanity check for topology

James Clark (2):
      perf test: Fix test_arm_coresight.sh failures on Juno
      perf test: Fix attr tests for PERF_FORMAT_LOST

Namhyung Kim (3):
      perf stat: Support old kernels for bperf cgroup counting
      perf annotate: Add missing condition flags for arm64
      perf mem: Fix -C option behavior for perf mem record

Qi Liu (3):
      perf auxtrace arm: Refactor event list iteration in auxtrace_record__init()
      perf auxtrace arm64: Add support for HiSilicon PCIe Tune and Trace device driver
      perf auxtrace arm64: Add support for parsing HiSilicon PCIe Trace packet

Rob Herring (1):
      perf: Skip and warn on unknown format 'configN' attrs

 tools/arch/x86/include/asm/msr-index.h             |  18 +
 tools/lib/perf/include/perf/event.h                |   5 +-
 tools/perf/arch/arm/util/auxtrace.c                | 116 ++++++-
 tools/perf/arch/arm/util/pmu.c                     |   3 +
 tools/perf/arch/arm64/annotate/instructions.c      |   2 +-
 tools/perf/arch/arm64/util/Build                   |   2 +-
 tools/perf/arch/arm64/util/hisi-ptt.c              | 188 ++++++++++
 tools/perf/arch/x86/util/intel-pt.c                |   2 +-
 tools/perf/builtin-list.c                          |   2 +-
 tools/perf/builtin-mem.c                           |   8 +
 tools/perf/tests/attr/base-record                  |   2 +-
 tools/perf/tests/attr/system-wide-dummy            |   2 +-
 tools/perf/tests/attr/test-record-group            |   4 +-
 tools/perf/tests/attr/test-record-group-sampling   |   6 +-
 tools/perf/tests/attr/test-record-group1           |   4 +-
 tools/perf/tests/attr/test-record-group2           |   4 +-
 tools/perf/tests/shell/stat+csv_output.sh          |  43 ++-
 tools/perf/tests/shell/stat+json_output.sh         |  43 ++-
 tools/perf/tests/shell/test_arm_coresight.sh       |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh            | 385 ++++++++++++++++++++-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/auxtrace.c                         |   4 +
 tools/perf/util/auxtrace.h                         |   1 +
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c        |  29 +-
 tools/perf/util/genelf.h                           |   4 +-
 tools/perf/util/hisi-ptt-decoder/Build             |   1 +
 .../util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 164 +++++++++
 .../util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  31 ++
 tools/perf/util/hisi-ptt.c                         | 192 ++++++++++
 tools/perf/util/hisi-ptt.h                         |  19 +
 tools/perf/util/intel-pt.c                         |   9 +-
 tools/perf/util/parse-events.c                     |   3 +
 tools/perf/util/pmu.c                              |  17 +
 tools/perf/util/pmu.h                              |   2 +
 tools/perf/util/pmu.l                              |   2 -
 tools/perf/util/pmu.y                              |  15 +-
 36 files changed, 1265 insertions(+), 71 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/hisi-ptt.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
 create mode 100644 tools/perf/util/hisi-ptt.c
 create mode 100644 tools/perf/util/hisi-ptt.h
