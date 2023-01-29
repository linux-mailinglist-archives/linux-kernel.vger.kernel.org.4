Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAD6802EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjA2XVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjA2XVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:21:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F3B1ADC0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 15:21:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o18so83424wrj.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 15:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OlYExLmij+YlfdSJkSV26C1wi634B/cTlM0CDNG/aUs=;
        b=LAIBiPES1XsrOv2JitoA/JptV9N8SnVd0v1B+q+/pRTiWQXdZjxvz4xK9d+gJTS3xS
         IY6qOboLgPCmRD8+/NPl3I2ZSKzm9Fp0M35XiHiePp+fViUJzbrQfy888dvVwE/re3cJ
         z+UvKae6SkcU0re6wq6FVtKgI6czWhFagL4W4DVlBi7FpledEG71JJHSSGjPBiWndtav
         +zjwYiEct69Jw3WrEaD7/MQfUmCV42P1kh7+/nj5tikMzSBhEmFn5iixyCSq+61o4X2H
         CCB8NxBKN0bv1UNiYiDuNyxsWTz+hygwj5jyNkhra1oLAfXfHkMYRW0a9zeO7zVtNwlI
         tM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlYExLmij+YlfdSJkSV26C1wi634B/cTlM0CDNG/aUs=;
        b=QLZuNN8ovtteHI5qxor9UdatncVYZXQ3sgnKEApfYyFtBjZ0a/r3WPnfE8qHT4jCYq
         vS1YPPLKrY+qeDbwcOYeCeu8X+RdFrVwxLGnNbSeL+rrssvCYP45983b9NwpdE1mdmUc
         LcRgXRSUezWnf3X6bjuQncPU5ABaIRgzEASRJpc1WmcWMgFVAI01IKjzxsf3srIYZAtp
         lLyAN8soYugfA+Vc8/CY2+2aEnwUVxVUzOJOSL968mNSlq4XqU7Q3HCUhH1QRmESa8Gh
         2kdxbh+Mk4a3dHF/AuAD69f4oGrsQTjfyulnN4GAaH2M/5MsG6yLHtydWVFqZ2HGlVJl
         FTyA==
X-Gm-Message-State: AO0yUKXcxAwxqcPAYIK5rW7C2Y4G+jsnkUKdTHzzJqu1XouceG/8p8xc
        w5pjue48880HX9sX79oV7Sb6fYy4fCKj0mMGJ9hIAQ==
X-Google-Smtp-Source: AK7set+lRjLGXFDbALYS1psgg3KJRulUIMMBybGx4aU6G/ZrCvVgbCJGW2O9b8nz5575wmvZ0V+9m0cPFH5f/aZQEyI=
X-Received: by 2002:a5d:55d1:0:b0:2bf:c5eb:e303 with SMTP id
 i17-20020a5d55d1000000b002bfc5ebe303mr502098wrw.40.1675034504458; Sun, 29 Jan
 2023 15:21:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
In-Reply-To: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 29 Jan 2023 15:21:29 -0800
Message-ID: <CAP-5=fULKkEYXOVV5tXd8J0occGJwgV+BiJLkA=exW=bfgyEBw@mail.gmail.com>
Subject: Re: [6.1.7][6.2-rc5] perf all metrics test: FAILED!
To:     sedat.dilek@gmail.com
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 1:59 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> [ CC LLVM linux folks + Ben from Debian kernel team ]
>
> Hi,
>
> I am playing with LLVM version 16.0.0-rc1 which was released yesterday and PERF.
>
> After building my selfmade LLVM toolchain, I built perf and run some
> perf tests here on my Intel SandyBridge CPU (details see below).
>
> perf all metrics test: FAILED!
>
> ...with both Debian's perf version 6.1.7 and my selfmade version 6.2-rc5.
>
> Just noticed:
>
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> BPF maps, etc
>
> Run the below tests with `sudo` - made this go away - still FAILED.
>
> But maybe I am missing to activate some sysfs/debug or whatever other stuff?

Hi Sedat,

things have been improving wrt metrics and so this failure may have
just been because of the addition of a previously missing metric. The
rlimit thing shouldn't affect things but maybe file descriptors?
Looking at the test output the issue is:

