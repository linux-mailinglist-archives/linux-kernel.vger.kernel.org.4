Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63174DE02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGJTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGJTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:13:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170A197
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:13:49 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403b622101bso60481cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689016428; x=1691608428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+hA88FR3vPplUQ1011adLOle3GTZBi7T5Emm/QInIk=;
        b=hmhTZ7NGouMWNCZh6IekL2vgyQ2LQcEvrTPLhV3EfbbMDYQgPoifrRTfhfyWC1qjwF
         jcwqMTIYqx3ugfS7WWU0d7nTeYwY/UzoOINz9gIbJ+vyj35KKF//xRR3U5KQnRDzCAjx
         NOH9hJHOa22Y0PJSfCaYk3LpNGL8J9rL2vptOTQHKDfpnT8ZeRpqvRz6B1fmz6zn0oCk
         XX2c1KLa4qMkvbL6RSgwWQJ01phyuBvysYabdwihfYx52w820th2RzE8OUxdLeO+GWpe
         3TKF6mEnUEuDRT6zfEqR17JZ5qLx/VSmSiwrOllBseulxCi65qBmsH9Xl95VrEOd3wvH
         Xpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689016428; x=1691608428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+hA88FR3vPplUQ1011adLOle3GTZBi7T5Emm/QInIk=;
        b=KNmSO73IqIz/uFt37pYXf1VZsL5O0UJu2NWAy4bjyQy1qOoSLX1HyI+qb2JLHGOiTR
         4+wu16BHIQe2c+MXwZWfILFXrBAO8e3xpiMnqsAr8J1BPeDwr5TlM7QVx6epR6zgIf7G
         1QDz7uHCjkx8SCvzthmlqu3OeVUYSNngeueijHxooiKtcVpBlKuXmV9SdOjvdawLkJCn
         o6O5JmIItJPPc07JZ3T0ArXdvgrR6z6MiNgriPlbbW9gqjJCuC7dz9bySy4iziO1FNTS
         mpQrQ4Cs3gV7nHvJajQUndVxO3Qsyy++U+xg1izmRK3PeuoO/HWo/olO+fRM1aGAM9wR
         jlrw==
X-Gm-Message-State: ABy/qLZQ8w+ShdUyYGq/3jzGRiRL3KTLLjX6UnWsp6pMnLrJM19uBszB
        ZsTpRT9hAs41Z4ZPUgRj8g0tM8D3wH8rb7mbdhk9uQ==
X-Google-Smtp-Source: APBJJlFCs60IYfIke7ip+lzlgj6rKsEJCExfA8nbyBjdWEr2aqsvgey9Fl462Ly/r/Mb35oACz0sHqgwq1Yv0eAnotM=
X-Received: by 2002:ac8:5882:0:b0:3f9:a78f:c527 with SMTP id
 t2-20020ac85882000000b003f9a78fc527mr17762qta.21.1689016428164; Mon, 10 Jul
 2023 12:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <202307101059.86ea1eac-oliver.sang@intel.com>
In-Reply-To: <202307101059.86ea1eac-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 12:13:36 -0700
Message-ID: <CAP-5=fVQc_FioO2QAGrW2B7QMQN8TyD1_Ns=rMNxmGQ9hhPnYQ@mail.gmail.com>
Subject: Re: [linus:master] [perf parse] 70c90e4a6b: perf-test.perf_hw_event_sample_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_instructions_HAS_FIX_NO_NMI_R1.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Samantha Alt <samantha.alt@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Weilin Wang <weilin.wang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and thanks for the report, I'm confused by the output. Specifically:

Direct leak of 17544 byte(s) in 51 object(s) allocated from:
    #0 0x7f49ee50c037 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x556656895a6b in map__new2 util/map.c:226
    #2 0x55665687a6ac in machine__addnew_module_map util/machine.c:1039
    #3 0x556656880bfa in machine__process_kernel_mmap_event util/machine.c:=
