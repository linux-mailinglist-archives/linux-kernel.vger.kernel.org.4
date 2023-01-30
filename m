Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B466803D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjA3CZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjA3CZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:25:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18F01D900;
        Sun, 29 Jan 2023 18:25:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b3so17023253lfv.2;
        Sun, 29 Jan 2023 18:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBuiJBVm2tNm0T5Xjj3NOb3iR5h5QCN0pN0vFZkrcBc=;
        b=iLEAeHz90s4RrfB9u0qjxHhTom4GpA1Rb46JcmZP77Gq9y6Utj1bTHmgNdDJS6VB73
         qyf6bVvf2j/okvngGYVW3WYPiWfpZqzEh9UxE9qQYXBpog+SmxpD0AQNojvO0ty4X2Fq
         5kXakLaU0OMHObhvTgziH1jsbssG101RSiKJE1QulvObcZtNN/vfboyUp0lLK4PrL8E+
         XgWYwPLuY4lyNi3LCfYgAXB4zQ+ydbW1wolbYCEmEVykimgOW/Y8qzLFXq9poxtVtZY7
         6e2Vpobh8cMWJr630dSL2gojqNPTifJEER5c/tKSGWogGwrrExbaPkxkAjN2E50QEBlX
         3TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBuiJBVm2tNm0T5Xjj3NOb3iR5h5QCN0pN0vFZkrcBc=;
        b=aegdyqAPfYb3h+B+hvR3CT5y8t72r+1g/CnYnm6xXBl0vQIXKjLOcXxeNCxFOovUlV
         39P/TSpYydPEoj/9U/OM4Lj6WJcr3Wvm8rEl23S6LhMmmLsI9LOjMQBACe5fSkBJuLaN
         1C/CJfCbPaJ617ihEwNtsP5It9mEM7a87KCF/fmjohFBUHelZZYj2I9TnElmL0fTZr/T
         5QNgYRBm4KbXrpXu3+EL1JyDyJHGyKrsN50pSgwjYONPlZLM+9uKmUuPKOyxob27rnqU
         vX2ONR9HYgbaqWzahWiM8aoMLOks7TkPKIoBFrCCoIcwYNjwDt3JfKCPwQtCkYP7eGRx
         X8VA==
X-Gm-Message-State: AFqh2krCe0DyntQJrSVcbfZQiIU7ePIfUktP821HJiU/SbBUeTQcx835
        m7Pg0mvPGQIYaYR+ti+UgN0FTiYFKzHowPg70hA=
X-Google-Smtp-Source: AMrXdXt4gybyDRlvFlysn8lG7/slFK+PNcqRWxMlse6IWC/t668XMPgiODUqdnMZvaBPWektkErybg8DHl9YL9UERWg=
X-Received: by 2002:a19:6901:0:b0:4d5:af91:f3e9 with SMTP id
 e1-20020a196901000000b004d5af91f3e9mr2241585lfc.269.1675045518709; Sun, 29
 Jan 2023 18:25:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
 <CAP-5=fULKkEYXOVV5tXd8J0occGJwgV+BiJLkA=exW=bfgyEBw@mail.gmail.com>
In-Reply-To: <CAP-5=fULKkEYXOVV5tXd8J0occGJwgV+BiJLkA=exW=bfgyEBw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 30 Jan 2023 03:24:41 +0100
Message-ID: <CA+icZUUOZoLOFiBcYkccWPSusk9G_Rhf3DOZYWat-K+VfWFHQw@mail.gmail.com>
Subject: Re: [6.1.7][6.2-rc5] perf all metrics test: FAILED!
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        llvm@lists.linux.dev, Ben Hutchings <benh@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

?

