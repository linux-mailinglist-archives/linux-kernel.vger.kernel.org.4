Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6673A5E563B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIUW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIUW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:26:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B557A8307;
        Wed, 21 Sep 2022 15:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 964C0CE1FA1;
        Wed, 21 Sep 2022 22:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADBBC433C1;
        Wed, 21 Sep 2022 22:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663799168;
        bh=eCz+7ykAr0o97vQ4d0dHFt5bI+cqs4JXKrGw8rTT0kY=;
        h=From:To:Cc:Subject:Date:From;
        b=SMY9Vp2hEevfHx7SItZiK0H97UQYuU6XDNkgha1jrNcrWVKHKhf6ZynvQ69JHD3mM
         nmG5QkaXYWamQ7eiRzbbEoRgyMoZ5ozbvvEPZ6BPGvW7l7eZccpxwOCVM1Uyv6XtEr
         L9hQnP5eEY4cJSvBllpUR8TL0KnGIIaa6UodDyBh0Uh7ReNb3RrAP7m4FWvKp8uw9k
         bKVArTGw4dcwKw/GzR+7Zr7zVI39J1m7Pe4tMdpV3g/3f2iZN9CD3XDRjonbxmAyKU
         bfccHxr2kppd3FnPjzmkQLl74yJWfBA9PySVzz45HEroLzbwNDyzT1t0JrC5JWO/CB
         E+hjuMHGP5CeQ==
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
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Leo Yan <leo.yan@linaro.org>, Lieven Hey <lieven.hey@kdab.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.0: 4th batch
Date:   Wed, 21 Sep 2022 23:26:00 +0100
Message-Id: <20220921222600.29851-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

The following changes since commit 60891ec99e141b74544d11e897a245ef06263052:

  Merge tag 'for-6.0-rc6-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2022-09-20 10:23:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-21

for you to fetch changes up to 999e4eaa4b3691acf85d094836260ec4b66c74fd:

  perf tools: Honor namespace when synthesizing build-ids (2022-09-21 16:08:00 -0300)

----------------------------------------------------------------
perf tools fixes for v6.0: 4th batch

- Fix polling of system-wide events related to mixing per-cpu and per-thread
  events.

- Do not check if /proc/modules is unchanged when copying /proc/kcore,
  that doesn't get in the way of post processing analysis.

- Include program header in ELF files generated for JIT files, so that they can
  be opened by tools using elfutils libraries.

- Enter namespaces when synthesizing build-ids.

- Fix some bugs related to a recent cpu_map overhaul where we should be
  using an index and not the cpu number.

- Fix BPF program ELF section name, using the naming expected by libbpf when
  using BPF counters in 'perf stat'.

- Add a new test for perf stat cgroup BPF counter.

- Adjust check on 'perf test wp' for older kernels, where the
  PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl isn't supported.

- Sync x86 cpufeatures with the kernel sources, no changes in tooling.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (3):
      perf record: Fix cpu mask bit setting for mixed mmaps
      libperf evlist: Fix polling of system-wide events
      perf kcore_copy: Do not check /proc/modules is unchanged

Arnaldo Carvalho de Melo (1):
      tools headers cpufeatures: Sync with the kernel sources

Lieven Hey (1):
      perf jit: Include program header in ELF files

Namhyung Kim (6):
      perf stat: Fix BPF program section name
      perf stat: Fix cpu map index in bperf cgroup code
      perf stat: Use evsel->core.cpus to iterate cpus in BPF cgroup counters
      perf test: Add a new test for perf stat cgroup BPF counter
      perf test: Skip wp modify test on old kernels
      perf tools: Honor namespace when synthesizing build-ids

 tools/arch/x86/include/asm/cpufeatures.h         |  5 +-
 tools/lib/perf/evlist.c                          |  5 +-
 tools/perf/builtin-record.c                      |  2 +
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 83 ++++++++++++++++++++++++
 tools/perf/tests/wp.c                            | 10 ++-
 tools/perf/util/bpf_counter_cgroup.c             | 10 +--
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c      |  2 +-
 tools/perf/util/genelf.c                         | 14 ++++
 tools/perf/util/genelf.h                         |  4 ++
 tools/perf/util/symbol-elf.c                     |  7 +-
 tools/perf/util/synthetic-events.c               | 17 ++++-
 11 files changed, 139 insertions(+), 20 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