```
Metric 'tma_dram_bound' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 207.680 usec (+- 0.176 usec)
  Average num. events: 30.000 (+- 0.000)
  Average time per event 6.923 usec
  Average data synthesis took: 217.833 usec (+- 0.202 usec)
  Average num. events: 161.000 (+- 0.000)
  Average time per event 1.353 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      MEM_LOAD_UOPS_RETIRED.LLC_HIT
                         (0,00%)
     <not counted>      CYCLE_ACTIVITY.STALLS_L2_PENDING
                         (0,00%)
     <not counted>      CPU_CLK_UNHALTED.THREAD
                         (0,00%)
     <not counted>      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
                            (0,00%)
```

So the test was checking to see whether the tma_dram_bound metric
could be computed on your Sandybridge and it failed. The event counts
below show that every event came back "<not counted>" which is usually
indicative of a permissions problem - it is also not surprising given
this that the metric wasn't computed. You could try repeating the
command the test is trying with something like "perf stat -M
tma_dram_bound -a sleep 1", but running as root should have resolved
that issue. Does that give you enough to keep exploring?

Thanks,
Ian

> Last perf version which was OK:
>
> ~/bin/perf -v
> perf version 6.0.0
>
> echo "linux-perf: Adjust limited access to performance monitoring and
> observability operations"
> echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
> /proc/sys/kernel/perf_event_paranoid
> 0
>
> ~/bin/perf test 10 86 92 93 94 95
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Ok
> 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> 86: perf record tests                                               : Ok
> 92: perf stat tests                                                 : Ok
> 93: perf all metricgroups test                                      : Ok
> 94: perf all metrics test                                           : Ok
> 95: perf all PMU test                                               : Ok
>
> echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
> /proc/sys/kernel/perf_event_paranoid
> echo "linux-perf: Reset limited access to performance monitoring and
> observability operations"
>
> If you need further information, please let me know.
>
> Thanks.
>
> Regards,
> -Sedat-
>
> P.S. Instructions
>
> [ REPRODUCER ]
>
> LLVM_MVER="16"
>
> # Debian LLVM
> ##LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
> # Selfmade LLVM
> LLVM_TOOLCHAIN_PATH="/opt/llvm/bin"
> if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
>    export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
> fi
>
> PYTHON_VER="3.11"
> MAKE="make"
> MAKE_OPTS="V=1 -j1 HOSTCC=clang-$LLVM_MVER HOSTLD=ld.lld
> HOSTAR=llvm-ar CC=clang-$LLVM_MVER LD=ld.lld AR=llvm-ar
> STRIP=llvm-strip"
>
> echo "LLVM MVER ........ $LLVM_MVER"
> echo "Path settings .... $PATH"
> echo "Python version ... $PYTHON_VER"
> echo "make line ........ $MAKE $MAKE_OPTS"
>
> LANG=C LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
>
> LANG=C LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
> PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
> ../make-log_perf-install_bin_python${PYTHON_VER}_llvm${LLVM_MVER}.txt
>
>
> [ TESTS ]
>
> [ TESTS - START ]
>
> echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
> /proc/sys/kernel/perf_event_paranoid
>
> [ TESTS - DEBIAN ]
>
> /usr/bin/perf -v
> perf version 6.1.7
>
> /usr/bin/perf test 10 92 98 99 100 101
>
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  92: perf record tests                                               : Ok
>  98: perf stat tests                                                 : Ok
>  99: perf all metricgroups test                                      : Ok
> 100: perf all metrics test                                           : FAILED!
> 101: perf all PMU test                                               : Ok
>
> [ TESTS - DILEKS ]
>
> ~/bin/perf -v
> perf version 6.2.0-rc5
>
> ~/bin/perf test 7 87 93 94 95 96
>
>   7: PMU events                                                      :
>   7.1: PMU event table sanity                                        : Ok
>   7.2: PMU event map aliases                                         : Ok
>   7.3: Parsing of PMU event table metrics                            : Ok
>   7.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  87: perf record tests                                               : Ok
>  93: perf stat tests                                                 : Ok
>  94: perf all metricgroups test                                      : Ok
>  95: perf all metrics test                                           : FAILED!
>  96: perf all PMU test                                               : Ok
>
> [ TESTS - FAILED ]
>
> /usr/bin/perf test --verbose 100 2>&1 | tee
> perf-test-verbose-100-perf-all-metrics-test_debian-perf-6-1-7.txt
>
> ~/bin/perf test --verbose 95 2>&1 | tee
> perf-test-verbose-95-perf-all-metrics-test_dileks-perf-6-2-rc5.txt
>
> [ TESTS - STOP ]
>
> echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
> /proc/sys/kernel/perf_event_paranoid
>
> - EOT -