1809
    #4 0x556656882eb7 in machine__process_mmap_event util/machine.c:1996
    #5 0x5566567426bd in perf_event__process_mmap util/event.c:370
    #6 0x5566568b3536 in machines__deliver_event util/session.c:1565
    #7 0x5566568b4e16 in perf_session__deliver_event util/session.c:1645
    #8 0x5566568b7ea1 in perf_session__process_event util/session.c:1881
    #9 0x5566568bed4d in process_simple util/session.c:2442
    #10 0x5566568bdd9d in reader__read_event util/session.c:2371
    #11 0x5566568be6dd in reader__process_events util/session.c:2420
    #12 0x5566568bf506 in __perf_session__process_events util/session.c:246=
7
    #13 0x5566568c243e in perf_session__process_events util/session.c:2633
    #14 0x5566563ff7d9 in __cmd_report
/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-70c90e4a6b2fbe775b662eafefae51f=
64d627790/tools/perf/builtin-report.c:989
    #15 0x55665640be73 in cmd_report
/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-70c90e4a6b2fbe775b662eafefae51f=
64d627790/tools/perf/builtin-report.c:1709
    #16 0x5566566e0d7f in run_builtin
/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-70c90e4a6b2fbe775b662eafefae51f=
64d627790/tools/perf/perf.c:323
    #17 0x5566566e1601 in handle_internal_command
/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-70c90e4a6b2fbe775b662eafefae51f=
64d627790/tools/perf/perf.c:377
    #18 0x5566566e1b33 in run_argv
/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-70c90e4a6b2fbe775b662eafefae51f=
64d627790/tools/perf/perf.c:421
    #19 0x5566566e225f in main
/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-70c90e4a6b2fbe775b662eafefae51f=
64d627790/tools/perf/perf.c:537
    #20 0x7f49ed6b3d09 in __libc_start_main
(/lib/x86_64-linux-gnu/libc.so.6+0x23d09)

It shows a map being leaked but without the reference count checker
being enabled, which shouldn't happen given:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/to=
ols/lib/perf/include/internal/rc_check.h#n12

Trying to look further, the blamed line is a closing curly for a function:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/to=
ols/perf/util/machine.c#n1039

As such I'm not sure there is anything actionable here and I suspect
the underlying issues were fixed with the numerous reference count
checker fixes to the perf tool.

Thanks,
Ian

On Sun, Jul 9, 2023 at 8:10=E2=80=AFPM kernel test robot <oliver.sang@intel=
.com> wrote:
>
>
> hi Ian Rogers,
>
> when we reported
> "[linux-next:master] [perf parse]  70c90e4a6b: perf-test.perf_hw_event_sa=
mple_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_=
instructions_HAS_FIX_NO_NMI_R1.fail"
> on
> https://lore.kernel.org/all/202306161546.17ace7b9-oliver.sang@intel.com/
> when this commit is still on linus-next, you mentioned it should be fixed=
 by
