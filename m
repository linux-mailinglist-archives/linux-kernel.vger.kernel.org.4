Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A3714E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjE2Q2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjE2Q2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:28:43 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FAD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:28:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso299481cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685377717; x=1687969717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyZCj96iRF2jvhBEHv5YWxHz5llZW0keAn3B6U6pHG8=;
        b=LXu7PHtOEjdQvmHjgAJQk2uWKbMEVo45NVLDdp1usGse4wFa6F2dChK67MuF6RrHVf
         gK/I66s5dy1tabHwR9NRHA2SZXaxGnv6kRqUPlwBQbhvrOchDLfxVPfrZv7T3StVoEN0
         cHFIwPBL3uqpendrz0cCIdpHdaTuxh83oVw9Nc77PKVUtxqEKKE3zhtas7kfZeY5efiQ
         ne7lcAs9MIT//V6VsXW8IQHLQYbouI+HPAKWah92SrEIxx3HWAHmPJOjDczuH76MSvVa
         1d7PMMIKd1aREI3fAilZsNBRTWMupgShBJaeooXPtReFUG5AR6qgx6yAdcKKrLYWkZN5
         6DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685377717; x=1687969717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyZCj96iRF2jvhBEHv5YWxHz5llZW0keAn3B6U6pHG8=;
        b=K1/rB5yyO/cMaQFamP5siwCd5VAE3tsdHJIhjVx18v/qDSZEoXUT6BVxXn70QvtISH
         bBGkmhg2d+yYVB0TtKcbu5wI6eVZw+GhA4+lb4u3aYfAUTzmU8illkmetGXTuPlKAeJY
         5tG2oIGaF/BFwOIWLzH065cXB28tLguMuc5+WVBxdC/5lM6uBs2M3Nl7KHwUi0hCTa1s
         5QCFZvd3EJ6GsO+cbDS08ETkiovjjPGnNqnqIhGUyPOrS+VtW4h2QuvscF4YYV2boDTP
         GwBkwTLGccGIQ9/pXu5SnyPHrSC32StZmbuBctif2bxeWpaqnalQrogc5feV81oKQSIG
         slpQ==
X-Gm-Message-State: AC+VfDz+6lJKzveLE483YW5wUbVYDQ3EJUZPBnPk1+btLwT8A71rRQsR
        F/gzPoVzwSTUFyhwVGpXci08dPlpT5vrFbVCNbJDHg==
X-Google-Smtp-Source: ACHHUZ7tNHeP+NRFPg8fNZtB39JwiTCATOyCnNlEnkEUjwVdhUB9OZhZ4wCiS7rYAJmb89kZZY+NbC48TvRQfGK+GhM=
X-Received: by 2002:a05:622a:2d4:b0:3f7:ffc8:2f6f with SMTP id
 a20-20020a05622a02d400b003f7ffc82f6fmr403990qtx.28.1685377716957; Mon, 29 May
 2023 09:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <202305291525.df3ce28d-oliver.sang@intel.com>
In-Reply-To: <202305291525.df3ce28d-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 May 2023 09:28:25 -0700
Message-ID: <CAP-5=fVjdEUnujbndX4eMqT2Hpuz3QUB6bW0MjcFt+Os-6ux9g@mail.gmail.com>
Subject: Re: [linus:master] [perf parse] a4c7d7c502: perf-test.perf_pmu_event_count_group.count_group_cpu/branch-misses/_cpu/topdown-heavy-ops/_cpu/branch-misses/_R0.fail
To:     kernel test robot <oliver.sang@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Stephane Eranian <eranian@google.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:30=E2=80=AFAM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "perf-test.perf_pmu_event_count_group.count_gro=
up_cpu/branch-misses/_cpu/topdown-heavy-ops/_cpu/branch-misses/_R0.fail" on=
:
>
> commit: a4c7d7c502b935f3a8324d954de78aecf6940897 ("perf parse-events: War=
n when events are regrouped")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I'm having a hard time understanding the output from the test:

1) the output is filled with sanitizer output that makes it look like
a non-asan version of libc is being used, either that or we're missing
asan interceptors for functions called by perf. This means the noise
is much greater than the signal in the output.

2) the referenced test doesn't appear to be part of the "perf test"
set of tests. Are these additional tests that Intel have created?
Could we get them moved to "perf test" which is used as a pre-submit
and can help avoid regressions.

Why a warning would cause this test to start failing I'm not sure.
Given the amount of difficulty the harness has with asan I think
there's a good chance this is a false positive. It could also be that
the test expectations have changed and could have been fixed, which
would break external tests that make assumptions on things like
events. Moving the test to "perf test" would be the best way to
resolve this.

Thanks,
Ian

> [test failed on linux-next/master 6a3d37b4d885129561e1cef361216f00472f7d2=
e]
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
> compiler: gcc-11
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapp=
hire Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202305291525.df3ce28d-oliver.san=
g@intel.com
>
>
>
> perf kernel cpu PMU event count group test
> Sun May 28 06:51:04 UTC 2023
> 1 test cases pass for perf_pmu_event_count_group test. 1 test cases fail =
for perf_pmu_event_count_group test.
> Test Case count_group_cpu/topdown-fetch-lat/_cpu/mem-loads-aux/_cpu/branc=
h-instructions/_R1 PASS!
> Test Case count_group_cpu/branch-misses/_cpu/topdown-heavy-ops/_cpu/branc=
h-misses/_R0 FAILED!
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