On Mon, Jan 30, 2023 at 12:21 AM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Jan 29, 2023 at 1:59 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > [ CC LLVM linux folks + Ben from Debian kernel team ]
> >
> > Hi,
> >
> > I am playing with LLVM version 16.0.0-rc1 which was released yesterday and PERF.
> >
> > After building my selfmade LLVM toolchain, I built perf and run some
> > perf tests here on my Intel SandyBridge CPU (details see below).
> >
> > perf all metrics test: FAILED!
> >
> > ...with both Debian's perf version 6.1.7 and my selfmade version 6.2-rc5.
> >
> > Just noticed:
> >
> > Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> > BPF maps, etc
> >
> > Run the below tests with `sudo` - made this go away - still FAILED.
> >
> > But maybe I am missing to activate some sysfs/debug or whatever other stuff?
>
> Hi Sedat,
>
> things have been improving wrt metrics and so this failure may have
> just been because of the addition of a previously missing metric. The
> rlimit thing shouldn't affect things but maybe file descriptors?
> Looking at the test output the issue is:
>
> ```
> Metric 'tma_dram_bound' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 207.680 usec (+- 0.176 usec)
>   Average num. events: 30.000 (+- 0.000)
>   Average time per event 6.923 usec
>   Average data synthesis took: 217.833 usec (+- 0.202 usec)
>   Average num. events: 161.000 (+- 0.000)
>   Average time per event 1.353 usec
>
>  Performance counter stats for 'perf bench internals synthesize':
>
>      <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
>                          (0,00%)
>      <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
>                          (0,00%)
>      <not counted>      CPU_CLK_UNHALTED.THREAD
>                          (0,00%)
>      <not counted>      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
>                             (0,00%)
> ```
>
> So the test was checking to see whether the tma_dram_bound metric
> could be computed on your Sandybridge and it failed. The event counts
> below show that every event came back "<not counted>" which is usually
> indicative of a permissions problem - it is also not surprising given
> this that the metric wasn't computed. You could try repeating the
> command the test is trying with something like "perf stat -M
> tma_dram_bound -a sleep 1", but running as root should have resolved
> that issue. Does that give you enough to keep exploring?
>

Hi Ian,

Thanks for your feedback!

I booted into my Debian kernel - just to see what happens.

