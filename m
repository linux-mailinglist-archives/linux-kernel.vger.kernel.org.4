Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BCD60EA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiJZUo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiJZUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450F1A82B;
        Wed, 26 Oct 2022 13:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A51F620C7;
        Wed, 26 Oct 2022 20:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2257EC433C1;
        Wed, 26 Oct 2022 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666817091;
        bh=2oVA+EsmgbKLpSEn7D0ZujUs5MGueNylhy9NyCfNoPk=;
        h=From:To:Cc:Subject:Date:From;
        b=dDRTXJ/RZpTPwe/BNHWamXr/pylxaEJcvuSHy5HPgWT1hRf24iwAbKk0RAijZ/kyE
         sBVWnSkDQkUAkJGjlajYU9HB8LS8MfiNQG0kA3TJQylpv3SkGdGhzJajohtyljT03B
         XtKTx+OuTOct0MYx3mOFyA0gX2Wc4vmKMs2VYbk01QXTUM2GbWCzTd16GEeDZfJDvo
         kvYbmVXEiW7kkSl/lvKHPgRFppFIUlvGLPzZwu7bGEvSSXdB7QFIx/4PK++/qGDT5C
         qd+GGoYJGaVjtIKHMI9oTr5Zy93UcOo6Ga9sAJtqf3rPTgWIVpQow1yxbqEHUvTrHV
         L4Ezs0T8kh5Ig==
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
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.1: 1st batch
Date:   Wed, 26 Oct 2022 17:44:43 -0300
Message-Id: <20221026204443.158004-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 4dc12f37a8e98e1dca5521c14625c869537b50b6:

  Merge tag 'platform-drivers-x86-v6.1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2022-10-25 12:05:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-2022-10-26

for you to fetch changes up to e9229d5b6254a75291536f582652c599957344d2:

  perf vendor events arm64: Fix incorrect Hisi hip08 L3 metrics (2022-10-26 11:01:56 -0300)

----------------------------------------------------------------
perf tools fixes for v6.1: 1st batch

- Fix some aspects of building with an older (than the one in the kernel
  sources) libbpf present in a distro, when building with LIBBPF_DYNAMIC=1.

- Fix errno setting races with event_fd and the signal handler in 'perf record'.

- Fix Power10 hv-24x7 metric events when some events may have a zero count based
  on system configuration.

- Do not fail Intel-PT misc test w/o libpython, just skip it.

- Fix incorrect arm64 Hisi hip08 L3 metrics (IF_BP_MISP_BR_RET,
  IF_BP_MISP_BR_RET, IF_BP_MISP_BR_BL) due to mistakes in the documentation used
  to generate the JSON files for these metrics.

- Fix auxtrace (Intel PT, ARM Coresight) address filter symbol name match for
  modules, we need to skip the module name.

- Sync copies of files with the kernel sources, including ppc syscall tables
  and assorted headers, some resulting in tools being able to decode new network
  protocols (IPPROTO_L2TP) and statx masks (STATX_DIOALIGN).

- Fix PMU name pai_crypto in the vendor events file (JSON) for s390.

- Fix man page build wrt perf-arm-coresight.txt as the build process assumes
  files starting with 'perf-' are man pages, and this file isn't one.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf docs: Fix man page build wrt perf-arm-coresight.txt
      perf auxtrace: Fix address filter symbol name match for modules

Arnaldo Carvalho de Melo (10):
      tools headers UAPI: Sync powerpc syscall tables with the kernel sources
      perf bpf: Fix build with libbpf 0.7.0 by adding prototype for bpf_load_program()
      perf bpf: Fix build with libbpf 0.7.0 by checking if bpf_program__set_insns() is available
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      tools headers: Update the copy of x86's memcpy_64.S used in 'perf bench'
      tools headers uapi: Update linux/in.h copy
      tools include UAPI: Sync sound/asound.h copy with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources

Ian Rogers (1):
      perf record: Fix event fd races

Kajol Jain (1):
      perf vendor events power10: Fix hv-24x7 metric events

Namhyung Kim (1):
      perf test: Do not fail Intel-PT misc test w/o libpython

Shang XiaoJing (1):
      perf vendor events arm64: Fix incorrect Hisi hip08 L3 metrics

Thomas Richter (1):
      perf list: Fix PMU name pai_crypto in perf list on s390

 tools/arch/arm64/include/asm/cputype.h             |  4 ++
 tools/arch/x86/include/asm/cpufeatures.h           |  2 +-
 tools/arch/x86/lib/memcpy_64.S                     |  2 +-
 tools/build/Makefile.feature                       |  1 +
 tools/build/feature/Makefile                       |  4 ++
 .../feature/test-libbpf-bpf_program__set_insns.c   |  8 +++
 tools/include/uapi/linux/in.h                      | 22 +++----
 tools/include/uapi/linux/perf_event.h              | 27 +++++---
 tools/include/uapi/linux/stat.h                    |  4 +-
 tools/include/uapi/sound/asound.h                  | 16 -----
 .../{perf-arm-coresight.txt => arm-coresight.txt}  |  0
 tools/perf/Makefile.config                         |  5 ++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 16 +++--
 tools/perf/builtin-record.c                        | 41 +++++++-----
 tools/perf/check-headers.sh                        |  2 +-
 .../arch/arm64/hisilicon/hip08/metrics.json        |  6 +-
 .../arch/powerpc/power10/nest_metrics.json         | 72 +++++++++++-----------
 .../arch/s390/cf_z16/{pai.json => pai_crypto.json} |  0
 tools/perf/tests/shell/test_intel_pt.sh            |  6 ++
 tools/perf/trace/beauty/statx.c                    |  1 +
 tools/perf/util/auxtrace.c                         | 10 ++-
 tools/perf/util/bpf-event.c                        |  5 ++
 tools/perf/util/bpf-loader.c                       | 18 ++++++
 tools/perf/util/include/linux/linkage.h            | 13 ++++
 24 files changed, 181 insertions(+), 104 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
 rename tools/perf/Documentation/{perf-arm-coresight.txt => arm-coresight.txt} (100%)
 rename tools/perf/pmu-events/arch/s390/cf_z16/{pai.json => pai_crypto.json} (100%)
