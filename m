Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513F3660209
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjAFOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjAFOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:23:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26047F44B;
        Fri,  6 Jan 2023 06:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45070616FE;
        Fri,  6 Jan 2023 14:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9159C433D2;
        Fri,  6 Jan 2023 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673014986;
        bh=GLq2I201W/dvI6oHhthki9BIrq367DLSrcf0EBqIqAE=;
        h=From:To:Cc:Subject:Date:From;
        b=NvicM3gAwQf8qOAExduvANxhpvRbAxZO+Apgfsr/RIvXzjS7hZ+jEFblXH1KYZJo3
         U0EP59h6rECNeneqcfOCHGin8rJ2Ra1zPNS3eZwyfOJCMNO2XQyYGNUeRrFP9cLcxZ
         3u0DMm2uGFau2NAHcXbS4mjqIUswmB2FWLsHjkyQ5t6mz6bjWgmKvm2yCid0Ga41Dw
         d4U0FwyxV3g459s/qJ7XsIv3NQ9z9wWpvDkdsBq6qGLJc1clQJJfpVaq/FOfEwQBc5
         ouxNOP8ShjdGO4/fDb7Jj77d2jyeewx3GqXumzKaMvVZWykGzaHgGRKSOfhUQeM8jr
         jxrP0Nd0iWrRw==
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
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Eric Lin <eric.lin@sifive.com>,
        Ian Rogers <irogers@google.com>,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.2: 1st batch
Date:   Fri,  6 Jan 2023 11:22:56 -0300
Message-Id: <20230106142256.763489-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.0
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

	Please consider pulling, there are some more being tested but
that should sit in linux-next/pending-fixes for a while.

        Please let me know if you think anything should be reworked,

Best regards,

- Arnaldo

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-1-2023-01-06

for you to fetch changes up to 481028dbf1daa2808e1be06f6a865b5fe5939efc:

  perf tools: Fix build on uClibc systems by adding missing sys/types.h include (2023-01-04 16:44:01 -0300)

----------------------------------------------------------------
perf tools fixes for v6.2: 1st batch

- Fix segfault when trying to process tracepoints present in a perf.data file
  and not linked with libtraceevent.

- Fix build on uClibc systems by adding missing sys/types.h include, that was
  being obtained indirectly which stopped being the case when tools/lib/traceevent
  was removed.

- Don't show commands in 'perf help' that depend on linking with libtraceevent
  when not building with that library, which is now a possibility since we
  no longer ship a copy in tools/lib/traceevent.

- Fix failure in 'perf test' entry testing the combination of 'perf probe' user
  space function + 'perf record' + 'perf script' where it expects a backtrace
  leading to glibc's inet_pton() from 'ping' that now happens more than once with
  glibc 2.35 for IPv6 addreses.

- Fix for the inet_pton perf test on s/390 where 'text_to_binary_address' now
  appears on the backtrace.

- Fix build error on riscv due to missing header for 'struct perf_sample'.

- Fix 'make -C tools perf_install' install variant by not propagating the 'subdir'
  to submakes for the 'install_headers' targets.

- Fix handling of unsupported cgroup events when using BPF counters in 'perf stat'.

- Count all cgroups, not just the last one when using 'perf stat
  --for-each-cgroup' with --bpf-counters. This makes the output using BPF
  counters match the output without using it, which was the intention all along,
  the output should be the same using --bpf-counters or not.

- Fix 'perf lock contention' core dump related to not finding the
  "__sched_text_end" symbol on s/390.

- Fix build failure when HEAD is signed: exclude the signature from the version
  string.

- Add missing closedir() calls to in perf_data__open_dir(), plugging a fd leak.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Ahelenia Ziemiańska (1):
      perf tools: Don't include signature in version strings

Arnaldo Carvalho de Melo (2):
      perf tools: Fix segfault when trying to process tracepoints in perf.data and not linked with libtraceevent
      perf test record_probe_libc_inet_pton: Fix failure due to extra inet_pton() backtrace in glibc >= 2.35

Eric Lin (1):
      perf tools riscv: Fix build error on riscv due to missing header for 'struct perf_sample'

Ian Rogers (1):
      perf build: Don't propagate subdir to submakes for install_headers

Jesus Sanchez-Palencia (1):
      perf tools: Fix build on uClibc systems by adding missing sys/types.h include

Miaoqian Lin (1):
      perf tools: Fix resources leak in perf_data__open_dir()

Namhyung Kim (2):
      perf stat: Fix handling of unsupported cgroup events when using BPF counters
      perf stat: Fix handling of --for-each-cgroup with --bpf-counters to match non BPF mode

Thomas Richter (2):
      perf lock contention: Fix core dump related to not finding the "__sched_text_end" symbol on s/390
      perf test record_probe_libc_inet_pton: Fix test on s/390 where 'text_to_binary_address' now appears on the backtrace

Yang Jihong (1):
      perf help: Use HAVE_LIBTRACEEVENT to filter out unsupported commands

 tools/perf/Documentation/Makefile                  |  2 +-
 tools/perf/Makefile.perf                           | 10 +++++-----
 tools/perf/arch/riscv/util/unwind-libdw.c          |  2 +-
 tools/perf/builtin-lock.c                          |  2 ++
 tools/perf/command-list.txt                        | 10 +++++-----
 .../tests/shell/record+probe_libc_inet_pton.sh     |  3 ++-
 tools/perf/util/PERF-VERSION-GEN                   |  2 +-
 tools/perf/util/bpf_counter_cgroup.c               | 14 +++----------
 tools/perf/util/cgroup.c                           | 23 +++++++++++++++++-----
 tools/perf/util/data.c                             |  2 ++
 tools/perf/util/generate-cmdlist.sh                | 19 ++++++++++++++++--
 tools/perf/util/sort.c                             | 12 +++++++++++
 tools/perf/util/trace-event.h                      |  1 +
 13 files changed, 70 insertions(+), 32 deletions(-)
