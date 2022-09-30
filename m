Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5A5F01D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiI3Ad1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3AdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B120192B;
        Thu, 29 Sep 2022 17:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 247E4621F8;
        Fri, 30 Sep 2022 00:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF31C433D6;
        Fri, 30 Sep 2022 00:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664498003;
        bh=iitw3YbJcnCMdYxmQPC7U8sUkD91rj3PQj2IgF+NBus=;
        h=From:To:Cc:Subject:Date:From;
        b=aSoIeCy1lBcsZdsv/rukl5UlwTNIi24MndK51Y3kSwu/Hesn6S5isnSuHfMVDioCS
         3ameJt/LFGQyoq/jJ+H+hVtjoQJSvN0US0Hj+ExuNY3PHFwInXWAk4ImtzKgfFTXn0
         UnVkwFDC8z8S4EPnlfhPgWE3GoOFASX/ex9tYA2RpXv7C9IDDn42DwxPzYeSAUAI81
         4Dk5rGx4ON2xGVCa1xTURzFXzpsNgq8ofzS9xbHHtKg9cEa3v8MhBs9WT1j+drIQT/
         iIM0aofUK6DfzBa8St56GzPeIgMTyY9XGg3TXOb26uln/U6Mb1C6TTqW+fzm2PWtDl
         Hy/rmjBiKE6RQ==
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yi Ammy <ammy.yi@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.0: 5th batch
Date:   Thu, 29 Sep 2022 21:33:16 -0300
Message-Id: <20220930003316.62853-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-29

for you to fetch changes up to 8e8bf60a675473a034ecfcb7a842b98868ed74a3:

  perf build: Fixup disabling of -Wdeprecated-declarations for the python scripting engine (2022-09-29 16:03:35 -0300)

----------------------------------------------------------------
perf tools fixes for v6.0: 5th batch

- Fail the 'perf test record' entry on error, fixing a regression where just
  setup stuff like allocating memory and not the actual things being tested failed.

- Fixup disabling of -Wdeprecated-declarations for the python scripting engine, the
  previous attempt had a brown paper bag thinko.

- Fix branch stack sampling test to include sanity check for branch filter on PowerPC.

- Update is_ignored_symbol function to match the kernel ignored list, fixing running
  the 'perf test' entry that compares resolving symbols from kallsyms to resolving from
  vmlinux.

- Augment the data source type with ARM's neoverse_spe list, the previous code
  was limited in its search resolving the data source.

- Fix some clang 5 variable set but unused cases.

- Get a perf cgroup more portably in BPF as the __builtin_preserve_enum_value builtin is
  not available in older versions of clang. In those cases we can forgo BPF's CO-RE (Compile
  Once, Run Everywhere).

- More Fixes for Intel's hybrid CPU model.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      perf tests record: Fail the test if the 'errs' counter is not zero
      perf build: Fixup disabling of -Wdeprecated-declarations for the python scripting engine

Athira Rajeev (2):
      perf tests powerpc: Fix branch stack sampling test to include sanity check for branch filter
      perf tests vmlinux-kallsyms: Update is_ignored_symbol function to match the kernel ignored list

Jing Zhang (1):
      perf arm-spe: augment the data source type with neoverse_spe list

Jiri Olsa (2):
      perf parse-events: Ignore clang 15 warning about variable set but unused in bison produced code
      perf tests mmap-basic: Remove unused variable to address clang 15 warning

Namhyung Kim (1):
      perf tools: Get a perf cgroup more portably in BPF

Zhengjun Xing (3):
      perf print-events: Fix "perf list" can not display the PMU prefix for some hybrid cache events
      perf parse-events: Remove "not supported" hybrid cache events
      perf test: Fix test case 87 ("perf record tests") for hybrid systems

 tools/perf/tests/mmap-basic.c               |  3 +--
 tools/perf/tests/perf-record.c              |  2 +-
 tools/perf/tests/shell/record.sh            |  2 +-
 tools/perf/tests/shell/test_brstack.sh      |  3 ++-
 tools/perf/tests/vmlinux-kallsyms.c         |  5 ++--
 tools/perf/util/Build                       |  2 +-
 tools/perf/util/arm-spe.c                   |  2 +-
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 11 +++++++-
 tools/perf/util/bpf_skel/off_cpu.bpf.c      | 18 ++++++++++---
 tools/perf/util/parse-events-hybrid.c       | 21 +++++++++++++---
 tools/perf/util/parse-events.c              | 39 +++++++++++++++++++++++++++++
 tools/perf/util/parse-events.h              |  1 +
 tools/perf/util/print-events.c              | 39 -----------------------------
 tools/perf/util/scripting-engines/Build     |  2 +-
 14 files changed, 92 insertions(+), 58 deletions(-)