> https://lore.kernel.org/r/20230608232823.4027869-20-irogers@google.com
> which we noticed is already on mainline now.
>   "1981da1fe2499 perf machine: Don't leak module maps"
>
> now we noticed the commit is on mainline already, and the issues seem sti=
ll
> exist. we also tested on latest linus/master linux-next/master when this =
bisect
> done, which we confirmed both include 1981da1fe2499. but we found the tes=
ts
> still failed. so we send this report again FYI.
>
>
> Hello,
>
> kernel test robot noticed "perf-test.perf_hw_event_sample_group.group_sam=
pe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_instructions_HAS_FIX=
_NO_NMI_R1.fail" on:
>
> commit: 70c90e4a6b2fbe775b662eafefae51f64d627790 ("perf parse-events: Avo=
id scanning PMUs before parsing")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master 1c7873e3364570ec89343ff4877e0f27a7b21a61]
> [test failed on linux-next/master 123212f53f3e394c1ae69a58c05dfdda56fec8c=
6]
>
> in testcase: perf-test
> version: perf-test-x86_64-git-1_20220520
> with following parameters:
>
>         type: lkp
>         group: group-00
>
> test-description: The internal Perf Test suite.
>
>
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapp=
hire Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307101059.86ea1eac-oliver.san=
g@intel.com
>
>
> besides, we also noticed several other cases will fail on this commit but=
 pass
> on parent:
>
> 442eeb77044705f2 70c90e4a6b2fbe775b662eafefa
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_i=
nstructions_HAS_FIX_NO_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_i=
nstructions_NO_FIX_HAS_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_instructions_k_HAS_FIX_NO_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_instructions_k_NO_FIX_HAS_NMI_R1.fail
>
>
>
> 28 test cases pass for perf_hw_event_sample_group test. 4 test cases fail=
 for perf_hw_event_sample_group test.
> Test Case sampe_cpu-cycles_cache-misses_instructions_NO_FIX_HAS_NMI_R1 PA=
SS!
> Test Case group_sampe_cpu-cycles_cache-misses_NO_FIX_HAS_NMI_R1 PASS!
> Test Case group_sampe_cache-misses_instructions_u_NO_FIX_HAS_NMI_R1 PASS!
> Test Case group_sampe_cpu-cycles_instructions_k_NO_FIX_HAS_NMI_R1 FAILED!=
     <----------
> Test Case group_sampe_cpu-cycles_cache-misses_and_cache-misses_instructio=
ns_NO_FIX_HAS_NMI_R1 PASS!
> Test Case group_sampe_cpu-cycles_cache-misses_instructions_NO_FIX_HAS_NMI=
_R1 PASS!
> Test Case group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses=
_instructions_NO_FIX_HAS_NMI_R1 FAILED!     <----------
> Test Case group_sampe_cpu-cycles_cache-misses_instructions_and_cpu-cycles=
_cache-misses_instructions_NO_FIX_HAS_NMI_R1 PASS!
> Test Case sampe_cpu-cycles_cache-misses_instructions_HAS_FIX_NO_NMI_R1 PA=
SS!
> Test Case group_sampe_cpu-cycles_cache-misses_HAS_FIX_NO_NMI_R1 PASS!
> Test Case group_sampe_cache-misses_instructions_u_HAS_FIX_NO_NMI_R1 PASS!
> Test Case group_sampe_cpu-cycles_instructions_k_HAS_FIX_NO_NMI_R1 FAILED!=
     <----------
> Test Case group_sampe_cpu-cycles_cache-misses_and_cache-misses_instructio=
ns_HAS_FIX_NO_NMI_R1 PASS!
> Test Case group_sampe_cpu-cycles_cache-misses_instructions_HAS_FIX_NO_NMI=
_R1 PASS!
> Test Case group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses=
_instructions_HAS_FIX_NO_NMI_R1 FAILED!     <----------
> Test Case group_sampe_cpu-cycles_cache-misses_instructions_and_cpu-cycles=
_cache-misses_instructions_HAS_FIX_NO_NMI_R1 PASS!
> Test Case sampe_bus-cycles_bus-cycles_branch-misses_NO_FIX_HAS_NMI_R0 PAS=
S!
> Test Case group_sampe_bus-cycles_bus-cycles_NO_FIX_HAS_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_branch-misses_u_NO_FIX_HAS_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_branch-misses_k_NO_FIX_HAS_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_and_bus-cycles_branch-misses_=
NO_FIX_HAS_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_branch-misses_NO_FIX_HAS_NMI_=
R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_and_bus-cycles_bus-cycles_bra=
nch-misses_NO_FIX_HAS_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_branch-misses_and_bus-cycles_=
bus-cycles_branch-misses_NO_FIX_HAS_NMI_R0 PASS!
> Test Case sampe_bus-cycles_bus-cycles_branch-misses_HAS_FIX_NO_NMI_R0 PAS=
S!
> Test Case group_sampe_bus-cycles_bus-cycles_HAS_FIX_NO_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_branch-misses_u_HAS_FIX_NO_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_branch-misses_k_HAS_FIX_NO_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_and_bus-cycles_branch-misses_=
HAS_FIX_NO_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_branch-misses_HAS_FIX_NO_NMI_=
R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_and_bus-cycles_bus-cycles_bra=
nch-misses_HAS_FIX_NO_NMI_R0 PASS!
> Test Case group_sampe_bus-cycles_bus-cycles_branch-misses_and_bus-cycles_=
bus-cycles_branch-misses_HAS_FIX_NO_NMI_R0 PASS!
> perf hardware cache event sample group test
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
