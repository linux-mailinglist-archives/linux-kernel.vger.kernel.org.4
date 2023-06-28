Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC73740B72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjF1I2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjF1IZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:53 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE0359F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:16:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-635ee3baa14so12420786d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687940187; x=1690532187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBsZLVTgJrT+03UCUP7W/SIjStfAyEMLyISpbv+xmm8=;
        b=m98RFeaaOnxrYBM0OFPEej8BMRQYeFNWVlEr/7XoZpYuG8QsOD1Mz6IYo/lmtC3BQc
         I+KAamdhaUpfLlRr+OVApe+wOvo2mglrhMZD2F+U8YjaWnHA5Q22qJWdi1dkRSitOybp
         HRgylMS9ddO+MWKzbYg1S5ZnxVKUlht440MZwrzhLd9eh9ViYQDDsd6KwZ4NCYadnpGU
         SSRK178FQsAFe53HKSGQpBLG3/m+tsenrVjEtzLgKkovr/R6erg8jsTvjQOlfcaD0pnv
         /oRuD1q5vIxVgnuQ8SINg238Pc1ePXubvX930kWWygzfxRSzvB9xvZ9+EOfSPgOI+56o
         eTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940187; x=1690532187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBsZLVTgJrT+03UCUP7W/SIjStfAyEMLyISpbv+xmm8=;
        b=dYwCy5r06Np2n+oGhbIMWZjH/fuqvg4FieYP6dUBlEKGFN8ctw7Sak443JKOTsME1i
         22yVWkH0Odi7kB4CSkJ1r9AsMeVVfeoc7cFnYeEys3a3wnN1SI3gMm+R/rgEKvf8M08E
         RPI5RQRZ1Y5jFtmGB2QDJmkPxiIf6fgcCyZVByZ8nHYIJpL0Ma5OZWZQWRqsKJ9zYaN3
         rWHnvWMdkiHl7jF3uxSBnEULYPtAM0/+Y3CmiaOylD7VkK/ftxvBL4EITpWIADAxE9a3
         JOkkgpZfVD81gq4Q8j7d2ynBRDaogSC56unMoVV8Hu7tqmwWz+m5uWq87RxJM2AWUvBp
         YMGg==
X-Gm-Message-State: AC+VfDwrW0q8dWwx64ZikBHqWpImy3lzrcWD818gdUy1Fy5jVoCCa2rc
        RwLw0i7yAN4ikhpGAWV7o+BH5F+XMjTstHHq27ADcy3UqScGrNZLa9bPGw==
X-Google-Smtp-Source: ACHHUZ66FiA8xyxebfpqH1Qrde7H4jIWrD3BH5kC6/BYy+JjAxjAd0yItqgheFmJGhyMczqDz+DfrCQyD/3ICxiw6Yk=
X-Received: by 2002:a67:efd7:0:b0:443:62c2:7f4f with SMTP id
 s23-20020a67efd7000000b0044362c27f4fmr2989394vsp.32.1687934151245; Tue, 27
 Jun 2023 23:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180800.476539630@linuxfoundation.org>
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:05:24 +0530
Message-ID: <CA+G9fYs=AMHqGPMG2wa4wi8o6QmBqYEFABS8B-SDdf_7Ekzw3Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/170] 6.1.36-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 23:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.36 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.36-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 8c805fb9757e69c239188ee683605520ff73b913
* git describe: v6.1.35-171-g8c805fb9757e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
5-171-g8c805fb9757e

## Test Regressions (compared to v6.1.35)

## Metric Regressions (compared to v6.1.35)

## Test Fixes (compared to v6.1.35)

## Metric Fixes (compared to v6.1.35)


## Test result summary
total: 166130, pass: 132599, fail: 3459, skip: 29913, xfail: 159

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
