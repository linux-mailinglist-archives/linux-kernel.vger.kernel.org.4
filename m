Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD65728FF5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbjFIGbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjFIGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:31:10 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED95730E7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:30:56 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-43b5882f945so466343137.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686292256; x=1688884256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF5eChhUeOObLndhM05v4v9hcSfyNWa1h0zv+44AyzE=;
        b=NqO8yW//9bm3FInTZ4EaJayDZMF1jaU8XN0Dg/k3Mit4vferLk48BjWFz52etDpluE
         5K2iov5PMH6gk7q4tpLVQlhICTOqub5nPu02N2D+oZFSUA/2j/EoAUyg7blcpLUd7YBv
         NXq0QBL8KJ4QCprVVdC4DbuIL8boEXuAFpyZm68lBpvts82gP6BsaJG7Vo1n7UCx/7Ce
         0gIPYmaHELX9EL7F0oXByIvNp+ZbsgggBmSznrF4/rz4Pn3bIqXS7/k1BfgmwF292Dk1
         CMBWwjyGZmWxH8hxo3HVxj95Gqp7/oLtyfJDoIXs6Wveptu4LbY0vmr5QbG0oARAvRJf
         s5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292256; x=1688884256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF5eChhUeOObLndhM05v4v9hcSfyNWa1h0zv+44AyzE=;
        b=HzFPvdwKtE6Ik+VBpBXpzrfLJ2n/ZPS4J0l0jWpT+cCaxPnt33n/JCWE/SkmGnrjQE
         Y+EVgck6E23bo0qY6TsfWITzaSAqn5aqbKHdxfM1zpx56o4MulnJ4DWp1kx+/zPlFFSk
         hBjReIvp6EEYaOmjcfyGR7FgHQL6fkfK7pF8+cHqtg9Am6R3QrjLbwUxtH8CbaJACxC3
         fQSOdCJy8dHyXr9Urk+MHHnkYC2RgT6+U+jLsBePi+//c+Uybr7XQciGtXiRezb/QxWa
         hBqs/6dlc9KDB1O/8MxPxmyJ0t86QrT2lCKbEobebzF4P/UI/fOH5k/ZcIjQkLYwdvO/
         NLxQ==
X-Gm-Message-State: AC+VfDzPVLy2vMWW9f58vnGzrMgY+7hnm55kq0Oe9i4yU4EZoI5UZsn9
        0p6c6t5z81u7SKzwlH/OfACcZ3mSOYTBrQaG9j1rgpETfxpazjPHikd/Bg==
X-Google-Smtp-Source: ACHHUZ6rYHYr8oALJGUoadjA1z2iLJS5c0TCHVYB3YHFW/89t2JI2/4P9ILn1V+l2c+koFp+ZsmuayT6JCJ8ZbdSS8Y=
X-Received: by 2002:a67:ff88:0:b0:439:3128:587d with SMTP id
 v8-20020a67ff88000000b004393128587dmr290674vsq.28.1686292255923; Thu, 08 Jun
 2023 23:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230608175722.489602717@linuxfoundation.org>
In-Reply-To: <20230608175722.489602717@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Jun 2023 12:00:44 +0530
Message-ID: <CA+G9fYujcU7wYUF3FMPZ-kzrOi=D0_yNj48D+mvN055P=74LQQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/285] 6.3.7-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 at 23:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 10 Jun 2023 17:56:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.3.7-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-6.3.y
* git commit: 6f9b6a83bd08fb6abac41d5a521adec785ea0e68
* git describe: v6.3.5-332-g6f9b6a83bd08
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.5=
-332-g6f9b6a83bd08

## Test Regressions (compared to v6.3.5)

## Metric Regressions (compared to v6.3.5)

## Test Fixes (compared to v6.3.5)

## Metric Fixes (compared to v6.3.5)

## Test result summary
total: 172899, pass: 150726, fail: 3525, skip: 18397, xfail: 251

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 141 total, 140 passed, 1 failed
* arm64: 50 total, 50 passed, 0 failed
* i386: 37 total, 36 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 42 total, 42 passed, 0 failed

## Test suites summary
* boot
* fwts
* igt-gpu-tools
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
* kselftest-mincore
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