# cat /proc/version
Linux version 6.1.0-2-amd64 (debian-kernel@lists.debian.org) (gcc-12
(Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1
SMP PREEMPT_DYNAMIC Debian 6.1.7-1 (2023-01-18)

All things run as root...

# echo 0 | tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid
0

# /usr/bin/perf test 10 92 98 99 100 101
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Ok
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
92: perf record tests                                               : Ok
98: perf stat tests                                                 : Ok
99: perf all metricgroups test                                      : Ok
100: perf all metrics test                                           : FAILED!
101: perf all PMU test                                               : Ok

# perf stat -M tma_dram_bound -a sleep 1

Performance counter stats for 'system wide':

    <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
                  (0,00%)
    <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
                     (0,00%)
    <not counted>      CPU_CLK_UNHALTED.THREAD
              (0,00%)
    <not counted>      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
                        (0,00%)

      1,002148600 seconds time elapsed

Hmm... looking at... Metric 'tma_l3_bound' ...

Running...

# perf stat --verbose -M tma_l3_bound -a sleep 1
Using CPUID GenuineIntel-6-2A-7
metric expr (MEM_LOAD_UOPS_RETIRED.LLC_HIT /
(MEM_LOAD_UOPS_RETIRED.LLC_HIT + 7 *
MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS)) *
CYCLE_ACTIVITY.STALLS_L2_PENDING / CLKS for tma_l3_bound
metric expr CPU_CLK_UNHALTED.THREAD for CLKS

found event MEM_LOAD_UOPS_RETIRED.LLC_HIT
found event CYCLE_ACTIVITY.STALLS_L2_PENDING
found event CPU_CLK_UNHALTED.THREAD
found event MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS

Parsing metric events
'{MEM_LOAD_UOPS_RETIRED.LLC_HIT/metric-id=MEM_LOAD_UOPS_RETIRED.LLC_HIT/,CYCLE_ACTIVITY.STALLS_L2_PENDING/metric-id=CYCLE_ACTIVITY.STALLS_L2_PEND
ING/,CPU_CLK_UNHALTED.THREAD/metric-id=CPU_CLK_UNHALTED.THREAD/,MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS/metric-id=MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS/}:W'
MEM_LOAD_UOPS_RETIRED.LLC_HIT -> cpu/event=0xd1,period=0xc365,umask=0x4/
CYCLE_ACTIVITY.STALLS_L2_PENDING ->
cpu/event=0xa3,cmask=0x5,period=0x1e8483,umask=0x5/
CPU_CLK_UNHALTED.THREAD -> cpu/event=0x3c,period=0x1e8483/
MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS -> cpu/event=0xd4,period=0x186a7,umask=0x2/

Control descriptor is not initialized

MEM_LOAD_UOPS_RETIRED.LLC_HIT: 0 4007421228 0
CYCLE_ACTIVITY.STALLS_L2_PENDING: 0 4007421228 0
CPU_CLK_UNHALTED.THREAD: 0 4007421228 0
MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS: 0 4007421228 0

Performance counter stats for 'system wide':

    <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
                  (0,00%)
    <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
                     (0,00%)
    <not counted>      CPU_CLK_UNHALTED.THREAD
              (0,00%)
    <not counted>      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
                        (0,00%)

      1,002310013 seconds time elapsed

So those events/metric-ids resulting in "<not counted>" are all found.

What means "Control descriptor is not initialized"?

To summarize:

Those two tests in "100: perf all metrics test" FAILED:

1. tma_dram_bound
2. tma_l3_bound

Best regards,
-Sedat-

> Thanks,
> Ian
>
> > Last perf version which was OK:
> >
> > ~/bin/perf -v
> > perf version 6.0.0
> >
> > echo "linux-perf: Adjust limited access to performance monitoring and
> > observability operations"
> > echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
> > /proc/sys/kernel/perf_event_paranoid
> > 0
> >
> > ~/bin/perf test 10 86 92 93 94 95
> > 10: PMU events                                                      :
> > 10.1: PMU event table sanity                                        : Ok
> > 10.2: PMU event map aliases                                         : Ok
> > 10.3: Parsing of PMU event table metrics                            : Ok
> > 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> > 86: perf record tests                                               : Ok
> > 92: perf stat tests                                                 : Ok
> > 93: perf all metricgroups test                                      : Ok
> > 94: perf all metrics test                                           : Ok
> > 95: perf all PMU test                                               : Ok
> >
> > echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
> > /proc/sys/kernel/perf_event_paranoid
> > echo "linux-perf: Reset limited access to performance monitoring and
> > observability operations"
> >
> > If you need further information, please let me know.
> >
> > Thanks.
> >
> > Regards,
> > -Sedat-
> >
> > P.S. Instructions
> >
> > [ REPRODUCER ]
> >
> > LLVM_MVER="16"
> >
> > # Debian LLVM
> > ##LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
> > # Selfmade LLVM
> > LLVM_TOOLCHAIN_PATH="/opt/llvm/bin"
> > if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
> >    export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
> > fi
> >
> > PYTHON_VER="3.11"
> > MAKE="make"
> > MAKE_OPTS="V=1 -j1 HOSTCC=clang-$LLVM_MVER HOSTLD=ld.lld
> > HOSTAR=llvm-ar CC=clang-$LLVM_MVER LD=ld.lld AR=llvm-ar
> > STRIP=llvm-strip"
> >
> > echo "LLVM MVER ........ $LLVM_MVER"
> > echo "Path settings .... $PATH"
> > echo "Python version ... $PYTHON_VER"
> > echo "make line ........ $MAKE $MAKE_OPTS"
> >
> > LANG=C LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
> >
> > LANG=C LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
> > PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
> > ../make-log_perf-install_bin_python${PYTHON_VER}_llvm${LLVM_MVER}.txt
> >
> >
> > [ TESTS ]
> >
> > [ TESTS - START ]
> >
> > echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
> > /proc/sys/kernel/perf_event_paranoid
> >
> > [ TESTS - DEBIAN ]
> >
> > /usr/bin/perf -v
> > perf version 6.1.7
> >
> > /usr/bin/perf test 10 92 98 99 100 101
> >
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : Ok
> >  10.2: PMU event map aliases                                         : Ok
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >  92: perf record tests                                               : Ok
> >  98: perf stat tests                                                 : Ok
> >  99: perf all metricgroups test                                      : Ok
> > 100: perf all metrics test                                           : FAILED!
> > 101: perf all PMU test                                               : Ok
> >
> > [ TESTS - DILEKS ]
> >
> > ~/bin/perf -v
> > perf version 6.2.0-rc5
> >
> > ~/bin/perf test 7 87 93 94 95 96
> >
> >   7: PMU events                                                      :
> >   7.1: PMU event table sanity                                        : Ok
> >   7.2: PMU event map aliases                                         : Ok
> >   7.3: Parsing of PMU event table metrics                            : Ok
> >   7.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >  87: perf record tests                                               : Ok
> >  93: perf stat tests                                                 : Ok
> >  94: perf all metricgroups test                                      : Ok
> >  95: perf all metrics test                                           : FAILED!
> >  96: perf all PMU test                                               : Ok
> >
> > [ TESTS - FAILED ]
> >
> > /usr/bin/perf test --verbose 100 2>&1 | tee
> > perf-test-verbose-100-perf-all-metrics-test_debian-perf-6-1-7.txt
> >
> > ~/bin/perf test --verbose 95 2>&1 | tee
> > perf-test-verbose-95-perf-all-metrics-test_dileks-perf-6-2-rc5.txt
> >
> > [ TESTS - STOP ]
> >
> > echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
> > /proc/sys/kernel/perf_event_paranoid
> >
> > - EOT -
