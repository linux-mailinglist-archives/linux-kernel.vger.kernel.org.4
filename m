Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06AE716E45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjE3UCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjE3UCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049D98;
        Tue, 30 May 2023 13:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C41363306;
        Tue, 30 May 2023 20:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281D1C4339B;
        Tue, 30 May 2023 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685476938;
        bh=CGnr4j1mtkj7XDAkxN9NmqrdZfInpVJvJRWjYYdVIDY=;
        h=From:To:Cc:Subject:Date:From;
        b=UAPsEDCuOlsvrqWdyGUXAB8+TTdpmAkSxEcPbDIDTz+qNOg98mZLJhoVWdCDWKE6r
         ekAMQ37X+yjolRt43zkBSVXnzjGsl6/8qXghsT7lVEShVaHy8xi2r+AhGVRXtUlicI
         3vqqY/Lk+jr+eKoVFJQSwp27vyViR+e9GLktRtFj3rpop+h/o9DBgV+lW4EsDg2yC8
         ijls7SeSmogVw+DxxUa1m1yXNVVXH2R41vHkl7sKXGG0G6WQL86ZyDGQf196XWVJ0J
         ixoy2HVRMZea1aKAjbqunzGE4C9b6DPTz9DIncz4Z7EfwK1J/WYblMpEDfjksi5nxr
         QDaxPYb686gpQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.4: 2nd batch
Date:   Tue, 30 May 2023 17:02:10 -0300
Message-Id: <20230530200210.2103158-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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


The following changes since commit 0d85b27b0cc6b5cf54567c5ad913a247a71583ce:

  Merge tag '6.4-rc3-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2023-05-25 19:23:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.4-2-2023-05-30

for you to fetch changes up to c041d33bf7ec731bb71f47e4d45a7aec9e40b1b9:

  perf evsel: Separate bpf_counter_list and bpf_filters, can be used at the same time (2023-05-26 16:03:43 -0300)

----------------------------------------------------------------
perf tools fixes for v6.4: 2nd batch

- Fix BPF CO-RE naming convention for checking the availability of fields on
  'union perf_mem_data_src' on the running kernel.

- Remove the use of llvm-strip on BPF skel object files, not needed, fixes a
  build breakage when the llvm package, that contains it in most distros, isn't
  installed.

- Fix tools that use both evsel->{bpf_counter_list,bpf_filters}, removing them from a
  union.

- Remove extra "--" from the 'perf ftrace latency' --use-nsec option,
  previously it was working only when using the '-n' alternative.

- Don't stop building when both binutils-devel and a C++ compiler isn't
  available to compile the alternative C++ demangle support code, disable that
  feature instead.

- Sync the linux/in.h and coresight-pmu.h header copies with the kernel sources.

- Fix relative include path to cs-etm.h.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      tools headers UAPI: Sync the linux/in.h with the kernel sources

Ian Rogers (2):
      perf arm: Fix include path to cs-etm.h
      perf build: Don't compile demangle-cxx.cpp if not necessary

James Clark (1):
      perf cs-etm: Copy kernel coresight-pmu.h header

Namhyung Kim (2):
      perf ftrace latency: Remove unnecessary "--" from --use-nsec option
      perf bpf filter: Fix a broken perf sample data naming for BPF CO-RE

Song Liu (2):
      perf bpf: Do not use llvm-strip on BPF binary
      perf evsel: Separate bpf_counter_list and bpf_filters, can be used at the same time

 tools/include/linux/coresight-pmu.h          | 13 -------------
 tools/include/uapi/linux/in.h                |  1 +
 tools/perf/Makefile.config                   |  1 +
 tools/perf/Makefile.perf                     |  3 +--
 tools/perf/arch/arm/util/pmu.c               |  2 +-
 tools/perf/builtin-ftrace.c                  |  2 +-
 tools/perf/util/Build                        |  2 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  4 ++--
 tools/perf/util/cs-etm.h                     | 13 +++++++++++++
 tools/perf/util/evsel.c                      |  1 +
 tools/perf/util/evsel.h                      |  6 ++----
 tools/perf/util/symbol-elf.c                 | 27 +++++++++++++++++++++++++++
 12 files changed, 51 insertions(+), 24 deletions(-)
